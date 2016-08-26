function rowTypeID = DWGetRowTypeID(this, iRow, tableToUse)
% DWGetRowTypeID - [no description]
%
%       rowTypeID = DWGetRowTypeID(this, iRow, tableToUse)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% if no table was provided, use the default table which is the DataWatcher's table
if ~exist('tableToUse', 'var') || isempty(tableToUse);
    tableToUse = this.dw.table;
end;
% if the row ID of more than one row is required, use a loop to retrieve them all
if numel(iRow) > 1;
    % get all the row IDs as a cell array
    rowTypeID = arrayfun(@(iLocalRow)DWGetRowTypeID(this, iLocalRow, tableToUse), iRow, 'UniformOutput', false)';
    return;
end;

% extract the row's type
rowType = get(this, iRow, 'rowType');
rowTypeID = '';

% if a row type was found
if ~isempty(rowType);
    
    % go through all watch types
    for iWatchType = 1 : size(this.dw.watchTypes);
        % get the sub-file pattern table
        subFilePatternTable = this.dw.watchTypes.subFilePatterns{iWatchType};
        % if some sub-file, try to match the watch type's sub-files' labels
        if ~isempty(subFilePatternTable) && ismember(rowType, subFilePatternTable.label);
            rowTypeID = subFilePatternTable.id{strcmp(rowType, subFilePatternTable.label)}; 
            break;
        end;
    end;

    % if no rowType ID found in the sub-files and there is a match in the watch type's label, use that id
    if isempty(rowTypeID) && ismember(rowType, this.dw.watchTypes.label);
        rowTypeID = this.dw.watchTypes.id{strcmp(rowType, this.dw.watchTypes.label)}; 
    end;
    
end;

% if no match has been found, show warning an abort loading
if isempty(rowTypeID);
    showWarning(this, 'OCIA:DW:DWLoadRow:UnknownRowType', ...
        sprintf('Cannot find a row type ID for "%s" (row %03d). Aborting loading.', rowType, iRow));
    return;
end;

end
