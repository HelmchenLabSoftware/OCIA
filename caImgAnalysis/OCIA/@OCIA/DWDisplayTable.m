function DWDisplayTable(this, showWarningIfTableIsEmpty)
% DWDisplayTable - Updates the display of the DataWatcher's table
%
%       DWDisplayTable(this)
%       DWDisplayTable(this, showWarningIfTableIsEmpty)
%
% Updates the display of the DataWatcher's table by displaying the current content of the table (this.dw.table). This
%   function re-updates the display of all cells. Single-cell update can be done via the DWUpdateColumnsDisplay function.
%   If 'showWarningIfTableIsEmpty' is not provided or is provided as input and is true, a warning will be displayed if
%   the table is empty. The table only displays common data types (numerics, strings, logicals). Other data types will
%   not be displayed as such.

% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

[nRowsInTable, nColsInTable] = size(this.dw.table);
% 32 is the minimum number of rows so that the scrollbar is displayed
displayTableContent = cell(max(32, nRowsInTable), nColsInTable);

% if there is a content to the table, display it
if nRowsInTable;
    
    % only set data if there is a GUI
    if isGUI(this);
        % make a copy of the table
        tableCopy = this.dw.table;
        % go through the "data" column and create a display for it, using the loading status of the data instead of
        %   showing the data itself
        for iRow = 1 : nRowsInTable;
            tableCopy = set(this, iRow, 'data', DWGetUpdateDataLoadStatus(this, iRow, false), tableCopy);
        end;    
        % copy the rows into the display table
        displayTableContent(1 : nRowsInTable, :) = tableCopy;
    end;
    
% if there is no content to the table and warning display is required, display warning
elseif ~exist('showWarningIfTableIsEmpty', 'var') || showWarningIfTableIsEmpty;
    showWarning(this, 'OCIA:DWDisplayTable:EmptyTable', 'Table is empty!');
    
end;

% only set data if there is a GUI
if isGUI(this);
    
    % fill the empty cells with the 'empty cell display content'
    emptyCells = find(cellfun(@isempty, displayTableContent(:)));
    displayTableContent(emptyCells) = repmat({this.GUI.dw.tableEmptyCellDisplayContent}, 1, numel(emptyCells));
        
    % clear the delete tag from each cell
    for i = 1 : size(displayTableContent, 1);
        for j = 1 : size(displayTableContent, 2);
            displayTableContent{i, j} = regexprep(displayTableContent{i, j}, ['^' this.GUI.dw.deleteTag], '');
        end;
    end;
    
    % get the table's content, re-order its columns and remove the non-visible ones
    order = 1 : numel(this.GUI.dw.tableDisplay.order);
    [~, tabOrderInd] = sort(this.GUI.dw.tableDisplay.order);
    order = order(tabOrderInd);
    displayTableContent = displayTableContent(:, order);
    displayTableContent(:, ~this.GUI.dw.tableDisplay.visible) = [];
    % fill the non-displayable cells with a generic string
    displayTableContent(~cellfun(@(cont) isnumeric(cont) || ischar(cont) || islogical(cont), ...
        displayTableContent(:))) = { '[...]' };
    set(this.GUI.handles.dw.table, 'Data', displayTableContent);
end;

% clear the row selection
this.dw.selectedTableRows = [];

end
