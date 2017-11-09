function JTProcessVirtualJoints(this, ~, ~)
% JTProcessVirtualJoints - [no description]
%
%       JTProcessVirtualJoints(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

o('#JTProcessVirtualJoints: processing virtual joints ...', 2, this.verb);

% clear all non-forces virtual joints
for iJoint = 1 : this.jt.nJoints;
    for iFrame = 1 : this.jt.nFrames;
        if this.jt.jointConfig{iJoint, 2} && ~this.GUI.jt.forcedJoints(iJoint, iFrame, this.GUI.jt.iJointType);
            this.jt.joints(iJoint, iFrame, :, this.GUI.jt.iJointType) = 0;
        end;
    end;
end;
% clear handles from current frame
jointsToClearCurrentFrame = cell2mat(this.jt.jointConfig(:, 2)) ...
    & ~this.GUI.jt.forcedJoints(:, this.GUI.jt.iFrame, this.GUI.jt.iJointType);
JTClearJoints(this, jointsToClearCurrentFrame);
o('#JTProcessVirtualJoints: cleared virtual joints ...', 2, this.verb);

% rebuild virtual joints
for iJointType = 1 : this.jt.nJointTypes;
    for iFrame = 1 : this.jt.nFrames;
        JTUpdateVirtualJoints(this, iFrame, iJointType);
    end;
end;

% update GUI
JTUpdateGUI(this);
uicontrol(this.GUI.handles.jt.frameSetter);

o('#JTProcessVirtualJoints: processing virtual joints done.', 2, this.verb);

end
