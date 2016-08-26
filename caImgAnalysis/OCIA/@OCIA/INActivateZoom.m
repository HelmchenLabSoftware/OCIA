function INActivateZoom(this, h, ~)
% INActivateZoom - [no description]
%
%       INActivateZoom(this, h, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

o('#INActivateZoom()', 4, this.verb);

if this.GUI.handles.in.zTool ~= h; % if change was requested by a input value
    zoomState = h;
    set(this.GUI.handles.in.zTool, 'Value', zoomState);
else % if change was requested by the callback
    zoomState = get(this.GUI.handles.in.zTool, 'Value');
end;

% if zoom should be activated
if zoomState;
    INActivatePan(this, 0); % make sure pan is no longer active
    % get the zoom handler
    hZoom = zoom(this.GUI.handles.in.refAxe);
    % create a context menu on the figure to remove the zoom
    hCMZ = uicontextmenu('Parent', this.GUI.figH);
    uimenu('Parent', hCMZ, 'Label', 'Stop zoom', 'Callback', @(~, ~)INActivateZoom(this, 0));
    % set the context menu on the zoom handler
    set(hZoom, 'UIContextMenu', hCMZ);
    % actiavte the zoom and show a message
    set(hZoom, 'Enable', 'on');
    showMessage(this, 'Zoom enabled for Intrinsic.');
% if zoom should be de-activated
else
    zoom(this.GUI.handles.in.refAxe, 'off');
    % delete the context menu object
    try delete(get(zoom(this.GUI.handles.in.refAxe), 'UIContextMenu')); catch; end;
    showMessage(this, 'Zoom disabled for Intrinsic.', 'yellow');
end;

end
