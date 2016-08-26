function bSuccess = wt_mark_eyes(varargin)
% WT_MARK_EYES
% Mark location of eyes in current frame
% return bSuccess = 0 if user does not input all required points
global g_tWT
bSuccess = 1;

figure(findobj('Tag', 'WTMainWindow'))

% Get frame number
if ~isempty(varargin), nCurrentFrame = varargin{1};
else, nCurrentFrame = get(g_tWT.Handles.hSlider, 'Value'); end

% Determine whether to mark nose as well
% Nose is only marked if g_tWT.MovieInfo.EyeNoseAxLen is not set
if ~isfield(g_tWT.MovieInfo, 'EyeNoseAxLen'), bMarkNose = 1;
else
    if isempty(g_tWT.MovieInfo.EyeNoseAxLen), bMarkNose = 1;
    else, bMarkNose = 0; end
end

%%% COLLECT LOCATIONS

% Get coordinates of eyes via ginput
hold on;
try
    for i = 1:2
         [nX nY] = ginput(1);  % user may hit RETURN if he does not want to input data
         vCurrXPos(i,1) = nX;
         vCurrYPos(i,1) = nY;
         scatter(vCurrXPos(i), vCurrYPos(i), 'go');
         drawnow;
    end
catch
    bSuccess = 0;   % eyes not marked
    return;
end

% Get coordinates of nose via ginput
if bMarkNose
    try
        [nNoseX nNoseY] = ginput(1);
    catch
        bSuccess = 0;   % nose not marked
        return;
    end
    scatter(nNoseX, nNoseY, 'ro');
else
    % Compute location of nose based on g_tWT.MovieInfo.EyeNoseAxLen
    %vNosePos = wt_find_nose(vLeyePos(nRealFrame, :), vLeyePos(nRealFrame, :), g_tWT.MovieInfo.EyeNoseAxLen);
end
hold off


%%% STORE LOCATIONS

% Reset old data
g_tWT.MovieInfo.RightEye = zeros(g_tWT.MovieInfo.NumFrames, 2) * NaN; % [x y]
g_tWT.MovieInfo.LeftEye = zeros(g_tWT.MovieInfo.NumFrames, 2) * NaN; % [x y]
g_tWT.MovieInfo.Nose = zeros(g_tWT.MovieInfo.NumFrames, 2) * NaN; % [x y]

% Assign new values for first frame
mPos = round(sortrows([vCurrXPos(1:2) vCurrYPos(1:2)])); % sort value-pairs so that right eye is first
g_tWT.MovieInfo.RightEye(nCurrentFrame, :) = mPos(1, :);
g_tWT.MovieInfo.LeftEye(nCurrentFrame, :) = mPos(2, :);
if bMarkNose
    g_tWT.MovieInfo.Nose(nCurrentFrame, :) = [nNoseX nNoseY];
end

% Calculate length of eye-nose axes
if bMarkNose
    R = mPos(1, :); % right eye
    L = mPos(2, :); % left eye
    M = [mean([R(1) L(1)]) mean([R(2) L(2)])]; % mid-point between eyes
    g_tWT.MovieInfo.EyeNoseAxLen = sqrt(diff([nNoseX M(1)])^2 + diff([nNoseY M(2)])^2); % length of eyes-nose axes
end

return
