function varargout = track_average_whisker_position_jc_aa(varargin)
g_tWT=varargin{1};
global g_tWT % load global parameter
if nargin > 1
    MovieInfo=varargin{2};
    g_tWT.MovieInfo.WhiskerOrigin=MovieInfo.WhiskerOrigin;
    g_tWT.MovieInfo.RefLine=MovieInfo.RefLine;
    g_tWT.MovieInfo.Outlines=MovieInfo.Outlines;
    
end

g_tWT.StopProc = 0;

% ----------------------PARAMETERS-------------------------------------%
vidfile = g_tWT.MovieInfo.Filename;
viewims = 1;

% parameters for thresholding whiskers
threshmultiplier =0.92; %1.15;% 0.92; % threshold of mean pixel value over entire movie, 0.92 was the original value
h = fspecial('gaussian',[5 5],1); % to smooth average background for whisker removal

%---------------- end params-------------------------------------------%


% Get AVI info
info = aviinfo(vidfile);
numframes = info.NumFrames;
nStep = g_tWT.MovieInfo.ScreenRefresh; % added 10/01 Per

% Create waitbar
hWaitbar = waitbar(0, 'Computing mean image...'); % added 10/01 Per
wt_set_status('Computing mean image')

% Compute mean image
mov = aviread(vidfile,1);
pixgrid = wt_image_preprocess( double(mov.cdata) );
sumim = double(zeros(size(pixgrid)));
for iframe = 1:nStep:numframes
    
    if ishandle(hWaitbar) & ~g_tWT.StopProc
        waitbar(iframe / numframes, hWaitbar);
    else, wt_set_status(''), return; end
    
    % Extract frame
    try, mov = aviread(vidfile,iframe);
    catch, break, end
    pixgrid = wt_image_preprocess( double(mov.cdata) );
    pixwhisk = pixgrid; % original
    sumim = sumim+pixgrid;
end
meanim = sumim./length(1:nStep:numframes);

% Close waitbar
close(hWaitbar)

hFig = g_tWT.WTWindow; % get figure handle

% Get origin
if isfield (g_tWT.MovieInfo, 'WhiskerOrigin')

else
    wt_set_status('Click on whiskerpad origin')
    global g_tWT
    axes(g_tWT.FrameAx)

    % Get coordinates
    [vX vY] = ginput(1);
    g_tWT.MovieInfo.WhiskerOrigin = sortrows([round(vX) round(vY)], 2);

    % Get padangle
    wt_set_status('Set reference line')
    wt_set_reference_line
end
% Get ROI
mov = aviread(vidfile,1);
pixgrid = wt_image_preprocess( double(mov.cdata) );
pixgridim(:,:,1) = pixgrid(:,:,1);
pixgridim(:,:,2) = pixgrid(:,:,1);
pixgridim(:,:,3) = pixgrid(:,:,1);
image(uint8(pixgridim)); axis equal;
width = size(pixgrid,2); height = size(pixgrid,1);



wt_set_status('Select region where whiskers move.')

% If there exists an outline by the name AVGPOS_ROI, then use this as the
% ROI. If not, define it again manually. To override this, user must first
% manually delete the outline.
BWroi = [];
if isfield(g_tWT.MovieInfo, 'Outlines')
    csFields = [g_tWT.MovieInfo.Outlines.Name];
    nIndx = find(strcmp(csFields, 'AVGPOS_ROI'));
    if ~isempty(nIndx)
        mCoords = g_tWT.MovieInfo.Outlines(nIndx(1)).Coords;
        mCoords(end+1,:) = mCoords(1,:); % make sure ROI is closed
        BWroi = roipoly([1 size(pixgridim,2)],[1 size(pixgridim,1)],pixgridim(:,:,1),mCoords(:,1),mCoords(:,2));
    end
end
if isempty(BWroi)
    [x,y,BWroi,xi,yi] = roipoly;
    % Save region of interest as an outline
    if ~isfield(g_tWT.MovieInfo, 'Outlines')
        g_tWT.MovieInfo.Outlines = struct([]);
    end
    g_tWT.MovieInfo.Outlines(end+1).Name = {'AVGPOS_ROI'};
    g_tWT.MovieInfo.Outlines(end).Coords = [xi yi];
end

roiinds = find(BWroi);
filtmeanim = imfilter(meanim,h);
filtmeanim = filtmeanim(:,:,1);
thresh = threshmultiplier*filtmeanim;
if isempty(viewims), close(hFig); end % added 10/01 Per
wt_set_status('Tracking average whisker position. Press Stop to abort.')
nStepCount = 0;
nStep = 50;

% TODO Pre-load X filed
vTrackFrames = 1:g_tWT.MovieInfo.NoFramesToLoad:numframes;
for nStepRange = vTrackFrames
    % Prevent frame-range not to exceed actual max number of frames
    vFrames = nStepRange:nStepRange+g_tWT.MovieInfo.NoFramesToLoad-1;
    vFrames = vFrames(find(vFrames <= numframes));
    
    % Load frames in current range
    % if this fails, video may be corrupted etc
    try, mFrames = wt_load_avi(vidfile, vFrames);
    catch, break, end

    % Iterate over frames in current range
    for nFrame = 1:length(vFrames)
        iframe = vFrames(nFrame); % real framenumber
        
        % If all frame pixels have the same value assign NaN to position 
        % A blank frame (usually black) typically means the frame was not acquired.
        % Blank frames were later inserted into the movie for completeness
        
        % extract frame
        mov = mFrames(:,:,nFrame);
        pixgrid = wt_image_preprocess( mov );
        whiskermask = (pixgrid<thresh).*BWroi;
        [xinds yinds] = find(whiskermask);
        
        % Remove all pixels that dont have immediate neighbours
        % TODO
        mFilt = ones(4,6);
        whiskermask2 = imfilter(whiskermask, mFilt) ./ prod(size(mFilt));
        whiskermask3 = zeros(size(whiskermask));
        whiskermask3(intersect(find(whiskermask2 >= 4/prod(size(mFilt))), find(whiskermask))) = 1;
        whiskermask = whiskermask3;

        % calculate center of mass in each row
        cm_x_mean_not_rounded(iframe) = mean(yinds);
        cm_y_mean_not_rounded(iframe) = mean(xinds);

        % Update slider
        set(g_tWT.Handles.hSlider, 'value', iframe)

        % plot
        if ~isempty(viewims) & (nStepCount == 0) % show images with dot on center of mass
            pixwhisk = whiskermask .* 255; % masked
            pixwhiskim(:,:,1) = pixwhisk; pixwhiskim(:,:,2) = pixwhisk; pixwhiskim(:,:,3) = pixwhisk;
            if ~ishandle(hFig) | g_tWT.StopProc % abort
                wt_set_status('')
                return
            end
            figure(hFig);
            cla
            image(uint8(pixwhiskim)); axis equal; hold on
            plot(cm_x_mean_not_rounded(iframe), cm_y_mean_not_rounded(iframe), 'r.', 'markersize', 16)
        end

        if nStepCount >= nStep, nStepCount = 0;
        else, nStepCount = nStepCount + 1; end

        drawnow
    end

end
wt_set_status('')

% Save tracking data
g_tWT.MovieInfo.AvgWhiskerPos = [cm_x_mean_not_rounded' cm_y_mean_not_rounded'];

% calculate angle
g_tWT.MovieInfo.AvgWhiskerAngle=ks_CalcAngle(g_tWT);
% Refresh gui
wt_display_frame
% Export vectors
% Default save filename and directory is same as currently loaded file, but
% give user option to change in UI dialog
sDefFileName = [g_tWT.MovieInfo.Filename(1:end-4) '_Whisker_Tracking'];
% sDefFileName_ks = [g_tWT.MovieInfo.Filename(1:end-7) '_Whisker_Tracking'];
%uisave(cVarNames, sDefFileName); % interactive save
save(sDefFileName, '-struct', 'g_tWT'); % default save
% save(sDefFileName_ks, '-struct','g_tWT');
return
