warning('off', 'MATLAB:mir_warning_maybe_uninitialized_temporary');

overwrite = false;
checkOnly = false;

showSinglePlots = 0;
showAveragePlot = 2;
showHistograms = 2;
% nBins = { 100 };
% nBins = { 'BinMethod', 'sturges' };
nBins = { 'BinMethod', 'sqrt' };
imgFrameRate = 20;

% basePath = 'C:/Users/WideField/Documents/LabVIEW Data/1601_behav/';
basePath = 'F:/RawData/1601_behav/';

% animIDs = dir([basePath 'mou_bl*']);
% animIDs = animIDs(arrayfun(@(i) animIDs(i).isdir, 1 : numel(animIDs)));
animIDs = { 'mou_bl_160105_03' };
    
dayIDs = { '2016_05_27' };
% allDayIDs = struct2cell(dir([basePath 'mou_bl_160105_03/2016_*']));
% allDayIDs = allDayIDs(1, :)';
% dayIndsWithImg = cellfun(@(dayID) numel(dir([basePath 'mou_bl_160105_03/', dayID, '/widefield_labview/session*'])) > 0, allDayIDs);
% dayIDs = allDayIDs(dayIndsWithImg);



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
            fprintf('    Processing animal %d %s, day %s, session %d %s ...\n', iAnim, ...
                animID, dayID, iSess, sessIDs(iSess).name);

            if exist(matFilesPath, 'dir') ~= 7;
                fprintf('      Skipping animal %d %s, day %s, session %d %s: Matt_files folder missing.\n', ...
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
            
            % check if file does not already exist
            stimStartFilePath = sprintf('%sstimStartFrames.mat', matFilesPath);
            if exist(stimStartFilePath, 'file');
                fprintf('      Skipping animal %d %s, day %s, session %d %s: stimStartFrames file already present.\n', ...
                    iAnim, animID, dayID, iSess, sessIDs(iSess).name);
                continue;
            end;
            
            if checkOnly; continue; end;
            
            if showSinglePlots || showAveragePlot || showHistograms;
                currentSavePath = sprintf('%sgetStimFramePlots', basePathSess);
                if exist(currentSavePath, 'dir') ~= 7; mkdir(currentSavePath); end;
                currentSavePath = sprintf('%s/%s_%s_%s', currentSavePath, shortAnimID, dayIDShort);
            end;
            
            %% extract data for this row
            behavDataMat = load([matFilesPath, behavFiles.name]);
            behavData = behavDataMat.out;

            respTypes = behavData.respTypes;
            micrCell = behavData.record.micr;
            trigCell = behavData.record.trig;
            anInSampRate = behavData.anInSampRate;

            nTrials = numel(micrCell);
            nTrialsHit = sum(respTypes == 1);
            nTrialsCR = sum(respTypes == 2);
            nSamples = cellfun(@numel, micrCell);
            nSamplesTrig = cellfun(@numel, trigCell);

            soundAI = nan(nTrials, 1);
            trigAI = nan(nTrials, 1);
            trigEndAI = nan(nTrials, 1);

            nMaxSampleHit = max(nSamples(respTypes == 1));
            nMaxSampleCR = max(nSamples(respTypes == 2));
            nMaxSample = max([nSamples nSamplesTrig]);

            t = (1 : nMaxSample) / anInSampRate; %#ok<*NASGU>

            avgMicrHit = zeros(nMaxSampleHit, 1);
            avgMicrCR = zeros(nMaxSampleCR, 1);
            
            %% go through all trials
            % [30 160 1215 460]
            % [100 100 1750 950]
            if showAveragePlot;
                avgFig = figure('NumberTitle', 'off', 'Position', [100 100 1750 950]); %#ok<*UNRCH>
            end;
            for iTrial = 1 : nTrials;

                if respTypes(iTrial) ~= 1 && respTypes(iTrial) ~= 2; continue; end;
                if isempty(trigCell{iTrial}) || isempty(micrCell{iTrial}); continue; end;

                micrForTrial = linScale(abs(micrCell{iTrial}'));
                soundYThresh = 0.09;
                upSamples = [0 find(micrForTrial > soundYThresh)];
                upSamplesDiff = diff(upSamples);
                ISI = 0.5;
                minISI = ISI * 0.5 * anInSampRate;
                soundStartInds = upSamples(find(upSamplesDiff >= minISI) + 1);
                if ~isempty(soundStartInds); soundAI(iTrial) = soundStartInds(1) / anInSampRate; end;

                trigData = trigCell{iTrial}; % extract the triger's trace
                normThresh = 0.05; % take the first frames for normalization threshold
                trigData(abs(trigData) < normThresh) = 0; % normalize to remove the noise of parts when there is no trigger
                trigTop = find(abs(trigData(1 : round(nSamplesTrig(iTrial) * 0.5))) > 0); % find all the peaks

                % get the trigger delay
                if ~isempty(trigTop);
                    trigInd = trigTop(1);
                    trigAI(iTrial) = trigInd / anInSampRate;
                end;

                trigTopEnd = find(abs(trigData(round(nSamplesTrig(iTrial) * 0.5) : end)) > 0);
                if ~isempty(trigTopEnd);
                    trigIndEnd = trigTopEnd(1) + round(nSamplesTrig(iTrial) * 0.5);
                    trigEndAI(iTrial) = trigIndEnd / anInSampRate;
                end;
                if respTypes(iTrial) == 1;

                    avgMicrHit(1 : nSamples(iTrial)) = avgMicrHit(1 : nSamples(iTrial)) + micrCell{iTrial};

                    if showSinglePlots;
                        figure('Name', sprintf('Trial %03d', iTrial), 'NumberTitle', 'off', 'Position', [100 100 1750 950]);
                        hold on;
                        plot(t(1 : nSamples(iTrial)), micrCell{iTrial}, 'Color', [0.8 0.5 0.5], 'LineWidth', 0.5);
                        plot(repmat(soundAI(iTrial), 1, 2), [-9.8 9.8], 'Color', [0 0 0], 'LineWidth', 0.5);

                        plot(t(1 : nSamplesTrig(iTrial)), 1 + trigCell{iTrial}, 'Color', [0.8 0.5 0.5], 'LineWidth', 0.5, 'LineStyle', ':');
                        plot(repmat(trigAI(iTrial), 1, 2), [-9.8 9.8], 'Color', [0 0 0], 'LineWidth', 0.5, 'LineStyle', ':');
                        plot(repmat(trigEndAI(iTrial), 1, 2), [-9.8 9.8], 'Color', [0 0 0], 'LineWidth', 0.5, 'LineStyle', ':');
                        title(sprintf('Inter-trig time: %.2f', trigEndAI(iTrial) - trigAI(iTrial)));

                        xlim([-0.5, 15.5]);
                        ylim([-9.8 9.8]);
                        
                        if showSinglePlots > 1;
                            export_fig(sprintf('%strial%03d_hit_singlePlot.png', currentSavePath, iTrial), '-r150', gcf);
%                             export_fig(sprintf('%strial%03d_hit_singlePlot.fig', currentSavePath, iTrial), gcf);
                            close(gcf);
                        end;
                    end;

                    if showAveragePlot;
                        figure(avgFig);
                        subplot(2, 1, 1);
                        hold on;
                        plot(repmat(soundAI(iTrial), 1, 2), [-1.8 1.8], 'Color', [0 0 0], 'LineWidth', 0.5);
                        plot(repmat(trigAI(iTrial), 1, 2), [-1.8 1.8], 'Color', [0 0 0], 'LineWidth', 0.5, 'LineStyle', ':');
                        plot(repmat(trigEndAI(iTrial), 1, 2), [-1.8 1.8], 'Color', [0 0 0], 'LineWidth', 0.5, 'LineStyle', ':');
                        ylim([-1.8 1.8]);
                        xlim([-0.5, 15.5]);
                    end;

                elseif respTypes(iTrial) == 2;

                    avgMicrCR(1 : nSamples(iTrial)) = avgMicrCR(1 : nSamples(iTrial)) + micrCell{iTrial};

                    if showSinglePlots;
                        figure('Name', sprintf('Trial %03d', iTrial), 'NumberTitle', 'off', 'Position', [100 100 1750 950]);
                        hold on;
                        plot(t(1 : nSamples(iTrial)), micrCell{iTrial}, 'Color', [0.5 0.8 0.5], 'LineWidth', 0.5);
                        plot(repmat(soundAI(iTrial), 1, 2), [-9.8 9.8], 'Color', [0 0 0], 'LineWidth', 0.5);

                        plot(t(1 : nSamplesTrig(iTrial)), 1 + trigCell{iTrial}, 'Color', [0.5 0.8 0.5], 'LineWidth', 0.5, 'LineStyle', ':');
                        plot(repmat(trigAI(iTrial), 1, 2), [-9.8 9.8], 'Color', [0 0 0], 'LineWidth', 0.5, 'LineStyle', ':');
                        plot(repmat(trigEndAI(iTrial), 1, 2), [-9.8 9.8], 'Color', [0 0 0], 'LineWidth', 0.5, 'LineStyle', ':');
                        title(sprintf('Inter-trig time: %.2f', trigEndAI(iTrial) - trigAI(iTrial)));

                        ylim([-9.8 9.8]);
                        xlim([-0.5, 15.5]);
                        
                        if showSinglePlots > 1;
                            export_fig(sprintf('%strial%03d_CR_singlePlot.png', currentSavePath, iTrial), '-r150', gcf);
%                             export_fig(sprintf('%strial%03d_CR_singlePlot.fig', currentSavePath, iTrial), gcf);
                            close(gcf);
                        end;
                    end;

                    if showAveragePlot;
                        figure(avgFig);
                        subplot(2, 1, 2);
                        hold on;
                        plot(repmat(trigAI(iTrial), 1, 2), [-1.8 1.8], 'Color', [0 0 0], 'LineWidth', 0.5, 'LineStyle', ':');
                        plot(repmat(soundAI(iTrial), 1, 2), [-1.8 1.8], 'Color', [0 0 0], 'LineWidth', 0.5);
                        plot(repmat(trigEndAI(iTrial), 1, 2), [-1.8 1.8], 'Color', [0 0 0], 'LineWidth', 0.5, 'LineStyle', ':');

                        ylim([-1.8 1.8]);
                        xlim([-0.5, 15.5]);
                    end;

                end;

            end;


            stdMicrHit = zeros(nMaxSampleHit, 1);
            stdMicrCR = zeros(nMaxSampleCR, 1);
            for iTrial = 1 : nTrials;

                if respTypes(iTrial) ~= 1 && respTypes(iTrial) ~= 2; continue; end;
                if respTypes(iTrial) == 1;
                    stdMicrHit(1 : nSamples(iTrial)) = stdMicrHit(1 : nSamples(iTrial)) + (micrCell{iTrial} - avgMicrHit(1 : nSamples(iTrial))) .^ 2;
                elseif respTypes(iTrial) == 2;
                    stdMicrCR(1 : nSamples(iTrial)) = stdMicrCR(1 : nSamples(iTrial)) + (micrCell{iTrial} - avgMicrCR(1 : nSamples(iTrial))) .^ 2;
                end;
            end;

            % figure('NumberTitle', 'off', 'Position', [100 100 1750 950]);
            stdMicrHit = sqrt(stdMicrHit / nTrialsHit);
            stdMicrCR = sqrt(stdMicrCR / nTrialsCR);
            avgMicrHit = avgMicrHit / nTrialsHit;
            avgMicrCR = avgMicrCR / nTrialsCR;
            
            if showAveragePlot;
                figure(avgFig);
                subplot(2, 1, 1);
                hold on;
                plot(t(1 : nMaxSampleHit), avgMicrHit, 'Color', [1 0 0], 'LineWidth', 2);
                subplot(2, 1, 2);
                hold on;
                plot(t(1 : nMaxSampleCR), avgMicrCR, 'Color', [0 1 0], 'LineWidth', 2);
                
                if showAveragePlot > 1;
                    export_fig(sprintf('%saveragePlot.png', currentSavePath), '-r150', avgFig);
%                     export_fig(sprintf('%saveragePlot.fig', currentSavePath), avgFig);
                    close(avgFig);
                end;
            end;
            
            %% compare analog in times (AI)
            nBins = { 100 };
            % nBins = { 'BinMethod', 'sturges' };
            % nBins = { 'BinMethod', 'sqrt' };
            soundAIFromTrigAI = soundAI - trigAI;
            stimStartFrame = round(soundAIFromTrigAI * imgFrameRate);
            soundAIFromTrigEndAI = soundAI - trigEndAI;
            trigAIToTrigEndAI = trigEndAI - trigAI;
            if showHistograms;
                figure('NumberTitle', 'off', 'Position', [100 100 1750 950], 'Name', 'All trials AI');
                subplot(2, 3, 1); histogram(soundAI, nBins{:}); title('soundAI'); xlim([2 6]);
                subplot(2, 3, 2); histogram(trigAI, nBins{:}); title('trigAI'); xlim([-1 3]);
                subplot(2, 3, 3); histogram(trigEndAI, nBins{:}); title('trigEndAI'); xlim([12 16]);
                subplot(2, 3, 4); histogram(soundAIFromTrigAI, nBins{:}); title('soundAIFromTrigAI'); xlim([1 5]);
                subplot(2, 3, 5); histogram(soundAIFromTrigEndAI, nBins{:}); title('soundAIFromTrigEndAI'); xlim([-12 -8]);
                subplot(2, 3, 6); histogram(trigAIToTrigEndAI, nBins{:}); title('trigAIToTrigEndAI'); xlim([11 15]);
                if showHistograms > 1;
                    export_fig(sprintf('%shist_AI.png', currentSavePath), '-r150', gcf);
%                     export_fig(sprintf('%shist_AI.fig', currentSavePath), gcf);
                    close(gcf);
                end;
            end;

            %% compare time stamps from TS (time stamp)
            soundTS = behavData.times.sound';
            trialStartTS = behavData.times.trialStartCue';
            lightInTS = behavData.times.lightIn';
            trigTS = behavData.times.imgStart';
            trigEndTS = behavData.times.imgStopObs';
            respCueTS = behavData.times.lightCueOn';

            soundTS(respTypes ~= 1 & respTypes ~= 2) = NaN;
            trialStartTS(respTypes ~= 1 & respTypes ~= 2) = NaN;
            lightInTS(respTypes ~= 1 & respTypes ~= 2) = NaN;
            trigTS(respTypes ~= 1 & respTypes ~= 2) = NaN;
            trigEndTS(respTypes ~= 1 & respTypes ~= 2) = NaN;
            respCueTS(respTypes ~= 1 & respTypes ~= 2) = NaN;

            soundTSFromTrigTS = soundTS - trigTS;
            trialStartTSFromTrigTS = trialStartTS - trigTS;
            trialStartTSFromSoundTS = trialStartTS - soundTS;
            soundTSFromTrigEndTS = soundTS - trigEndTS;
            trigTSToTrigEndTS = trigEndTS - trigTS;
            respCueTSToSoundTS = respCueTS - soundTS;
            respCueTSToTrigTS = respCueTS - trigTS;

            if showHistograms;
                figure('NumberTitle', 'off', 'Position', [100 100 1750 950], 'Name', 'All trials TS');
                subplot(4, 4, 1); histogram(soundTS, nBins{:}); title('soundTS'); xlim([1 5]);
                subplot(4, 4, 2); histogram(trigTS, nBins{:}); title('trigTS'); xlim([-2 2]);
                subplot(4, 4, 3); histogram(trigEndTS, nBins{:}); title('trigEndTS'); xlim([11 15]);
                subplot(4, 4, 4); histogram(lightInTS, nBins{:}); title('lightInTS'); xlim([5 9]);
                subplot(4, 4, 5); histogram(soundTSFromTrigTS, nBins{:}); title('soundTSFromTrigTS'); xlim([1 5]);
                subplot(4, 4, 6); histogram(soundTSFromTrigEndTS, nBins{:}); title('soundTSFromTrigEndTS'); xlim([-12 -8]);
                subplot(4, 4, 7); histogram(trigTSToTrigEndTS, nBins{:}); title('trigTSToTrigEndTS'); xlim([11 15]);
                subplot(4, 4, 8); histogram(trialStartTS, nBins{:}); title('trialStartTS'); xlim([-1 3]);
                subplot(4, 4, 9); histogram(trialStartTSFromTrigTS, nBins{:}); title('trialStartTSFromTrigTS'); xlim([-1 3]);
                subplot(4, 4, 10); histogram(trialStartTSFromSoundTS, nBins{:}); title('trialStartTSFromSoundTS'); xlim([-4 0]);
                subplot(4, 4, 11); histogram(respCueTS, nBins{:}); title('respCueTS'); xlim([5 9]);
                subplot(4, 4, 12); histogram(respCueTSToSoundTS, nBins{:}); title('respCueTSToSoundTS'); xlim([2 6]);
                subplot(4, 4, 13); histogram(respCueTSToTrigTS, nBins{:}); title('respCueTSToTrigTS'); xlim([5 9]);
                if showHistograms > 1;
                    export_fig(sprintf('%shist_TS.png', currentSavePath), '-r150', gcf);
%                     export_fig(sprintf('%shist_TS.fig', currentSavePath), gcf);
                    close(gcf);
                end;
            end;

            %% compare AI and TS
            if showHistograms;
                figure('NumberTitle', 'off', 'Position', [100 100 1750 950], 'Name', 'TS vs AI');
                subplot(3, 3, 1); histogram(trigAI, nBins{:}); title('trigAI'); xlim([-1, 3]);
                subplot(3, 3, 2); histogram(trigTS, nBins{:}); title('trigTS'); xlim([-2, 2]);
                subplot(3, 3, 3); histogram(trigAI - trigTS, nBins{:}); title('trigAI - trigTS'); xlim([-1, 3]);

                subplot(3, 3, 4); histogram(soundAI, nBins{:}); title('soundAI'); xlim([2, 6]);
                subplot(3, 3, 5); histogram(soundTS, nBins{:}); title('soundTS'); xlim([1, 5]);
                subplot(3, 3, 6); histogram(soundAI - soundTS, nBins{:}); title('soundAI - soundTS'); xlim([-1, 3]);

                subplot(3, 3, 7); histogram(soundAI - trigAI, nBins{:}); title('sound-trig [AI]'); xlim([1, 5]);
                subplot(3, 3, 8); histogram(soundTS - trigTS, nBins{:}); title('sound-trig [TS]'); xlim([1, 5]);
                subplot(3, 3, 9); histogram((soundAI - trigAI) - (soundTS - trigTS), nBins{:}); title('soundAI-trigAI - soundTS-trigTS'); xlim([-2, 2]);
                if showHistograms > 1;
                    export_fig(sprintf('%shist_AIvsTS.png', currentSavePath), '-r150', gcf);
%                     export_fig(sprintf('%shist_AIvsTS.fig', currentSavePath), gcf);
                    close(gcf);
                end;
            end;
            
            % save stim. start frames
            save(stimStartFilePath, 'stimStartFrame');

            fprintf('    Processing animal %d %s, day %s, session %d %s: %d trial(s) done\n', iAnim, ...
                animID, dayID, iSess, sessIDs(iSess).name, nTrials);

        end;

        fprintf('  Processing animal %d %s, day %s, %d session(s) done (%3.1f sec)\n', iAnim, animID, ...
            dayID, numel(sessIDs), toc(animTic));
        
    end;
    fprintf('Processing day %s done (%3.1f sec)\n', dayID, toc(dayTic));
    
end;

warning('on', 'MATLAB:mir_warning_maybe_uninitialized_temporary');

