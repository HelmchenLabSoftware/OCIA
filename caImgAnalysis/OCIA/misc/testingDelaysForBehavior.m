
respTypes = out.respTypes;
micrCell = out.record.micr;
trigCell = out.record.trig;

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
nMaxSample = max(nSamples);

t = (1 : nMaxSample) / out.anInSampRate;

avgMicrHit = zeros(nMaxSampleHit, 1);
avgMicrCR = zeros(nMaxSampleCR, 1);

showSinglePlots = false;

% [30 160 1215 460]
avgFig = figure('NumberTitle', 'off', 'Position', [100 100 1750 950]); % 100 100 1750 950
for iTrial = 1 : nTrials;
    
    if respTypes(iTrial) ~= 1 && respTypes(iTrial) ~= 2; continue; end;
    
    micrForTrial = linScale(abs(micrCell{iTrial}'));
    begRange = round(nSamples(iTrial) * 0.01 : nSamples(iTrial) * 0.1);
    soundYThresh = 0.09;
    upSamples = [0 find(micrForTrial > soundYThresh)];
    upSamplesDiff = diff(upSamples);
    ISI = 0.5;
    minISI = ISI * 0.5 * out.anInSampRate;
    soundStartInds = upSamples(find(upSamplesDiff >= minISI) + 1);
    if ~isempty(soundStartInds);
        soundAI(iTrial) = soundStartInds(1) / out.anInSampRate;
    end;
    
    trigData = trigCell{iTrial}; % extract the triger's trace
    normThresh = 0.05; % take the first frames for normalization threshold
    trigData(abs(trigData) < normThresh) = 0; % normalize to remove the noise of parts when there is no trigger
    trigTop = find(abs(trigData(1 : round(nSamplesTrig(iTrial) * 0.5))) > 0); % find all the peaks

    % get the trigger delay
    if ~isempty(trigTop);
        trigInd = trigTop(1);
        trigAI(iTrial) = trigInd / out.anInSampRate;
    end;
    
    trigTopEnd = find(abs(trigData(round(nSamplesTrig(iTrial) * 0.5) : end)) > 0);
    if ~isempty(trigTopEnd);
        trigIndEnd = trigTopEnd(1) + round(nSamplesTrig(iTrial) * 0.5);
        trigEndAI(iTrial) = trigIndEnd / out.anInSampRate;
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
        end;

        figure(avgFig);
        subplot(2, 1, 1);
        hold on;
        plot(repmat(soundAI(iTrial), 1, 2), [-9.8 9.8], 'Color', [0 0 0], 'LineWidth', 0.5);
        plot(repmat(trigAI(iTrial), 1, 2), [-9.8 9.8], 'Color', [0 0 0], 'LineWidth', 0.5, 'LineStyle', ':');
        plot(repmat(trigEndAI(iTrial), 1, 2), [-9.8 9.8], 'Color', [0 0 0], 'LineWidth', 0.5, 'LineStyle', ':');
        ylim([-9.8 9.8]);
        xlim([-0.5, 15.5]);
        
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
        end;
        
        figure(avgFig);
        subplot(2, 1, 2);
        hold on;
        plot(repmat(trigAI(iTrial), 1, 2), [-9.8 9.8], 'Color', [0 0 0], 'LineWidth', 0.5, 'LineStyle', ':');
        plot(repmat(soundAI(iTrial), 1, 2), [-9.8 9.8], 'Color', [0 0 0], 'LineWidth', 0.5);
        plot(repmat(trigEndAI(iTrial), 1, 2), [-9.8 9.8], 'Color', [0 0 0], 'LineWidth', 0.5, 'LineStyle', ':');
        
        ylim([-9.8 9.8]);
        xlim([-0.5, 15.5]);
        
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

subplot(2, 1, 1);
hold on;
plot(t(1 : nMaxSampleHit), avgMicrHit, 'Color', [1 0 0], 'LineWidth', 2);
subplot(2, 1, 2);
hold on;
plot(t(1 : nMaxSampleCR), avgMicrCR, 'Color', [0 1 0], 'LineWidth', 2);

% figure();
% subplot(2, 1, 1);
% shadedErrorBar(t(1 : nMaxSampleHit), avgMicrHit, sgolayfilt(stdMicrHit, 1, 3), { 'Color', [1 0 0], 'LineWidth', 2 }, 1, gcf, gca);
% subplot(2, 1, 2);
% shadedErrorBar(t(1 : nMaxSampleCR), avgMicrCR, sgolayfilt(stdMicrCR, 1, 3), { 'Color', [0 1 0], 'LineWidth', 2 }, 1, gcf, gca);

%% compare analog in times (AI)
nBins = { 100 };
% nBins = { 'BinMethod', 'sturges' };
% nBins = { 'BinMethod', 'sqrt' };
soundAIFromTrigAI = soundAI - trigAI;
imgFrameRate = 20;
stimStartFrame = round(soundAIFromTrigAI * imgFrameRate);
soundAIFromTrigEndAI = soundAI - trigEndAI;
trigAIToTrigEndAI = trigEndAI - trigAI;
figure('NumberTitle', 'off', 'Position', [100 100 1750 950], 'Name', 'All trials AI');
subplot(2, 3, 1); histogram(soundAI, nBins{:}); title('soundAI'); xlim([2 6]);
subplot(2, 3, 2); histogram(trigAI, nBins{:}); title('trigAI'); xlim([-1 3]);
subplot(2, 3, 3); histogram(trigEndAI, nBins{:}); title('trigEndAI'); xlim([12 16]);
subplot(2, 3, 4); histogram(soundAIFromTrigAI, nBins{:}); title('soundAIFromTrigAI'); xlim([1 5]);
subplot(2, 3, 5); histogram(soundAIFromTrigEndAI, nBins{:}); title('soundAIFromTrigEndAI'); xlim([-12 -8]);
subplot(2, 3, 6); histogram(trigAIToTrigEndAI, nBins{:}); title('trigAIToTrigEndAI'); xlim([11 15]);

%% compare time stamps from TS (time stamp)
soundTS = out.times.sound';
trialStartTS = out.times.trialStartCue';
lightInTS = out.times.lightIn';
trigTS = out.times.imgStart';
trigEndTS = out.times.imgStopObs';
respCueTS = out.times.lightCueOn';

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

%% compare AI and TS
nBins = { 100 };
% nBins = { 'BinMethod', 'sturges' };
% nBins = { 'BinMethod', 'sqrt' };
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

%%
figure('NumberTitle', 'off', 'Position', [100 100 1750 950], 'Name', 'HIT trials');
subplot(2, 2, 1); histogram(soundAI(respTypes == 1), 100); title('soundAI');
subplot(2, 2, 2); histogram(trigAI(respTypes == 1), 100); title('trigAI');
subplot(2, 2, 3); histogram(soundAIFromTrigAI(respTypes == 1), 100); title('soundAIFromTrigAI');

figure('NumberTitle', 'off', 'Position', [100 100 1750 950], 'Name', 'CR trials');
subplot(2, 2, 1); histogram(soundAI(respTypes == 2), 100); title('soundAI');
subplot(2, 2, 2); histogram(trigAI(respTypes == 2), 100); title('trigAI');
subplot(2, 2, 3); histogram(soundAIFromTrigAI(respTypes == 2), 100); title('soundAIFromTrigAI');

%%
figure('NumberTitle', 'off', 'Position', [100 100 1750 950], 'Name', 'Times based on analog in - all trials');
hold on;
plot(soundAI(~isnan(soundAI)), 'k');
plot(trigAI(~isnan(trigAI)), 'b');
plot(soundAIFromTrigAI(~isnan(soundAIFromTrigAI)), 'r');
legend(sprintf('soundAI %.2f\\pm%.2f', nanmean(soundAI), nanstd(soundAI)), ...
    sprintf('trigAI %.2f\\pm%.2f', nanmean(trigAI), nanstd(trigAI)), ...
    sprintf('soundAIFromTrigAI %.2f\\pm%.2f', nanmean(soundAIFromTrigAI), nanstd(soundAIFromTrigAI)), ...
    'Location', 'NorthOutside')

figure('NumberTitle', 'off', 'Position', [100 100 1750 950], 'Name', 'Times based on analog in - HIT trials');
hold on;
plot(soundAI(respTypes == 1), 'k');
plot(trigAI(respTypes == 1), 'b');
plot(soundAIFromTrigAI(respTypes == 1), 'r');
legend(sprintf('soundAI %.2f\\pm%.2f', nanmean(soundAI(respTypes == 1)), nanstd(soundAI(respTypes == 1))), ...
    sprintf('trigAI %.2f\\pm%.2f', nanmean(trigAI(respTypes == 1)), nanstd(trigAI(respTypes == 1))), ...
    sprintf('soundAIFromTrigAI %.2f\\pm%.2f', nanmean(soundAIFromTrigAI(respTypes == 1)), nanstd(soundAIFromTrigAI(respTypes == 1))), ...
    'Location', 'NorthOutside')

figure('NumberTitle', 'off', 'Position', [100 100 1750 950], 'Name', 'Times based on analog in - CR trials');
hold on;
plot(soundAI(respTypes == 2), 'k');
plot(trigAI(respTypes == 2), 'b');
plot(soundAIFromTrigAI(respTypes == 2), 'r');
legend(sprintf('soundAI %.2f\\pm%.2f', nanmean(soundAI(respTypes == 2)), nanstd(soundAI(respTypes == 2))), ...
    sprintf('trigAI %.2f\\pm%.2f', nanmean(trigAI(respTypes == 2)), nanstd(trigAI(respTypes == 2))), ...
    sprintf('soundAIFromTrigAI %.2f\\pm%.2f', nanmean(soundAIFromTrigAI(respTypes == 2)), nanstd(soundAIFromTrigAI(respTypes == 2))), ...
    'Location', 'NorthOutside')
