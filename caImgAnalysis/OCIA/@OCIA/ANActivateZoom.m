function ANActivateZoom(this, h, ~)
% ANActivateZoom - [no description]
%
%       ANActivateZoom(this, h, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

o('#ANActivateZoom()', 4, this.verb);

if this.GUI.handles.an.zTool ~= h; % if change was requested by a input value
    zoomState = h;
    set(this.GUI.handles.an.zTool, 'Value', zoomState);
else % if change was requested by the callback
    zoomState = get(this.GUI.handles.an.zTool, 'Value');
end;

% if zoom should be activated
if zoomState;
    ANActivatePan(this, 0); % make sure pan is no longer active
    % get the zoom handler
    hZoom = zoom(this.GUI.handles.an.axe);
    % create a context menu on the figure to remove the zoom
    hCMZ = uicontextmenu('Parent', this.GUI.figH);
    uimenu('Parent', hCMZ, 'Label', 'Stop zoom', 'Callback', @(~, ~)ANActivateZoom(this, 0));
    % set the context menu on the zoom handler
    set(hZoom, 'UIContextMenu', hCMZ);
    % actiavte the zoom and show a message
    set(hZoom, 'Enable', 'on');
    showMessage(this, 'Zoom enabled for Analyser.');
% if zoom should be de-activated
else
    zoom(this.GUI.handles.an.axe, 'off');
    % delete the context menu object
    try delete(get(zoom(this.GUI.handles.an.axe), 'UIContextMenu')); catch; end;
    showMessage(this, 'Zoom disabled for Analyser.', 'yellow');
end;

end
