function OCIA_startFunction_widefieldGetStimStartFrames(this)
% OCIA_startFunction_widefieldGetStimStartFrames - [no description]
%
%       OCIA_startFunction_widefieldGetStimStartFrames(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
    
    iStartID = 9;
    iExcl = [];
    iEndID = Inf;
    iBehavStart = 2;
    iBehavEnd = Inf;

    showSinglePlots = 2;
    showAveragePlot = 2;
    showHistograms = 2;
    nBins = { 100 };
    % nBins = { 'BinMethod', 'sturges' };
    % nBins = { 'BinMethod', 'sqrt' };
    imgFrameRate = 20;

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
    set(dwh.watchTypes.behav,       'Value', 1);
    % get triplets
    IDs = get(this, 'all', { 'animal', 'day' }, DWFilterTable(this, 'rowType = WFLV session AND wfLVSess ~= \d{6}'));
    
    % make list unique
    [~, IDsStrInd] = unique(arrayfun(@(iID)sprintf('%s:::%s', IDs{iID, :}), 1 : size(IDs, 1), 'UniformOutput', false));
    IDs = IDs(IDsStrInd, :);    
    
    %% go through each animal
    for iID = max(iStartID, 1) : min(size(IDs, 1), iEndID);
        
        % do not process excluded IDs
        if ismember(iID, iExcl); continue; end;
        
        % get the IDs and set filters
        [animalID, dayID] = IDs{iID, :};
        set(dwh.filt.animalID,          'Value', 2, 'String', { '-', animalID });
        set(dwh.filt.dayID,             'Value', 2, 'String', { '-', dayID });
        
        % update the table
        DWProcessWatchFolder(this);
        
        % get behavior rows
        [~, behavRowInds] = DWFilterTable(this, 'rowType = Behavior data AND wfLVSess ~= \d{6}');
        if isempty(behavRowInds);
           showWarning(this, sprintf('OCIA:%s:NoBehavIndices', mfilename()), sprintf(...
               'Problem with animal %s, day %s, session %s (%s): no behavior index.\n', ...
               animalID, dayID, sessID, sessNum));
           continue;
        end;
        
        % process each behavior row
        for iRow = max(iBehavStart, 1) : min(numel(behavRowInds), iBehavEnd);
            iDWRow = behavRowInds(iRow);
            
            if showSinglePlots || showAveragePlot || showHistograms;
                currentSavePath = sprintf('%s%s/%s/getStimFramePlots', this.path.OCIASave, animalID, dayID);
                if exist(currentSavePath, 'dir') ~= 7; mkdir(currentSavePath); end;
                currentSavePath = sprintf('%s%s/%s/getStimFramePlots/%s_%s_', this.path.OCIASave, animalID, dayID, ...
                    regexprep(animalID, 'mou_bl_', ''), get(this, iDWRow, 'behav'));
            end;
            
            % fully load row
            DWLoadRow(this, iDWRow, 'full');
            
            % extract data for this row
            dataForRow = getData(this, iDWRow, 'behav', 'data');

            respTypes = dataForRow.respTypes;
            micrCell = dataForRow.record.micr;
            trigCell = dataForRow.record.trig;
            anInSampRate = dataForRow.anInSampRate;

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
            soundTS = dataForRow.times.sound';
            trialStartTS = dataForRow.times.trialStartCue';
            lightInTS = dataForRow.times.lightIn';
            trigTS = dataForRow.times.imgStart';
            trigEndTS = dataForRow.times.imgStopObs';
            respCueTS = dataForRow.times.lightCueOn';

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
                subplot(4, 3, 1); histogram(trigAI, nBins{:}); title('trigAI'); xlim([-1, 3]);
                subplot(4, 3, 2); histogram(trigTS, nBins{:}); title('trigTS'); xlim([-2, 2]);
                subplot(4, 3, 3); histogram(trigAI - trigTS, nBins{:}); title('trigAI - trigTS'); xlim([-1, 3]);

                subplot(4, 3, 4); histogram(soundAI, nBins{:}); title('soundAI'); xlim([2, 6]);
                subplot(4, 3, 5); histogram(soundTS, nBins{:}); title('soundTS'); xlim([1, 5]);
                subplot(4, 3, 6); histogram(soundAI - soundTS, nBins{:}); title('soundAI - soundTS'); xlim([-1, 3]);

                subplot(4, 3, 7); histogram(soundAI - trigAI, nBins{:}); title('sound-trig [AI]'); xlim([1, 5]);
                subplot(4, 3, 8); histogram(soundTS - trigTS, nBins{:}); title('sound-trig [TS]'); xlim([1, 5]);
                subplot(4, 3, 9); histogram((soundAI - trigAI) - (soundTS - trigTS), nBins{:}); title('soundAI-trigAI - soundTS-trigTS'); xlim([-2, 2]);
                if showHistograms > 1;
                    export_fig(sprintf('%shist_AIvsTS.png', currentSavePath), '-r150', gcf);
%                     export_fig(sprintf('%shist_AIvsTS.fig', currentSavePath), gcf);
                    close(gcf);
                end;
            end;
            
            % clean up by erasing data for this row
            DWFlushData(this, iDWRow, false, 'behav');
            
            % get session's path
            sessionRowPath = get(this, 'all', 'path', DWFilterTable(this, ...
                sprintf('animal = %s AND day = %s AND behav = %s AND rowType = WFLV session', animalID, dayID, ...
                get(this, iDWRow, 'behav'))));
            
            %  create Matt_files directory if not already present
            mattFilesDirPath = sprintf('%sMatt_files/', sessionRowPath);
            if exist(mattFilesDirPath, 'dir') ~= 7; mkdir(mattFilesDirPath); end;
            
            % save stim. start frames
            save(sprintf('%sstimStartFrames.mat', mattFilesDirPath), 'stimStartFrame');
            
        end;
        
    end;
    
end

