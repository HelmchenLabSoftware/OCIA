function OCIA_startFunction_widefieldRenameTrialsForEachCondition(this)
% OCIA_startFunction_widefieldRenameTrialsForEachCondition - [no description]
%
%       OCIA_startFunction_widefieldRenameTrialsForEachCondition(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
    
    iStartID = 31; % 2016_04_28
%     iStartID = 22; % 2016_03_18
    iExcl = [];
    iEndID = Inf;
    iTrialStart = 1;
    iTrialEnd = Inf;
    % define trial types
    trialTypesRegexp = { 'hit', 'CR' };
    trialTypeSaveName = { 'hit', 'CR' };

    %% get all behavior data
    OCIAChangeMode(this, 'DataWatcher');
    
    % get the DataWatcher's and the Analyser's GUI handles
    dwh = this.GUI.handles.dw;
    
    % set the watch types
    set(dwh.watchTypes.animal,      'Value', 1);
    set(dwh.watchTypes.day,         'Value', 1);
    set(dwh.watchTypes.wfLV,        'Value', 1);
    set(dwh.watchTypes.wfLVSess,    'Value', 1);
    set(dwh.watchTypes.wfLVMat,     'Value', 0);
    set(dwh.watchTypes.wfAn,        'Value', 0);
    set(dwh.watchTypes.behav,       'Value', 0);
    % set the filters
    set(dwh.filt.animalID,          'Value', 1, 'String', { '-' });
    set(dwh.filt.dayID,             'Value', 1, 'String', { '-' });
    set(dwh.filt.wfLVSessID,        'Value', 1, 'String', { '-' });
    set(dwh.filt.rowTypeID,         'Value', 1, 'String', { '-' });
    set(dwh.filt.dataLoadStatus,    'Value', 0, 'String', '');
    set(dwh.filt.rowNum,            'Value', 0, 'String', '');
    set(dwh.filt.runNum,            'Value', 0, 'String', '');
    set(dwh.filt.all,               'Value', 0, 'String', '');
    
    % update the table
    DWProcessWatchFolder(this);
    
    % set the watch types for processing
    set(dwh.watchTypes.wfLVMat,     'Value', 1);
    set(dwh.watchTypes.behav,       'Value', 1);
    
    % get triplets
    IDs = get(this, 'all', { 'animal', 'day', 'wfLVSess', 'runNum' }, DWFilterTable(this, 'rowType = WFLV session AND wfLVSess ~= \d{6}'));
    
    %% go through each animal
    for iID = max(iStartID, 1) : min(size(IDs, 1), iEndID);
        
        % do not process excluded IDs
        if ismember(iID, iExcl); continue; end;
        
        % get the IDs and set filters
        [animalID, dayID, sessID, sessNum] = IDs{iID, :};
        set(dwh.filt.animalID,          'Value', 2, 'String', { '-', animalID });
        set(dwh.filt.dayID,             'Value', 2, 'String', { '-', dayID });
        set(dwh.filt.wfLVSessID,        'Value', 2, 'String', { '-', sprintf('session%s_%s', sessNum, sessID) });
        
        % update the table
        DWProcessWatchFolder(this);
        
        % get trial rows
        [~, trialRowInds] = DWFilterTable(this, 'rowType = WF trial');
        if isempty(trialRowInds);
           showWarning(this, sprintf('OCIA:%s:NoTrialIndices', mfilename()), sprintf(...
               'Problem with animal %s, day %s, session %s (%s): no trial index.\n', ...
               animalID, dayID, sessID, sessNum));
           continue;
        end;
        
        % count the trials of each type
        trialCountStruct = struct();
        
        % go through all trials to rename them
        for iRow = max(iTrialStart, 1) : min(numel(trialRowInds), iTrialEnd);
            iDWRow = trialRowInds(iRow);
            
            % extract info and data for this row
            commentsForRow = get(this, iDWRow, 'comments');
            
            % check each trial type for a match
            for iTrialType = 1 : numel(trialTypeSaveName);
                trialTypeRegexp = trialTypesRegexp{iTrialType};
                trialType = trialTypeSaveName{iTrialType};
                % trial is a match for this type
                if ~isempty(regexp(commentsForRow, trialTypeRegexp, 'once'));
                    
                    % first trial of this type
                    if ~isfield(trialCountStruct, trialType);
                        trialCountStruct.(trialType) = 0;
                        % create "tr_hit" or "tr_CR" variables
                        eval(sprintf('tr_%s = [];', trialType));
                    end;
                    % add trial count
                    trialCountStruct.(trialType) = trialCountStruct.(trialType) + 1;
                    % append to "tr_hit" or "tr_CR" variables
                    eval(sprintf('tr_%s(end + 1) = iRow;', trialType));
                    
                    % get path and rename file
                    filePath = get(this, iDWRow, 'path');
                    newFilePath = regexprep(filePath, 'stim_trial\d+\.mat', sprintf('cond_%s_trial%d.mat', trialType, trialCountStruct.(trialType)));
                    movefile(filePath, newFilePath);
                end;
            end;
        end;
        
        % save the data for each condition
        varsToSave = {};
        for iTrialType = 1 : numel(trialTypeSaveName);
            trialType = trialTypeSaveName{iTrialType};
            % abort if no trials of this type
            if ~isfield(trialCountStruct, trialType) || trialCountStruct.(trialType) <= 0; continue; end;
            varsToSave{end + 1} = sprintf('tr_%s', trialType'); %#ok<AGROW>
        end;
        
        % save "trial_inds.mat" file
        trialPath = get(this, trialRowInds(1), 'path');
        save(regexprep(trialPath, 'stim_trial1', 'trials_ind'), varsToSave{:});
        
    end;
    
end
