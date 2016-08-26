function fig = plotPSStimAverageForROI(titleStr, PSROIStatsData, nBaseFrames, frameRate, plotLimits, ROISet)

% create the figure
fig = figure('Name', titleStr, 'NumberTitle', 'off');

% init the size of the data set
nROIs = size(PSROIStatsData, 1); % including the neuropil
nStims = size(PSROIStatsData, 2);
% nReps = size(PSROIStatsData{1, 1}, 1);
nFrames = size(PSROIStatsData{1, 1}, 2);
nEvokedFrames = nFrames - nBaseFrames;

ROIStatsForROIsRepAveraged = cell(nROIs, 1);
ROIStatsForROIsRepStd = cell(nROIs, 1);
for iROI = 1 : nROIs;
    ROIStatsForROIsRepAveraged{iROI} = cell2mat(cellfun(@(x) nanmean(x, 1), PSROIStatsData(iROI, :), ...
        'UniformOutput', false)');
    ROIStatsForROIsRepStd{iROI} = cell2mat(cellfun(@(x) sem(x, 1), PSROIStatsData(iROI, :), ...
        'UniformOutput', false)');
end;

% extract the PSROI stats data as a 4D matrix, without the neuropil
ROIStatsForPop = reshape(cell2mat(ROIStatsForROIsRepAveraged'), nStims, nFrames, nROIs);
ROIStatsForPopStd = reshape(cell2mat(ROIStatsForROIsRepStd'), nStims, nFrames, nROIs);

meanTraces = reshape(mean(ROIStatsForPop, 1), nFrames, nROIs)';
meanTracesCorrected = meanTraces - repmat(mean(meanTraces(:, 1 : nBaseFrames), 2), 1, nFrames);
stdMeanTrace = reshape(mean(ROIStatsForPopStd, 1), nFrames, nROIs)';

% create the time axis, first for a single ROI ...
t = (- nBaseFrames : nEvokedFrames - 1) / frameRate;
t = repmat(t, nROIs, 1); % ... then enhance for N ROIs for grouped plotting
t = t + repmat(0.005 * (1 : nROIs)', 1, nFrames);

% plot the mean traces
% plotHandles = plot(t', meanTracesCorrected');
plotHandles = errorbar(t', meanTracesCorrected', stdMeanTrace');
if numel(plotLimits) == 2;
    ylim(plotLimits);
end;

% color each trace by a specific color
colors = jet(numel(plotHandles));
for iHand = 1 : numel(plotHandles);
    set(plotHandles(iHand), 'Color', colors(numel(plotHandles) - iHand + 1, :));
end;

% create the ROI IDs
IDs = cell(1, nROIs);
for iROI = 1 : nROIs;
    if iROI == nROIs; IDs{iROI} = 'Npil';
    else IDs{iROI} = ROISet{iROI, 1}; end;
end;

% add the legends
hLeg = legend(IDs, 'Location', 'EastOutside', 'Interpreter', 'none');

% get the 'best' ROIs
ROIMeans = mean(meanTracesCorrected(:, nBaseFrames : end), 2);
bestROIs = find(ROIMeans > mean(ROIMeans) + std(ROIMeans));
if any(bestROIs > size(ROISet, 1));
    ROISet{end + 1, 1} = 'Npil'; % make sure even the neuropil can be named
end;
bestROIsStr = sprintf(repmat('%s ', 1, numel(bestROIs)), ROISet{bestROIs, 1});
if isempty(bestROIsStr); bestROIsStr = '-'; end;

% axis labels and title
ylabel('DFF/DRR \pm SEM [%]');
xlabel('Time [s]');
title(sprintf('Trace average for each ROI. Best ROIs are : %s', bestROIsStr));
set(hLeg, 'FontSize', 7)

end

