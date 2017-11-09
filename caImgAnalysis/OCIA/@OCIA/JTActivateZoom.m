function JTActivateZoom(this, h, ~)
% JTActivateZoom - [no description]
%
%       JTActivateZoom(this, h, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

o('#JTActivateZoom()', 4, this.verb);

% if change was requested by a input value, set the state to the input
if this.GUI.handles.jt.zTool ~= h;
    zoomState = h;
    set(this.GUI.handles.jt.zTool, 'Value', zoomState);
% if change was requested by the callback, get the value from the GUI element
else
    zoomState = get(this.GUI.handles.jt.zTool, 'Value');
end;


% if zoom should be activated
if zoomState;
    JTActivatePan(this, 0); % make sure pan is no longer active
    % get the zoom handler
    hZoom = zoom(this.GUI.handles.jt.axe);
    % create a context menu on the figure to remove the zoom
    hCMZ = uicontextmenu('Parent', this.GUI.figH);
    uimenu('Parent', hCMZ, 'Label', 'Stop zoom', 'Callback', @(~, ~)JTActivateZoom(this, 0));
    % set the context menu on the zoom handler
    set(hZoom, 'UIContextMenu', hCMZ);
    % actiavte the zoom and show a message
    set(hZoom, 'Enable', 'on');
    showMessage(this, 'Zoom enabled for JointTracker.');
% if zoom should be de-activated
else
    zoom(this.GUI.handles.jt.axe, 'off');
    showMessage(this, 'Zoom disabled for JointTracker.', 'yellow');
    if ~isempty(h) && ~ischar(h) && ishandle(h); uicontrol(this.GUI.handles.jt.frameSetter); end;
end;

end
