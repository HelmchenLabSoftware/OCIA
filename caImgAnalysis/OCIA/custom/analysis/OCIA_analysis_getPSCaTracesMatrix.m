function [PSCaTraces, ROINames, allStimIDs, hashStruct] = OCIA_analysis_getPSCaTracesMatrix(this, iDWRows)

totalTic = tic; % for performance timing purposes

% get the calcium traces
[~, stims, ROINames, ~, ~, allCaTraces, ~, allROINames, hashStruct] = OCIA_analysis_getCaTracesMatrix(this, ...
    iDWRows, this.an.img.combineROIs);

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
hashStruct.PSPer = PSPer;
hashStruct.sgFiltFrameSize = this.an.img.sgFiltFrameSize;
hashStruct.combineROIs = this.an.img.combineROIs;
hashStruct.dataType = 'PSCaTraces';
cachedData = ANGetCachedData(this, 'img', hashStruct);

% if the per-stimulus calcium traces matrix is not in cache yet, create it
if isempty(cachedData) || iscell(cachedData);

    % apply filtering if required
    if this.an.img.sgFiltFrameSize > 1;
        fliterTic = tic; % for performance timing purposes
        % get the size of the dataset
        [nTrials, nTotROIs, ~] = size(allCaTraces);
        allCaTracesSGFilt = nan(size(allCaTraces));
        filtFrameSize = this.an.img.sgFiltFrameSize;
        parfor iROI = 1 : nTotROIs;
            for iTrial = 1 : nTrials;
                allCaTracesSGFilt(iTrial, iROI, :) = sgolayfilt(allCaTraces(iTrial, iROI, :), 1, filtFrameSize);
            end;
        end;
        allCaTraces = allCaTracesSGFilt;
        clear('allCaTracesSGFilt');
        o('#%s filtering done (%3.1f sec).', mfilename(), toc(fliterTic), 2, this.verb);
    end;
    
    % extract the peri-stimulus calcium traces
    PSExtractTic = tic; % for performance timing purposes
    allPSCaTracesCellArrayForPSPer = cell(size(PSPer, 1), 1);
    for iPSPer = 1 : size(PSPer, 1);
        allPSCaTracesCellArrayForPSPer{iPSPer} = extractPSTrace(allCaTraces, stims, round(PSPer(iPSPer, :) * this.an.img.defaultFrameRate));
    end;
    o('#%s extract PS-trace done (%3.1f sec).', mfilename(), toc(PSExtractTic), 2, this.verb);
    
    % combine the traces into a single matrix: get the data set size
    nStimTypesWithPSPer = sum(cellfun(@(cont)size(cont, 1), allPSCaTracesCellArrayForPSPer));
    maxNStims = max(cellfun(@(cont)size(cont, 2), allPSCaTracesCellArrayForPSPer));
    maxNROIs = max(cellfun(@(cont)size(cont, 3), allPSCaTracesCellArrayForPSPer));
    maxNPSFrames = max(cellfun(@(cont)size(cont, 4), allPSCaTracesCellArrayForPSPer));
    allPSCaTraces = nan(nStimTypesWithPSPer, maxNStims, maxNROIs, maxNPSFrames);
    
    % create a new list of stimulus IDs
    allStimIDs = [];
    
    % store each PSPeriod result
    iStimType = 0;
    for iPSPer = 1 : size(PSPer, 1);
        currPSCaTraces = allPSCaTracesCellArrayForPSPer{iPSPer};
        allPSCaTraces(iStimType + 1 : iStimType + size(currPSCaTraces, 1), ...
                1 : size(currPSCaTraces, 2), 1 : size(currPSCaTraces, 3), 1 : size(currPSCaTraces, 4)) ...
            = currPSCaTraces;
        iStimType = iStimType + size(currPSCaTraces, 1);
        
        % update the stimulus IDs list
        allStimIDs = [allStimIDs sprintf(sprintf('%%s_%s__SEP__', PSPerIDs{iPSPer}), this.an.img.selStimIDs{:})]; %#ok<AGROW>
    end;
    
    % store the new stimIDs only if there
    allStimIDs = regexp(regexprep(allStimIDs, '__SEP__$', ''), '__SEP__', 'split')';
    
    % store the variables
    cachedData = struct('allPSCaTraces', allPSCaTraces, 'dataType', 'PSCaTraces', 'allStimIDs', { allStimIDs }, 'params', hashStruct);
    % store the data in memory
    ANStoreCachedData(this, 'img', hashStruct, cachedData);

% if data was in memory, fetch it
else
    % fetch the data
    allPSCaTraces = cachedData.allPSCaTraces;
    allStimIDs = cachedData.allStimIDs;

end;


%% prepare data
% fetch or extract data from memory
hashStruct.dataType = 'selectedPSCaTraces';
hashStruct.ROINames = ROINames;
cachedData = ANGetCachedData(this, 'img', hashStruct);

% if the processed peri-stimulus calcium traces are not in cache yet, create it
if isempty(cachedData) || iscell(cachedData);    

    % get the indexes of the selected ROIs
    selROIs = find(ismember(allROINames, ROINames));
    % if none selected, select all of them
    if isempty(selROIs);
        selROIs = 1 : numel(allROINames);
    end;

    % exclude the ROIs that have no data
    emptyROIs = false(numel(selROIs), 1);
    for iSelROI = 1 : numel(emptyROIs);
        PSTracesForROI = allPSCaTraces(:, :, selROIs(iSelROI), :);
        emptyROIs(iSelROI) = ~any(~isnan(PSTracesForROI(:)));
    end;
    selROIs(emptyROIs) = [];


    % combine ROIs if needed
    if this.an.img.combineROIs;

        % get the size of the big matrix
        [nStimTypes, nStims, ~, nPSFrames] = size(allPSCaTraces);
        nROIs = numel(ROINames);

        % create the combined matrix line by line
        PSCaTraces = nan(nStimTypes, 200, nROIs, nPSFrames);
        iMaxStim = -Inf;
        for iCombROI = 1 : nROIs;
            for iStimType = 1 : nStimTypes;
                iStim = 0;
                sameNameROIs = find(strcmp(ROINames{iCombROI}, allROINames));
                for iRefROILoop = 1 : numel(sameNameROIs);
                    % get the current reference ROIs' stims
                    refROIsStims = reshape(allPSCaTraces(iStimType, :, sameNameROIs(iRefROILoop), :), [nStims, nPSFrames]);
                    refROIsStims(~any(~isnan(refROIsStims), 2), :) = []; % remove NaN stims
                    PSCaTraces(iStimType, iStim + 1 : iStim + size(refROIsStims, 1), iCombROI, :) = refROIsStims;
                    iStim = iStim + size(refROIsStims, 1);
                end;
                iMaxStim = max(iMaxStim, iStim);
            end;
        end;
        % remove useless rows
        iMaxStim = iff(iMaxStim == -Inf, 0, iMaxStim); % avoid having -Inf still at this point
        PSCaTraces(:, (iMaxStim + 1) : end, :, :) = [];

    % if no ROI combination is required
    else
        % get the selected calcium traces, stimulus vectors and ROIs
        PSCaTraces = allPSCaTraces(:, :, selROIs, :);
    end;
    
    % store the variables
    cachedData = struct('PSCaTraces', PSCaTraces, 'dataType', 'selectedPSCaTraces', 'params', hashStruct);
    % store the data in memory
    ANStoreCachedData(this, 'img', hashStruct, cachedData);
    
    
% if data was in memory, fetch it
else
    % fetch the data
    PSCaTraces = cachedData.PSCaTraces;

end;


o('#%s done (%3.1f sec).', mfilename(), toc(totalTic), 2, this.verb);

end