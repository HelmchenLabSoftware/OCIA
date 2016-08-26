function OCIA_loadData_behavData(this, iDWRow, loadType)
% OCIA_loadData_behavData - [no description]
%
%       OCIA_loadData_behavData(this, iDWRow, loadType)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

loadTic = tic; % for performance timing purposes
o('#%s: iDWRow: %03d, loadType: %s.', mfilename, iDWRow, loadType, 3, this.verb);

% get the load status
currLoadStatus = getData(this, iDWRow, 'behav', 'loadStatus');

% check whether the data is loaded
isDataLoaded = ~isempty(currLoadStatus) && ((strcmp(currLoadStatus, 'partial') && strcmp(loadType, 'partial')) ...
    || (strcmp(currLoadStatus, 'full') && strcmp(loadType, 'full')));

% only load the data if not already loaded
if ~isDataLoaded;

    % load the behavior structure
    loadPath = get(this, iDWRow, 'path');
    behavDataStruct = load(get(this, iDWRow, 'path'));
    out = behavDataStruct.out;
    
    if ~isfield(out.times, 'end');
        showWarning(this, 'OCIA:OCIA_loadData_behavData:FileIncomplete', sprintf( ...
            'Could not load behavior file "%s" because it is incomplete (missing end-times field).', loadPath));
        return;
    end;
    
    % only keep recording data in full load mode
    if strcmp(loadType, 'partial');
        if isfield(out, 'record');
            out = rmfield(out, 'record');
        end;
        if isfield(out, 'rawRecord');
            out = rmfield(out, 'rawRecord');
        end;
    end;

    % store the data
    setData(this, iDWRow, 'behav', 'data', out);

    % annotate the row using a delete tag to be able to remove these fields upon unloading
    set(this, iDWRow, 'time', [this.GUI.dw.deleteTag datestr(unix2dn(out.expStartTime * 1000), 'HH_MM_SS')]);
    nTrials = find(~isnan(out.times.end) & ~isnan(out.resps), 1, 'last');
    counts = analyseBehavPerf(out.respTypes(1 : nTrials), 0, 0, 0);
    set(this, iDWRow, 'dim', [this.GUI.dw.deleteTag sprintf('%03d trial%s (d'':%.1f|hit:%03.0f%%|CR:%03.0f%%|early:%03.0f%%)', ...
        nTrials, iff(nTrials > 1, 's', ''), counts.DPRIME, counts.TGOP, counts.NTNGOP, counts.INVALIDP)]);
    set(this, iDWRow, 'comments', [this.GUI.dw.deleteTag sprintf('task: %s, phase: %s', out.taskType, out.phase)]);
    set(this, iDWRow, 'behav', [this.GUI.dw.deleteTag DWGetRowID(this, iDWRow)]);
    
    DWUpdateColumnsDisplay(this, iDWRow, { 'time', 'dim', 'comments', 'behav' }, false);
    
    % mark row as loaded
    setData(this, iDWRow, 'behav', 'loadStatus', iff(strcmp(currLoadStatus, 'full'), 'full', loadType));
    
end;

o('  #%s: iDWRow %03d, loadType: %s done (%3.1f sec).', mfilename, iDWRow, loadType, toc(loadTic), 4, this.verb);

end
