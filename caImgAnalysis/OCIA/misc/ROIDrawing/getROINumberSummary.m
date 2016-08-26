%% count
% ROISetIDs = [1 2 3 4 5 7];
% ROISetIDs = [4 5 7 9 11 13];
% thisRef = this;

spotIDs = thisRef.dw.spotIDs;
spotID = spotIDs{get(thisRef.GUI.handles.dw.filt.spotID, 'Value')};

% if no spot selected, do all spots
if strcmp(spotID, '-');
    for iSpot = 2 : numel(spotIDs);
        set(thisRef.GUI.handles.dw.filt.spotID, 'Value', iSpot);
        getROINumberSummary();
    end;
    set(thisRef.GUI.handles.dw.filt.spotID, 'Value', 1);
    return;
end;

% get animal ID
animalIDs = thisRef.dw.animalIDs;
animalID = animalIDs{get(thisRef.GUI.handles.dw.filt.animalID, 'Value')};

% create a name
ROISetBelongName = sprintf('%s - %s', animalID, spotID);

% select the ROISets and get their IDs
DWFilterSelectTable(thisRef, 'new');
ROISetIDs = DWGetRowID(thisRef, thisRef.dw.selectedTableRows);
nROISets = numel(ROISetIDs);

% get the day for these ROISets
dayIDs = get(thisRef, thisRef.dw.selectedTableRows, 'day');
% make sure each day is unique (am/pm)
if numel(unique(dayIDs)) ~= numel(dayIDs);
    for iDay = 1 : numel(dayIDs) - 1;
        if strcmp(dayIDs{iDay}, dayIDs{iDay + 1});
            dayIDs{iDay} = sprintf('%s_am', dayIDs{iDay});
            dayIDs{iDay + 1} = sprintf('%s_pm', dayIDs{iDay + 1});
        end;
    end;
end;

% get all ROINames
ROINames = cell(nROISets, 1);
ROINamesIntersec = {};
ROINamesUnion = {};
for iROISet = 1 : nROISets;
    ROISetData = getData(thisRef, thisRef.dw.selectedTableRows(iROISet), 'ROISets', 'data');
    ROINames{iROISet} = ROISetData.ROISet(1 : end - 1, 1);
    if isempty(ROINamesIntersec); ROINamesIntersec = ROINames{iROISet}; end;
    ROINamesIntersec = intersect(ROINamesIntersec, ROINames{iROISet});
    ROINamesUnion = [ROINamesUnion; ROINames{iROISet}]; %#ok<AGROW>
%     fprintf('day %s (%d): %d\n', dayIDs{iROISet}, iROISet, numel(ROINames{iROISet}));
end;
ROINamesUniqueUnion = unique(ROINamesUnion);
nUniqueROIs = numel(ROINamesUniqueUnion);
fprintf('intersect: %d, union: %d, uniqueUnion: %d\n', numel(ROINamesIntersec), numel(ROINamesUnion), nUniqueROIs);

% intersect matrix
intersects = nan(nROISets, nROISets);
for iRef = 1 : nROISets;
    for iTarg = 1 : nROISets;
        intersects(iRef, iTarg) = numel(intersect(ROINames{iRef}, ROINames{iTarg}));
    end;
end;

%% plot
figure('Name', sprintf('Summary for %s', ROISetBelongName), 'NumberTitle', 'off', 'Position', [860 50 1020 1060]);
subplot(2, 2, 1);
counts = zeros(nROISets, 1);
for i = 1 : nROISets;
    counts(i) = sum(cellfun(@(x)sum(strcmpi(x, ROINamesUnion)), ROINamesUniqueUnion) == i);
end;
bar(counts);
xlabel('Times seen'); ylabel('nROIs');
title('Number of times ROIs are present in dataset');
xlim([-0.1 nROISets + 1.1]);
subplot(2, 2, 3);
imagesc(intersects, [0 nUniqueROIs]);
set(gca, 'XTick', 1 : nROISets, 'XTickLabel', 1 : nROISets, 'YTick', 1 : nROISets, 'YTickLabel', dayIDs);
for iRef = 1 : nROISets;
    for iTarg = 1 : nROISets;
        text(iRef, iTarg, num2str(intersects(iRef, iTarg)), 'HorizontalAlignment', 'center', 'FontSize', 8);
    end;
end;
colorbar();
set(gca, 'CLim', [0 ceil(max(intersects(:)) / 10) * 10]);
subplot(2, 2, [2 4]);
title('ROI Presence');
hold on;
xRange = 1 : nROISets;
yRange = cellfun(@str2double, ROINamesUniqueUnion);
yRange(end) = yRange(end - 1) + 1;
for iROI = 1 : nUniqueROIs;
    presence = double(arrayfun(@(i)ismember(ROINamesUniqueUnion{iROI}, ROINames{i}), 1 : nROISets));
%     yROI = yRange(iROI);
    yROI = iROI;
    plot(xRange, yROI, 'LineStyle', 'none', 'Marker', 'o', ...
        'MarkerFaceColor', 'none', 'MarkerEdgeColor', 'black', 'MarkerSize', 5);
    presence(~presence) = NaN;
    presence(~isnan(presence)) = 0;
    col = [0 0 0];
    nNans = sum(isnan(presence));
    if ~nNans; col = [1 0 0]; end;
    if nNans == 1; col = [0.5 0 0]; end;
    plot(xRange, presence + yROI, 'LineStyle', 'none', 'Marker', 'o', ...
        'MarkerFaceColor', col, 'MarkerEdgeColor', col, 'MarkerSize', 5);
    % mark ROIs where only one day is missing
    if nNans == 1;
        presence(~isnan(presence)) = 0;
        presence(isnan(presence)) = 1;
        presence(~presence) = NaN;
        presence(~isnan(presence)) = 0;
        plot(xRange, presence + yROI, 'LineStyle', 'none', 'Marker', 'x', ...
            'MarkerFaceColor', col, 'MarkerEdgeColor', col, 'MarkerSize', 15);
    end;
end;
ylabel('ROIs');
ROISetps = 3;
yTicks = [1 (1 + ROISetps : ROISetps : nUniqueROIs - ROISetps) nUniqueROIs];
set(gca, 'YTick', yTicks, 'YTickLabel', ROINamesUniqueUnion(yTicks));
set(gca, 'XTick', 1 : nROISets, 'XTickLabel', dayIDs);
rotateXLabels(gca, 35);
ylim([-2.1 nUniqueROIs + 2.9]);
xlim([-0.1 nROISets + 1.1]);

makePrettyFigure();
savePath = sprintf('%s%s/ref/spots/%s__%s__ROISetOverlap', thisRef.path.localData, animalID, animalID, spotID);
export_fig(savePath, '-png', '-r150');
