function fig = plotBSPref_polar(iROI, saveName, ROIPref)

dbgLevel = 4;

% init the size of the data set
nStim = size(ROIPref, 1);
o('    #plotBFPref: ROI %d, %d stim(s) ...', ...
    iROI, nStim, 2, dbgLevel);

% init the title and the figure
if iROI; titleStr = sprintf('%s ROI %1.0f', saveName, iROI);
else titleStr = sprintf('%s population', saveName);
end;
fig = figure('Name', titleStr, 'NumberTitle', 'off');

angleStep = (2 * pi) / nStim;
stims = 0 : angleStep : 2 * pi - angleStep;

h = customPolar(stims, ROIPref');
patch(get(h, 'XData'), get(h, 'YData'), 'r', 'FaceAlpha', 0.5, ...
    'FaceColor', [1 0.5 0.5], 'EdgeColor', [0.9 0 0], 'LineWidth', 3);

% polarAxis = get(get(gcf, 'Children'));
% set(polarAxis, 'XLabel', 'Stim');
% set(gca, 'XTick', 1 : nStim);
% set(gca, 'XTickLabel', 1 : nStim);
% set(gca, 'YTick', 1 : nStim);
% set(gca, 'YTickLabel', ROIStatsForROILabels);
% set(gca, 'YTickLabel', ROIStatsForROILabelsSorted);
% create and adjust the axes of the labels (ROI labels and stim)
% ylabel('DFF');
title(titleStr, 'Interpreter', 'none');

end