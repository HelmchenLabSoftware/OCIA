function OCIA_startFunction_multiAnimalAnalysisPipeline_ROISets(this)
% OCIA_startFunction_multiAnimalAnalysisPipeline_ROISets - [no description]
%
%       OCIA_startFunction_multiAnimalAnalysisPipeline_ROISets(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% load the list of all animals and spots
% OCIA_startFunction_loadAllROISets(this);

%% extract pooled data
% get the paths
mainSavePath = this.path.OCIASave;
dataTablePath = sprintf('%sROISetDataTable.mat', mainSavePath);

% if data table is not created/stored yet, create it
if ~exist(dataTablePath, 'file');
    
    % get all the imaging spot/day/animal combinations
    [~, filtTableIndexesSpots] = DWFilterTable(this, 'rowType = Spot');
    
    % create the table
    dataTable = cell2table(get(this, filtTableIndexesSpots, { 'animal', 'spot', 'day' }), ...
        'VariableNames', { 'animalID', 'spotID', 'day' });
    dataTable.shortAnimID = regexprep(dataTable.animalID, 'mou_bl_', '');
    dataTable.ROISets = cell(size(dataTable, 1), 1);
    dataTable.trialRowIDs = cell(size(dataTable, 1), 1);
    dataTable.putativeTrials = cell(size(dataTable, 1), 1);
    dataTable.validTrials = cell(size(dataTable, 1), 1);
    
    % get all ROISets
    [~, filtTableIndexesROISets] = DWFilterTable(this, 'rowType = ROISet');
    ROISetData = getData(this, filtTableIndexesROISets, 'ROISets', 'data');
    
    % combine the two row indexes
    fullRowIDsSpots = get(this, filtTableIndexesSpots, { 'animal', 'spot', 'day' });
    fullRowIDsSpots = arrayfun(@(iRow) sprintf('%s_%s_%s', fullRowIDsSpots{iRow, :}), 1 : size(fullRowIDsSpots, 1), ...
        'UniformOutput', false)';
    fullRowIDsROISets = get(this, filtTableIndexesROISets, { 'animal', 'spot', 'day' });
    fullRowIDsROISets = arrayfun(@(iRow) sprintf('%s_%s_%s', fullRowIDsROISets{iRow, :}), ...
        1 : size(fullRowIDsROISets, 1), 'UniformOutput', false)';
    [~, correspIndexes] = ismember(fullRowIDsROISets, fullRowIDsSpots);
    
    % append some variables
    dataTable.ROISets(correspIndexes) = arrayfun(@(iRow)ROISetData{iRow}.ROISet(:, 1), 1 : size(ROISetData, 1), ...
        'UniformOutput', false)';
    dataTable.trialRowIDs(correspIndexes) = arrayfun(@(iRow)ROISetData{iRow}.runsValidity, 1 : size(ROISetData, 1), ...
        'UniformOutput', false)';
    dataTable.putativeTrials(correspIndexes) = arrayfun(@(iRow)numel(ROISetData{iRow}.runsValidity), 1 : size(ROISetData, 1), ...
        'UniformOutput', false)';    
    
    processedDataPath = sprintf('%s1502_chronic.h5', mainSavePath);
    for iRow = 1 : size(dataTable, 1);
        trialRowIDs = dataTable.trialRowIDs{iRow};
        if isempty(trialRowIDs); continue; end;
        nValidTrials = 0;
        for iTrial = 1 : numel(trialRowIDs);
            dataSetPath = sprintf('/mou_bl_%s/%s/%s/caTraces/%s', dataTable.shortAnimID{iRow}, ...
                dataTable.spotID{iRow}, dataTable.day{iRow}, trialRowIDs{iTrial});
            nValidTrials = nValidTrials + double(h5exists(processedDataPath, dataSetPath));
        end;
        if nValidTrials ~= 0;
            dataTable.validTrials{iRow} = nValidTrials;
        end;
    end;

    % remove empty rows
    dataTable(cellfun(@isempty, dataTable.shortAnimID), :) = [];
    dataTable(cellfun(@isempty, dataTable.ROISets), :) = [];
    dataTable{cellfun(@isempty, dataTable.validTrials), 'validTrials'} = { NaN };
    % exclude animal 4
    dataTable(cellfun(@(anID) strcmp(anID, '150217_04'), dataTable.shortAnimID), :) = [];
    dataTable(cellfun(@(anID) strcmp(anID, '150217_05'), dataTable.shortAnimID), :) = [];
    dataTable(cellfun(@(anID) strcmp(anID, '150217_08'), dataTable.shortAnimID), :) = [];
    % save the table
    save(dataTablePath, 'dataTable');

% load the data table
else
    
    % load file
    matStruct = load(dataTablePath);
    dataTable = matStruct.dataTable;
    
end;

% get all unique dates
allDates = dataTable.day;
uniqueAllDates = unique(allDates);
dateVecs = datevec(datestr(uniqueAllDates, 'yyyy_mm_dd'), 'yyyy_mm_dd');
uniqueDayIndices = arrayfun(@(iDate) 1 + etime(dateVecs(iDate, :), dateVecs(1, :)) / 3600 / 24, 1 : size(dateVecs, 1));

animalIDs = unique(dataTable.shortAnimID);
spotIDs = unique(dataTable.spotID);

%% plot pooled data - trial numbers
hFig = figure('Name', 'Number of trials', 'NumberTitle', 'off', 'Position', [370, 185, 1270 900], ...
    'Color', 'white');
markers = { 's', 'o', '^', 'd', '<' };
colors = lines(numel(animalIDs));
plotHandles = nan(2, 200);
hold('on');
for iAnim = 1 : numel(animalIDs);
    for iSpot = 1 : numel(spotIDs);
        animSpotMask = strcmp(animalIDs{iAnim}, dataTable.shortAnimID) & strcmp(spotIDs{iSpot}, dataTable.spotID);
        daysForSpotAnim = dataTable.day(animSpotMask);
        putTrialsForSpotAnim = cell2mat(dataTable.putativeTrials(animSpotMask));
        valTrialsForSpotAnim = cell2mat(dataTable.validTrials(animSpotMask));
        valTrialsForSpotAnim(isnan(valTrialsForSpotAnim)) = putTrialsForSpotAnim(isnan(valTrialsForSpotAnim));
        [~, b] = ismember(daysForSpotAnim, uniqueAllDates);
        dayIndexesForSpotAnim = uniqueDayIndices(b);
    %     offsetX = 0.1 * iAnim;
        offsetX = 0;
        plotHandles(1, iAnim) = plot(dayIndexesForSpotAnim + offsetX, valTrialsForSpotAnim, ...
            'LineWidth', 2, 'LineStyle', '--', 'Color', colors(iAnim, :));
        plotHandles(2, iSpot) = scatter(dayIndexesForSpotAnim + offsetX, valTrialsForSpotAnim, 120, ...
            'Marker', markers{iSpot}, 'MarkerFaceColor', colors(iAnim, :), 'MarkerEdgeColor', colors(iAnim, :));
    end;
end;
hold('off');
legend([plotHandles(1, 1 : numel(animalIDs)), plotHandles(2, 1 : numel(spotIDs))], [animalIDs, spotIDs], ...
    'Interpreter', 'none', 'Location', 'North', 'Orientation', 'Horizontal', 'FontSize', 17);
set(gca, 'XLim', [-0.9 52], 'YLim', [-0.9 95], 'FontSize', 22);
ylabel('Number of trials');
xlabel('Days since training start');
title('Trial numbers', 'FontSize', 25);
figSavePath = sprintf('%strialNumbers', mainSavePath);
saveas(hFig, figSavePath);
export_fig(figSavePath, '-png', '-r150', hFig);
close(hFig);

%% plot pooled data - ROI numbers
hFig = figure('Name', 'Number of ROIs', 'NumberTitle', 'off', 'Position', [370, 185, 1270 900], ...
    'Color', 'white');
markers = { 's', 'o', '^', 'd', '<' };
colors = lines(numel(animalIDs));
plotHandles = nan(2, 200);
hold('on');
for iAnim = 1 : numel(animalIDs);
    for iSpot = 1 : numel(spotIDs);
        animSpotMask = strcmp(animalIDs{iAnim}, dataTable.shortAnimID) & strcmp(spotIDs{iSpot}, dataTable.spotID);
        daysForSpotAnim = dataTable.day(animSpotMask);
        ROINumbers = cellfun(@numel, dataTable.ROISets(animSpotMask));
        [~, b] = ismember(daysForSpotAnim, uniqueAllDates);
        dayIndexesForSpotAnim = uniqueDayIndices(b);
    %     offsetX = 0.1 * iAnim;
        offsetX = 0;
        plotHandles(1, iAnim) = plot(dayIndexesForSpotAnim + offsetX, ROINumbers, ...
            'LineWidth', 2, 'LineStyle', '--', 'Color', colors(iAnim, :));
        plotHandles(2, iSpot) = scatter(dayIndexesForSpotAnim + offsetX, ROINumbers, 120, ...
            'Marker', markers{iSpot}, 'MarkerFaceColor', colors(iAnim, :), 'MarkerEdgeColor', colors(iAnim, :));
    end;
end;
hold('off');
legend([plotHandles(1, 1 : numel(animalIDs)), plotHandles(2, 1 : numel(spotIDs))], [animalIDs, spotIDs], ...
    'Interpreter', 'none', 'Location', 'North', 'Orientation', 'Horizontal', 'FontSize', 17);
set(gca, 'XLim', [-0.9 52], 'YLim', [-0.9 69], 'FontSize', 22);
ylabel('Number of ROIs');
xlabel('Days since training start');
title('ROI numbers', 'FontSize', 25);
figSavePath = sprintf('%sROINumbers', mainSavePath);
saveas(hFig, figSavePath);
export_fig(figSavePath, '-png', '-r150', hFig);
close(hFig);

%% plot pooled data - conserved ROI numbers
hFig = figure('Name', 'Conserved number of ROIs', 'NumberTitle', 'off', 'Position', [370, 185, 1270 900], ...
    'Color', 'white');
markers = { 's', 'o', '^', 'd', '<' };
colors = lines(numel(animalIDs));
plotHandles = nan(2, 200);
hold('on');
for iAnim = 1 : numel(animalIDs);
    for iSpot = 1 : numel(spotIDs);
        animSpotMask = strcmp(animalIDs{iAnim}, dataTable.shortAnimID) & strcmp(spotIDs{iSpot}, dataTable.spotID);
        daysForSpotAnim = dataTable.day(animSpotMask);
        
        ROINames = dataTable.ROISets(animSpotMask);
        nROISets = numel(ROINames);
        
        % intersect matrix
        intersects = nan(nROISets, nROISets);
        for iRef = 1 : nROISets;
            for iTarg = 1 : nROISets;
                intersects(iRef, iTarg) = numel(intersect(ROINames{iRef}, ROINames{iTarg})) - 1;
            end;
        end;
        
        [~, b] = ismember(daysForSpotAnim, uniqueAllDates);
        dayIndexesForSpotAnim = uniqueDayIndices(b);
    %     offsetX = 0.1 * iAnim;
        offsetX = 0;
        plotHandles(1, iAnim) = plot(dayIndexesForSpotAnim + offsetX, intersects(1, :), ...
            'LineWidth', 2, 'LineStyle', '--', 'Color', colors(iAnim, :));
        plotHandles(2, iSpot) = scatter(dayIndexesForSpotAnim + offsetX, intersects(1, :), 120, ...
            'Marker', markers{iSpot}, 'MarkerFaceColor', colors(iAnim, :), 'MarkerEdgeColor', colors(iAnim, :));
    end;
end;
hold('off');
legend([plotHandles(1, 1 : numel(animalIDs)), plotHandles(2, 1 : numel(spotIDs))], [animalIDs, spotIDs], ...
    'Interpreter', 'none', 'Location', 'North', 'Orientation', 'Horizontal', 'FontSize', 17);
set(gca, 'XLim', [-0.9 52], 'YLim', [-0.9 69], 'FontSize', 22);
ylabel('Number of conserved ROIs');
xlabel('Days since training start');
title('Conserved ROI numbers', 'FontSize', 25);
figSavePath = sprintf('%sconservedROINumbers', mainSavePath);
saveas(hFig, figSavePath);
export_fig(figSavePath, '-png', '-r150', hFig);
close(hFig);

%% plot pooled data - ROI numbers turnover
hFig = figure('Name', 'Turnover of number of ROIs', 'NumberTitle', 'off', 'Position', [370, 185, 1270 900], ...
    'Color', 'white');
markers = { 's', 'o', '^', 'd', '<' };
colors = lines(numel(animalIDs));
plotHandles = nan(2, 200);
hold('on');
for iAnim = 1 : numel(animalIDs);
    for iSpot = 1 : numel(spotIDs);
        animSpotMask = strcmp(animalIDs{iAnim}, dataTable.shortAnimID) & strcmp(spotIDs{iSpot}, dataTable.spotID);
        daysForSpotAnim = dataTable.day(animSpotMask);
        
        ROINames = dataTable.ROISets(animSpotMask);
        nROISets = numel(ROINames);
        
        % intersect matrix
        intersects = nan(nROISets, nROISets);
        for iRef = 1 : nROISets;
            for iTarg = 1 : nROISets;
                intersects(iRef, iTarg) = numel(intersect(ROINames{iRef}, ROINames{iTarg})) - 1;
            end;
        end;
        
        intersects(1, :) = [];
        ROIsFromPreviousDay = diag(intersects);
        
        [~, b] = ismember(daysForSpotAnim, uniqueAllDates);
        dayIndexesForSpotAnim = uniqueDayIndices(b);
    %     offsetX = 0.1 * iAnim;
        offsetX = 0;
        plotHandles(1, iAnim) = plot(dayIndexesForSpotAnim(2 : end) + offsetX, ROIsFromPreviousDay, ...
            'LineWidth', 2, 'LineStyle', '--', 'Color', colors(iAnim, :));
        plotHandles(2, iSpot) = scatter(dayIndexesForSpotAnim(2 : end) + offsetX, ROIsFromPreviousDay, 120, ...
            'Marker', markers{iSpot}, 'MarkerFaceColor', colors(iAnim, :), 'MarkerEdgeColor', colors(iAnim, :));
    end;
end;
hold('off');
legend([plotHandles(1, 1 : numel(animalIDs)), plotHandles(2, 1 : numel(spotIDs))], [animalIDs, spotIDs], ...
    'Interpreter', 'none', 'Location', 'North', 'Orientation', 'Horizontal', 'FontSize', 17);
set(gca, 'XLim', [-0.9 52], 'YLim', [-0.9 69], 'FontSize', 22);
ylabel('Number of conserved ROIs from previous day');
xlabel('Days since training start');
title('Turnover of ROI numbers', 'FontSize', 25);
figSavePath = sprintf('%sturnoverROINumbers', mainSavePath);
saveas(hFig, figSavePath);
export_fig(figSavePath, '-png', '-r150', hFig);
% close(hFig);


end
