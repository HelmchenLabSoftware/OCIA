function ANSelRuns(this, runsToSel)
% ANSelRuns - [no description]
%
%       ANSelRuns(this, runsToSel)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

nRuns = size(get(this.GUI.handles.an.rowList, 'String'), 1);
if ischar(runsToSel) && strcmp(runsToSel, 'all');
    set(this.GUI.handles.an.rowList, 'Value', 1 : nRuns);
elseif ischar(runsToSel) && strcmp(runsToSel, 'none');
    set(this.GUI.handles.an.rowList, 'Value', []);
elseif ischar(runsToSel) && strcmp(runsToSel, 'up');
    selRuns = get(this.GUI.handles.an.rowList, 'Value');
    selRun = selRuns(1);
    set(this.GUI.handles.an.rowList, 'Value', max(selRun - 1, 1));
elseif ischar(runsToSel) && strcmp(runsToSel, 'down');
    selRuns = get(this.GUI.handles.an.rowList, 'Value');
    selRun = selRuns(end);
    set(this.GUI.handles.an.rowList, 'Value', min(selRun + 1, nRuns));
elseif isnumeric(runsToSel);
    set(this.GUI.handles.an.rowList, 'Value', runsToSel(runsToSel >= 1 && runsToSel <= nRuns));
else
    showWarning(this, 'OCIA:ANSelRuns:InvalidCommand', sprintf('Unknown command: %s', runsToSel));
end;

ANUpdatePlot(this);

end
