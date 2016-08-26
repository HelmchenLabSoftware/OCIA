function jointAngles = JTGetJointAngles(this, selJoints, frameRange, iJointType)
% JTGetJointAngles - [no description]
%
%       jointAngles = JTGetJointAngles(this, selJoints, frameRange, iJointType)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
% get the angles between joints

jointAngles = zeros(this.jt.nJoints, frameRange(end) - frameRange(1) + 1);
for iJoint = 1 : this.jt.nJoints;
    if ~any(iJoint == selJoints); continue; end;

    jc = squeeze(this.jt.joints(iJoint, :, :, iJointType));

    if iJoint == 1;
        j1 = jc;
        jc = squeeze(this.jt.joints(iJoint + 1, :, :, iJointType));
        j2 = [j1(:, 1), jc(:, 2)];
    elseif iJoint == this.jt.nJoints;
        j2 = squeeze(this.jt.joints(iJoint - 1, :, :, iJointType));
        j1 = [j2(:, 1), jc(:, 2)];
    else
        j1 = squeeze(this.jt.joints(iJoint - 1, :, :, iJointType));
        j2 = squeeze(this.jt.joints(iJoint + 1, :, :, iJointType));
    end;

    jointAngles(iJoint, :) = arrayfun(@(iFrame) atan2(det([j2(iFrame, :) - jc(iFrame, :); j1(iFrame, :) - jc(iFrame, :)]), ...
        dot(j2(iFrame, :) - jc(iFrame, :), j1(iFrame, :) - jc(iFrame, :))) * 180 / pi, frameRange);
end;

end