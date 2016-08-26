function fig = plotCaTracesHeatMap(axeH, iRun, saveName, ~, caTraces, stim, stimIDs, ROISet, t, ~, cLim, colorMapName)

% created by B. Laurenczy - 2013

dbgLevel = 0;
% init the size of the data set
nROIs = size(ROISet, 1);
nFrames = size(caTraces, 2);
o('#%s: run %d "%s", %d ROI(s), %d frames ...', mfilename, iRun, saveName, nROIs, nFrames, 2, dbgLevel);

% init the title and the figure
if iRun;
    titleStr = sprintf('%s_run%02d', saveName, iRun);
else
    titleStr = saveName;
end;
if isempty(axeH);
    fig = figure('Name', titleStr, 'NumberTitle', 'off', 'Color', 'white');
    axeH = axes('Parent', fig);
    colormap('hot');
else
    fig = getParentFigure(axeH);
end;

% extract the stimulus 'IDs' by converting the stim index into a string (the index of the stimuli)
stimIDIndexes = stim(stim > 0);

o('#%s: run %d, variables initialized.', mfilename, iRun, 2, dbgLevel);
% init variables for plotting
normFiltCaTraces = zeros(nROIs, nFrames);

% go through each ROI to extract the ROI's ID and to normalize the data
iROI = 1;
for iROILoop = 1 : nROIs;
    
    ROICaTrace = caTraces(iROILoop, :);
    % if the ROI trace is not empty/null
    if nansum(ROICaTrace);
        % normalize by removing the minimum value and add the maximum so far
        normFiltCaTraces(iROI, :) = ROICaTrace;
        iROI = iROI + 1;
    else
        nROIs = nROIs - 1;
        normFiltCaTraces(iROI, :) = [];
        o('  #%s: run %d, ROI %d is null (no value above 0).', mfilename, iRun, iROI, 0, dbgLevel);
    end;
end;
o('#%s: run %d, caTraces normalized.', mfilename, iRun, 2, dbgLevel);

normFiltCaTraces = flipud(normFiltCaTraces);
ROIIDs = flipud(ROISet(:, 1));

imagesc(t, 1 : nROIs, normFiltCaTraces, 'Parent', axeH);
if ~isempty(cLim); set(axeH, 'CLim', cLim); end;
hColBar = colorbar('peer', axeH);
set(get(hColBar, 'YLabel'), 'String', 'DFF/DRR [%]');
colormap(axeH, colorMapName);
if isempty(regexp(get(gcf, 'Name'), 'OCIA', 'once')); close(gcf); end;

% adjust the axes of the calcium traces
imagescAxe = axeH;
xlabel(axeH, 'Time [s]');
ylabel(axeH, 'ROIs');

% create and adjust the axes of the stims labels 
set(imagescAxe, 'YTick', 1 : nROIs, 'YTickLabel', ROIIDs(1 : nROIs), 'FontSize', max(min(15 - (0.166 * nROIs), 20), 6));
o('#%s: run %d, axes initialized.', mfilename, iRun, 2, dbgLevel);

if ~isempty(stim);
    yLimits = get(axeH, 'YLim');
    hold(axeH, 'on');
    uniqueStims = unique(stimIDIndexes);
    % colors for the simuli
    stimColors = lines(numel(unique(stimIDIndexes)));
    % plot the stimuli in the appropriate colors
    for n = 1 : numel(stim);
        if ~isnan(stim(n)) && stim(n);
            xPos = n * (t(2) - t(1));
            stimColor = stimColors(stim(n) == uniqueStims, :);
            plot(axeH, [xPos xPos], [yLimits(1) yLimits(2) * 1.05], 'LineStyle', '--', 'Color', stimColor, 'LineWidth', 1);
            stimID = '';
            if stim(n) <= numel(stimIDs); stimID = stimIDs{stim(n)}; end;
            text(xPos, yLimits(1) - 0.025 * nROIs, stimID, 'Color', stimColor, 'Parent', axeH, ...
                'HorizontalAlignment', 'center');
        end;
    end
    hold(axeH, 'off');
    o('#%s: run %d, stims plotted.', mfilename, iRun, 2, dbgLevel);
end;

o('#%s: run %d "%s", %d ROI(s), %d frame(s) done.', mfilename, iRun, saveName, nROIs, nFrames, 1, dbgLevel);

end