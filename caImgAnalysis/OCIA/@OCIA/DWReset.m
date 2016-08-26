function DWReset(this, ~, ~)
% DWReset - [no description]
%
%       DWReset(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
    
    % get the selected data types from the GUI
    selectedDataTypes = this.main.dataConfig.id(get(this.GUI.handles.dw.SLROptDataList, 'Value'));
    
    % if none selected, delete all
    if isempty(selectedDataTypes);
        selectedDataTypes = 'all';
        
    % otherwise create a string list from sleection
    else
        selectedDataTypes = sprintf('%s,', selectedDataTypes{:});
    end;

    % flush requested data in requested rows
    DWFlushData(this, this.dw.selectedTableRows, true, selectedDataTypes);
    
end
