function OCIA_startFunction_widefieldCreateAveragesForEachCondition(this)
% OCIA_startFunction_widefieldCreateAveragesForEachCondition - [no description]
%
%       OCIA_startFunction_widefieldCreateAveragesForEachCondition(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
    
%     iStartID = 37;
    iStartID = 41;
    iExcl = []; % iEndID = Inf;
%     iEndID = 40;
    iEndID = 43;
    iTrialStart = 1;
    iTrialEnd = Inf;
    fixedStartFrame = 60;

    % define trial types
    % { '4 kHz', '28 kHz', 'miss', 'FA', 'early', 'auto' } 
    % { 'go', 'nogo', 'miss', 'FA', 'early', 'auto' }
    trialTypesRegexp = { 'hit', 'CR', 'quiet', 'moveDur', 'moveBef', ...
        'hit_AND_moveDur', 'hit_AND_quiet', 'hit_AND_moveBef', 'hit_AND_[quiet|moveBef]', ...
        'CR_AND_moveDur', 'CR_AND_quiet', 'CR_AND_moveBef', 'CR_AND_[quiet|moveBef]' };
    trialTypeSaveName = { 'hit', 'CR', 'strict_quiet', 'move', 'early_move', ...
        'move_hit', 'strict_quiet_hit', 'early_move_hit', 'delay_quiet_hit', ...
        'move_CR', 'strict_quiet_CR', 'early_move_CR', 'delay_quiet_CR' };

    %% get all widefield data
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
    
    %% go through each row
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
        
        % re-alignment to sound onset required
        pathToFirstTrial = get(this, trialRowInds(1), 'path');
        stimStartPath = regexprep(pathToFirstTrial, 'stim_trial1\.mat', 'stimStartFrames.mat');
        % stimulus start defining file exists
        if exist(stimStartPath, 'file');
            stimStartFramesMat = load(stimStartPath);
            stimStartFrames = stimStartFramesMat.stimStartFrame;

        else
            stimStartFrames = [];
            showWarning(this, sprintf('OCIA:%s:NoStimStartFrames', mfilename()), sprintf(['Problem with animal %s, ', ...
               'day %s, session %s (%s): cannot find stim start frames mat file at "%s". Skipping realigning.\n'], ...
               animalID, dayID, sessID, sessNum, stimStartPath));
        end;
        
        % create average for each condition
        for iRow = max(iTrialStart, 1) : min(numel(trialRowInds), iTrialEnd);
            iDWRow = trialRowInds(iRow);
            
            % extract info and data for this row
            commentsForRow = get(this, iDWRow, 'comments');
            iTrial = str2double(get(this, iDWRow, 'runNum'));
            
            % check each trial type for a match
            for iTrialType = 1 : numel(trialTypeSaveName);
                trialTypeRegexp = trialTypesRegexp{iTrialType};
                trialType = trialTypeSaveName{iTrialType};
                % trial is a match for this type
                if ~isempty(regexp(commentsForRow, trialTypeRegexp, 'once'));
                    % add to data structure
                    [avgStruct, trialCountStruct] = addToDataStruct(this, iDWRow, animalID, dayID, sessID, sessNum, ...
                        stimStartFrames, iTrial, fixedStartFrame, avgStruct, trialType, dims, trialCountStruct);
                end;
                
                % multiple trial types required
                if ~isempty(regexp(trialTypeRegexp, '_AND_', 'once'));
                    multiTrialTypes = regexp(trialTypeRegexp, '_AND_', 'split');
                    matchForEach = cellfun(@(triTy) ~isempty(regexp(commentsForRow, triTy, 'once')), multiTrialTypes);
                    % all requirements of matching are met
                    if all(matchForEach);
                        % add to data structure
                        [avgStruct, trialCountStruct] = addToDataStruct(this, iDWRow, animalID, dayID, sessID, ...
                            sessNum, stimStartFrames, iTrial, fixedStartFrame, avgStruct, trialType, ...
                            dims, trialCountStruct);
                        
                    end;
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
            avgStruct.(trialType).aligned = avgStruct.(trialType).aligned ./ N;
            avgStruct.(trialType).unalign = avgStruct.(trialType).unalign ./ N;
            
            % save as "tr_ave" and "N" variable
            tr_ave = avgStruct.(trialType).unalign; %#ok<NASGU>
            trialPath = get(this, trialRowInds(1), 'path');
            save(regexprep(trialPath, 'stim_trial1', sprintf('cond_%s_average', trialType)), 'tr_ave', 'N');
            
            % save as "tr_ave" and "N" variable
            tr_ave = avgStruct.(trialType).aligned; %#ok<NASGU>
            trialPath = get(this, trialRowInds(1), 'path');
            save(regexprep(trialPath, 'stim_trial1', sprintf('cond_%s_average_aligned', trialType)), 'tr_ave', 'N');
        end;
        
    end;
    
end

function [avgStruct, trialCountStruct] = addToDataStruct(this, iDWRow, animalID, dayID, sessID, sessNum, ...
    stimStartFrames, iTrial, fixedStartFrame, avgStruct, trialType, dims, trialCountStruct)

    % make sur data is loaded
    DWLoadRow(this, iDWRow, 'full');
    dataForRow = getData(this, iDWRow, 'wfTrIm', 'data');
    imgDims = size(dataForRow);

    % re-alignment to sound onset required
    if ~isempty(stimStartFrames);
        % calculate frame shift
        stimStartFrameTrial = stimStartFrames(iTrial);
        nFramesDiff = fixedStartFrame - stimStartFrameTrial;
        if abs(nFramesDiff) > 10;
            showWarning(this, sprintf('OCIA:%s:AlignFrameRemoval', mfilename()), sprintf(['Problem with animal %s, ', ...
               'day %s, session %s (%s): removing a lot of frames (%d) for realignment ...\n'], ...
               animalID, dayID, sessID, sessNum, abs(nFramesDiff)));
        end;
        % not enough frame before sound
        dataForRowUnalign = dataForRow;
        if nFramesDiff > 0;
            dataForRow = cat(3, nan([imgDims(1:2), nFramesDiff]), dataForRow(:, :, 1 : (end - nFramesDiff)));
        % too many frames before sound
        elseif nFramesDiff < 0;
            dataForRow = cat(3, dataForRow(:, :, (abs(nFramesDiff) + 1) : end), nan([imgDims(1:2), abs(nFramesDiff)]));
        end;
        
    % otherwise use nans
    else
        dataForRowUnalign = nan(dims);

    end;

    % first trial of this type
    if ~isfield(avgStruct, trialType);
        avgStruct.(trialType).aligned = zeros(dims);
        avgStruct.(trialType).unalign = zeros(dims);
        trialCountStruct.(trialType) = 0;
    end;
    
    % add average values
    avgStruct.(trialType).aligned = avgStruct.(trialType).aligned + dataForRow;
    avgStruct.(trialType).unalign = avgStruct.(trialType).unalign + dataForRowUnalign;
    
    % add trial count
    trialCountStruct.(trialType) = trialCountStruct.(trialType) + 1;
end
