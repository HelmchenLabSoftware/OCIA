function DWProcessWatchFolder(this, ~, ~)
% DWProcessWatchFolder - Processes the watch folder to update the DataWatcher's table
%
%       DWProcessWatchFolder(this)
%       DWProcessWatchFolder(this, handles, event)
%
% Process the watch folder (this.dw.watchFolder) and the files/folders it contains using the current watch types
%   (filtering options for the file types) and current filters (specific animal/day/etc.).

% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

watchTic = tic; % for performance timing purposes
o('#DWProcessWatchFolder(): in "%s".', this.dw.watchFolder, 4, this.verb);

% if processing is already ongoing, stop it
if this.GUI.dw.isProcessingOnGoing;
    this.GUI.dw.isProcessingOnGoing = false;
    set(this.GUI.handles.dw.procFold, 'String', 'Aborting...', 'BackgroundColor', 'yellow', 'Value', 1, 'Enable', 'off');
    return;
end;

% defines whether to keep the table or flush it
keepTable = get(this.GUI.handles.dw.keepTable, 'Value');

% warn the user that processing the watch folder path flushes all data
if ~keepTable && ~this.dw.ignoreDataFlushWarning;
    doFlush = questdlg('Processing the watch folder flushes all loaded data. Continue ?', ...
        '/!\ Warning ! Data flush !', 'Yes', 'No', 'Yes');
    if strcmp(doFlush, 'No'); return; end;
end;

% set a flag to know that processing is currently being done
this.GUI.dw.isProcessingOnGoing = true;
OCIAToggleGUIEnableState(this, 'DataWatcher', 0);
set(this.GUI.handles.dw.procFold, 'String', 'STOP', 'BackgroundColor', 'red', 'Enable', 'on', 'Value', 0);
% enable the online analysis button if it is active
if isfield(this.GUI.handles.dw, 'onlineAnalysis') && get(this.GUI.handles.dw.onlineAnalysis, 'Value');
    set(this.GUI.handles.dw.onlineAnalysis, 'Enable', 'on');
end;

% empty the selected rows
this.dw.selectedTableRows = [];
% if keeping the old table is not required, flush it and display the empty table
if ~keepTable;
    this.dw.table(:, :) = { [] };
    DWDisplayTable(this, false); % false is for no warning
end;

% update wait bar and show message
DWWaitBar(this, 0);
showMessage(this, 'Processing watch folder ...', 'yellow');

% create the toKeepWatchTypes structure which defines which file types should be included in the DataWatcher's table,
%   using the state of the GUI checkboxes
toKeepWatchTypes = DWCreateToKeepWatchTypeStruct(this, 1, 0);

% clear the filtering drop-down list
dropDownListFilterNames = this.GUI.dw.filtElems{strcmp(this.GUI.dw.filtElems.GUIType, 'dropdown'), 'id'};
for iName = 1 : numel(dropDownListFilterNames);
    filtName = dropDownListFilterNames{iName}; % get the filter name
    % create a list with only a dash element, which corresponds to no filtering
    this.dw.([filtName 'IDs']) = {'-'};
end;

% create a template table row that is an empty row of the DataWatcher's table
templateTableRow = cell(1, size(this.dw.table, 2));
    
% process the watch folder to get the new table. The filter elements' (animal, day, spot) list also gets updated.
try
    newTable = DWProcessGenericFolder(this, templateTableRow, this.dw.watchFolder, [], [], [], [], toKeepWatchTypes, 100);
    DWWaitBar(this, 100);
catch err;
    processFailError = err;
    newTable = -2;
end;

% if new table is -1, or -2, processing was interrupted or failed, so stop here with an empty table
if isnumeric(newTable) && (newTable == -1 || newTable == -2);
    
    % display warning for interruption
    if newTable == -1;
        showWarning(this, 'OCIA:DW:DWProcessWatchFolder:ProcessingInterrputed', ...
            'Processed watch folder interrupted.');
    % display warning for failure
    elseif newTable == -2;
        errMessage = regexprep(processFailError.message, 'Error: <a href=[^>]+>', '');
        errMessage = regexprep(errMessage, '</a>', '');
        showWarning(this, 'OCIA:DW:DWProcessWatchFolder:ProcessingFailed', ...
            sprintf('Processed watch folder failed ("%s"): %s.', processFailError.identifier, ...
            errMessage));
    end;
    
    % display the table without emptiness warning
    DWDisplayTable(this, false);
    % set the processing flag back to false and reset the processing button
    this.GUI.dw.isProcessingOnGoing = false;
    set(this.GUI.handles.dw.procFold, 'String', '<html><b>UPDATE</b><br>&nbsp;TABLE', 'BackgroundColor', 'default', 'Enable', 'on', 'Value', 0);
    OCIAToggleGUIEnableState(this, 'DataWatcher', 1);
    return;
    
% otherwise use the processed table as new table (eventually including the old table)
else
    % concatenate the old and new table    
    this.dw.table = [this.dw.table; newTable];
    DWMakeTableUnique(this);
end;

% get the different row types from the table
if ~isempty(this.dw.table) && size(this.dw.table, 1) > 1;
    this.dw.rowTypeIDs = [ '-'; unique(get(this, 'rowType')) ];
elseif ~isempty(this.dw.table);
    this.dw.rowTypeIDs = [ '-'; { get(this, 'rowType') } ];
end;

% update the filtering drop-down list
for iName = 1 : numel(dropDownListFilterNames);
    filtName = dropDownListFilterNames{iName}; % get the filter name
    filtH = this.GUI.handles.dw.filt.([filtName 'ID']);
    
    % make sure the selected object stays selected
    oldStrings = get(filtH, 'String');
    oldSelString = oldStrings(get(filtH, 'Value'));
    
    if get(filtH, 'Value') > numel(this.dw.([filtName 'IDs']));
        set(filtH, 'Value', 1);
    end;
    
    % populate the drop-down list with the existing list
    set(filtH, 'String', this.dw.([filtName 'IDs']));
    
    % restore the previously selected string if still available
    if ismember(oldSelString, this.dw.([filtName 'IDs']));
        set(filtH, 'Value', find(strcmp(get(filtH, 'String'), oldSelString)));
    else 
        
%         % try to find the old string using regular expressions
%         regexpMatch = find(cellfun(@(newStr)~isempty(cell2mat(regexp(newStr, oldSelString, 'once'))), this.dw.([filtName 'IDs'])));
%         % if none find, select first one
%         if isempty(regexpMatch); regexpMatch = 1; end;

        % otherwise just select the first element
        set(filtH, 'Value', 1);
    end;
end;

% fill in the row numbering
nRows = size(this.dw.table, 1);
if nRows;
    set(this, 1 : nRows, 'rowNum', arrayfun(@(i)sprintf(' %03d', i), 1 : nRows, 'UniformOutput', false));
end;

% display the table
DWDisplayTable(this);
% if the DataWatcher's table was not empty, display the message
nRowsInTable = size(this.dw.table, 1);
if nRowsInTable;
    showMessage(this, sprintf('Processed watch folder: %d row(s) (%.1f sec).', nRowsInTable, toc(watchTic)));

    % call the table annotating function
    OCIAGetCallCustomFile(this, 'annotateTable', this.dw.annotateTableFunctionName, 1, { this }, 1);

else
    showMessage(this, sprintf('Processed watch folder: no matching rows found (%.1f sec).', toc(watchTic)), 'yellow');
end;

% set the processing flag back to false and reset the processing button
this.GUI.dw.isProcessingOnGoing = false;
OCIAToggleGUIEnableState(this, 'DataWatcher', 1);
set(this.GUI.handles.dw.procFold, 'String', '<html><b>UPDATE</b><br>&nbsp;TABLE', 'BackgroundColor', 'default', 'Enable', 'on', 'Value', 0);

end
