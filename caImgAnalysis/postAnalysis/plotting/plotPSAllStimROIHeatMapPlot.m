function figHand = plotPSAllStimROIHeatMapPlot(axeH, saveName, ROIStats, baseFrames, ROISet, stimIDs, plotLimits, mode, N, frameRate, stimDur)

dbgLevel = 4;

% init the size of the data set
nFrames = size(ROIStats, 1);
nROIs = size(ROIStats, 2);
nStims = size(ROIStats, 3);

isROIMode = strcmp(mode, 'ROIs');
o('    #plotPSStimROIHeatMapPlot: ALL ROIs, %d stim(s), %d ROIs, %d frame(s) ...', ...
    nStims, nROIs, nFrames, 2, dbgLevel);

sumEvoked = sum(ROIStats((baseFrames + 1) : end, 1 : end - 1, 1));
[~, sortIndex] = sort(-sumEvoked);
ROIStats = ROIStats(:, [sortIndex nROIs], :);

% reshape again to have all the frames for each stims in one row per ROI
ROIStatsPermuted = permute(ROIStats, [1 3 2]);
ROIStatsAligned = reshape(ROIStatsPermuted, nFrames * nStims, nROIs);
% ROIStatsMeanEvoked = reshape(ROIStatsMeanEvoked3DPermuted, nEvokedFrames * nStims, nROIs)';

% create the figure
if isempty(axeH);
    figHand = figure('Name', saveName, 'NumberTitle', 'off', 'Color', 'white');
    axeH = axes('Parent', figHand);
else
    figHand = getParentFigure(axeH);
end;

ROIStatsMean = nanmean(ROIStatsAligned, 2);
ROIStatsAligned = horzcat(ROIStatsAligned, ROIStatsMean);
stimLine = zeros(1, size(ROIStatsAligned, 1)) + max(ROIStatsAligned(:));
for iStim = 1 : nStims;
    stimStart = baseFrames + (iStim - 1) * nFrames;
    stimEnd = stimStart + round(stimDur * frameRate);
    stimLine(stimStart : stimEnd) = min(ROIStatsAligned(:));
end;
ROIStatsAligned = horzcat(stimLine', ROIStatsAligned);
% ROIStatsForROILabels = [ROISet(:, 1); 'mean'];

% colormap hot;
if isempty(plotLimits);
    imagesc(ROIStatsAligned', 'Parent', axeH);
else
%     imagesc(ROIStatsAligned', plotLimits, 'Parent', axeH);
    imagesc((0 : size(ROIStatsAligned, 1)) / frameRate, 1 : (nROIs + 1), ROIStatsAligned', 'Parent', axeH);
end;
% imagesc(ROIStatsForROIMean);
hColBar = colorbar('peer', axeH);
set(get(hColBar,'YLabel'), 'String', 'DFF/DRR [%]');

yLimits = [0.5 nROIs + 1.5];
set(axeH, 'ylim', yLimits);

set(axeH, 'YTick', []);
set(axeH, 'XTick', []);

% add line to separate stimuli
hold(axeH, 'on');
% iStimHandles = zeros(nStims, 1);
for iStim = 1 : nStims;
    plot(axeH, repmat((iStim * nFrames) / frameRate, 1, 2), yLimits, 'LineWidth', 4.5, 'Color', 'white');
%     iStimHandles(iStim) = plot(axeH, repmat((baseFrames + (iStim - 1) * nFrames) / frameRate, 1, 2), yLimits, ...
%         'LineWidth', 1.5, 'Color', 'blue', 'LineStyle', '--');
    text((baseFrames + (iStim - 1) * nFrames + 5) / frameRate, 1.05, stimIDs{iStim}, 'Color', 'white', ...
        'HorizontalAlignment', 'left', 'Parent', axeH, 'FontSize', 8);
end;
text(-0.02, 1.05, 'stim', 'Color', 'black', ...
        'HorizontalAlignment', 'right', 'Parent', axeH, 'FontSize', 8);
text(-0.02, nROIs + 0.05, 'NPil', 'Color', 'black', ...
        'HorizontalAlignment', 'right', 'Parent', axeH, 'FontSize', 8);
text(-0.02, nROIs + 1.05, 'mean', 'Color', 'black', ...
        'HorizontalAlignment', 'right', 'Parent', axeH, 'FontSize', 8);
% % add line to separate neuropil from the others
% if ~isROIMode;
%     plot(axeH, xLimits, [nROIs - 0.5 nROIs - 0.5], 'LineWidth', 2, 'Color', 'white');
% end;
% % add line to separate mean from the others
% plot(axeH, xLimits, [nROIs + 0.5 nROIs + 0.5], 'LineWidth', 2, 'Color', 'white');


% display all ticks
%{
frameStep = 5;
ticks = 0 : frameStep : (nFrames * nStims) - 1;
time = zeros(1, numel(ticks));
currentTime = -baseFrames / frameRate;
for iTick = 1 : numel(time);
     time(iTick) = currentTime;
     currentTime = currentTime + frameStep / frameRate;
     if currentTime > nEvokedFrames / frameRate;
         currentTime = 0;
     end;
 end;
%}

% only display first stim and then only the zeros
% frameStep = 5;
% ticks = [(1 : frameStep : nFrames + 1), (2 : nStims - 1) * nFrames - nEvokedFrames] - 0.5;
% time = [((0 : frameStep : nFrames + 1) - baseFrames) / frameRate, zeros(1, nStims - 2)];

%{
%% TODO: only mark 0 and 0.5 - hard coded shit that needs to change. we need to
% make ticks based on stimulus duration...
%
ticks = 1 : nStims * nFrames;
time = zeros(1, numel(ticks));
zeroCounter = nFrames - baseFrames;
for i = 1 : nStims * nFrames;
    zeroCounter = zeroCounter + 1;
    if zeroCounter == nFrames;
        ticks(i) = 0;
        time(i) = 4;
        time(i + baseFrames) = 6.5;
        zeroCounter = 0;
    end;
end;
ticks = find(time);
time = time(ticks) - 4;
% %}

set(axeH, 'XTick', ticks);
set(axeH, 'XTickLabel', time);
set(axeH, 'YTick', 1 : nROIs + 1);
set(axeH, 'YTickLabel', ROIStatsForROILabels);
% stimAxe = axes('Position', get(timeAxe, 'Position'), 'YAxisLocation', 'right', 'XAxisLocation', 'top');
% set(stimAxe, 'XLim', get(timeAxe, 'XLim'), 'YLim', get(timeAxe, 'YLim'));
% set(stimAxe, 'YTick', [], 'YTickLabel', []);
% set(stimAxe, 'XTick', ((0.5 : 1 : nStims + 0.5) * nFrames), 'XTickLabel', stimIDs);

%}

titleHandle = title(axeH, sprintf('%s, N = %d', saveName, N), 'Interpreter', 'none');
% hLeg = legend(iStimHandles, 'Orientation', 'horzontal', 'Location', 'SouthOutside', stimIDs);

% make the time axe the current axe
set(figHand, 'CurrentAxes', axeH)
hold(axeH, 'all');

% create and adjust the axes of the labels (ROI labels and stim)
labH = xlabel(axeH, 'Time [s]');
if isROIMode;
    ylabel(axeH, 'Stimulus');
else
    ylabel(axeH, 'ROIs');
end;

% makePrettyFigure(figHand);
set(axeH, 'FontSize', 8);
% set(stimAxe, 'FontSize', 8);
set(titleHandle, 'FontSize', 10);
set(labH, 'FontSize', 12);

% restack axes so that the trace axes is on top
restackAxes(axeH, 'top');

end
