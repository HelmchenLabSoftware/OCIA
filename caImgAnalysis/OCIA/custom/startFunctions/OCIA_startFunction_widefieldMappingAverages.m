function OCIA_startFunction_widefieldMappingAverages(this)
% OCIA_startFunction_widefieldMappingAverages - [no description]
%
%       OCIA_startFunction_widefieldMappingAverages(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
    
    iStartID = 1;
    iExcl = [];
    iEndID = Inf;
    iTrialStart = 1;
    iTrialEnd = Inf;
    % define trial types
%     trialTypesRegexp = { '4 kHz', '28 kHz', 'hit', 'CR', 'miss', 'FA', 'early', 'auto' };
%     trialTypeSaveName = { 'go', 'nogo', 'hit', 'CR', 'miss', 'FA', 'early', 'auto' };

    %% get all mapping data for the selected parameters (animal/day/etc)
    OCIAChangeMode(this, 'DataWatcher');
    
    % get the DataWatcher's and the Analyser's GUI handles
    dwh = this.GUI.handles.dw;
    
    % set the watch types
    set(dwh.watchTypes.animal,      'Value', 1);
    set(dwh.watchTypes.day,         'Value', 1);
    set(dwh.watchTypes.wfLV,        'Value', 1);
    set(dwh.watchTypes.wfLVSess,    'Value', 1);
    set(dwh.watchTypes.wfLVMat,     'Value', 1);
    set(dwh.watchTypes.wfAn,        'Value', 0);
    set(dwh.watchTypes.behav,       'Value', 0);
    % set the filters
    set(dwh.filt.rowTypeID,         'Value', 1, 'String', { '-' });
    set(dwh.filt.dataLoadStatus,    'Value', 0, 'String', '');
    set(dwh.filt.rowNum,            'Value', 0, 'String', '');
    set(dwh.filt.runNum,            'Value', 0, 'String', '');
    set(dwh.filt.all,               'Value', 0, 'String', '');
    
    % update the table
    DWProcessWatchFolder(this);
    
    % get triplets
    IDs = get(this, 'all', { 'animal', 'day', 'wfLVSess', 'runNum' }, ...
        DWFilterTable(this, 'rowType = WF average AND wfLVSess ~= \w+'));
    
    %% go through each row within the selection
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
        avgStruct = struct();
        trialCountStruct = struct();
        DWLoadRow(this, trialRowInds(1), 'full');
        dims = str2dim(get(this, trialRowInds(1), 'dim'));
        
        % create average for each condition
        for iRow = max(iTrialStart, 1) : min(numel(trialRowInds), iTrialEnd);
            iDWRow = trialRowInds(iRow);
            
            % fully load row
            DWLoadRow(this, iDWRow, 'full');
            
            % extract info and data for this row
            commentsForRow = get(this, iDWRow, 'comments');
            dataForRow = getData(this, iDWRow, 'wfTrIm', 'data');
            
            % check each trial type for a match
            for iTrialType = 1 : numel(trialTypeSaveName);
                trialTypeRegexp = trialTypesRegexp{iTrialType};
                trialType = trialTypeSaveName{iTrialType};
                % trial is a match for this type
                if ~isempty(regexp(commentsForRow, trialTypeRegexp, 'once'));
                    % first trial of this type
                    if ~isfield(avgStruct, trialType);
                        avgStruct.(trialType) = zeros(dims);
                        trialCountStruct.(trialType) = 0;
                    end;
                    % add average values
                    avgStruct.(trialType) = avgStruct.(trialType) + dataForRow;
                    % add trial count
                    trialCountStruct.(trialType) = trialCountStruct.(trialType) + 1;
                end;
            end;
            
            % clean up by erasing data for this row
            DWFlushData(this, iDWRow, false, 'wfTrIm');
        end;
        
        % save the data for each condition
        for iTrialType = 1 : numel(trialTypeSaveName);
            trialType = trialTypeSaveName{iTrialType};
            % abort if no trials of this type
            if ~isfield(trialCountStruct, trialType) || trialCountStruct.(trialType) <= 0; continue; end;
            % divide by the number of trials
            N = trialCountStruct.(trialType);
            avgStruct.(trialType) = avgStruct.(trialType) ./ N;
            % save as "tr_ave" and "N" variable
            tr_ave = avgStruct.(trialType); %#ok<NASGU>
            trialPath = get(this, trialRowInds(1), 'path');
            save(regexprep(trialPath, 'stim_trial1', sprintf('cond_%s_average', trialType)), 'tr_ave', 'N');
        end;
        
    end;
    
end
