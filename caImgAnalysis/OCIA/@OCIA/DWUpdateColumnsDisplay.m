function DWUpdateColumnsDisplay(this, iDWRows, columnsToUpdate, doEmptyFieldsWithDeleteTag)
% DWUpdateColumnsDisplay - Updates the specified column(s) of a row in the DataWatcher's table
%
%       DWUpdateColumnsDisplay(this, iDWRow, columnsToUpdate, emptyFieldsWithDeleteTag)
%
% Updates the specified columns of the row(s) 'iDWRows' from the DataWatcher table with
%   their current content (stored in this.dw.table). The column names should be provided in the 'columnsToUpdate'
%   cell-array of string. If the 'doEmptyFieldsWithDeleteTag' logical is set to true, the columns containing the
%   "delete tag" are cleared out (emptied) and their display is empty.

% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% no update if no GUI
if ~isGUI(this); return; end;

% make sure "columnsToUpdate" is a cell-array (unless its empty)
if ~isempty(columnsToUpdate) && ~iscell(columnsToUpdate); columnsToUpdate = { columnsToUpdate }; end;

% get the jTable
jTable = getJTable(this, 'DWTable');

% go through all rows
for iRow = 1 : numel(iDWRows);
    % get the current row
    iDWRow = iDWRows(iRow);
    
    % update each column with the table's content
    for iCol = 1 : numel(columnsToUpdate);
        colName = columnsToUpdate{iCol}; % get the column's name
        
        newValue = getR(this, iDWRow, colName); % get the value to place in the table
        
        % if value is a cell of a string, extract the string
        if iscell(newValue) && numel(newValue) == 1 && ischar(newValue{1});
            newValue = newValue{1};
        end;
        
        % if the value is empty or not a character, skip the update
        if isempty(newValue) || ~ischar(newValue); continue; end;
        
        % if fields with delete tag should be emptied, replace them with the empty cell string
        if doEmptyFieldsWithDeleteTag && ~isempty(regexp(newValue, ['^' this.GUI.dw.deleteTag], 'once'));
            newValue = this.GUI.dw.tableEmptyCellDisplayContent; 
        end;
        
        % remove the leading delete tag if present to hide it in the display
        newValue = regexprep(newValue, ['^' this.GUI.dw.deleteTag], '');
        % replace in the jTable
        iJTCol = find(strcmp(colName, this.dw.tableIDs)); % get this columns index in the table
        iJTCol = iJTCol - sum(~this.GUI.dw.tableDisplay.visible(1 : iJTCol)); % compensate for hidden columns
        jTable.setValueAt(newValue, iDWRow - 1, iJTCol - 1);
        
        % pause for update
        pause(0.00001);
    end;
end;
    
end
