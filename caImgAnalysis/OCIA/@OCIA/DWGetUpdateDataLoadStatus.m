function loadStatusText = DWGetUpdateDataLoadStatus(this, iDWRow, doUpdate)
% DWGetUpdateDataLoadStatus - Returns/updates the 'data' column with the loading status in a row of the DataWatcher's table
%
%       loadStatusText = DWGetUpdateDataLoadStatus(this, iDWRow)
%       loadStatusText = DWGetUpdateDataLoadStatus(this, iDWRow, doUpdate)
%
% Returns the loading status 'loadStatusText' of the data of the row 'iDWRow' from the DataWatcher table. If the
%   logical 'doUpdate' is provided and is true, the loading status is also updated in the table and not only returned
%   by the function. This update is done via the Java handle of the table and only updates the specified row's data
%   column.

% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the data structure for this row
dataStruct = get(this, iDWRow, 'data');

% if no data, set status to empty
if isempty(dataStruct);
    loadStatusText = '';
   
% if some data was found, use to display the load status
else
    % use html for coloring
    loadStatusText = '<html>';
    
    % get the fields of this row's data
    fieldNames = fieldnames(dataStruct);
    % go through each field
    for iField = 1 : numel(fieldNames);
        % get the current field name
        fieldName = fieldNames{iField};
        % get the load status for this field
        loadStatus = dataStruct.(fieldName).loadStatus;
        % get the label for this field
        label = this.main.dataConfig.shortLabel{strcmp(this.main.dataConfig.id, fieldName)};
        % if no label, do not display anything
        if isempty(label); continue; end;
        % default color is blue
        labelColor = 'blue';
        % color the label differently depending on the status
        switch loadStatus;
            case 'full';    labelColor = 'green';
            case 'partial'; labelColor = 'orange';
            case '';        labelColor = 'gray';
        end;
        % if the current field is the processed image and the processing state information is available
        if strcmp(fieldName, 'procImg') && isfield(dataStruct.procImg, 'procState');
            % get the current processing state for this row
            procState = dataStruct.procImg.procState;
            % get the required processing steps to be labeled as full
            procStepsToBeFull = this.an.procOptions.id(this.an.procOptions.isProcStep);
            % if all steps are present, label as full
            if isempty(setdiff(procStepsToBeFull, procState));
                labelColor = 'green';
            end;
        end;
        % create the load status's text with a separation bar
        loadStatusText = sprintf('%s<font color="%s">%s</font> <b><font color="black">|</font></b> ', ...
            loadStatusText, labelColor, label);
    end;
    % remove the last separation bar
    loadStatusText = [regexprep(loadStatusText, ' <b><font color="black">\|</font></b> $', ''), '</html>'];    
end;

% if there is a GUI
if isGUI(this);
    % get the jTable
    jTable = getJTable(this, 'DWTable');    
    % if there is a jTable and the table needs to be updated, do it
    if ~isempty(jTable) && ~exist('doUpdate', 'var') || doUpdate;
        iJTCol = find(strcmp('data', this.dw.tableIDs)); % get this columns index in the table
        iJTCol = iJTCol - sum(~this.GUI.dw.tableDisplay.visible(1 : iJTCol)); % compensate for hidden columns
        % this is horrible but nobody wants to deal with Java erros in Matlab
        try jTable.setValueAt(loadStatusText, iDWRow - 1, iJTCol - 1);
        catch; end;
    end;
end;
    
end
