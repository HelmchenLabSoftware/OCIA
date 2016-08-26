function DWTableClick(this, ~, ~)
% DWTableClick - [no description]
%
%       DWTableClick(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

    o('#DWTableClick()', 4, this.verb);
    
    % do nothing if there is no GUI
    if ~isGUI(this); return; end;

    % update the list of selected rows
    jTable = getJTable(this, 'DWTable');
    if ishandle(jTable);
        clickedRows = double(jTable.getSelectedRows() + 1);
        this.dw.selectedTableRows = clickedRows;
    else
        clickedRows = [];
        this.dw.selectedTableRows = [];
    end;

    % remove selected rows that are out of the range ot the DataWatcher's table
    this.dw.selectedTableRows(this.dw.selectedTableRows > size(this.dw.table, 1)) = [];
    % highlight the selected rows
    DWSelTableRows(this, this.dw.selectedTableRows);

    o('#DWTableClick(): clickedRows: %s, selected rows: %s ...', num2str(clickedRows'), ...
        num2str(this.dw.selectedTableRows'), 4, this.verb);
end
