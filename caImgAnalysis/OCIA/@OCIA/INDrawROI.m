function INDrawROI(this, ~, ~, varargin)
% INDrawROI - [no description]
%
%       INDrawROI(this, ~, ~, varargin)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% clear previous ROI
if ~isempty(this.GUI.in.ROIHandle);
    showMessage(this, 'Intrinsic: clearing previous ROI ...', 'yellow');
    delete(this.GUI.in.ROIHandle{1});
    delete(this.GUI.in.ROIHandle{2});
    delete(this.GUI.in.ROIHandle{3});
    this.GUI.in.ROIHandle = {};
end;

% if no position provided as input
if isempty(varargin) || isempty(varargin{1});
    % draw a new ROI
    showMessage(this, 'Intrinsic: drawing new ROI on stimulus image ...', 'yellow');
    freeHandROIHandle = imfreehand(this.GUI.handles.in.expAxeRight);
    if isempty(freeHandROIHandle);
        this.GUI.in.ROIHandle = {};
        showMessage(this, 'Intrinsic: drawing new ROI aborted.', 'yellow');
        return;
    end;

    ROIPos = freeHandROIHandle.getPosition();
    ROIPos = unique(round(ROIPos) + 0.5, 'rows', 'stable');
    delete(freeHandROIHandle);
    
% use position provided as input
else
    
    ROIPos = varargin{1};
    
end;

% create ROI on stimulus image
this.GUI.in.ROIHandle{1} = imfreehand(this.GUI.handles.in.expAxeRight, ROIPos, 'Closed', true);
this.GUI.in.ROIHandle{1}.setVerticesDraggable(false);
this.GUI.in.ROIHandle{1}.addNewPositionCallback(@(h, e)this.GUI.in.ROIHandle{2}.setPosition(this.GUI.in.ROIHandle{1}.getPosition()));
this.GUI.in.ROIHandle{1}.addNewPositionCallback(@(h, e)this.GUI.in.ROIHandle{3}.setPosition(this.GUI.in.ROIHandle{1}.getPosition()));

% create ROI on refence image
this.GUI.in.ROIHandle{2} = imfreehand(this.GUI.handles.in.refAxe, ROIPos, 'Closed', true);
this.GUI.in.ROIHandle{2}.setVerticesDraggable(false);
this.GUI.in.ROIHandle{2}.addNewPositionCallback(@(h, e)this.GUI.in.ROIHandle{1}.setPosition(this.GUI.in.ROIHandle{2}.getPosition()));
this.GUI.in.ROIHandle{2}.addNewPositionCallback(@(h, e)this.GUI.in.ROIHandle{3}.setPosition(this.GUI.in.ROIHandle{2}.getPosition()));

% create ROI on baseline image
this.GUI.in.ROIHandle{3} = imfreehand(this.GUI.handles.in.expAxeLeft, ROIPos, 'Closed', true);
this.GUI.in.ROIHandle{3}.setVerticesDraggable(false);
this.GUI.in.ROIHandle{3}.addNewPositionCallback(@(h, e)this.GUI.in.ROIHandle{1}.setPosition(this.GUI.in.ROIHandle{3}.getPosition()));
this.GUI.in.ROIHandle{3}.addNewPositionCallback(@(h, e)this.GUI.in.ROIHandle{2}.setPosition(this.GUI.in.ROIHandle{3}.getPosition()));


showMessage(this, 'Intrinsic: new ROI created !');

end
