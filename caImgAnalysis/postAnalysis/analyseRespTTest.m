function ttestStruct = analyseRespTTest(PSROIStats, respThresh, PSFrames, ...
    ROISet, stimIDs, saveName, doSavePlot) %#ok<INUSD>
    
nStims = size(PSROIStats, 2);
nROIs = size(PSROIStats, 1);
nTrials = size(PSROIStats{1, 1}, 1);
tStatMax3PP = nan(nROIs, nStims);
pvalMax3PP = nan(nROIs, nStims);
tStatMax = nan(nROIs, nStims);
pvalMax = nan(nROIs, nStims);
tStatMean = nan(nROIs, nStims);
pvalMean = nan(nROIs, nStims);

%% calculate response probability for all trials
% go trough each stim and each ROI
for iStim = 1 : nStims;
    for iROI = 1 : nROIs;
        base = PSROIStats{iROI, iStim}(:, 1 : PSFrames.base);
        evoked = PSROIStats{iROI, iStim}(:, (PSFrames.base + 1) : (PSFrames.base + PSFrames.evoked));
        max3PPBase = mean(cell2mat(arrayfun(@(i)maxnpp(base(i, :), 3), 1 : nTrials, 'UniformOutput', false)'), 2);
        max3PPEvoked = mean(cell2mat(arrayfun(@(i)maxnpp(evoked(i, :), 3), 1 : nTrials, 'UniformOutput', false)'), 2);
        [~, pvalMax3PP(iROI, iStim), ~, statsMax3PP] = ttest(max3PPEvoked, max3PPBase, respThresh, 'right');
        [~, pvalMax(iROI, iStim), ~, statsMax] = ttest(max(evoked, [], 2), max(base, [], 2), respThresh, 'right');
        [~, pvalMean(iROI, iStim), ~, statsMean] = ttest(mean(evoked, 2), mean(base, 2), respThresh, 'right');

        tStatMax3PP(iROI, iStim) = statsMax3PP.tstat;
        tStatMax(iROI, iStim) = statsMax.tstat;
        tStatMean(iROI, iStim) = statsMean.tstat;
    end;
end;

ttestStruct.tStatMax3PP = tStatMax3PP;
ttestStruct.pvalMax3PP = pvalMax3PP;
ttestStruct.tStatMax = tStatMax;
ttestStruct.pvalMax = pvalMax;
ttestStruct.tStatMean = tStatMean;
ttestStruct.pvalMean = pvalMean;
   
end
