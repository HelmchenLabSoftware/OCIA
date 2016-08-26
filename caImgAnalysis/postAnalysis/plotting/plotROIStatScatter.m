function figHand = plotROIStatScatter(axeH, ROIStat, groupingCell, groupLabels, saveName, plotLimits, yLab, titleString)

%% init
% abort if no data
if isempty(ROIStat); return; end;

% create the figure
if isempty(axeH);
    figHand = figure('Name', saveName, 'NumberTitle', 'off', 'Color', 'white');
    axeH = axes('Parent', figHand);
else
    figHand = getParentFigure(axeH);
    axeParent = get(axeH, 'Parent'); %#ok<NASGU>
end;

% get the number of groups
uniqueGroups = cellfun(@(grouping)unique(grouping), groupingCell, 'UniformOutput', false);
nGroups = cellfun(@(uniqueGroup)numel(uniqueGroup), uniqueGroups);

% make sure at least one color is defined
if nGroups(2) == 0;
    nGroups(2) = 1;
    uniqueGroups{2} = 1;
    groupingCell{2} = ones(numel(groupingCell{1}), 1);
    groupLabels{2} = [];
end;

%% plot
% xJitter = 0.08;
xJitter = 0.5;
hold(axeH, 'on');
hPoint = nan(1, nGroups(2));
    
% get the colormap for the second group
group2Colors = lines(nGroups(2));
if size(group2Colors, 1) == 2;
    group2Colors = [1 0 0; 0 0 1];
elseif size(group2Colors, 1) == 3;
    group2Colors = [1 0 0; 0 0 1; 0 0.7 0];
end;

yPosLab = max(ROIStat(:));

% go through each group
for iGroupLoop = 1 : nGroups(1);
    % get the group index
    iGroup = uniqueGroups{1}(iGroupLoop);
    
    % get the values for this group
    ROIStatForGroup = ROIStat(groupingCell{1} == iGroup);
    grouping2 = groupingCell{2}(groupingCell{1} == iGroup);
   
    % calculate the mean and error
    meanForGroups = nanmean(ROIStatForGroup);
    errorForGroups = nanstd(ROIStatForGroup);
    
    % plot the mean bars
    meanBarH = plot(axeH, [iGroupLoop - xJitter * 0.6, iGroupLoop + xJitter * 0.6], ones(2, 1) * meanForGroups, ...
        'black', 'LineWidth', 3);
    % plot the error bars
    plot(axeH, ones(2, 1) * iGroupLoop, [meanForGroups - errorForGroups meanForGroups + errorForGroups], ...
        'black', 'LineWidth', 3);
    
    % plot the points
    nPoints = zeros(nGroups(2), 1);
    for iPoint = 1 : numel(ROIStatForGroup);
        iGroup2 = find(grouping2(iPoint) == unique(grouping2));
        nPoints(iGroup2) = nPoints(iGroup2) + iff(isnan(ROIStatForGroup(iPoint)), 0, 1);
        xCenter = iGroupLoop - 0.5 * xJitter + (iGroup2 - 1) * xJitter / nGroups(2);
        hPoint(iGroup2) = scatter(axeH, xCenter + rand * xJitter / nGroups(2), ROIStatForGroup(iPoint), 15);
        set(hPoint(iGroup2), 'MarkerEdgeColor', group2Colors(iGroup2, :), 'MarkerFaceColor', group2Colors(iGroup2, :), 'Marker', 'o');
    end;
    
    % place number of data points
    for iGroup2 = 1 : nGroups(2);
        if nPoints(iGroup2);
            xCenterLab = iGroupLoop - 0.5 * xJitter + (iGroup2 - 1) * xJitter / nGroups(2) + 0.5 * xJitter / nGroups(2);
            bgColor = group2Colors(iGroup2, :) + 0.7; bgColor(bgColor > 1) = 1;
            text(xCenterLab, ceil(yPosLab), sprintf('N=%03d', nPoints(iGroup2)), 'BackgroundColor', ...
                bgColor, 'Parent', axeH, 'HorizontalAlignment', 'center', 'FontSize', 5 + 8 / nGroups(2));
        end;
    end;
    
    
    nNonNanROIStatForGroup = numel(ROIStatForGroup(~isnan(ROIStatForGroup)));
    xCenterLab = iGroupLoop;
    text(xCenterLab, ceil(yPosLab) + 0.6, sprintf('N=%03d', nNonNanROIStatForGroup), 'BackgroundColor', ...
        [0.7, 0.7, 0.7], 'Parent', axeH, 'HorizontalAlignment', 'center', 'FontSize', 14);

end;

% add legend
groupLabels{2}(isnan(hPoint)) = [];
hPoint(isnan(hPoint)) = [];
if isempty(groupLabels{2});
    hLeg = legend(axeH, meanBarH, 'mean \pm SD');
else
    if size(groupLabels{2}, 1) > size(groupLabels{2}, 2);
        groupLabels{2} = groupLabels{2}';
    end;
    hLeg = legend(axeH, [meanBarH, hPoint], [ 'mean \pm SD', groupLabels{2} ]);
end;
set(hLeg, 'FontSize', 15);

% adjust the Y limits
if ~isempty(plotLimits);
    set(axeH, 'YLim', plotLimits);
end;


% % add the significance
% if ~isempty(pValue);
%     sigText = 'n.s.';
%     if pValue < 0.001; sigText = sprintf('*** (p = %.5f)', pValue);
%     elseif pValue < 0.01; sigText = sprintf('** (p = %.5f)', pValue);
%     elseif pValue < 0.05; sigText = sprintf('* (p = %.5f)', pValue);
%     end;
%     sigBarH = (plotLimits(2) - plotLimits(1)) * 0.05;
%     sigBarY = plotLimits(2) - (plotLimits(2) - plotLimits(1)) * 0.1;
%     plot(axeH, [1 1 NaN 1 2 NaN 2 2], [sigBarY - sigBarH sigBarY NaN sigBarY sigBarY NaN sigBarY sigBarY - sigBarH], 'Color', 'black', 'LineWidth', 2);
%     text(1.5, sigBarY + sigBarH, sigText, 'Parent', axeH, 'FontSize', 15, 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
% end;


% adjust font size
set(axeH, 'FontSize', 22);

% create group labels if none provided
if isempty(groupLabels{1});
    groupLabels = regexp(regexprep(sprintf('Group %02d,', 1 : nGroups(1)), ',$', ''), ',', 'split');
end;
set(axeH, 'XTick', 1 : nGroups(1), 'XTickLabel', groupLabels{1}, 'FontSize', max(min(15 - (0.166 * nGroups(1)), 20), 6));
xlim(axeH, [0.5 nGroups(1) + 0.5]);

% add labels
ylabel(axeH, yLab, 'FontSize', 15);
title(axeH, titleString);

hold(axeH, 'off');

end
