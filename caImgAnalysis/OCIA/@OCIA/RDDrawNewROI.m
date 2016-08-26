function RDDrawNewROI(this, ~, ~)
% RDDrawNewROI - [no description]
%
%       RDDrawNewROI(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the currently selected drawing tool
for iTool = 1 : size(this.GUI.rd.drawTools, 1);
    if get(this.GUI.handles.rd.drawTool.(this.GUI.rd.drawTools.id{iTool}), 'Value');
        currentDrawTool = this.GUI.rd.drawTools.id{iTool};
        break;
    end;
end;

o('#RDDrawNewROI(): current draw tool: %s.', currentDrawTool, 4, this.verb);

% get the current draw tool's callback
drawFuncHandle = str2func(char(this.GUI.rd.drawTools{currentDrawTool, 'callback'}));
% call it to draw a new ROI
newROI = drawFuncHandle(this.GUI.handles.rd.axe);

% if no ROI was created, abort
if isempty(newROI); return; end;

% make sur position is at the right resolution
ROIPos = newROI.getPosition();
ROIClass = class(newROI);
if isa(newROI, 'imfreehand');
    ROIPos = unique(round(ROIPos) + 0.5, 'rows', 'stable');
    delete(newROI);
    newROI = impoly(this.GUI.handles.rd.axe, ROIPos, 'Closed', true);
    newROI.setVerticesDraggable(false);
end;

this.rd.ROIs(end + 1, 1 : 2) = cell(2, 1);
this.rd.ROIs{end, 1} = newROI;
this.rd.nROIs = size(this.rd.ROIs, 1);
if this.rd.nROIs == 1;  this.rd.ROIs{end, 2} = sprintf('%03d', this.rd.nROIs);
else                    this.rd.ROIs{end, 2} = sprintf('%03d', str2double(this.rd.ROIs{end - 1, 2}) + 1);
end;
ROIID = this.rd.ROIs{end, 2};

this.rd.ROIs{end, 1}.addNewPositionCallback(@(h)RDUpdateImage(this, [], [], ROIID));
this.rd.ROIs{end, 3} = ROIPos;
this.rd.ROIs{end, 4} = ROIClass;
this.rd.ROIs{end, 5} = []; % will contain the text handles
this.rd.ROIs{end, 6} = true; % mark as modified/new ROI

RDUpdateGUI(this);

% if in ROICompare mode, give focus to the ROIRename
if get(this.GUI.handles.rd.refROISet, 'Value');
    set(this.GUI.handles.rd.selROIsList, 'Value', numel(get(this.GUI.handles.rd.selROIsList, 'String')));
    RDSelROI(this);
    set(this.GUI.handles.rd.ROIName, 'String', '');
    uicontrol(this.GUI.handles.rd.ROIName);
end;

end
