function JTImClick(this, ~, ~)
% JTImClick - [no description]
%
%       JTImClick(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get current frame and joint type
iFrame = this.GUI.jt.iFrame;
iJointType = this.GUI.jt.iJointType;

% abort if no frame set
if iFrame == 0; return; end;

% get the click coordinates
pos = get(this.GUI.handles.jt.axe, 'CurrentPoint');
pos = pos(1, 1 : 2);
o('#JTImClick(): current frame: %d, click coordinates: [%.1f,%.1f].', iFrame, pos, 3, this.verb);

% all joints are already set and not placing neither moving any joints
if isempty(this.GUI.jt.placeJointIndex) && isempty(this.GUI.jt.moveJointIndex);

    o('#JTImClick(): all joints assigned, no placing, no moving.', 3, this.verb);
    
% both placing and moving a joints: normally impossible case
elseif ~isempty(this.GUI.jt.placeJointIndex) && ~isempty(this.GUI.jt.moveJointIndex);
    
    showWarning(this, 'OCIA:JT:JTImClick:PlaceAndMove', sprintf('Error: placing AND moving joint (%d & %d) ...', ...
        this.GUI.jt.placeJointIndex, this.GUI.jt.moveJointIndex));
    
% currently placing or moving a joint
elseif ~isempty(this.GUI.jt.placeJointIndex) || ~isempty(this.GUI.jt.moveJointIndex);
    
    if ~isempty(this.GUI.jt.placeJointIndex);
        iJoint = this.GUI.jt.placeJointIndex;
        o('#JTImClick(): placing joint %d ...', iJoint, 3, this.verb);
    else
        iJoint = this.GUI.jt.moveJointIndex;
        o('#JTImClick(): moving joint %d ...', iJoint, 3, this.verb);
    end;
    
    % store joint position
    this.jt.joints(iJoint, iFrame, :, iJointType) = pos;
    % mark joint as forced-placed
    this.GUI.jt.forcedJoints(iJoint, iFrame, iJointType) = true;
    
    % if previous joint is virtual and not forced-placed, reset it
    if iJoint > 1 && this.jt.jointConfig{iJoint - 1, 2} && ~this.GUI.jt.forcedJoints(iJoint - 1, iFrame, iJointType);
        this.jt.joints(iJoint - 1, iFrame, :, iJointType) = [0 0];
    end;
    
    % if next joint is virtual and not forced-placed, reset it
    if iJoint < this.jt.nJoints && this.jt.jointConfig{iJoint + 1, 2} ...
            && ~this.GUI.jt.forcedJoints(iJoint + 1, iFrame, iJointType);
        this.jt.joints(iJoint + 1, iFrame, :, iJointType) = [0 0];
    end;
    
    % check for virtual joints
    JTUpdateVirtualJoints(this, iFrame, iJointType);
    
    % refresh the joints' display
    JTUpdateGUI(this);
    
    if ~isempty(this.GUI.jt.placeJointIndex);
        showMessage(this, sprintf('Placed %s (%d, "%s") at [%.1f,%.1f].', this.jt.jointConfig{iJoint, 1}, iJoint, ...
            this.jt.jointTypes{iJointType, 2}, this.jt.joints(iJoint, iFrame, :, iJointType)));
    else
        showMessage(this, sprintf('Moved %s (%d, "%s") to [%.1f,%.1f].', this.jt.jointConfig{iJoint, 1}, iJoint, ...
            this.jt.jointTypes{iJointType, 2}, this.jt.joints(iJoint, iFrame, :, iJointType)));
    end;

% impossible case
else
    
    showWarning(this, 'OCIA:JT:JTImClick:ImpossibleCase', sprintf(['Error: impossible case: place joint = %d, ' ...
        'move joint = %d ...'], this.GUI.jt.placeJointIndex, this.GUI.jt.moveJointIndex));
    
end;

% set the focus to the frame setter
uicontrol(this.GUI.handles.jt.frameSetter);

end
