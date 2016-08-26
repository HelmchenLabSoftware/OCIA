function fig = plotCaTraces(axeH, iRun, saveName, caTraces, caTracesFilt, stim, stimIDs, ROISet, t, tFilt, ROIColors, varargin)

% created by B. Laurenczy - 2013 (adapted from H. Luetcke)

%  = caTraces(isnan(caTraces), :);
% caTraces = caTraces(isnan(caTraces), :);

dbgLevel = 0;
% init the size of the data set
nROIs = size(ROISet, 1);
nFrames = size(caTraces, 2);
isFilt = ~isempty(caTracesFilt);

% nanEndFrames = find((nansum(caTraces, 1) + nansum(stim, 1) + nansum(caTracesFilt, 1)), 1, 'last');
% if ~isempty(nanEndFrames) && nanEndFrames ~= nFrames;
%     caTraces(:, nanEndFrames + 1 : end) = [];
%     caTracesFilt(:, nanEndFrames + 1 : end) = [];
%     stim(nanEndFrames + 1 : end) = [];
%     t(nanEndFrames + 1 : end) = [];
%     tFilt(nanEndFrames + 1 : end) = [];
%     nFrames = size(caTraces, 2);
% end;

o('#%s: run %d "%s", %d ROI(s), %d frame(s) ...', mfilename, iRun, saveName, nROIs, nFrames, 2, dbgLevel);

% init the title and the figure
if iRun;
    titleStr = sprintf('%s_run%02d', saveName, iRun);
else
    titleStr = saveName;
end;
if isempty(axeH);
    fig = figure('Name', titleStr, 'NumberTitle', 'off', 'Color', 'white');
    axeH = axes('Parent', fig);
else
    fig = getParentFigure(axeH);
end;

% extract the stimuli times
stimTimes = t(stim > 0);

o('#%s: run %d, variables initialized.', mfilename, iRun, 2, dbgLevel);

currOffSet = 0; % offset between each ROI
% overallOffset = 0;
% fixOffset = nanmax(caTraces(:)) + abs(nanmin(caTraces(:)));
% fixOffset = 25;
normCaTraces = zeros(size(caTraces));
if isFilt; normFiltCaTraces = zeros(size(caTracesFilt)); end;
% go through each ROI to extract the ROI's ID and to normalize the data
iROI = 1;
for iROILoop = 1 : nROIs;
    ROICaTrace = caTraces(iROILoop, :);
    if isFilt; ROICaTraceFilt = caTracesFilt(iROILoop, :); end;
    % if the ROI trace is not empty/null
    if nansum(ROICaTrace);
        % normalize by removing the minimum value and add the maximum so far
        if isFilt; meanDiff = nanmean(ROICaTrace) - nanmean(ROICaTraceFilt); end;
        normCaTraces(iROI, :) = ROICaTrace + currOffSet;
        if isFilt; normFiltCaTraces(iROI, :) = ROICaTraceFilt + meanDiff + currOffSet; end;
        currOffSet = nanmax(normCaTraces(iROI, :));
%         currOffSet = currOffSet + fixOffset;
        iROI = iROI + 1;
    else
        nROIs = nROIs - 1;
        normCaTraces(iROI, :) = [];
        if isFilt; normFiltCaTraces(iROI, :) = []; end;
        o('  #%s: run %d, ROI [iROILoop:%d-iROI:%d-ROI%s] is null (no value above 0).', mfilename, iRun, iROILoop, iROI, ROISet{iROILoop, 1}, 0, dbgLevel);
    end;
end;
o('#%s: run %d, caTraces normalized.', mfilename, iRun, 2, dbgLevel);

% adjust the axes of the calcium traces
% yLimits = [overallOffset currOffSet];
yLimits = [min(normCaTraces(:)) currOffSet];
xLimits = [min(t) - 0.2  max(t) + 0.2];
% set(axeH, 'ylim', yLimits, 'xlim', xLimits, 'YTick', DRRTicks, 'YTickLabel', DRRTicks);
set(axeH, 'ylim', yLimits, 'xlim', xLimits);
xlabel(axeH, 'Time [s]');
% create and adjust the axes of the labels (ROI labels and stim)
ylabel(axeH, sprintf('%s', 'dFF/dRR [%]'));
labelAxe = axes('Position', get(axeH, 'Position'), 'Parent', get(axeH, 'Parent'), ...
    'YAxisLocation', 'right', 'XAxisLocation', 'top', 'Tag', 'ROICaTracesPlotLabelAxe');
ROIIDs = arrayfun(@(iROI)sprintf('%s (%4.2f)', ROISet{iROI, 1}, nanstd(normCaTraces(iROI, :))), ...
    1 : nROIs, 'UniformOutput', false)';

stimIDIndexes = stim(stim > 0);
stimIDsToPlot = cell(1, max(stimIDIndexes));
stimIDsToPlot(1 : numel(stimIDs)) = stimIDs;
set(labelAxe, 'XTick', stimTimes, 'XTickLabel', stimIDsToPlot(stimIDIndexes));
set(labelAxe, 'YLim', yLimits, 'YTick', nanmean(normCaTraces(1 : nROIs, :), 2), 'YTickLabel', ROIIDs, 'FontSize', ...
    max(min(15 - (0.166 * max(nROIs, numel(stimIDIndexes))), 20), 6));
title(axeH, titleStr, 'Interpreter', 'none', 'FontSize', 15);
o('#%s: run %d, axes initialized.', mfilename, iRun, 2, dbgLevel);

% make the trace axe the current axe
set(fig, 'CurrentAxes', axeH);
hold(axeH, 'all');
if ~isempty(stim);
    if isempty(varargin);
        % colors for the simuli
        stimColors = lines(max(stimIDIndexes));
    else
        stimColors = varargin{1};
    end;
    % plot the stimuli in the appropriate colors
    for iStim = 1 : numel(stimIDIndexes);
        hStimLine = plot(axeH, [stimTimes(iStim) stimTimes(iStim)], yLimits, 'LineStyle', '--', ...
            'Color', stimColors(stimIDIndexes(iStim), :));
        set(hStimLine, 'Tag', sprintf('stimLine_stim%03d_%s', iStim, stimIDsToPlot{stimIDIndexes(iStim)}));
    end
    o('#%s: run %d, stims plotted.', mfilename, iRun, 2, dbgLevel);
end;

% plotting loop
o('#%s: run %d, plotting calcium traces ...', mfilename, iRun, 3, dbgLevel);
% colors for the ROIs
if isempty(ROIColors);
    ROIColors = jet(nROIs);
    ROIColors(ROIColors > 0.4) = 0.4;
end;
plotHandles = zeros(nROIs, 1); % for legend handling
for iROI = 1 : nROIs;
    o('  #%s: run %d - ROI %d, plotting calcium trace ...', mfilename, iRun, iROI, 4, dbgLevel);
    if isFilt;
        % plot the 'raw' calcium trace in gray
        plotHandles(iROI) = plot(axeH, t, normCaTraces(iROI, :), 'LineWidth', 1, 'Color', [.8 .8 .8]);
        % plot the filtered calcium trace in color
        plotHandles(iROI) = plot(axeH, tFilt, normFiltCaTraces(iROI, :), 'LineWidth', 1.5, 'Color', ROIColors(iROI, :));
    else
        % plot the 'raw' calcium trace in color
        plotHandles(iROI) = plot(axeH, t, normCaTraces(iROI, :), 'LineWidth', 1.5, 'Color', ROIColors(iROI, :));
    end;
    % stop for some reason before displaying the last ROI (the neuropil?)
    if iROI == nROIs; break; end;
    o('  #%s: run %d - ROI %d, plotting calcium trace done.', mfilename, iRun, iROI, 3, dbgLevel);
end;
o('#%s: run %d, plotting calcium traces done.', mfilename, iRun, 2, dbgLevel);

linkaxes([labelAxe, axeH], 'xy'); % link the axes so the traces and stim indications are aligned
set(axeH, 'ylim', yLimits, 'xlim', xLimits);
o('#%s: run %d, axes linked.', mfilename, iRun, 2, dbgLevel);

o('#%s: run %d "%s", %d ROI(s), %d frame(s) done.', mfilename, iRun, saveName, nROIs, nFrames, 1, dbgLevel);
hold(axeH, 'off');

% make the axe handle the top-most element
restackAxes(axeH, 'top');

end
