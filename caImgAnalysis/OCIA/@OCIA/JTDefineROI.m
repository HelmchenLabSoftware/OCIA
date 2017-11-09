function JTDefineROI(this, ~, ~)
% JTDefineROI - [no description]
%
%       JTDefineROI(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if isempty(this.GUI.jt.iJoint);
    showWarning(this, 'OCIA:JT:JTDefineROI:NoJoint', 'No joint selected to define the ROI.');
    return;
end;

% get the joint to which to apply the ROI
selJoints = this.GUI.jt.iJoint;

% loop through all selected joints and copy the created mask
for i = 1 : numel(selJoints);
    
    % get the current joint and its handle
    iJoint = selJoints(i);
    ROIHandle = this.GUI.jt.jointROIHandles{iJoint};
    
    % remove previous handle if it exists
    if ~isempty(ROIHandle) && isa(ROIHandle, 'impoly') && ROIHandle.isvalid();
        delete(ROIHandle);
    end;

    if i == 1;
        this.GUI.jt.selectingROI = true;
        ROIHandleNewROI = impoly(this.GUI.handles.jt.axe);
        this.GUI.jt.selectingROI = false;
    else
        ROIHandleNewROI = impoly(this.GUI.handles.jt.axe, ROIHandleNewROI.getPosition());
    end;
    
    if isempty(ROIHandleNewROI);
        ROIHandleNewROI = [];
        jointMask = [];
    else
        jointMask = ROIHandleNewROI.createMask();
        set(ROIHandleNewROI, 'Tag', sprintf('JTROIMask_%02d', iJoint));
    end;

    % store the variables
    this.GUI.jt.jointROIHandles{iJoint} = ROIHandleNewROI;
    this.jt.jointROIMasks{iJoint} = jointMask;
    
end;

% reset the joint placing variable
this.GUI.jt.placeJointIndex = [];

end
