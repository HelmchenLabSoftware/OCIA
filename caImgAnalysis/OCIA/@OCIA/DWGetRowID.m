function rowID = DWGetRowID(this, iRow, tableToUse, tIDs)
% DWGetRowID - [no description]
%
%       rowID = DWGetRowID(this, iRow, tableToUse, tIDs)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
    
% if no table was provided, use the default table which is the DataWatcher's table
if ~exist('tableToUse', 'var') || isempty(tableToUse);
    tableToUse = this.dw.table;
    % flag the function to use rowID caching
    useRowIDCache = true;
% if using an input table, do not cache row ID
else
    useRowIDCache = false;
end;

% if no table was provided, use the default table ID which is the DataWatcher's table's IDs
if ~exist('tIDs', 'var') || isempty(tIDs);
    % get the table IDs
    tIDs = this.dw.tableIDs;
end;

% select all rows
if ischar(iRow) && strcmp(iRow, 'all');
    iRow = 1 : size(tableToUse, 1);
end;

% if the row ID of more than one row is required, use a loop to retrieve them all
if numel(iRow) > 1;
    % get all the row IDs as a cell array
    rowID = arrayfun(@(iLocalRow)DWGetRowID(this, iLocalRow, tableToUse, tIDs), iRow, 'UniformOutput', false)';
    return;
end;

% get the 'rowID' field's index
rowIDIndex = strcmp(tIDs, 'rowID');

% if there is a rowID column and the row ID is already stored (cached), return it and abort
if any(rowIDIndex);
    rowID = tableToUse{iRow, rowIDIndex};
    if ~isempty(rowID); return; end;
end;

% get the content of the requested columns from the table
columnIDs = this.dw.rowIDColumns(:, 1);
columnValues = cell(numel(columnIDs), 1);

% replace the values of each column using the specified regular expression patterns: go throuch each column
for iColumn = 1 : numel(columnValues);
    [colID, sourcePattern, targetPattern] = this.dw.rowIDColumns{iColumn, :};
    % get the column's value
    columnValues{iColumn} = get(this, iRow, colID, tableToUse, tIDs);
    % make sure we do not keep a cell in the columnValues' values
    if iscell(columnValues{iColumn});
        columnValues{iColumn} = columnValues{iColumn}{1};
    end;
    % if column is not empty
    if ~isempty(columnValues{iColumn});
        % replace the delete on unload tag (if any)
        columnValues{iColumn} = regexprep(columnValues{iColumn}, ['^' this.GUI.dw.deleteTag], '');
    end;
    % if there is a value and there is a regular expression to replace something
    if ~isempty(columnValues{iColumn}) && ~isempty(sourcePattern);
        % replace the value using the source and target replace patterns
        columnValues{iColumn} = regexprep(columnValues{iColumn}, sourcePattern, targetPattern);
    end;
end;

% if no column is empty, return the unique row ID based on the pattern and columns from the configuration
if ~any(cellfun(@isempty, columnValues));
    rowID = sprintf(this.dw.rowIDPattern, columnValues{:});
    
% otherwise use an empty row
else
    rowID = '';
end;

% store the row ID if there is a field for it
if useRowIDCache && any(rowIDIndex);
    this.dw.table{iRow, rowIDIndex} = rowID;
end;

end
