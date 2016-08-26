function JTManualTrackStart(this, varargin)
% JTManualTrackStart - [no description]
%
%       JTManualTrackStart(this, varargin)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if get(this.GUI.handles.jt.manuTrack, 'Value');
    
    % no joint selected
    if isempty(this.GUI.jt.iJoint);
        
        % reset the counters
        this.GUI.jt.startFrame = [];
        this.GUI.jt.endFrame = [];
        this.GUI.jt.startTime = [];
    
        showWarning(this, 'OCIA:JT:JTManualTrackStart:NoJointSelected', 'No joints selected!');
        set(this.GUI.handles.jt.manuTrack, 'Value', 0);
        
    % some joint selected, start tracking
    else
    
        % set the counters
        this.GUI.jt.startFrame = this.GUI.jt.iFrame;
        this.GUI.jt.startTime = tic;

        % restrict to first joint
        if numel(this.GUI.jt.iJoint) > 1;d
            this.GUI.jt.iJoint = this.GUI.jt.iJoint(1);
            set(this.GUI.handles.jt.joinSelSetter, 'Value', this.GUI.jt.iJoint);
        end;aa
        this.GUI.jt.placeJointIndex = this.GUI.jt.iJoint;
        showMessage(this, sprintf('Started manually tracking joint %s (%d).', ...
            this.jt.jointConfig{this.GUI.jt.iJoint, 1}, this.GUI.jt.iJoint), 'yellow');
    end;

% joint tracking disabled
else
    nFramesTracked = this.GUI.jt.iFrame - this.GUI.jt.startFrame;
    if nFramesTracked > 0;
        timeTracked = toc(this.GUI.jt.startTime);
        showMessage(this, sprintf('Stopped manual tracking of joints (%d frames in %.1f seconds, %.1f frames/sec).', ...
            nFramesTracked, timeTracked, nFramesTracked / timeTracked));
    else
        showMessage(this, 'Manual tracking disabled.', 'yellow');
    end;
    
    % reset the counters
    this.GUI.jt.startFrame = [];
    this.GUI.jt.endFrame = [];
    this.GUI.jt.startTime = [];
end;

% set the focus to the frame setter if the call was from a GUI element
if numel(varargin); uicontrol(this.GUI.handles.jt.frameSetter); end;

end
