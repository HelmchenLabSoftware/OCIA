function JTShowInfo(this, varargin)
% JTShowInfo - [no description]
%
%       JTShowInfo(this, varargin)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
% display informations about the joints

jointConf = this.jt.jointConfig;
iJointType = this.GUI.jt.iJointType(1);
selectedJoints = this.GUI.jt.iJoint;
nSelJoints = numel(selectedJoints);
    
close(findobj('Tag', 'JTInfoPlots'));
if any(this.jt.joints(:, :, :, iJointType));
    
    % get subplot indices
    N = ceil(sqrt(nSelJoints)); M = N; while nSelJoints && (M - 1) * N >= nSelJoints; M = M - 1; end;
    
    %{
    % get maximum distance traveled by each joint from one frame to the next for each coordinate
    diffCoords = diff(squeeze(this.jt.joints(:, :, :, iJointType)), [], 2);
    maxCoordDiff = squeeze(max(diffCoords, [], 2));
    avgCoordDiff = squeeze(nanmean(diffCoords, 2));
    stdCoordDiff = squeeze(nanstd(diffCoords, [], 2));
    
    % get distances between joints
    jointTravelDists = zeros(this.jt.nJoints, this.jt.nFrames - 1);
    for iJoint = 1 : this.jt.nJoints - 1;
        if ~any(iJoint == selectedJoints); continue; end;
        for iFrame = 1 : this.jt.nFrames - 1;
            f1 = squeeze(this.jt.joints(iJoint, iFrame, :, iJointType));
            f2 = squeeze(this.jt.joints(iJoint, iFrame + 1, :, iJointType));
            jointTravelDists(iJoint, iFrame) = dist(f1', f2);
        end;
    end;
    maxJointTravelDists = max(jointTravelDists, [], 2);
    avgJointTravelDists = nanmean(jointTravelDists, 2);
    stdJointTravelDists = nanstd(jointTravelDists, [], 2);
    
    showMessage(this, sprintf('Distance differences %d joints with %d frames:', this.jt.nJoints, this.jt.nFrames));
    fMovXY = figure('Name', 'Movement on XY for each joint', 'NumberTitle', 'off', 'Tag', 'JTInfoPlots');
    fMovDistribXY = figure('Name', 'Movement distributions on XY for each joint', 'NumberTitle', 'off', 'Tag', 'JTInfoPlots');
    for iJoint = 1 : this.jt.nJoints;
        
        if ~any(iJoint == selectedJoints); continue; end;
        showMessage(this, sprintf(' - %-10s (%d): max.: distance: %.2f, X: %.2f, Y: %.2f.', ...
            jointConf{iJoint, 1}, iJoint, maxJointTravelDists(iJoint), maxCoordDiff(iJoint, 1), ...
            maxCoordDiff(iJoint, 2)));
        showMessage(this, sprintf(' - %-10s (%d): avg.: distance: %.2f +- %.2f, X: %.2f +- %.2f, Y: %.2f +- %.2f.', ...
            jointConf{iJoint, 1}, iJoint, avgJointTravelDists(iJoint), stdJointTravelDists(iJoint), ...
            avgCoordDiff(iJoint, 1), stdCoordDiff(iJoint, 1), avgCoordDiff(iJoint, 2), stdCoordDiff(iJoint, 2)));
        
        % plot movements for each frame
        figure(fMovXY);
        subplot(M, N, find(iJoint == selectedJoints));
        plot(squeeze(diffCoords(iJoint, :, :)));
        title(jointConf{iJoint, 1});
        
        % plot distribution of the movement on XY
        figure(fMovDistribXY);
        subplot(M, N, find(iJoint == selectedJoints));
        hist(squeeze(diffCoords(iJoint, :, :)), 2 * sqrt(this.jt.nFrames));
        title(jointConf{iJoint, 1});
        
    end;
    showMessage(this, 'Consider using at least the double of these distances as bounding boxes.');
    
    % get distances between joints
    jointDists = zeros(this.jt.nJoints - 1, this.jt.nFrames);
    for iJoint = 1 : this.jt.nJoints - 1;
        if ~any(iJoint == selectedJoints); continue; end;
        j1 = squeeze(this.jt.joints(iJoint, :, :, iJointType));
        j2 = squeeze(this.jt.joints(iJoint + 1, :, :, iJointType));
        jointDists(iJoint, :) = arrayfun(@(iFrame) dist(j1(iFrame, :), j2(iFrame, :)'), 1 : this.jt.nFrames);
    end;
    avgJointDists = nanmean(jointDists, 2);
    stdJointDists = nanstd(jointDists, [], 2);
    
    showMessage(this, sprintf('Average joint distance for %d joints on %d frames:', this.jt.nJoints, this.jt.nFrames));
    figInterJointDist = figure('Name', 'Distances distributions for each joint', 'NumberTitle', 'off', 'Tag', 'JTInfoPlots');
    for iJoint = 1 : this.jt.nJoints - 1;
        if ~any(iJoint == selectedJoints); continue; end;
        showMessage(this, sprintf(' - %-10s (%d) <-> %-10s (%d) : %.2f +- %.2f pixels.', ...
            jointConf{iJoint, 1}, iJoint, jointConf{iJoint + 1, 1}, iJoint + 1, ...
            avgJointDists(iJoint), stdJointDists(iJoint)));
        
        % plot distribution
        figure(figInterJointDist);
        subplot(M, N, find(iJoint == selectedJoints));
        hist(squeeze(jointDists(iJoint, :)), 2 * sqrt(this.jt.nFrames));
        title(sprintf('%s (%d) <-> %s (%d)', jointConf{iJoint, 1}, iJoint, ...
            jointConf{iJoint + 1, 1}, iJoint + 1));
    end;
    showMessage(this, 'Consider using these joint distances for the constraints.');
    %}
    
    % get angles between joints
    jointAngles = JTGetJointAngles(this, selectedJoints, 1 : this.jt.nFrames, iJointType);
    avgJointAngles = nanmean(jointAngles, 2);
    stdJointAngles = nanstd(jointAngles, [], 2);
    
    showMessage(this, sprintf('Average joint angles for %d joints on %d frames:', this.jt.nJoints, this.jt.nFrames));
    figAngleFrames = figure('Name', 'Angle for each frame for each joint', 'NumberTitle', 'off', 'Tag', 'JTInfoPlots');
    figAngleDiffFrames = figure('Name', 'Angle difference for each frame for each joint', 'NumberTitle', 'off', 'Tag', 'JTInfoPlots');
    figAngleDist = figure('Name', 'Angle distributions for each joint', 'NumberTitle', 'off', 'Tag', 'JTInfoPlots');
    for iJoint = 1 : this.jt.nJoints;
        if ~any(iJoint == selectedJoints); continue; end;
        if iJoint == 1;
            showMessage(this, sprintf(' - %-10s (%d) <-> %-10s (%d) and horizontal: %.2f +- %.2f pixels.', ...
                jointConf{iJoint, 1}, iJoint, jointConf{iJoint + 1, 1}, iJoint + 1, ...
                avgJointAngles(iJoint), stdJointAngles(iJoint)));
        elseif iJoint == this.jt.nJoints;
            showMessage(this, sprintf(' - %-10s (%d) <-> %-10s (%d) and horizontal : %.2f +- %.2f pixels.', ...
                jointConf{iJoint - 1, 1}, iJoint - 1, jointConf{iJoint, 1}, iJoint, ...
                avgJointAngles(iJoint), stdJointAngles(iJoint)));
        else
            showMessage(this, sprintf(' - %-10s (%d) <-> %-10s (%d) <-> %-10s (%d) : %.2f +- %.2f pixels.', ...
                jointConf{iJoint - 1, 1}, iJoint - 1, jointConf{iJoint, 1}, iJoint, jointConf{iJoint + 1, 1}, iJoint + 1, ...
                avgJointAngles(iJoint), stdJointAngles(iJoint)));
        end;
        
        % plot angles for each frame
        figure(figAngleFrames);
        subplot(M, N, find(iJoint == selectedJoints));
        plot(squeeze(jointAngles(iJoint, :)));
        title(jointConf{iJoint, 1});
        
        % plot angles for each frame
        figure(figAngleDiffFrames);
        subplot(M, N, find(iJoint == selectedJoints));
        plot(diff(squeeze(jointAngles(iJoint, :))));
        title(jointConf{iJoint, 1});
        
        % plot distribution of the angles
        figure(figAngleDist);
        subplot(M, N, find(iJoint == selectedJoints));
        hist(squeeze(jointAngles(iJoint, :)), 2 * sqrt(this.jt.nFrames));
        title(sprintf('%s (%d)', jointConf{iJoint, 1}, iJoint));
    end;
    showMessage(this, 'Consider using these joint distances for the constraints.');
    
    tilefigs();
    
end;

% set the focus to the frame setter if the call was from a GUI element
if numel(varargin); uicontrol(this.GUI.handles.jt.frameSetter); end;

end
