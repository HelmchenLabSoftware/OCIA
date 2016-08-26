function RDRenameROI(this, ~, ~)
% RDRenameROI - [no description]
%
%       RDRenameROI(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the selected ROIs
selROIs = RDGetSelectedROIs(this);
% abort if no selection
if isempty(selROIs); return; end;

% get the names of the ROIs
for iROI = 1 : numel(selROIs);
    ROIID = get(this.GUI.handles.rd.ROIName, 'String');
    %% TODO: remove old position callback ...
    this.rd.ROIs{selROIs(iROI), 1}.addNewPositionCallback(@(h)RDUpdateImage(this, [], [], ROIID));
    this.rd.ROIs{selROIs(iROI), 2} = ROIID;
    this.rd.ROIs{selROIs(iROI), 6} = true; % mark as modified
end;

% sort ROIs by name
[~, sortInd] = sort(this.rd.ROIs(:, 2));
this.rd.ROIs = this.rd.ROIs(sortInd, :);

% clear selection
RDSelROI(this, this.GUI.handles.rd.selROISetterClear);

% update the display
RDUpdateGUI(this);
    
end




