function DWMakeTableUnique(this, varargin)
% DWMakeTableUnique - Makes the DataWatcher table unique (no duplicate rows)
%
%       DWMakeTableUnique(this)
%       DWMakeTableUnique(this, ignoreFields)
%
% Makes the DataWatcher's table unique based on the column names. An optional cell-array of string "ignoreFields" 
%   enables to make the uniqueness test without taking these fields into account.

% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
    
% create a string-only table: turn each column into a string
stringTable = this.dw.table;
% calculate the number of rows
nRows = size(stringTable, 1);
% replace empty columns with empty strings
stringTable(cellfun(@isempty, stringTable)) = { '' };
% turn the non-string cells into strings using a hash ID
warning('off', 'JSimon:DataHash:BadDataType'); % ignore handle warning
for iCell = 1 : numel(stringTable);
    if ischar(stringTable{iCell}); continue; end;
    stringTable{iCell} = matlab.lang.makeValidName(DataHash(stringTable{iCell}));
end;
warning('on', 'JSimon:DataHash:BadDataType'); % ignore handle warning
% only keep the unique rows, excluding the numbering column
if ~isempty(varargin) && iscellstr(varargin{1});
    stringTable = get(this, 'all', setdiff(this.GUI.dw.tableDisplay.id, [ 'rowNum', varargin{1} ], 'stable'), stringTable);
else
	stringTable = get(this, 'all', setdiff(this.GUI.dw.tableDisplay.id, 'rowNum', 'stable'), stringTable);
end;
% concatenate all the columns
stringTableSingleCol = arrayfun(@(iRow)sprintf('%s', stringTable{iRow, :}), 1 : nRows, 'UniformOutput', false)';
% remove empty rows
this.dw.table(cellfun(@isempty, stringTableSingleCol), :) = [];
stringTableSingleCol(cellfun(@isempty, stringTableSingleCol)) = [];

% only get the unique rows (with or without sorting)
if this.GUI.dw.sortTableOnDisplay;
    [~, uniqueRowIndexes] = unique(stringTableSingleCol); % automatic sorting (done by the "unique" function)
else
    [~, uniqueRowIndexes] = unique(stringTableSingleCol, 'stable'); % no sorting
end

% only keep the unique rows
this.dw.table = this.dw.table(uniqueRowIndexes, :);
% calculate the new number of rows
nRows = size(this.dw.table, 1);

%reset the row numbers
if nRows;
    set(this, 1 : nRows, 'rowNum', arrayfun(@(i)sprintf(' %03d', i), 1 : nRows, 'UniformOutput', false));
end;

end