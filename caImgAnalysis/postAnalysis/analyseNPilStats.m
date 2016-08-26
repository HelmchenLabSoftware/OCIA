function npilttestStats = analyseNPilStats(PSROIStats, respThresh, ...
    PSFrames, ROISet, stimIDs, saveName, doSavePlot, sortMethod)
    
% Analyze if for a specified Neuropil ROI, the evoked activity of a given ROI is
% significantly different (get an overall estimate of neurons significantly
% above neuropil level).
%
% Usage: npilttestStats = analyseNPilStats(PSROIStats, respThresh, PSFrames, ROISet, stimIDs, saveName, doSavePlot, sortMethod)
%
% Author: A. van der Bourg, 2014


% Check for a neuropil ROI instance at the last ROISet index
if ~strcmp(ROISet{end, 1}, 'NPil');
        warning('analyseNPilStats:NoNPil', 'No neuropil included!');
        return;
end;

nStims = size(PSROIStats, 2);
nROIs = size(ROISet, 1);
nTrials = size(PSROIStats{1, 1}, 1);
meanTrials = nan(nTrials, nROIs-1, nStims);
sumTrials = nan(nTrials, nROIs-1, nStims);
meanTrialsNPil = nan(nTrials, 1, nStims);
sumTrialsNPil = nan(nTrials, 1, nStims);
pvalMean = nan(nROIs-1, nStims);
tStatMean = nan(nROIs-1, nStims);
pvalSum = nan(nROIs-1, nStims);
tStatSum = nan(nROIs-1, nStims);


%% calculate response on each trial
% go trough each stim and each ROI
for iStim = 1 : nStims;
    for iROI = 1 : nROIs-1;
        for iTrial = 1 : nTrials;
            frames = PSROIStats{iROI, iStim}(iTrial, :);
            evoked = frames((PSFrames.base + 1) : (PSFrames.base + PSFrames.evoked));
            meanTrials(iTrial, iROI, iStim) = mean(evoked);
            sumTrials(iTrial, iROI, iStim) = sum(evoked);
        end;
    end;
end;

%% Calculate response for neuropil for each trial
for iStim = 1 : nStims;
    for iTrial = 1 : nTrials;
        framesNPil = PSROIStats{nROIs, iStim}(iTrial,:);
        evokedNPil = framesNPil((PSFrames.base + 1) : (PSFrames.base + PSFrames.evoked));
        meanTrialsNPil(iTrial, iStim) = mean(evokedNPil);
        sumTrialsNPil(iTrial, iStim) = sum(evokedNPil);
    end;
end;


%% Perform a ttest where mean evoked ROI is tested against mean evoked NPil ROI
for iStim = 1: nStims;
    for iROI = 1:nROIs-1;
        % ttest for mean response metric
        [~, pvalMean(iROI, iStim), ~, statsMean] = ttest(meanTrials(:,iROI,iStim), meanTrialsNPil(:,1,iStim), respThresh, 'right');
        tStatMean(iROI, iStim) = statsMean.tstat;
        % ttest for sum response metric
        [~, pvalSum(iROI, iStim), ~, statsSum] = ttest(sumTrials(:,iROI,iStim), sumTrialsNPil(:,1,iStim), respThresh, 'right');
        tStatSum(iROI, iStim) = statsSum.tstat;
    end
end

%% Plot ttest heatmap values:

%TODO: Bar plot mean trial vs mean nPil and significance star
if doSavePlot;
   %For now we save a p-value heatmap
   figImagesc = plotGenericROIStimHeatMap(pvalMean, [], strrep([saveName '_pvalMean'], '_', '\_'), ...
        stimIDs, ROISet(:, 1), 'p-value', saveName, 'NPilTTest', 1, sortMethod, []);
    colormap('hot');
    saveFigToDir(figImagesc, [saveName '_pvalMean'], 'NPilttest', doSavePlot, 1, 1);
    
    %p-value heatmap for sum response stat
    figImagesc = plotGenericROIStimHeatMap(pvalsum, [], strrep([saveName '_pvalSum'], '_', '\_'), ...
        stimIDs, ROISet(:, 1), 'p-value', saveName, 'NPilTTest', 1, sortMethod, []);
    colormap('hot');
    saveFigToDir(figImagesc, [saveName '_pvalSum'], 'NPilttest', doSavePlot, 1, 1);
    
end;

%Mean of nPil and evoked response
npilttestStats.pvalMean = pvalMean;
npilttestStats.tStatMean = tStatMean;
%Sum of nPil and evoked response
npilttestStats.pvalSum = pvalSum;
npilttestStats.tStatSum = tStatSum;

end