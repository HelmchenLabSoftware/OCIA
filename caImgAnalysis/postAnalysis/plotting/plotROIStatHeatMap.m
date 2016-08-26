function figHand = plotROIStatHeatMap(axeH, ROIStat, stimIDs, saveName, ROINames, plotLimits, colorMapName, colBarLab, titleString)

%% init
% get the size of the data set
[nStimTypes, nTrials, nROIs] = size(ROIStat);

% create the figure
if isempty(axeH);
    figHand = figure('Name', saveName, 'NumberTitle', 'off', 'Color', 'white');
    axeH = axes('Parent', figHand);
else
    figHand = getParentFigure(axeH);
    axeParent = get(axeH, 'Parent');
end;

%% plot
% get the position of the initial axe
baseAxePosition = get(axeH, 'Position');
% hide the original axe
set(axeH, 'YTick', [], 'XTick', [], 'XColor', 'white', 'YColor', 'white');
% create a holder for the handles of the sub-axes
imAxeHandles = nan(nStimTypes, 1);
% create one sub-plot for each stimulus type
for iStimType = 1 : nStimTypes;
    % calculate the new position
    axePosition = baseAxePosition;
    axePosition(3) = (baseAxePosition(3) / (nStimTypes + 0.05)) * 0.98;
    axePosition(1) = baseAxePosition(1) + (iStimType - 1) * axePosition(3) * 1.02;
    % create the new axe
    imAxeHandles(iStimType) = axes('Parent', axeParent, 'Color', 'blue', 'Position', axePosition, 'Visible', 'off');
    % get the ROI property matrix
    ROIRespsForStimType = reshape(ROIStat(iStimType, :, :), nTrials, nROIs)';
    nanOnlyTrials = arrayfun(@(iTrial)all(isnan(ROIRespsForStimType(:, iTrial))), 1 : nTrials);
    nRealTrials = nTrials - sum(nanOnlyTrials);
    % plot the matrix as heat map
    imagesc(1 : nRealTrials, 1 : nROIs, ROIRespsForStimType(:, ~nanOnlyTrials), 'Parent', imAxeHandles(iStimType));
    % if there are plot limits, apply them
    if ~isempty(plotLimits);
        set(imAxeHandles(iStimType), 'CLim', plotLimits);
    end;
    % change the colormap
    colormap(imAxeHandles(iStimType), colorMapName); close(gcf);
    % remove ticks
    set(imAxeHandles(iStimType), 'YTick', []);
    % plot the stimulus line
    hold(imAxeHandles(iStimType), 'on');
    plot(imAxeHandles(iStimType), [0 0], [0 nROIs + 1], 'LineWidth', 1.5, 'LineStyle', '--', 'Color', 'red');
    % plot the stimulus IDs if any present
    if ~isempty(stimIDs);
        text(0.5 + nRealTrials / 2, 0.0005 * nROIs * nROIs - 0.0483 * nROIs + 0.5467, stimIDs{iStimType}, 'Color', 'black', 'FontWeight', 'bold', ...
                'HorizontalAlignment', 'center', 'Parent', imAxeHandles(iStimType), 'FontSize', 14);
    end;
    hold(imAxeHandles(iStimType), 'off');
end;

% add the color bar on the last axe
hColBar = colorbar('peer', imAxeHandles(end));
set(get(hColBar, 'YLabel'), 'String', colBarLab);
% compensate the width
colBarPos = get(hColBar, 'Position');
set(imAxeHandles(end), 'Position', get(imAxeHandles(end), 'Position') + [0 0 colBarPos(3) * 2 0]);
% set(hColBar, 'Color', 'red');
% create the ROI label axe
textAxeH = axes('Parent', axeParent, 'Color', 'blue', 'Position', get(imAxeHandles(1), 'Position'), 'Visible', 'off', ...
    'XLim', get(imAxeHandles(1), 'XLim'), 'YLim', get(imAxeHandles(1), 'YLim'));
% add ROI labels
ROINamesFlipped = flipud(ROINames);
xOffset = - nTrials * 0.01;
if nTrials == 1;
    xOffset = 0.48;
    set(imAxeHandles, 'XTick', []);
end;
for iROI = 1 : nROIs;
    text(xOffset, iROI, ROINamesFlipped{iROI}, 'Parent', textAxeH, 'HorizontalAlignment', 'right', ...
        'Interpreter', 'none', 'FontSize', max(min(15 - (0.166 * nROIs), 20), 6));
end;
% link all these axes
linkaxes([imAxeHandles; textAxeH]', 'y');
% put the label axe at the bottom
restackAxes(textAxeH, 'bottom');

% add title
title(axeH, titleString, 'FontSize', 15);

end
