function JTChangeFrame(this, ~, e)
% JTChangeFrame - [no description]
%
%       JTChangeFrame(this, ~, e)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

    totTic = tic; % for performance timing purposes
    iFrameSetter = round(get(this.GUI.handles.jt.frameSetter, 'Value'));
    o('#JTChangeFrame: GUI iFrame: %d, frameSetter: %.1f, auto-track: %d ...', this.GUI.jt.iFrame, iFrameSetter, ...
        get(this.GUI.handles.jt.autoTrack, 'Value'), 4, this.verb);
    
    % if no frame number is set, abort
    if iFrameSetter == 0;
        return;
    % get the new frame's java mouse wheel event
    elseif exist('e', 'var') && ~isempty(e) && isa(e, 'java.awt.event.MouseWheelEvent');
        iFrame = this.GUI.jt.iFrame - get(e, 'wheelRotation'); % use minus to have the right direction
        iFrame = min(max(iFrame, 1), this.jt.nFrames);
        set(this.GUI.handles.jt.frameSetter, 'Value', iFrame);
    % do not do anything if the frame is already right
    elseif this.GUI.jt.iFrame == iFrameSetter;
        return;
    else
        iFrame = iFrameSetter;
    end;
    
    % enforce the joints tracked automatically from the previous frame if they are not empty
    if this.GUI.jt.iFrame < iFrame && get(this.GUI.handles.jt.autoTrack, 'Value') ...
            && all(this.jt.joints(this.GUI.jt.iJoint, this.GUI.jt.iFrame, this.GUI.jt.iJointType));
        this.GUI.jt.forcedJoints(this.GUI.jt.iJoint, this.GUI.jt.iFrame, this.GUI.jt.iJointType) = 1;
        
    % remove the enforcement of the joints tracked automatically from the previous frame if we went backwards
    elseif this.GUI.jt.iFrame > iFrame && get(this.GUI.handles.jt.autoTrack, 'Value');
        this.GUI.jt.forcedJoints(this.GUI.jt.iJoint, this.GUI.jt.iFrame : this.jt.nFrames, this.GUI.jt.iJointType) = 0;
    end;
    
    % update the frame label
    currTimeTotSec = iFrame / this.jt.frameRate;
    currTimeMin = floor(currTimeTotSec / 60);
    currTimeSec = floor(currTimeTotSec - currTimeMin * 60);
    currTimeMSec = floor((currTimeTotSec - currTimeMin * 60 - currTimeSec) * 1000);
    set(this.GUI.handles.jt.frameLabel, 'String', sprintf('F  %03d\nT  %02d:%02d.%03d\nM %04d %04d', ...
        iFrame, currTimeMin, currTimeSec, currTimeMSec, this.GUI.jt.mouseCoords));

    % if we moved forward and the manual tracking was on when the frame was changed, label the joint
    if this.GUI.jt.iFrame < iFrame && get(this.GUI.handles.jt.manuTrack, 'Value');
        pos = get(this.GUI.figH, 'CurrentPoint');
        pos = pos(1, 1 : 2);
        o('#JTChangeFrame: placing joint (started on frame %d) to %d, pos: [%.1f,%.1f] ...', ...
            this.GUI.jt.startFrame, iFrame, pos, 3, this.verb);
        JTImClick(this);
    end;
    
    % change the current frame
    this.GUI.jt.iFrame = iFrame;
    
    % move validity frame indicator bar
    set(this.GUI.handles.jt.validityFrameIndicator, 'XData', [iFrame, iFrame]);
        
    % refresh the joints' display
    JTUpdateGUI(this, 'all');
    
    % if in auto-track mode, process a single frame
    if get(this.GUI.handles.jt.autoTrack, 'Value');
        JTProcess(this, 'single');
    end;
    
    o('#JTChangeFrame: changed to frame %d (%.4f sec).', iFrame, toc(totTic), 3, this.verb);
end
