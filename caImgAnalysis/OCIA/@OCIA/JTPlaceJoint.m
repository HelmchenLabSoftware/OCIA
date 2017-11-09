function JTPlaceJoint(this, iJoint, iJointType, pos)
% JTPlaceJoint - [no description]
%
%       JTPlaceJoint(this, iJoint, iJointType, pos)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the axe handles, the joint type ID, the current frame
axeH = this.GUI.handles.jt.axe;
jointTypeID = this.jt.jointTypes{iJointType, 1};
iFrame = this.GUI.jt.iFrame;
% get the right display settings and some information about the joint
dispSet = this.GUI.jt.disp(iJointType, :);
isVirtual = this.jt.jointConfig{iJoint, 2};
isForced = this.GUI.jt.forcedJoints(iJoint, iFrame, iJointType);
isVirtualNotForced = isVirtual & ~isForced;

% use color set of virtual if joint is virtual and not forced placed
if isVirtualNotForced;  v = 4;
else                     v = 0;
end;
    
% draw the joint if required
if get(this.GUI.handles.jt.viewOpts.joints, 'Value');
    
    r = dispSet{1 + v};
    rPos = [pos - r/2, r, r];
    ec = dispSet{2 + v};
    if isForced; ec = dispSet{7}; end;
    
    hold(axeH, 'on');
    rectangle('Parent', axeH, 'Position', rPos, 'EdgeColor', ec, 'FaceColor', dispSet{3 + v}, ...
        'Curvature', dispSet{4 + v}, 'Tag', sprintf('JTJoint_%s_%02d', jointTypeID, iJoint));
    hold(axeH, 'off');
    
end;

% draw the joint joining lines if required and if not currently the first joint
if get(this.GUI.handles.jt.viewOpts.jointLines, 'Value') && iJoint > 1;
    
    % get the position of the previous joint
    posPrevJoint = squeeze(this.jt.joints(iJoint - 1, iFrame, :, iJointType))';
    
    % do not show line if no coordinates or if previous joint is not shown
    if any(posPrevJoint) && any(iJoint - 1 == get(this.GUI.handles.jt.jointSelDispSetter, 'Value'));
        
        hold(axeH, 'on');
        
        % create the line
        h = plot(axeH, [pos(1) posPrevJoint(1)], [pos(2), posPrevJoint(2)], 'Tag', ...
            sprintf('JTJointLine_%s_%02d', jointTypeID, iJoint), 'LineWidth', dispSet{9}, 'Color', dispSet{10});
        set(h, 'LineStyle', dispSet{11}); % set the line style separately
        
        % change the z-level of the line: behind the other handles
        childHands = get(this.GUI.handles.jt.axe, 'Children');
        childHands(end + 1) = childHands(end);
        childHands(childHands == h) = [];
        childHands(end - 1) = h;
        set(this.GUI.handles.jt.axe, 'Children', childHands);
        
        hold(axeH, 'off');
        
    end;
end;

% draw the bounding box if required
bBoxPos = this.GUI.jt.boundBoxPos(iJoint, iFrame, iJointType, :);
if get(this.GUI.handles.jt.viewOpts.boundBoxes, 'Value') && all(bBoxPos);

    dispSet = this.GUI.jt.disp(iJointType, :);
    rectangle('Parent', this.GUI.handles.jt.axe, 'Position', bBoxPos, 'Tag', ...
        sprintf('JTBBox_%s_%02d', this.jt.jointTypes{iJointType, 1}, iJoint), ...
        'LineWidth', dispSet{12}, 'EdgeColor', dispSet{13}, 'LineStyle', dispSet{14});
end;

% draw the joint distances if required
if get(this.GUI.handles.jt.viewOpts.jointDist, 'Value');

%     prevJointDist = 2 * this.jt.jointConfig{iJoint, 4}(1);
%     if ~isnan(prevJointDist);
%         rPos = [pos - prevJointDist / 2, prevJointDist, prevJointDist];
%         rectangle('Parent', this.GUI.handles.jt.axe, 'Position', rPos, 'Curvature', [1, 1], 'Tag', ...
%             sprintf('JTDist_%s_%02d', this.jt.jointTypes{iJointType, 1}, iJoint), ...
%             'LineWidth', 2, 'EdgeColor', iff(mod(iJoint, 2), 'red', 'blue'), 'LineStyle', ':');
%     end;    
    
    nextJointDist = 2 * this.jt.jointConfig{iJoint, 4}(2);
    if ~isnan(nextJointDist);
        rPos = [pos - nextJointDist / 2, nextJointDist, nextJointDist];
        rectangle('Parent', this.GUI.handles.jt.axe, 'Position', rPos, 'Curvature', [1, 1], 'Tag', ...
            sprintf('JTDist_%s_%02d', this.jt.jointTypes{iJointType, 1}, iJoint), ...
            'LineWidth', 2, 'EdgeColor', iff(mod(iJoint, 2), 'blue', 'green'), 'LineStyle', ':');
    end;
end;

% display and save the coordinates
this.jt.joints(iJoint, iFrame, :, iJointType) = pos;
o('#JTPlaceJoint(): joint %d created, coordinates: [%.1f,%.1f].', iJoint, pos, 4, this.verb);

end
