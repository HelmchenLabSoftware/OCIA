function OCIA_analysis_storeStimVectorsFromWhiskTraces(this)

% get the selected rows
selectedRowIndexes = get(this.GUI.handles.an.rowList, 'Value');
% if no exactly one analysis type is selected
if isempty(selectedRowIndexes);
    % select the first row
    selectedRowIndexes = 1;
    % update the selected plot in the GUI
    set(this.GUI.handles.an.rowList, 'Value', selectedRowIndexes);
end;

% get the DataWatcher table's row indexes for the row selection
iDWRows = this.an.selectedTableRows(selectedRowIndexes);

% get the whisk stim vector
ANShowHideMessage(this, 1, 'Fetching whisker traces ...');
[~, whiskStimVect, ~] = OCIA_analysis_getWhiskTraces(this, iDWRows);

showMessage(this, 'Storing stim. vectors based on whisker traces ...', 'yellow');
% store the stimulus vectors in the data structure: loop through all rows
for iRow = 1 : size(whiskStimVect, 1);
    OCIA_genStimVect_fromInputArgument(this, this.an.selectedTableRows(iRow), { whiskStimVect(iRow, :) }, ...
        { 'whisk' }, { 1 });
end;
DWDisplayTable(this);

ANShowHideMessage(this, 0, 'Storing stim. vectors done.');


end