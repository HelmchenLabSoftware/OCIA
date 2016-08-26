function OCIA_startFunction_multiAnimalAnalysisPipeline_behav(this)
% OCIA_startFunction_multiAnimalAnalysisPipeline_behav - [no description]
%
%       OCIA_startFunction_multiAnimalAnalysisPipeline_behav(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% load the list of all animals and spots
% OCIA_startFunction_loadAllAnimalsAndSpots(this);

%% extract pooled data
% get the paths
dataRootPath = this.path.localData;
mainSavePath = this.path.OCIASave;
dataTablePath = sprintf('%sbehavDataTable.mat', mainSavePath);

% if data table is not created/stored yet, create it
if ~exist(dataTablePath, 'file');

    % get the IDs
    animalIDs = this.dw.animalIDs(2 : end); % do not include the first element that is a '-'.

    % storage for all the data
    dataTable = cell2table(cell(numel(animalIDs), 1), 'VariableNames', { 'shortAnimID' });
    iRow = 1;

    % turn new variable warning off
    warning('off', 'MATLAB:table:RowsAddedNewVars');

    % loop over animals
    for iAnimal = 1 : numel(animalIDs);        
        shortAnimID = regexprep(animalIDs{iAnimal}, 'mou_bl_', '');
            
        %% load current animal
        % get the data path
        dataPath = sprintf('%s%s/ref/behav/%s__behavior__output.mat', dataRootPath, animalIDs{iAnimal}, shortAnimID);
        % if data does not exist, skip
        if ~exist(dataPath, 'file'); continue; end;

        % store variables in the data cell-array
        dataTable.shortAnimID{iRow} = shortAnimID;

        % load the file
        o('%s#: loading file %s ...', mfilename(), shortAnimID, 0, this.verb);
        matStruct = load(dataPath);
        
        % load the data from the structure
        behavVars = matStruct.savedDataStruct.be.behavVars.behavVars;
        rowIDs = matStruct.savedDataStruct.be.behavVars.rowIDs;
        colIDs = matStruct.savedDataStruct.be.behavVars.colIDs;
        counts = matStruct.savedDataStruct.be.behavCounts.counts;
        
        % get the masks
        dprimeMask = isnan(get(this, find(strcmp(rowIDs, 'dprime')), 'allDataRep', behavVars, colIDs));
        hitRateMask = isnan(get(this, find(strcmp(rowIDs, 'hitRate')), 'allDataRep', behavVars, colIDs));
        FARateMask = isnan(get(this, find(strcmp(rowIDs, 'FARate')), 'allDataRep', behavVars, colIDs));

        % mask the curves
        dprimesMasked = counts.DPRIMEs;
        dprimesMasked(dprimeMask) = NaN;
        hitRateMasked = counts.TGOs;
        hitRateMasked(hitRateMask) = NaN;
        FARateMasked = counts.NTGOs;
        FARateMasked(FARateMask) = NaN;
        
        % get grouping mask for dates
        dates = get(this, find(strcmp(rowIDs, 'date')), 'allDataRep', behavVars, colIDs);
        uniqueDates = unique(dates);
        grouping = cell2mat(arrayfun(@(i) find(strcmp(dates{i}, uniqueDates)), 1 : numel(dprimesMasked), ...
            'UniformOutput', false));
        
        % get the unique grouping indices and count them
        uniqueGroupingIndices = unique(grouping);
        nGroups = numel(uniqueGroupingIndices);

        % group by dates
        dprimesGrouped = cell2mat(arrayfun(@(i) nanmax(dprimesMasked(grouping == uniqueGroupingIndices(i))), ...
            1 : nGroups, 'UniformOutput', false));
        hitRateGrouped = cell2mat(arrayfun(@(i) nanmean(hitRateMasked(grouping == uniqueGroupingIndices(i))), ...
            1 : nGroups, 'UniformOutput', false));
        FARateGrouped = cell2mat(arrayfun(@(i) nanmean(FARateMasked(grouping == uniqueGroupingIndices(i))), ...
            1 : nGroups, 'UniformOutput', false));
            
        % store the data in table
%         dataTable.counts{iRow} = matStruct.savedDataStruct.be.behavCounts.counts;
%         dataTable.behavVars{iRow} = matStruct.savedDataStruct.be.behavVars.behavVars;
%         dataTable.rowIDs{iRow} = matStruct.savedDataStruct.be.behavVars.rowIDs;
%         dataTable.colIDs{iRow} = matStruct.savedDataStruct.be.behavVars.colIDs;
%         dataTable.dprimesMasked{iRow} = dprimesMasked;
%         dataTable.hitRateMasked{iRow} = hitRateMasked;
%         dataTable.FARateMasked{iRow} = FARateMasked;
        dataTable.dprimesGrouped{iRow} = dprimesGrouped;
        dataTable.hitRateGrouped{iRow} = hitRateGrouped;
        dataTable.FARateGrouped{iRow} = FARateGrouped;
        dataTable.uniqueDates{iRow} = uniqueDates;

        % update the row counter
        iRow = iRow + 1;
    end;

    % remove empty rows
    dataTable(cellfun(@isempty, dataTable.shortAnimID), :) = [];
%     % exclude animal 4
%     dataTable(cellfun(@(anID) strcmp(anID, '14100104'), dataTable.shortAnimID), :) = [];
    % save the table
    save(dataTablePath, 'dataTable');

% load the data table
else
    
    % load file
    matStruct = load(dataTablePath);
    dataTable = matStruct.dataTable;
    
end;

%% process pooled data
nAnim = size(dataTable, 1);

% get all unique dates
allDates = {};
for iAnim = 1 : nAnim;
    allDates = [allDates dataTable.uniqueDates{iAnim}]; %#ok<AGROW>
end;
uniqueAllDates = unique(allDates);
dateVecs = datevec(datestr(uniqueAllDates, 'yyyy_mm_dd'), 'yyyy_mm_dd');
uniqueDayIndices = arrayfun(@(iDate) 1 + etime(dateVecs(iDate, :), dateVecs(1, :)) / 3600 / 24, 1 : size(dateVecs, 1));
allDaysList = min(uniqueDayIndices) : max(uniqueDayIndices);
nDates = numel(allDaysList);

% create the pooled data matrices
dPrimes = nan(nAnim, nDates);
hitRates = nan(nAnim, nDates);
FARates = nan(nAnim, nDates);

% loop over each animal and assign the data points to the right date
for iAnim = 1 : nAnim;
    dateMask = ismember(uniqueAllDates, dataTable.uniqueDates{iAnim});
    dPrimes(iAnim, uniqueDayIndices(dateMask)) = dataTable.dprimesGrouped{iAnim};
    hitRates(iAnim, uniqueDayIndices(dateMask)) = dataTable.hitRateGrouped{iAnim};
    FARates(iAnim, uniqueDayIndices(dateMask)) = dataTable.FARateGrouped{iAnim};
end;

% mask mondays
mondayMask = cellfun(@(cont)strcmp(datestr(cont, 'ddd'), 'Mon'), uniqueAllDates);
dPrimes(:, uniqueDayIndices(mondayMask)) = NaN;
hitRates(:, uniqueDayIndices(mondayMask)) = NaN;
FARates(:, uniqueDayIndices(mondayMask)) = NaN;

%% plot pooled data - performance
hFig = figure('Name', 'd'' curves all animal', 'NumberTitle', 'off', 'Position', [370, 185, 1270 900], ...
    'Color', 'white');
markers = { 's', 'o', '^', 'd', '<' };
colors = lines(nAnim);
plotHandles = nan(1, nAnim);
hold('on');
for iAnim = 1 : nAnim;
%     offsetX = 0.1 * iAnim;
    offsetX = 0;
    plot(allDaysList + offsetX, dPrimes(iAnim, :), 'LineWidth', 2, 'LineStyle', '--', 'Color', colors(iAnim, :));
    plotHandles(iAnim) = scatter(allDaysList + offsetX, dPrimes(iAnim, :), 120, 'Marker', markers{iAnim}, ...
        'MarkerFaceColor', colors(iAnim, :), 'MarkerEdgeColor', colors(iAnim, :));
end;
line(allDaysList([1 end]), [0 0], 'LineStyle', ':', 'LineWidth', 2, 'Color', [0.5 0.5 0.5]);
line(allDaysList([1 end]), [1.96 1.96], 'LineStyle', ':', 'LineWidth', 2, 'Color', [0.5 0.5 0.5]);
hold('off');
legend(plotHandles, dataTable.shortAnimID(:), 'Interpreter', 'none', 'Location', 'North', ...
    'Orientation', 'Horizontal', 'FontSize', 17);
set(gca, 'XLim', [9.5 50], 'YLim', [-0.9 4.5], 'FontSize', 22);
ylabel('Performance ({\itd''})');
xlabel('Days since training start');
title('Performance ({\itd''})', 'FontSize', 25);
figSavePath = sprintf('%sbehav_dprimesPooled', mainSavePath);
saveas(hFig, figSavePath);
export_fig(figSavePath, '-png', '-r150', hFig);
close(hFig);

%% plot pooled data - hit rate
hFig = figure('Name', 'hit rate curves all animal', 'NumberTitle', 'off', 'Position', [370, 185, 1270 900], ...
    'Color', 'white');
markers = { 's', 'o', '^', 'd', '<' };
colors = lines(nAnim);
plotHandles = nan(1, nAnim);
hold('on');
for iAnim = 1 : nAnim;
%     offsetX = 0.1 * iAnim;
    offsetX = 0;
    plot(allDaysList + offsetX, hitRates(iAnim, :), 'LineWidth', 2, 'LineStyle', '--', 'Color', colors(iAnim, :));
    plotHandles(iAnim) = scatter(allDaysList + offsetX, hitRates(iAnim, :), 120, 'Marker', markers{iAnim}, ...
        'MarkerFaceColor', colors(iAnim, :), 'MarkerEdgeColor', colors(iAnim, :));
end;
hold('off');
legend(plotHandles, dataTable.shortAnimID(:), 'Interpreter', 'none', 'Location', 'North', ...
    'Orientation', 'Horizontal', 'FontSize', 17);
set(gca, 'XLim', [-1 50], 'YLim', [-1 109], 'FontSize', 22);
ylabel('Hit rate (%)');
xlabel('Days since training start');
title('Hit rate', 'FontSize', 25);
figSavePath = sprintf('%sbehav_hitRatePooled', mainSavePath);
saveas(hFig, figSavePath);
export_fig(figSavePath, '-png', '-r150', hFig);
close(hFig);

%% plot pooled data - false alarm rate
hFig = figure('Name', 'false alarm curves all animal', 'NumberTitle', 'off', 'Position', [370, 185, 1270 900], ...
    'Color', 'white');
markers = { 's', 'o', '^', 'd', '<' };
colors = lines(nAnim);
plotHandles = nan(1, nAnim);
hold('on');
for iAnim = 1 : nAnim;
%     offsetX = 0.1 * iAnim;
    offsetX = 0;
    plot(allDaysList + offsetX, FARates(iAnim, :), 'LineWidth', 2, 'LineStyle', '--', 'Color', colors(iAnim, :));
    plotHandles(iAnim) = scatter(allDaysList + offsetX, FARates(iAnim, :), 120, 'Marker', markers{iAnim}, ...
        'MarkerFaceColor', colors(iAnim, :), 'MarkerEdgeColor', colors(iAnim, :));
end;
hold('off');
legend(plotHandles, dataTable.shortAnimID(:), 'Interpreter', 'none', 'Location', 'North', ...
    'Orientation', 'Horizontal', 'FontSize', 17);
set(gca, 'XLim', [9.5 50], 'YLim', [-9 109], 'FontSize', 22);
ylabel('False alarm (%)');
xlabel('Days since training start');
title('False alarm', 'FontSize', 25);
figSavePath = sprintf('%sbehav_FARatePooled', mainSavePath);
saveas(hFig, figSavePath);
export_fig(figSavePath, '-png', '-r150', hFig);
close(hFig);


end
