
warning('off', 'MATLAB:mir_warning_maybe_uninitialized_temporary');

overwrite = false;
checkOnly = false;
doAverages = false;
doSaveNotCRNotHit = false;

fr0 = 5:15;
% fr0 = 7:9;
% fr0 = 56:59; % just before sound once aligned
fixedStartFrame = 60;

imgDims = [512 512];
ds = 2;

% basePath = 'C:/Users/WideField/Documents/LabVIEW Data/1601_behav/';
basePath = 'W:/Neurophysiology-Storage1/Laurenczy/2016/1601_behav/';

% dayIDs = { '2016_04_28' };
    
allDayIDs = struct2cell(dir([basePath 'mou_bl_160105_03/2016_*']));
allDayIDs = allDayIDs(1, :)';
dayIndsWithImg = cellfun(@(dayID) numel(dir([basePath 'mou_bl_160105_03/', dayID, '/widefield_labview/session*'])) > 0, allDayIDs);
dayIDs = allDayIDs(dayIndsWithImg);

for iDay = 1 : numel(dayIDs);
    
    dayID = dayIDs{iDay};
    dayIDShort = regexprep(dayID, '_', '');
    invertDayIDShort = [dayIDShort(1 : 4), dayIDShort(7:8), dayIDShort(5:6)];
%     animIDs = dir([basePath 'mou_bl*']);
%     animIDs = animIDs(arrayfun(@(i) animIDs(i).isdir, 1 : numel(animIDs)));
%     animIDs = arrayfun(@(i) animIDs(i).name, 1 : numel(animIDs), 'UniformOutput', false);
    animIDs = { 'mou_bl_160105_03' };
    fprintf('Processing day %s ...\n', dayID);
    dayTic = tic;

    for iAnim = 1 : numel(animIDs);

        animID = animIDs{iAnim};
        basePathAnim = [basePath animID '/' dayID '/widefield_labview/'];
%         sessIDs = dir([basePathAnim 'exp*']);
        sessIDs = dir([basePathAnim 'session*']);
        sessIDs = sessIDs(arrayfun(@(i)sessIDs(i).isdir, 1 : numel(sessIDs)));
        fprintf('  Processing animal %d %s, day %s, %d session(s)...\n', iAnim, animID, dayID, ...
            numel(sessIDs));

        animTic = tic;
        
        if numel(sessIDs) == 0; continue; end;

        for iSess = 1 : numel(sessIDs);

            basePathSess = [basePathAnim sessIDs(iSess).name '/'];
            matFilesPath = sprintf('%sMatt_files/', basePathSess);
            fprintf('    Processing animal %d %s, day %s, session %d %s ...\n', iAnim, ...
                animID, dayID, iSess, sessIDs(iSess).name);

            if exist(matFilesPath, 'dir') ~= 7;
                fprintf('      Skipping animal %d %s, day %s, session %d %s: Matt_files folder missing.\n', ...
                    iAnim, animID, dayID, iSess, sessIDs(iSess).name);
                continue;
            end;
            
            if strcmp(sessIDs(iSess).name, 'session00_reference'); continue; end;
            
            pixelsToRemoveFilePath = sprintf('%spixels_to_remove.mat', matFilesPath);
            if exist(pixelsToRemoveFilePath, 'file') ~= 2;
                fprintf('      Skipping animal %d %s, day %s, session %d %s: "pixels_to_remove.mat" file missing.\n', ...
                    iAnim, animID, dayID, iSess, sessIDs(iSess).name);
                continue;
            end;
            
            stimStartFramesFilePath = sprintf('%sstimStartFrames.mat', matFilesPath);
            if exist(stimStartFramesFilePath, 'file') ~= 2 && ~strcmp(sessIDs(iSess).name, 'session00_reference');
                fprintf('      Skipping animal %d %s, day %s, session %d %s: "stimStartFrames.mat" file missing.\n', ...
                    iAnim, animID, dayID, iSess, sessIDs(iSess).name);
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
                    fprintf('      Fixing animal %d %s, day %s, session %d %s: moving behavior file to Matt_files folder from session root.\n', ...
                        iAnim, animID, dayID, iSess, sessIDs(iSess).name);
                    
                elseif numel(behavFilesBase) > 1;
                    fprintf('      Skipping animal %d %s, day %s, session %d %s: too many behavior files *in root*.\n', ...
                        iAnim, animID, dayID, iSess, sessIDs(iSess).name);
                    
                elseif ~strcmp(sessIDs(iSess).name, 'session00_reference');
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
            
            % extract data for this row
            if ~checkOnly && ~strcmp(sessIDs(iSess).name, 'session00_reference');
                behavDataMat = load([matFilesPath, behavFiles.name]);
                behavData = behavDataMat.out;
                respTypes = behavData.respTypes;
                
            else
                respTypes = [];
                
            end;
            
            % get pixels to remove
            pixelsToRemoveMat = load(pixelsToRemoveFilePath);
            pixels_to_remove = pixelsToRemoveMat.pixels_to_remove;
            
            % get stimulus start frames
            if ~checkOnly && ~strcmp(sessIDs(iSess).name, 'session00_reference');
                stimStartFramesMat = load(stimStartFramesFilePath);
                stimStartFrames = stimStartFramesMat.stimStartFrame;
                
            else
                stimStartFrames = [];
                
            end;
            
            trialDCIMGFiles = dir(sprintf('%s%s*', basePathSess, invertDayIDShort));
            nTrials = numel(trialDCIMGFiles);

            if nTrials == 0;
                fprintf('      Skipping animal %d %s, day %s, session %d %s: no DCIMG files.\n', ...
                    iAnim, animID, dayID, iSess, sessIDs(iSess).name);
                continue;
            end;
            
            matFiles = dir(sprintf('%s*.mat', matFilesPath));
            trialFiles = matFiles(arrayfun(@(iFile)~isempty(regexp(matFiles(iFile).name, 'cond_(hit|CR)_trial\d+.mat', 'once')), 1 : numel(matFiles)));
            nHitOrCRTrials = sum(~isnan(stimStartFrames(respTypes == 1 | respTypes == 2)));
            
            if nTrials == 0;
                fprintf('      Skipping animal %d %s, day %s, session %d %s: no DCIMG files.\n', ...
                    iAnim, animID, dayID, iSess, sessIDs(iSess).name);
                continue;
            end;
            
            if nHitOrCRTrials == numel(trialFiles);
                fprintf('      Skipping animal %d %s, day %s, session %d %s: conversion already done.\n', ...
                    iAnim, animID, dayID, iSess, sessIDs(iSess).name);
                continue;
            end;
            
            if exist(sprintf('%sstim_ave.mat', matFilesPath), 'file') && ~overwrite;
                fprintf('      Skipping animal %d %s, day %s, session %d %s: average mat-file exists.\n', iAnim, ...
                    animID, dayID, iSess, sessIDs(iSess).name);
                continue;
                
            elseif exist(sprintf('%sstim_ave.mat', matFilesPath), 'file') && overwrite;
                fprintf(['      *Not* skipping animal %d %s, day %s, session %d %s: ', ...
                    'average mat-file exists but will be overwritten.\n'], iAnim, ...
                    animID, dayID, iSess, sessIDs(iSess).name);
                
            end;

            imgDimY = imgDims(1);
            imgDimYDS = ceil(imgDimY / ds);
            imgDimX = imgDims(2);
            imgDimXDS = ceil(imgDimX / ds);
            
            % read the header of the first file to get the number of frames
            fid = fopen(sprintf('%s%s', basePathSess, trialDCIMGFiles(1).name), 'r');
            % 232 bytes offset
            hdr = fread(fid, 232, 'char*1', 'ieee-le');
            % close file handle
            fclose(fid);
            nFrames = hdr(37);
            iTrial = 0;

            if doAverages;
                tr_ave = zeros(imgDimYDS, imgDimXDS, nFrames);
                cond_hit_ave = zeros(imgDimYDS, imgDimXDS, nFrames);
                cond_CR_ave = zeros(imgDimYDS, imgDimXDS, nFrames);
            end;
            
            normFrameFilePath = sprintf('%snorm_frame.mat', matFilesPath);
            if exist(normFrameFilePath, 'file') ~= 2;
                baselineForEachTrial = nan(imgDimYDS, imgDimXDS, nTrials);
                fprintf('      Processing animal %d %s, day %s, session %d %s: creating norm_frame from scratch.\n', ...
                    iAnim, animID, dayID, iSess, sessIDs(iSess).name);
                
            else
                fprintf('      Processing animal %d %s, day %s, session %d %s: loading norm_frame from file.\n', ...
                    iAnim, animID, dayID, iSess, sessIDs(iSess).name);
                normFrameMat = load(normFrameFilePath);
                
                if numel(normFrameMat.fr0) ~= numel(fr0) || any(normFrameMat.fr0 ~= fr0);
                    fprintf('/!\\ Problem with animal %d %s, day %s, session %d %s: loaded a norm_frame with a different baseline.\n', ...
                        iAnim, animID, dayID, iSess, sessIDs(iSess).name);
                    continue;
                end;
                    
                
                baselineForEachTrial = normFrameMat.fr_dev;
                
            end;
            fprintf('      Processing animal %d %s, day %s, session %d %s: %d trial(s) ...\n', iAnim, ...
                animID, dayID, iSess, sessIDs(iSess).name, nTrials);

            sessTic = tic;
            nRealTrials = 0;
            nHitTrials = 0;
            nCRTrials = 0;
            tr_hit = [];
            tr_CR = [];
            for iTrial = 1 : nTrials;
                
                % make sure trial type is valid
                respType = respTypes(iTrial);
                if isnan(respType);
                    fprintf('/!\\ Problem with animal %d %s, day %s, session %d %s trial %d: invalid respType, skipping trial.\n', ...
                           iAnim, animID, dayID, iSess, sessIDs(iSess).name, iTrial);
                    continue;
                end;
                    
                % save directly in conditions
                if ~isempty(respTypes) && respTypes(iTrial) == 1;
                    nHitTrials = nHitTrials + 1;
                    tr_hit(end + 1) = iTrial; %#ok<*SAGROW>
                    savePath = sprintf('%scond_hit_trial%d.mat', matFilesPath, nHitTrials);

                elseif ~isempty(respTypes) && respTypes(iTrial) == 2;
                    nCRTrials = nCRTrials + 1;
                    tr_CR(end + 1) = iTrial;
                    savePath = sprintf('%scond_CR_trial%d.mat', matFilesPath, nCRTrials);

                elseif doSaveNotCRNotHit;
                    savePath = sprintf('%sstim_trial%d.mat', matFilesPath, iTrial);
                    
                else
                    fprintf('        Skipping animal %d %s, day %s, session %d %s trial %d: not a hit or CR trial ...\n', ...
                        iAnim, animID, dayID, iSess, sessIDs(iSess).name, iTrial);
                    continue;
                    
                end;
                        
                try

                    % trial exists and must be loaded for averages
                    if exist(savePath, 'file') && ~overwrite && doAverages;
                        fprintf('        Processing animal %d %s, day %s, session %d %s trial %d: loading as it already exists ...\n', ...
                            iAnim, animID, dayID, iSess, sessIDs(iSess).name, iTrial);

                        if checkOnly; continue; end;
                        
                        trialMat = load(savePath);
                        trialFrames = trialMat.tr;
                        
                    % trial exists but no averages required
                    elseif exist(savePath, 'file') && ~overwrite && ~doAverages;
                        fprintf('        Skipping animal %d %s, day %s, session %d %s trial %d: trial already exists ...\n', ...
                            iAnim, animID, dayID, iSess, sessIDs(iSess).name, iTrial);

                        continue;
                        
                    % trial not done yet
                    else

                        if exist(savePath, 'file') && overwrite;
                            fprintf('        Processing animal %d %s, day %s, session %d %s trial %d: *not* loading but re-processing ...\n', ...
                                iAnim, animID, dayID, iSess, sessIDs(iSess).name, iTrial);
                        end;

                        if checkOnly; continue; end;

                        fprintf('        Processing animal %d %s, day %s, session %d %s trial %d: %d frame(s) ...\n', iAnim, ...
                            animID, dayID, iSess, sessIDs(iSess).name, iTrial, nFrames);

                        
                        if ~isempty(stimStartFrames) && isnan(stimStartFrames(iTrial));
                            fprintf('/!\\ Problem with animal %d %s, day %s, session %d %s trial %d: no stim start frame, skipping.\n', ...
                                   iAnim, animID, dayID, iSess, sessIDs(iSess).name, iTrial);
                               continue;
                        end;

                        trialTic = tic;
                        rawFrames = readDCAM(sprintf('%s%s', basePathSess, trialDCIMGFiles(iTrial).name), nFrames, imgDims);
                        fprintf('        Processing animal %d %s, day %s, session %d %s trial %d: reading %d frame(s) done. (%.3f sec)\n', iAnim, ...
                            animID, dayID, iSess, sessIDs(iSess).name, iTrial, nFrames, toc(trialTic));
                        
                        trialTic = tic;
                        trialFrames = zeros(imgDimYDS, imgDimXDS, nFrames);
                        parfor iFrame = 1 : nFrames;
                            imgReshape = reshape(rawFrames(:, :, iFrame)', imgDimY * imgDimX, 1);
                            imgReshape(pixels_to_remove, :) = nan;
                            img = reshape(imgReshape, imgDimY, imgDimX);
                            img = im2double(img);
                            trialFrames(:, :, iFrame) = imresize(img, 1/ds, 'box');

                        end;
                        fprintf('        Processing animal %d %s, day %s, session %d %s trial %d: %d frame(s) done. (%.3f sec)\n', iAnim, ...
                            animID, dayID, iSess, sessIDs(iSess).name, iTrial, nFrames, toc(trialTic));

                        %% alignment to sound onset required
                        % calculate frame shift
                        if ~isempty(stimStartFrames);
                            stimStartFrameTrial = stimStartFrames(iTrial);
                            nFramesDiff = fixedStartFrame - stimStartFrameTrial;
                            if abs(nFramesDiff) > 15;
                                fprintf('/!\\ Problem with animal %d %s, day %s, session %d %s trial %d: removing a lot of frames (%d) for realignment ...\n', ...
                                   iAnim, animID, dayID, iSess, sessIDs(iSess).name, iTrial, abs(nFramesDiff));
                               
                            end;
                            
                            offsetFrames = nan([imgDimYDS, imgDimXDS, abs(nFramesDiff)]);
                            % not enough frame before sound
                            if nFramesDiff > 0;
                                trialFrames = cat(3, offsetFrames, trialFrames(:, :, 1 : (end - nFramesDiff)));
                            % too many frames before sound
                            elseif nFramesDiff < 0;
                                trialFrames = cat(3, trialFrames(:, :, (abs(nFramesDiff) + 1) : end), offsetFrames);
                            end;
                            
                        else
                            fprintf(['/!\\ Problem with animal %d %s, day %s, session %d %s trial %d: not aligning because no ', ...
                                'stim start frame (reference?) ...\n'], iAnim, animID, dayID, iSess, ...
                                sessIDs(iSess).name, iTrial);
                           
                        end;
                        
                        %% baseline correction and save
                        if max(fr0) > nFrames;
                            fprintf(['/!\\ Problem with animal %d %s, day %s, session %d %s trial %d: max(fr0) ', ...
                                'exceeds number of frame %d ! Skipping.\n'], iAnim, ...
                                animID, dayID, iSess, sessIDs(iSess).name, iTrial, max(fr0), nFrames);
                            trialFrames = zeros(imgDimYDS, imgDimXDS, nFrames);
                            nRealTrials = nRealTrials - 1;
                            continue;
                        end;
                        baselineForTrial = nanmean(trialFrames(:, :, fr0), 3);
                        baselineForEachTrial(:, :, iTrial) = baselineForTrial;
                        trialFrames = trialFrames ./ repmat(baselineForTrial,[1 1 nFrames]);
                        tr = trialFrames;
                        fprintf('      Saving animal %d %s, day %s, session %d %s trial %d ...\n', iAnim, ...
                            animID, dayID, iSess, sessIDs(iSess).name, iTrial);
                        
                        % save
                        save(savePath, 'tr');
                        
                    end;
                
                catch err;
                    fprintf('      Problem with animal %d %s, day %s, session %d %s trial %d (%s): %s ...\n', ...
                        iAnim, animID, dayID, iSess, sessIDs(iSess).name, iTrial, err.identifier, ...
                        err.message);

                    if doAverages;
                        trialFrames = zeros(imgDimYDS, imgDimXDS, nFrames);
                    end;
                           
                end;
                
                if checkOnly; continue; end;

                %% averaging
                if doAverages;
                    tr_ave = tr_ave + trialFrames;
                    nRealTrials = nRealTrials + 1;
                    
                    if ~isempty(respTypes) && respTypes(iTrial) == 1;
                        cond_hit_ave = cond_hit_ave + trialFrames;

                    elseif ~isempty(respTypes) && respTypes(iTrial) == 2;
                        cond_CR_ave = cond_CR_ave + trialFrames;

                    end;
                end;

            end
            
            if checkOnly; continue; end;

            fprintf('      Processing animal %d %s, day %s, session %d %s: %d trial(s) (%d/%d real) processed (%3.1f sec)\n', iAnim, ...
                animID, dayID, iSess, sessIDs(iSess).name, nTrials, nRealTrials, nTrials, toc(sessTic));

            %% get & save average
            if doAverages;
                tr_ave = tr_ave ./ nTrials;
                save(sprintf('%sstim_ave.mat', matFilesPath), 'tr_ave');

                if nHitTrials;
                    cond_hit_ave = cond_hit_ave ./ nHitTrials;
                    save(sprintf('%scond_hit_ave.mat', matFilesPath), 'cond_hit_ave');
                end;

                if nCRTrials;
                    cond_CR_ave = cond_CR_ave ./ nCRTrials;
                    save(sprintf('%scond_CR_ave.mat', matFilesPath), 'cond_CR_ave');
                end;
            end;
            
            fr_dev = baselineForEachTrial;
            save(sprintf('%snorm_frame.mat', matFilesPath), 'fr_dev', 'fr0');
            clear('trials', 'tr', 'tr_ave', 'fr_dev', 'img', 'imgReshape', 'trialDCIMGFiles', 'framesTiffList');

            fprintf('    Processing animal %d %s, day %s, session %d %s: %d trial(s) (%d/%d real) done (%3.1f sec)\n', iAnim, ...
                animID, dayID, iSess, sessIDs(iSess).name, nTrials, nRealTrials, nTrials, toc(sessTic));

        end;

        if checkOnly; continue; end;
        fprintf('  Processing animal %d %s, day %s, %d session(s) done (%3.1f sec)\n', iAnim, animID, ...
            dayID, numel(sessIDs), toc(animTic));
    end;
    fprintf('Processing day %s done (%3.1f sec)\n', dayID, toc(dayTic));
end;

warning('on', 'MATLAB:mir_warning_maybe_uninitialized_temporary');
