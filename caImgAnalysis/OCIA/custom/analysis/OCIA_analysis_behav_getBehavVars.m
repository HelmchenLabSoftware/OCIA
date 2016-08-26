function [behavVars, rowIDs, colIDs] = OCIA_analysis_behav_getBehavVars(this, allBehavStructs, ...
    selectedLoadedBehavRows, includeEOTrials)
% OCIA_analysis_behav_getBehavVars - [no description]
%
%       [behavVars, rowIDs, colIDs] = OCIA_analysis_behav_getBehavVars(this, allBehavStructs, ...
%                                       selectedLoadedBehavRows, includeEOTrials)
%
% Extract the behavior variables from the input structures into a cell array.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)


% count the number of strutures
nBehavStructs = numel(allBehavStructs);

% create a configuration cell-array for the different behavior variables with 3 + "nBehavData" + 2 columns:
%   { id, label, grouping options, plotting parameters, data for each structure, concatenated data (one value per trial), 
%       concat. data without repetitions }
behavVars = { ...
... id                          label                   grouping                               groupMethod  plotParams (plot type, unit, color)
    'behavInd',                 'behav. file num.',     { 'trial'                           },  '',         { 'box',     '',        'black'  };
    'date',                     'date',                 { 'trial'                           },  '',         { 'box'    , '',        'black'  };
    'days',                     'days',                 { 'trial'                           },  '',         { 'box'    , '',        'black'  };
    'time',                     'time',                 {                                   },  '',         { 'scatter', 'hour',    'black'  };
    'session',                  'session',              { 'trial'                           },  '',         { 'box'    , '',        'black'  };
    'dateWithSession',          'date (with session)',  {                                   },  '',         { 'scatter', '',        'black'  };
    'trialRange',               'used trial range',     {                                   },  '',         { 'scatter', '',        'black'  };
    'nTrials',                  'n. of trials',         {          'run', 'session', 'date' },  'sum',      { 'scaline', 'trial',   'black'  };
    'resps',                    'response',             { 'trial', 'run', 'session', 'date' },  'mean',     { 'scaline', '  % ',    'black'  };
    'minRespTime',              'delay',                { 'trial', 'run', 'session', 'date' },  'mean',     { 'scaline', 'sec.',  [.8 .8 .2] };
    'earliesAllowed',           'allowedEarlies',       {          'run', 'session', 'date' },  'mean',     { 'scaline', '  % ',  [.2 .8 .8] };
%     'phase',                    'training phase name',  { 'trial'                           },  '',         { 'box'    , '',        'black'  };
%     'phaseGroup',               'training phase',       { 'trial'                           },  '',         { 'box'    , '',        'black'  };
    'nogoPerc',                 'NoGo percent',        {          'run', 'session', 'date' },  'mean',     { 'scaline', '  % ',  [.8 .2 .2] };
    'animalID',                 'animal ID',            { 'trial'                           },  '',         { 'box'    , '',        'black'  };
    'stimMatrixRandomIndex',    'stim. matrix num.',    {          'run'                    },  'mean',     { 'scatter', '',        'black'  };
    'respTypes',                'response type',        { 'trial', 'run', 'session', 'date' },  'mean',     { 'scatter', '',        'black'  };
    'respDelays',               'response delay',       { 'trial', 'run', 'session', 'date' },  'mean',     { 'scaline', 'sec.',    'black'  };
%     'imagedTrials',             'imaged trials',        { 'trial',                          },  'sum',      { 'box'    , '',        'black'  };
    'startDelay',               'starting delay',       { 'trial', 'run', 'session', 'date' },  'mean',     { 'scaline', 'sec.',    'black'  };
%     'spoutIn',                  'spout delay',          { 'trial', 'run', 'session', 'date' },  'mean',     { 'scaline', 'sec.',    'black'  };
    'lightCueOn',               'light delay',          { 'trial', 'run', 'session', 'date' },  'mean',     { 'scaline', 'sec.',    'black'  };
    'nRewards',                 'n. of rew. trials',    { 'trial', 'run', 'session', 'date' },  'sum',      { 'scaline', 'trial',   'green'  };
%     'nRewardsEO',               'n. of EO rew. trials', { 'trial', 'run', 'session', 'date' },  'sum',      { 'scaline', 'trial',   'green'  };
%     'suppliedWater',            'supplied water',       {                 'session', 'date' },  'max',      { 'scaline', ' ml ',   [0 0.5 1] };
%     'rewardWater',              'reward water',         {          'run', 'session', 'date' },  'sum',      { 'line'   , ' ml ',    'cyan'   };
%     'water',                    'total water',          {          'run', 'session', 'date' },  'sum',      { 'line'   , ' ml ',    'blue'   };
%     'weight',                   'animal weight',        {                            'date' },  '',         { 'scaline', ' g. ',    'black'  };
    'counts',                   'performance counts',   {                                   },  '',         { ''       , '',        ''       };
    'hitRate',                  'hit rate',             { 'trial', 'run', 'session', 'date' },  'mean',     { 'linesca', '  % ',    'green'  };
    'FARate',                   'false alarm rate',     { 'trial', 'run', 'session', 'date' },  'mean',     { 'linesca', '  % ',    'red'    };
    'earlies',                  'earlies',              { 'trial', 'run', 'session', 'date' },  'mean',     { 'linesca', '  % ',   [0.2 0.5 1] };
    'dprime',                   'performance (d'')',    { 'trial', 'run', 'session', 'date' },  'max',      { 'linesca',  'd'' ',   'blue'   };
};
rowIDs = behavVars(:, 1); % extract the IDs
behavColIDs = regexp(regexprep(sprintf('%03d,', 1 : nBehavStructs), ',$', ''), ',', 'split');
colIDs = [{ 'id', 'label', 'grouping', 'groupMethod', 'plotParams' }, behavColIDs, { 'allDataRep', 'allData' }];
nBehavVars = size(behavVars, 1); % count the number of variables (=> rows)
% extend for each structure and for the concatenated data
behavVars(:, end + 1 : end + nBehavStructs + 2) = cell(nBehavVars, nBehavStructs + 2);

% get the mice info file's content as a cell-array with one cell per line
miceInfoLines = readMiceInfoFile(this);

% get all the starting time for each structure
expStartTimes = zeros(nBehavStructs, 1);
% go through each behavior structure
for iBehav = 1 : nBehavStructs;
    % get the behavior data structure
    behavStruct = allBehavStructs{iBehav};
    % extract the experiment starting time as a "datenum"
    expStartTimes(iBehav) = unix2dn(behavStruct.expStartTime * 1000);
end;

% create the session indexes by clustering the times
if nBehavStructs > 1;
    % get the date "datenum"
    expStartDates = datenum(datestr(expStartTimes, 'yyyy_mm_dd'), 'yyyy_mm_dd');
    % cluster the time (without the date)
    expStartTimesNoDate = expStartTimes - expStartDates;
    sessionIndexes = clusterdata(expStartTimesNoDate, 'maxclust', 2);

    % make sure the session labeled '1' is the one from the morning
    meanStartTimesForFirstSession = mean(expStartTimesNoDate(sessionIndexes == 1));
    meanStartTimesForSecondSession = mean(expStartTimesNoDate(sessionIndexes == 2));
    % if session 1 is later than session 2, swap them
    if meanStartTimesForFirstSession > meanStartTimesForSecondSession;
        sessionIndexes(sessionIndexes == 1) = 3;
        sessionIndexes(sessionIndexes == 2) = 1;
        sessionIndexes(sessionIndexes == 3) = 2;
    end;
else
    sessionIndexes = 1;
end;

o('#%s(): gathering info about %d behavior files ...', mfilename(), nBehavStructs, 2, this.verb);

    
% go through each behavior variable
for iVar = 1 : nBehavVars;
        
    % get the current behavior variable
    behavVarID = get(this, iVar, 'id', behavVars, colIDs);
    
    % go through each behavior structure
    for iBehav = 1 : nBehavStructs;
        
        % get the behavior index as string
        iBehavStr = sprintf('%03d', iBehav);
        % get the behavior data structure
        behavStruct = allBehavStructs{iBehav};
        % get the starting time for this structure
        expStartTime = expStartTimes(iBehav);
        % get the number of trials for this structure as the last valid trial having a trial ending time
        nTotTrials = find(~isnan(behavStruct.times.end) & ~isnan(behavStruct.resps), 1, 'last');
        % get early-on trials
        EOTrials = ~isnan(behavStruct.autoRewardGiven) & behavStruct.autoRewardGiven > 0 ...
            & strcmp(behavStruct.autoRewardModes, 'EarlyOn');
        nEOTrials = nansum(EOTrials);
        % remove early on auto-reward trials if required
        if ~includeEOTrials;
            nTotTrials = nTotTrials - nEOTrials;
        end;
        
        switch behavVarID;

            %% trialRange
            case 'trialRange';

                % by default, use all trials
                trialRange = 1 : nTotTrials;

                % if the phase was is not "quite wakefulness" (no reward and no go stimulation),
                %   then try to remove the invalid trials
                if ~strcmp(behavStruct.phase, 'QW');
                    
                    % get the current day and session
                    currDay = get(this, find(strcmp(rowIDs, 'date')), iBehavStr, behavVars, colIDs);
                    currSession = get(this, find(strcmp(rowIDs, 'session')), iBehavStr, behavVars, colIDs);

                    % if first structure, consider this as a first of session
                    if iBehav == 1;
                        isFirstStructFromSession = true;   

                    % otherwise check the previous structure's day and session
                    else
                        % get the day and session from the previous structure
                        prevDay = get(this, find(strcmp(rowIDs, 'date')), sprintf('%03d', iBehav - 1), behavVars, colIDs);
                        prevSession = get(this, find(strcmp(rowIDs, 'session')), sprintf('%03d', iBehav - 1), behavVars, colIDs);
                        % this is the first file from session only if either the day or the session does not match
                        isFirstStructFromSession = ~strcmp(prevDay, currDay) || prevSession ~= currSession;  

                    end;

                    % if last structure, consider this as an end of session
                    if iBehav == nBehavStructs;
                        isLastStructFromSession = true;

                    % otherwise check the previous structure's day and session
                    else
                        % get the day and session from the next structure
                        nextDay = get(this, find(strcmp(rowIDs, 'date')), sprintf('%03d', iBehav + 1), behavVars, colIDs);
                        nextSession = get(this, find(strcmp(rowIDs, 'session')), sprintf('%03d', iBehav + 1), behavVars, colIDs);
                        % this is the first file from session only if either the day or the session does not match
                        isLastStructFromSession = ~strcmp(nextDay, currDay) || nextSession ~= currSession;

                    end;        

                    % if this is the first structure from a session, remove some trials at the begining
                    if isFirstStructFromSession && ~isempty(this.an.be.nTrialsSkip);
                        o('%s#: %s is first structure from session (%s, %d).', mfilename(), iBehavStr, currDay, ...
                            currSession, 4, this.verb);
                        trialRange(1 : min(this.an.be.nTrialsSkip(1), nTotTrials)) = [];            
                    end;

                    % if this is the last structure from a session, remove some trials at the end        
                    if isLastStructFromSession && ~isempty(this.an.be.nTrialsSkip);
                        o('%s#: %s is last structure from session (%s, %d).', mfilename(), iBehavStr, currDay, ...
                            currSession, 4, this.verb);
                        trialRange(max(end - this.an.be.nTrialsSkip(2) + 1, 1) : end) = [];

                    end;

                    % if this is the last structure from a session, remove some trials at the end        
                    if isLastStructFromSession && ~isempty(this.an.be.nMinRespTrialSkip);                            
                        % get the response types
                        respTypes = behavStruct.respTypes(trialRange);
                        % get the parameters for the ending non-responsive ratio mesure
                        minNResps = this.an.be.nMinRespTrialSkip(1);
                        nLastTrial = this.an.be.nMinRespTrialSkip(2);
                        % if there are enough trials to calculate the non-responsive trials
                        if numel(respTypes) > nLastTrial;
                            % counter for the number of trials removed
                            nTrialsRemoved = 0;
                            % get the last trials
                            lastRespTypes = respTypes(end - nLastTrial + 1 : end);
                            % get how many response there was in these last trials
                            nResps = sum(lastRespTypes == 1 | lastRespTypes == 3);
                            % as long as the number of responsive trials is not enough and there are enough trials
                            %   to calculate the number of responses
                            while nResps < minNResps && numel(respTypes) > nLastTrial;
                                % remove the last trial
                                respTypes(end) = [];
                                % update the counter
                                nTrialsRemoved = nTrialsRemoved + 1;
                                % get the "new" last trials
                                lastRespTypes = respTypes(end - nLastTrial + 1 : end);
                                % get the "new" number of response(s) in the last trials
                                nResps = sum(lastRespTypes == 1 | lastRespTypes == 3);
                            end;
                            % exclude the last trials
                            trialRange(end - nTrialsRemoved + 1 : end) = [];
                        end;
                    end;
                end; % end of QW phase check

                % if Early-on trials should not be included
                if ~includeEOTrials;
                    % remove early on trials
                    EOTrialIndices = find(EOTrials);
                    trialRange(ismember(trialRange, EOTrialIndices)) = [];
                    
                end;
                
                % store the trial range
                 data = trialRange; 

            %% nTrials
            case 'nTrials';

                % update the actual number of trials
                trialRange = get(this, find(strcmp(rowIDs, 'trialRange')), iBehavStr, behavVars, colIDs);

                % store the number of trials
                 data = zeros(1, nTotTrials);
                 data(trialRange) = 1;

            %% resps, phase, respDelays, respTypes, animalID, stimMatrixRandomIndex
            case { 'resps', 'phase', 'respDelays', 'respTypes', 'animalID', 'stimMatrixRandomIndex' };
                % if the behavior variable is stored in the structure's root, extract it from there
                if isfield(behavStruct, behavVarID);
                    data = behavStruct.(behavVarID);
                else
                    data = NaN;
                end;  

            %% lightCueOn, spoutIn, startDelay
            case { 'lightCueOn', 'spoutIn', 'startDelay' };
                % if the behavior variable is stored in the structure's root, extract it from there
                if isfield(behavStruct, 'times') && isfield(behavStruct.times, behavVarID);
                    data = behavStruct.times.(behavVarID);
                    % unless this variable is the starting delay, subtract the starting delay to have a time in
                    % seconds from the trial start
                    if ~strcmp(behavVarID, 'startDelay') && isfield(behavStruct.times, 'startDelay');
                        data = data - behavStruct.times.startDelay;
                    end;
                else
                    data = NaN;
                end; 
                
            %% phaseGroup
            case 'phaseGroup';
                phase = get(this, find(strcmp(rowIDs, 'phase')), iBehavStr, behavVars, colIDs);
                if regexp(phase, '^Q', 'once');
                    data = 'baseline';
                elseif regexp(phase, '^[ABL]', 'once');
                    data = 'shaping';
                elseif regexp(phase, '^[CDE][A-Z]\d', 'once');
                    data = 'discrimination';
                else
                    data = '[unknown]';
                end
                
            %% nogoPerc
            case 'nogoPerc';
                data = 100 * nanmean(~ismember(behavStruct.stims, behavStruct.config.tone.goStim));
                                
            %% behavInd
            case 'behavInd';
                % store the behavior index
                data = iBehav;

            %% date
            case 'date';
                % store the date as string
                data = datestr(expStartTime, 'mm_dd');

            %% days
            case 'days';
                % store the days as string of number of days since experiment start
                firstDateVec = datevec(get(this, find(strcmp(rowIDs, 'date')), '001', behavVars, colIDs), 'mm_dd');
                expStartVec = datevec(datestr(expStartTime, 'yyyy_mm_dd'), 'yyyy_mm_dd');
                data = sprintf('%02d', 1 + etime(expStartVec, firstDateVec) / 3600 / 24);
                
            %% dateWithSession
            case 'dateWithSession';
                % get the session
                session = get(this, find(strcmp(rowIDs, 'session')), iBehavStr, behavVars, colIDs);
                % store the date as string
                data = [datestr(expStartTime, 'mm_dd'), ' ', iff(session == 1, 'am', 'pm')];

            %% time
            case 'time';
                % get the starting hour and minute
                startHour = str2double(datestr(expStartTime, 'HH'));
                startMinute = str2double(datestr(expStartTime, 'MM'));
                % store the time as a decimal hour
                data = startHour + startMinute / 60;

            %% session
            case 'session';
                % use the clustered sessions
                data = sessionIndexes(iBehav);

            %% imagedTrials
            case 'imagedTrials';
                % get the behavior ID of this structure
                behavRowID = get(this, iBehav, 'behav', selectedLoadedBehavRows);
                % check whether there is ANY imaging row
                imagingRows = DWFilterTable(this, 'rowType = Imaging data');
                % some imaging rows are present
                if ~isempty(imagingRows);
                    % try to find imaging rows that have the same behavior ID
                    imagingRows = DWFilterTable(this, sprintf('behav = %s AND rowType = Imaging data', behavRowID));
                    % get the trial number of these imaging rows
                    imagedTrialNumbers = str2double(get(this, 'all', 'runNum', imagingRows));
                    % find and store which trials of the behavior structure have been imaged
                    data = double(arrayfun(@(i)ismember(i, imagedTrialNumbers), 1 : nTotTrials));
                    % get the spot number as index for the data
                    if ~isempty(imagingRows);
                        data(data > 0) = str2double(regexprep(get(this, 'all', 'spot', imagingRows), 'spot', ''));
                    end;
                    
                % no imaging rows, try to find it by day
                else
                    % get the date
                    dateForRowNoYear = get(this, find(strcmp(rowIDs, 'date')), iBehavStr, behavVars, colIDs);
                    dateForRow = [datestr(expStartTime, 'yyyy'), '_', dateForRowNoYear];
                    % find if there are any spot folders for this day
                    dateSpotPath = sprintf('%smou_bl_%s/%s/spot*', this.path.localData, behavStruct.animalID, dateForRow);
                    spotFolders = dir(dateSpotPath);
                    if ~isempty(spotFolders);
                        data = ones(nTotTrials, 1);
                    else
                        data = zeros(nTotTrials, 1);
                    end;
                    
                end;
                
            %% nRewards
            case 'nRewards';
                % store the rewarded trials
                data = double(~isnan(behavStruct.times.end) & ~isnan(behavStruct.resps) & behavStruct.respTypes == 1);

            %% nRewardsEO
            case 'nRewardsEO';
                % store the EO rewarded trials
                if includeEOTrials;
                    data = double(~isnan(behavStruct.times.end) & ~isnan(behavStruct.resps) & behavStruct.respTypes == 1);
                    data(~EOTrials) = 0;
                else
                    data = [];
                end;

            %% suppliedWater
            case 'suppliedWater';
                % if some info was found
                if ~isempty(miceInfoLines);
                    % get the current structure's date in the format of the mice info file, with an "am/pm" label 
                    %   depending on the session
                    dateToSearch = ['-' datestr(expStartTime, 'yymmdd') iff(session == 1, 'am', 'pm')];
                    % get the lines that have these date
                    lineIndexes = find(cellfun(@(cont)~isempty(regexp(cont, dateToSearch, 'once')), miceInfoLines));
                    % if no line found, assume no water was supplied
                    if isempty(lineIndexes);
                        suppliedWater = 0;
                    % if a line was found, get the amount of supplied water
                    else
                        % get the animal index of this structure
                        animalIndex = str2double(behavStruct.animalID(end - 1 : end));
                        % get the line after the date line
                        suppliedWaterCellIndex = lineIndexes(animalIndex) + 1;
                        % extract the amount of supplied water
                        suppliedWater = str2double(regexp(miceInfoLines{suppliedWaterCellIndex}, '(\d\.\d+)', 'match'));
                    end;
                    % store the supplied water
                    data = suppliedWater;
                % no info, no data
                else
                    suppliedWater = 0;
                    data = NaN;
                end;
                
            %% rewardWater
            case 'rewardWater';
                % get the list of rewarded trials as a logical array of length "nTrials"
                isReward = ~isnan(behavStruct.times.end) & ~isnan(behavStruct.resps) & behavStruct.respTypes == 1;
                % get the amount of water received on trial using the opening-time <=> water amount conversion ( multiply by 3 ):
                %   0.02s opening = 0.006ul water, 0.03s opening = 0.009 ul water
                waterReward = isReward * behavStruct.params.rewDur * 0.3;
                % store the rewarded water
                data = waterReward;

            %% water
            case 'water';
                % store the total water as the sum of the reward water and the supplied water
                data = waterReward + suppliedWater / numel(waterReward);

            %% weight
            case 'weight';
                % if some info was found
                if ~isempty(miceInfoLines);
                    % get the current structure's date in the format of the mice info file
                    dateToSearch = [datestr(expStartTime, 'yymmdd'), '\s+'];
                    % get the lines that have these date
                    lineIndexes = find(cellfun(@(cont)~isempty(regexp(cont, dateToSearch, 'once')), miceInfoLines));
                    % if no line found, use NaN as weight
                    if isempty(lineIndexes);
                        data = NaN;
                    % if a line was found, get the weight from it
                    else
                        % get the line of the weights (if several lines, take the last one)
                        weightsLine = miceInfoLines{lineIndexes(end)};
                        % try to extract the weight numbers
                        weightHits = str2double(regexprep(regexp(weightsLine, '\s\d{2}\s?', 'match'), '\s', ''));
                        % if no extraction possible, use NaN as weight
                        if isempty(weightHits);
                            data = NaN;
                        % if a match was found, get the weight
                        else
                            % get the animal index of this structure
                            animalIndex = str2double(behavStruct.animalID(end));
                            % take the weight of that animal
                            data = weightHits(animalIndex);
                        end;
                    end;
                % no info, no data
                else
                    data = NaN;
                end;

            %% counts
            case 'counts';
                % analyse the response types
                data = analyseBehavPerf(behavStruct.respTypes, [], [], 0);

            %% hitRate
            case 'hitRate';
                % get the analysis of the response types
                counts = get(this, find(strcmp(rowIDs, 'counts')), iBehavStr, behavVars, colIDs);
                % store the percent of go trials on target trial
                data = counts.TGOP;

            %% FARate
            case 'FARate';
                % get the analysis of the response types
                counts = get(this, find(strcmp(rowIDs, 'counts')), iBehavStr, behavVars, colIDs);
                % store the percent of go trials on non-target trial
                data = counts.NTGOP;

            %% dprime
            case 'dprime';
                % get the analysis of the response types
                counts = get(this, find(strcmp(rowIDs, 'counts')), iBehavStr, behavVars, colIDs);
                % store the dprime value for this structure
                data = counts.DPRIME;

            %% earlies
            case 'earlies';
                % get the analysis of the response types
                counts = get(this, find(strcmp(rowIDs, 'counts')), iBehavStr, behavVars, colIDs);
                % store the dprime value for this structure
                data = counts.INVALIDP;

            %% minRespTime
            case 'minRespTime';
                data = behavStruct.times.respMin - behavStruct.times.startDelay;
                
            %% earliesAllowed
            case 'earliesAllowed';
                if isfield(behavStruct.config.training, 'allowEarlyLicks');
                    data = behavStruct.config.training.allowEarlyLicks * 100;
                else
                    data = NaN;
                end;

            %% OTHERWISE
            % if variable is not found, skip and show warning
            otherwise
                data = [];
                showWarning(this, 'OCIA:OCIA_analysis_behav_dprime:UnknownBehavVar', ...
                    sprintf('Unknown behavior variable: "%s". Skipping it.', behavVarID));

        end; % end of behavior variable ID switch
        
        % if data has nTrials values, apply the trial range filtering
        if isnumeric(data) && numel(data) > 1 && ~strcmp(behavVarID, 'trialRange');
            trialRange = get(this, find(strcmp(rowIDs, 'trialRange')), iBehavStr, behavVars, colIDs);
            try
                data = data(trialRange);
            catch
                o('stop', 0, 0);
            end;
        end; 
        
        % actually store the behavior variable
        behavVars = set(this, iVar, iBehavStr, data, behavVars, colIDs); 
        
    end; % end of behavior structures loop
end; % end of behavior variable loop

%% create the concatenated data for all structures
% create a concatenated data where each variable has a value for each trial
% go through each behavior structure
for iBehav = 1 : nBehavStructs;
    
    % get the behavior index as string
    iBehavStr = sprintf('%03d', iBehav);
    % get the number of trials
    nTrials = sum(get(this, find(strcmp(rowIDs, 'nTrials')), iBehavStr, behavVars, colIDs));
    
    % go through each behavior variable
    for iVar = 1 : nBehavVars;
        
        % get the data for this structure and this variable
        data = get(this, iVar, iBehavStr, behavVars, colIDs);
        % get all the data for this variable with one value per trial
        allDataRep = get(this, iVar, 'allDataRep', behavVars, colIDs);
        % get all the data for this variable without repetition
        allData = get(this, iVar, 'allData', behavVars, colIDs);
        
        % if data is a string, concatenate with a cell array of "nTrials" times the string
        if ischar(data);
            allDataRep = [ allDataRep repmat( { data }, 1, nTrials) ]; %#ok<AGROW>
            allData = [ allData { data } ]; %#ok<AGROW>
            
        % if data is a numeric of length 1, concatenate with a replicaton of "nTrials" times the data
        elseif isnumeric(data) && numel(data) == 1;
            allDataRep = [ allDataRep repmat( data, 1, nTrials) ]; %#ok<AGROW>
            allData = [ allData data ]; %#ok<AGROW>
            
        % if data is a numeric of length "nTrials", concatenate the data itself
        elseif isnumeric(data) && size(data, 1) == nTrials;
            allDataRep = [ allDataRep data' ]; %#ok<AGROW>
            allData = [ allData data' ]; %#ok<AGROW>
            
        % if data is a numeric of length "nTrials", concatenate the data itself
        elseif isnumeric(data) && size(data,2) == nTrials;
            allDataRep = [ allDataRep data ]; %#ok<AGROW>
            allData = [ allData data ]; %#ok<AGROW>
            
        % otherwise show a warning and use NaNs
        else
            allDataRep = [ allDataRep nan(1, nTrials) ]; %#ok<AGROW>
            allData = [ allData NaN ]; %#ok<AGROW>
            % if data is not empty, show a warning
            if ~isempty(data) && ~isstruct(data);
                showWarning(this, 'OCIA:OCIA_analysis_behav_getBehavVars:BadSizeBehavVar', ...
                    sprintf('Behavior variable "%s" has a bad size in structure %02d: %d x %d (nTrials = %02d). Using NaNs.', ...
                    behavVars{iVar, 1}, iBehav, size(data), nTrials));
            end;
            
        end;
        
        % store back the concatenated data
        % get all the data for this variable with one value per trial
        behavVars = set(this, iVar, 'allDataRep', { allDataRep }, behavVars, colIDs);
        % get all the data for this variable without repetition
        behavVars = set(this, iVar, 'allData', { allData }, behavVars, colIDs);

    end; % end of behavior variable loop
end; % end of behavior structures loop

end

function miceInfoLines = readMiceInfoFile(this)
% extract the lines from the mice info file

% open file
miceInfoFilePath = [this.path.localData this.an.be.miceInfoFilePath];
fID = fopen(miceInfoFilePath);

if fID == -1;
    miceInfoLines = []; % return nothing
    showWarning(this, 'OCIA:OCIA_analysis_behav_dprime:CannotReadMiceInfoLine', ...
        sprintf('Could not read the "MiceInfo" file at "%s". Skipping it.', miceInfoFilePath));
    return;
end;

% allocate a cell array for the lines
miceInfoLines = cell(1000, 1);

% read all lines
i = 1;
miceInfoLines{i} = fgetl(fID); i = i + 1;
while ischar(miceInfoLines{i - 1});
    miceInfoLines{i} = fgetl(fID); i = i + 1;
end;

% close the file
fclose(fID);

% remove empty or numeric lines
miceInfoLines(cellfun(@isempty, miceInfoLines)) = [];
miceInfoLines(cellfun(@isnumeric, miceInfoLines)) = [];


end