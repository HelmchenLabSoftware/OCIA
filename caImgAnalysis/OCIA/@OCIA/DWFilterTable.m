function [filtTable, filtTableIndexes] = DWFilterTable(this, filtText, tableToUse, tIDs)
% DWFilterTable - Filter the DataWatcher table and return the rows (and row indexes)
%
%       [filtTable, filtTableIndexes] = DWFilterTable(this, filtText)
%       [filtTable, filtTableIndexes] = DWFilterTable(this, filtText, tableToUse)
%
% Filters the rows of the 'tableToUse' (or the DataWatcher's table if none provided) based on the column names 
%   using the filternig string 'filtText'. The filtering string can be anything like: 'rowType = notebook' or 
%   'rowType ~= imgData' for regexp match or 'spot != spot01' for *not* matching or
%   'spot = spot01 AND day = 2014_02_08' or 'rowType = imgData OR animal = mouse1', etc.
%   Sub-column names are also possible like 'data.rawImg.loadStatus = full' to get all the rows where the
%   data is fully loaded.

% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
    
    % if no table was provided, use the default table which is the DataWatcher's table
    if ~exist('tableToUse', 'var') || isempty(tableToUse);
        tableToUse = this.dw.table;
    end;
    % if no table IDs were provided, use the DataWatcher table's IDs
    if ~exist('tIDs', 'var') || isempty(tIDs);
        tIDs = this.dw.tableIDs;
    end;

    % separate the filter into parts at the join operators
    [filtParts, ~, ~, ~, ops] = regexp(filtText, '\s(OR|AND)\s', 'split');
    
    % holder for the filtered table indexes
    filtTableIndexes = [];
    
    % go through each filter pair
    for iPart = 1 : numel(filtParts);
    
        % match the filter string for: colName (column name), eq (equality), val (value)
        hit = regexp(filtParts{iPart}, '^(?<colName>[\w\.\*]+)\s+(?<eq>[!~]{0,2}\=)\s+(?<val>.+)$', 'names');
        
        % cannot match the pair, skip it with warning
        if isempty(hit);
            showWarning(this, 'OCIA:DW:DWFilterTable:BadRegexp', ...
                sprintf('Cannot processed regular expression part: %s. Skipping it.', filtParts{iPart}));
            continue;
        end;
        
        % get the equality function
        switch hit.eq;
            % basic string comparison
            case '='; eqfun = @strcmp;
            % basic string comparison with negation
            case '!='; eqfun = @(varargin)~strcmp(varargin{:});
            % regular expression comparison
            case '~='; eqfun = @(varargin)~isempty(regexp(varargin{1}, varargin{2}, 'once'));
            % regular expression comparison with negation
            case '!~='; eqfun = @(varargin)isempty(regexp(varargin{1}, varargin{2}, 'once'));
            % unknown comparison sign
            otherwise
                showWarning(this, 'OCIA:DW:DWFilterTable:UnkownVar', ...
                sprintf('Unknown comparison sign requested for filtering: %s', hit.eq));
            continue;
        end;
        
        % extract the value and the filtering column's name
        val = hit.val;
        colName = hit.colName;
        
        % if the column name does not contain a sub-column
        if isempty(regexp(colName, '^[\w\*]+\.[\w\*]+', 'once'));
            
            % if the requested filtering column is not part of the table's column list and is not the rowID
            if ~ismember(colName, tIDs) && ~strcmp(colName, 'rowID');
                % show a warning and skip
                showWarning(this, 'OCIA:DW:DWFilterTable:UnkownColName', ...
                    sprintf('Unknown column name requested for filtering: %s', colName));
                continue;
            end;

            % special case for the row IDs
            if strcmp(colName, 'rowID');
                values = DWGetRowID(this, 1 : size(tableToUse, 1), tableToUse, tIDs); 
                
            % otherwise get all the values from the table's column
            else
                values = get(this, 'all', colName, tableToUse, tIDs);            
            end;
            
            % make sure values are cell
            if ~iscell(values); values = { values }; end;
            
            % make sure no cell is empty
            values(cellfun(@isempty, values)) = { '' };
            
        % if the variable name has a sub-variable name (like "data.rawImg"), extract the values differently
        else
            values = getSubColumnValues(this, tIDs, tableToUse, colName);
        end;
        
        % check if all values are strings and abort with a warning if it is not the case
        isAllCell = all(cellfun(@ischar, values));        
        if ~isAllCell; 
            showWarning(this, 'OCIA:DW:DWFilterTable:NotCharCellFilter', 'Requested filtering on a non-string column. Aborting.');
            return;
        end;
        
        % remove the delete tag
        values = regexprep(values, ['^' this.GUI.dw.deleteTag], '');
        
        % get the rows where the requested values match (or not) the table's values
        tempTableIndexes = find(cellfun(@(valueTable) eqfun(valueTable, val), values));
        
        % if this is the first filter pair, use if as starting filtered table
        if iPart == 1;
            filtTableIndexes = tempTableIndexes;
            
        % if the previous filter was an 'AND' operator, only get the overlapping indexes
        elseif strcmp(ops{iPart - 1}, ' AND ');
            % only get the overlap of them
            filtTableIndexes(~ismember(filtTableIndexes, tempTableIndexes), :) = []; %#ok<AGROW>
            
        % if the previous filter was an 'OR' operator, get the unique concatenated indexes
        elseif strcmp(ops{iPart - 1}, ' OR ');
            % get the unique concatenated table
            filtTableIndexes = unique(vertcat(filtTableIndexes, tempTableIndexes), 'rows');
        end;
        
    end; % end of filter pairs looping
    
    % create the filtered table using the filtered indexes
    filtTable = tableToUse(filtTableIndexes, :);    

end

% extract the values of a non-character column
function newValues = getSubColumnValues(this, tIDs, tableToUse, colName)

% get the column name "parts"
colNameParts = regexp(colName, '\.', 'split');

% get the values for the column name
values = get(this, 'all', colNameParts{1}, tableToUse, tIDs);
% make sure values are cell
if ~iscell(values); values = { values }; end;
% make sure no empty cells exist by filling them with empty structures
values(cellfun(@isempty, values)) = { struct() };
% create a new values cell-array which will have the extract sub-column values
newValues = cell(numel(values), 1);

% go through each row of the table and asses whether the sub-column matches
for iRow = 1 : numel(values);
    
    % get a row validity tag
    isRowValid = true;
    % get the remaining column parts
    localColumnParts = colNameParts(2 : end);
    % get the current structure
    currentValue = values{iRow};
    
    % recursively get the right field from the current structure
    while ~isempty(localColumnParts);  
        
        % if the current value is still a structure and it has the right sub-field
        if isstruct(currentValue) && isfield(currentValue, localColumnParts{1});
            % get the "next" sub-structure and move forward in the list of the column parts
            currentValue = currentValue.(localColumnParts{1});
            localColumnParts(1) = [];
        
        % if the current value is still a structure with at least one field and a numbered field was required
        elseif isstruct(currentValue) && numel(fieldnames(currentValue)) ...
                && ~isempty(regexp(localColumnParts{1}, '^\s*\d+\s*$', 'once'));
            fNames = fieldnames(currentValue); % get the field names
            iField = str2double(localColumnParts{1}); % get the sub-field number
            % if the required number is not a number or exceeds the limit, abort
            if isnan(iField) || iField < 1 || iField > numel(fNames); 
                % mark this row as non-valid and abort
                isRowValid = false;
                break;   
            end;
            % otherwise get the "next" sub-structure by getting the right sub-field using the number given as input and
            %   move forward in the list of the column parts
            currentValue = currentValue.(fNames{iField});
            localColumnParts(1) = [];
        
        % if the current value is still a structure with at least one field and any field was required
        elseif isstruct(currentValue) && numel(fieldnames(currentValue)) && strcmp(localColumnParts{1}, '*');
            % get the "next" sub-structure and move forward in the list of the column parts 
            fNames = fieldnames(currentValue); % get the field names           
            currentValue = currentValue.(fNames{1});
            localColumnParts(1) = [];
            
        % if the current value is still a structure but it does *not* have the right sub-field, abort
        elseif isstruct(currentValue);
            % mark this row as non-valid and abort
            isRowValid = false;
            break;            
        end;
    end;
    
    % if the current row is already flagged as non-valid, do not continue
    if ~isRowValid;
        % fill the row with an empty string
        newValues{iRow} = '';
        continue;
    end;
    
    % store the extracted value
    newValues{iRow} = currentValue;
    
end;

end