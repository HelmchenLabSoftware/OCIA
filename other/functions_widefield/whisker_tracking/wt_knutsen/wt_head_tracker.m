function bResult = wt_head_tracker(sFileName)
% WT_HEAD_TRACKER
% Track rat head movements
%

warning off MATLAB:divideByZero
warning off MATLAB:mir_warning_variable_used_as_function

global g_tWT
bResult = 1;
wt_toggle_display_mode(0)

g_tWT.MovieInfo.ImCropSize = round([g_tWT.MovieInfo.RadExt g_tWT.MovieInfo.EyeNoseAxLen+g_tWT.MovieInfo.HorExt*2]);

% Open waitbar dialog
hWaitbar = waitbar(0, sprintf('Loading buffer (%d frames)...', g_tWT.MovieInfo.NoFramesToLoad), 'CreateCancelBtn', 'delete(gcbf)');
set(hWaitbar, 'units', get(findobj('tag', 'WTMainWindow'), 'units'))
vFrPos = get(findobj('tag', 'WTMainWindow'), 'position');
vWtPos = get(hWaitbar, 'position');
set(hWaitbar, 'tag', 'auto');

% Add buttons for manual control
uicontrol(hWaitbar, 'Style', 'pushbutton', 'Position', [25 12 50 23], ...
    'Callback', 'set(gcf, ''tag'', ''manual_right'')', 'String', 'Right' );
uicontrol(hWaitbar, 'Style', 'pushbutton', 'Position', [85 12 50 23], ...
    'Callback', 'set(gcf, ''tag'', ''manual_left'')', 'String', 'Left' );
uicontrol(hWaitbar, 'Style', 'pushbutton', 'Position', [145 12 50 23], ...
    'Callback', 'set(gcf, ''tag'', ''manual_both'')', 'String', 'Both' );
uicontrol(hWaitbar, 'Style', 'pushbutton', 'Position', [205 12 50 23], ...
    'Callback', 'set(gcf, ''tag'', ''stop'')', 'String', 'Stop' );
drawnow

nYlim = g_tWT.MovieInfo.Height;
nXlim = g_tWT.MovieInfo.Width;

set(g_tWT.Handles.hSlider, 'enable', 'off') % disable slider

% Process frames
nFirstFrame = find(~isnan(g_tWT.MovieInfo.LeftEye(:,1)))+1;
nRealFrame = nFirstFrame(1);
bBreakOuter = 0;

% Outer loop: iterate over frame segments
while nRealFrame <= g_tWT.MovieInfo.NumFrames
    nRangeStart = nRealFrame;
    nRangeEnd = nRangeStart + g_tWT.MovieInfo.NoFramesToLoad - 1;
    nRangeEnd = min([nRangeEnd g_tWT.MovieInfo.NumFrames]);
    vFrameRange = nRangeStart:nRangeEnd; % range of frames in buffer
    waitbar(nRealFrame/g_tWT.MovieInfo.NumFrames, hWaitbar, sprintf('Loading buffer (%d frames)...', g_tWT.MovieInfo.NoFramesToLoad))
    mFrames = wt_load_avi(sFileName, vFrameRange); % load frame buffer
    
    % Inner loop: iterate over individual frames in buffer
    nFrame = 1;
    bBreakInner = 0;
    while nFrame <= length(vFrameRange) & nFrame > 0
        nRealFrame = vFrameRange(nFrame);
        try
            waitbar(nRealFrame/g_tWT.MovieInfo.NumFrames, hWaitbar, sprintf('Processing frame %d', nRealFrame))
        catch, bResult = 0; nBreakOuter = 1; break; end

        if g_tWT.MovieInfo.Invert == 0, nInvert = -1; else, nInvert = 1; end

        % Rotate
        if g_tWT.MovieInfo.Rot ~= 0, mFrames(:,:,nFrame) = imrotate(mFrames(:,:,nFrame), g_tWT.MovieInfo.Rot); end
        if g_tWT.MovieInfo.Flip(1) mFrames(:,:,nFrame) = flipud(mFrames(:,:,nFrame)); end % flip up-down
        if g_tWT.MovieInfo.Flip(2) mFrames(:,:,nFrame) = fliplr(mFrames(:,:,nFrame)); end % flip left-right

        if strcmp(get(hWaitbar, 'tag'), 'auto')
            % Automatic
            try
                g_tWT.MovieInfo.RightEye(nRealFrame, :) = wt_track_spot(double(mFrames(:,:,nFrame)).*nInvert, g_tWT.MovieInfo.RightEye(nRealFrame-1, :), [], g_tWT.EyeFilter.Filter, g_tWT.VerboseMode);
                g_tWT.MovieInfo.LeftEye(nRealFrame, :) = wt_track_spot(double(mFrames(:,:,nFrame)).*nInvert, g_tWT.MovieInfo.LeftEye(nRealFrame-1, :), [], g_tWT.EyeFilter.Filter, g_tWT.VerboseMode);
            catch, bBreakOuter = 1; break, end
            nFrame = nFrame + 1;
        elseif strcmp(get(hWaitbar, 'tag'), 'stop') % stop tracking at current frame
            bBreakOuter = 1; break
        else
            % Manual (ignore buffer and load frame-by-frame)
            nFrame = 0;
            while ~strcmp(get(hWaitbar, 'tag'), 'auto')
                if nRealFrame < nFirstFrame, nRealFrame = nFirstFrame; end

                % Get automatic suggestions
                mFrame = wt_load_avi(sFileName, nRealFrame); % load frame buffer
                g_tWT.MovieInfo.RightEye(nRealFrame, :) = wt_track_spot(double(mFrame).*nInvert, g_tWT.MovieInfo.RightEye(nRealFrame-1, :), [], g_tWT.EyeFilter.Filter, g_tWT.VerboseMode);
                g_tWT.MovieInfo.LeftEye(nRealFrame, :) = wt_track_spot(double(mFrame).*nInvert, g_tWT.MovieInfo.LeftEye(nRealFrame-1, :), [], g_tWT.EyeFilter.Filter, g_tWT.VerboseMode);
                g_tWT.MovieInfo.Nose(nRealFrame, :) = wt_find_nose(g_tWT.MovieInfo.RightEye(nRealFrame, :), g_tWT.MovieInfo.LeftEye(nRealFrame, :), g_tWT.MovieInfo.EyeNoseAxLen);
                wt_display_frame(nRealFrame); % refresh frame

                hLine = line(-10,-10); % indicator line
                set(hLine, 'linewidth', 5, 'color', [1 0 0])

                % Decide which side(s) to track
                switch get(hWaitbar, 'tag')
                    case 'manual_both', cSides = {'Right' 'Left'};
                    case 'manual_right', cSides = {'Right'};
                    case 'manual_left', cSides = {'Left'};
                end

                for sS = cSides
                    % Update indicator line
                    if strcmp(sS,'Right'), set(hLine, 'xdata', [1 1], 'ydata', [0 nYlim]);
                    else, set(hLine, 'xdata', [nXlim nXlim], 'ydata', [0 nYlim]), end
                    nX = -1; nY = -1;
                    % Get input
                    while ~ValidCoord(nX,nY), [nX, nY, nButton] = ginput(1); end
                    if nButton == 2 | nButton == 3
                        % Break if middle or right button was pressed
                        set(hWaitbar, 'tag', 'auto')
                        figure(hWaitbar)
                        bBreakInner = 1;
                        break
                    elseif nButton > 3
                        % Change framenumber if a number key was pressed
                        nRealFrame = nRealFrame - str2num(char(nButton));
                    else
                        % Assign coordinate
                        eval(sprintf('g_tWT.MovieInfo.%sEye(nRealFrame, :) = round([nX nY]);', char(sS)));
                        if strcmp(sS,cSides{end}), nRealFrame = nRealFrame + 1; end
                    end
                end
                delete(hLine)
                if bBreakInner
                    break
                end
            end
        end
    end % inner loop

    if bBreakOuter, break
    else % refresh frame
        g_tWT.MovieInfo.RightEye = g_tWT.MovieInfo.RightEye;
        g_tWT.MovieInfo.LeftEye = g_tWT.MovieInfo.LeftEye;
        g_tWT.MovieInfo.Nose = wt_find_nose(g_tWT.MovieInfo.RightEye, g_tWT.MovieInfo.LeftEye, g_tWT.MovieInfo.EyeNoseAxLen);
        if nFrame
            wt_display_frame(nRealFrame, mFrames(:,:,nFrame-1));
        else, wt_display_frame(nRealFrame); end
        figure(hWaitbar); drawnow
    end

end % outer loop
delete(hWaitbar)

g_tWT.MovieInfo.RightEye = g_tWT.MovieInfo.RightEye;
g_tWT.MovieInfo.LeftEye = g_tWT.MovieInfo.LeftEye;
g_tWT.MovieInfo.Nose = wt_find_nose(g_tWT.MovieInfo.RightEye, g_tWT.MovieInfo.LeftEye, g_tWT.MovieInfo.EyeNoseAxLen);

set(g_tWT.Handles.hSlider, 'enable', 'on', 'value', nFirstFrame-1) % enable slider
wt_toggle_display_mode(1) % refresh frame
wt_display_frame(nFirstFrame-1)

return

%%%%  VALIDCOORD
%%%%  Check if ginput() coordinates is inside the frame
function nB = ValidCoord(nX,nY)
global g_tWT
nB = 1;
vYlim = get(g_tWT.FrameAx, 'ylim');
vXlim = get(g_tWT.FrameAx, 'xlim');
if nX < 1 | nX > vXlim(2), nB = 0; end
if nY < 1 | nY > vYlim(2), nB = 0; end
return
