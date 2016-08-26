function analyseInterROIPSResponseCorrelations(PSROIStats, ROISet, nRuns, runFileIDs, doSavePlot)

%% TODO: THIS IS NOT FINISHED

nStims = size(PSROIStats, 2);
nPSFrames = size(PSROIStats{1, 1}, 2);
runMeanCorr = zeros(nRuns, 1);

for iStim = 1 : nStims;
    
    % get the valid ROIs as those that are non-NaNs and non-empty for this run.
    validROIs = cellfun(@(runCaTrace) nansum(isnan(runCaTrace) + runCaTrace), PSROIStats(:, iStim)) ~= 0;
    if isempty(validROIs); continue; end;
    
    % extract the IDs and ROIStats for the valid ROIs of this run
    validROIIDs = ROISet(validROIs, 1);
    nValidROIs = numel(validROIIDs);
    ROIStatsForRun = cell2mat(PSROIStats(validROIs, iStim));
    
    % calculate the correlation between ROIs
    corrMatForRun = corr(ROIStatsForRun');
    % get the mean of the correlation between ROIs
    runMeanCorr(iStim) = nanmean(corrMatForRun(:));
    
    % plot the correlation if required
    if doSavePlot;
        saveNameCorr = sprintf('%s_InterROICorr_run%02d', runFileIDs{iStim}, iStim);
        corrFig = figure('Name', saveNameCorr, 'NumberTitle', 'off');
        imagesc(corrMatForRun, [0 1]);
        hColBar = colorbar;
        set(get(hColBar, 'YLabel'), 'String', 'Inter-ROI correlation');
        set(gca, 'YTick', 1 : nValidROIs, 'YTickLabel', validROIIDs, 'XTick', 1 : nValidROIs, 'XTickLabel', validROIIDs);
        title({sprintf('Run %02d - %s - inter-ROI correlation', iStim, runFileIDs{iStim}), ...
            sprintf('Mean overall correlation: %4.2f', runMeanCorr(iStim))});
        makePrettyFigure(corrFig);

        saveFigToDir(corrFig, saveNameCorr, 'Corr', doSavePlot, 1);
    end;
    
end;
   
end
