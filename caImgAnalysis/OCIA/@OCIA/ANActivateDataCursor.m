function ANActivateDataCursor(this, h, ~)
% ANActivateDataCursor - [no description]
%
%       ANActivateDataCursor(this, h, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

o('#ANActivateDataCursor()', 4, this.verb);
if this.GUI.handles.an.cTool ~= h; % if change was requested by a input value
    cursorState = h;
    set(this.GUI.handles.an.cTool, 'Value', cursorState);
else % if change was requested by the callback
    cursorState = get(this.GUI.handles.an.cTool, 'Value');
end;

if cursorState;
    ANActivateZoom(this, 0); % make sure zoom is no longer active
    ANActivatePan(this, 0); % make sure zoom is no longer active
    hDataCurs = datacursormode(this.GUI.figH);
    set(hDataCurs, 'Enable', 'on');
    showMessage(this, 'Data cursor on (Analyser)');
else
    datacursormode(this.GUI.figH);
    showMessage(this, 'Data cursor off (Analyser)', 'yellow');
end;

end