function OCIA_dataWatcherProcess_processRows(this, h, inputRows)
% OCIA_dataWatcherProcess_processRows - [no description]
%
%       OCIA_dataWatcherProcess_processRows(this, h, inputRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if ~isfield(this.GUI.handles.dw, 'processRows'); return; end;

preProcRowsTic = tic; % for performance timing purposes

% if rows to process where provided as input, use them
if exist('inputRows', 'var') && isnumeric(inputRows) && (isempty(h) || ~ishandle(h));
    toProcessRows = inputRows;
    rowsFromInput = true; % set a flag

% otherwise get the selected rows
else    
    % get the rows to process
    toProcessRows = this.dw.selectedTableRows;
    rowsFromInput = false; % set a flag
    
end;

% if processing is already ongoing, stop it
if this.GUI.dw.isProcessingOnGoing;
    this.GUI.dw.isProcessingOnGoing = false;
    set(this.GUI.handles.dw.processRows, 'String', 'Aborting...', 'BackgroundColor', 'yellow', 'Value', 1, ...
        'Enable', 'off');
    return;
end;

% get the number of rows
nTotRows = numel(toProcessRows);
% if no row selected, abort with a warning
if nTotRows == 0;
    showWarning(this, 'OCIA:OCIA_dataWatcherProcess_processRows:NoRows', 'No rows selected.');
    return;
end;

% show message of how many rows are being processed
showMessage(this, sprintf('Processing data for %d row(s) ...', nTotRows));

% set a flag to know that processing is currently being done
this.GUI.dw.isProcessingOnGoing = true;
OCIAToggleGUIEnableState(this, 'DataWatcher', 0);
set(this.GUI.handles.dw.processRows, 'String', 'STOP', 'BackgroundColor', 'red', 'Enable', 'on', 'Value', 0);

% update the waiting bar
DWWaitBar(this, 0);
                
% analyse the type of each row
for iRow = 1 : nTotRows;
    
    % check if the processing should be aborted
    if DWCheckProcessAbort(this, [], []); break; end;
    
    preProcSingleRowTic = tic; % for performance timing purposes
    iDWRow = toProcessRows(iRow); % get the current row in the DataWatcher's table reference
    rowType = get(this, iDWRow, 'rowType'); % get the row type
    rowTypeID = DWGetRowTypeID(this, iDWRow); % get the row type ID
    rowID = DWGetRowID(this, iDWRow); % get the row ID 

    % call the processing function for this row type (data type)
    warning('off', 'OCIA:dataProcessFunctionNotFound');
    [funcHandle, validityCell] = OCIAGetCallCustomFile(this, 'dataProcess', rowTypeID, 1, { this, iDWRow }, 0);
    warning('on', 'OCIA:dataProcessFunctionNotFound');
    
    % if the process function was not found (function handle is empty) or if no validity cell is returned
    %   or the validity is false (first element of the validity cell-array)
    if isempty(funcHandle) || isempty(validityCell) || ~validityCell{1};

        % print a message explaining why the row was not processed:
        % if the function was not found (function handle is empty)
        if isempty(funcHandle);
            showMessage(this, sprintf(['Processing data for %s (%03d) skipped: row type "%s" is not valid ', ...
                '(no processing function).'], rowID, iDWRow, rowType));
        % if the row was flagged as not valid
        elseif ~isempty(validityCell) && numel(validityCell) >= 2 && ~validityCell{1};
            showMessage(this, sprintf('Processing data for %s (%03d) skipped: row is not valid: %s.', ...
                rowID, iDWRow, validityCell{2}));
        % otherwise something else went wrong
        else
            showMessage(this, sprintf('Processing data for %s (%03d) skipped: unknown error', rowID, iDWRow));
        end;
    
    % if row is valid
    else
        % update the row's loading and processing status
        DWGetUpdateDataLoadStatus(this, iDWRow, true);
        showMessage(this, sprintf('Processing data for %s (%03d) done (%.1f%% complete, done in %.1f sec).', ...
            rowID, iDWRow, 100 * (iRow / nTotRows), toc(preProcSingleRowTic)));
    end;
      
    % update waiting bar
    DWWaitBar(this, 100 * (iRow / nTotRows));
    
    % allow time for GUI update
    if isGUI(this); pause(0.005); end;

end;

showMessage(this, sprintf('Processing data for %d row(s) done (%.1f sec).', nTotRows, toc(preProcRowsTic)));

% if call is from callback, re-select the first row to activate the preview
if ~rowsFromInput;
    DWSelTableRows(this, this.dw.selectedTableRows);
end;

%% restore UI
% set the processing flag back to false and reset the processing button
this.GUI.dw.isProcessingOnGoing = false;
set(this.GUI.handles.dw.processRows, 'String', 'Process', 'BackgroundColor', 'default', 'Enable', 'on', 'Value', 0);
OCIAToggleGUIEnableState(this, 'DataWatcher', 1);

end
