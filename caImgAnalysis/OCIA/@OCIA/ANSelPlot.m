function ANSelPlot(this, plotsToSel)
% ANSelPlot - [no description]
%
%       ANSelPlot(this, plotsToSel)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

nPlotTypes = size(get(this.GUI.handles.an.plotList, 'String'), 1);
if ischar(plotsToSel) && strcmp(plotsToSel, 'left');
    selPlots = get(this.GUI.handles.an.plotList, 'Value');
    selPlot = selPlots(1);
    set(this.GUI.handles.an.plotList, 'Value', max(selPlot - 1, 1));
    
elseif ischar(plotsToSel) && strcmp(plotsToSel, 'right');
    selPlots = get(this.GUI.handles.an.plotList, 'Value');
    selPlot = selPlots(end);
    set(this.GUI.handles.an.plotList, 'Value', min(selPlot + 1, nPlotTypes));
    
elseif isnumeric(plotsToSel);
    set(this.GUI.handles.an.plotList, 'Value', plotsToSel(plotsToSel >= 1 && runstoSel <= nPlotTypes));
    
else
    showWarning(this, 'OCIA:ANSelPlot:InvalidCommand', sprintf('Unknown command: %s', plotsToSel));
    
end;

ANUpdatePlot(this);

end
