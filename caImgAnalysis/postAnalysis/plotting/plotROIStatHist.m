function figHand = plotROIStatHist(axeH, ROIStat, groupingCell, groupLabels, saveName, plotLimits, xLab, ~)

%% init
% create the figure
if isempty(axeH);
    figHand = figure('Name', saveName, 'NumberTitle', 'off', 'Color', 'white');
    axeH = axes('Parent', figHand);
else
    figHand = getParentFigure(axeH);
end;

% get the number of groups
uniqueGroups = cellfun(@(grouping)unique(grouping), groupingCell, 'UniformOutput', false);
nGroups = cellfun(@(uniqueGroup)numel(uniqueGroup), uniqueGroups);

%% plot
% gather infos about original axe
axeHParent = get(axeH, 'Parent');
basePos = get(axeH, 'Position');
% get subplot sizes
M = ceil(sqrt(nGroups(2))); N = iff(M * (M - 1) >= nGroups(2), M - 1, M);
% get the dimensions of the subplots
WPad = basePos(3) * 0.1; W = (basePos(3) - (M - 1) * WPad) / M;
HPad = basePos(4) * 0.1; H = (basePos(4) - (N - 1) * HPad) / N;
X = basePos(1); Y = basePos(2);

% get maximum y axe
maxY = -1;
if isempty(plotLimits);
    plotLimits = [min(ROIStat(:)), max(ROIStat(:))];
end;

% get the colormap for the first group
group1Colors = lines(nGroups(1));
if size(group1Colors, 1) == 2;
    group1Colors = [1 0 0; 0 0 1];
elseif size(group1Colors, 1) == 3;
    group1Colors = [1 0 0; 0 0 1; 0 0.7 0];
end;

% go through each group
axeHandles = zeros(nGroups(2), 1);
curveHandles = zeros(nGroups(2), nGroups(1));

% make sure at least one plot is created
if nGroups(2) == 0;
    nGroups(2) = 1;
    uniqueGroups{2} = 1;
    groupingCell{2} = ones(numel(groupingCell{1}), 1);
    groupLabels{2} = [];
end;

% labels with count the number of ROIs
legendLabels = cell(nGroups(2), nGroups(1));

% go through each group
for iGroupLoop2 = 1 : nGroups(2);
    % get the group index
    iGroup2 = uniqueGroups{2}(iGroupLoop2);
    
    % if more than one group/plot, create other axes
    if nGroups(2) ~= 1;
        currAxeH = axes('Parent', axeHParent, 'Color', 'white', 'Position', [X Y W H], 'Visible', 'on');
        % hide the original axe
        set(axeH, 'YTick', [], 'XTick', [], 'XColor', 'white', 'YColor', 'white');
        
    % if only one plot, do not create other axes
    else
        currAxeH = axeH;
    end;
    % hold to plot multiple curves on the same graph
    hold(currAxeH, 'on');
    
    % store the axe handle
    axeHandles(iGroupLoop2) = currAxeH;
    
    %% plot
    for iGroupLoop1 = 1 : nGroups(1);
        % get the group index
        iGroup1 = uniqueGroups{1}(iGroupLoop1);
        ROIStatForGroup = ROIStat(groupingCell{2} == iGroup2 & groupingCell{1} == iGroup1);
        nNonNanROIStatForGroup = numel(ROIStatForGroup(~isnan(ROIStatForGroup)));
        if isempty(ROIStatForGroup); continue; end;
        nBins = round(sqrt(numel(ROIStatForGroup)) * 2);
        plotLimRange = abs(diff(plotLimits));
        binCenters = plotLimits(1) : (plotLimRange / nBins) : plotLimits(2);
        [counts, xPos] = hist(currAxeH, ROIStatForGroup, binCenters);
        curveHandles(iGroupLoop2, iGroupLoop1) = plot(currAxeH, xPos, counts / nNonNanROIStatForGroup, 'LineWidth', 2);
    
        % color each curve
        set(curveHandles(iGroupLoop2, iGroupLoop1), 'Color', group1Colors(iGroupLoop1, :));
        
        % fill-in legend string
        legendLabels{iGroupLoop2, iGroupLoop1} = sprintf('%s N=%02d', groupLabels{1}{iGroupLoop1}, nNonNanROIStatForGroup);
    end;
    
    % set X limits
    xlim(currAxeH, plotLimits * 1.05);
    
    % add title and axe labels
    set(currAxeH, 'FontSize', 15);
    % only on bottom plots
    if Y == basePos(2); xlabel(currAxeH, xLab, 'FontSize', 15); end;
    % only on left-most plots
    if X == basePos(1); ylabel(currAxeH, 'Fraction of neurons', 'FontSize', 15); end;
    
    % update max y limit
    maxY = max([get(currAxeH, 'YLim'), maxY]);
    
    % if more than one group/plot, update position
    if nGroups(2) ~= 1;
        X = X + W + WPad;
        if X >= basePos(1) + basePos(3);
            X = basePos(1); 
            Y = Y + H + HPad;
        end;
    end;
    
    % add legend on the current plot
    allHandles = curveHandles(iGroupLoop2, :);
    allLegendLabels = legendLabels(iGroupLoop2, :);
    allHandles(cellfun(@isempty, allLegendLabels)) = [];
    allLegendLabels(cellfun(@isempty, allLegendLabels)) = [];
    hLeg = legend(currAxeH, allHandles, allLegendLabels, 'Location', 'NorthEast', 'Orientation', 'Vertical');
    set(hLeg, 'FontSize', 12);
    
    % stop holding and add title
    hold(currAxeH, 'off');
    if ~isempty(groupLabels{2});
        title(currAxeH, groupLabels{2}(iGroupLoop2), 'FontSize', 16);
    end;
    
end;
    
% update Y limit
for iHandle = 1 : numel(axeHandles);
    currYLim = get(axeHandles(iHandle), 'YLim');
    set(axeHandles(iHandle), 'YLim', [currYLim(1), maxY * 1.1]);
end;

end
