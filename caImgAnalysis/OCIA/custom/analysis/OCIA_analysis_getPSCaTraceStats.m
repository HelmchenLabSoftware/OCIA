function [PSCaTracesStats, ROINames, t] = OCIA_analysis_getPSCaTraceStats(this, iDWRows, PSCaTraces, ROINames, stimIDs)

totalTic = tic; % for performance timing purposes

%% general plotting parameter UI controls
if ~ismember('normBaseline', this.GUI.an.paramPanConfig.id);
    
    % selected stimulus for sorting, use 'none' if none selected
    selStimsForSort = stimIDs;
    if isempty(selStimsForSort);
    	selStimsForSort = { 'none' };
    end;
    
    paramConf = cell2table({ ...
    ... categ  id                   UIType      valueType               UISize  isLabAbove      label                   tooltip
        'img', 'normBaseline',      'dropdown', { 'true', 'false' }',   [1 0],  false,          'Norm. baseline',       'Normalise the trials by the mean of the baseline frames.';
        'img', 'nStimsThreshold',   'text',     { 'numeric' },          [1 0],  false,          'Min. stims',           'Minimum number of stimuli to have for a stimulus type in order to be included in the analysis.';
        'img', 'averageROI',        'dropdown', { 'true', 'false' }',   [1 0],  false,          'Average ROIs',         'Average different ROIs together.';
        'img', 'respMethod',        'dropdown', { 'mean', 'max', 'sum', '3ppmax', 'maxAbs' }', [1 0], false, 'Resp. method',         'Method to calculate a responsiveness index for each ROI.';
        'img', 'sortMethod',        'dropdown', { 'none', 'mean', 'mean_evoked', 'max', 'max_evoked' }, ...
                                                                        [1 0],  false,          'Sorting method',       'Statistic to use to define the sorting order.';
        'img', 'sortDirection',     'dropdown', { 'ascending', 'descending' }, [1 0], false,    'Sorting direction',    'Sorting direction (highest response top or bottom).';
        'img', 'sortStim',          'dropdown', selStimsForSort,        [1 0],  false,          'Sorting stimulus',     'Defines on which stimulus the sorting is done.';
    }, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);
    % append the new configuration to the table and update the row names using the ids
    this.GUI.an.paramPanConfig = [this.GUI.an.paramPanConfig; paramConf];
    this.GUI.an.paramPanConfig.Properties.RowNames = this.GUI.an.paramPanConfig.id;
end;

%% fetch or extract data from memory
PSCaTracesStats = struct();
% get the currently selected peri-stimulus period
PSPerIDs = this.an.img.PSPer(ismember(this.an.img.PSPer(:, 1), this.an.img.PSPerID), 1);
PSPer = cell2mat(this.an.img.PSPer(ismember(this.an.img.PSPer(:, 1), this.an.img.PSPerID), 2 : end));

% get the data in memory
hashStruct = struct('iDWRows', iDWRows, 'selStimTypeGroups', { this.an.img.selStimTypeGroups }, 'PSPer', PSPer, ...
    'sgFiltFrameSize', this.an.img.sgFiltFrameSize, 'exclFrames', this.an.img.exclFrames, 'respMethod', this.an.img.respMethod, ...
    'combineROIs', this.an.img.combineROIs, 'averageROI', this.an.img.averageROI, 'selStimIDs', { this.an.img.selStimIDs }, ...
    'nStimsThreshold', this.an.img.nStimsThreshold, 'normBaseline', this.an.img.normBaseline, 'ROINames', { ROINames }, 'dataType', 'selectedPSCaTracesStats');
cachedData = ANGetCachedData(this, 'img', hashStruct);
    
% get the peri-stimulus frames' range
PSPerFrames = round(PSPer * this.an.img.defaultFrameRate);
PSFramesRange = min(PSPerFrames(:, 1)) : max(PSPerFrames(:, 4));

% create a time vector
t = PSFramesRange ./ this.an.img.defaultFrameRate;

% get the evoked frames mask
baseFramesMask = false(size(PSPer, 1), size(PSFramesRange, 2));
evokedFramesMask = false(size(PSPer, 1), size(PSFramesRange, 2));
nEvFrames = nan(size(PSPer, 1), 1);
nBaseFrames = nan(size(PSPer, 1), 1);
for iPSPer = 1 : size(PSPer, 1);
    baseFramesMask(iPSPer, ismember(PSFramesRange, PSPerFrames(iPSPer, 1) : PSPerFrames(iPSPer, 2))) = true;
    evokedFramesMask(iPSPer, ismember(PSFramesRange, PSPerFrames(iPSPer, 3) : PSPerFrames(iPSPer, 4))) = true;
    nBaseFrames(iPSPer) = nansum(baseFramesMask(iPSPer, :));
    nEvFrames(iPSPer) = nansum(evokedFramesMask(iPSPer, :));
end;
    
% if the per-stimulus calcium traces matrix is not in cache yet, create it
if isempty(cachedData) || iscell(cachedData);

    %% prepare
    % get the size of the dataset
    [nStimTypes, nStims, nROIs, nPSFrames] = size(PSCaTraces);

    %% average the traces
    stimAverageTic = tic; % for performance timing purposes

    % if averaging the ROIs together is requested
    if this.an.img.averageROI;
        ROINames = { sprintf('Pop. of %02d ROIs', nROIs) };
        PSCaTraces = nanmean(PSCaTraces, 3);
        nROIs = 1;
    end;

    % average each stimulus
    PSCaTraceMeans = reshape(nanmean(PSCaTraces, 2), [nStimTypes, nROIs, nPSFrames]);
    PSCaTraceErrors = nan(size(PSCaTraceMeans));
    for iStimType = 1 : nStimTypes;
        for iROI = 1 : nROIs;
            PSCaTraceErrors(iStimType, iROI, :) = nansem(squeeze(PSCaTraces(iStimType, :, iROI, :)));
        end;
    end;
    o('#%s: stimulus averaging done (%3.1f sec).', mfilename(), toc(stimAverageTic), 2, this.verb);

    % calculate the number of stimulus that where averaged for each ROI/stimType pair
    NStims = zeros(nStimTypes, nROIs);
    for iStimType = 1 : nStimTypes;
        for iROI = 1 : nROIs;
            for iStim = 1 : nStims;
                % count this stimulus only if at least 5% of the frames are not nans
                NStims(iStimType, iROI) = NStims(iStimType, iROI) ...
                    + double(nansum(~isnan(PSCaTraces(iStimType, iStim, iROI, :))) > (nPSFrames * 0.05));
            end;
        end;
    end;
    
    % remove stimuli that do not have enough stimulus for averaging in ALL ROIs
    badStims = any(NStims' < this.an.img.nStimsThreshold);
    % get the stimulus IDs to use
    stimIDs = this.an.img.selStimIDs;
    stimIDs = regexprep(reshape(stimIDs, 1, numel(stimIDs)), '_', ' ');
    stimIDs = OCIA_analysis_renameStimIDs(stimIDs);
    badStimsString = regexprep(sprintf('%s, ', stimIDs{badStims}), ', $', '');
    if ~isempty(badStimsString);
        o('#%s: removing stimType(s) %s because they do not have at least %d stim(s) in ALL ROIs.', ...
            mfilename(), badStimsString, this.an.img.nStimsThreshold, 2, this.verb);
    end;
    % remove bad stims
    PSCaTraceMeans(badStims, :, :) = [];
    PSCaTraceErrors(badStims, :, :) = [];
    NStims(badStims, :) = [];
    stimIDs(badStims) = [];
    this.an.img.selStimIDs(badStims) = [];
    % get the size of the dataset
    nStimTypes = size(PSCaTraceMeans, 1);

    % remove ROIs that do not have enough stimulus for averaging
    badROIs = any(NStims < this.an.img.nStimsThreshold);
    badROIsString = regexprep(sprintf('%s,', ROINames{badROIs}), ',$', '');
    if ~isempty(badROIsString);
        o('#%s: removing ROI(s) %s because they do not have at least %d stim(s) in at least one stimulus type.', ...
            mfilename(), badROIsString, this.an.img.nStimsThreshold, 2, this.verb);
    end;
    % remove bad ROIs from ROINames, mean traces and NStims matrix
    ROINames(badROIs) =  []; nROIs = numel(ROINames);
    PSCaTraceMeans(:, badROIs, :) = [];
    PSCaTraceErrors(:, badROIs, :) = [];
    NStims(:, badROIs) = [];

    % if required, normalize by the mean of the baseline frames
    if this.an.img.normBaseline;
        baseFrames = t < 0;
        baseLineMeans = nanmean(PSCaTraceMeans(:, :, baseFrames), 3);
        PSCaTraceMeans = PSCaTraceMeans - repmat(baseLineMeans, [1 1 nPSFrames]);
    end;
    
    %% get responsiveness
    % go trough each stim and each ROI
    ROIRespTrial = nan(nStimTypes, nStims, nROIs); 
    for iStimType = 1 : nStimTypes;
        % get which peri-stimulus period it corresponds to
        PSPerIndex = ceil(iStimType / (nStimTypes / numel(PSPerIDs)));
        for iStim = 1 : nStims;
            for iROI = 1 : nROIs;
                % get the relevant frames
                allFrames = squeeze(PSCaTraces(iStimType, iStim, iROI, :));
                baseFrames = allFrames(baseFramesMask(PSPerIndex, :));
                evokedFrames = allFrames(evokedFramesMask(PSPerIndex, :));

                switch this.an.img.respMethod;
                    case 'mean';
                        ROIRespTrial(iStimType, iStim, iROI) = nanmean(evokedFrames) - nanmean(baseFrames);
                    case 'sum';
                        ROIRespTrial(iStimType, iStim, iROI) = nansum(evokedFrames);
                    case 'max';
                        ROIRespTrial(iStimType, iStim, iROI) = nanmax(evokedFrames) - nanmean(baseFrames);
                    case 'maxAbs';
                        minPeak = nanmin(evokedFrames - nanmean(baseFrames));
                        maxPeak = nanmax(evokedFrames - nanmean(baseFrames));
                        ROIRespTrial(iStimType, iStim, iROI) = iff(abs(minPeak) > abs(maxPeak), minPeak, maxPeak);
                    case '3ppmax';
                        ROIRespTrial(iStimType, iStim, iROI) = nanmean(maxnpp(evokedFrames, 3)) - nanmean(maxnpp(baseFrames, 3));
                    otherwise
                        ANShowHideMessage(this, 1, sprintf('Problem during plotting: unknown responsiveness calculating method: "%s".', ...
                            this.an.img.respMethod));
                end;

    %             % calculate tStat
    %             ROIRespTrial(iStimType, iStim, iROI) = (nanmean(maxnpp(evoked, 3)) - nanmean(maxnpp(base, 3))) ...
    %                 / (0.5 * (nanvar(maxnpp(evoked, 3)) + nanvar(maxnpp(base, 3))));
            end;
        end;
    end;

    %% get response probability
    %{
    ROIRespBinary = ROIRespTrial > 4;
    % calculate response probability for all trials
    ROIRespProb = reshape(nanmean(ROIRespBinary, 2), [nStimTypes, nROIs]);
    %}
    ROIRespProb = [];
    
    %% get reponse timing
    % go trough each stim and each ROI
    ROIRespTime = nan(nStimTypes, nROIs); 
    for iStimType = 1 : nStimTypes;
        % get which peri-stimulus period it corresponds to
        PSPerIndex = ceil(iStimType / (nStimTypes / numel(PSPerIDs)));
        for iROI = 1 : nROIs;
            % get the relevant frames
            allFrames = squeeze(PSCaTraceMeans(iStimType, iROI, :));
            evokedFrames = allFrames;
            evokedFrames(baseFramesMask(PSPerIndex, :)) = NaN;
            % get the peak response of this ROI
            peakEvokedFrames = nanmean(maxnpp(evokedFrames, 3));
            % if the peak reponse is not high enough, discard timing
            if peakEvokedFrames < this.an.img.ROIRespThresh; continue; end;
            % get the mid-peak value
            midPeak = 0.5 * peakEvokedFrames;
            % get the first frame where the mid-peak is exceeded
            midPeakFrame = find(evokedFrames > midPeak, 1, 'first');
            % get the time of that peak value if a non-NaN frame was found
            if ~isnan(midPeakFrame);
                ROIRespTime(iStimType, iROI) = t(midPeakFrame);
            % use NaN if no frame could be found
            else
                ROIRespTime(iStimType, iROI) = NaN;
            end;
        end;
    end;
    
    if ~this.an.img.combineROIs;
        % get the grouping from ROISet number
        ROISetIndexes = cellfun(@(ROIName)str2double(regexprep(regexp(ROIName, 'RS\d+_', 'match'), '[^\d]', '')), ROINames);
        % get the days from the rows and from the ROISet IDs
        allDays = regexprep(unique(get(this, iDWRows, 'day')), '_', '');
        allROISetsDays = regexprep(unique(get(this, iDWRows, 'ROISet')), '_\d+$', '');
        % re-map the grouping using the actual unique days
        for iROISetDay = 1 : numel(allROISetsDays);
            ROISetIndexes(ROISetIndexes == iROISetDay) = find(strcmp(allROISetsDays{iROISetDay}, allDays));    
        end;

        % get the group labels phases
%         uniquePhases = { 'baseline', 'naïve', 'expert', 'lateExpert' };
%         ROIPhases = uniquePhases(ROISetIndexes);
        ROIPhases = allROISetsDays(ROISetIndexes);
        
    else
        
        ROIPhases = {};
        
    end;
    
    % store the variables
    cachedData = struct('PSCaTraceMeans', PSCaTraceMeans, 'PSCaTraceErrors', PSCaTraceErrors, ...
        'ROIRespTrial', ROIRespTrial, 'ROIRespProb', ROIRespProb, 'ROIRespTime', ROIRespTime, 't', t, 'NStims', NStims, ...
        'dataType', 'selectedPSCaTracesStats', 'ROINames', { ROINames }, 'ROIPhases', { ROIPhases }, 'params', hashStruct);
    % store the data in memory
    ANStoreCachedData(this, 'img', hashStruct, cachedData);
    
    %{
    
% if data was in memory but in separate parts, fetch it
elseif iscell(cachedData);
    
    % extract the data from the first element
    PSCaTraceMeans = cachedData{1}.PSCaTraceMeans;
    PSCaTraceErrors = cachedData{1}.PSCaTraceErrors;
    ROIRespTrial = cachedData{1}.ROIRespTrial;
    ROIRespProb = cachedData{1}.ROIRespProb;
    ROIRespTime = cachedData{1}.ROIRespTime;
    ROINames = cachedData{1}.ROINames;
    NStims = cachedData{1}.NStims;
    
    % concatenate with the data of the other elements
    for iCache = 2 : numel(cachedData);
        
        % concatenate the calcium traces: get the size of things
        cacheAllCaTraces = cachedData{iCache}.allCaTraces;
        cacheAllExclMask = cachedData{iCache}.allExclMask;
        cacheAllStims = cachedData{iCache}.allStims;
        [nRowsCurr, nROIsCurr, nFramesCurr] = size(allCaTraces);
        [nRowsCache, nROIsCache, nFramesCache] = size(cacheAllCaTraces);
        % if there is a dimension mismatch, extend with nans
        if nFramesCurr > nFramesCache;
            cacheAllCaTraces = cat(3, cacheAllCaTraces, nan(nRowsCache, nROIsCache, nFramesCurr - nFramesCache));
            cacheAllExclMask = cat(3, cacheAllExclMask, nan(nRowsCache, nROIsCache, nFramesCurr - nFramesCache));
            cacheAllStims = cat(2, cacheAllStims, nan(nRowsCache, nFramesCurr - nFramesCache));
        % if there is a dimension mismatch, extend with nans
        elseif nFramesCurr < nFramesCache;
            allCaTraces = cat(3, allCaTraces, nan(nRowsCurr, nROIsCurr, nFramesCache - nFramesCurr));
            allExclMask = cat(3, allExclMask, nan(nRowsCurr, nROIsCurr, nFramesCache - nFramesCurr));
            allStims = cat(2, allStims, nan(nRowsCurr, nFramesCache - nFramesCurr));
        end;
        
        % if there is a ROI number mismatch
        if nROIsCurr ~= nROIsCache;
            
        end;
        
        % concatenate the traces
        allCaTraces = cat(1, allCaTraces, cacheAllCaTraces);
        allExclMask = cat(1, allExclMask, cacheAllExclMask);
        allStims = cat(1, allStims, cacheAllStims);
        allStimsTypesCell = cat(1, allStimsTypesCell, cachedData{iCache}.allStimsTypesCell);
        
    end;
    
    % fetch the data
    PSCaTraceMeans = cachedData.PSCaTraceMeans;
    PSCaTraceErrors = cachedData.PSCaTraceErrors;
    ROIRespTrial = cachedData.ROIRespTrial;
    ROIRespProb = cachedData.ROIRespProb;
    ROIRespTime = cachedData.ROIRespTime;
    ROINames = cachedData.ROINames;
    NStims = cachedData.NStims;
    
    % get the size of the dataset
    [nStimTypes, nROIs, ~] = size(PSCaTraceMeans);
    % if averaging the ROIs together is requested
    if this.an.img.averageROI;
        nROIs = 1;
    end;
    
    %}
    
    
% if data was directly in memory, fetch it
else
    
    % fetch the data
    PSCaTraceMeans = cachedData.PSCaTraceMeans;
    PSCaTraceErrors = cachedData.PSCaTraceErrors;
    ROIRespTrial = cachedData.ROIRespTrial;
    ROIRespProb = cachedData.ROIRespProb;
    ROIRespTime = cachedData.ROIRespTime;
    ROINames = cachedData.ROINames;
    NStims = cachedData.NStims;
    
    % get the size of the dataset
    [nStimTypes, nROIs, ~] = size(PSCaTraceMeans);
    % if averaging the ROIs together is requested
    if this.an.img.averageROI;
        nROIs = 1;
    end;
    
end;

%% update the analysis parameters
% set the stimulus selection in the param. config to be displayed
this.GUI.an.paramPanConfig{'sortStim', 'valueType'} = { stimIDs };

%% sort
% get the sorting parameters
sortMethod = this.an.img.sortMethod;
sortDirection = iff(strcmp(this.an.img.sortDirection, 'ascending'), -1, 1);
% make sure we have a sorting stimulus
sortStimIndex = find(strcmp(stimIDs, this.an.img.sortStim));
if isempty(sortStimIndex) || sortStimIndex(1) == 0;
    sortStimIndex = 1;
    this.an.img.sortStim = stimIDs{1};
end;
    
% if sorting is required
if ~isempty(this.an.img.sortMethod) && ~strcmp(this.an.img.sortMethod, 'none');
    sortTic = tic; % for performance timing purposes

    % get which peri-stimulus period it corresponds to
    PSPerIndex = ceil(sortStimIndex / (nStimTypes / numel(PSPerIDs)));
    % get the evoked evoked activity for the sorting stimulus
    sortStimEvokedPSCaTraceMeans = reshape(PSCaTraceMeans(sortStimIndex, :, evokedFramesMask(PSPerIndex, :)), [nROIs, nEvFrames(PSPerIndex, :)]);
    sortStimBasePSCaTraceMeans = reshape(PSCaTraceMeans(sortStimIndex, :, baseFramesMask(PSPerIndex, :)), [nROIs, nBaseFrames(PSPerIndex, :)]);

    % get sorted values with the specified method on the specified stimulus
    if strcmp(sortMethod, 'mean');
        sortValues = nanmean(sortStimEvokedPSCaTraceMeans, 2);
    elseif strcmp(sortMethod, 'mean_evoked');
        sortValues = nanmean(sortStimEvokedPSCaTraceMeans, 2) - nanmean(sortStimBasePSCaTraceMeans, 2);
    elseif strcmp(sortMethod, 'max');
        sortValues = max(sortStimEvokedPSCaTraceMeans, [], 2);
    elseif strcmp(sortMethod, 'max_evoked');
        sortValues = max(sortStimEvokedPSCaTraceMeans, [], 2) - max(sortStimBasePSCaTraceMeans, [], 2);
    else
        sortValues = [];
    end;

    % if there is something to sort
    if ~isempty(sortValues);
        [~, sortIndexes] = sort(sortDirection * sortValues);
        % apply the sorting
        PSCaTraceMeans = PSCaTraceMeans(:, sortIndexes, :);
        PSCaTraceErrors = PSCaTraceErrors(:, sortIndexes, :);
        ROINames = ROINames(sortIndexes);
        NStims = NStims(:, sortIndexes);
        ROIRespTrial = ROIRespTrial(:, :, sortIndexes);
    end;
    o('#%s: sorting done (%3.1f sec).', mfilename(), toc(sortTic), 2, this.verb);
end;
    

PSCaTracesStats.PSCaTraceMeans = PSCaTraceMeans;
PSCaTracesStats.PSCaTraceErrors = PSCaTraceErrors;
PSCaTracesStats.ROIRespTrial = ROIRespTrial;
PSCaTracesStats.ROIRespProb = ROIRespProb;
PSCaTracesStats.NStims = NStims;
PSCaTracesStats.ROIRespTime = ROIRespTime;

o('#%s: done (%3.1f sec).', mfilename(), toc(totalTic), 2, this.verb);
    

end