function RDLoadROIs(this, ~, ~)
% RDLoadROIs - [no description]
%
%       RDLoadROIs(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

o('#%s()', mfilename(), 4, this.verb);
showMessage(this, 'Loading ROIs ...', 'yellow');

% if not in RDCompareROIs mode
if ~get(this.GUI.handles.rd.refROISet, 'Value');
    iRDRow = get(this.GUI.handles.rd.tableList, 'Value');
    if isempty(iRDRow);
        warning('OCIA:RD:RDLoadROIs:NoRowSelected', 'No rows are selected!');
        return;
    end;
    iRDRow = iRDRow(1); % only use the first row
    
% in RDCompareROIs mode
else
    iRDRows = get(this.GUI.handles.rd.tableList, 'Value');
    iRDRow = iRDRows(get(this.GUI.handles.rd.refROISetASetter, 'Value'));
end;
o('#%s(): iListRow: %d', mfilename(), iRDRow, 4, this.verb);

iDWRow = this.rd.selectedTableRows(iRDRow); % get the DataWatcher table's index

% if selected row is a ROISet row, load directly its path
if strcmp('ROISet', get(this, iDWRow, 'rowType'));
    ROISetFilePath = get(this, iDWRow, 'path');
    
% if selected row is not a ROISet row, create the ROISet path
else
    
    % build up the path from the watch folder
    ROISetFolderPath = get(this, iDWRow, 'path');
    ROISetFolderPath = regexprep(ROISetFolderPath, '/$', ''); % remove ending slash
    % remove path parts where the ROISet folder should be saved
    for iLevel = 1 : this.dw.ROISetNFolderAbove + 1;
        ROISetFolderPath = regexprep(ROISetFolderPath, '/[^/]+$', '');
    end;
    
    ROISetFolderPath = sprintf('%s/ROISets/', ROISetFolderPath);
    o('#%s(): ROISetFolderPath: %s', mfilename(), ROISetFolderPath, 4, this.verb);
    ROISetFilePath = sprintf('%sROISet_%s.mat', ROISetFolderPath, DWGetRowID(this, iDWRow));
    % backward compatibility with old naming system
    if ~exist(ROISetFilePath, 'file');
        ROISetFilePath = sprintf('%sROISet_%s__%sh.mat', ROISetFolderPath, get(this, iDWRow, 'day'), ...
            get(this, iDWRow, 'time'));
    end;
    o('#%s(): ROISetFilePath: %s', mfilename(), ROISetFilePath, 4, this.verb);
end;

% if the file cannot be found, abort with a warning
if ~exist(ROISetFilePath, 'file');
    showWarning(this, 'RDLoadROIs:ROISetFileNotFound', ...
        sprintf('Could not find ROISet file at "%s" ...', ROISetFilePath));
    
    % select a file
    [ROISetFileName, ROISetFilePath] = uigetfile('*.*', 'Select a file to load', this.path.localData);
    % if a path was specified, use that one
    if ischar(ROISetFileName);
        ROISetFilePath = [ROISetFilePath ROISetFileName];
    else % otherwise abort the loading
        return;
    end;
end;

% clear the eventually present previous ROIs
o('#%s(): Clearing previous ROIs, nROIs: %d', mfilename(), this.rd.nROIs, 4, this.verb);
showMessage(this, 'Loading ROIs: clearing previous ROIs ...', 'yellow');
RDClearROIs(this);
pause(0.1);

% load the ROISet containig mat-file
o('#%s(): loading ROIs ...', mfilename(), 3, this.verb);
showMessage(this, 'Loading ROIs: loading file ...', 'yellow');
ROISetMatStruct = load(ROISetFilePath);

% load back the variables
this.rd.ROIMask = ROISetMatStruct.ROIMask;
this.rd.ROIs = ROISetMatStruct.ROIs;
this.rd.nROIs = size(this.rd.ROIs, 1);
if isfield(ROISetMatStruct, 'runsValidity');
    runsValidity = ROISetMatStruct.runsValidity;
else
    runsValidity = [];
end;

% recreate the imroi objects
o('#%s(): recreating imroi objects ...', mfilename(), 3, this.verb);
showMessage(this, 'Loading ROIs: creating ROIs ...', 'yellow');
pause(0.5);
for iROI = 1 : this.rd.nROIs;
    % make sure name is displayed with 3 digits
    this.rd.ROIs{iROI, 2} = sprintf('%03d', str2double(this.rd.ROIs{iROI, 2}));
    % common inputs for the imrois
    inputs = {this.GUI.handles.rd.axe, this.rd.ROIs{iROI, 3}};
    % set the type of the imroi in the 4th column
    this.rd.ROIs{iROI, 4} = this.rd.ROIs{iROI, 1};
    % recreate the imroi depending on its type
    switch(this.rd.ROIs{iROI, 1});
        case {'impoly', 'imfreehand'};
            this.rd.ROIs{iROI, 1} = impoly(inputs{:}, 'Closed', true);
            this.rd.ROIs{iROI, 1}.setVerticesDraggable(false);
        otherwise
            imroiFuncHandle = str2func(this.rd.ROIs{iROI, 1});
            this.rd.ROIs{iROI, 1} = imroiFuncHandle(inputs{:});
    end;
    % add the position callback
    ROIID = this.rd.ROIs{iROI, 2};
    this.rd.ROIs{iROI, 1}.addNewPositionCallback(@(h)RDUpdateImage(this, [], [], ROIID));
    this.rd.ROIs{iROI, 6} = true; % mark as modified/created
end;

o('#%s(): loading done.', mfilename(), 3, this.verb);
% get the plural marks for the display
plurROIs = ''; if this.rd.nROIs > 1;        plurROIs = 's'; end;
plurRuns = ''; if numel(runsValidity) > 1;  plurRuns = 's'; end;
showMessage(this, sprintf('Loaded %d ROI%s (%d run%s).', this.rd.nROIs, plurROIs, numel(runsValidity), plurRuns));

% update the display
RDUpdateGUI(this);
RDShowHideROIs(this, []);

% set back the ROICompare annotations
if get(this.GUI.handles.rd.refROISet, 'Value');    
    set(this.GUI.handles.rd.showHideROIs, 'Value', 0);
    set(this.GUI.handles.rd.showHideROIsLab, 'Value', 0);
    RDShowHideROIs(this, []);    
    RDCompareROIs(this);    
end;

end
