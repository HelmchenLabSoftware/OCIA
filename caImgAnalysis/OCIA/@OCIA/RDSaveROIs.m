function RDSaveROIs(this, ~, ~)
% RDSaveROIs - [no description]
%
%       RDSaveROIs(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

o('#%s(): saving %d ROI(s) ...', mfilename(), this.rd.nROIs, 3, this.verb);

% if there are no ROIs, abort
if ~this.rd.nROIs;
    showWarning(this, 'RDSaveROIs:NoROI', 'There are no ROIs to be saved !');
    return;
end;

% find redundant ROIs: ROIs that have the exact same name
redundantROIIndexes = cell2mat(cellfun(@(ROIID) sum(strcmp(ROIID, this.rd.ROIs(:, 2))), ...
    unique(this.rd.ROIs(:, 2)), 'UniformOutput', false)) > 1;
redundantROIIDs = this.rd.ROIs(redundantROIIndexes, 2);
% if there are redundant ROIs, show a warning and abort
if ~isempty(redundantROIIDs);
    showWarning(this, 'RDSaveROIs:DuplicatedROIs', sprintf('Identically labelled ROIs :%s !', ...
        sprintf(' %s', redundantROIIDs{:})));
    return;
end;

% if not in RDCompareROIs mode
if ~get(this.GUI.handles.rd.refROISet, 'Value');
    iRDRow = get(this.GUI.handles.rd.tableList, 'Value');
    if isempty(iRDRow);
        warning('OCIA:RD:RDSaveROIs:NoRowSelected', 'No rows are selected!');
        return;
    end;
    if numel(iRDRow) > 1;
        showWarning(this, 'RDSaveROIs:MultipleRowsSelected', 'Several rows selected as reference, please choose one.');
        return;
    end;
 
% in RDCompareROIs mode
else
    iRDRows = get(this.GUI.handles.rd.tableList, 'Value');
    iRDRow = iRDRows(get(this.GUI.handles.rd.refROISetASetter, 'Value'));
end;

o('#%s(): iRDRow: %d', mfilename(), iRDRow, 4, this.verb);

iDWRow = this.rd.selectedTableRows(iRDRow); % get the DataWatcher table's index

% get if the current row is a ROISet row
isROISetRow = strcmp('ROISet', get(this, iDWRow, 'rowType'));

% if the current row is a ROISet row, do not save the runs and the reference image
if isROISetRow;
    set([this.GUI.handles.rd.saveOpts.runsVal, this.GUI.handles.rd.saveOpts.refIm], 'Value', 0);
end;

% get what needs to be saved
toSaveOptions = {};
if get(this.GUI.handles.rd.saveOpts.ROIs, 'Value');     toSaveOptions(end + 1 : end + 2) = { 'ROIs', 'ROIMask' }; end;
if get(this.GUI.handles.rd.saveOpts.runsVal, 'Value');  toSaveOptions{end + 1} = 'runsValidity'; end;
if get(this.GUI.handles.rd.saveOpts.refIm, 'Value');    toSaveOptions{end + 1} = 'refImage'; end;
% if nothing is selected to be saved
if isempty(toSaveOptions);
    showWarning(this, 'OCIA:RD:RDSaveROIs:NothingToSave', 'Nothing is selected to be saved! Use the checkboxes!');
    return;
end;
    
% if selected row is a ROISet row, load directly its path
if isROISetRow;
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
    % backward compatibility for overwrite ROISets with old naming system
    if ~exist(ROISetFilePath, 'file');
        ROISetFilePath = sprintf('%sROISet_%s__%sh.mat', ROISetFolderPath, get(this, iDWRow, 'day'), ...
            get(this, iDWRow, 'time'));
    end;
    
    % create directory
    if exist(ROISetFolderPath, 'dir') ~= 7; mkdir(ROISetFolderPath); end;
    
    o('#%s(): ROISetFilePath: %s', mfilename(), ROISetFilePath, 4, this.verb);    
end;
    
% extract the variables that need to be saved
ROIMask = this.rd.ROIMask; %#ok<NASGU>
ROIs = cell(this.rd.nROIs, 3);
% extract the imroi object type, the ROI ID and the positions
ROIs(:, 1) = this.rd.ROIs(:, 4);
ROIs(:, 2) = this.rd.ROIs(:, 2);
ROIs(:, 3) = this.rd.ROIs(:, 3); %#ok<NASGU>
o('#%s(): generated saveable ''ROIs'' structure', mfilename(), 4, this.verb);

% get the runs validity
runsValidity = DWGetRowID(this, this.rd.selectedTableRows);
if ~iscell(runsValidity) && ~isempty(runsValidity); runsValidity = { runsValidity }; end;

% make sure the row is fully loaded
DWLoadRow(this, iDWRow, 'full'); % load row if required
if ismember('refImage', toSaveOptions);
    refImage = cellfun(@(img)nanmean(img, 3), getData(this, iDWRow, 'procImg', 'data'), 'UniformOutput', false); %#ok<NASGU>
end;
    
% save required elements
if exist(ROISetFilePath, 'file');
    save(ROISetFilePath, toSaveOptions{:}, '-append');
else
    save(ROISetFilePath, toSaveOptions{:});
end;

% generate and show the save text
saveText = 'Saved ';
if ismember('ROIs', toSaveOptions);
    plurROIs = ''; if this.rd.nROIs > 1; plurROIs = 's'; end;
    saveText = sprintf('%s%d ROI%s, ', saveText, this.rd.nROIs, plurROIs);
end;
if ismember('runsValidity', toSaveOptions);
    saveText = sprintf('%s%d "runsValidity", ', saveText, numel(runsValidity));
end;
if ismember('refImage', toSaveOptions);
    saveText = sprintf('%sreference image ', saveText);
end;
saveText = sprintf('%sunder "%s".', saveText, ROISetFilePath);
saveText = regexprep(saveText, ', under', ' under');
showMessage(this, saveText);

end
