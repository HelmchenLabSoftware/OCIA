function allTrialsMeanCorr = analyseInterTrialCorrelation(PSROIStats, ROISet, psFrames, stimIDs, ...
    trialSortMethod, meanSortMethod, saveName, doSavePlot)

%% Initialization
% get the maximum number of "trials" (repetitions) for each ROI and each stim
nMaxTrials = max(cellfun(@(c) size(c, 1), PSROIStats(:)));
nStims = size(PSROIStats, 2);
nROIs = size(ROISet, 1);

% init the matrix holding the correlations with the extra columns for summary stats (mean, max, etc)
nExtraColCorr = 4;
nExtraColMeanCorr = 2;
allTrialsCorr = nan(nMaxTrials * (nStims + nExtraColCorr), nMaxTrials * (nROIs + nExtraColCorr));
allTrialsMeanCorr = nan(nStims, nROIs);
allTrialsMeanCorrForPlot = nan(nStims + nExtraColMeanCorr, nROIs + nExtraColMeanCorr);

%% Stim loop
% go through all stimulus first
for iStim = 1 : nStims;
    
    % create the range of indexes to use for this stim, by steps of 'nMaxTrials'
    allTrialsStimRange = (iStim - 1) * nMaxTrials + 1 : iStim * nMaxTrials;
    
    % get the valid ROIs as thos with a non-NaN and non-empty trace
    validROIs = cellfun(@(runCaTrace) sum(isnan(runCaTrace(:)) + runCaTrace(:)), PSROIStats(:, iStim)) ~= 0;
    
    %% ROI loop
    % for the current stim, go through all ROIs
    for iROI = 1 : nROIs;
        
        % if it's a non-valid ROI, skip it and leave the correlations to NaN
        if ~validROIs(iROI); continue; end;
        
        % create the range of indexes to use for this ROI, by steps of 'nMaxTrials'
        allTrialsROIRange = (iROI - 1) * nMaxTrials + 1 : iROI * nMaxTrials;
        % get the peri-stimulus ROIStats for this ROI with this stim
        PSROIStatsForStimROI = cell2mat(PSROIStats(iROI, iStim));
        % get the number of trials for this stim-ROI combination
        nTrials = size(PSROIStatsForStimROI, 1);
        % calculate the correlation on the evoked part of the peri-stimulus
        corrMatForStimROI = corr(PSROIStatsForStimROI(:, psFrames.base + 1 : end)');
        % set the diagonal to NaN to exclude it from the max and the mean calculations
        corrMatForStimROI(logical(eye(size(corrMatForStimROI)))) = NaN;
        
        %% Sorting of the trials
        % sort the trials within this stim-ROI combination using the specified method
        if strcmp(trialSortMethod, 'max');
            [~, nTrialIDs] = sort(max(corrMatForStimROI));
        elseif strcmp(trialSortMethod, 'mean');
            [~, nTrialIDs] = sort(nanmean(corrMatForStimROI));
        elseif strcmp(trialSortMethod, 'sum');
            [~, nTrialIDs] = sort(nansum(corrMatForStimROI));
        elseif strcmp(trialSortMethod, 'med');
            [~, nTrialIDs] = sort(nanmed(corrMatForStimROI));
        else % if no sort is required, leave it in original order
            nTrialIDs = 1 : nTrials;
        end;
        % apply the sorting
        corrMatForStimROI = corrMatForStimROI(nTrialIDs, nTrialIDs);
        
        %% Storing in the holder matrices
        % store the correlation for this stim-ROI combination in the 'allTrials' matrix
        allTrialsCorr(allTrialsStimRange, allTrialsROIRange) = corrMatForStimROI;
        % store the mean value of the correlation for this stim-ROI combination in the 'allTrialsMean' matrix
        allTrialsMeanCorr(iStim, iROI) = nanmean(corrMatForStimROI(:));
        
    end;
    
    %% Mean/Max/etc. stats calculations for each stim
    % calculate the statistics for the correlations of this stim accross all ROIs
    repsForStimAllROIs = allTrialsCorr(allTrialsStimRange, :);
    % mean for each trial within this stim accross all ROIs
    allTrialsCorr(allTrialsStimRange, (nROIs + 1 - 1) * nMaxTrials + 1 : (nROIs + 1) * nMaxTrials) = ...
        repmat(nanmean(repsForStimAllROIs, 2), 1, nMaxTrials);
    % max for each trial within this stim accross all ROIs
    allTrialsCorr(allTrialsStimRange, (nROIs + 2 - 1) * nMaxTrials + 1 : (nROIs + 2) * nMaxTrials) = ...
        repmat(max(repsForStimAllROIs, [], 2), 1, nMaxTrials);
    % mean for all trials within this stim accross all ROIs (1 value)
    allTrialsCorr(allTrialsStimRange, (nROIs + 3 - 1) * nMaxTrials + 1 : (nROIs + 3) * nMaxTrials) = ...
        repmat(nanmean(repsForStimAllROIs(:)), nMaxTrials, nMaxTrials);
    % max for all trials within this stim accross all ROIs (1 value)
    allTrialsCorr(allTrialsStimRange, (nROIs + 4 - 1) * nMaxTrials + 1 : (nROIs + 4) * nMaxTrials) = ...
        repmat(max(repsForStimAllROIs(:)), nMaxTrials, nMaxTrials);

    % calculate the statistics for the mean of the correlations of this stim accross all ROIs
    % mean of all ROIs for this stim
    allTrialsMeanCorrForPlot(iStim, nROIs + 1) = nanmean(allTrialsMeanCorr(iStim, 1 : nROIs));
    % max of all ROIs for this stim
    allTrialsMeanCorrForPlot(iStim, nROIs + 2) = max(allTrialsMeanCorr(iStim, 1 : nROIs));
    
end;

allTrialsMeanCorrForPlot(1 : nStims, 1 : nROIs) = allTrialsMeanCorr;

%% Mean/Max/etc. stats calculations for each ROI
for iROI = 1 : nROIs;
    
    % create the range of indexes to use for this ROI, by steps of 'nMaxTrials'
    allTrialROIRange = (iROI - 1) * nMaxTrials + 1 : iROI * nMaxTrials;
    
    % calculate the statistics for the correlations of this ROI accross all stims
    repsForROIAllStims = allTrialsCorr(:, allTrialROIRange);
    % mean for each trial within this ROI accross all stims
    allTrialsCorr((nStims + 1 - 1) * nMaxTrials + 1 : (nStims + 1) * nMaxTrials, allTrialROIRange) = ...
        repmat(nanmean(repsForROIAllStims, 1), nMaxTrials, 1);
    % max for each trial within this ROI accross all stims
    allTrialsCorr((nStims + 2 - 1) * nMaxTrials + 1 : (nStims + 2) * nMaxTrials, allTrialROIRange) = ...
        repmat(max(repsForROIAllStims), nMaxTrials, 1);
    % mean for all trials within this ROI accross all stims (1 value)
    allTrialsCorr((nStims + 3 - 1) * nMaxTrials + 1 : (nStims + 3) * nMaxTrials, allTrialROIRange) = ...
        repmat(nanmean(repsForROIAllStims(:)), nMaxTrials, nMaxTrials);
    % max for all trials within this ROI accross all stims (1 value)
    allTrialsCorr((nStims + 4 - 1) * nMaxTrials + 1 : (nStims + 4) * nMaxTrials, allTrialROIRange) = ...
        repmat(max(repsForROIAllStims(:)), nMaxTrials, nMaxTrials);
    
    % calculate the statistics for the mean of the correlations of this ROI accross all stims
    % mean of all stims for this ROI
    allTrialsMeanCorrForPlot(nStims + 1, iROI) = nanmean(allTrialsMeanCorr(1 : nStims, iROI));
    % max of all stims for this ROI
    allTrialsMeanCorrForPlot(nStims + 2, iROI) = max(allTrialsMeanCorr(1 : nStims, iROI));
    
end;

%% Sorting of the mean of the trials
if strcmp(meanSortMethod, 'mean');
    [~, ROISortIndexes] = sort(nanmean(allTrialsMeanCorrForPlot(1 : nStims, 1 : nROIs)));
    [~, stimSortIndexes] = sort(nanmean(allTrialsMeanCorrForPlot(1 : nStims, 1 : nROIs), 2));
elseif strcmp(meanSortMethod, 'max');
    [~, ROISortIndexes] = sort(max(allTrialsMeanCorrForPlot(1 : nStims, 1 : nROIs)));
    [~, stimSortIndexes] = sort(max(allTrialsMeanCorrForPlot(1 : nStims, 1 : nROIs), [], 2));
elseif strcmp(meanSortMethod, 'sum');
    [~, ROISortIndexes] = sort(nansum(allTrialsMeanCorrForPlot(1 : nStims, 1 : nROIs)));
    [~, stimSortIndexes] = sort(nansum(allTrialsMeanCorrForPlot(1 : nStims, 1 : nROIs), 2));
elseif strcmp(meanSortMethod, 'med');
    [~, ROISortIndexes] = sort(nanmed(allTrialsMeanCorrForPlot(1 : nStims, 1 : nROIs)));
    [~, stimSortIndexes] = sort(nanmed(allTrialsMeanCorrForPlot(1 : nStims, 1 : nROIs), 2));
else % if no sort is required, leave it in original order
    ROISortIndexes = (1 : nROIs);
    stimSortIndexes = (1 : nStims)';
end;
% apply the sorting
allTrialsMeanCorrForPlot = allTrialsMeanCorrForPlot([stimSortIndexes', nStims + 1 : nStims + nExtraColMeanCorr], ...
    [ROISortIndexes, nROIs + 1 : nROIs + nExtraColMeanCorr]);

%% Plotting of the correlation matrices
if doSavePlot;
    
    sepLineCol = [0 0 0];

    %% Plotting of the all-trials correlation matrix
    saveNameAllTrialCorr = [saveName '_allTrials']; % create the figure name
    allTrialCorrFig = figure('Name', saveNameAllTrialCorr, 'NumberTitle', 'off'); % create the figure
    imAxes = imagesc(allTrialsCorr', [-1, 1]); % plot the correlation matrix
%     imAxes = imagesc(allTrialsCorr, [0, 1]); % plot the correlation matrix
    allTrialCorrAxes = gca;
    set(imAxes, 'AlphaData', ~isnan(allTrialsCorr)');
    hColBar = colorbar;
    set(get(hColBar, 'YLabel'), 'String', 'Inter-trial correlation');
    set(allTrialCorrAxes, 'XTick', nMaxTrials * 0.5 : nMaxTrials : nMaxTrials * (nStims + nExtraColCorr), ...
        'XTickLabel', [stimIDs; 'mean'; 'max'; 'mean'; 'max'], ...
        'YTick', nMaxTrials * 0.5 : nMaxTrials : nMaxTrials * (nROIs + nExtraColCorr), ...
        'YTickLabel', [ROISet(:, 1); 'mean'; 'max'; 'mean'; 'max']);
    xlabel('Frequencies [kHz]');
    xl = get(allTrialCorrAxes, 'XLim');
    yl = get(allTrialCorrAxes, 'YLim');
    commonArgs = {'LineWidth', 1.5, 'Color', sepLineCol};
    for iStim = 1 : nStims + nExtraColCorr; line(xl, repmat((iStim - 1) * nMaxTrials + 0.5, 1, 2), commonArgs{:}); end;
    for iROI = 1 : nROIs + nExtraColCorr; line(repmat((iROI - 1) * nMaxTrials + 0.5, 1, 2), yl, commonArgs{:}); end;
    title({saveNameAllTrialCorr, sprintf('Overall correlation: %4.2f', nanmean(allTrialsCorr(:)))}, ...
        'Interpreter', 'none');

    %% Plotting of the mean correlation matrix
    saveNameMeanCorr = [saveName '_mean'];
    meanCorrFig = figure('Name', saveNameMeanCorr, 'NumberTitle', 'off');
    imagesc(allTrialsMeanCorrForPlot', [0 ceil(max(allTrialsMeanCorrForPlot(:)) * 10) / 10]);
    meanCorrAxes = gca;
    hColBar = colorbar;
    set(get(hColBar, 'YLabel'), 'String', 'Mean of inter-trial correlation');
    set(gca, 'XTick', 1 : 1 : nStims + nExtraColMeanCorr, ...
        'XTickLabel', [stimIDs(stimSortIndexes); 'mean'; 'max'], ...
        'YTick', 1 : 1 : nROIs + nExtraColMeanCorr, ...
        'YTickLabel', [ROISet(ROISortIndexes, 1); 'mean'; 'max']);
    line([nStims + 0.5, nStims + 0.5], [0, nROIs + nExtraColMeanCorr + 1], 'LineWidth', 4, 'Color', sepLineCol);
    line([0, nStims + nExtraColMeanCorr + 1], [nROIs + 0.5, nROIs + 0.5], 'LineWidth', 4, 'Color', sepLineCol);
    title({saveNameMeanCorr, sprintf('Overall correlation: %4.2f', nanmean(allTrialsMeanCorrForPlot(:)))}, ...
        'Interpreter', 'none');

    makePrettyFigure(allTrialCorrFig);
    makePrettyFigure(meanCorrFig);
    
    set(allTrialCorrAxes, 'Color', [0.7 0.7 0.7]);
    set(allTrialCorrAxes, 'FontSize', 8);
    set(meanCorrAxes, 'FontSize', 8);

    saveFigToDir(allTrialCorrFig, saveNameAllTrialCorr, 'InterTrialCorr', doSavePlot, 1, 1);
    saveFigToDir(meanCorrFig, saveNameMeanCorr, 'InterTrialCorr', doSavePlot, 1, 1);

end;
   
end
