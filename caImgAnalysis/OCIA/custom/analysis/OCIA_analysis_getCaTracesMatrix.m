function [caTraces, stims, ROINames, concatCaTraces, concatStims, allCaTraces, allStimTypeGroups, allROINames, hashStruct] ...
    = OCIA_analysis_getCaTracesMatrix(this, iDWRows, combineROIs)

totalTic = tic; % for performance timing purposes

% initialize variables
caTraces = [];
stims = [];
ROINames = [];
concatCaTraces = [];
concatStims = [];
allCaTraces = [];
allStimTypeGroups = [];
allROINames = [];

%% general plotting parameter UI controls
if ~ismember('selROINames', this.GUI.an.paramPanConfig.id);
        paramConf = cell2table({ ...
...     categ  id                   UIType      valueType               UISize    isLabAbove    label                       tooltip
        'img', 'selROINames',       'list',     { },                    [4 7], true,            'Selected ROIs',            'Select the ROIs to show and use for the current analysis.';
        'img', 'selStimTypeGroups', 'list',     { },                    [2 2], true,            'Selected stimulus types',  'Select the stimulus type to use for the current analysis.';
        'img', 'selStimIDs',        'list',     { },                    [2 2], true,            'Stims',                    'Selection of stimuli.';
        'img', 'allStimIDs',        'text',     { 'cellArray' },        [1 0], false,           'All stim. IDs',            'Stimulus IDs for all the stimulus type as a cell-array.';
        'img', 'sgFiltFrameSize',   'text',     { 'numeric' },          [1 0], false,           'Sav.-Gol. filt.',          'Frame size of the Savitzky-Golay filter for the calcium traces, value must be an odd number.';
        'img', 'noisyTrialsThresh', 'text',     { 'text' },             [1 0], false,           'Noisy thresh.',            'Threshold of standard deviation for the calcium traces to consider a trial to be noisy (default is ''auto'').';
        'img', 'exclFrames',        'dropdown', { 'show', 'mask' }',    [1 0], false,           'Excluded frames',          'Show or mask (hide) the excluded frames (z-motion).';
        'img', 'combineROIs',       'dropdown', { 'true', 'false' }',   [1 0], false,           'Combine ROIs',             'Combine the ROIs from different days or keep them separate.';
        'img', 'gapSize',           'text',     { 'numeric' },          [1 0],   false,         'Gap size',             'Gaps to leave between trials.';

    }, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);
    % append the new configuration to the table and update the row names using the ids
    this.GUI.an.paramPanConfig = [paramConf; this.GUI.an.paramPanConfig];
    this.GUI.an.paramPanConfig.Properties.RowNames = this.GUI.an.paramPanConfig.id;
    
    % adjust the re-organisation of the ROINames depending on the size of their name
    if ~this.an.img.combineROIs;
        this.GUI.an.paramPanConfig{'selROINames', 'UISize'} = [4 2.5];
    end;
end;

%% fetch or extract data
% noisy trial exclusion threshold
if ~isfield(this.an.img, 'noisyTrialsThresh');
    this.an.img.noisyTrialsThresh = 'auto';
end;
% get the data in memory
hashStruct = struct('iDWRows', iDWRows, 'combineROIs', combineROIs, 'noisyTrialsThresh', this.an.img.noisyTrialsThresh, ...
    'exclFrames', this.an.img.exclFrames, 'gapSize', this.an.img.gapSize, 'dataType', 'caTraces');
cachedData = ANGetCachedData(this, 'img', hashStruct);

% if the raw calcium traces matrix is not in cache yet, create it
if isempty(cachedData) || iscell(cachedData);
    
    % get the total number of rows analysed
    nTotRows = numel(iDWRows);
    % get which ROISet each run belongs to, using the ROISet ID stored in the DataWatcher's table
    rowsROISetIDs = get(this, iDWRows, 'ROISet');
    if ~iscell(rowsROISetIDs); rowsROISetIDs = { rowsROISetIDs }; end;

    % get all the unique ROISets for the data set currently analysed
    ANShowHideMessage(this, 1, 'Loading ROISet(s) ...');
    [ROISets, ~, iDWROISetRows] = ANGetROISetForRow(this, iDWRows);
    if iscell(iDWROISetRows); iDWROISetRows = cell2mat(iDWROISetRows); end;
    % get the ROISet IDs
    ROISetRowIDs = DWGetRowID(this, iDWROISetRows);
    if ~iscell(ROISetRowIDs); ROISetRowIDs = { ROISetRowIDs }; end;
    % if first cell is not a cell, it means we have a single ROISet so transform it to a cell-array
    if ~iscell(ROISets{1}); ROISets = { ROISets }; end;
    nROISets = numel(ROISets);
    % extract the number of ROIs for each ROISet
    nROIsForEachROISet = cell2mat(cellfun(@(ROISet) size(ROISet, 1), ROISets, 'UniformOutput', false));
    % get the total number of ROIs
    nTotROIs = sum(nROIsForEachROISet);

    % get the calcium data of all rows as a cell array of matrices
    allCaTracesCell = getData(this, iDWRows, 'caTraces', 'data');
    if ~iscell(allCaTracesCell); allCaTracesCell = { allCaTracesCell }; end;
    % get the number of frames for each row
    nFramesEachRow = arrayfun(@(iRow) size(allCaTracesCell{iRow}, 2), 1 : nTotRows, 'UniformOutput', false);
    % get the maximum number of frames of the currently analysed data set
    nMaxFrames = max(cell2mat(nFramesEachRow));
    % add one extra obligatory NaN frame so that even if all trials/rows have the same number of frames, separations
    %   can be seen on the concatenated data
    nMaxFrames = nMaxFrames + this.an.img.gapSize;
    % get the stimulus vectors and their bit description for the current selection
    allStimsCell = getData(this, iDWRows, 'stim', 'data');
    allStimsTypesCell = getData(this, iDWRows, 'stim', 'stimTypes');
    if ~iscell(allStimsCell) && ~isempty(allStimsCell); allStimsCell = { allStimsCell }; end;
    if ~iscell(allStimsTypesCell) && ~isempty(allStimsTypesCell); allStimsTypesCell = { allStimsTypesCell }; end;
    % hack for soundStart
    if ~isempty(allStimsTypesCell);
        allStimsTypesCell = regexprep(allStimsTypesCell, 'soundStart_', '');
    end;
    
    % get the exclusion masks of all rows as a cell array of matrices
    allExclMaskCell = getData(this, iDWRows, 'exclMask', 'data');
    if ~iscell(allExclMaskCell); allExclMaskCell = { allExclMaskCell }; end;
    
    % get the required memory to do this
    requiredMemory = 8 * (nTotRows * nTotROIs * nMaxFrames) * 2;
    % check whether we have enough memory
    [~, memStatsMore] = memory;
    availMemory = memStatsMore.PhysicalMemory.Available;
    % if not enough memory, abort with a warning
    if availMemory < requiredMemory;
        showWarning(this, 'OCIA:OCIA_analysis_getCaTracesMatrix:NotEnoughMemory', sprintf( ...
            'Not enough memory to store %d rows x %d ROIs x %d frames (required: %.0f MB, available: %.0f MB).', ...
            nTotRows, nTotROIs, nMaxFrames, requiredMemory / 1024 ^ 2, availMemory / 1024 ^ 2));
        ANShowHideMessage(this, 1, 'Not enough memory.');
        return;
    end;

    % (re-)create the raw calcium traces matrix as a nrows x nROIs x nFrames matrix with NaNs where there is no data
    allCaTraces = nan(nTotRows, nTotROIs, nMaxFrames);
    allExclMask = nan(nTotRows, nTotROIs, nMaxFrames);
    allStims = nan(nTotRows, nMaxFrames);

    % get the animal and spot IDs
    animIDsForROISets = get(this, iDWROISetRows, 'animal');
    if ~iscell(animIDsForROISets); animIDsForROISets = { animIDsForROISets }; end;
    animIDsForROISets = regexprep(animIDsForROISets, 'mou_[bd]l_(\d+)_(\d+)', 'A$2');
    spotIDsForROISets = get(this, iDWROISetRows, 'spot');
    if ~iscell(spotIDsForROISets); spotIDsForROISets = { spotIDsForROISets }; end;
    spotIDsForROISets = regexprep(spotIDsForROISets, 'spot(\d+)', 'S$1');
    % if only one unique animal ID, do not bother and use empty cells
    nAnimIDs = numel(unique(animIDsForROISets));
    if nAnimIDs == 1; animIDsForROISets = cell(nROISets, 1); end;
    % if only one unique animal ID, do not bother and use empty cells
    nSpotIDs = numel(unique(spotIDsForROISets));
    if nSpotIDs == 1; spotIDsForROISets = cell(nROISets, 1); end;
    
    % store the ROI names
    allROINames = cell(nTotROIs, 1);
    for iGroup = 1 : nROISets;
        iROIStart = sum(nROIsForEachROISet(1 : iGroup - 1)) + 1; % define the ROI indexing's start
        iROIEnd = iROIStart + nROIsForEachROISet(iGroup) - 1; % define the ROI indexing's end
        % create the list of all ROI names, either with the ROISet's tag or without it
        if combineROIs;
            iGroupStr = '';
        else
            iGroupStr = sprintf('RS%02d', iGroup);
        end;
        allROINames(iROIStart : iROIEnd) = arrayfun(@(iROI) sprintf('%s%s%s_%s', animIDsForROISets{iGroup}, ...
            spotIDsForROISets{iGroup}, iGroupStr, ROISets{iGroup}{iROI, 1}), ...
            1 : size(ROISets{iGroup}, 1), 'UniformOutput', false);
    end;
    
    % remove the starting underscore from the names if there is one
    allROINames = regexprep(allROINames, '^_', '');

    % fill-in the raw calcium traces for each row
    for iRow = 1 : nTotRows;
        iROISetForRow = find(strcmp(rowsROISetIDs{iRow}, ROISetRowIDs)); % get the ROISet index of this row
        iROIStart = sum(nROIsForEachROISet(1 : iROISetForRow - 1)) + 1; % define the ROI indexing's start
        iROIEnd = iROIStart + nROIsForEachROISet(iROISetForRow) - 1; % define the ROI indexing's end
        if size(allCaTracesCell{iRow}, 1) ~= nROIsForEachROISet(iROISetForRow);            
            showWarning(this, 'OCIA:OCIA_analysis_getCaTracesMatrix:BadROISetSize', sprintf( ...
                'ROI number mismatch! From ROISet: %d ROI(s), from calcium data: %d ROI(s).', ...
                nROIsForEachROISet(iROISetForRow), size(allCaTracesCell{iRow}, 1)));
            ANShowHideMessage(this, 1, 'ROI number mismatch !');
            return;
        end;
        % store the raw calcium traces
        allCaTraces(iRow, iROIStart : iROIEnd, 1 : nFramesEachRow{iRow}) = allCaTracesCell{iRow};
        % store the exclusion masks
        if isempty(allExclMaskCell{iRow}); allExclMaskCell{iRow} = ones(size(allCaTracesCell{iRow})); end;
        allExclMask(iRow, iROIStart : iROIEnd, 1 : nFramesEachRow{iRow}) = allExclMaskCell{iRow};
        % store the stimulus vector and the bit description
        if ~isempty(allStimsCell) && ~isempty(allStimsCell{iRow});
%             if numel(allStimsCell{iRow}) == nFramesEachRow{iRow} + 1;
%                 allStims(iRow, 1 : nFramesEachRow{iRow}) = allStimsCell{iRow}(1 : nFramesEachRow{iRow});
%             else
                allStims(iRow, 1 : nFramesEachRow{iRow}) = allStimsCell{iRow};
%             end;
        end;
    end;
    
    % check for noisy ROIs
    stdCaTraces = squeeze(nanstd(allCaTraces, [], 3));
    if strcmp(this.an.img.noisyTrialsThresh, 'auto') || isnan(str2double(this.an.img.noisyTrialsThresh));
        meanStd = nanmean(stdCaTraces(:));
        stdStd = nanstd(stdCaTraces(:));
        noisyStdThresh = meanStd + 2.5 * stdStd;
        o('%s#: automatic noise threshold: mean SD: %.1f, SD of SD: %.1f, mean + 2.5*SD => threshold = %.1f', ...
            mfilename(), meanStd, stdStd, noisyStdThresh, 0, this.verb);
    else
        noisyStdThresh = str2double(this.an.img.noisyTrialsThresh);
        o('#%s: manual noise threshold: threshold = %.1f', mfilename(), noisyStdThresh, 0, this.verb);
    end;
    
    allCaTraces(repmat(stdCaTraces > noisyStdThresh, [1, 1, nMaxFrames])) = NaN;
    showMessage(this, sprintf('Excluded %02d noisy trials(s).', sum(sum(stdCaTraces > noisyStdThresh))), 'yellow');
    for iROI = 1 : nTotROIs;
        noisyTrialsString = regexprep(sprintf('%02d,', find(stdCaTraces(:, iROI) > noisyStdThresh)), ',$', '');
        if isempty(noisyTrialsString); continue; end;
        showMessage(this, sprintf('Excluded noisy trial(s) %s for ROI%s.', ...
            noisyTrialsString, allROINames{iROI}), 'yellow');
    end;

    % get all stimulus types
    [nTotRows, nTotFrames] = size(allStims); %#ok<NASGU>
    allStimTypeGroups = {};
    if ~isempty(allStimsTypesCell);
        for iRow = 1 : nTotRows;
            allStimTypeGroups = unique([allStimTypeGroups regexp(allStimsTypesCell{iRow}, ',', 'split')], 'stable');
        end;
    end;
    
    % store the variables in the cached structure
    cachedData = struct('allCaTraces', allCaTraces, 'allExclMask', allExclMask, 'allStims', allStims, ...
        'allStimsTypesCell', { allStimsTypesCell }, 'allStimTypeGroups', { allStimTypeGroups }, ...
        'allROINames', { allROINames }, 'dataType', 'caTraces', 'params', hashStruct);
    % store the data in memory
    ANStoreCachedData(this, 'img', hashStruct, cachedData);

    %{
    
% if data was in memory but in a separate way, re-combine it
elseif iscell(cachedData);
    
    % extract the data from the first element
    allCaTraces = cachedData{1}.allCaTraces;
    allExclMask = cachedData{1}.allExclMask;
    allStims = cachedData{1}.allStims;
    allStimsTypesCell = cachedData{1}.allStimsTypesCell;
    allROINames = cachedData{1}.allROINames;
    
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
        
    % get all stimulus types
    [nTotRows, nTotFrames] = size(allStims); %#ok<NASGU>
    allStimTypeGroups = {};
    if ~isempty(allStimsTypesCell);
        for iRow = 1 : nTotRows;
            allStimTypeGroups = unique([allStimTypeGroups regexp(allStimsTypesCell{iRow}, ',', 'split')], 'stable');
        end;
    end; 
    
    %}
    
% if data was directly in memory, fetch it
else
    
    % fetch the data
    allCaTraces = cachedData.allCaTraces;
    allExclMask = cachedData.allExclMask;
    allStims = cachedData.allStims;
    allStimsTypesCell = cachedData.allStimsTypesCell;
    allStimTypeGroups = cachedData.allStimTypeGroups;
    allROINames = cachedData.allROINames;

end;

%% prepare data
ANShowHideMessage(this, 1, 'Loading calcium traces ...');
% fetch or extract data from memory
hashStruct.dataType = 'selectedCaTraces';
hashStruct.selStimTypeGroups = this.an.img.selStimTypeGroups;
hashStruct.selStimIDs = this.an.img.selStimIDs;
hashStruct.selROINames = this.an.img.selROINames;
cachedData = ANGetCachedData(this, 'img', hashStruct);

% if the processed calcium trace data is not in cache yet, create it
if isempty(cachedData) || iscell(cachedData);
    
    % get the selected calcium traces, stimulus vectors
    caTraces = allCaTraces;
    exclMask = allExclMask;
    stims = allStims;
    [nRows, nROIs, nFrames] = size(caTraces); %#ok<ASGLU>
    
    if isempty(allStimTypeGroups) || all(isnan(stims(:)));
        
        % create the requested variables
        selStimTypeGroups = { '-' };
        selStimIDs = { '-' };
        allStimTypeIDs = { '-' };
        
    else

        %% get the list of selected stimulus types
        selStimTypeGroups = this.an.img.selStimTypeGroups;
        % get the indexes of the selected stimulus types
        selStimTypeGroupIndex = find(ismember(allStimTypeGroups, selStimTypeGroups));
        % if none selected, select the first one
        if isempty(selStimTypeGroupIndex) && ~isempty(allStimTypeGroups);
            selStimTypeGroupIndex = 1;
            selStimTypeGroups = allStimTypeGroups(selStimTypeGroupIndex);
        end;

        % get the number of bits to use for all the selected stimuli
        nStimTypeGroups = numel(selStimTypeGroupIndex);
        % get the number of non-empty stimulus IDs for each group
        nStimIDsPerGroup = arrayfun(@(iGroup)sum(~cellfun(@isempty, ...
            this.an.img.allStimIDs(selStimTypeGroupIndex(iGroup), :))), 1 : nStimTypeGroups);
        % get the number of possible combinations with all stimulus IDs
        nStimIDCombinations = prod(nStimIDsPerGroup);

        % create the stimulus sets to get all combinations
        stimSets = cell(nStimTypeGroups, 1);
        for iGroup = 1 : nStimTypeGroups;
            stimSets{iGroup} = this.an.img.allStimIDs(selStimTypeGroupIndex(iGroup), :);
            stimSets{iGroup}(cellfun(@isempty, stimSets{iGroup})) = []; % remove empty stims
        end;

        % get all combinations
        allCombinations = allcomb(stimSets{:});
        allStimTypeIDs = cell(nStimIDCombinations, 1);
        % join them in a single string
        for iComb = 1 : nStimIDCombinations;
            allStimTypeIDs{iComb} = regexprep(sprintf('%s_', allCombinations{iComb, :}), '_$', '');
        end;

        % adapt the stimulus vector
        for iRow = 1 : nRows;

            % get the stimulus vector indices for this row
            stimIndices = find(stims(iRow, :) > 0);
            % get the stimulus vector indices for this row
            stimValues = stims(iRow, stimIndices);
            % reset the stimulus vector
            stims(iRow, stimIndices) = 0;

            % get the stimulus types for this row
            stimTypesForRow = regexp(allStimsTypesCell{iRow}, ',', 'split');
            % if this row has no stimulus type matching with the selected ones, skip
            if ~any(ismember(selStimTypeGroups, stimTypesForRow)); continue; end;

            % go through each stimulus
            for iStim = 1 : numel(stimIndices);

                % get which stimulus types are true for this stimulus
                stimTypesForStim = '';

                % go through all the selected stimulus types
                for iSelStimType = 1 : numel(selStimTypeGroupIndex);
                    % store the value extracted from the bits for this stimulus type
                    stimBitValue = 0;
                    % check which index of the row's stimTypes the current selected stim type is
                    stimTypeIndexInRowStimTypes = find(strcmp(selStimTypeGroups(iSelStimType), stimTypesForRow));
                    % if it is in the row (index not 0)
                    if ~isempty(stimTypeIndexInRowStimTypes);
                        % mark the stimulus with the decoded number from the appropriate bits
                        bitCode = bitget(stimValues(iStim), stimTypeIndexInRowStimTypes);
                        for iBitLoop = 1 : numel(bitCode);
                            stimBitValue = bitset(stimBitValue, iBitLoop, bitCode(iBitLoop));
                        end;
                        % if only one bit was used for the current stimulus type, do a binary encoding
                        if numel(stimSets{iSelStimType}) == 2;
                            % mark the stimuli with either 1 or 2 instead of 0 or 1
                            stimBitValue = stimBitValue + 1;
                            % invert the stimulus coding 1 becomes 2 and 2 becomes 1
                            stimBitValue = iff(stimBitValue == 1, 2, 1);                        
                        end;
                        % if the current bit value is not 0 (stimulus not encoded for this stimulus)
                        if stimBitValue;
                            % add the current stimulus type to the list for this stimulus:
                            % no stim name available
                            if numel(stimSets{iSelStimType}) < stimBitValue;
                                stimTypesForStim = regexprep(sprintf('%s_UNKNOWN', stimTypesForStim), '^_', '');
                            % stim name available
                            else
                                stimTypesForStim = regexprep(sprintf('%s_%s', stimTypesForStim, ...
                                    stimSets{iSelStimType}{stimBitValue}), '^_', '');
                            end;
                        end;
                    end;
                end;

                % get the index of this stimulus based on the stimulus types it had
                stimValue = find(strcmp(stimTypesForStim, allStimTypeIDs));
                if isempty(stimValue);
                    stims(iRow, stimIndices(iStim)) = 0;
                else
                    stims(iRow, stimIndices(iStim)) = stimValue(1);
                end;

            end;
        end;

        % check whether we only have one type of stimulus
        uniqueStimIndexes = unique(stims(:));
        uniqueStimIndexes(isnan(uniqueStimIndexes) | uniqueStimIndexes == 0) = [];
        allStimTypeIDs = allStimTypeIDs(uniqueStimIndexes);

        % get the selected stimulus IDs
        selStimIDs = this.an.img.selStimIDs;    
        % remove the selected stimulus IDs that are not part of the current set of stimulus IDs (allStimTypeIDs)
        selStimIDs(~ismember(selStimIDs, allStimTypeIDs)) = [];
        % if no stimulus ID selected, select them all
        if isempty(selStimIDs); selStimIDs = allStimTypeIDs; end;

        % remove non-selected stimuli: find the non-selected stimulus IDs
        toRemoveStimIndexes = uniqueStimIndexes(~ismember(allStimTypeIDs, selStimIDs));
        for iStimToRemove = 1 : numel(toRemoveStimIndexes);
            stims(stims == toRemoveStimIndexes(iStimToRemove)) = 0;
        end;

        % re-map the stimulus indexes
        uniqueStimIndexes = unique(stims);
        uniqueStimIndexes(isnan(uniqueStimIndexes) | uniqueStimIndexes == 0) = [];
        oldStims = stims;
        for iStim = 1 : numel(uniqueStimIndexes);
            stims(oldStims == uniqueStimIndexes(iStim)) = iStim;
        end;
    
    end;

    %% get the list of selected ROIs
    ROINames = this.an.img.selROINames;
    % get the indexes of the selected ROIs
    selROIs = find(ismember(allROINames, ROINames));
    % if none selected, select all of them
    if isempty(selROIs);
        selROIs = 1 : numel(allROINames);
    end;

    % exclude the ROIs that have no data
    emptyROIs = false(numel(selROIs), 1);
    for iSelROI = 1 : numel(emptyROIs);
        caTracesForROI = caTraces(:, selROIs(iSelROI), :);
        emptyROIs(iSelROI) = ~any(~isnan(caTracesForROI(:)));
    end;
    selROIs(emptyROIs) = [];

    % get the selected calcium traces and ROIs
    caTraces = caTraces(:, selROIs, :);
    exclMask = exclMask(:, selROIs, :);
    ROINames = allROINames(selROIs);

    % apply masking of excluded frames if required
    if strcmp(this.an.img.exclFrames, 'mask');
        caTraces = caTraces .* exclMask;
    end;

    % get the indexing of the ROIs as unique names
    if nRows > 1 && combineROIs;
        
        % get the correspondance between the list of ROI names and the unique list
        [~, ROIMatchIndex] = ismember(allROINames(selROIs), unique(allROINames(selROIs)));
        
        % combine ROIs into a new matrix:
        caTracesAll = caTraces;
        caTraces = nan(nRows, numel(unique(ROIMatchIndex)), nFrames);
        % go through each row and assign its ROIs to the right place in the matrix
        for iRow = 1 : nRows;
            % go through each ROI
            for iROI = 1 : numel(ROIMatchIndex);
                % if there is some data for this row for this ROI, use it
                if sum(~isnan(caTracesAll(iRow, iROI, :)));
                    % if there was some data already in this place, show a warning
                    if sum(~isnan(caTraces(iRow, ROIMatchIndex(iROI), :)));
                        o('#%s: overwriting data for row %d, ROI%s !', mfilename(), iRow, ROINames(iROI), 1, this.verb);
                    end;
                    % place the data in the right row and right ROI position
                    caTraces(iRow, ROIMatchIndex(iROI), :) = caTracesAll(iRow, iROI, :);
                end;
            end;
        end;
        ROINames = unique(ROINames);
        
    end;

    %% concatenate the data by putting together all runs:
    [nRows, nROIs, nFrames] = size(caTraces);
    nConcatFrames = nFrames * nRows; % total number of frames in the concatenated data
    % concatenate all the calcium traces and the stimulus vectors in a single vector
    concatCaTraces = nan(nROIs, nConcatFrames);
    concatStims = nan(1, nConcatFrames);
    for iRow = 1 : nRows;
        for iROI = 1 : nROIs;
            concatCaTraces(iROI, (iRow - 1) * nFrames + 1 : iRow * nFrames) = caTraces(iRow, iROI, :);
        end;
        concatStims(1, (iRow - 1) * nFrames + 1 : iRow * nFrames) = stims(iRow, :);
    end;
    
    % store the variables in the cached structure
    cachedData = struct('caTraces', caTraces, 'stims', stims, 'ROINames', { ROINames }, 'concatCaTraces', concatCaTraces, ...
        'concatStims', concatStims, 'selStimIDs', { selStimIDs }, 'selStimTypeGroups', { selStimTypeGroups }, ...
        'allStimTypeIDs', { allStimTypeIDs }, 'dataType', 'selectedCaTraces', 'params', hashStruct);
    % store the data in memory
    ANStoreCachedData(this, 'img', hashStruct, cachedData);

% if data was in memory, fetch it
else
    
    % fetch the data
    caTraces = cachedData.caTraces;
    stims = cachedData.stims;
    ROINames = cachedData.ROINames;
    concatCaTraces = cachedData.concatCaTraces;
    concatStims = cachedData.concatStims;
    selStimTypeGroups = cachedData.selStimTypeGroups;
    allStimTypeIDs = cachedData.allStimTypeIDs;
    selStimIDs = cachedData.selStimIDs;
    
end;
    
% set back the ROINames and stim types in the selection
this.an.img.selROINames = ROINames;
this.an.img.selStimTypeGroups = selStimTypeGroups;
this.an.img.selStimIDs = selStimIDs;

%% update the analysis parameters
% set the stimulus selection in the param. config to be displayed
this.GUI.an.paramPanConfig{'selStimIDs', 'valueType'} = { allStimTypeIDs };
% set the stimulus types in the param. config to be displayed
this.GUI.an.paramPanConfig{'selStimTypeGroups', 'valueType'} = { allStimTypeGroups };
% set the ROINames in the param. config to be displayed
this.GUI.an.paramPanConfig{'selROINames', 'valueType'} = { unique(allROINames) };

o('#%s done (%3.1f sec).', mfilename(), toc(totalTic), 2, this.verb);

end