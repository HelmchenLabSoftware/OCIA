function figHand = plotPSStimAvg(axeH, PSROIStats, PSTime, avgMode, stimIDs, saveName, N)

% caTraces = PSROIStats.mean.all;
caTraces = PSROIStats.mean.allNorm;

% init the size of the data set
nROIs = size(caTraces, 2);
nStims = size(caTraces, 3);
nFrames = size(caTraces, 1);

caTraceErrors = PSROIStats.sem.all;

% caTraceErrors = PSROIStats.std.all;
% %% TODO: HACK: hard-core change
% warning('plotPSStimAvg:SEMTOSTDHACK', 'WARNING!! SEM IS ACTUALLY STD HERE!!!');

% if only one stim or one ROI
if size(caTraces, 2) == 1 || size(caTraces, 3) == 1;
    avgDim = 0;
    avgSize = 1;
    caTraces = squeeze(caTraces);
    caTraceErrors = squeeze(caTraceErrors);
    titlestr = sprintf('%s - Mean evoked response for each stimulus, N = %d', saveName, N);
    if strcmp(avgMode, 'stim');
        titlestr = sprintf('%s - Mean evoked response for each ROI, N = %d', saveName, N);
    end;
elseif strcmp(avgMode, 'ROI');
    avgDim = 2;
    avgSize = nStims;
    % exclude neuropil
    caTraces = caTraces(:, 1 : end - 1, :);
    caTraceErrors = caTraceErrors(:, 1 : end - 1, :);
    titlestr = sprintf('%s - Mean evoked response for each stimulus, N = %d', saveName, N);
elseif strcmp(avgMode, 'stim');
    avgDim = 3;
    avgSize = nROIs;
    titlestr = sprintf('%s - Mean evoked response for each ROI, N = %d', saveName, N);
end;

if avgDim;
    traceMeans = reshape(nanmean(caTraces, avgDim), nFrames, avgSize);
    traceErrors = reshape(nanmean(caTraceErrors, avgDim), nFrames, avgSize);
else
    traceMeans = caTraces;
    traceErrors = caTraceErrors;
end;

% xShift = 0.005;
% PSTimeStims = repmat(PSTime', 1, avgSize);
% PSTimeStims = PSTimeStims + repmat(xShift * (1 : avgSize), nFrames, 1) - xShift; % small shift for each trace

% create the figure
if isempty(axeH);
    figHand = figure('Name', saveName, 'NumberTitle', 'off', 'Color', 'white');
    axeH = axes('Parent', figHand);
else
    figHand = getParentFigure(axeH);
end;

% color each trace by a specific color
if nStims == 1;
    colors = [0 0 0];
    colorsLight = colors;
    colorsLight(colorsLight == 0) = 0.5;
    lineStyles = {'-'};
elseif nStims == 2;
    colors = [0 0 0; 1 0 0];
    colorsLight = colors;
    colorsLight(colorsLight == 0) = 0.5;
    lineStyles = {'-', '-'};
elseif nStims == 3;
    colors = [0.7 0.7 0.7; 0 0 0; 1 0 0;];
    colorsLight = colors;
    colorsLight(colorsLight == 0.7) = 0.85;
    colorsLight(colorsLight == 0) = 0.5;
    lineStyles = {'-.', '-', '-'};
else
    colors = jet(nStims);
    colorsLight = colors;
    colorsLight(colorsLight == 0) = 0.5;
    lineStyles = [];
end;

% % plot the mean traces
% hold(axeH, 'on');
% plotHands = plot(axeH, PSTimeStims, traceMeans, 'LineWidth', 2);

% % plot the mean traces
% hold(axeH, 'on');
% plotHands = errorbar(repmat(PSTimeStims, 1, 2), traceMeans, traceErrors, 'Parent', axeH);
% for iHand = 1 : numel(plotHands);
%     set(plotHands(iHand), 'Color', colors(numel(plotHands) - iHand + 1, :));
%     removeErrorBarEnds(plotHands(iHand));
% end;

plotHands = cell(nStims, 1);
legHandles = zeros(1, nStims);
opengl software;
for iStim = 1 : nStims;
    plotHands{iStim} = shadedErrorBar(PSTime, traceMeans(:, iStim), traceErrors(:, iStim), [], 1, figHand, axeH);
    hold(axeH, 'on');
    set(plotHands{iStim}.mainLine, 'Color', colors(iStim, :), 'LineWidth', 2);
    if ~isempty(lineStyles); set(plotHands{iStim}.mainLine, 'LineStyle', lineStyles{iStim}); end;
    set(plotHands{iStim}.patch, 'FaceColor', colorsLight(iStim, :));
    set(plotHands{iStim}.edge, 'Color', colors(iStim, :));
    legHandles(iStim) = plotHands{iStim}.mainLine;
end;

set(axeH, 'LineWidth', 1.5, 'Box', 'off'); % defeat OpenGL border bug

yLimits = get(axeH, 'YLim');
hStimLine = plot(axeH, [0 0], yLimits, 'Color', 'red', 'LineWidth', 2, 'LineStyle', '--');

% add the legends
% legend(axeH, stimIDs, 'Location', 'EastOutside');
hLeg = legend(axeH, [legHandles, hStimLine], [stimIDs, 'stim. onset'], 'Location', 'NorthWest', 'Orientation', 'Horizontal');
set(hLeg, 'Box', 'off'); % defeat OpenGL border bug

% axis labels and title
ylabel(axeH, 'dFF/dRR [%]');
xlabel(axeH, 'Time [s]');
title(axeH, titlestr, 'Interpreter', 'none');
hold(axeH, 'off');

%  makePrettyFigure(figHand);

end

