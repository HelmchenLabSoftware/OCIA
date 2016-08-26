function INActivatePan(this, h, ~)
% INActivatePan - [no description]
%
%       INActivatePan(this, h, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

o('#INActivatePan()', 4, this.verb);
if this.GUI.handles.in.pTool ~= h; % if change was requested by a input value
    panState = h;
    set(this.GUI.handles.in.pTool, 'Value', panState);
else % if change was requested by the callback
    panState = get(this.GUI.handles.in.pTool, 'Value');
end;

if panState;
    INActivateZoom(this, 0); % make sure zoom is no longer active
    hPan = pan(this.GUI.figH);
    hCMP = uicontextmenu('Parent', this.GUI.figH);
    uimenu('Parent', hCMP, 'Label', 'Stop pan', 'Callback', @(~, ~)INActivatePan(this, 0));
    set(hPan, 'UIContextMenu', hCMP);
    set(hPan, 'Enable', 'on');
    showMessage(this, 'Pan tool on (Intrinsic)');
else
    pan(this.GUI.figH, 'off');
    % delete the context menu object
    try delete(get(pan(this.GUI.figH), 'UIContextMenu')); catch; end;
    showMessage(this, 'Pan tool off (Intrinsic)', 'yellow');
end;

end