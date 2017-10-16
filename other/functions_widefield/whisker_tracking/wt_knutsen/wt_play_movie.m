function wt_play_movie( varargin )
% WT_PLAY_MOVIE
% Play movie, optionally save movie to disk.
% Takes an optional argument, which can be the string:
%   'save'  Save animated movie to disk as AVI file

global g_tWT

nStep = g_tWT.MovieInfo.ScreenRefresh;
clear mex

if nargin == 1, sOption = varargin{1};
else, sOption = []; end

% Determine frames to play
nFirstFrame = round(get(g_tWT.Handles.hSlider, 'Value'));
if isempty(g_tWT.MovieInfo.EyeNoseAxLen) % no head movements
    vFrames = nFirstFrame:nStep:g_tWT.MovieInfo.NumFrames;
else    % with head movements
    vHeadFrames = find(~isnan(g_tWT.MovieInfo.Nose(:,1)));
    nFirstFrame = max([vHeadFrames(1) nFirstFrame]);
    vFrames = nFirstFrame:nStep:vHeadFrames(end);
end

% If head movements have been tracked, ask if movie should be played in
% head-centered or video coordinates
if ~isempty(g_tWT.MovieInfo.EyeNoseAxLen)
    sCoordinates = questdlg('Do you want the movie to played in head-centered coordinates (faster) or world coordinates (slower)?', 'Select coordinate system', 'Head-centered', 'World', 'Cancel', 'Head-centered');
    switch sCoordinates
        case 'Head-centered'
            g_tWT.DisplayMode = 1;
            set(findobj('Label', 'Toggle viewing mode'), 'checked', 'on');
        case 'World'
            g_tWT.DisplayMode = 0;
            set(findobj('Label', 'Toggle viewing mode'), 'checked', 'off');
        case 'Cancel', return;
    end
end

% Use blank frame if 'Hide Image' was selected
if g_tWT.HideImage
    vX = get(g_tWT.FrameAx,'Xlim');
    vY = get(g_tWT.FrameAx,'Ylim');
    mImgZeros = zeros(vY(2), vX(2));
else, mImgZeros = []; end

% Prepare for saving
sLastFrame = {'-1'};
if strcmp(sOption, 'save')
    % Output destination
    [sFilename, sFilepath] = uiputfile('*.avi', 'Save movie as');
    if ~sFilename, return; end

    % Compressor
    sCompressor = questdlg('Select video compression method', 'Select compressor', 'None','Indeo5', 'Cinepak', 'None');

    % Create AVI stream
    tMov = avifile([sFilepath sFilename], ...
        'Compression', sCompressor, ...
        'Fps', 100, ...
        'Quality', 70 );

    % Ask for end frame
    while ~(str2num(sLastFrame{1}) > nFirstFrame)
        sLastFrame = inputdlg('Last frame (must be higher than current frame)', 'Last frame');
        if isempty(sLastFrame), return, end
    end
    if isempty(sLastFrame), return, end
    nLastFrame = str2num(char(sLastFrame));
    vFrames = vFrames(1):min([nLastFrame vFrames(end)]);
    sAnsTraces = questdlg('Do you want to create a movie that includes traces of whisker angle and curvature? Note that as the movie is created, MATLAB will cycle between two windows causing a lot of flicker. This is OK. Dont close or move any windows (including non-MATLAB windows) as the movie is being generated.', 'WT', 'Yes', 'No', 'Yes');
end

if g_tWT.MovieInfo.EyeNoseAxLen, bHeadIsTracked = 1;
else, bHeadIsTracked = 0; end

if bHeadIsTracked
    sAnsBackG = questdlg('Do you want to subtract background?', 'WT', 'Yes', 'No', 'No');
    if ~g_tWT.DisplayMode
        sAnsHead = questdlg('Do you want to remove head markers?', 'WT', 'Yes', 'No', 'No');
    else, sAnsHead = 'Yes'; end
else
    sAnsBackG = 'No';
    sAnsHead = 'Yes';
end

i = 1;
g_tWT.StopProc = 0;
r = 1;

if strcmp(sOption, 'save')
    wt_set_status('Saving frames. Do not close window. Click || button to abort.')
    
    % Prepare new figure window that contains trace+frame
    if strcmp(sAnsTraces, 'Yes')
        hNewFig = figure('color', 'w');
        vPos = get(hNewFig, 'position');
        set(hNewFig, 'position', [vPos(1:2) 600 450])

        % Movie panel
        hMovPan = uipanel('BorderType', 'none',...
            'Units', 'normalized', ...
            'Position', [0 .3 1 .7], ...
            'Parent', hNewFig, ...
            'backgroundColor', 'w' );
        hAngAx = axes('position', [.07 .07 .9 .23], 'fontsize', 7);
        hLine = plot(hAngAx,0,0);
        colormap gray
    end
end

for r = 1:g_tWT.MovieInfo.NoFramesToLoad:length(vFrames)
    nEnd = min([length(vFrames) r+g_tWT.MovieInfo.NoFramesToLoad]);
    vLoadFrames = vFrames(r:nEnd);
    wt_set_status(['Loading next set of ' num2str(g_tWT.MovieInfo.NoFramesToLoad) ' frames...'])
    mFrames = wt_load_avi(g_tWT.MovieInfo.Filename, vLoadFrames);
    wt_set_status('')

    wt_set_status(['Press spacebar to stop'])
    for f = 1:length(vLoadFrames)
        if g_tWT.StopProc, break, end

        mImg = wt_image_preprocess(mFrames(:,:,f)); % rotate, crop etc
        
        if strcmp(sAnsBackG, 'Yes') % subtract background
            mImg = wt_subtract_bg_frame(mFrames(:,:,f), vLoadFrames(f));
        end
        
        % Pre-process frame if there is head-movements data
        if bHeadIsTracked & g_tWT.DisplayMode
            mImg = wt_crop_behaving_video(mImg, ...
                [g_tWT.MovieInfo.RightEye(vLoadFrames(f),:); g_tWT.MovieInfo.LeftEye(vLoadFrames(f),:); g_tWT.MovieInfo.Nose(vLoadFrames(f),:)] , ...
                g_tWT.MovieInfo.HorExt, g_tWT.MovieInfo.RadExt, 'nearest');
            mImg = cat(2, mImg{1}, mImg{2});
        end
        
        % Display frame
        if ~isempty(mImgZeros)  % show blank background
            wt_display_frame(vLoadFrames(f), mImgZeros);
        elseif ~bHeadIsTracked  % show image without head movements
            wt_display_frame(vLoadFrames(f), mImg)
        else                    % show image with head movements
            if strcmp(sAnsHead, 'Yes')
                wt_display_frame(vLoadFrames(f), mImg, 0, 'nohead'); % head markers
            else
                wt_display_frame(vLoadFrames(f), mImg); % no head markers
            end
        end
        drawnow
        
        % Store frame (for saving later)
        if strcmp(sOption, 'save')
            if strcmp(sAnsTraces, 'Yes') % grab frame with angles
                hNewFrameAx = copyobj(g_tWT.FrameAx, hMovPan); % Copy frame
                axes(hAngAx) % Draw traces
                set(hLine, 'xdata', [1:vLoadFrames(f)], 'ydata', g_tWT.MovieInfo.Angle(1:vLoadFrames(f), 1))
                set(hAngAx, 'xlim', [0 nLastFrame], 'ylim', [min(g_tWT.MovieInfo.Angle(:))-1 max(g_tWT.MovieInfo.Angle(:))+2])
                xlabel('Time (msec)'); ylabel('Angle (deg)')
                drawnow
                mF = getframe(hNewFig); % grab frame
                tMov = addframe(tMov, mF);
                cla(hNewFrameAx)
            else % grab frame without angles
                mF = getframe(g_tWT.FrameAx);
            end
            tMov = addframe(tMov, mF);
            i = i + 1;
        end
    end
    wt_set_status([''])
    if g_tWT.StopProc, break, end
end
wt_set_status([''])

% Open window for re-playing and saving movie
if strcmp(sOption, 'save')
    if strcmp(sAnsTraces, 'Yes'), close(hNewFig), end
    wt_set_status('')
    tMov = close(tMov);
end


return
