function [figCOD, figNvsNP1] = plotNVSNP1(ROIsValues, ROIIDs, yAxeName, saveName, doTimeCoursePlot, newFig)

nROIs = size(ROIsValues, 1);
nDays = size(ROIsValues, 2);

%% plot the change over the days
if doTimeCoursePlot;
    if newFig; figCOD = figure('NumberTitle', 'off', 'Name', saveName); else figCOD = NaN; end;
    imagesc(ROIsValues);
    hColBar = colorbar;
    set(get(hColBar, 'YLabel'), 'String', yAxeName);

    legend('off');
    % ylim([0 max(max(ROIsValues) * 1.1)]);
    set(gca, 'XTick', 1 : nDays, 'YTick', 1 : nROIs, 'YTickLabel', ROIIDs);
    xlabel('Days');
    ylabel('ROIs');
    titleHand = title(sprintf('%s - ''time course'', %d days, %d ROIs', saveName, nDays, nROIs), ...
        'Interpreter', 'none');

    if newFig; makePrettyFigure(figCOD); end;
    set(titleHand, 'FontSize', 10);
else
    figCOD = NaN;
end;

%% plot the N vs N + 1
NaNNvsNP1 = zeros((nDays - 1) * nROIs, 3);
for iDay = 1 : nDays - 1;
    NaNNvsNP1((iDay - 1) * nROIs + 1 : iDay * nROIs, 1) = ROIsValues(:, iDay);
    NaNNvsNP1((iDay - 1) * nROIs + 1 : iDay * nROIs, 2) = ROIsValues(:, iDay + 1);
    NaNNvsNP1((iDay - 1) * nROIs + 1 : iDay * nROIs, 3) = 1 : nROIs;
end;

% ROISetLabels = ROISetCell(~isnan(NaNNvsNP1(:, 1)), 1);
NvsNP1 = NaNNvsNP1(~isnan(NaNNvsNP1(:, 1)), :);
NvsNP1 = NvsNP1(~isnan(NvsNP1(:, 2)), :);

p = polyfit(NvsNP1(:, 1), NvsNP1(:, 2), 1);
yFit = polyval(p, NvsNP1(:, 1));
yResid = NvsNP1(:, 2) - yFit;
SSResid = sum(yResid .^ 2);
SSTot = (length(NvsNP1(:, 2)) - 1) * var(NvsNP1(:, 2));
RSquare = 1 - SSResid / SSTot;

% figNvsNP1 = figure('NumberTitle', 'off', 'Position', figPos, 'Name', saveName);
if newFig; figNvsNP1 = figure('NumberTitle', 'off', 'Name', saveName); else figNvsNP1 = NaN; end;
% scatter(NvsNP1(:, 1) ./ 1000, NvsNP1(:, 2) ./ 1000, 50, repmat(colors, nDays - 1, 1), 'filled');
% gscatter(NvsNP1(:, 1) ./ 1000, NvsNP1(:, 2) ./ 1000, repmat((1 : nROIs)', nDays - 1, 1));
hGScatt = gscatter(NvsNP1(:, 1), NvsNP1(:, 2), ROIIDs(NvsNP1(:, 3), 1));
set(hGScatt, 'Markersize', 25);
hold on;
fitLineHandle = plot(NvsNP1(:, 1), yFit, ':b', 'DisplayName', 'FitLine');

xlim([0 max(ROIsValues(:)) * 1.1]);
ylim([0 max(ROIsValues(:)) * 1.1]);

xlabel(sprintf('%s day N', yAxeName));
ylabel(sprintf('%s day N + 1', yAxeName));
titleHand = title(sprintf('%s\nNvsN+1-%ddays-%dROIs-RSquare=%.3f', ...
    saveName, nDays, nROIs, RSquare), 'Interpreter', 'none');
% hLeg2 = legend('Location', 'EastOutside', 'Interpreter', 'none');
legend('off');


if newFig; makePrettyFigure(figNvsNP1); end;

set(fitLineHandle, 'LineWidth', 0.5);
set(titleHand, 'FontSize', 10);
% set(hLeg1, 'FontSize', 2);
% set(hLeg2, 'FontSize', 2);

end

