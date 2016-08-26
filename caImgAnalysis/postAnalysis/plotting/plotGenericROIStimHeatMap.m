function figHand = plotGenericROIStimHeatMap(axeH, valuesMat, cLim, titleStr, xLab, yLab, cBarLab, saveName, sortMethod, sortDim)

% Generic function that generates a heatmap plot for a set of ROIs
%
% Usage: plotGenericROIStimHeatMap(valuesMat, cLim, titleStr, xLab, yLab, cBarLab, saveName, dirName, doSavePlot, sortMethod, sortDim)
% valuesMat: NxM matrix containing a data series for m rois
% cLim: ?
% titleStr: Title of image
% xLab: Label of x-axis
% yLab: Label of y-axis
% cBarLab: color Bar label
% saveName: figure save name
% sortMethod: method to sort evoked response
% sortDim: which dimesion should be sorted by sortMethod

% create the figure
if isempty(axeH);
    figHand = figure('Name', saveName, 'NumberTitle', 'off', 'Color', 'white');
    axeH = axes('Parent', figHand);
else
    figHand = getParentFigure(axeH);
end;

% sorting
if ismember(1, sortDim);
    if strcmp(sortMethod, 'max');
        if ~any(valuesMat(eye(size(valuesMat)) == 1) ~= 1);
            valuesMatNoDiagOnes = valuesMat;
            valuesMatNoDiagOnes(eye(size(valuesMat)) == 1) = NaN;
            [~, indexes] = sort(max(valuesMatNoDiagOnes, [], 1));
        else
            [~, indexes] = sort(max(valuesMat, [], 1));
        end;
    elseif strcmp(sortMethod, 'mean');
        [~, indexes] = sort(nanmean(valuesMat, 1));
    elseif strcmp(sortMethod, 'sum');
        [~, indexes] = sort(nansum(valuesMat, 1));
    else % if no sort is required, leave it in original order
        indexes = 1 : size(valuesMat, 1);
    end;
    valuesMat = valuesMat(:, indexes);
    xLab = xLab(indexes);
end;

if ismember(2, sortDim);
    if strcmp(sortMethod, 'max');
        if ~any(valuesMat(eye(size(valuesMat)) == 1) ~= 1);
            valuesMatNoDiagOnes = valuesMat;
            valuesMatNoDiagOnes(eye(size(valuesMat))) = NaN;
            [~, indexes] = sort(max(valuesMatNoDiagOnes, [], 2));
        else
            [~, indexes] = sort(max(valuesMat, [], 2));
        end;
    elseif strcmp(sortMethod, 'mean');
        [~, indexes] = sort(nanmean(valuesMat, 2));
    elseif strcmp(sortMethod, 'sum');
        [~, indexes] = sort(nansum(valuesMat, 2));
    else % if no sort is required, leave it in original order
        indexes = 1 : size(valuesMat, 2);
    end;
    valuesMat = valuesMat(indexes, :);
    yLab = yLab(indexes);
end;

% ploting
if ~isempty(cLim);
    imagesc(valuesMat, cLim, 'Parent', axeH);
else
    imagesc(valuesMat, 'Parent', axeH);
end;

% add the color bar on the last axe
hColBar = colorbar('peer', axeH);
set(get(hColBar, 'YLabel'), 'String', cBarLab);
% set other properties and add title
set(axeH, 'XTick', 1 : numel(xLab), 'XTickLabel', xLab, 'YTick', 1 : numel(yLab), 'YTickLabel', yLab);
title(axeH, titleStr, 'Interpreter', 'none');
set(axeH, 'FontSize', 13);

end
