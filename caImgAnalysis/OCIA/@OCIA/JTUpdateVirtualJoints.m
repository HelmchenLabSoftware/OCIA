function JTUpdateVirtualJoints(this, iFrame, iJointType)
% JTUpdateVirtualJoints - [no description]
%
%       JTUpdateVirtualJoints(this, iFrame, iJointType)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% show debug plots of virtual joints
showDebugPlot = 0;

% get the joints' x coordinate
joints = squeeze(this.jt.joints(:, iFrame, 1, iJointType));

% loop through the joint handles
for iJoint = 1 : this.jt.nJoints;
    
    % if a joint coordinate is empty and it is a virtual joint and the previous and next coordinates are not empty,
    %   get the virtual joint's coordinates
    if joints(iJoint) == 0 && this.jt.jointConfig{iJoint, 2} ...
            && joints(iJoint - 1) ~= 0 && joints(iJoint + 1) ~= 0;

        jointCoords = squeeze(this.jt.joints(:, iFrame, :, iJointType));
        p1 = jointCoords(iJoint - 1, :); % coordinates of the joint before
        p2 = jointCoords(iJoint + 1, :); % coordinates of the joint after
        r1 = this.jt.jointConfig{iJoint, 4}(1); % distance with the joint before
        r2 = this.jt.jointConfig{iJoint, 4}(2); % distance with the joint after

        o(['#JTUpdateVirtualJoints: trying to predict virtual joint %d with: p1: [%.1f,%.1f], p2: [%.1f,%.1f], ', ...
            'd1: %.1f, d2: %.1f ...'], iJoint, p1, p2, r1, r2, 4, this.verb);

        % iteratively try to find the interesection point with increasing distances
        increaseStepR1 = r1 * 0.05; increaseStepR2 = r2 * 0.05; iLoop = 1; nMaxLoop = 10;
        intersects = {}; % default is empty
        while isempty(intersects) && iLoop < nMaxLoop;
            
            % try to get the joints
            [cx1, cy1, cx2, cy2, intersects] = calcVirtJoint(p1(1), p1(2), p2(1), p2(2), r1, r2); %#ok<ASGLU>
            
            % if there is going to be another loop, increase distances
            if isempty(intersects) && iLoop < nMaxLoop;
                r1 = r1 + increaseStepR1;
                r2 = r2 + increaseStepR2;
                iLoop = iLoop + 1;
            end;
            
        end; % end while loop
        
        % show debug informations
        if showDebugPlot;
            
            axeH = this.GUI.handles.jt.axe; %#ok<UNRCH>
            hold(axeH, 'on');
            
            % show the intersection circles
            commonArgs = {'FaceColor', 'none', 'EdgeColor', [0.3 1 0], 'Curvature', [1, 1]};
            rectangle('Parent', axeH, 'Position', [a - r1 b - r1 2 * r1 2 * r1], commonArgs{:});
            rectangle('Parent', axeH, 'Position', [c - r2 d - r2 2 * r2 2 * r2], commonArgs{:});
            
            % show the possible points
            r = 4;
            commonArgs = {'FaceColor', [0 0 1], 'EdgeColor', [0 0 1], 'Curvature', [1, 1]};
            rectangle('Parent', axeH, 'Position', [cx1 - r/2 cy1 - r/2 r r], commonArgs{:});
            rectangle('Parent', axeH, 'Position', [cx2 - r/2 cy2 - r/2 r r], commonArgs{:});
            
            hold(axeH, 'off');
            
        end;
        
        if isempty(intersects);
            o('#JTUpdateVirtualJoints: virtual joint %d could not be placed (iLoop: %d).', iJoint, iLoop, 2, this.verb);
            showWarning(this, 'OCIA:JT:JTUpdateVirtualJoints:VirtualJointImpossible', ...
                sprintf(['Impossible to get a virtual joint for joint %d with the distances: ', ...
                '%.1f and %.1f and coordinates: [%.1f,%.1f] and [%.1f,%.1f]!'], iJoint, r1, r2, p1, p2));
            % clear the joint coordinates
            this.jt.joints(iJoint, iFrame, :, iJointType) = [0 0];
        else
            o('#JTUpdateVirtualJoints: virtual joint %d is either at: c1 [%.1f,%.1f] or c2 [%.1f,%.1f] (iLoop: %d).', ...
                iJoint, intersects{1}, intersects{2}, iLoop, 3, this.verb);
            % save the joint coordinates
            this.jt.joints(iJoint, iFrame, :, iJointType) = intersects{1}; % hard coded, always the first intersect
        end;

    end; % end of virtual joint if condition
    
end; % end of joint looping

end

% little functino to find the virtual joint by calculating the intersecitno of two circles
function [cx1, cy1, cx2, cy2, intersects] = calcVirtJoint(a, b, c, d, r1, r2)

    cx1 = NaN; cy1 = NaN; cx2 = NaN; cy2 = NaN; intersects = {};

    % Finding the coordinates c (c1,c2) of the virtual joint is basically finding the intersection of two 
    % circles centered on p1 (a,b) and p2 (c,d) with respective radius r1 and r2:
    %
    %   (x - a)^2 + (y - b)^2 = r1^2    AND     (x - c)^2 + (y - d)^2 = r2^2
    %
    % First express the distance D between the two circles :
    D = sqrt((c - a)^2 + (d - b)^2);

    % Inter sections only happen if:
    %
    %   r1 + r2 > D                     AND     D > |r1 - r2|
    %

    % check for intersection
    circlesIntersect = r1 + r2 >= D && D > abs(r1 - r2);
    if ~circlesIntersect;
        return;
    end;

    % To get the coordinates, first express gamma :            
    gamma = 0.25 * sqrt((D + r1 + r2) * (D + r1 - r2) * (D - r1 + r2) * (-D + r1 + r2));

    % Then the coordinates can be calculated with :
    cx1 = ((a + c) / 2) + (((c - a) * (r1^2 - r2^2)) / (2 * D^2)) + ((2 * gamma * (b - d)) / D^2);
    cx2 = ((a + c) / 2) + (((c - a) * (r1^2 - r2^2)) / (2 * D^2)) - ((2 * gamma * (b - d)) / D^2);
    cy1 = ((b + d) / 2) + (((d - b) * (r1^2 - r2^2)) / (2 * D^2)) - ((2 * gamma * (a - c)) / D^2);
    cy2 = ((b + d) / 2) + (((d - b) * (r1^2 - r2^2)) / (2 * D^2)) + ((2 * gamma * (a - c)) / D^2);

    % The intersection points are then:
    intersects = {[cx1, cy1]; [cx2, cy2]};

end
