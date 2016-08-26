function OCIA_dataWatcherProcess_analyseRows(this, ~, ~)
% OCIA_dataWatcherProcess_analyseRows - [no description]
%
%       OCIA_dataWatcherProcess_analyseRows(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% store the selected rows so that even changing the selection in the DataWatcher mode does not affect the Analyser
this.an.selectedTableRows = this.dw.selectedTableRows;

% get the rows to process
toProcessRows = this.an.selectedTableRows;
nTotRows = numel(toProcessRows); % get the number of rows

% if no row selected, abort with a warning
if nTotRows == 0;
    showWarning(this, 'OCIA:OCIA_dataWatcherProcess_analyseRows:NoRows', 'No rows selected.');
    return;
end;

%% process rows
% call the processing function first
OCIA_dataWatcherProcess_processRows(this);

%% prepare analyser panel
% generate labels for the selected rows
rowLabels = cell(nTotRows, 1);
for iRow = 1 : nTotRows;
    iDWRow = this.an.selectedTableRows(iRow); % get the DataWatcher's table row index
    rowLabels{iRow} = ''; % empty label is default
    % create the display using the column names specified in the config
    colNames = this.GUI.an.DWTableColumnsToUse;
    for iCol = 1 : numel(colNames);
        rowLabels{iRow} = sprintf('%s - %s', rowLabels{iRow}, get(this, iDWRow, colNames{iCol}));
    end;
    % alter the row labels using the regular expression
    regExpPatterns = this.GUI.an.DWTableColumnsRegexp;
    for iRegexp = 1 : size(regExpPatterns, 1);
        rowLabels{iRow} = regexprep(rowLabels{iRow}, regExpPatterns{iRegexp, 1}, regExpPatterns{iRegexp, 2}); 
    end;
    % clean up the label
    rowLabels{iRow} = regexprep(rowLabels{iRow}, '^\s+-\s+', '');
    rowLabels{iRow} = regexprep(rowLabels{iRow}, '-\s+-', '-');
    rowLabels{iRow} = regexprep(rowLabels{iRow}, '- $', '');
end;
% fill in the listBox items of the analyser panel
set(this.GUI.handles.an.plotList, 'Value', 1, 'ListBoxTop', 1);
set(this.GUI.handles.an.rowList, 'String', rowLabels, 'Value', 1, 'ListBoxTop', 1);

% clear the plot area and show the loading message
ANClearPlot(this);
ANShowHideMessage(this, 1);
OCIAChangeMode(this, 'Analyser');

%% plot / run analysis
plotDataTic = tic; % for performance timing purposes
% select a default first plot to display depending on the data type
switch DWGetRowTypeID(this, this.an.selectedTableRows(1));
    case 'imgData';
        currAnalysis = find(strcmp(this.an.analysisTypes.id, 'caTraces_basic'));
    case 'behavData';
        currAnalysis = find(strcmp(this.an.analysisTypes.id, 'behav_timeseries'));
    case 'wfTr';
        currAnalysis = find(strcmp(this.an.analysisTypes.id, 'widefield_mappingMultiFreqTrialMaps'));
    otherwise;
        currAnalysis = 1;
end;

% select the first row and the default plot
set(this.GUI.handles.an.plotList, 'Value', currAnalysis);

% do the analysis / plot
ANUpdatePlot(this, 'force');

o('#OCIA_dataWatcherProcess_analyseRows(): plotting done (%3.1f sec).', toc(plotDataTic), 2, this.verb);

end
