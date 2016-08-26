function ANActivatePan(this, h, ~)
% ANActivatePan - [no description]
%
%       ANActivatePan(this, h, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

o('#ANActivatePan()', 4, this.verb);
if this.GUI.handles.an.pTool ~= h; % if change was requested by a input value
    panState = h;
    set(this.GUI.handles.an.pTool, 'Value', panState);
else % if change was requested by the callback
    panState = get(this.GUI.handles.an.pTool, 'Value');
end;

if panState;
    ANActivateZoom(this, 0); % make sure zoom is no longer active
    hPan = pan(this.GUI.figH);
    hCMP = uicontextmenu('Parent', this.GUI.figH);
    uimenu('Parent', hCMP, 'Label', 'Stop pan', 'Callback', @(~, ~)ANActivatePan(this, 0));
    set(hPan, 'UIContextMenu', hCMP);
    set(hPan, 'Enable', 'on');
    showMessage(this, 'Pan tool on (Analyser)');
else
    pan(this.GUI.figH, 'off');
    % delete the context menu object
    try delete(get(pan(this.GUI.figH), 'UIContextMenu')); catch; end;
    showMessage(this, 'Pan tool off (Analyser)', 'yellow');
end;

end