%% #OCIA:OCIA_dataProcess_imgData_moCorr_HMM
function [isValid, unvalidReason] = OCIA_dataProcess_imgData_moCorr_HMM(this, iDWRow, varargin)

% by default, row is valid
isValid = true;
unvalidReason = '';

% get the selected processing steps and this row's processing state
selProcOpts = this.an.procOptions.id(get(this.GUI.handles.dw.procOptsList, 'Value'));
rowProcState = getData(this, iDWRow, 'procImg', 'procState');
% if this processing is not required or if data is not imaging data or if data was already processed, abort
if ~any(strcmp(selProcOpts, 'moCorr')) || ~strcmp(get(this, iDWRow, 'rowType'), 'Imaging data') ...
        || any(strcmp(rowProcState, 'moCorr'));
    return;
end;

        
% check if the processing should be aborted
[doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;

%%


% mark row as processed for motion correction
setData(this, iDWRow, 'procImg', 'procState', [rowProcState { 'moCorr' }]);

end
