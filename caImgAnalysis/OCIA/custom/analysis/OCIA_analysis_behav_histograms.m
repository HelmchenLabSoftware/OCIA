function OCIA_analysis_behav_histograms(this, iDWRows)
% OCIA_analysis_behav_histograms - [no description]
%
%       OCIA_analysis_behav_histograms(this, iDWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% plotting parameter UI controls
paramConf = cell2table({ ...
... categ  id                   UIType  valueType       UISize   isLabAbove     label                   tooltip
    'be',  'histBinWidth',      'text', { 'numeric' },  [1 0],   false,         'Bin width',            'Binning width in trials for the behavior data in the histogram.';
    'be',  'nTrialsSkip',       'text', { 'array' },    [1 0],   false,         'Trials to skip',       'Number of trials to skip at start and ending of a session.';
    'be',  'nMinRespTrialSkip', 'text', { 'array' },    [1 0],   false,         'Min. resp. trials',    'Minimum number of responsive trials (first number) to have in a certain number of trials (second number) at the end of session.';
    'be',  'groupBehavVar',     'list', {{ 'default' }},[4 1],   true,          'Group var.',           'Select which behavior variable(s) to use for the grouping.';
    'be',  'behavVarToPlot',    'list', {{ 'default' }},[4 1],   true,          'Plot var.',            'Select which behavior variable(s) to plot.';
    'be',  'includeEO',         'dropdown', {{ 'true', 'false' }}, [0.75 0], true, 'Incl. E.O.',          'Whether to include or not the EarlyOn trials.';
}, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);
% append the new configuration to the table and update the row names using the ids
this.GUI.an.paramPanConfig = [this.GUI.an.paramPanConfig; paramConf];
this.GUI.an.paramPanConfig.Properties.RowNames = this.GUI.an.paramPanConfig.id;

% get the selected behavior variables to plot
behavVarToPlot = this.an.be.behavVarToPlot;
% make sure only one variable is used for plotting
if iscell(behavVarToPlot) && numel(behavVarToPlot) > 1;
    behavVarToPlot = behavVarToPlot{1};
    if isfield(this.GUI.handles.an.paramPanElems, 'behavVarToPlot');
        set(this.GUI.handles.an.paramPanElems.behavVarToPlot, 'Value', ...
            strcmp(get(this.GUI.handles.an.paramPanElems.behavVarToPlot, 'String'), behavVarsToPlot));
    end;
end;
if isempty(behavVarToPlot);
    showWarning(this, 'OCIA:OCIA_analysis_behav_histograms:NoBehavVarSelected', 'No behavior variable selected to plot!');
    ANShowHideMessage(this, 1, 'No behavior variable selected to plot!');
    return;
end;
nVarsToPlot = numel(behavVarToPlot);

% get the selected behavior variables for grouping
behavVarForGrouping = this.an.be.groupBehavVar;
% make sure only one variable is used for grouping
if iscell(behavVarForGrouping) && numel(behavVarForGrouping) > 1;
    behavVarForGrouping = behavVarForGrouping{1};
    set(this.GUI.handles.an.paramPanElems.groupBehavVar, 'Value', ...
        strcmp(get(this.GUI.handles.an.paramPanElems.groupBehavVar, 'String'), behavVarForGrouping));
end;

%% get the "raw" data structure from the rows
% get the behavior data: get the rows that have behavior data
selectedLoadedBehavRows = DWFilterTable(this, 'data.behav.loadStatus = full', this.dw.table(iDWRows, :));
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
    showWarning(this, 'OCIA:OCIA_analysis_behav_histograms:NoBehavData', 'No behavior data to plot in selected rows!');
    ANShowHideMessage(this, 1, 'No behavior data to plot in selected rows!');
    return;
end;

%% get the behavior variable cell-array
ANShowHideMessage(this, 1, 'Loading data ...');
% create a structure which is unique for the selected rows and the critical parameters
hashParamStruct = struct();
hashParamStruct.rows = iDWRows;
hashParamStruct.miceInfoFilePath = this.an.be.miceInfoFilePath;
hashParamStruct.nTrialsSkip = this.an.be.nTrialsSkip;
hashParamStruct.nMinRespTrialSkip = this.an.be.nMinRespTrialSkip;

% get the "hash" ID of the parameter structure
selectedRowsHashID = matlab.lang.makeValidName(DataHash(hashParamStruct));
% store this key as being the last one used
this.an.be.dataHash.lastHashID = selectedRowsHashID;

% if the data is already in memory, just fetch it
if isfield(this.an.be.dataHash, selectedRowsHashID);
    
    % fetch the variables
    behavVars = this.an.be.dataHash.(selectedRowsHashID).behavVars;
    rowIDs = this.an.be.dataHash.(selectedRowsHashID).rowIDs;
    colIDs = this.an.be.dataHash.(selectedRowsHashID).colIDs;
    
% if data needs to be extracted, extract the behavior variables from the behavior structures
else
    % extract the behavior variables
    [behavVars, rowIDs, colIDs] = OCIA_analysis_behav_getBehavVars(this, allBehavStructs, selectedLoadedBehavRows, ...
        this.an.be.includeEO);

    % store the variables
    this.an.be.dataHash.(selectedRowsHashID).behavVars = behavVars;
    this.an.be.dataHash.(selectedRowsHashID).rowIDs = rowIDs;
    this.an.be.dataHash.(selectedRowsHashID).colIDs = colIDs;    
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
end;
% set into the parameters (excluding the last empty one)
this.GUI.an.paramPanConfig{'behavVarToPlot', 'valueType'} = { allLabels };
this.GUI.an.paramPanConfig{'groupBehavVar', 'valueType'} = { allLabels };

% check if selected var was not default
if numel(this.an.be.behavVarToPlot) == 1 && strcmp(this.an.be.behavVarToPlot, 'default');
    this.an.be.behavVarToPlot = allLabels{1};
    behavVarToPlot = allLabels{1};
    if isfield(this.GUI.handles.an.paramPanElems, 'behavVarToPlot');
        set(this.GUI.handles.an.paramPanElems.behavVarToPlot, 'Value', 1);
    end;
end;

% get the total number of trials
nTotTrials = sum(get(this, find(strcmp(rowIDs, 'nTrials')), 'allData', behavVars, colIDs));

% if no trials found, abort with a warning
if nTotTrials == 0;
    showWarning(this, 'OCIA:OCIA_analysis_behav_histograms:NoTrials', 'No trials found in the selected rows!');
    ANShowHideMessage(this, 1, 'No trials found in the selected rows!');
    return;
end;

%% get the data to plot and group it
behavVarID = rowIDs(strcmp(get(this, 'all', 'label', behavVars, colIDs), behavVarToPlot));
% get the data with repetition (one value per trial)
data = get(this, find(strcmp(rowIDs, behavVarID)), 'allDataRep', behavVars, colIDs);
% if there is a grouping variable
if ~isempty(behavVarForGrouping);
    groupBehavVarID = rowIDs(strcmp(get(this, 'all', 'label', behavVars, colIDs), behavVarForGrouping));
    groupingData = get(this, find(strcmp(rowIDs, groupBehavVarID)), 'allDataRep', behavVars, colIDs);    
        
    % if grouping variable is a cell array of strings, use "strcmp" as equality function
    if iscell(groupingData);
        groupingFunc = @strcmp;
        
    % if grouping variable is a cell array of strings, use "eq" as equality function
    elseif isnumeric(groupingData);
        % remove the nan grouping data
        groupingData(isnan(groupingData)) = [];
        groupingFunc = @eq;
    
    % unknown grouping type     
    else
        msg = sprintf('Cannot handle grouping data of type "%s". Aborting.', class(groupingData));
        showWarning(this, 'OCIA:OCIA_analysis_behav_histograms:BadGroupingDataType', msg);
        ANShowHideMessage(this, 1, msg);
        return;  
    end;
    
    % get the unique grouping data cells
    uniqueGrouping = unique(groupingData);
    % create the grouping variable
    groupingIndex = cell2mat(arrayfun(@(i) find(groupingFunc(groupingData(i), uniqueGrouping)), ...
        1 : numel(groupingData), 'UniformOutput', false)); 
    % create a storage for the grouped data
    groupedData = repmat(data', 1, numel(uniqueGrouping));
    % replace each point that does not belong to a particular group by NaN
    for iGroup = 1 : numel(uniqueGrouping);
        groupedData(groupingIndex ~= iGroup, iGroup) = NaN;
    end; 

% otherwise do not group the data
else
    groupedData = data;
end;

%% plotting
ANShowHideMessage(this, 1, 'Plotting ...');
binWidth = this.an.be.histBinWidth;
if ischar(binWidth) && strcmp(binWidth, 'sqrt');
    binWidth = sqrt(numel(size(groupedData, 1)));
end;
[histData, binX] = hist(groupedData, round(size(groupedData, 1) / binWidth));
plot(axeH, binX, histData, 'LineWidth', 3);

%{
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
%}

ANShowHideMessage(this, 0, 'Update analyser plot done.');
    
end
