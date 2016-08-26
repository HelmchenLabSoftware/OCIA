function wt_track_whiskers_with_labels(sDefAns)
% WT_TRACK_WHISKERS_WITH_LABELS
% Used whisker labels to interpolate/extrapolate the whisker shaft location
% in each frame. The user selects the basepoint and endpoint location. The
% function then interpolates a spline between the whisker-labels and
% extrapolates the additional distance to the base and tip.

global g_tWT

% Warn user that old SplinePoints will be deleted
%if size(g_tWT.MovieInfo.SplinePoints,3) > 1
%    sAnswer = questdlg('This action will overwrite all previously tracked data. Are you sure you want to continue?', 'WT', 'Yes', 'No', 'Cancel', 'Cancel');
%    switch sAnswer
%        case 'No', return
%        case 'Cancel', return
%    end
%end

g_tWT.MovieInfo.SplinePoints = [];

% Ask user if the the shaft should be extrapolated
if isempty(sDefAns)
    sAnswer = questdlg('Do you want to extrapolate the whisker to its base?', 'WT', 'Yes', 'No', 'No');
else
    sAnswer = sDefAns;
end
wt_batch_redo(['wt_track_whiskers_with_labels(''' sAnswer ''')']);
nXlim = [];

% Iterate over whiskers
for w = 1:length(g_tWT.MovieInfo.WhiskerLabels)
    % Select base-point X-coordinate
    if strcmp(sAnswer, 'Yes')
        set(g_tWT.Handles.hStatusText, 'string', sprintf('Select base-location of whisker %s', cell2mat(g_tWT.MovieInfo.WhiskerIdentity{w})));
        [nXlim nYlim] = ginput(1);
        if g_tWT.MovieInfo.WhiskerSide(w) == 2
            vAxSize = get(g_tWT.FrameAx, 'XLim');
            nXlim = nXlim - vAxSize(2)/2; % only change X
        end
    end
    
    set(g_tWT.Handles.hStatusText, 'string', sprintf('Assigning splinepoints to whisker %s. Please wait...', cell2mat(g_tWT.MovieInfo.WhiskerIdentity{w}))); drawnow
    for f = 1:size(g_tWT.MovieInfo.WhiskerLabels{w}, 1) % Iterate over frames
        vX = squeeze(g_tWT.MovieInfo.WhiskerLabels{w}(f,1,:));
        vY = squeeze(g_tWT.MovieInfo.WhiskerLabels{w}(f,2,:));
        vIndxRemX = find(isnan(vX));
        vIndxRemY = find(isnan(vY));
        vX([vIndxRemX vIndxRemY]) = [];
        vY([vIndxRemX vIndxRemY]) = [];
        if isempty(vX) | isempty(vY), continue, end
        if ~isempty(nXlim)
            try
                vYY = interp1(vX, vY, nXlim:max(vX), 'spline', 'extrap');
            catch, break, end
            nYlim = vYY(1);
            vX = [nXlim;vX];
            vY = [nYlim;vY];
        end
        % If there are only two splinepoints (e.g. only base and tip were
        % tracked), interpolate a third point halfway between vX(1) and vX(2)
        if length(vX) == 2
            vXX = [vX(1) sum(vX)/2 vX(2)]';
            try % catch cases when points are not unique
                vYY = interp1(vX, vY, vXX, 'spline', 'extrap');
            catch
                wt_error(sprintf('Failed computing spline in frame %d', f))
            end
            vX = vXX;
            vY = vYY;
        end
        g_tWT.MovieInfo.SplinePoints(1:length(vX),1,f,w) = vX;
        g_tWT.MovieInfo.SplinePoints(1:length(vX),2,f,w) = vY;
    end
    wt_display_frame(1)
end
set(g_tWT.Handles.hStatusText, 'string', '');

return

