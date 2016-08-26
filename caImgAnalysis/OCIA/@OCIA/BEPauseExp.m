function BEPauseExp(this, ~, ~)
% BEPauseExp - [no description]
%
%       BEPauseExp(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

    if this.be.isRunning;
        if this.be.isPaused;
            this.be.isPaused = false;
            set(this.GUI.handles.be.pauseExp, 'BackgroundColor', 'green', 'Value', 0);
            set(this.GUI.handles.be.startExp, 'BackgroundColor', 'green', 'Value', 1);
        else
            this.be.isPaused = true;
            set(this.GUI.handles.be.pauseExp, 'BackgroundColor', 'yellow', 'Value', 1);
            set(this.GUI.handles.be.startExp, 'BackgroundColor', 'yellow', 'Value', 1);
        end;

    else
        showWarning(this, 'OCIA:Behavior:CannotPauseNotRunning', ...
            'Cannot pause because experiment is not running.');
        set(this.GUI.handles.be.pauseExp, 'BackgroundColor', 'red', 'Value', 0);
        set(this.GUI.handles.be.startExp, 'BackgroundColor', 'red', 'Value', 0);
    end;
    
end
