function resp = analyseCrossCorr(PSStats, frameRate, PSFrames, doPlot)

%% init
dbgLevel = 0;

nROIs = size(PSStats, 1);
nStims = size(PSStats, 2);

stimStartFrame = PSFrames.base;
%TODO: remove hard coded 1 second base and evoked frame bins!
nBaseFrames = round(1 * frameRate);
nEvokedFrames = round(1 * frameRate);
% stimDur = 0.2;
%TODO: pass config.PSFrames.evoked frames to extract stimEvokedFrames?
evokedDur = 0.5;
stimEvokedFrames = round(stimStartFrame : (stimStartFrame + evokedDur * frameRate));
nLagFrames = max(nBaseFrames, nEvokedFrames);
ccEvokedFrames = nLagFrames : (nLagFrames + evokedDur * frameRate);

% crossCorrThreshold = 0.3;
% crossCorrThreshold = 0.28;
% crossCorrThreshold = 0.1;

signifLevel = 0.001;

o('#analyseCrossCorr: %d ROI(s), %d stim(s), frameRate: %.2f', nROIs, nStims, frameRate, 1, dbgLevel);

%% run
crossCorrs = nan(nLagFrames * 2 + 1, nROIs, nStims);
pVals = nan(nLagFrames * 2 + 1, nROIs, nStims);
for iStim = 1 : nStims;
    for iROI = 1 : nROIs;
        ROIPSAvg = mean(PSStats{iROI, iStim});
        stimVect = zeros(1, numel(ROIPSAvg));
        stimVect(stimEvokedFrames) = 1;
        [cc, p] = xcorr_mc(ROIPSAvg, stimVect, nLagFrames, 5);
        crossCorrs(:, iROI, iStim) = cc;
        pVals(:, iROI, iStim) = p;
        o('#analyseCrossCorr: ROI %d, stim %d', iROI, iStim, 2, dbgLevel);
    end;
end;

%% calculate threshold
% meanEvokedCC = squeeze(nanmean(nanmean(crossCorrs(1 : lags, :, :), 2), 3)); % average ROIs & stims
% meanEvokedCC = squeeze(nanmean(crossCorrs(1 : lags, :, :), 2)); % average ROIs
% get the threshold for each ROI as the mean of the base cross correlation for all stims (average)
meanBaseCrossCorr = squeeze(nanmean(crossCorrs(1 : nLagFrames, :, :), 3)); % average stims
thresh = nanmean(meanBaseCrossCorr) + 1.96 * nanstd(meanBaseCrossCorr); % exceeds the threshold with a 95% CI

%% set responsiveness
% only use significant cross correlation values
signifCrossCorrs = crossCorrs;
signifCrossCorrs(pVals > (signifLevel / size(signifCrossCorrs, 1))) = NaN;
% get the maximum evoked cross correlation
maxEvokedResp = squeeze(nanmax(signifCrossCorrs(ccEvokedFrames, :, :), [], 1));
% store max responsiveness values
resp = maxEvokedResp;
% only keep values that are higher than the threshold
resp(resp < repmat(thresh', 1, nStims)) = NaN;

%% plot
if doPlot;
    
    %% plot corrs as line series
    for iStim = 1 : nStims;
        figure('Name', sprintf('Cross-correlation of mean trace - stim %d', iStim), 'NumberTitle', 'off');
        hold on;
        cols = jet(nROIs);
        cols(isnan(resp(:, iStim)), :) = repmat(0.8, sum(isnan(resp(:, iStim))), 3);
        for iROI = 1 : nROIs;
            cc = squeeze(crossCorrs(:, iROI, iStim));
            plot(cc, 'DisplayName', iROI, 'Color', cols(iROI, :));
            plot([1 numel(cc)], repmat(thresh(iROI), 1, 2), 'Color', cols(iROI, :), 'LineStyle', ':');
        end;
        ylim([0, 1]);
        yLims = get(gca, 'YLim');
        boxCol = [0 0 0];
        rectangle('Position', [ccEvokedFrames(1), yLims(1) + 0.01, ...
            ccEvokedFrames(end) - ccEvokedFrames(1), diff(yLims) - 0.02], ...
            'FaceColor', 'none', 'EdgeColor', boxCol);
        title(sprintf('Stim %d', iStim));
    end;
    
    %% plot corrs as heat map
    figH = plotPSAllStimROIHeatMapSubPlot('crossCorrHeatMap', crossCorrs, nBaseFrames, ...
        num2cell(1 : nStims), [0 max(crossCorrs(:))]);
    childH = get(figH, 'Children');
    childHStim = childH([5 4]);
    for iStim = 1 : 2;
        axes(childHStim(iStim)); %#ok<LAXES>
        hold on;
        for iROI = 1 : nROIs;
            if ~isnan(resp(iROI, iStim));
                text(0, (nROIs - iROI) + 1 + 0.25, '*', 'FontSize', 150 / nROIs + 11, 'Color', [0 0 1]);
            end;
        end;
        hold off;
    end;
    
    %% responses
    figure('Name', 'Responding ROIs', 'NumberTitle', 'off');
    imagesc(resp, [0 1]);
    colorbar
end;

end