function JTActivatePan(this, h, ~)
% JTActivatePan - [no description]
%
%       JTActivatePan(this, h, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
    
o('#JTActivatePan()', 4, this.verb);
if this.GUI.handles.jt.pTool ~= h; % if change was requested by a input value
    panState = h;
    set(this.GUI.handles.jt.pTool, 'Value', panState);
else % if change was requested by the callback
    panState = get(this.GUI.handles.jt.pTool, 'Value');
end;
    
if panState;
    JTActivateZoom(this, 0); % make sure zoom is no longer active
    hPan = pan(this.GUI.figH);
    hCMP = uicontextmenu('Parent', this.GUI.figH);
    uimenu('Parent', hCMP, 'Label', 'Stop pan', 'Callback', @(~, ~)JTActivatePan(this, 0));
    set(hPan, 'UIContextMenu', hCMP);
    set(hPan, 'Enable', 'on');
    showMessage(this, 'Pan tool on (JointTracker)');
else
    pan(this.GUI.figH, 'off');
    showMessage(this, 'Pan tool off (JointTracker)', 'yellow');
end;

end
