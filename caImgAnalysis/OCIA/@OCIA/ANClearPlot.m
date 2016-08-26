function ANClearPlot(this)
% ANClearPlot - [no description]
%
%       ANClearPlot(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

anAxe = this.GUI.handles.an.axe;
anPanelChild = get(this.GUI.handles.panels.AnalyserPanel, 'Children');

% remove everything that doesn't belong to the Analyser panel
anPanelChild(~cellfun(@isempty, regexp(get(anPanelChild, 'Tag'), '^AN'))) = [];
anPanelChild(anPanelChild == anAxe) = [];
delete(anPanelChild); % delete unwanted objects
if ishandle(anAxe);
    delete(get(anAxe, 'Children')); % delete previous data of the analyser axes
    oldAxePos = get(this.GUI.handles.an.axe, 'Position');
    delete(anAxe);
else
    oldAxePos = [0 0 1 1];
end;

% re-create the axe
this.GUI.handles.an.axe = axes('Parent', this.GUI.handles.panels.AnalyserPanel, 'Units', 'normalized', ...
    'Tag', 'ANAxe', 'Color', 'white', 'Position', oldAxePos);

% clear the parameters area
delete(get(this.GUI.handles.an.paramPan, 'Children'));
this.GUI.handles.an.paramPanElems = struct();

end   