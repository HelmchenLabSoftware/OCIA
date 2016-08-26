function OCIA_analysis_behav_timeseries(this, iDWRows)
% OCIA_analysis_behav_timeseries - [no description]
%
%       OCIA_analysis_behav_timeseries(this, iDWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)


%% plotting parameter UI controls
paramConf = cell2table({ ...
... categ  id                   UIType  valueType       UISize   isLabAbove     label                   tooltip
    'be',  'binWidth',          'text', { 'numeric' },  [1 0],   false,         'Bin width',            'Binning width in trials for the behavior data in the histogram.';
    'be',  'nTrialsSkip',       'text', { 'array' },    [1 0],   false,         'Trials to skip',       'Number of trials to skip at start and ending of a session.';
    'be',  'nMinRespTrialSkip', 'text', { 'array' },    [1 0],   false,         'Min. resp. trials',    'Minimum number of responsive trials (first number) to have in a certain number of trials (second number) at the end of session.';
    'be',  'plotLims',          'text', { 'array' },    [1 0],   false,         'Plot limits',          'Plot limits for each variable as a 2 x nVar array.';
    'be',  'behavVarToPlot',    'list', { },            [4 1],   true,          'Plot var.',            'Select which behavior variable(s) to plot.';
    'be',  'includeEO',         'dropdown', { 'true', 'false' }, [0.75 0], true, 'Incl. E.O.',          'Whether to include or not the EarlyOn trials.';
}, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);
% append the new configuration to the table and update the row names using the ids
this.GUI.an.paramPanConfig = [this.GUI.an.paramPanConfig; paramConf];
this.GUI.an.paramPanConfig.Properties.RowNames = this.GUI.an.paramPanConfig.id;

% get the selected behavior variables to plot
if isempty(this.an.be.behavVarToPlot);
    this.an.be.behavVarToPlot = { 'behav. file num.' };
end;
behavVarsToPlot = this.an.be.behavVarToPlot;
nVarsToPlot = numel(behavVarsToPlot);

%% load data
for iRow = 1 : numel(iDWRows);
    DWLoadRow(this, iDWRows(iRow), 'partial');
end;

%% get the "raw" data structure from the rows
% get the behavior data: get the rows that have behavior data
selectedLoadedBehavRows = DWFilterTable(this, 'rowType = Behavior data', this.dw.table(iDWRows, :));
if isempty(selectedLoadedBehavRows);
    showWarning(this, 'OCIA:OCIA_analysis_behav_timeseries:NoBehavDataLoaded', 'No behavior data loaded in selected rows!');
    ANShowHideMessage(this, 1, 'No behavior data loaded in selected rows!');
    return;
end;
% get the DataWatcher table indexes for these rows
selectedLoadedBehavRowsIndexes = str2double(get(this, 'all', 'rowNum', selectedLoadedBehavRows));
% get the data for these rows
allBehavStructs = getData(this, selectedLoadedBehavRowsIndexes, 'behav', 'data');
% make sure data is cell
if ~iscell(allBehavStructs); allBehavStructs = { allBehavStructs }; end;
nBehavStructs = numel(allBehavStructs); % count the number of strutures

% get the axe handle where all the plotting elements should be displayed
axeH = this.GUI.handles.an.axe;

% if no behavior data, abort with a warning
if isempty(allBehavStructs);
    showWarning(this, 'OCIA:OCIA_analysis_behav_timeseries:NoBehavData', 'No behavior data to plot in selected rows!');
    ANShowHideMessage(this, 1, 'No behavior data to plot in selected rows!');
    return;
end;

%% get the behavior variable cell-array
ANShowHideMessage(this, 1, 'Loading data ...');
% create a structure which is unique for the selected rows and the critical parameters
hashParamStruct = struct('rows', iDWRows, 'miceInfoFilePath', this.an.be.miceInfoFilePath, ...
    'nTrialsSkip', this.an.be.nTrialsSkip, 'nMinRespTrialSkip', this.an.be.nMinRespTrialSkip, ...
    'includeEO', this.an.be.includeEO, 'dataType', 'behavVars');
% get the data in memory
cachedData = ANGetCachedData(this, 'be', hashParamStruct);

% if data was in memory
if ~isempty(cachedData);    
    % fetch the variables
    behavVars = cachedData.behavVars;
    rowIDs = cachedData.rowIDs;
    colIDs = cachedData.colIDs;
    
% if data is not in memory, extract the behavior variables from the behavior structures
else
    % extract the behavior variables
    [behavVars, rowIDs, colIDs] = OCIA_analysis_behav_getBehavVars(this, allBehavStructs, selectedLoadedBehavRows, ...
        this.an.be.includeEO);

    % store the variables
    cachedData = struct('behavVars', { behavVars }, 'rowIDs', { rowIDs }, 'colIDs', { colIDs }, 'dataType', 'behavVars');
    % store the data in memory
    ANStoreCachedData(this, 'be', hashParamStruct, cachedData);
end;

%% fill-in the labels for the plot parameter config
% count the number of variables
nVars = numel(rowIDs);
% get the labels and the grouping
behavVarLabels = get(this, 'all', 'label', behavVars, colIDs);
behavGroups = get(this, 'all', 'grouping', behavVars, colIDs);
% create the label list
allLabels = {};
for iVar = 1 : nVars;
    if ismember('trial',    behavGroups{iVar}); allLabels{end + 1} =  behavVarLabels{iVar}                ; end; %#ok<AGROW>
    if ismember('run',      behavGroups{iVar}); allLabels{end + 1} = [behavVarLabels{iVar}, ' - run'     ]; end; %#ok<AGROW>
    if ismember('session',  behavGroups{iVar}); allLabels{end + 1} = [behavVarLabels{iVar}, ' - session' ]; end; %#ok<AGROW>
    if ismember('date',     behavGroups{iVar}); allLabels{end + 1} = [behavVarLabels{iVar}, ' - date'    ]; end; %#ok<AGROW>
end;
% set into the parameters (excluding the last empty one)
this.GUI.an.paramPanConfig{'behavVarToPlot', 'valueType'} = { allLabels };

% check if selected var was not default
if numel(this.an.be.behavVarToPlot) == 1 && strcmp(this.an.be.behavVarToPlot, 'default');
    this.an.be.behavVarToPlot = allLabels{1};
    behavVarsToPlot = allLabels{1};
    set(this.GUI.handles.an.paramPanElems.behavVarToPlot, 'Value', 1);
end;

%% create or get the analysed data
ANShowHideMessage(this, 1, 'Analysing data ...');

% add to the cache structure some other critical parameters
hashParamStruct.binWidth = this.an.be.binWidth;
hashParamStruct.dataType = 'behavCounts';
% get the data in memory
cachedData = ANGetCachedData(this, 'be', hashParamStruct);

% if data was in memory
if ~isempty(cachedData);    
    % fetch the variables
    counts = cachedData.counts; 
    
% if data is not in memory, extract the behavior variables from the behavior structures
else
    % get all the response types
    allRespTypes = get(this, find(strcmp(rowIDs, 'respTypes')), 'allData', behavVars, colIDs);
    % analyse the responses to extract the response type counts
    counts = analyseBehavPerf(allRespTypes, [], this.an.be.binWidth, 1);
    % store the variables
    cachedData = struct('counts', counts, 'dataType', 'behavCounts');
    % store the data in memory
    ANStoreCachedData(this, 'be', hashParamStruct, cachedData);
end;

dprimeMask = isnan(get(this, find(strcmp(rowIDs, 'dprime')), 'allDataRep', behavVars, colIDs));
hitRateMask = isnan(get(this, find(strcmp(rowIDs, 'hitRate')), 'allDataRep', behavVars, colIDs));
FARateMask = isnan(get(this, find(strcmp(rowIDs, 'FARate')), 'allDataRep', behavVars, colIDs));
earliesMask = isnan(get(this, find(strcmp(rowIDs, 'earliers')), 'allDataRep', behavVars, colIDs));

dprimesMasked = counts.DPRIMEs; dprimesMasked(dprimeMask) = NaN;
hitRateMasked = counts.TGOs; hitRateMasked(hitRateMask) = NaN;
FARateMasked = counts.NTGOs; FARateMasked(FARateMask) = NaN;
earliesMasked = counts.INVALIDs; earliesMasked(earliesMask) = NaN;

% change the d' and the rates for the sliding window values
behavVars = set(this, find(strcmp(rowIDs, 'dprime')), 'allDataRep', dprimesMasked, behavVars, colIDs);
behavVars = set(this, find(strcmp(rowIDs, 'hitRate')), 'allDataRep', hitRateMasked, behavVars, colIDs);
behavVars = set(this, find(strcmp(rowIDs, 'FARate')), 'allDataRep', FARateMasked, behavVars, colIDs);
behavVars = set(this, find(strcmp(rowIDs, 'earlies')), 'allDataRep', earliesMasked, behavVars, colIDs);

% get the total number of trials
nTotTrials = sum(get(this, find(strcmp(rowIDs, 'nTrials')), 'allData', behavVars, colIDs));

% if no trials found, abort with a warning
if nTotTrials == 0;
    showWarning(this, 'OCIA:OCIA_analysis_behav_timeseries:NoTrials', 'No trials found in the selected rows!');
    ANShowHideMessage(this, 1, 'No trials found in the selected rows!');
    return;
end;

% show the reward string
nTotRewards = sum(get(this, find(strcmp(rowIDs, 'nRewards')), 'allData', behavVars, colIDs));
nTotRewardWater = sum(get(this, find(strcmp(rowIDs, 'rewardWater')), 'allData', behavVars, colIDs));
showMessage(this, sprintf('%02d selected row: %d/%d rewarded trials (%.3f ul water)', nBehavStructs, nTotRewards, ...
    nTotTrials, nTotRewardWater));

%% group the data
ANShowHideMessage(this, 1, 'Grouping data ...');
% storage for the grouped data
behavVarIDsToPlot = cell(nVarsToPlot, 1);
groupMethod = cell(nVarsToPlot, 1);
groupingType = cell(nVarsToPlot, 1);
groupedData = cell(nVarsToPlot, 1);
groupedError = cell(nVarsToPlot, 1);
groupedDataTrialPos = cell(nVarsToPlot, 3);
plotParams = cell(nVarsToPlot, 1);

% get the appropriate data for each behavior variable, depending on the grouping selected
for iVarToPlot = 1 : nVarsToPlot;
    % extract the different parts of the label
    hits = regexp(behavVarsToPlot{iVarToPlot}, '^(?<label>[^-]+[^-\s])( - )?(?<grouping>.+)?$', 'names');
    % get the grouping type
    groupingType{iVarToPlot} = hits.grouping;
    if ~any(strcmp(get(this, 'all', 'label', behavVars, colIDs), hits.label)); continue; end;
    % get the id of the current variable
    behavVarIDsToPlot{iVarToPlot} = rowIDs{strcmp(get(this, 'all', 'label', behavVars, colIDs), hits.label)};
    % get the plotting parameters
    plotParams{iVarToPlot} = get(this, find(strcmp(rowIDs, behavVarIDsToPlot{iVarToPlot})), 'plotParams', behavVars, colIDs);
    
    % get the data with repetition (one value per trial)
    data = get(this, find(strcmp(rowIDs, behavVarIDsToPlot{iVarToPlot})), 'allDataRep', behavVars, colIDs);
        
    % if there is no grouping
    if isempty(hits.grouping);
        % no grouping, each data point is unique
        grouping = 1 : numel(data);
        % fill in the grouping type
        groupingType{iVarToPlot} = 'trial';
        
    % if the grouping is "run"
    elseif strcmp(hits.grouping, 'run');
        % get the behavior file indexes as grouping
        grouping = get(this, find(strcmp(rowIDs, 'behavInd')), 'allDataRep', behavVars, colIDs);
        
    % if the grouping is "sessions"
    elseif strcmp(hits.grouping, 'session');
        % get the dates with the session
        dateSessions = get(this, find(strcmp(rowIDs, 'dateWithSession')), 'allDataRep', behavVars, colIDs);
        % get the unique IDs
        uniqueDateSessions = unique(dateSessions);
        % create a grouping vector with indices for each unique date-session combination
        grouping = cell2mat(arrayfun(@(i) find(strcmp(dateSessions{i}, uniqueDateSessions)), 1 : numel(data), 'UniformOutput', false));
        
    % if the grouping is "day"
    elseif strcmp(hits.grouping, 'date');
        % get the dates
        dates = get(this, find(strcmp(rowIDs, 'date')), 'allDataRep', behavVars, colIDs);
        % get the unique IDs
        uniqueDates = unique(dates);
        % create a grouping vector with indices for each unique date
        grouping = cell2mat(arrayfun(@(i) find(strcmp(dates{i}, uniqueDates)), 1 : numel(data), 'UniformOutput', false));
        
    % unknown grouping: abort with warning
    else
        msg = sprintf('Unknown grouping found for label "%s": "%s". Aborting.', hits.label, hits.grouping);
        showWarning(this, 'OCIA:OCIA_analysis_behav_timeseries:UnknownGrouping', msg);
        ANShowHideMessage(this, 1, msg);
        return;
    end;
    
    % get the unique grouping indices and count them
    uniqueGroupingIndices = unique(grouping);
    nGroups = numel(uniqueGroupingIndices);
    
    % get the grouping method as a function
    groupMethod{iVarToPlot} = get(this, find(strcmp(rowIDs, behavVarIDsToPlot{iVarToPlot})), 'groupMethod', behavVars, colIDs);
    % use mean as default
    if isempty(groupMethod{iVarToPlot}); groupMethod{iVarToPlot} = 'mean'; end;
    groupFunc = str2func(['nan' groupMethod{iVarToPlot}]);
    
    % group the data differently depending on the data type
    if isnumeric(data) && ~all(isnan(data));
        % fill in the grouped data
        groupedData{iVarToPlot} = cell2mat(arrayfun(@(i) groupFunc(data(grouping == uniqueGroupingIndices(i))), 1 : nGroups, 'UniformOutput', false));
%         groupedError{iVarToPlot} = cell2mat(arrayfun(@(i) nansem(data(grouping == uniqueGroupingIndices(i))), 1 : nGroups, 'UniformOutput', false));
        
    % if the data is cell-array of strings, use the first element of each group
    elseif iscell(data);
        % fill in the grouped data
        groupedData{iVarToPlot} = arrayfun(@(i) data{find(grouping == uniqueGroupingIndices(i), 1, 'first')}, 1 : nGroups, 'UniformOutput', false);
        
    end;
    
    % get the trial numbers positions for each grouped data point
    groupedDataTrialPos{iVarToPlot, 1} = cell2mat(arrayfun(@(i) find(grouping == uniqueGroupingIndices(i), 1, 'first'), 1 : nGroups, 'UniformOutput', false));
    groupedDataTrialPos{iVarToPlot, 2} = cell2mat(arrayfun(@(i) nanmean(find(grouping == uniqueGroupingIndices(i))), 1 : nGroups, 'UniformOutput', false));
    groupedDataTrialPos{iVarToPlot, 3} = cell2mat(arrayfun(@(i) find(grouping == uniqueGroupingIndices(i), 1, 'last'), 1 : nGroups, 'UniformOutput', false));
    
end;

%% plot the data
ANShowHideMessage(this, 1, 'Plotting ...');
hold(axeH, 'on');
nGridLines = 4 + 2;
for iGrid = 1 : nGridLines;
    plot(axeH, [1 nTotTrials], [1 1] .* ((iGrid - 1) / (nGridLines - 1)), 'k:', 'LineWidth', 0.5);
end;
% get the label offset
offsets = [nTotTrials * 0.01 + 1, 0.02];

% list of used colors and by which variable it was used
usedColors = zeros(0, 3);
usedByVarID = cell(0, 1);
% list of available colors randomized
availColors = lines(nVars);
% availColors = availColors(randperm(size(availColors, 1)), :);

% vars with line or scatter plot
varsWithLineOrScatterPlot = [];

% go through each variable to plot
plotLimitValues = cell(nVarsToPlot, nGridLines);
bottomPad = 0;
for iVarToPlot = 1 : nVarsToPlot;
    
    % get the data
    dataForVar = groupedData{iVarToPlot};
    trialPos = groupedDataTrialPos(iVarToPlot, :);
    % randomize trial positions
    trialPos = arrayfun(@(i)trialPos{i} + (rand - 0.5) * 0.01 * nTotTrials, 1 : numel(trialPos), 'UniformOutput', false);
    % get the grouping type and the plotting parameters
    groupType = groupingType{iVarToPlot};
    [plotType, ~, plotCol] = plotParams{iVarToPlot}{:};
    
    if isempty(dataForVar) || (numel(dataForVar) == 1 && dataForVar(1) == 0);
        continue;
    end;
    
    % make sur color is RGB
    if ~isempty(plotCol) && ischar(plotCol); plotCol = rgb(plotCol); end;    
    
    % if numeric or logical, plot as it is
    if (strcmp(plotType, 'scatter') || strcmp(plotType, 'line') || strcmp(plotType, 'scaline') ...
            || strcmp(plotType, 'linesca')) && isnumeric(dataForVar);
        
        % flag this variable as being plotted as a line or scatter plot
        varsWithLineOrScatterPlot(end + 1) = iVarToPlot; %#ok<AGROW>
        
        % check if the current color was already used    
        usedColorIndex = find(arrayfun(@(i) all(usedColors(i, :) == plotCol), 1 : size(usedColors, 1)));
        % if the color was already used and it is not by the same variable, use another one
        if ~isempty(usedColorIndex) && ~strcmp(usedByVarID{usedColorIndex(1)}, behavVarIDsToPlot{iVarToPlot});
            
            % if var already has an assigned color, use it
            if ismember(behavVarIDsToPlot{iVarToPlot}, usedByVarID);
                % get the color already used
                plotCol = usedColors(find(strcmp(behavVarIDsToPlot{iVarToPlot}, usedByVarID), 1, 'first'), :);
            % otherwise pick another color
            else
                % if color was already used, take another one
                plotCol = availColors(1, :);
                % remove it from the list of availble colors
                availColors(1, :) = [];
            end;

        % if the color was already used but by the same variable, keep it
        elseif ~isempty(usedColorIndex) && strcmp(usedByVarID{usedColorIndex(1)}, behavVarIDsToPlot{iVarToPlot});
            % nothing to do, color is not in the available list anymore

        % if color was never used, check if it is in the list of available colors
        else
            % get the index in the available colors list
            availColorsIndex = find(arrayfun(@(i) all(availColors(i, :) == plotCol), 1 : size(availColors, 1)));
            % if it is in there, remove it from the available colors
            if ~isempty(availColorsIndex);
                availColors(availColorsIndex, :) = [];
            end;

        end;
        % add color to the used colors
        usedColors(end + 1, :) = plotCol; %#ok<AGROW>
        usedByVarID{end + 1} = behavVarIDsToPlot{iVarToPlot}; %#ok<AGROW>
        
        % if no plot limits where provided
        if isempty(this.an.be.plotLims) || size(this.an.be.plotLims, 1) < numel(varsWithLineOrScatterPlot);

            % get automatic plot limits base on data
            minData = min(dataForVar);
            maxData = max(dataForVar);
            maxAbs = max(abs(minData), abs(maxData));
            powToRound = floor(log10(maxAbs));
            if isnan(powToRound) || isinf(powToRound); powToRound = 0; end;
            plotLims = [];
            plotLims(1) = roundn(minData - (10 ^ powToRound) * 0.5, powToRound);
            plotLims(2) = roundn(maxData + (10 ^ powToRound) * 0.5, powToRound);
            if minData == roundn(minData, powToRound); plotLims(1) = minData; end;
            if maxData == roundn(maxData, powToRound); plotLims(2) = maxData; end;
            if plotLims(1) == plotLims(2); plotLims = plotLims + [-1, 1] .* 10 ^ powToRound; end;
        
        % use the plot limits provided as arguments for the current variable
        else
            plotLims = this.an.be.plotLims(numel(varsWithLineOrScatterPlot), :);        
        end;
            
        % remove the data points that are outside of the limits
        dataForVar(dataForVar > plotLims(2) | dataForVar < plotLims(1)) = NaN;
        % scale the data to fit in axis
        dataForVar = linScale([plotLims(1), dataForVar, plotLims(2)]);
        dataForVar([1, end]) = [];
        % fill-in the plot limit labels: get the range of this plot
        plotLimRange = plotLims(2) - plotLims(1);
        % get the values
        plotLimValuesNumeric = plotLims(1) : plotLimRange / (nGridLines - 1) : plotLims(2);
        % get the format in which to display
        if      plotLimRange <= 1 && max(plotLims) <= 10;     numFormat = '%.2f,';
        elseif  plotLimRange <= 5 && max(plotLims) <= 10;     numFormat = '%.1f,';
        elseif  plotLimRange <= 5 && max(plotLims) > 1000;   numFormat = '%06.1f,';
        elseif  plotLimRange <= 5 && max(plotLims) > 100;    numFormat = '%05.1f,';
        elseif  plotLimRange <= 5 && max(plotLims) > 10;     numFormat = '%04.1f,';
        elseif  plotLimRange > 5 && max(plotLims) <= 10;     numFormat = '%.1f,';
        elseif  plotLimRange > 5 && max(plotLims) > 1000;   numFormat = '%04d,';
        elseif  plotLimRange > 5 && max(plotLims) > 100;    numFormat = '%03d,';
        elseif  plotLimRange > 5 && max(plotLims) > 10;     numFormat = '%02d,';
        else                                                numFormat = '%d,';
        end;
        % get the plot grid labels
        plotLimitValues(iVarToPlot, :) = regexp(regexprep(sprintf(numFormat, plotLimValuesNumeric), ',$', ''), ',', 'split');
        
        
        % trial grouping
        if strcmp(groupType, 'trial');
            % scatter plot
            if strcmp(plotType, 'scatter') || strcmp(plotType, 'scaline');
                hScat = scatter(axeH, trialPos{2}, dataForVar, 10, 'x');
                set(hScat, 'MarkerFaceColor', plotCol, 'MarkerEdgeColor', plotCol);
            % line plot
            elseif strcmp(plotType, 'line') || strcmp(plotType, 'linesca');
                plot(axeH, trialPos{2}, dataForVar, 'Color', plotCol, 'LineWidth', 3);
            end;
        
        % other groupings
        else
            if strcmp(plotType, 'line');
                plot(axeH, trialPos{2}, dataForVar, 'Color', plotCol, 'LineWidth', 2);
            else
                % choose the marker type
                scatterMarker = 'c';
                if strcmp(groupType, 'run'); scatterMarker = 'd'; end;
                if strcmp(groupType, 'session'); scatterMarker = 's'; end;   
                hScat = scatter(axeH, trialPos{2}, dataForVar, 80, scatterMarker, 'fill');
                set(hScat, 'MarkerFaceColor', plotCol, 'MarkerEdgeColor', plotCol); 
                % scatter and line plot: add the line
                if strcmp(plotType, 'scaline') || strcmp(plotType, 'linesca');        
                    if isempty(groupedError{iVarToPlot});
                        plot(axeH, trialPos{2}, dataForVar, 'Color', plotCol, 'LineWidth', 2);
                    else
                        hErr = errorbar(axeH, trialPos{2}, dataForVar, groupedError{iVarToPlot}, 'Color', plotCol, 'LineWidth', 2);
                        removeErrorBarEnds(hErr);
                    end;
                end;
            end;
        end; 
        
        
    % if boxes are requested to be plotted
    elseif strcmp(plotType, 'box');
        
        % init some basic parameters
        boxHeight = 0.1;
        b = 0.5;
        boxColors = [ 1 1 b; 1 b b; b 1 b; b b 1 ];
        
        % get the unique data
        uniqueData = unique(dataForVar);
        
        % create the rectangles by looping
        currentValue = dataForVar(1); boxStart = 1;
        for iData = 1 : numel(dataForVar);
            
            % if data is cell and a new type encountered, draw the rectangle
            if iscell(dataForVar) && (~strcmp(dataForVar{iData}, currentValue) || iData == numel(dataForVar));
                iUnique = mod(find(strcmp(dataForVar{iData - 1}, uniqueData)), 4) + 1;
                p = [boxStart, -bottomPad - 0.01 - boxHeight, iData - boxStart, boxHeight];
                label = dataForVar{iData - 1};            
%                 fontSize = min(max(0.3 * p(3) / numel(label), 5), 11);
                fontSize = 9;
                if iData - boxStart < 100; fontSize = 7; end;
                bdfcn = [];
                if fontSize == 7; bdfcn = @(h, e)disp(label); label = '..'; end;  
                rectangle('Position', p, 'FaceColor', boxColors(iUnique, :), 'EdgeColor', 'black', ...
                    'Parent', axeH, 'ButtonDownFcn', bdfcn);            
                text(p(1) + p(3) * 0.5, p(2) + 0.5 * p(4), label, 'Parent', axeH, 'Interpreter', 'none', ...
                    'HorizontalAlignment', 'center', 'FontSize', fontSize, 'ButtonDownFcn', bdfcn);
                boxStart = iData;
                % update the current value
                currentValue = dataForVar{iData};
                
            % if data is numeric
            elseif isnumeric(dataForVar) && ((dataForVar(iData) ~= currentValue && ~(isnan(dataForVar(iData)) ...
                    && isnan(currentValue))) || iData == numel(dataForVar));
                if ~isnan(dataForVar(iData - 1));
                    iUnique = mod(find(dataForVar(iData - 1) == uniqueData), 4) + 1;   
                    p = [boxStart, -bottomPad - 0.01 - boxHeight, iData - boxStart, boxHeight];     
                    label = num2str(dataForVar(iData - 1));
%                     fontSize = min(max(0.3 * p(3) / numel(label), 5), 11);
                    fontSize = 8;
                    if iData - boxStart < 100; fontSize = 7; end;
                    bdfcn = [];
                    if fontSize == 7; bdfcn = @(h, e)disp(label); label = '..'; end;
                    rectangle('Position', p, 'FaceColor', boxColors(iUnique, :), 'EdgeColor', 'black', ...
                        'Parent', axeH, 'ButtonDownFcn', bdfcn);
                    text(p(1) + p(3) * 0.45, p(2) + 0.5 * p(4), label, 'Parent', axeH, 'HorizontalAlignment', ...
                        'center', 'Interpreter', 'none', 'FontSize', fontSize, 'ButtonDownFcn', bdfcn);
                end;
                boxStart = iData;
                % update the current value
                currentValue = dataForVar(iData);
            end;
            
        end;
        
        text(-offsets(1) * 0.5, p(2) + 0.5 * p(4), behavVarsToPlot{iVarToPlot}, 'Parent', axeH, ...
            'HorizontalAlignment', 'right', 'Interpreter', 'none');
        % update the rectangle area's padding
        bottomPad = bottomPad + boxHeight;
        
    end; % end of plot type check
    
end;

% decide which variable label should go to the left (the rest goes to the right
leftLabel = 1 : floor(numel(varsWithLineOrScatterPlot) / 2);
% add the labels on the grid
for iGrid = 1 : nGridLines;
    textForGridLeft = '';
    textForGridRight = '';
    textForUnitLeft = '';
    textForUnitRight = '';
    iUsedVar = 1;
    for iVarToPlot = 1 : nVarsToPlot;
        if ~ismember(iVarToPlot, varsWithLineOrScatterPlot); continue; end;
        if ismember(iUsedVar, leftLabel);
            textForUnitLeft = sprintf('%s\\color[rgb]{%f %f %f}%s\\color{black} / ', textForUnitLeft, ...
                usedColors(iUsedVar, :), plotParams{iVarToPlot}{2});
            textForGridLeft = sprintf('%s\\color[rgb]{%f %f %f}%s\\color{black} / ', textForGridLeft, ...
                usedColors(iUsedVar, :), plotLimitValues{iVarToPlot, iGrid});
        else
            textForUnitRight = sprintf('%s\\color[rgb]{%f %f %f}%s\\color{black} / ', textForUnitRight, ...
                usedColors(iUsedVar, :), plotParams{iVarToPlot}{2});
            textForGridRight = sprintf('%s\\color[rgb]{%f %f %f}%s\\color{black} / ', textForGridRight, ...
                usedColors(iUsedVar, :), plotLimitValues{iVarToPlot, iGrid});
        end;
        iUsedVar = iUsedVar + 1;
    end;
    % clean up label
    textForUnitLeft = regexprep(textForUnitLeft, ' / $', '');
    textForUnitRight = regexprep(textForUnitRight, ' / $', '');
    textForGridLeft = regexprep(textForGridLeft, ' / $', '');
    textForGridRight = regexprep(textForGridRight, ' / $', '');
    % display the labels
    text(-offsets(1), (iGrid - 1) / (nGridLines - 1), textForGridLeft, 'HorizontalAlignment', 'right', ...
        'Parent', axeH);
    text(nTotTrials + offsets(1) * 0.5, (iGrid - 1) / (nGridLines - 1), textForGridRight, ...
        'HorizontalAlignment', 'left', 'Parent', axeH);
    
    % display the unit labels
    if iGrid == 1 && ~isempty(textForUnitLeft);
        text(-offsets(1) * 0.5, 1.1, ['[' textForUnitLeft ']'], 'HorizontalAlignment', 'right', 'Parent', axeH);
    end;
    if iGrid == 1 && ~isempty(textForUnitRight);
        text(nTotTrials, 1.1, ['[' textForUnitRight ']'], 'HorizontalAlignment', 'left', 'Parent', axeH);
    end;
end;

% make sure axe is displayed in the right limits
set(axeH, 'XLim', [1, nTotTrials * 1.1], 'YLim', [-0.05 - bottomPad, 1.05], 'YTick', []);
hold(axeH, 'off');

% create a title
titleText = sprintf('%d trials - Behavior variables:\n\\fontsize{%f}', nTotTrials, this.GUI.pos(4) / 80);
iUsedVar = 1;
for iVarToPlot = 1 : nVarsToPlot;
    if ~ismember(iVarToPlot, varsWithLineOrScatterPlot); continue; end;
    titleText = sprintf('%s\\color[rgb]{%f %f %f}%s\\color{black} / ', titleText, usedColors(iUsedVar, :), ...
        behavVarsToPlot{iVarToPlot});
    iUsedVar = iUsedVar + 1;
end;
titleText = regexprep(titleText, ' / $', '');
title(axeH, titleText, 'FontSize', this.GUI.pos(4) / 70);

% add the x label
xlabel(axeH, 'Trials', 'FontSize', this.GUI.pos(4) / 65);
set(axeH, 'FontSize', this.GUI.pos(4) / 65);

ANShowHideMessage(this, 0, 'Update analyser plot done.');
    
end
