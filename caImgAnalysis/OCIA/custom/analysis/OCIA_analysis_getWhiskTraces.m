function [whiskTraces, whiskStimVect, whiskTraceTypes, whiskFrameRateCellArray] = OCIA_analysis_getWhiskTraces(this, iDWRows)

totalTic = tic; % for performance timing purposes

%% general plotting parameter UI controls
if ~ismember('selWhiskTraceType', this.GUI.an.paramPanConfig.id);
        paramConf = cell2table({ ...
...     categ       id                        UIType    valueType       UISize  isLabAbove
...         label                       tooltip
        'whisk',    'selWhiskTraceType',  'dropdown',   {},             [1 0],  false, ...
            'Stim. whisk trace',        'Select which whisker trace should be used to create the stimulus vector.';
        'whisk',    'stimVectMinStartTime',  'text',   { 'numeric' },   [1 0],  false, ...
            'Stim. min. start time',    'Starting time in seconds after which to look for stim. for construction of whisk stim. vector.';
        'whisk',    'stimVectPeakSTDThresh',  'text',   { 'numeric' },  [1 0],  false, ...
            'Stim. peak thresh',        'Minimum peak height (in number of STDs above mean) for construction of whisk stim. vector.';
        'whisk',    'stimVectInterPeakDistThresh',  'text',   { 'numeric' },   [1 0],  false, ...
            'Stim. inter-peak dist.',   'Minimum inter-peak distance in seconds for construction of whisk stim. vector.';
        'whisk',    'stimVectPeakStartThreshold',  'text',   { 'numeric' },   [1 0],  false, ...
            'Stim. onset thresh.',      'Fraction of the peak that we must go below to find the onset of the peak in the construction of whisk stim. vector.';
        'whisk',    'stimVectDbgPlotRows',  'text',   { 'array' },   	[1 0],  false, ...
            'Stim. debug plot',         'Array of the rows for which a debuging plot should be plotted.';
            
    }, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);
    % append the new configuration to the table and update the row names using the ids
    this.GUI.an.paramPanConfig = [this.GUI.an.paramPanConfig; paramConf];
    this.GUI.an.paramPanConfig.Properties.RowNames = this.GUI.an.paramPanConfig.id;    
end;


%% whisker traces: fetch or extract data
ANShowHideMessage(this, 1, 'Loading whisker traces ...');
% get the data in memory
hashStruct = struct('iDWRows', iDWRows, 'dataType', 'whiskTraces');
cachedData = ANGetCachedData(this, 'whisk', hashStruct);

% if the data is not in cache yet, create it
if isempty(cachedData);
    
    % get the imaging frame rate and number of frames
    imgFrameRate = this.an.img.defaultFrameRate;    
    % get the number of skipped frames from the imaging
    skipFrameParams = this.an.skipFrame;

    % get the whisker data
    whiskDataStructCellArray = getData(this, iDWRows, 'whisk', 'data');
    % make sure this is a cell-array
    if ~isempty(whiskDataStructCellArray) && ~iscell(whiskDataStructCellArray);
        whiskDataStructCellArray = { whiskDataStructCellArray };
    end;

    % if no whisker data was found, abort;
    % whikser data must be a non empty structure
    if isempty(whiskDataStructCellArray) || ~isstruct(whiskDataStructCellArray{1}) ... 
    ...     % check that angle field is present and not empty
            || ~isfield(whiskDataStructCellArray{1}, 'angle') || isempty(whiskDataStructCellArray{1}.angle) ...
    ...     % check that frameRate field is present and not empty
            || ~isfield(whiskDataStructCellArray{1}, 'frameRate') || isempty(whiskDataStructCellArray{1}.frameRate);

        % return empty array and show a warning message
        whiskTraces = [];
        showWarning(this, 'OCIA:OCIA_analysis_getWhiskTraces:NoWhiskData', ...
            sprintf('Cannot find whisker data for row %03d. Aborting.', iDWRows(1)));
        return; % abort processing of this row

    end;

    % get the size of the data set
    nRows = size(whiskDataStructCellArray, 1);
    % extract the angle vector and the frame rate
    whiskDataCellArray = arrayfun(@(i)whiskDataStructCellArray{i}.angle, 1 : nRows, 'UniformOutput', false)'; 
    whiskFrameRateCellArray = arrayfun(@(i)whiskDataStructCellArray{i}.frameRate, 1 : nRows, 'UniformOutput', false)';    

    ANShowHideMessage(this, 1, 'Extracting and generating the whisker traces ...');
    [WAEnvs, WAAmp, WASetP, WAExpWhisk, WAFovWhisk] = OCIA_analysis_getWhiskVectors(this, whiskDataCellArray, ...
        whiskFrameRateCellArray);
    whiskDataCellArray = cat(2, whiskDataCellArray, WAEnvs, WAAmp, WASetP, WAExpWhisk, WAFovWhisk);
    whiskTraceTypes = { 'raw', 'envelope', 'amplitude', 'set point', 'exploratory', 'foveal' };
    
    % whisker types
    nWhiskTypes = size(whiskDataCellArray, 2);

    % down sample the whisking data to the imaging frame rate
    ANShowHideMessage(this, 1, 'Down-sampling the whisker traces ...');
    for iWhiskType = 1 : nWhiskTypes;
        % down sample the whisker traces one by one
        parfor iRow = 1 : nRows;
            whiskDataCellArray{iRow, iWhiskType} = interp1DS(whiskFrameRateCellArray{iRow}, ...
                imgFrameRate, whiskDataCellArray{iRow, iWhiskType});
            % adjust for the imaging's frame skipping
            whiskDataCellArray{iRow, iWhiskType} ...
                = whiskDataCellArray{iRow, iWhiskType} ...
                (1 + skipFrameParams.nFramesBegin : end - skipFrameParams.nFramesEnd); %#ok<PFBNS>
        end;
    end;

    % adjust the number of frames by putting NaN paddings at the *begining* of the traces
    maxNFramesWhiskTraces = max(arrayfun(@(i)size(whiskDataCellArray{i, 1}, 2), 1 : nRows));
    for iWhiskType = 1 : nWhiskTypes;
        whiskDataCellArray(:, iWhiskType) = arrayfun(@(i) ...
            [nan(1, maxNFramesWhiskTraces - size(whiskDataCellArray{i, iWhiskType}, 2)), whiskDataCellArray{i, iWhiskType}], ...
            1 : nRows, 'UniformOutput', false)';
    end;
    
    % transform each whisker trace into into a nRows x nFrames matrix
    whiskTraces = cell(nWhiskTypes, 1);
    for iWhiskType = 1 : nWhiskTypes;
        whiskTraces{iWhiskType} = cell2mat(whiskDataCellArray(:, iWhiskType));
    end;  
    
    % store the variables in the cached structure
    cachedData = struct('whiskTraces', { whiskTraces }, 'whiskTraceTypes', { whiskTraceTypes }, ...
        'whiskFrameRateCellArray', { whiskFrameRateCellArray }, 'dataType', 'whiskTraces', 'params', hashStruct);
    % store the data in memory
    ANStoreCachedData(this, 'whisk', hashStruct, cachedData);

% if data was in memory, fetch it
else
    
    % fetch the data
    whiskTraces = cachedData.whiskTraces;
    whiskTraceTypes = cachedData.whiskTraceTypes;
    whiskFrameRateCellArray = cachedData.whiskFrameRateCellArray;

end;

%% stim vector: fetch or extract data
% get which whisker trace should be used for stim vector
if isempty(this.an.whisk.selWhiskTraceType) || ~ismember(this.an.whisk.selWhiskTraceType, whiskTraceTypes);
    this.an.whisk.selWhiskTraceType = 'exploratory';
elseif iscell(this.an.whisk.selWhiskTraceType) && numel(this.an.whisk.selWhiskTraceType) > 1;
    this.an.whisk.selWhiskTraceType = this.an.whisk.selWhiskTraceType{1};
end;

% get the data in memory
hashStruct.selWhiskTraceType = this.an.whisk.selWhiskTraceType;
hashStruct.minStartTime = this.an.whisk.stimVectMinStartTime;
hashStruct.peakSTDThresh = this.an.whisk.stimVectPeakSTDThresh;
hashStruct.interPeakDistThresh = this.an.whisk.stimVectInterPeakDistThresh;
hashStruct.stimVectPeakStartThreshold = this.an.whisk.stimVectPeakStartThreshold;
hashStruct.dataType = 'whiskStimVect';
cachedData = ANGetCachedData(this, 'whisk', hashStruct);

% get index
iWhiskTypeToUse = find(strcmp(whiskTraceTypes, this.an.whisk.selWhiskTraceType));

% if the data is not in cache yet, create it
if isempty(cachedData);
    
    % get the imaging frame rate and number of frames
    imgFrameRate = this.an.img.defaultFrameRate;    

    % create the vector for each row
    whiskStimVect = zeros(size(whiskTraces{iWhiskTypeToUse}));
    
    for iRow = 1 : size(whiskStimVect, 1);

        % select the correct whisker data
        whiskData = whiskTraces{iWhiskTypeToUse}(iRow, :);
        
        % use data with no negative values
        whiskData = whiskData - min(whiskData(:));

        % extract the stimulus vector by thresholding
        whiskStimVect(iRow, :) = getStimVectFromTrace(whiskData, this.an.whisk.stimVectPeakSTDThresh, [], ...
            this.an.whisk.stimVectInterPeakDistThresh, this.an.whisk.stimVectMinStartTime, ...
            this.an.whisk.stimVectPeakStartThreshold, imgFrameRate, ...
            ismember(iRow, this.an.whisk.stimVectDbgPlotRows), ...
            sprintf('Row %02d: %s', iRow, DWGetRowID(this, iDWRows(iRow))), whiskTraces{iWhiskTypeToUse});

    end;
    
    % store the variables in the cached structure
    cachedData = struct('whiskStimVect', whiskStimVect,  'dataType', 'whiskStimVect', 'params', hashStruct);
    % store the data in memory
    ANStoreCachedData(this, 'whisk', hashStruct, cachedData);

% if data was in memory, fetch it
else
    
    % fetch the data
    whiskStimVect = cachedData.whiskStimVect;

end;

%% update parameter pannel
this.GUI.an.paramPanConfig{'selWhiskTraceType', 'valueType'} = { whiskTraceTypes };

o('#%s done (%3.1f sec).', mfilename(), toc(totalTic), 2, this.verb);

end