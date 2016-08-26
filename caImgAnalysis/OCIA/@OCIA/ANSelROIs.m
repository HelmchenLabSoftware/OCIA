function ANSelROIs(this, ROIsToSel)
% ANSelROIs - [no description]
%
%       ANSelROIs(this, ROIsToSel)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

nROIs = size(get(this.GUI.handles.an.ROIList, 'String'), 1);
if ischar(ROIsToSel) && strcmp(ROIsToSel, 'all');
    set(this.GUI.handles.an.ROIList, 'Value', 1 : nROIs);
elseif ischar(ROIsToSel) && strcmp(ROIsToSel, 'none');
    set(this.GUI.handles.an.ROIList, 'Value', []);
elseif ischar(ROIsToSel) && strcmp(ROIsToSel, 'up');
    selRuns = get(this.GUI.handles.an.ROIList, 'Value');
    selRun = selRuns(1);
    set(this.GUI.handles.an.ROIList, 'Value', max(selRun - 1, 1));
elseif ischar(ROIsToSel) && strcmp(ROIsToSel, 'down');
    selRuns = get(this.GUI.handles.an.ROIList, 'Value');
    selRun = selRuns(end);
    set(this.GUI.handles.an.ROIList, 'Value', min(selRun + 1, nROIs));
elseif isnumeric(ROIsToSel);
    set(this.GUI.handles.an.ROIList, 'Value', ROIsToSel(ROIsToSel >= 1 && ROIsToSel <= nROIs));
else
    showWarning(this, 'OCIA:ANSelROIs:InvalidCommand', sprintf('Unknown command: %s', ROIsToSel));
end;

ANUpdatePlot(this);

end
