function JTJointClickStart(this, forcePlace)
% JTJointClickStart - [no description]
%
%       JTJointClickStart(this, forcePlace)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% abort if no frame set
if this.GUI.jt.iFrame == 0; return; end;

% abort if any ROI mask is shown
if get(this.GUI.handles.jt.viewOpts.ROIs, 'Value') && any(~cellfun(@isempty, this.GUI.jt.jointROIHandles));
    return;
end;

% default is not force place
if ~exist('forcePlace', 'var'); forcePlace = false; end;

% reset the joint placing/moving settings
this.GUI.jt.placeJointIndex = [];
this.GUI.jt.moveJointIndex = [];

% get the current frame and store it as starting frame
iFrame = this.GUI.jt.iFrame;
this.GUI.jt.startFrame = iFrame;
set(this.GUI.handles.jt.manuTrack, 'Value', 1);

% get the first joint type
if numel(this.GUI.jt.iJointType) > 1;
    this.GUI.jt.iJointType = this.GUI.jt.iJointType(1);
    set(this.GUI.handles.jt.jointTypeSelSetter, 'Value', this.GUI.jt.iJointType);
end;
iJointType = this.GUI.jt.iJointType;

% find the relevant joint from the current joint type:
% - if there are some non-set joints, use the first non-set non-virtual joint
% - if there are no non-set joints, use the closest joint
jointsVirtuality = cell2mat(this.jt.jointConfig(:, 2))';
jointsEmptiness = (squeeze(this.jt.joints(:, iFrame, 1, iJointType)) == 0)';

% get the clicked position
clickPos = get(this.GUI.handles.jt.axe, 'CurrentPoint');
clickPos = clickPos(1, 1 : 2);

% get the joints coordinates
jointCoords = squeeze(this.jt.joints(:, iFrame, :, iJointType));
% get the distance from the clicked position to each joint
dists = arrayfun(@(iJoint) dist(jointCoords(iJoint, :), clickPos'), 1 : this.jt.nJoints);
% get the closest joint
[sortDists, closestJointIndex] = sort(dists);
% exclude the joints that are too far:
closestJointIndex(sortDists > this.GUI.jt.jointMoveMaxDist) = 0;
% get the closest joint if there is still any (or leave empty otherwise)
iClosestJoint = closestJointIndex(find(closestJointIndex, 1, 'first'));
closestJointDistance = sortDists(find(closestJointIndex, 1, 'first'));

% if in auto-track mode or no joint to place or very close to a joint, try to move an existing joint
if ~forcePlace && (get(this.GUI.handles.jt.autoTrack, 'Value') || ~any(jointsEmptiness & ~jointsVirtuality) ...
        || (~isempty(closestJointDistance) && closestJointDistance < this.GUI.jt.jointMoveMinDist));
    
    % label that joint as the moved joint or leave empty if no joint to move
    this.GUI.jt.moveJointIndex = iClosestJoint;
    iJoint = iClosestJoint;

% some joints are not placed yet   
else
    
    % use the first non-set non-virtual joint
    iJoint = find(jointsEmptiness & ~jointsVirtuality, 1, 'first');

    % if no joint found, it means only virtual joints are not placed, so place the first non-set joint
    if isempty(iJoint);
        % use the first non-set joint
        iJoint = find(jointsEmptiness, 1, 'first');
    end;
    
    % label that joint as the placed joint
    this.GUI.jt.placeJointIndex = iJoint;
    
end;

% update the joint setter if not in auto-track mode
if ~get(this.GUI.handles.jt.autoTrack, 'Value');
    this.GUI.jt.iJoint = iJoint;
    set(this.GUI.handles.jt.jointSelSetter, 'Value', iJoint);
end;
    
% set the focus to the frame setter
uicontrol(this.GUI.handles.jt.frameSetter);

o('#JTJointClickStart(): moved joint: %d, placed joint: %d, iFrame: %d ...', ...
    this.GUI.jt.moveJointIndex, this.GUI.jt.placeJointIndex, this.GUI.jt.startFrame, 2, this.verb);

end
