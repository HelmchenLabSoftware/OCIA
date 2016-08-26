function fig = plotPSStimROIHeatMapPlot(iElem, saveName, ROIStats, ROIStatsEvoked, ...
    PSTime, ROISet, stimIDs, stimLabel, plotLimits, mode, sortROIs)

dbgLevel = 4;

% init the size of the data set
nFrames = size(ROIStats, 1);
nElem = size(ROIStats, 2);
isROIMode = strcmp(mode, 'ROIs');
o('    #plotPSStimROIHeatMapPlot: ROI %d, %d stim(s), %d frame(s) ...', ...
    iElem, nElem, nFrames, 2, dbgLevel);

% init the title and the figure
if iElem;
    if isROIMode;   titleStr = sprintf('%s - ROI%s', saveName, ROISet{iElem, 1});
    else            titleStr = sprintf('%s - %s', saveName, stimIDs{iElem});
    end;
else
    if isROIMode;   titleStr = sprintf('%s - All ROIs', saveName);
    else            titleStr = sprintf('%s - All frequencies', saveName);
    end;
end;
fig = figure('Name', titleStr, 'NumberTitle', 'off');

if isROIMode;   labels = stimIDs;
else            labels = ROISet(:, 1); end;

if sortROIs;
    maxForEachElem = max(ROIStatsEvoked);
    [~, sortInds] = sort(-maxForEachElem);
    ROIStatsSorted = zeros(size(ROIStats));
    labelsSorted = cell(1, nElem);
    for iRow = 1 : numel(sortInds);
        ROIStatsSorted(:, iRow) = ROIStats(:, sortInds(iRow));
        labelsSorted(iRow) = labels(sortInds(iRow));
    end;
    
    ROIStats = ROIStatsSorted;
    labels = labelsSorted;
end;

ROIStatsMean = mean(ROIStats, 2);
ROIStats = horzcat(ROIStats, ROIStatsMean);
labels{end + 1} = 'mean';

colormap hot;
if ~isempty(plotLimits);    imagesc(ROIStats', plotLimits);
else                        imagesc(ROIStats');             end;
% imagesc(ROIStatsForROIMean);
hColBar = colorbar;
set(get(hColBar,'YLabel'), 'String', 'DFF/DRR [%]');

xLimits = get(gca, 'xlim');

% add line to separate neuropil from the others
if ~isROIMode;
    line(xLimits, [nElem - 0.5 nElem - 0.5], 'LineWidth', 2, 'Color', 'black');
end;
% add line to separate mean from the others
line(xLimits, [nElem + 0.5 nElem + 0.5], 'LineWidth', 2, 'Color', 'black');

xlabel('Time [s]');
%----Alex: We need to make the ticks a bit less dense
totalTicks = 10;
tickVector = 1:(round(nFrames/totalTicks)):nFrames;
set(gca, 'XTick', tickVector);
%set(gca, 'XTick', 1 : nFrames);
set(gca, 'XTickLabel', PSTime(tickVector));
set(gca, 'YTick', 1 : nElem + 1);
set(gca, 'YTickLabel', labels);

% create and adjust the axes of the labels (ROI labels and stim)
if isROIMode;
    ylabel(stimLabel);
else
    ylabel('ROIs');
end;
title(titleStr, 'Interpreter', 'none');

end