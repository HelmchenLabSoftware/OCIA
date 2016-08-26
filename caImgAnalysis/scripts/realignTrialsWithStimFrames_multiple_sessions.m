
warning('off', 'MATLAB:mir_warning_maybe_uninitialized_temporary');

checkOnly = false;

fixedStartFrame = 60;

% basePath = 'C:/Users/WideField/Documents/LabVIEW Data/1601_behav/';
basePath = 'F:/RawData/1601_behav/';

% animIDs = dir([basePath 'mou_bl*']);
% animIDs = animIDs(arrayfun(@(i) animIDs(i).isdir, 1 : numel(animIDs)));
animIDs = { 'mou_bl_160105_03' };
    
% dayIDs = { '2016_05_20' };
allDayIDs = struct2cell(dir([basePath 'mou_bl_160105_03/2016_*']));
allDayIDs = allDayIDs(1, :)';
dayIndsWithImg = cellfun(@(dayID) numel(dir([basePath 'mou_bl_160105_03/', dayID, '/widefield_labview/session*'])) > 0, allDayIDs);
dayIDs = allDayIDs(dayIndsWithImg);

%% go through each session
for iAnim = 1 : numel(animIDs);

    animID = animIDs{iAnim};
    shortAnimID = regexprep(regexprep(animID, 'mou_bl_', ''), '_', '');
    basePathAnim = [basePath animID '/'];
    
    %% go through each day
    for iDay = 9 : numel(dayIDs);
        
        dayID = dayIDs{iDay};
        dayIDShort = regexprep(dayID, '_', '');
        fprintf('Processing day %s ...\n', dayID);
        dayTic = tic;

        basePathDay = [basePath animID '/' dayID '/widefield_labview/'];
        
%         sessIDs = dir([basePathAnim 'exp*']);
        sessIDs = dir([basePathDay 'session*']);
        sessIDs = sessIDs(arrayfun(@(i)sessIDs(i).isdir & ~strcmp(sessIDs(i).name, 'session00_reference'), 1 : numel(sessIDs)));
        fprintf('  Processing animal %d %s, day %s, %d session(s)...\n', iAnim, animID, dayID, ...
            numel(sessIDs));

        animTic = tic;
        
        if numel(sessIDs) == 0; continue; end;

        %% go through each session
        for iSess = 1 : numel(sessIDs);

            currTxt = sprintf('animal %d %s, day %s, session %d %s', iAnim, animID, dayID, iSess, sessIDs(iSess).name);
            
            basePathSess = [basePathDay sessIDs(iSess).name '/'];
            matFilesPath = sprintf('%sMatt_files/', basePathSess);
            fprintf('    Processing %s ...\n', currTxt);

            if exist(matFilesPath, 'dir') ~= 7;
                fprintf('      Skipping %s: Matt_files folder missing.\n', currTxt);
                continue;
            end;
            
            stimStartFramesFilePath = sprintf('%sstimStartFrames.mat', matFilesPath);
            if exist(stimStartFramesFilePath, 'file') ~= 2 && ~strcmp(sessIDs(iSess).name, 'session00_reference');
                fprintf('      Skipping %s: "stimStartFrames.mat" file missing.\n', currTxt);
                continue;
            end;
            
            % exclude reference sessions
            if strcmp(sessIDs(iSess).name, 'session00_reference');
                continue;
            end;
            
            behavFiles = dir([matFilesPath, 'Behavior_*']);
            behavFilesBase = dir([basePathSess, 'Behavior_*']);
                
            if numel(behavFiles) < 1;
                % missplaced behavior file
                if numel(behavFilesBase) == 1;
                    if ~checkOnly;
                        movefile([basePathSess behavFilesBase(1).name], [matFilesPath behavFilesBase(1).name]);
                        behavFiles = dir([matFilesPath, 'Behavior_*']);
                    end;
                    fprintf('      Fixing %s: moving behavior file to Matt_files folder from session root.\n', currTxt);
                    
                elseif numel(behavFilesBase) > 1;
                    fprintf('      Skipping %s: too many behavior files *in root*.\n', currTxt);
                    
                elseif ~strcmp(sessIDs(iSess).name, 'session00_reference');
                    fprintf('      Skipping %s: behavior file missing.\n', currTxt);
                    continue;
                end;
                
            elseif numel(behavFiles) > 1;
                fprintf('      Skipping %s: more than one behavior file.\n', currTxt);
                continue;
                
            elseif numel(behavFiles) == 1 && numel(behavFilesBase) == 1;
                fprintf('      Fixing %s: file present in root and Matt_files, removing the one in root.\n', currTxt);
                if ~checkOnly;
                    delete([basePathSess behavFilesBase(1).name]);
                end;
                
            end;
            
            % extract data for this row
            if ~checkOnly && ~strcmp(sessIDs(iSess).name, 'session00_reference');
                behavDataMat = load([matFilesPath, behavFiles.name]);
                behavData = behavDataMat.out;
                respTypes = behavData.respTypes;
                
            else
                respTypes = [];
                
            end;
            
            % get stimulus start frames
            if ~checkOnly && ~strcmp(sessIDs(iSess).name, 'session00_reference');
                stimStartFramesMat = load(stimStartFramesFilePath);
                stimStartFrames = stimStartFramesMat.stimStartFrame;
                
            else
                stimStartFrames = [];
                
            end;
            
            %% count trial files
            files = struct(); nFiles = struct();
            files.stim = dir([matFilesPath, 'stim_trial*']); nFiles.stim = numel(files.stim);
            files.hit = dir([matFilesPath, 'cond_hit_trial*']); nFiles.hit = numel(files.hit);
            files.CR = dir([matFilesPath, 'cond_CR_trial*']); nFiles.CR = numel(files.CR);

            conds = { 'hit', 'CR', 'stim' };
            for iCond = 1 : numel(conds);
                condName = conds{iCond};
                
                nHitTrials = 0;
                nCRTrials = 0;
                tr_hit = [];
                tr_CR = [];
                for iTrialLoop = 1 : nFiles.(condName);

                    fileName = files.(condName)(iTrialLoop).name;
                    
                    iTrial = str2double(regexprep(fileName, '.+trial(\d+)\.mat', '$1'));
                    if isempty(iTrial) || any(isnan(iTrial));
                        fprintf('*/!\\* Problem with %s cond %s trial %d: cannot extract trial number...\n', ...
                            currTxt, condName, iTrialLoop);
                        continue;
                    end;
                    
                    % if this is a CR or hit trial number, it is not the actual trial number
                    if ~strcmp(condName, 'stim');
                        condTrialInds = find(respTypes == iCond);
                        iTrialCond = iTrial;
                        iTrial = condTrialInds(iTrialCond);
%                         fprintf('        Processing %s cond %s: trial %d is actual trial %d...\n', ...
%                             currTxt, condName, iTrialCond, iTrial);
                        % save as overwrite
                        savePath = [matFilesPath fileName];
                        
                    else
                        iTrialCond = iTrial;
                                                
                    end;
                    
                    currTxtCond = sprintf('%s cond %s trial %03d (%03d|%03d)', currTxt, condName, iTrial, iTrialCond, iTrialLoop);
                
                    % make sure trial type is valid
                    respType = respTypes(iTrial);
                    if isnan(respType);
                        fprintf('*/!\\* Problem with %s: invalid respType, skipping trial.\n', currTxtCond);
                        continue;
                    end;
                    
                    % stim_trial
                    if strcmp(condName, 'stim');
                        
                        if ~isempty(respTypes) && respTypes(iTrial) == 1;
                            nHitTrials = nHitTrials + 1;
                            tr_hit(end + 1) = iTrial; %#ok<*SAGROW>
                            savePath = sprintf('%scond_hit_trial%d.mat', matFilesPath, nHitTrials);
                            fprintf('        Processing %s: hit trial %d...\n', currTxtCond, nHitTrials);

                        elseif ~isempty(respTypes) && respTypes(iTrial) == 2;
                            nCRTrials = nCRTrials + 1;
                            tr_CR(end + 1) = iTrial;
                            savePath = sprintf('%scond_CR_trial%d.mat', matFilesPath, nCRTrials);
                            fprintf('        Processing %s: CR trial %d...\n', currTxtCond, nCRTrials);
                            
                        else
                            savePath = sprintf('%sstim_trial%d.mat', matFilesPath, iTrial);
                            fprintf('        Deleting %s: not a hit or CR trial ...\n', currTxtCond);
                            % delete file
                            if ~checkOnly && exist(savePath, 'file');
                                delete(savePath);
                            end;
                            continue;
                            
                        end;

                    end
                    
                    if ~isempty(stimStartFrames) && isnan(stimStartFrames(iTrial));
                        fprintf('*/!\\* Problem with %s: no stim start frame, skipping.\n', currTxtCond);
                            
                        % delete original file
                        originalPath = [matFilesPath fileName];
                        if ~checkOnly && exist(originalPath, 'file');
                            fprintf('          Deleting %s: deleting original ...\n', currTxtCond);
                            delete(originalPath);
                        end;
                        continue;
                    end;                    

                    %% alignment to sound onset required
                    % calculate frame shift
                    stimStartFrameTrial = stimStartFrames(iTrial);
                    nFramesDiff = fixedStartFrame - stimStartFrameTrial;
                    if abs(nFramesDiff) > 15;
                        fprintf('          Warning for %s: removing a lot of frames (%d) for realignment ...\n', ...
                           currTxtCond, abs(nFramesDiff));

                    end;
                    
                    if checkOnly;
                        fprintf('          Processing %s: re-align for %d frame(s) ...\n', currTxtCond, nFramesDiff);
                        continue;
                    end;
                    
                    % load trial
                    originalPath = [matFilesPath fileName];
                    try
                        trialMat = load(originalPath);
                        tr = trialMat.tr;
                    catch err;
                        fprintf('*/!\\* Problem with %s: cannot load file (%s): %s.\n', ...
                           currTxtCond, err.identifier, err.message);
                       % delete file if unable to read
                       if ismember(err.identifier, { 'MATLAB:load:unableToReadMatFile', 'MATLAB:load:cantReadFile' });
                            % delete file
                            if ~checkOnly && exist(originalPath, 'file');
                                fprintf('        Deleting %s: deleting original ...\n', currTxtCond);
                                delete(originalPath);
                            end;
                       end;
                       continue;
                    end;
                    imgDims = size(tr);
                    
                    nanFrames = find(all(all(isnan(tr))))';
                            
                    % delete original stim file
                    if ~checkOnly && exist(originalPath, 'file') && strcmp(condName, 'stim');
                        fprintf('        Deleting %s: deleting original ...\n', currTxtCond);
                        delete(originalPath);
                    end;

                    offsetFrames = nan([imgDims(1:2), abs(nFramesDiff)]);
                    % not enough frame before sound (stim was too early)
                    if nFramesDiff > 0;
                        % check if trial is already aligned (first frame)
                        if numel(nanFrames) && (numel(nanFrames) ~= abs(nFramesDiff) || ~all(nanFrames == 1 : abs(nFramesDiff)));
                            fprintf('*/!\\* Problem with %s: trial badly aligned (%d NaN frame(s) expected, %d actual) ...\n', ...
                                currTxtCond, abs(nFramesDiff), numel(nanFrames));
                            continue;
                            
                        % check if trial is already aligned (first frame)
                        elseif numel(nanFrames) && (numel(nanFrames) == abs(nFramesDiff) && all(nanFrames == 1 : abs(nFramesDiff)));
                            fprintf('          Skipping %s: trial already aligned.\n', currTxtCond);
                            continue;
                            
                        end;
                    
                        fprintf('        Processing %s: re-align for %d frame(s) ...\n', currTxtCond, nFramesDiff);
                        % re-align otherwise
                        tr = cat(3, offsetFrames, tr(:, :, 1 : (end - nFramesDiff)));
                        
                    % too many frames before sound (stim was too late)
                    elseif nFramesDiff < 0;
                        % check if trial is already aligned (first frame)
                        if numel(nanFrames) && (numel(nanFrames) ~= abs(nFramesDiff) ...
                                || ~all(nanFrames == (imgDims(3) - abs(nFramesDiff) + 1) : imgDims(3)));
                            fprintf('*/!\\* Problem with %s: trial badly aligned (%d NaN frame(s) expected, %d actual) ...\n', ...
                                currTxtCond, abs(nFramesDiff), numel(nanFrames));
                            continue;
                            
                        % check if trial is already aligned (first frame)
                        elseif numel(nanFrames) && (numel(nanFrames) == abs(nFramesDiff) ...
                                && all(nanFrames == (imgDims(3) - abs(nFramesDiff) + 1) : imgDims(3)));
                            fprintf('          Skipping %s: trial already aligned.\n', currTxtCond);
                            continue;
                            
                        end;
                    
                        fprintf('        Processing %s: re-align for %d frame(s) ...\n', currTxtCond, nFramesDiff);
                        % re-align otherwise
                        tr = cat(3, tr(:, :, (abs(nFramesDiff) + 1) : end), offsetFrames);
                        
                    end;
                    
                    % debug plots
                    
                    % save
                    save(savePath, 'tr');

                end;
                
                % save trials
                save('trial_inds.mat', 'tr_hit', 'tr_CR');

                fprintf('    Processing %s cond %s: %d trial(s) done\n', currTxt, condName, nFiles.(condName));

            end;
        end;

        if checkOnly; continue; end;
        fprintf('  Processing animal %d %s, day %s, %d session(s) done (%3.1f sec)\n', iAnim, animID, ...
            dayID, numel(sessIDs), toc(animTic));
    end;
    fprintf('Processing day %s done (%3.1f sec)\n', dayID, toc(dayTic));
end;

warning('on', 'MATLAB:mir_warning_maybe_uninitialized_temporary');
