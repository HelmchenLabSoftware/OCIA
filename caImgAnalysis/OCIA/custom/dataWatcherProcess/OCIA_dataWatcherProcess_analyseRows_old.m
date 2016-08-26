%% #OCIA_dataWatcherProcess_analyseRows
function OCIA_dataWatcherProcess_analyseRows_old(this, ~, ~)

analyseRowsTic = tic; % for performance timing purposes

% store the selected rows so that even changing the selection in the DataWatcher mode does not affect the Analyser
this.an.selectedTableRows = this.dw.selectedTableRows;

% if no row selected, abort with a warning
nRows = numel(this.an.selectedTableRows); % count the number of selected rows
if nRows == 0;
    showWarning(this, 'OCIA:OCIA_dataWatcherProcess_analyseRows:NoRows', 'No rows selected.');
    return;
end;

o('#OCIA_dataWatcherProcess_analyseRows(): selected rows (%d): %s', nRows, ...
    sprintf('%d ', this.an.selectedTableRows), 2, this.verb);
    
% empty/reset the table, the plot list and the ROI list
set(this.GUI.handles.an.rowList, 'String', [], 'Value', [], 'ListBoxTop', 1);
set(this.GUI.handles.an.ROIList, 'String', [], 'Value', [], 'ListBoxTop', 1);

%% - #OCIA_dataWatcherProcess_analyseRows : load/pre-process/analyse selected rows
loadDataTic = tic; % for performance timing purposes
OCIAGetCallCustomFile(this, 'preprocess', this.dw.preProcessFunctionName, 1, { this }, 1);
o('#OCIA_dataWatcherProcess_analyseRows(): pre-processing data done (%3.1f sec).', toc(loadDataTic), 2, this.verb);

%% - #OCIA_dataWatcherProcess_analyseRows : prepare analyser panel
% generate labels for the selected rows
rowLabels = cell(nRows, 1);
tIDs = this.dw.tableIDs; % get the table IDs
for iRow = 1 : nRows;
    iDWRow = this.an.selectedTableRows(iRow); % get the DataWatcher's table row index
    rowLabels{iRow} = ''; % empty label is default
    % create the display using the column names specified in the config
    colNames = this.GUI.an.DWTableColumnsToUse;
    for iCol = 1 : numel(colNames);
        % get the row ID using the dedicated function
        if strcmp(colNames{iCol}, 'rowID');
            rowLabels{iRow} = sprintf('%s - %s', rowLabels{iRow}, DWGetRowID(this, iDWRow));
        % otherwise just fetch the value from the DataWatcher's table
        else
            rowLabels{iRow} = sprintf('%s - %s', rowLabels{iRow}, ...
                this.dw.table{iDWRow, strcmp(tIDs, colNames{iCol})});
        end;
    end;
    rowLabels{iRow} = regexprep(rowLabels{iRow}, '^\s+-\s+', ''); % clean up the label
    rowLabels{iRow} = regexprep(rowLabels{iRow}, '-\s+-', '-'); % clean up the label
    rowLabels{iRow} = regexprep(rowLabels{iRow}, '- $', ''); % clean up the label
end;
% fill in the listBox items of the analyser panel
set(this.GUI.handles.an.rowList, 'String', rowLabels, 'Value', [], 'ListBoxTop', 1);
set(this.GUI.handles.an.plotList, 'Value', [], 'ListBoxTop', 1);

% clear the plot area and show the loading message
ANClearPlot(this);
ANShowHideMessage(this, 1);
OCIAChangeMode(this, 'Analyser');

% reset the lists
set(this.GUI.handles.an.plotList, 'Value', [], 'ListBoxTop', 1);
set(this.GUI.handles.an.rowList, 'Value', [], 'ListBoxTop', 1);
set(this.GUI.handles.an.ROIList, 'Value', [], 'ListBoxTop', 1);

%% - #OCIA_dataWatcherProcess_analyseRows : plot
plotDataTic = tic; % for performance timing purposes
currAnalysis = [];
% select a default first plot to display depending on the data type
switch this.dw.table{this.an.selectedTableRows(1), strcmp(tIDs, 'rowType')};
    case 'imgData';
        currAnalysis = find(strcmp(this.an.analysisTypes.id, 'caTraces_basic'));
    case 'behavData';
        currAnalysis = find(strcmp(this.an.analysisTypes.id, 'behav_dprime'));
end;

% select the first row and the default plot
set(this.GUI.handles.an.rowList, 'Value', 1);
set(this.GUI.handles.an.plotList, 'Value', currAnalysis);

% do the analysis / plot
ANUpdatePlot(this, 'force');

o('#OCIA_dataWatcherProcess_analyseRows(): plotting done (%3.1f sec).', toc(plotDataTic), 2, this.verb);
o('#OCIA_dataWatcherProcess_analyseRows(): analyse rows done (%3.1f sec).', toc(analyseRowsTic), 2, this.verb);

end
