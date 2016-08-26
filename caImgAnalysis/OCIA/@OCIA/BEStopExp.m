function BEStopExp(this, ~, ~)
% BEStopExp - [no description]
%
%       BEStopExp(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% abort behavior looping
if ~isempty(this.GUI.be.loopBehavTimer) && isvalid(this.GUI.be.loopBehavTimer) ...
        && strcmp(this.GUI.be.loopBehavTimer.Running, 'on');
    stop(this.GUI.be.loopBehavTimer);
    delete(this.GUI.be.loopBehavTimer);
    this.GUI.be.loopBehavTimer = [];
end;

if this.be.isRunning;
    this.be.isRunning = false;
    this.be.isToReset = true;
%     this.be.iTrial = 0;
    set(this.GUI.handles.be.pauseExp, 'BackgroundColor', 'red', 'Value', 0);
    set(this.GUI.handles.be.startExp, 'BackgroundColor', 'red', 'Value', 0);
    BESaveOutput(this);
else
    showWarning(this, 'OCIA:Behavior:CannotStopNotRunning', ...
        'Cannot stop because experiment is not running.');
    set(this.GUI.handles.be.pauseExp, 'BackgroundColor', 'red', 'Value', 0);
    set(this.GUI.handles.be.startExp, 'BackgroundColor', 'red', 'Value', 0);
end

end

