function BEUpdatePerformance(this)
% BEUpdatePerformance - [no description]
%
%       BEUpdatePerformance(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if ~isfield(this.GUI.handles.be, 'perfAxes'); return; end;

respTypes = this.be.respTypes;
respTypes = respTypes(~isnan(respTypes));
nTrials = size(respTypes, 2);
if nTrials < 1; return; end;

o('#BEUpdatePerformance(): counting %d respTypes ...', size(respTypes, 2), 3, this.verb);
countTic = tic; % for performance timing purposes
counts = analyseBehavPerf(respTypes, [], 15, 1);
o('#behav..mance(): analyzing %d trials done (%3.1f sec)', nTrials, toc(countTic), 3, this.verb);
o('#behav..mance(): counting done (%3.1f sec)', toc(countTic), 3, this.verb);

perfPanChild = get(this.GUI.handles.be.panels.perf, 'Children');
axeH = this.GUI.handles.be.perfAxes;
perfPanChild(perfPanChild == axeH) = [];
delete(perfPanChild);
delete(get(axeH, 'Children')); % delete previous data
plotBehavPerfCurves(axeH, '', counts.TGOs, counts.NTGOs, counts.INVALIDs, counts.DPRIMEs, 4, 1.95, [], [], [], []);

end
