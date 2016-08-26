warning('off', 'MATLAB:mir_warning_maybe_uninitialized_temporary');

checkOnly = false;
% checkOnly = true;

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
    for iDay = 1 : numel(dayIDs);
        
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

            basePathSess = [basePathDay sessIDs(iSess).name '/'];
            matFilesPath = sprintf('%sMatt_files/', basePathSess);
%             fprintf('    Processing animal %d %s, day %s, session %d %s ...\n', iAnim, ...
%                 animID, dayID, iSess, sessIDs(iSess).name);

            if exist(matFilesPath, 'dir') ~= 7;
                fprintf('      Skipping animal %d %s, day %s, session %d %s: Matt_files folder missing.\n', ...
                    iAnim, animID, dayID, iSess, sessIDs(iSess).name);
                continue;
            end;
            
            % check if stimStartFrames file exists
            stimStartFilePath = sprintf('%sstimStartFrames.mat', matFilesPath);
            if ~exist(stimStartFilePath, 'file');
                fprintf('      Skipping animal %d %s, day %s, session %d %s: stimStartFrames file missing.\n', ...
                    iAnim, animID, dayID, iSess, sessIDs(iSess).name);
                continue;
                
            end;
            % load the stim starts
            stimStartFramesMat = load(stimStartFilePath);
            stimStartFrames = stimStartFramesMat.stimStartFrame;
            
            % check if behavior file exists
            behavFiles = dir([matFilesPath, 'Behavior_*']);
            behavFilesBase = dir([basePathSess, 'Behavior_*']);
            if numel(behavFiles) < 1;
                % missplaced behavior file
                if numel(behavFilesBase) == 1;
                    if ~checkOnly;
                        movefile([basePathSess behavFilesBase(1).name], [matFilesPath behavFilesBase(1).name]);
                        behavFiles = dir([matFilesPath, 'Behavior_*']);
                    end;
                    fprintf('      Fixing animal %d %s, day %s, session %d %s: moving behavior file to Matt_files folder from session root.\n', ...
                        iAnim, animID, dayID, iSess, sessIDs(iSess).name);
                    
                elseif numel(behavFilesBase) > 1;
                    fprintf('      Skipping animal %d %s, day %s, session %d %s: too many behavior files *in root*.\n', ...
                        iAnim, animID, dayID, iSess, sessIDs(iSess).name);
                    
                else
                    fprintf('      Skipping animal %d %s, day %s, session %d %s: behavior file missing.\n', ...
                        iAnim, animID, dayID, iSess, sessIDs(iSess).name);
                    continue;
                end;
                
            elseif numel(behavFiles) > 1;
                fprintf('      Skipping animal %d %s, day %s, session %d %s: more than one behavior file.\n', ...
                    iAnim, animID, dayID, iSess, sessIDs(iSess).name);
                continue;
                
            elseif numel(behavFiles) == 1 && numel(behavFilesBase) == 1;
                fprintf('      Fixing animal %d %s, day %s, session %d %s: file present in root and Matt_files, removing the one in root.\n', ...
                    iAnim, animID, dayID, iSess, sessIDs(iSess).name);
                if ~checkOnly;
                    delete([basePathSess behavFilesBase(1).name]);
                end;
                
            end;
            
            %% extract behavior data for this session
            if ~checkOnly;
                behavDataMat = load([matFilesPath, behavFiles.name]);
                behavData = behavDataMat.out;
                respTypes = behavData.respTypes;
            end;
            
            %% count trial files
            files = struct(); nFiles = struct();
            files.stim = dir([matFilesPath, 'stim_trial*']); nFiles.stim = numel(files.stim);
            files.hit = dir([matFilesPath, 'cond_hit_trial*']); nFiles.hit = numel(files.hit);
            files.CR = dir([matFilesPath, 'cond_CR_trial*']); nFiles.CR = numel(files.CR);
            
            msg = sprintf('animal %d %s, day %s, session %d %s: [STIM|HIT|CR] = [%03d|%03d|%03d]', ...
                iAnim, animID, dayID, iSess, sessIDs(iSess).name, nFiles.stim, nFiles.hit, nFiles.CR);
            
            %% no files
            if nFiles.stim == 0 && nFiles.hit == 0 && nFiles.CR == 0;
                fprintf('    Skipping   %s: no trials\n', msg);
                continue;
                
            %% files are not renamed yet
            elseif nFiles.stim > 0 && nFiles.hit == 0 && nFiles.CR == 0;
                fprintf('    Processing %s: only stim trials => rename & maybe align\n', msg);
                    
                if checkOnly; continue; end;
                continue;

                nHitTrials = 0;
                nCRTrials = 0;
                tr_hit = [];
                tr_CR = [];
                for iTrial = 1 : 10;
%                 for iTrial = 1 : nFiles.stim;
                    
                    % make sure trial type is valid
                    respType = respTypes(iTrial);
                    if isnan(respType);
%                         fprintf('        Skipping animal %d %s, day %s, session %d %s trial %03d: unknown type.\n', ...
%                             iAnim, animID, dayID, iSess, sessIDs(iSess).name, iTrial);
                        continue;
                    end;
                    
                    %% load data
                    dataForRowMat = load(sprintf('%sstim_trial%d.mat', matFilesPath, iTrial));
                    dataForRow = dataForRowMat.tr;
                    imgDims = size(dataForRow);

                    %% re-alignment to sound onset
                    % calculate frame shift
                    stimStartFrameTrial = stimStartFrames(iTrial);
                    nFramesDiff = fixedStartFrame - stimStartFrameTrial;
                    if abs(nFramesDiff) > 15;
                        fprintf('        Warning for animal %d %s, day %s, session %d %s trial %03d: removing a lot of frames (%d) for realignment ...\n', ...
                            iAnim, animID, dayID, iSess, sessIDs(iSess).name, iTrial, abs(nFramesDiff));
                    end;
                    
                    % not enough frame before sound
                    if nFramesDiff > 0;
                        % check if trial is already aligned (first frame)
                        if all(all(isnan(dataForRow(:, :, 1))));
                            fprintf('        Skipping animal %d %s, day %s, session %d %s trial %03d: trials already aligned.\n', ...
                                iAnim, animID, dayID, iSess, sessIDs(iSess).name, iTrial);
                            break;
                        end;
                        % re-align otherwise
                        dataForRow = cat(3, nan([imgDims(1:2), nFramesDiff]), dataForRow(:, :, 1 : (end - nFramesDiff)));
                        
                    % too many frames before sound
                    elseif nFramesDiff < 0;
                        % check if trial is already aligned (last frame)
                        if all(all(isnan(dataForRow(:, :, end))));
                            fprintf('        Skipping animal %d %s, day %s, session %d %s trial %03d: trials already aligned.\n', ...
                                iAnim, animID, dayID, iSess, sessIDs(iSess).name, iTrial);
                            break;
                        end;
                        % re-align otherwise
                        dataForRow = cat(3, dataForRow(:, :, (abs(nFramesDiff) + 1) : end), nan([imgDims(1:2), abs(nFramesDiff)]));
                        
                    end;
                    
                    %% create averages variables
                    if ~exist('tr_ave', 'var');
                        tr_ave = zeros(imgDims);
                        cond_hit_ave = zeros(imgDims);
                        cond_CR_ave = zeros(imgDims);
                        
                    end;

                    %% averaging
                    tr_ave = tr_ave + dataForRow;
                    if respTypes(iTrial) == 1;
                        cond_hit_ave = cond_hit_ave + dataForRow;

                    elseif respTypes(iTrial) == 2;
                        cond_CR_ave = cond_CR_ave + dataForRow;

                    end;
                    
                    %% rename & save
                    % save directly in conditions
                    if respTypes(iTrial) == 1;
                        nHitTrials = nHitTrials + 1;
                        tr_hit(end + 1) = iTrial; %#ok<*SAGROW>
                        savePath = sprintf('%scond_hit_trial%d.mat', matFilesPath, nHitTrials);
                        oldPath = sprintf('%sstim_trial%d.mat', matFilesPath, iTrial);
                        fprintf('        Saving for animal %d %s, day %s, session %d %s trial %03d hit:\n          "%s"\n', ...
                            iAnim, animID, dayID, iSess, sessIDs(iSess).name, iTrial, savePath);
                        fprintf('        Deleting for animal %d %s, day %s, session %d %s trial %03d hit:\n          "%s"\n', ...
                            iAnim, animID, dayID, iSess, sessIDs(iSess).name, iTrial, oldPath);
%                         save(savePath, 'tr_hit');
%                         delete(oldPath);

                    elseif respTypes(iTrial) == 2;
                        nCRTrials = nCRTrials + 1;
                        tr_CR(end + 1) = iTrial;
                        savePath = sprintf('%scond_CR_trial%d.mat', matFilesPath, nCRTrials);
                        oldPath = sprintf('%sstim_trial%d.mat', matFilesPath, iTrial);
                        fprintf('        Saving for animal %d %s, day %s, session %d %s trial %03d CR:\n          "%s"\n', ...
                            iAnim, animID, dayID, iSess, sessIDs(iSess).name, iTrial, savePath);
                        fprintf('        Deleting for animal %d %s, day %s, session %d %s trial %03d CR:\n          "%s"\n', ...
                            iAnim, animID, dayID, iSess, sessIDs(iSess).name, iTrial, oldPath);
%                         save(savePath, 'tr_CR');
%                         delete(oldPath);

                    else
                        savePath = sprintf('%sstim_trial%d.mat', matFilesPath, iTrial);
                        fprintf('        Saving for animal %d %s, day %s, session %d %s trial %03d other:\n          "%s"\n', ...
                            iAnim, animID, dayID, iSess, sessIDs(iSess).name, iTrial, savePath);
%                         save(savePath, 'tr');

                    end;
                end;
                
                %% get & save average
                fprintf('        Averaging for animal %d %s, day %s, session %d %s ...\n', ...
                    iAnim, animID, dayID, iSess, sessIDs(iSess).name);
                tr_ave = tr_ave ./ nFiles.stim;
                cond_hit_ave = cond_hit_ave ./ nHitTrials;
                cond_CR_ave = cond_CR_ave ./ nCRTrials;
                
                savePath = sprintf('%sstim_ave.mat', matFilesPath);
                fprintf('        Saving for animal %d %s, day %s, session %d %s averages:\n          "%s"\n', ...
                    iAnim, animID, dayID, iSess, sessIDs(iSess).name, savePath);
%                 save(savePath, 'tr_ave');
%                 save(sprintf('%scond_hit_ave.mat', matFilesPath), 'cond_hit_ave');
%                 save(sprintf('%scond_CR_ave.mat', matFilesPath), 'cond_CR_ave');
                
            %% files are renamed but not aligned
            elseif nFiles.stim > 0 && nFiles.hit > 0 && nFiles.CR > 0;
                
                if nFiles.stim + nFiles.hit + nFiles.CR > 120;
                    fprintf('    Processing %s: CR/hit/stim trials => maybe align and delete useless trials\n', msg);
                    
                else
                    fprintf('    Processing %s: CR/hit/stim trials => maybe align\n', msg);
                    
                end;
                    
                if checkOnly; continue; end;
                
                conds = { 'hit', 'CR', 'stim' };
                for iCond = 1 : 3;
                    condName = conds{iCond};
                    
                    for iTrial = 1 : nFiles.(condName);

                        fprintf('        Loading animal %d %s, day %s, session %d %s %s trials %03d ...\n', ...
                            iAnim, animID, dayID, iSess, sessIDs(iSess).name, condName, iTrial);

                        %% load data
                        trialPath = sprintf('%s%s_trial%d.mat', matFilesPath, iff(strcmp(condName, 'stim'), 'stim', ...
                            ['cond_' condName]), iTrial);
                        dataForRowMat = load(trialPath);
                        dataForRow = dataForRowMat.tr;
                        imgDims = size(dataForRow);

                        %% re-alignment to sound onset
                        % calculate frame shift
                        stimStartFrameTrial = stimStartFrames(iTrial);
                        nFramesDiff = fixedStartFrame - stimStartFrameTrial;
                        if abs(nFramesDiff) > 15;
                            fprintf('        Warning for animal %d %s, day %s, session %d %s trial %03d: removing a lot of frames (%d) for realignment ...\n', ...
                                iAnim, animID, dayID, iSess, sessIDs(iSess).name, iTrial, abs(nFramesDiff));
                        end;

                        % not enough frame before sound
                        if nFramesDiff > 0;
                            % check if trial is already aligned (first frame)
                            if all(all(isnan(dataForRow(:, :, 1))));
                                fprintf('        Skipping animal %d %s, day %s, session %d %s trial %03d: trials already aligned.\n', ...
                                    iAnim, animID, dayID, iSess, sessIDs(iSess).name, iTrial);
                                break;
                            end;
                            % re-align otherwise
                            dataForRow = cat(3, nan([imgDims(1:2), nFramesDiff]), dataForRow(:, :, 1 : (end - nFramesDiff)));
                        % too many frames before sound
                        elseif nFramesDiff < 0;
                            % check if trial is already aligned (last frame)
                            if all(all(isnan(dataForRow(:, :, end))));
                                fprintf('        Skipping animal %d %s, day %s, session %d %s trial %03d: trials already aligned.\n', ...
                                    iAnim, animID, dayID, iSess, sessIDs(iSess).name, iTrial);
                                break;
                            end;
                            % re-align otherwise
                            dataForRow = cat(3, dataForRow(:, :, (abs(nFramesDiff) + 1) : end), nan([imgDims(1:2), abs(nFramesDiff)]));
                        end;

                        %% rename & save
                        fprintf('        Saving for animal %d %s, day %s, session %d %s trial %03d:\n          %s...\n', ...
                            iAnim, animID, dayID, iSess, sessIDs(iSess).name, iTrial, trialPath);
                        

                        % save trial as new hit/CR aligned name
%                         save(trialPath, 'tr');
                        
                    end; % end of trial loop
                    
                end; % end of condition loop
                
            %% other cases
            else
                fprintf('    Skipping   %s: unknown situation.\n', msg);
                continue;
                
                
            end;

            fprintf('    Processing animal %d %s, day %s, session %d %s done\n', iAnim, ...
                animID, dayID, iSess, sessIDs(iSess).name);

        end;

        fprintf('  Processing animal %d %s, day %s, %d session(s) done (%3.1f sec)\n', iAnim, animID, ...
            dayID, numel(sessIDs), toc(animTic));
        
    end;
    fprintf('Processing day %s done (%3.1f sec)\n', dayID, toc(dayTic));
    
end;

warning('on', 'MATLAB:mir_warning_maybe_uninitialized_temporary');

