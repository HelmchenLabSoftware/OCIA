function figHand = plotROIStatCompare(axeH, ROIStat1, ROIStat2, groupingCell, groupLabels, saveName, plotLimits, xLab, yLab, showFit)

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

% get the colormap for the first group
group1Colors = lines(nGroups(1));

% go through each group
axeHandles = zeros(nGroups(2), 1);

% make sure at least one plot is created
if nGroups(2) == 0;
    nGroups(2) = 1;
    uniqueGroups{2} = 1;
    groupingCell{2} = ones(numel(groupingCell{1}), 1);
    groupLabels{2} = [];
end;

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
    
    % get the values for the current group 2
    ROIStat1ForGroup2 = ROIStat1(groupingCell{2} == iGroup2);
    ROIStat2ForGroup2 = ROIStat2(groupingCell{2} == iGroup2);
    group1ForGroup2 = groupingCell{1}(groupingCell{2} == iGroup2);

    % labels with count the number of ROIs
    legendLabels = cell(nGroups(1), 1);
    pointHandles = nan(nGroups(1), 1);

    % plot the points
    % loop through all groups
    for iGroupLoop1 = 1 : nGroups(1);
        % get the group index
        iGroup1 = uniqueGroups{1}(iGroupLoop1);
        
        % get the ROIStats
        ROIStat1ForGroup21 = ROIStat1ForGroup2(group1ForGroup2 == iGroup1);
        ROIStat2ForGroup21 = ROIStat2ForGroup2(group1ForGroup2 == iGroup1);
        
        % calculate number of non-nan points
        nNonNan = sum(~isnan(ROIStat1ForGroup21(:)) & ~isnan(ROIStat2ForGroup21(:)));
        
        % exclude nan values
        ROIStat2ForGroup21(isnan(ROIStat1ForGroup21)) = [];
        ROIStat1ForGroup21(isnan(ROIStat1ForGroup21)) = [];
        ROIStat1ForGroup21(isnan(ROIStat2ForGroup21)) = [];
        ROIStat2ForGroup21(isnan(ROIStat2ForGroup21)) = [];
        
        if showFit && ~isempty(ROIStat1ForGroup21);
            % calculate linear fit R-square
            polyFitStats = polyfit(ROIStat1ForGroup21, ROIStat2ForGroup21, 1); 
            ROIStat2PredForGroup12 = polyval(polyFitStats, ROIStat1ForGroup21); 
            r2 = rsquare(ROIStat2ForGroup21, ROIStat2PredForGroup12);
            % plot the fit
            plot(currAxeH, [min(ROIStat1ForGroup21) max(ROIStat1ForGroup21)], [min(ROIStat2PredForGroup12) max(ROIStat2PredForGroup12)], ...
                'Color', group1Colors(iGroupLoop1, :), 'LineWidth', 2, 'LineStyle', '--');
            legendLabels{iGroupLoop1} = sprintf('%s - N = %03d, %.2f slope, %.2f R^2adj', ...
                groupLabels{1}{iGroupLoop1}, nNonNan, polyFitStats(2), r2);
        elseif ~isempty(ROIStat1ForGroup21);
            legendLabels{iGroupLoop1} = sprintf('%s - N = %03d', groupLabels{1}{iGroupLoop1}, nNonNan);
        end;

        % plot points
        pointHandles(iGroupLoop1) = scatter(currAxeH, ROIStat1ForGroup21, ROIStat2ForGroup21, 15); 
        set(pointHandles(iGroupLoop1), 'MarkerEdgeColor', group1Colors(iGroupLoop1, :), ...
            'MarkerFaceColor', group1Colors(iGroupLoop1, :), 'Marker', 'o');
    end;
    
    if showFit;
        % exclude nan values
        ROIStat2ForGroup2(isnan(ROIStat1ForGroup2)) = [];
        ROIStat1ForGroup2(isnan(ROIStat1ForGroup2)) = [];
        ROIStat1ForGroup2(isnan(ROIStat2ForGroup2)) = [];
        ROIStat2ForGroup2(isnan(ROIStat2ForGroup2)) = [];
        % calculate linear fit R-square
        polyFitStatsAll = polyfit(ROIStat1ForGroup2, ROIStat2ForGroup2, 1); 
        ROIStat2ForGroupPredAll = polyval(polyFitStatsAll, ROIStat1ForGroup2); 
        r2All = rsquare(ROIStat2ForGroup2, ROIStat2ForGroupPredAll);
    end;
    
    % set the axis limits
    if ~isempty(plotLimits);
        xlim(plotLimits);
        ylim(plotLimits);
    end;
    
    % add title and axe labels
    set(currAxeH, 'FontSize', 15);
    % only on bottom plots
    if Y == basePos(2); xlabel(currAxeH, xLab, 'FontSize', 14); end;
    % only on left-most plots
    if X == basePos(1); ylabel(currAxeH, yLab, 'FontSize', 14); end;
    
    % if more than one group/plot, update position
    if nGroups(2) ~= 1;
        X = X + W + WPad;
        if X >= basePos(1) + basePos(3);
            X = basePos(1); 
            Y = Y + H + HPad;
        end;
    end;
    
    % add legend on the current plot
    pointHandles(cellfun(@isempty, legendLabels)) = [];
    legendLabels(cellfun(@isempty, legendLabels)) = [];
    if ~isempty(legendLabels);
        hLeg = legend(currAxeH, pointHandles, legendLabels, 'Location', 'NorthEast', 'Orientation', 'Vertical');
        set(hLeg, 'FontSize', 8);
    end;
    
    % calculate number of non-nan points
    nNonNan = sum(~isnan(ROIStat1ForGroup2(:)) & ~isnan(ROIStat2ForGroup2(:)));
        
    % stop holding and add title
    hold(currAxeH, 'off');
    if ~isempty(groupLabels{2});
        if showFit;
            title(currAxeH, sprintf('\\bf %s\\rm - N = %03d, %.2f slope, %.2f R^2adj', ...
                groupLabels{2}{iGroupLoop2}, nNonNan, polyFitStatsAll(2), r2All), 'FontSize', 18);
        else
            title(currAxeH, sprintf('\\bf %s\\rm - N = %03d', ...
                groupLabels{2}{iGroupLoop2}, nNonNan), 'FontSize', 18);
        end;
    else
        if showFit;
            title(currAxeH, sprintf('N = %03d, %.2f slope, %.2f R^2adj', ...
                nNonNan, polyFitStatsAll(2), r2All), 'FontSize', 18);
        else
            title(currAxeH, sprintf('N = %03d', nNonNan), 'FontSize', 18);
        end;      
    end;
    
end;

end
