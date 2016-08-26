function ANShowHideMessage(this, doShowMessage, varargin)
% ANShowHideMessage - [no description]
%
%       ANShowHideMessage(this, doShowMessage, varargin)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if doShowMessage;
    txt = 'Loading ...';
    if nargin > 2; txt = varargin{1}; end;
    % if there is a GUI
    if isGUI(this);
        % show the message and hide the axes
        if ishandle(this.GUI.handles.an.axe); set(this.GUI.handles.an.axe, 'Visible', 'off'); end;
        set(this.GUI.handles.an.message, 'String', txt, 'Visible', 'on');
    % if there is no GUI, only set the string
    else
        set(this.GUI.handles.an.message, 'String', txt);
    end;
    showMessage(this, sprintf('Analyser: %s', txt));
else
    txt = 'Loading done.';
    if nargin > 2; txt = varargin{1}; end;
    % if there is a GUI, show the axes
    if isGUI(this);
        set(this.GUI.handles.an.message, 'String', txt, 'Visible', 'off');
        if ishandle(this.GUI.handles.an.axe); set(this.GUI.handles.an.axe, 'Visible', 'on'); end;
    % if there is no GUI, only set the string
    else
        set(this.GUI.handles.an.message, 'String', txt);
    end;
    showMessage(this, sprintf('Analyser: %s', txt));
end;

pause(0.1); % required to let the GUI update itself

end
