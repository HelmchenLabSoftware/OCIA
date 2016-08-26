function fig = plotPSAllStimROIHeatMapSubPlot(saveName, ROIStats, baseFrames, stimIDs, plotLimits)

% init the size of the data set
nFrames = size(ROIStats, 1);
nROIs = size(ROIStats, 2);
nStims = size(ROIStats, 3);

% init the figure
fig = figure('Name', saveName, 'NumberTitle', 'off');


frameRate = 77.76;
t = ((1 : nFrames) - baseFrames) / frameRate;
y = fliplr(1 : nROIs);

cBarWidthFrac = 1 / 20;

colormap hot;
for iStim = 1 : nStims;
    subplot(1, nStims / cBarWidthFrac + 2, (iStim - 1) / cBarWidthFrac + 1 : (iStim / cBarWidthFrac));
    if isempty(plotLimits);
        imagesc(t, y, squeeze(ROIStats(:, :, iStim))');
    else
        imagesc(t, y, squeeze(ROIStats(:, :, iStim))', plotLimits);
    end;
    set(gca, 'Tag', sprintf('stimAxe%d', iStim));
    
    if iStim == 1;
        ylabel('ROIs');
        yTicks = unique([get(gca, 'YTick') nROIs]);
        yTickLabels = get(gca, 'YTickLabel');
        if size(yTickLabels, 1) == numel(yTicks);
            yTickLabels(end, :) = [];
        end;
        yTickLabels = [repmat(' ', size(yTickLabels, 1), 4 - size(yTickLabels, 2)), yTickLabels; 'NPil']; %#ok<AGROW>
        set(gca, 'YTick', yTicks, 'YTickLabel', yTickLabels);
    else
        set(gca, 'YTick', []);
    end;
    
    
    xLimits = get(gca, 'xlim');
    % add line to separate neuropil from the others
    line(xLimits, [nROIs - 0.5 nROIs - 0.5], 'LineWidth', 2, 'Color', 'white');
    title(stimIDs{iStim});
    xlabel('Time [s]');
    
end;

subplot(1, nStims / cBarWidthFrac + 2, nStims / cBarWidthFrac + 1 : nStims / cBarWidthFrac + 2);
set(gca, 'Tag', 'colorBarAxe');
axis('off');
hColBar = colorbar('Location', 'East');
colBarYLimits = get(hColBar, 'YLim');
set(hColBar, 'YTick', colBarYLimits + [1 -1], 'YTickLabel', {'Min ', 'Max '});
set(get(hColBar,'YLabel'), 'String', 'DFF/DRR [%]');
set(hColBar, 'Position', get(gca, 'Position') .* [1.08 1 0.95 1]);
colBarYLabelPos = get(get(hColBar,'YLabel'), 'Position');
set(get(hColBar,'YLabel'), 'Position', colBarYLabelPos .* [0.5 1 1]);

makePrettyFigure(fig);

suptitle('Peri-stimulus average');
% set(timeAxe, 'FontSize', 8);
% set(stimAxe, 'FontSize', 8);
% set(titleHandle, 'FontSize', 10);
% set(labH, 'FontSize', 12);

end
