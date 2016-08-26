function [respGLM, pvalGLM] = analyseRespGLM(ROIStats, NPilTransient, ...
    stim, ROISet, stimIDs, PSFrames, thresh, saveName, doSavePlot) %#ok<INUSL>
    
doDebugInputPlots = 0;
doDebugPlots = 0;

nROIs = size(ROIStats, 1);
nStims = size(stimIDs, 1);
nFrames = size(stim, 2);

respGLM = nan(nROIs, nStims);
% respErrGLM = nan(nROIs, nStims);
pvalGLM = nan(nROIs, nStims);
residGLM = nan(nROIs, nFrames);

% %% create a single transient
% ca_p_scale = 6;
% data_time = 1 : 17;
% ca_p_onsetposition = 1;
% ca_p_onsettau = 2;
% ca_p_amp1 = 1;
% ca_p_tau1 = 4;
% ca_p_amp2 = 1;
% ca_p_tau2 = 1;
% 
% transient = ca_p_scale .* (1 - exp( -(data_time - ca_p_onsetposition) ./ ca_p_onsettau)) .* ...
%           (ca_p_amp1 .* exp( -(data_time - ca_p_onsetposition) ./ ca_p_tau1) + ...
%           ca_p_amp2 .* exp( -(data_time - ca_p_onsetposition) ./ ca_p_tau2));
      
transient = NPilTransient - min(NPilTransient);
% NPilNorm = NPilTransient - min(NPilTransient);
% peakFrame = find(diff(NPilNorm, 2) == min(diff(NPilNorm, 2))) + 1;
% transient = gaussmf(1 : numel(NPilNorm), [var(NPilNorm) * 1.8, peakFrame]) * max(NPilNorm);
% transient([1 end]) = 0;

if doDebugInputPlots;
    hFig = figure('Name', 'Gaussian based on NPil', 'NumberTitle', 'off'); %#ok<*UNRCH>
    if exist('NPilNorm', 'var')
        plot((1 : numel(NPilNorm)) / 10, NPilNorm);
        hold on;
        plot(((1 : numel(transient))) / 10, transient, 'r');
        legend('NPilNorm', 'Gaussian');
        hold off;
    else
        plot(((1 : numel(transient))) / 10, transient);
        title('NeuroPil transient for GLM');
    end;
    xlabel('Time [s]'); ylabel('dRR [%]');
    makePrettyFigure();
    saveFigToDir(hFig, sprintf('%s_Transient', saveName), 'GLM', doDebugInputPlots, 1, 1);
end;
      
%% each stimulus is a different predictor
convStims = zeros(nFrames, nStims);
for iStim = 1 : nStims;
    convStim = conv(transient, double(stim == iStim));
    convStims(:, iStim) = convStim(1 : nFrames);
end;

if doDebugInputPlots;
    hFig = figure('Name', 'Stimulus-wise convolution', 'NumberTitle', 'off');
    cMap = jet(nStims);
    plotHands = plot(convStims);
    for i = 1 : numel(plotHands); set(plotHands(i), 'Color', cMap(i, :)); end;
    maxY = max(convStims(:));
    for i = 1 : numel(stim); if stim(i); line([i i], [0 maxY], 'Color', 'k'); end; end;
    saveFigToDir(hFig, sprintf('%s_stimInputModel', saveName), 'GLM', doDebugInputPlots, 1, 1);
end;

% %% each tone is a different predictor
% stimTimes = find(stim);
% nTones = numel(stimTimes);
% convTones = zeros(nFrames, nTones);
% for iTone = 1 : nTones;
%     toneStim = zeros(1, nFrames);
%     toneStim(stimTimes(iTone)) = 1;
%     convTone = conv(transient, toneStim);
%     convTones(:, iTone) = convTone(1 : nFrames);
% end;
% 
% if doDebugInputPlots;
%     figure('Name', 'Tone-wise convolution', 'NumberTitle', 'off');
%     cMap = jet(nTones);
%     plotHands = plot(convTones);
%     for i = 1 : numel(plotHands); set(plotHands(i), 'Color', cMap(i, :)); end;
%     saveFigToDir(hFig, sprintf('%s_toneInputModel', saveName), 'GLM', doDebugInputPlots, 1, 1);
% end;


%% calculate the GLM
% go trough each ROI
for iROI = 1 : nROIs;
    caTrace = ROIStats(iROI, :)';
%     caTrace = caTrace - min(caTrace);
    caTrace = caTrace - prctile(caTrace, 5);
    
    % stim-wise fit
    [~, ~, statsStims] = glmfit(convStims, caTrace);
    respGLM(iROI, :) = statsStims.t((1 : nStims) + 1);
%     respErrGLM(iROI, :) = statsStims.se((1 : nStims) + 1);
    pvalGLM(iROI, :) = statsStims.p((1 : nStims) + 1);
    residGLM(iROI, :) = statsStims.resid;
    
%     % tone-wise fit
%     [~, ~, statsTones] = glmfit(convTones, caTrace);
%     % group the betas
%     beta = statsTones.beta((1 : nTones) + 1);
%     pvals = statsTones.p((1 : nTones) + 1);
%     stimBeta = arrayfun(@(iStim)mean(beta(stim(stim > 0) == iStim)), 1 : nStims);
%     stimBetaSEM = arrayfun(@(iStim)sem(beta(stim(stim > 0) == iStim)), 1 : nStims);
%     stimBetaPVal = arrayfun(@(iStim)mean(pvals(stim(stim > 0) == iStim)), 1 : nStims);
%     respGLM(iROI, :) = stimBeta;
%     respErrGLM(iROI, :) = stimBetaSEM;
%     pvalGLM(iROI, :) = stimBetaPVal;
%     residGLM(iROI, :) = statsTones.resid;
    
    if doDebugPlots;
        
        %% create the model of the GLM
        caTraceModelStims = glmval(statsStims.beta, convStims, 'identity');
%         caTraceModelTones = glmval(statsTones.beta, convTones, 'identity');
        
        %% residual analysis
        hFig = figure('Name', sprintf('Residual analysis for ROI%s', ROISet{iROI, 1}), 'NumberTitle', 'off');
        t = (1 : nFrames) / 10; % frame rate hard coded
        plot(t, caTrace, 'b');
        hold on;
        plot(t, caTraceModelStims, 'r');
%         plot(t, caTraceModelTones, 'g');
        hold off;
        title(sprintf('Residual analysis for ROI%s', ROISet{iROI, 1}));
        xlabel('Time [s]'); ylabel('dRR [%]');
        legend('Raw calcium trace', 'Model for frequency');
%         legend('Raw calcium trace', 'Model for frequency', 'Model for tones');
        saveFigToDir(hFig, sprintf('%s_residROI%s', saveName, ROISet{iROI, 1}), 'GLM', doDebugInputPlots, 1, 1);
        
        %% PS average
        % get the unique stim IDs without the 0
        uniqueStims = unique(stim);
        uniqueStims(uniqueStims == 0) = [];
        
        % extract the peri-stimulus calcium traces
        PSROIStatsCaTrace = extractPSTraceSingleTrace(caTrace', stim, uniqueStims, PSFrames.base, PSFrames.evoked);
        PSROIStatsModelStims = extractPSTraceSingleTrace(caTraceModelStims', stim, uniqueStims, ...
            PSFrames.base, PSFrames.evoked);
%         PSROIStatsModelTones = extractPSTraceSingleTrace(caTraceModelTones', stim, uniqueStims, ...
%             PSFrames.base, PSFrames.evoked);
        
        % average all trials for each stim
        PSAvgCaTrace = cell2mat(cellfun(@mean, PSROIStatsCaTrace(1, :), 'UniformOutput', false)');
        PSAvgModelStims = cell2mat(cellfun(@mean, PSROIStatsModelStims(1, :), 'UniformOutput', false)');
%         PSAvgModelTones = cell2mat(cellfun(@mean, PSROIStatsModelTones(1, :), 'UniformOutput', false)');
        
        % substract the baseline of the average
        minBaseLineCaTrace = min(PSAvgCaTrace(:, 1 : PSFrames.base), [], 2);
        PSAvgCaTrace = PSAvgCaTrace - repmat(minBaseLineCaTrace, 1, PSFrames.base + PSFrames.evoked);
        minBaseLineModelStims = min(PSAvgModelStims(:, 1 : PSFrames.base), [], 2);
        PSAvgModelStims = PSAvgModelStims - repmat(minBaseLineModelStims, 1, PSFrames.base + PSFrames.evoked);
%         minBaseLineModelTones = min(PSAvgModelTones(:, 1 : PSFrames.base), [], 2);
%         PSAvgModelTones = PSAvgModelTones - repmat(minBaseLineModelTones, 1, PSFrames.base + PSFrames.evoked);
        
        % get the error as the SEM of the trials
        PSErrCaTrace = cell2mat(cellfun(@sem, PSROIStatsCaTrace(1, :), 'UniformOutput', false)');
%         PSErrModelStims = cell2mat(cellfun(@sem, PSROIStatsModelStims(1, :), 'UniformOutput', false)');
%         PSErrModelTones = cell2mat(cellfun(@sem, PSROIStatsModelTones(1, :), 'UniformOutput', false)');
        
        % plot the overlay of the original trace and the models
        PSTime = ((1 : (PSFrames.base + PSFrames.evoked)) - PSFrames.base) / 10; % hard coded stuff here
        for iStim = 1 : nStims;
            hFig = figure('Name', sprintf('PSAvg for ROI%s - %s', ROISet{iROI, 1}, stimIDs{iStim}), 'NumberTitle', 'off');
            hold on;
            errorbar(PSTime, PSAvgCaTrace(iStim, :), PSErrCaTrace(iStim, :), 'b');
            plot(PSTime + 0.02, PSAvgModelStims(iStim, :), 'r');
%             errorbar(PSTime + 0.04, PSAvgModelTones(iStim, :), PSErrModelTones(iStim, :), 'g');
            hold off;
            title(sprintf('PSAvg for ROI%s - %s', ROISet{iROI, 1}, stimIDs{iStim}));
%             legend('CaTrace', 'ModelStims', 'ModelTones');
            legend('CaTrace', 'ModelStims');
            xlabel('Time [s]'); ylabel('dRR [%] or beta [a.u.]');
%             makePrettyFigure(gcf);
            saveFigToDir(hFig, sprintf('%s_PSAvgROI%sStim%s', saveName, ROISet{iROI, 1}, stimIDs{iStim}), ...
                'GLM', doDebugInputPlots, 1, 1);
        end;
        
        %% tuning curve
        hFig = figure('Name', sprintf('Tuning curve for ROI%s', ROISet{iROI, 1}), 'NumberTitle', 'off');
        % tunings
        tuningRawMax = max(PSAvgCaTrace(:, PSFrames.base + 1 : end), [], 2);
        tuningRawSum = sum(PSAvgCaTrace(:, PSFrames.base + 1 : end), 2);
        tuningStims = statsStims.beta((1 : nStims) + 1);
        % tunings error
        tuningRawSEM = sem(PSAvgCaTrace(:, PSFrames.base + 1 : end), 2);
        tuningStimsSE = statsStims.se((1 : nStims) + 1);
        % normalizations
        tuningRawMaxNorm = tuningRawMax / max(tuningRawMax);
        tuningRawSumNorm = tuningRawSum / max(tuningRawSum);
        tuningStimsNorm = tuningStims / max(tuningStims);
        tuningRawSEMNorm = tuningRawSEM / (max(tuningRawMax) / max(tuningRawMaxNorm));
        tuningStimsSENorm = tuningStimsSE / (max(tuningStims) / max(tuningStimsNorm));
        % plotting
        errorbar(1 : nStims, tuningRawMaxNorm, tuningRawSEMNorm, 'b');
        hold on;
        errorbar((1 : nStims) + 0.1, tuningRawSumNorm, tuningRawSEMNorm, 'r');
        errorbar((1 : nStims) + 0.2, tuningStimsNorm, tuningStimsSENorm, 'g');
        hold off;
        title(sprintf('Tuning curve for ROI%s', ROISet{iROI, 1}));
        xlabel('Frequency');
%         ylabel('beta \pm SE or SEM');
        ylabel('tuning (beta/max/sum) \pm SE/SEM');
%         legend('GLM''s beta \pm SE for each frequency', 'GLM''s beta \pm SEM for each tone');
        legend('Tuning of raw data as MAX of evoked average response', ...
            'Tuning of raw data as SUM of evoked average response', 'GLM''s beta \pm SE for each frequency', ...
            'Location', 'NorthOutside');
        saveFigToDir(hFig, sprintf('%s_tuningROI%s', saveName, ROISet{iROI, 1}), 'GLM', doDebugInputPlots, 1, 1);
        
    end;
end;


%% plotting
if doSavePlot;

    figImagesc = plotGenericROIStimHeatMap(pvalGLM, [0 thresh], strrep([saveName '_pval'], '_', '\_'), ...
        stimIDs, ROISet(:, 1), 'p-value', saveName, 'GLM', 1, '', []);
    colormap('hot');
    saveFigToDir(figImagesc, [saveName '_pval'], 'GLM', doSavePlot, 1, 1);
    
    figImagesc = plotGenericROIStimHeatMap(respGLM, [], strrep([saveName '_b'], '_', '\_'), ...
        stimIDs, ROISet(:, 1), 'beta', saveName, 'GLM', 1, '', []);
    colormap('hot');
    saveFigToDir(figImagesc, [saveName '_beta'], 'GLM', doSavePlot, 1, 1);

end;
   
end
