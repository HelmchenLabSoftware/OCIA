%% Function - mtrainerAnalyser_loadAllFromFolder
function outAll = mtrainerAnalyser_loadAllFromFolder(folderPath, skipIncomplete, doMakeConsistent, ...
    doRemoveUnresponsive, doSavePlots)

%% Initialize variables
dbgLevel = 4;

% output structure for all data in the requested folder
outAll = struct();

% fields that need to be gathered
toGatherFields = {
    'respTypes', 'nInTriLick', 'datesAsNum', 'taskTypes', ...
    'nFreqs', 'nTones', 'freqs', 'goFreq' ...
};

% initialize the structure with these fields
for iField = 1 : numel(toGatherFields);
    outAll.(toGatherFields{iField}) = [];
end;

% remodelling of the saved out structrures
toRemoveField = { ...
    'trialEnds_obs'
    'trialStarts_obs'
    'trialStarts_sched'
    }; %#ok<NASGU>
toRenameField = { ... %#ok<NASGU>
%     'responseTypeVector', 'respTypes';
%     'responseTimeVector', 'respTimes';
%     'trial', 'iTrial';
%     'trialEndVector_observed', 'trialEnds_obs';
%     'trialStartVector_observed', 'trialStarts_obs';
%     'trialStartVector_scheduled', 'trialStarts_sched';
    'trialEndsTimes', 'trialEndTimes';
    'respDelay', 'respDelays';
    }; %#ok<NASGU>
requiredFields = { ... %#ok<NASGU>
    'mouseId', 'MOUSE_ID';
    'taskType', 'TASK_TYPE';
    'phase', '?';
    'basePath', '?';
    'config', struct();
    'stims', [];
    'odds', [];
    'oddPos', [];
    'isOdd', [];
    'savePath', '?';
    'saveTime', 'SAVE_TIME';
%     'trialStarts_sched', [];
%     'trialStarts_obs', [];
%     'trialEnds_obs', [];
    'respTimes', [];
    'nInTriLick', [];
    'resps', [];
    'respDelays', [];
    'respTypes', [];
    'expStartTime', -1;
    'expTotDurTime', -1;
    }; %#ok<NASGU>

%% Gather mat-files and loop through them
matFiles = dir([folderPath '/*.mat']);
o('#mtrainerAnalyser_loadAllFromFolder: processing %d mat-file(s) in folder "%s" ...', ...
    numel(matFiles), folderPath, 1, dbgLevel);
nValidMatFiles = 0;
for iExp = 1 : numel(matFiles);
    % get the full path and load the mat-file
    fullPath = sprintf('%s/%s', folderPath, matFiles(iExp).name);
    mat = load(fullPath);
    mouseId = matFiles(iExp).name(1:9); %#ok<NASGU>
    saveTime = matFiles(iExp).name(12:31); %#ok<NASGU>
    
    % check for the presence of the 'out' struct inside, otherwise create it
    if ~isfield(mat, 'out');
        out = mat;
        save(fullPath, 'out');
    else
        out = mat.out;
    end;
    
    % extract the task type, the number of tones/frequencies used from the logFile
    out = parseLogFile(out, fullPath, iExp, dbgLevel);
    
    % remodelling of the out.mat file: change names, delete useless fields, etc.
    if doMakeConsistent;
        out = makeConsistent(out, fullPath, iExp, toRemoveField, toRenameField, requiredFields, dbgLevel); %#ok<UNRCH>
    end;
    
    % skip problematic vectors
    if ~isfield(out, 'respTypes');
        o('  #mtrain...FromFolder: %d: %s has no ''respTypes'' field.', ...
            iExp, matFiles(iExp).name, 2, dbgLevel);
        continue;
    elseif skipIncomplete && any(out.respTypes == 0);
        o('  #mtrain...FromFolder: %d: %s has an incomplete ''respTypes''.', ...
            iExp, matFiles(iExp).name, 2, dbgLevel);
        continue;
    else
        o('  #mtrain...FromFolder: %d: %s is valid.', iExp, matFiles(iExp).name, 2, dbgLevel);
        nValidMatFiles = nValidMatFiles + 1;
    end;
    
    % remodelling of the out.mat file: removing long non responsive parts
    if doRemoveUnresponsive;
        outOri = out;
        [out, unResps] = removeUnresponsive(out, iExp, dbgLevel); %#ok<UNRCH>
    end;
    
    dateAsStr = matFiles(iExp).name(12:31);
    
    if doSavePlots;
        mtrainerAnalyser_performance(outOri.respTypes, 1, ['\01_' dateAsStr], outOri.nInTriLick);
        mtrainerAnalyser_performance(out.respTypes, 1, ['\02_' dateAsStr], out.nInTriLick);
    end;
    
    dateAsNum = datenum(dateAsStr, 'yyyy_mm_dd__HH_MM_SS');
    
    nTrials = numel(out.respTypes);
    
    outAll.respTypes    = [outAll.respTypes     out.respTypes];
    outAll.nInTriLick   = [outAll.nInTriLick    out.nInTriLick];
    
    outAll.freqs        = [outAll.freqs         out.config.tone.freqs(out.stims)];
    outAll.datesAsNum   = [outAll.datesAsNum    repmat(dateAsNum, 1, nTrials)];
    outAll.taskTypes    = [outAll.taskTypes     repmat(sum(out.taskType), 1, nTrials)];
    outAll.nFreqs       = [outAll.nFreqs        repmat(numel(out.config.tone.freqs), 1, nTrials)];
    outAll.nTones       = [outAll.nTones        repmat(out.config.tone.nTones, 1, nTrials)];
    outAll.goFreq       = [outAll.goFreq        repmat(out.config.tone.freqs(out.config.tone.goStim), ...
                                                    1, nTrials)];
    
    if numel(outAll.respTypes) ~= numel(outAll.nInTriLick);
        o('  #mtrain...FromFolder: %d: %s problem!', iExp, matFiles(iExp).name, 0, dbgLevel);
    end;
        
end;

nDays = numel(unique(cellstr(datestr(outAll.datesAsNum, 'yyyymmdd'))));
o('#mtrain...FromFolder: found %d/%d valid file(s), %d trial(s) in %d unique day(s).', ...
    nValidMatFiles, numel(matFiles), numel(outAll.respTypes), nDays, 1, dbgLevel);

end

function out = parseLogFile(out, fullPath, iExp, dbgLevel)

    % try the taskType first in the out file
    if isfield(out, 'taskType') && ~strcmp(out.taskType, '?') && ~strcmp(out.taskType, 'UNKNOWN') ...
            && isfield(out.config, 'tone') && isfield(out.config.tone, 'nTones');
        taskType = out.taskType;
        o('  #mtrain...FromFolder: %d: checking for taskType, taskType present: "%s"...', ...
            iExp, taskType, 3, dbgLevel);
    else
        taskType = '?';
        % extract taskType
        o('  #mtrain...FromFolder: %d: checking for taskType, so far unset ("%s")...', ...
            iExp, taskType, 3, dbgLevel);
        fid = fopen(strrep(fullPath, '_out.mat', '_log.txt'));
        line = fgetl(fid);
        while ischar(line);
            m = regexp(line, '(?<nFreqs>\d+)F(?<nTones>\d+)T', 'names');
            if ~isempty(m);
                nFreqs = str2double(m.nFreqs);
                nTones = str2double(m.nTones);
                if nFreqs == 1 && nTones > 1;
                    taskType = 'oddballDiscrimination';
                elseif nFreqs == 2 && nTones > 1;
                    taskType = 'oddballDiscrimination';
                elseif nFreqs > 1 && nTones == 1;
                    taskType = 'freqDiscrimination';
                elseif nFreqs == 1 && nTones == 1;
                    taskType = 'basic';
                else
                    taskType = 'UNKNOWN';
                end;
                o('  #mtrain...FromFolder: %d: MATCH: nFreqs = %d, nTones = %d, taskType = "%s".', ...
                    iExp, nFreqs, nTones, taskType, 3, dbgLevel);
                out.taskType = taskType;
                if ~isfield(out.config, 'tone');
                    out.config.tone = struct();
                end;
                out.config.tone.nTones = nTones;
                if ~isfield(out.config.tone, 'freqs');
                    if nFreqs == 1; out.config.tone.freqs = 12000;
                    elseif nFreqs == 2; out.config.tone.freqs = [7000, 12000];
                    elseif nFreqs == 4; out.config.tone.freqs = [5000, 7000, 12000, 15000];
                    else out.config.freqs = repmat(-1, 1, nFreqs);
                    end;
                end;
                save(fullPath, 'out');
                break;
            end;
            line = fgetl(fid);
        end

        fclose(fid);
    end;
    if strcmp(out.taskType, '?');
        o('  #mtrain...FromFolder: %d: task type not found ("%s")...', ...
            iExp', out.taskType, 1, dbgLevel);
    end;
end

function out = makeConsistent(out, fullPath, iExp, toRemoveField, toRenameField, requiredFields, dbgLevel)
    if exist('toRemoveField', 'var');
        nFields = 0;
        for iField = 1 : size(toRemoveField, 1);
            if isfield(out, toRemoveField{iField});
                out = rmfield(out, toRemoveField{iField});
                nFields = nFields + 1;
            end;
        end;
        if nFields;
            save(fullPath, 'out');
            o('  #mtrain...FromFolder: %d: removed %d field(s).', iExp, nFields, 3, dbgLevel);
        end;
    end;
    if exist('toRenameField', 'var');
        nFields = 0;
        for iField = 1 : size(toRenameField, 1);
            if isfield(out, toRenameField{iField, 1});
                out.(toRenameField{iField, 2}) = out.(toRenameField{iField, 1});
                out = rmfield(out, toRenameField{iField, 1});
                nFields = nFields + 1;
            end;
        end;
        if nFields;
            o('  #mtrain...FromFolder: %d: renamed %d field(s).', iExp, nFields, 3, dbgLevel);
            save(fullPath, 'out');
        end;
    end;
    if exist('requiredFields', 'var');
        nFields = 0;
        for iField = 1 : size(requiredFields, 1);
            if ~isfield(out, requiredFields{iField, 1});
                if exist(requiredFields{iField, 1}, 'var');
                    eval(['out.(requiredFields{iField, 1}) = ' requiredFields{iField, 1} ';']);
                else
                    out.(requiredFields{iField, 1}) = requiredFields{iField, 2};
                end;
                nFields = nFields + 1;
            end;
        end;
        if nFields;
            o('  #mtrain...FromFolder: %d: created %d required fields.', iExp, nFields, 3, dbgLevel);
            save(fullPath, 'out');
        end;
    end;
end

function [out, unResps] = removeUnresponsive(out, iExp, dbgLevel)
    
    o('  #mtrain...FromFolder: %d: removing unresponsive trials ...', iExp, 3, dbgLevel);
    unrespSeriesIndexes = [];
    unResps = cell(1);
    minUnrespLength = 15; % minimum number of consecutive unresponsive trials
    
    toKeepIndexes = true(size(out.resps));
    toKeepIndexes(isnan(out.resps)) = false;
    
    fieldNames = {
        'stims', 'odds', 'oddPos', 'isOdd', 'trialStartDelays', 'trialStartTimes', 'trialEndTimes', ...
        'respTimes', 'nInTriLick', 'resps', 'respDelays', 'respTypes'
        };
    
    % remove NaNs
    for iField = 1 : numel(fieldNames);
        if numel(out.(fieldNames{iField})) < max(toKeepIndexes);
            o('  #mtrain...FromFolder: %d: problem with field "%s"...', iExp, fieldNames{iField}, ...
                3, dbgLevel);
            continue;
        end;
        out.(fieldNames{iField}) = out.(fieldNames{iField})(toKeepIndexes);
    end;
    
    % separate the trials by unresponsive 'bins'/'blobs'
    CC = bwconncomp(~out.resps);
    
    % go through each bin of unresponsive consecutive trials
    for iBin = 1 : numel(CC.PixelIdxList);
        indexList = CC.PixelIdxList{iBin}'; % extract the list of indexes
        
        % if the bin is long enough and contains at least one 'correct rejection' and one 'miss' ...
        if numel(indexList) >= minUnrespLength && any(out.respTypes(indexList) == 2) && any(out.respTypes(indexList) == 4);
            % then we can consider it as unresponsive and gather the indexes
            unrespSeriesIndexes = [unrespSeriesIndexes indexList]; %#ok<AGROW>
            unResps{end + 1} = indexList; %#ok<AGROW>
        end;
    end;
    
    toKeepIndexes = true(size(out.resps));
    toKeepIndexes(unrespSeriesIndexes) = false;
    
    for iField = 1 : numel(fieldNames);
        if numel(out.(fieldNames{iField})) < max(toKeepIndexes);
            o('  #mtrain...FromFolder: %d: problem with field "%s"...', iExp, fieldNames{iField}, ...
                3, dbgLevel);
            continue;
        end;
        out.(fieldNames{iField}) = out.(fieldNames{iField})(toKeepIndexes);
    end;
    
end
