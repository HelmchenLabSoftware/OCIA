function figHand = plotROIStatNvsNP1(axeH, ROIStat, groupingCell, groupLabels, saveName, plotLimits, xLab, showFit)

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
groupColors = lines(nGroups(1) * nGroups(1));

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
    
    % get the values and groupings for the current group 2
    ROIStatForGroup = ROIStat(groupingCell{2} == iGroup2); % ROI stats
    ROIGroupingForGroup = groupingCell{3}(groupingCell{2} == iGroup2); % ROI groupings
    grouping1ForGroup = groupingCell{1}(groupingCell{2} == iGroup2); % group 1 groupings
    % get all the ROI indexes
    uniqueROIsForGroup = unique(ROIGroupingForGroup);
    nUniqueROIsForGroup = numel(uniqueROIsForGroup);

    % create pairs in a nROIs x nGroup1 x nPairs
    ROIStatForGroupPaired = nan(nUniqueROIsForGroup, nGroups(1), 1000);
    % go through each ROI
    for iROI = 1 : nUniqueROIsForGroup;
        % get the ROIStats for this ROI (for the current group 2)
        ROIStatForROI = ROIStatForGroup(ROIGroupingForGroup == uniqueROIsForGroup(iROI));
        % get the grouping for this ROI (for the current group 2)
        grouping1ForROI = grouping1ForGroup(ROIGroupingForGroup == uniqueROIsForGroup(iROI));
        % go through each group 1
        for iGroupLoop = 1 : nGroups(1);
            % get the ROIStats for this ROI and this group 1 (and the current group 2)
            ROIStatForROIForGroup1 = ROIStatForROI(grouping1ForROI == uniqueGroups{1}(iGroupLoop));
            % store it
            ROIStatForGroupPaired(iROI, iGroupLoop, 1 : numel(ROIStatForROIForGroup1)) = ROIStatForROIForGroup1;
        end;
    end;
    
    % remove not created pairs (remained NaN)
    nanPairs = arrayfun(@(iPair)all(all(isnan(ROIStatForGroupPaired(:, :, iPair)))), 1 : size(ROIStatForGroupPaired, 3));
    ROIStatForGroupPaired(:, :, nanPairs) = [];

    % labels with count the number of ROIs
    legendLabels = cell(nGroups(1), nGroups(1));
    pointHandles = nan(nGroups(1), nGroups(1));

    % plot the points
    iPair = 1;
    allROIStatX = []; allROIStatY = [];
    % loop through all groups for X axis
    for iGroupLoop = 1 : nGroups(1);    
        % loop through the compared-to groups for Y axis
        for iGroupLoopB = iGroupLoop + 1 : nGroups(1);            
            % get the values for X and Y
            ROIStatX = ROIStatForGroupPaired(:, iGroupLoop, :);
            ROIStatX = ROIStatX(:);
            ROIStatY = ROIStatForGroupPaired(:, iGroupLoopB, :);
            ROIStatY = ROIStatY(:);
            
            % remove NaN pairs
            ROIStatY(isnan(ROIStatX)) = [];
            ROIStatX(isnan(ROIStatX)) = [];
            ROIStatX(isnan(ROIStatY)) = [];
            ROIStatY(isnan(ROIStatY)) = [];
            if all(isnan(ROIStatX)) && all(isnan(ROIStatY)); continue; end;
            if numel(ROIStatX) ~= numel(ROIStatX);
                o('#%s: group size mismatch.', mfilename, 0, 0);
                continue;
            end;
            
            % gather all values
            allROIStatX = [allROIStatX; ROIStatX]; %#ok<AGROW>
            allROIStatY = [allROIStatY; ROIStatY]; %#ok<AGROW>
            
            if showFit;
                % calculate linear fit R-square
                polyFitStats = polyfit(ROIStatX, ROIStatY, 1); 
                ROIStatPred = polyval(polyFitStats, ROIStatX); 
                r2 = rsquare(ROIStatY, ROIStatPred);
                % plot the fit
                plot(currAxeH, [min(ROIStatX) max(ROIStatX)], [min(ROIStatPred) max(ROIStatPred)], ...
                    'Color', groupColors(iPair, :), 'LineWidth', 2, 'LineStyle', '--');
                legendLabels{iGroupLoop, iGroupLoopB} = sprintf('%s [X] vs %s [Y] - N = %03d, %.2f slope, %.2f R^2adj', ...
                    groupLabels{1}{iGroupLoop}, groupLabels{1}{iGroupLoopB}, numel(ROIStatY), polyFitStats(2), r2);
            else
                legendLabels{iGroupLoop, iGroupLoopB} = sprintf('%s [X] vs %s [Y] - N = %03d', ...
                    groupLabels{1}{iGroupLoop}, groupLabels{1}{iGroupLoopB}, numel(ROIStatY));
            end;
            
            % plot points
            pointHandles(iGroupLoop, iGroupLoopB) = scatter(currAxeH, ROIStatX, ROIStatY, 15); 
            set(pointHandles(iGroupLoop, iGroupLoopB), 'MarkerEdgeColor', groupColors(iPair, :), ...
                'MarkerFaceColor', groupColors(iPair, :), 'Marker', 'o');
            iPair = iPair + 1;
        end;
    end;
    
    if showFit;
        % calculate linear fit R-square
        polyFitStatsAll = polyfit(allROIStatX, allROIStatY, 1); 
        ROIStatPredAll = polyval(polyFitStatsAll, allROIStatX); 
        r2All = rsquare(allROIStatY, ROIStatPredAll);
    end;
    
    % set the axis limits
    if isempty(plotLimits);
        xLims = get(currAxeH, 'XLim');
        yLims = get(currAxeH, 'YLim');
        minLim = min(xLims(1), yLims(1)) * 0.95;
        maxLim = max(xLims(2), yLims(2)) * 1.05;
        xlim(currAxeH, [minLim maxLim]);
        ylim(currAxeH, [minLim maxLim]);
    else
        xlim(plotLimits);
        ylim(plotLimits);
    end;
    
    % plot the diagonal
    plot(currAxeH, [minLim maxLim], [minLim maxLim], 'Color', 'black', 'LineWidth', 0.5, 'LineStyle', ':');
    
    % add title and axe labels
    set(currAxeH, 'FontSize', 15);
    % only on bottom plots
    if Y == basePos(2); xlabel(currAxeH, xLab, 'FontSize', 14); end;
    % only on left-most plots
    if X == basePos(1); ylabel(currAxeH, xLab, 'FontSize', 14); end;
    
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
    
    % stop holding and add title
    hold(currAxeH, 'off');
    if ~isempty(groupLabels{2});
        if showFit;
            title(currAxeH, sprintf('\\bf %s\\rm - N = %03d, %.2f slope, %.2f R^2adj', ...
                groupLabels{2}{iGroupLoop2}, numel(allROIStatX), polyFitStatsAll(2), r2All), 'FontSize', 18);
        else
            title(currAxeH, sprintf('\\bf %s\\rm - N = %03d', ...
                groupLabels{2}{iGroupLoop2}, numel(allROIStatX)), 'FontSize', 18);
        end;
    else
        if showFit;
            title(currAxeH, sprintf('N = %03d, %.2f slope, %.2f R^2adj', ...
                numel(allROIStatX), polyFitStatsAll(2), r2All), 'FontSize', 18);
        else
            title(currAxeH, sprintf('N = %03d', numel(allROIStatX)), 'FontSize', 18);
        end;      
    end;
    
end;

end
