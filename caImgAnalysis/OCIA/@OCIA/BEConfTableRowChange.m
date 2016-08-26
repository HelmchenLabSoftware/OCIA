function BEConfTableRowChange(this, h, ~)
% BEConfTableRowChange - [no description]
%
%       BEConfTableRowChange(this, h, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

o('#BEConfTableRowChange()', 4, this.verb);

if ~isempty(this.be.configs.animals);

    jTable = getJTable(this, 'BEConfTable');
    if ishandle(h);
        selectedRow = jTable.getSelectedRows() + 1;
    elseif isnumeric(h);
        selectedRow = h;
        % select the rows
        jTable.clearSelection();
        jTable.addRowSelectionInterval(selectedRow - 1, selectedRow - 1);
    else
        showWarning(this, 'OCIA:Behavior:BEConfTableRowChange:InvalidRow', ...
            sprintf('Cannot define which row was selected (h: %s).', h));
    end;

    if this.be.configLoaded && ~isempty(selectedRow);
        if strcmp(this.be.animalID, this.be.configs.animals{selectedRow, 1}) ...
                && strcmp(this.be.taskType, this.be.configs.animals{selectedRow, 2}) ...
                && strcmp(this.be.phase, this.be.configs.animals{selectedRow, 3});
            set(this.GUI.handles.be.loadConf, 'BackgroundColor', 'green', 'Value', 1);
        else
            set(this.GUI.handles.be.loadConf, 'BackgroundColor', 'yellow', 'Value', 0);
        end;
    else
        set(this.GUI.handles.be.loadConf, 'BackgroundColor', 'red', 'Value', 0);
    end;
    this.GUI.be.selConfigRow = selectedRow;
else
    this.GUI.be.selConfigRow = [];
    set(this.GUI.handles.be.loadConf, 'BackgroundColor', 'red', 'Value', 0);
end;

o('#BEConfTableRowChange(): selected config row: %d (%s - %s - %s) ...', this.GUI.be.selConfigRow, ...
    this.be.configs.animals{this.GUI.be.selConfigRow, 1}, this.be.configs.animals{this.GUI.be.selConfigRow, 2}, ...
    this.be.configs.animals{this.GUI.be.selConfigRow, 3}, 2, this.verb);

end
