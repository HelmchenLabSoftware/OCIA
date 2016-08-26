function INActivateDataCursor(this, h, ~)
% INActivateDataCursor - [no description]
%
%       INActivateDataCursor(this, h, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

o('#INActivateDataCursor()', 4, this.verb);
if this.GUI.handles.in.cTool ~= h; % if change was requested by a input value
    cursorState = h;
    set(this.GUI.handles.in.cTool, 'Value', cursorState);
else % if change was requested by the callback
    cursorState = get(this.GUI.handles.in.cTool, 'Value');
end;

if cursorState;
    INActivateZoom(this, 0); % make sure zoom is no longer active
    INActivatePan(this, 0); % make sure zoom is no longer active
    hDataCurs = datacursormode(this.GUI.figH);
    set(hDataCurs, 'Enable', 'on');
    showMessage(this, 'Data cursor on (Intrinsic)');
else
    datacursormode(this.GUI.figH);
    showMessage(this, 'Data cursor off (Intrinsic)', 'yellow');
end;

end