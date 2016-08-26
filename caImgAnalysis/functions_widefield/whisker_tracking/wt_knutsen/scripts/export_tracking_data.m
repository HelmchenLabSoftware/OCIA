function varargout = export_tracking_data(sWT, varargin)
% Export whisker traces as vectors. Includes Angle, Curvature, Intersect,
% PositionOffset and AvgWhiskerPos (those applicable).
%
% INSTALLATION:
% To run this script, copy it to the ./scripts folder where WT has been
% installed (most likely, this has already been done for you). To run the
% script, select the menu item Options -> Scripts -> export_angle_vectors.m
%
% PURPOSE:
% This script exports the angle traces of tracked whiskers as vectors in a
% .mat file. The exported .mat file will contain one vector for each
% whisker. The name of the whisker (if available) or index number is used
% for naming the vectors.
% 

% Fields to export
cFields = {'Angle', 'Curvature', 'Intersect', 'PositionOffset', 'AvgWhiskerPos', 'ROIEvent'};

% Iterate over fields
cVarNames = {};
tVars = struct([]);
for f = 1:length(cFields)
    % Check if there is data in current fields
    if ~isfield(sWT.MovieInfo, cFields{f}), continue, end
    if isempty(sWT.MovieInfo.(cFields{f})), continue, end

    if any(strcmp(cFields{f}, {'Angle', 'Curvature', 'PositionOffset'}))
        % Fields with [frame_a X whisker] structure
        mData = sWT.MovieInfo.(cFields{f});
        nWhiskers = size(mData, 2); % # tracked whiskers

        % Whisker names
        cNames = sWT.MovieInfo.WhiskerIdentity{1};
        for w = 1:nWhiskers
            if isempty(cNames{w})
                cNames{w} = {sprintf('%s_%d', cFields{f}, w)};
            end
        end
        
        % Create vectors
        for w = 1:nWhiskers
            sVarName = [cNames{w} '_' cFields{f}];
            if iscell(sVarName), sVarName = cell2mat(sVarName); end
            cVarNames{end+1} = sVarName;
            eval(sprintf('%s = mData(:,w);', sVarName));
            tVars(1).(sVarName) = mData(:,w);
        end

    elseif strcmp(cFields{f}, 'AvgWhiskerPos')
        % This is not a whisker specific parameter so no whisker
        % information is needed. Just export the average trace.
        if ~isfield(sWT.MovieInfo, 'AvgWhiskerPos'), continue, end
        if isempty(sWT.MovieInfo.AvgWhiskerPos), continue, end
        mData = sWT.MovieInfo.AvgWhiskerPos; % [ML AP]
        
        % Append vectors to output structure
        % - ML values
        sVarName = 'AvgWhiskerPos_ML';
        cVarNames{end+1} = sVarName;
        tVars(1).(sVarName) = mData(:,1);
        % - AP values
        sVarName = 'AvgWhiskerPos_AP';
        cVarNames{end+1} = sVarName;
        tVars(1).(sVarName) = mData(:,2);

    elseif strcmp(cFields{f}, 'ROIEvent')
        % This is not a whisker specific parameter so no whisker
        % information is needed. Just export the median ROI trace.
        if ~isfield(sWT.MovieInfo, 'ROIEvent'), continue, end
        if isempty(sWT.MovieInfo.ROIEvent), continue, end
        
        % Append vectors to output structure
        sVarName = 'ROIEvent';
        cVarNames{end+1} = sVarName;
        tVars(1).(sVarName) = sWT.MovieInfo.ROIEvent;

    elseif any(strcmp(cFields{f}, {'Intersect'}))
        
        % Fields with [frame_a X frame_b X whisker] structure
        mData = sWT.MovieInfo.(cFields{f});
        nWhiskers = size(mData, 3); % # tracked whiskers

        if isempty(sWT.MovieInfo.WhiskerIdentity), continue, end
        
        % Whisker names
        if isfield(sWT.MovieInfo, 'WhiskerIdentity')
            cNames = sWT.MovieInfo.WhiskerIdentity{1};
        else, cNames = cell(1,nWhiskers); end
        for w = 1:nWhiskers
            if isempty(cNames{w})
                cNames{w} = {sprintf('%s_%d', cFields{f}, w)};
            end
        end

        switch cFields{f}
            case 'Intersect', nIndx = 2;
        end
        
        % Create vectors
        for w = 1:nWhiskers
            sVarName = [cNames{w} '_' cFields{f}];
            if iscell(sVarName), sVarName = cell2mat(sVarName); end
            cVarNames{end+1} = sVarName;
            eval(sprintf('%s = mData(:,nIndx,w);', sVarName));
            tVars(1).(sVarName) = mData(:,nIndx,w);
        end
        
    end
    
end

% Framerate
cVarNames{end+1} = 'FPS';
eval(sprintf('%s = sWT.MovieInfo.FramesPerSecond;', cVarNames{end}));
tVars(1).(cVarNames{end}) = sWT.MovieInfo.FramesPerSecond;

% Gain
cVarNames{end+1} = 'Gain';
eval(sprintf('%s = 1;', cVarNames{end})); % default is 1
tVars(1).(cVarNames{end}) = 1;

% Export vectors
% Default save filename and directory is same as currently loaded file, but
% give user option to change in UI dialog
sDefFileName = [sWT.MovieInfo.Filename(1:end-4) '_Whisker_Tracking'];
%uisave(cVarNames, sDefFileName); % interactive save
save(sDefFileName, '-struct', 'tVars'); % default save

wt_set_status(['Exported tracking data of current movie'])

return
