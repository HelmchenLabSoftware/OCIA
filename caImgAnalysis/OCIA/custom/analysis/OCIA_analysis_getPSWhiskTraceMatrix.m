function [PSWhiskTraces, whiskTraceTypes, allStimIDs, allROINames] = OCIA_analysis_getPSWhiskTraceMatrix(this, iDWRows)

totalTic = tic; % for performance timing purposes

% get the calcium traces
[~, stims, ~, ~, ~, allCaTraces, ~, allROINames] = OCIA_analysis_getCaTracesMatrix(this, ...
    iDWRows, this.an.img.combineROIs);

% get the whisker traces
[whiskTracesCell, ~, whiskTraceTypes, ~] = OCIA_analysis_getWhiskTraces(this, iDWRows);

nWhiskTypes = numel(whiskTracesCell);
% init the matrix
whiskTraces = nan(size(allCaTraces, 1), nWhiskTypes, size(allCaTraces, 3));
for iWhiskType = 1 : nWhiskTypes;
    [nTrials, nFrames] = size(whiskTracesCell{iWhiskType});
    for iTrial = 1 : nTrials;
        whiskTraces(iTrial, iWhiskType, 1 : nFrames) = whiskTracesCell{iWhiskType}(iTrial, 1 : nFrames);
    end;
end;

% transform the whisk traces to the right format

%% general plotting parameter UI controls
if ~ismember('PSPer', this.GUI.an.paramPanConfig.id);
    paramConf = cell2table({ ...
    ... categ  id                   UIType      valueType               UISize  isLabAbove      label                   tooltip
        'img', 'PSPer',             'text',     { 'cellArray' },        [1 0],  false,          'Peri-stim. per.',    'Peri-stimulus period values for all PS periods (baseline vs. evoked) to display and to use for the analysis.';
        'img', 'PSPerID',           'list',     this.an.img.PSPer(:, 1), [1 3], false,          'Peri-stim. ID',        'Peri-stimulus period to display and to use for the analysis.';
    }, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);
    % append the new configuration to the table and update the row names using the ids
    this.GUI.an.paramPanConfig = [this.GUI.an.paramPanConfig; paramConf];
    this.GUI.an.paramPanConfig.Properties.RowNames = this.GUI.an.paramPanConfig.id;
end;

%% PS traces extraction
% get the currently selected peri-stimulus period
PSPerIDs = this.an.img.PSPer(ismember(this.an.img.PSPer(:, 1), this.an.img.PSPerID), 1);
PSPer = cell2mat(this.an.img.PSPer(ismember(this.an.img.PSPer(:, 1), this.an.img.PSPerID), 2 : end));

% get the data in memory
hashStruct = struct('iDWRows', iDWRows, 'selStimTypeGroups', { this.an.img.selStimTypeGroups }, 'PSPer', PSPer, ...
    'selStimIDs', { this.an.img.selStimIDs }, 'sgFiltFrameSize', this.an.img.sgFiltFrameSize, ...
    'exclFrames', this.an.img.exclFrames, 'combineROIs', this.an.img.combineROIs, 'dataType', 'PSWhiskTraces');
cachedData = ANGetCachedData(this, 'whisk', hashStruct);

% if the per-stimulus calcium traces matrix is not in cache yet, create it
if isempty(cachedData) || iscell(cachedData);

    % extract the peri-stimulus calcium traces
    PSExtractTic = tic; % for performance timing purposes
    allPSWhiskTracesCellArrayForPSPer = cell(size(PSPer, 1), 1);
    for iPSPer = 1 : size(PSPer, 1);
        allPSWhiskTracesCellArrayForPSPer{iPSPer} = extractPSTrace(whiskTraces, stims, round(PSPer(iPSPer, :) * this.an.img.defaultFrameRate));
    end;
    o('#%s extract PS-trace done (%3.1f sec).', mfilename(), toc(PSExtractTic), 2, this.verb);
    
    % combine the traces into a single matrix: get the data set size
    nStimTypesWithPSPer = sum(cellfun(@(cont)size(cont, 1), allPSWhiskTracesCellArrayForPSPer));
    maxNStims = max(cellfun(@(cont)size(cont, 2), allPSWhiskTracesCellArrayForPSPer));
    maxNROIs = max(cellfun(@(cont)size(cont, 3), allPSWhiskTracesCellArrayForPSPer));
    maxNPSFrames = max(cellfun(@(cont)size(cont, 4), allPSWhiskTracesCellArrayForPSPer));
    allPSWhiskTraces = nan(nStimTypesWithPSPer, maxNStims, maxNROIs, maxNPSFrames);
    
    % create a new list of stimulus IDs
    allStimIDs = [];
    
    % store each PSPeriod result
    iStimType = 0;
    for iPSPer = 1 : size(PSPer, 1);
        currPSWhiskTraces = allPSWhiskTracesCellArrayForPSPer{iPSPer};
        allPSWhiskTraces(iStimType + 1 : iStimType + size(currPSWhiskTraces, 1), ...
                1 : size(currPSWhiskTraces, 2), 1 : size(currPSWhiskTraces, 3), 1 : size(currPSWhiskTraces, 4)) ...
            = currPSWhiskTraces;
        iStimType = iStimType + size(currPSWhiskTraces, 1);
        
        % update the stimulus IDs list
        allStimIDs = [allStimIDs sprintf(sprintf('%%s_%s__SEP__', PSPerIDs{iPSPer}), this.an.img.selStimIDs{:})]; %#ok<AGROW>
    end;
    
    % store the new stimIDs only if there
    allStimIDs = regexp(regexprep(allStimIDs, '__SEP__$', ''), '__SEP__', 'split')';
    
    % store the variables
    cachedData = struct('allPSCaTraces', allPSWhiskTraces, 'allStimIDs', { allStimIDs }, 'dataType', 'PSWhiskTraces', ...
        'params', hashStruct);
    % store the data in memory
    ANStoreCachedData(this, 'whisk', hashStruct, cachedData);

% if data was in memory, fetch it
else
    % fetch the data
    allPSWhiskTraces = cachedData.allPSCaTraces;
    allStimIDs = cachedData.allStimIDs;

end;

% store data for output
PSWhiskTraces = allPSWhiskTraces(:, :, :, :);

o('#%s done (%3.1f sec).', mfilename(), toc(totalTic), 2, this.verb);

end