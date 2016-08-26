function DWFlushData(this, rowRange, updateGUI, varargin)
% DWFlushData - Flushes data from the DataWatcher's table
%
%       DWFlushData(this, 'all', updateGUI)
%       DWFlushData(this, rowRange, updateGUI)
%       DWFlushData(this, rowRange, updateGUI, dataType1, dataType2, ...)
%
% Flushes the data specified as arguments in the specified 'rowRange' from the DataWatcher's table. The 'rowRange'
%   should be a vector of row indices or the string "all" to flush all rows; the data types should be a list of string
%   arguments matching the IDs of the data configuration (this.main.dataConfig). The logical 'updateGUI' specifies
%   whether to update the GUI's display (using the Java table) or not.

% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

o('#%s()', mfilename(), 4, this.verb);

% get memory usage if windows
if ispc();
    [~, memUsage] = memory();
    usedMemPercentBefore = 100 * (1 - memUsage.PhysicalMemory.Available / memUsage.PhysicalMemory.Total);
    
% get memory usage if UNIX but not mac (linux)
elseif isunix() && ~ismac();
    [~, w] = unix('free | grep Mem');
    stats = str2double(regexp(w, '[0-9]*', 'match'));
    totAvailMemInGB = stats(1) / 1e6;
    freeAvailMemInGB = (stats(3) + stats(end)) / 1e6;
    usedMemPercentBefore = 100 * (1 - freeAvailMemInGB / totAvailMemInGB);
    
end;

toFlush = ''; % by default flush nothing

% if no arguments were provided, flush all data types
if nargin <= 3; toFlush = 'all';
% if arguments were provided, flush the data types requested
elseif nargin > 3;
    toFlush = cell2mat(varargin);
end;

% if string 'all' was provided, flush all rows
if ischar(rowRange) && strcmp(rowRange, 'all');
    rowRange = 1 : size(this.dw.table, 1);
end;
% make sure the range is not ouf of bounds
rowRange(rowRange < 1 | rowRange > size(this.dw.table, 1)) = [];

% get the data field names to delete
dataFields = this.main.dataConfig.id;

% go through each requested row
for iRowLoop = 1 : numel(rowRange);
    % get the row number
    iDWRow = rowRange(iRowLoop);

    % get an update flag
    toUpdateRow = false;

    % go through each requested fields
    for iField = 1 : numel(dataFields);
        % get the data field's name
        dataFieldName = dataFields{iField};
        % flush selected raw data if requested
        if ~isempty(regexpi(toFlush, sprintf('%s|all', dataFieldName), 'once')) ...
                && isfield(get(this, iDWRow, 'data'), dataFieldName);
            % flush the data and reset the loading status
            setData(this, iDWRow, dataFieldName, 'data', []);
            setData(this, iDWRow, dataFieldName, 'loadStatus', '');
            % if there is a processing state field, flush it as well
            if ~isempty(getData(this, iDWRow, dataFieldName, 'procState'));
                setData(this, iDWRow, dataFieldName, 'procState', '');
            end;
            toUpdateRow = true;
        end;            
    end;

    % if there was something deleted and updating is required, update the table's columns for the row
    if toUpdateRow && updateGUI && isGUI(this);
        % update all columns
        DWUpdateColumnsDisplay(this, iDWRow, this.dw.tableIDs(this.GUI.dw.tableDisplay.visible), true);
        % update the loading status
        DWGetUpdateDataLoadStatus(this, iDWRow);
    end;

end;

% get memory usage if windows
if ispc();
    [~, memUsage] = memory();
    usedMemPercentAfter = 100 * (1 - memUsage.PhysicalMemory.Available / memUsage.PhysicalMemory.Total);
    totAvailMemInGB = memUsage.PhysicalMemory.Total / (2^30);
    
% get memory usage if UNIX but not mac (linux)
elseif isunix() && ~ismac();
    [~, w] = unix('free | grep Mem');
    stats = str2double(regexp(w, '[0-9]*', 'match'));
    totAvailMemInGB = stats(1) / 1e6;
    freeAvailMemInGB = (stats(3) + stats(end)) / 1e6;
    usedMemPercentAfter = 100 * (1 - freeAvailMemInGB / totAvailMemInGB);
    
% otherwise just create variables
else
    usedMemPercentBefore = -1;
    usedMemPercentAfter = -1;
    totAvailMemInGB = -1;
    
end;

showMessage(this, sprintf('Freed %05.2f%% memory (percent of the %.0f GB available; used memory before flush: %05.2f%%, after %05.2f%%).', ...
    usedMemPercentBefore - usedMemPercentAfter, totAvailMemInGB, usedMemPercentBefore, usedMemPercentAfter));

    
end
