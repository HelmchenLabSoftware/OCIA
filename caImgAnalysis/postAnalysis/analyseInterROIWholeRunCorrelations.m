function runCorr = analyseInterROIWholeRunCorrelations(ROIStats, ROISet, saveName, ...
    nRuns, runFileIDs, sortMethod, doSavePlot)

nROIs = size(ROISet, 1);
runCorr = nan(nRuns, nROIs, nROIs);


% go through all runs
for iRun = 1 : nRuns;
    
    % get the valid ROIs as those that are non-NaNs and non-empty for this run.
    validROIs = cellfun(@(runCaTrace) nansum(isnan(runCaTrace) + runCaTrace), ROIStats(:, iRun)) ~= 0;
    if isempty(validROIs) || ~any(validROIs); continue; end;
    
    % extract the IDs and ROIStats for the valid ROIs of this run
    validROIIDs = ROISet(validROIs, 1);
    ROIStatsForRun = cell2mat(ROIStats(validROIs, iRun));
    
    % calculate the correlation between ROIs
    corrMatForRun = corr(ROIStatsForRun', 'rows', 'pairwise');
    runCorr(iRun, validROIs, validROIs) = corrMatForRun;
    % get the mean of the correlation between ROIs
    runMeanCorr = nanmean(corrMatForRun(:));
    
    plotGenericROIStimHeatMap(corrMatForRun, [0, 1], {sprintf('Run %02d - %s - inter-ROI correlation', iRun, ...
        runFileIDs{iRun}), sprintf('Mean overall correlation: %4.2f', runMeanCorr)}, validROIIDs, ...
        validROIIDs, 'Inter-ROI correlation', sprintf('%s_%s_run%02d', runFileIDs{iRun}, saveName, iRun), ...
        'InterROICorr', doSavePlot, sortMethod, [1 2]);
    
end;
   
end
