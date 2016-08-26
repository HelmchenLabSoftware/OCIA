function OCIA_dataWatcherProcess_drawROIs(this, ~, ~)
% OCIA_dataWatcherProcess_drawROIs - [no description]
%
%       OCIA_dataWatcherProcess_drawROIs(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% show message and update the row selection
showMessage(this, 'Entering ROIDrawing mode ...');
DWTableClick(this); % update the selected rows

% store the selected rows so that even changing the selection in the DataWatcher mode does not affect the ROIDrawer
this.rd.selectedTableRows = this.dw.selectedTableRows;

o('#%s(): selected row(s): %s ...', mfilename(), num2str(this.rd.selectedTableRows), 4, this.verb);

% abort if no rows selected
if isempty(this.rd.selectedTableRows);
    showWarning(this, 'OCIA:OCIA_dataWatcherProcess_drawROIs:NoRowsSelected', 'No rows selected! Aborting.');
    return;
end;

% filter the selection to only have valid rows selected (imaging data or ROISets)
selectedImagingRows = DWFilterTable(this, 'rowType = Imaging data OR rowType = ROISet', ...
    this.dw.table(this.rd.selectedTableRows, :));
% if some non-valid rows were selected, show a warning
if size(selectedImagingRows, 1) ~= numel(this.rd.selectedTableRows);
    showWarning(this, 'OCIA:OCIA_dataWatcherProcess_drawROIs:InvalidRowsSelected', ...
        'Some non-valid rows were removed from the selection.');
    % get the new selection and apply it to the table
    this.rd.selectedTableRows = str2double(get(this, 1 : size(selectedImagingRows), 'rowNum', selectedImagingRows));
    DWSelTableRows(this, this.rd.selectedTableRows);
    pause(0.5);
end;

% prepare/reset the ROIDrawer's variables
nRowSelected = numel(this.rd.selectedTableRows);
this.rd.avgImages = cell(nRowSelected, 1);
this.rd.rawFrames = cell(nRowSelected, 1);
rcFields = fieldnames(this.rd.rc)';
this.rd.rc = cell2struct(cell(1, numel(rcFields)), rcFields, 2); % reset the RD's ROI comparator structure
% reset the image
RDUpdateImage(this);

% change the mode
OCIAChangeMode(this, 'ROIDrawer');    
showMessage(this, 'Loading ...');

% get the ROISet rows
ROISetRefRows = DWFilterTable(this, 'rowType = ROISet');
if ~isempty(ROISetRefRows);
    ROISetRefRowRowIndexes = str2double(get(this, 1 : size(ROISetRefRows, 1), 'rowNum', ROISetRefRows));
    ROISetRefRowIDs = DWGetRowID(this, ROISetRefRowRowIndexes);
    if ~iscell(ROISetRefRowIDs); ROISetRefRowIDs = { ROISetRefRowIDs }; end;
else
    ROISetRefRowIDs = {};
end;

% storage for the row labels
rowLabels = cell(nRowSelected, 1);
rowToLoad = 1; % by default, load row 1

% go through each row and create a display text (row labels)
for iRDRow = 1 : nRowSelected;

    % get info about the row
    iDWRow = this.rd.selectedTableRows(iRDRow);    
    % generate a label for this row
    rowLabels{iRDRow} = '';
    
    % create the display using the column names specified in the config
    colNames = this.GUI.rd.DWTableColumnsToUse;
    for iCol = 1 : numel(colNames);
        % get the row ID using the dedicated function
        if strcmp(colNames{iCol}, 'rowID');
            rowLabels{iRDRow} = sprintf('%s - %s', rowLabels{iRDRow}, DWGetRowID(this, iDWRow));
        % otherwise just fetch the value from the DataWatcher's table
        else
            rowLabels{iRDRow} = sprintf('%s - %s', rowLabels{iRDRow}, get(this, iDWRow, colNames{iCol}));
        end;
    end;
    rowLabels{iRDRow} = regexprep(rowLabels{iRDRow}, '^\s+-\s+', ''); % clean up the label
    
    % check whethere this row was used as reference row for a ROISet
    if ismember(DWGetRowID(this, iDWRow), ROISetRefRowIDs);
        rowLabels{iRDRow} = ['**', rowLabels{iRDRow}];
        % select this row to be loaded
        if rowToLoad == 1; rowToLoad = iRDRow; end;
    end;
    
    % remove the delete tag(s) (if any)
    rowLabels{iRDRow} = regexprep(rowLabels{iRDRow}, this.GUI.dw.deleteTag, '');
end;

% display the created row labels
set(this.GUI.handles.rd.tableList, 'String', rowLabels, 'Value', rowToLoad, 'ListBoxTop', 1);

% go through each row and pre-load them if required
for iRDRow = 1 : nRowSelected;
    % if pre-loading of the images was requested or if it is the first row, load the image
    if this.GUI.rd.preloadImages || iRDRow == rowToLoad;
        RDChangeRow(this, iRDRow); % load the row
    elseif iRDRow > rowToLoad % if pre-load not required, abort pre-loading after first row is done
        break;
    end;
end;

% display final message
if this.GUI.rd.preloadImages;
    showMessage(this, sprintf('Loading images done (%02d/%02d).', nRowSelected, nRowSelected));
else
    showMessage(this, 'Loaded first image.');
end;

end
