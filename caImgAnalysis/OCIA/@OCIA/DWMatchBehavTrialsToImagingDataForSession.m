%% - #DWMatchBehavTrialsToImagingDataForSession
function DWMatchBehavTrialsToImagingDataForSession(this, animalID, dayID, spotID, iSess, rowIndexes, locFilter)

% get the number of imaging trials found
nTrialsFound = size(rowIndexes, 1);

% abort if no trials
if ~nTrialsFound; return; end;

% find the right behavior out file : get the behavior rows
behavRows = DWFilterTable(this, sprintf('animal = %s AND day = %s AND rowType = Behavior data%s', animalID, dayID, ...
    locFilter));
nBehavs = size(behavRows, 1); % count them

% go through all behavior files by comparing behavior trial and data file times
allBehavUNIXTimes = []; % behaviorally recorded times
allBehavBelongInds = []; % behavior file IDs (B01, B02, etc.)
% extract all behavior times from the behavior files
for iBehav = 1 : nBehavs;
    
    % get the DataWatcher table's row index for this row
    iDWRow = str2double(get(this, iBehav, 'rowNum', behavRows));
    
    % make sure behavior data is loaded
    DWLoadRow(this, iDWRow, 'full');
    % get the output structure
    behavData = getData(this, iDWRow, 'behav', 'data');
    
    % skip empty structures
    if isempty(behavData); continue; end;
    
    % find the end timing name (backward compatibility)
    fieldName = 'endImagExp';
    if ~isfield(behavData.times, fieldName);
        fieldName = 'endImagExpect';
    end;
    if ~isfield(behavData.times, fieldName);
        fieldName = 'imgStopExp';
    end;
    
    if ~isfield(behavData.times, fieldName);
        showWarning(this, 'OCIA:DW:DWMatchBehavTrialsToImagingDataForSession:NoEndImagingFieldName', ...
            sprintf('Cannot find an imaging end time field for row %03d: %s.', iDWRow, DWGetRowID(this, iDWRow)));
        continue;
    end;
    
    % extract the behavior UNIX times
    behavUNIXTimes = (behavData.times.(fieldName) + behavData.times.start) * 1000;
    behavUNIXTimes(behavUNIXTimes == 0) = [];
    % concatenate the times
    allBehavUNIXTimes = [allBehavUNIXTimes behavUNIXTimes]; %#ok<AGROW>
    allBehavBelongInds = [allBehavBelongInds repmat(iBehav, 1, size(behavUNIXTimes, 2))]; %#ok<AGROW>
    
end;

% remove NaN trials because they were not recorded
allBehavBelongInds(isnan(allBehavUNIXTimes)) = [];
allBehavUNIXTimes(isnan(allBehavUNIXTimes)) = [];

% use a time threshold to check for time mismatchs
timeThresh = this.dw.trialMatchingTimeDifferenceThreshold;

% minimum time differences between behavior timestamps and data file timestamps
[allMinTDiffs, allMinTInds] = compareImgFileTimeWithBehavTimes(this, allBehavUNIXTimes, rowIndexes, timeThresh);

% abort if no rows to process
if isempty(allMinTDiffs) || isempty(allMinTInds); return; end;

% best fitting behavior file are the ones with less than 3 hours 
iBestBehav = unique(allBehavBelongInds(allMinTDiffs < 3 * 60 * 60));
nMatchBehavs = size(iBestBehav, 2);
iBestBehavMask = ismember(allBehavBelongInds, iBestBehav);

% abort if no behavior match found
if isempty(iBestBehav); return; end;

% extract the adjusted time differences
minTDiff = abs(allMinTDiffs(iBestBehavMask) - nanmedian(allMinTDiffs(iBestBehavMask)));

% calculate the number of expected trials
nTrialsExp = 0;
for iBehav = 1 : nMatchBehavs;
    % get the DataWatcher table's row index for this row
    iDWRow = str2double(get(this, iBestBehav(iBehav), 'rowNum', behavRows));
    % get the output structure
    behavData = getData(this, iDWRow, 'behav', 'data');
    % count the number of trials that are expected
    nTrialsExp = nTrialsExp + find(~isnan(behavData.times.end) & ~isnan(behavData.resps), 1, 'last');
end;

% calculate the difference in trial numbers
diffTrials = nTrialsExp - nTrialsFound;

% get whether the difference is in missing or extra trials
missExtraInd = []; % indexes of rows that are missing or extra
missExtraLabel = ''; % label specifying whether the trials are missing or extra

% no trial number difference and no timing mismatch => no missmatch
if diffTrials == 0 && ~any(minTDiff > timeThresh);
    % nothing to do
    
% missing/extra trials
elseif diffTrials ~= 0;
    
    % difference is positive => missing trials
    if diffTrials > 0;
        missExtraLabel = 'missing'; % label the mismatch
        % loop to find all missing trials using a stepwise decreasing time threshold
        while size(missExtraInd, 1) < diffTrials;
            missExtraInd = find(minTDiff > timeThresh); % get the missing trials
            timeThresh = timeThresh - 100; % update the threshold
        end;
        
        % get the most different missing trials
        [~, missExtraIndOrdered] = sort(minTDiff(missExtraInd)); % sort by most different timing
        missExtraInd = sort(missExtraInd(missExtraIndOrdered(end - diffTrials + 1 : end)));
        
%         % get the first missing trials
%         missExtraInd = sort(missExtraInd(1 : abs(diffTrials)));
        
    % difference is negative => extra trials
    else
        missExtraLabel = 'extra'; % label the mismatch
        diffTrials = - diffTrials; % invert the sign
        % find the extra trials
        missExtraInd = find(~ismember(1 : nTrialsExp, allMinTInds(iBestBehavMask)), diffTrials);
        % if no extra trials found, try to find them using setdiff
        if isempty(missExtraInd); missExtraInd = setdiff(1 : nTrialsFound, allMinTInds); end;
        % only take the required number of different trials
        missExtraInd = sort(missExtraInd(1 : abs(diffTrials)));
    end;

    % create a list of mismatched indexes
    missList = regexprep(sprintf('%02d ', missExtraInd), ' $', '');
    % if the list is too long, make it shorter: find the space characters
    spaceCharStart = find(missList == ' ', 3, 'first');
    % find the second and before last space character
    if isempty(spaceCharStart);     spaceCharStart = min(8, round(numel(missList) * 0.5));
    else                            spaceCharStart = spaceCharStart(end);
    end;
    spaceCharEnd = find(missList == ' ', 3, 'last');
    if isempty(spaceCharEnd);       spaceCharEnd = max(numel(missList) - 8, round(numel(missList) * 0.5));
    else                            spaceCharEnd = spaceCharEnd(1);
    end;
    if size(missList, 2) > 30; missList = [missList(1 : spaceCharStart) ' ... ' missList(spaceCharEnd : end)]; end;
    % show the warning
    showWarning(this, 'OCIA:DWMatchBehavTrialsToImagingDataForSession:MissingTrials', ...
        sprintf('Found %d %s trial(s) ( %s ) for %s %s %s session %d.', diffTrials, missExtraLabel, ...
        missList, animalID, dayID, spotID, iSess));
end;

% label the stimuli
if strcmp(behavData.taskType, 'cotOdd');
    stimLabels = { 'lowStd ', 'highStd' };
else
    stimLabels = { 'low', 'high' };
end;

% create the annotations for the imaging rows
behavIDs = cell(nTrialsExp, 1);
runTypes = cell(nTrialsExp, 1);
trialNums = cell(nTrialsExp, 1);
spotIDs = cell(nTrialsExp, 1);
behavInfo = cell(nTrialsExp, 1);

% initialize the current behavior data to use for annotation
iBehav = 1;
iDWRowBehav = str2double(get(this, iBestBehav(iBehav), 'rowNum', behavRows)); % get the DW table's row index
behavID = DWGetRowID(this, iDWRowBehav); % get the behavior row's ID
behavData = getData(this, iDWRowBehav, 'behav', 'data'); % get the behavior data
currMaxTrial = find(~isnan(behavData.times.end) & ~isnan(behavData.resps), 1, 'last'); % get the number of trials for this behavior

% loop through all trials
iTrial = 1;
for iTotTrial = 1 : nTrialsExp;    
    % annotate this trial using the behavior's informations
    behavIDs{iTotTrial} = behavID;
    runTypes{iTotTrial} = 'Trial';
    trialNums{iTotTrial} = sprintf('%02d', iTrial);
    spotIDs{iTotTrial} = sprintf('spot%02d', behavData.spotMatrix(iTrial));

    % gather some information about the behavior
    behavInfo{iTotTrial} = sprintf('[ %s', stimLabels{behavData.stims(iTrial)});
    
    % response type
    if ~isnan(behavData.respTypes(iTrial));        
        % target
        if ismember(behavData.respTypes(iTrial), [1 4]);
            behavInfo{iTotTrial} = sprintf('%s / targ', behavInfo{iTotTrial});            
        % distractor
        elseif ismember(behavData.respTypes(iTrial), [2 3]);
            behavInfo{iTotTrial} = sprintf('%s / distr', behavInfo{iTotTrial});
        end;        
        % correct
        if ismember(behavData.respTypes(iTrial), [1 2]);
            behavInfo{iTotTrial} = sprintf('%s / corr', behavInfo{iTotTrial});            
        % wrong
        elseif ismember(behavData.respTypes(iTrial), [3 4]);
            behavInfo{iTotTrial} = sprintf('%s / false', behavInfo{iTotTrial});
        end;        
    end;
    
    % cloud of tones oddball case
    if strcmp(behavData.taskType, 'cotOdd') && numel(behavData.nTones) >= iTrial;
        behavInfo{iTotTrial} = sprintf('%s / %02d tones', behavInfo{iTotTrial}, behavData.nTones(iTrial));
    end;
    
    % close the information section
    behavInfo{iTotTrial} = sprintf('%s ]', behavInfo{iTotTrial});

    % update the trial count
    iTrial = iTrial + 1;
    
    % if we reach the start of a new behavior file
    if iTrial > currMaxTrial && iBehav < nMatchBehavs;
        
        % update the current behavior data to use for annotation
        iTrial = 1;
        iBehav = iBehav + 1;
        iDWRowBehav = str2double(get(this, iBestBehav(iBehav), 'rowNum', behavRows)); % get the DW table's row index
        behavID = DWGetRowID(this, iDWRowBehav); % get the behavior row's ID
        behavData = getData(this, iDWRowBehav, 'behav', 'data'); % get the behavior data
        currMaxTrial = find(~isnan(behavData.times.end) & ~isnan(behavData.resps), 1, 'last'); % get the number of trials for this behavior
    end;
end;

% re-order the rows according to the minimum time indexes
rowIndexes = rowIndexes(allMinTInds(iBestBehavMask));

% remove the annotations for the missing trials
if strcmp(missExtraLabel, 'missing');
    
    behavIDs(missExtraInd) = [];
    runTypes(missExtraInd) = [];
    trialNums(missExtraInd) = [];
    spotIDs(missExtraInd) = [];
    behavInfo(missExtraInd) = [];    
    rowIndexes(missExtraInd) = [];
    
end;

% update in the table
set(this, rowIndexes, 'behav', behavIDs);
set(this, rowIndexes, 'runType', runTypes);
set(this, rowIndexes, 'runNum', trialNums);
set(this, rowIndexes, 'spot', spotIDs);
set(this, rowIndexes, 'comments', behavInfo);

%% extract behavior data to imaging rows and get spot ID for behavior rows
% go through each behavior file and try to get a spot ID annotation for them
for iBehav = 1 : nBehavs;
    % get the DataWatcher table's row index for this row
    iDWRowBehav = str2double(get(this, iBehav, 'rowNum', behavRows)); % get the DW table's row index
    behavID = DWGetRowID(this, iDWRowBehav); % get the behavior row's ID
    
    % get the imaging trial rows that have a matching behavior ID
    trialRows = DWFilterTable(this, sprintf('rowType = Imaging data AND behav = %s AND runNum ~= \\d+', behavID)); 
    
    % skip the process if no imaging rows have this behavior ID
    if isempty(trialRows); continue; end;
    
    % get the behavior data
    behavDataForRow = getData(this, iDWRowBehav, 'behav', 'data');
    
    % go through each trial
    for iTrialLoop = 1 : size(trialRows, 1);
        iTrial = str2double(get(this, iTrialLoop, 'runNum', trialRows)); % get the trial number
        iDWRowTrial = str2double(get(this, iTrialLoop, 'rowNum', trialRows)); % get the row's index
        % extract the behavior data for this trial and store it in the imaging row's data
        setData(this, iDWRowTrial, 'behavExtr', 'data', DWExtractBehavDataForImagingRow(this, iTrial, behavDataForRow));
        setData(this, iDWRowTrial, 'behavExtr', 'loadStatus', 'full');
    end;
    
    % if the behavior file does not have a spot annotation
    if isempty(get(this, iDWRowBehav, 'spot'));
        % create a spot annotation using the one from the frist trial
        set(this, iDWRowBehav, 'spot', get(this, iTrialLoop, 'spot', trialRows));                
    end;
    
end;

end

%% - #compareImgFileTimeWithBehavTimes
function [minTDiffs, minTInds] = compareImgFileTimeWithBehavTimes(this, behavUNIXTimes, DWTableRowInds, timeDiffThresh)

% do not process if no rows
DWTableRowInds(isnan(DWTableRowInds)) = []; % remove nans
if isempty(DWTableRowInds);
    minTDiffs = [];
    minTInds = [];
    return;
end;

nTrialsExp = size(behavUNIXTimes, 2);
nTrialsFound = size(DWTableRowInds, 1);
fileTimes = arrayfun(@(i) dn2unix(datenum(sprintf('%s__%s', get(this, DWTableRowInds(i), 'day'), ...
    get(this, DWTableRowInds(i), 'time')), 'yyyy_mm_dd__HH_MM_SS')), 1 : nTrialsFound);
% nFrames = arrayfun(@(i) str2double(regexprep(get(this, DWTableRowInds(i), 'dim'), '^\d+x\d+x', '')), 1 : nTrialsFound);
% fileTimes = fileTimes(nFrames >= this.an.img.funcMovieNFramesLimit);
minTDiffs = zeros(nTrialsExp, 1);
minTInds = zeros(nTrialsExp, 1);
for iTrial = 1 : nTrialsExp;
    tDiffs = abs(behavUNIXTimes(iTrial) - fileTimes);
    [minTDiffs(iTrial), minTInds(iTrial)] = min(abs(tDiffs));
end;

%% show debug plot if required
if get(this.GUI.handles.dw.SLROpts.procDataShowDebug, 'Value');
    figure('Name', 'Time comparison for trial matching', 'NumberTitle', 'off', 'WindowStyle', 'docked');
    
    % match lines
    lineHandles = plot([fileTimes(minTInds); behavUNIXTimes(1 : nTrialsExp)], ...
        [ones(1, nTrialsExp); 2 * ones(1, nTrialsExp)], 'green');
    hold on;
    
    % imaging files scatter
    filePointHandles = scatter(fileTimes, ones(1, numel(fileTimes)), 10, 's', 'blue', 'fill');
    fileTrialList = regexp(regexprep(sprintf('%d,', 1 : numel(fileTimes)), ',$', ''), ',', 'split');
    behavTrialList = regexp(regexprep(sprintf('%d,', 1 : numel(behavUNIXTimes)), ',$', ''), ',', 'split');
    text(fileTimes, ones(1, numel(fileTimes)) - 0.05, fileTrialList, 'FontSize', 5, ...
        'HorizontalAlignment', 'center');
    
    % extract which are the deviant times
    deviantTimes = find(minTDiffs > timeDiffThresh);

    % time differences
    scaledTDiffs = linScale([0; timeDiffThresh; minTDiffs; max(minTDiffs)], 0, 0.5);
    timeDiffHandle = plot(behavUNIXTimes, scaledTDiffs(3 : end - 1) + 1.25, 'k', 'LineWidth', 1.5);
    plot([behavUNIXTimes(1) - 10E5 behavUNIXTimes(end) + 10E5], repmat(scaledTDiffs(1), 1, 2) + 1.25, ':k', 'LineWidth', 0.5);
    plot([behavUNIXTimes(1) - 10E5 behavUNIXTimes(end) + 10E5], repmat(scaledTDiffs(end), 1, 2) + 1.25, ':k', 'LineWidth', 0.5);
    text(behavUNIXTimes(1) - 10E5, scaledTDiffs(end) + 1.25, sprintf('%.1f', max(minTDiffs)), 'FontSize', 5, ...
        'HorizontalAlignment', 'right');
    text(behavUNIXTimes(1) - 10E5, scaledTDiffs(1) + 1.25, '0.0', 'FontSize', 5, 'HorizontalAlignment', 'right');
    % threshold
    plot([behavUNIXTimes(1) - 10E5 behavUNIXTimes(end) + 10E5], repmat(scaledTDiffs(2), 1, 2) + 1.25, ':r', 'LineWidth', 0.5);
    text(behavUNIXTimes(1) - 10E5, scaledTDiffs(2) + 1.25, sprintf('%.1f', timeDiffThresh), 'FontSize', 5, ...
        'HorizontalAlignment', 'right', 'Color', 'red');
    if ~isempty(deviantTimes);
        deviantTimesHandle = scatter(behavUNIXTimes(deviantTimes), scaledTDiffs(2 + deviantTimes) + 1.25, 65, 'red', ...
            'filled');
    else
        deviantTimesHandle = [];
    end;
    
    
    % behavior trials scatter
    behavPointHandles = scatter(behavUNIXTimes, 2 * ones(1, numel(behavUNIXTimes)), 10, 's', 'red', 'fill');
    text(behavUNIXTimes, 2 * ones(1, numel(behavUNIXTimes)) + 0.05, behavTrialList, 'FontSize', 5, ...
        'HorizontalAlignment', 'center');
    
    ylim([0.8 2.1]);
    if ~isempty(deviantTimesHandle);
        legend([filePointHandles, behavPointHandles, lineHandles(1), timeDiffHandle], ...
            { 'imaging files', 'behavior times', 'potential matches', 'time differences' });
    else
        legend([filePointHandles, behavPointHandles, lineHandles(1), timeDiffHandle, deviantTimesHandle], ...
            { 'imaging files', 'behavior times', 'potential matches', 'time differences', 'deviant time points' });
    end;
    hold off;
    
end;

end