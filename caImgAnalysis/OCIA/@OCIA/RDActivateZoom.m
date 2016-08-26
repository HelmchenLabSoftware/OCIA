function RDActivateZoom(this, h, ~)
% RDActivateZoom - [no description]
%
%       RDActivateZoom(this, h, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

o('#RDActivateZoom()', 4, this.verb);

% if change was requested by a input value, set the state to the input
if this.GUI.handles.rd.zTool ~= h;
    zoomState = h;
    set(this.GUI.handles.rd.zTool, 'Value', zoomState);
% if change was requested by the callback, get the value from the GUI element
else
    zoomState = get(this.GUI.handles.rd.zTool, 'Value');
end;

% if zoom should be activated
if zoomState;
    RDActivatePan(this, 0); % make sure pan is no longer active
    % get the zoom handler
    hZoom = zoom(this.GUI.handles.rd.axe);
    % create a context menu on the figure to remove the zoom
    hCMZ = uicontextmenu('Parent', this.GUI.figH);
    uimenu('Parent', hCMZ, 'Label', 'Stop zoom', 'Callback', @(~, ~)RDActivateZoom(this, 0));
    % set the context menu on the zoom handler and add an callback for the change in zoom
    set(hZoom, 'UIContextMenu', hCMZ, 'ActionPostCallback', @(~, ~)RDZoomChanged(this));
    % actiavte the zoom and show a message
    set(hZoom, 'Enable', 'on');
    showMessage(this, 'Zoom enabled for ROIDrawer.');
% if zoom should be de-activated
else
    zoom(this.GUI.handles.rd.axe, 'off');
    % delete the context menu object
    try delete(get(zoom(this.GUI.handles.rd.axe), 'UIContextMenu')); catch; end;
    showMessage(this, 'Zoom disabled for ROIDrawer.', 'yellow');
end;

end
