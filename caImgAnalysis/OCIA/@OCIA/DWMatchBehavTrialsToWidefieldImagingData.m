function DWMatchBehavTrialsToWidefieldImagingData(this)
% DWMatchBehavTrialsToWidefieldImagingData - [no description]
%
%       DWMatchBehavTrialsToWidefieldImagingData(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
% match the behavior trials and the data files

showMessage(this, 'Annotating table for widefield ...');

% update the wait bar
DWWaitBar(this, 0); 
    
% try to find the notebook file
behavRowPath = get(this, 1, 'path', DWFilterTable(this, 'rowType = Behavior data'));
trialNotebookData = {};
if ~isempty(behavRowPath);
    trialNotebookFilePath = regexprep(behavRowPath, '/behav/\w+\.mat', '/widefield_labview/trial_notebook.xlsx');
    if exist(trialNotebookFilePath, 'file');
        rawTrialAnnotateData = xlsread(trialNotebookFilePath, 1);
        
%         [~, rawSessionIDs] = xlsread(trialNotebookFilePath, 'B2:XX2');
%         rawSessionIDs = unique(rawSessionIDs);
%         rawSessionIDs(cellfun(@isempty, rawSessionIDs)) = [];
        
        nSessInXLS = (size(rawTrialAnnotateData, 2) - 7) / 6;
        if nSessInXLS - round(nSessInXLS) <= eps;
            trialNotebookData = cell(1, nSessInXLS);
            for iSess = 1 : nSessInXLS;
                trialNotebookData{iSess} = rawTrialAnnotateData(:, (4 + (iSess - 1) * 6) : (6 + (iSess - 1) * 6));
            end;
        end;
    end;
end;
    
showMessage(this, 'Loading behavior rows ...');
% get the behavior rows with no animal ID and figure it out from the data structure
behavRows = DWFilterTable(this, 'animal !~= \w+ AND rowType = Behavior data');
for iBehavRow = 1 : size(behavRows, 1);
    % get the DataWatcher table's row index for this row
    iDWRow = str2double(get(this, iBehavRow, 'rowNum', behavRows));
    % load the row
    DWLoadRow(this, iDWRow, 'full');
    % get the behavior data
    behavData = getData(this, iDWRow, 'behav', 'data');
    % set the new animal ID
    set(this, iDWRow, 'animal', regexprep(['mou_bl_', behavData.animalID], 'mou_bl_mou_bl', 'mou_bl'));
end;

showMessage(this, 'Getting lists ...');
% get the list of all animals
uniqueAnimals = get(this, 'animal');
if ~iscell(uniqueAnimals) && ischar(uniqueAnimals) && ~isempty(uniqueAnimals); uniqueAnimals = { uniqueAnimals }; end;
uniqueAnimals(cellfun(@isempty, uniqueAnimals)) = { '' };
uniqueAnimals = unique(uniqueAnimals);

% get the list of all days
uniqueDays = get(this, 'day');
if ~iscell(uniqueDays) && ischar(uniqueDays) && ~isempty(uniqueDays); uniqueDays = { uniqueDays }; end;
uniqueDays(cellfun(@isempty, uniqueDays)) = [];
uniqueDays = unique(uniqueDays);

% get the selected animal IDs
selectedAnimalIDs = this.dw.animalIDs(get(this.GUI.handles.dw.filt.animalID, 'Value'));
% if the dash '-' is selected, select all IDs
if numel(selectedAnimalIDs) == 1 && strcmp(selectedAnimalIDs{1}, '-');
    selectedAnimalIDs = uniqueAnimals;
end;

% get the selected day IDs
selectedDayIDs = this.dw.dayIDs(get(this.GUI.handles.dw.filt.dayID, 'Value'));
% if the dash '-' is selected, select all IDs
if numel(selectedDayIDs) == 1 && strcmp(selectedDayIDs{1}, '-');
    selectedDayIDs = uniqueDays;
end;

% go through each animal
iWaitBar = 0;
for iAnim = 1 : numel(uniqueAnimals);    
    animalID = uniqueAnimals{iAnim}; % get the current animal

    % skip irrelevant animal IDs
    if ~ismember(animalID, selectedAnimalIDs); continue; end;
    showMessage(this, sprintf('Processing "%s" ...', animalID));
    
    % go through each day
    for iDay = 1 : numel(uniqueDays);    
        dayID = uniqueDays{iDay}; % get the current day

        % skip irrelevant days
        if ~ismember(dayID, selectedDayIDs); continue; end;

        showMessage(this, sprintf('Processing "%s/%s" ...', animalID, dayID));
        % create animal filter
        if isempty(animalID);
            animalFilter = 'animal !~= \w AND ';
        else
            animalFilter = sprintf('animal = %s AND ', animalID);
        end;
            
        % get the behavior infos
        showMessage(this, sprintf('Processing "%s/%s": getting behavior infos ...', animalID, dayID));
        behavRows = DWFilterTable(this, sprintf('%sday = %s AND rowType = Behavior data', ...
            animalFilter, dayID));
        if isempty(behavRows); continue; end;
        nBehav = size(behavRows, 1);
        behavRowsNums = str2double(get(this, 'all', 'rowNum', behavRows));
        behavRowTime = regexprep(get(this, 'all', 'time', behavRows), '_', '');
        behavRowTimeUNIX = round(dn2unix(datenum(behavRowTime, 'HHMMSS')) / 1000);
        
        behavNTrials = zeros(numel(behavRowsNums), 1);
        for iRow = 1 : numel(behavRowsNums);
            DWLoadRow(this, behavRowsNums(iRow), 'full');
            behavData = getData(this, behavRowsNums(iRow), 'behav', 'data');
            behavNTrials(iRow) = find(~isnan(behavData.times.end) & ~isnan(behavData.resps), 1, 'last');
        end;
        
        % get session rows
        showMessage(this, sprintf('Processing "%s/%s": getting session infos ...', animalID, dayID));
        sessionTime = get(this, 'all', 'wfLVSess', DWFilterTable(this, ...
            sprintf('%sday = %s AND rowType = WF trial', animalFilter, dayID)));
        
        % if trials have been found
        if ~isempty(sessionTime);
            
            % define thresholds for matchs
            timeDiffThresh = 10 * 60; % 10 minutes difference
            nTrialsDiffThresh = 3;
        
        % if no trials, try to see if a session row exists
        else
            sessionTime = get(this, 'all', 'wfLVSess', DWFilterTable(this, ...
                sprintf('%sday = %s AND rowType = WFLV session', animalFilter, dayID)));
            % if no session row, abort
            if isempty(sessionTime); continue; end;
            
            % otherwise go on as session row
            if ischar(sessionTime); sessionTime = { sessionTime }; end;
            
            % define thresholds for matchs
            timeDiffThresh = 10 * 60; % 10 minutes difference
            nTrialsDiffThresh = Inf;
        end;
        
        % get times and trials
        sessionTime(cellfun(@isempty, sessionTime)) = [];
        sessionTime = unique(sessionTime);
        nSess = numel(sessionTime);
        sessionTimeUNIX = round(dn2unix(datenum(sessionTime, 'HHMMSS')) / 1000);
        sessionNTrials = arrayfun(@(i)size(DWFilterTable(this, ...
            sprintf('%sday = %s AND wfLVSess ~= %s AND rowType = WF trial', ...
            animalFilter, dayID, sessionTime{i})), 1), 1 : numel(sessionTime));
        
        % create a table that scores the matches
        showMessage(this, sprintf('Processing "%s/%s": creating score table ...', animalID, dayID));
        matchScoreTable = zeros(nBehav, nSess, 2);
        for iSess = 1 : nSess;
            for iBehav = 1 : nBehav;
                % assign score for trial difference
                matchScoreTable(iBehav, iSess, 1) = abs(sessionNTrials(iSess) - behavNTrials(iBehav));
                if matchScoreTable(iBehav, iSess, 1) > nTrialsDiffThresh;
                    matchScoreTable(iBehav, iSess, 1) = Inf;
                end;
                % assign score for time difference
                matchScoreTable(iBehav, iSess, 2) = abs(sessionTimeUNIX(iSess) - behavRowTimeUNIX(iBehav));
                if matchScoreTable(iBehav, iSess, 2) > timeDiffThresh;
                    matchScoreTable(iBehav, iSess, 2) = Inf;
                end;
            end;
        end;
        
        % for each session find the best behavior file and assign the session ID to the behavior file
        showMessage(this, sprintf('Processing "%s/%s": processing %d session(s) ...', animalID, dayID, nSess));
        for iSess = 1 : nSess;
            
            % find best behavior as the one with minimum score
            sessID = sessionTime{iSess};
            if strcmp(sessID, 'reference'); continue; end;
            
            [~, iBestBehav] = min(sum(matchScoreTable(:, iSess, :), 3));
            % check trial differences
            nTrialsDiff = abs(sessionNTrials(iSess) - behavNTrials(iBestBehav));
            if nTrialsDiff > 0;
                showWarning(this, sprintf('OCIA:%s:NTrialsMismatch', mfilename()), sprintf( ...
                    '"%s/%s/%s": found %d imaging trial(s) and %d behavior trial(s).', ...
                    animalID, dayID, sessID, sessionNTrials(iSess), ...
                    behavNTrials(iBestBehav)));
            end;
            
            % label session rows with behavior ID
            showMessage(this, sprintf('Processing "%s/%s/%s": labeling with behavID ...', animalID, dayID, sessID));
            sessionRowNums = str2double(get(this, 'all', 'rowNum', DWFilterTable(this, ...
                sprintf('%sday = %s AND wfLVSess ~= %s', ...
                animalFilter, dayID, sessID))));
            bestBehavRowDayTime = regexprep(get(this, iBestBehav, { 'day', 'time' }, behavRows), '_', '');
            set(this, sessionRowNums, 'behav', sprintf('%s_%s', bestBehavRowDayTime{:}));
            
            % get trial row numbers
            sessTrialRowNums = str2double(get(this, 'all', 'rowNum', DWFilterTable(this, ...
                sprintf('%sday = %s AND wfLVSess ~= %s AND rowType = WF trial', ...
                animalFilter, dayID, sessID))));
            
            % try to find the behavior vectors file
            if ~isempty(sessTrialRowNums) && ~any(isnan(sessTrialRowNums));
                pathOfFirstTrial = get(this, sessTrialRowNums(1), 'path');
                behavVectorFilePath = regexprep(pathOfFirstTrial, '/[^/]+$', '/behaviorVectors.mat');
                if exist(behavVectorFilePath, 'file');
                    
                    showWarning(this, sprintf('OCIA:%s:BehaviorVectors', mfilename()), sprintf( ...
                        '"%s/%s/%s": here would be the place to process the behavior vectors because they exist.', ...
                        animalID, dayID, sessID));
                    
                end;
            end;
            
            % label trials with behavior infos
            showMessage(this, sprintf('Processing "%s/%s/%s": labeling trials with behavior infos ...', animalID, ...
                dayID, sessID));
            % get behavior data for session
            behavData = getData(this, behavRowsNums(iBestBehav), 'behav', 'data');
            nTrials = min(sessionNTrials(iSess), behavNTrials(iBestBehav));
            for iTrial = 1 : nTrials                
                % gather some information about the behavior
                stimLabels = regexp(sprintf('%.0f kHz:', behavData.config.tone.freqs / 1000), ':', 'split');
                behavInfo = sprintf('[ %s', stimLabels{behavData.stims(iTrial)});
                if ~isnan(behavData.respTypes(iTrial));        
                    if behavData.respTypes(iTrial) == 1 && ~behavData.autoRewardGiven(iTrial);
                        behavInfo = sprintf('%s / hit', behavInfo);
                    elseif behavData.respTypes(iTrial) == 1 && behavData.autoRewardGiven(iTrial);
                        behavInfo = sprintf('%s / auto', behavInfo);
                    elseif behavData.respTypes(iTrial) == 2;
                        behavInfo = sprintf('%s / CR ', behavInfo);
                    elseif behavData.respTypes(iTrial) == 3;
                        behavInfo = sprintf('%s / FA ', behavInfo);
                    elseif behavData.respTypes(iTrial) == 4;
                        behavInfo = sprintf('%s / miss', behavInfo);
                    elseif behavData.respTypes(iTrial) == 5;
                        behavInfo = sprintf('%s / early', behavInfo);
                    else
                        behavInfo = sprintf('%s / unknown', behavInfo);
                    end; 
                end;
                % annotate with trial notebook data
                iRealSess = str2double(regexprep(this.dw.wfLVSessIDs{strcmp(sessionTime(iSess), ...
                    regexprep(this.dw.wfLVSessIDs, 'session\d+_', ''))}, '^session(\d+)_.+$', '$1'));
                if ~isempty(iRealSess) && ~isnan(iRealSess) && numel(trialNotebookData) >= iRealSess ...
                        && size(trialNotebookData{iRealSess}, 1) >= iTrial;
                    notebookRowForTrial = trialNotebookData{iRealSess}(iTrial, :);
                    % quiet trial
                    if ~isnan(notebookRowForTrial(1));
                        behavInfo = sprintf('%s / quiet', behavInfo);
                        
                    % move before trial
                    elseif ~isnan(notebookRowForTrial(2));
                        behavInfo = sprintf('%s / moveBef', behavInfo);
                        
                    % move trial
                    elseif ~isnan(notebookRowForTrial(3));
                        behavInfo = sprintf('%s / moveDur', behavInfo);
                    end;
                end;
                
                % close the information section
                behavInfo = sprintf('%s ]', behavInfo);
                set(this, sessTrialRowNums(iTrial), 'comments', behavInfo);                
            end;
        
            % label behavior row with session ID
            set(this, behavRowsNums(iBestBehav), 'wfLVSess', sessID);
            sessRunNum = get(this, 'all', 'runNum', DWFilterTable(this, ...
                    sprintf('%sday = %s AND wfLVSess ~= %s AND rowType = WFLV session', ...
                    animalFilter, dayID, sessID)));
            if ~isempty(sessRunNum) && ~any(isnan(sessRunNum));
                set(this, behavRowsNums(iBestBehav), 'runNum', sessRunNum);
            end;
            
        end;
        
        % extract behavior info
        showMessage(this, sprintf('Processing "%s/%s/%s": extracting behavior data for each trial ...', animalID, ...
            dayID, sessID));
        for iTrial = 1 : nTrials
            behavDataImg = DWExtractBehavDataForImagingRow(this, iTrial, behavData);
            setData(this, sessTrialRowNums(iTrial), 'wfTrBehav', 'data', behavDataImg);
            setData(this, sessTrialRowNums(iTrial), 'wfTrBehav', 'loadStatus', 'full');
        end;
        
        iWaitBar = iWaitBar + 1;
        DWWaitBar(this, 100 * (iWaitBar / (numel(uniqueDays) * numel(uniqueAnimals))));
        
    end; % end of day loop
end; % end of animal loop

DWWaitBar(this, 100);
showMessage(this, 'Matching behavior trials done !');
pause(0.1);

end