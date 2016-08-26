%% #OCIA:OCIA_dataProcess_imgData_skipFrame
function [isValid, unvalidReason] = OCIA_dataProcess_imgData_skipFrame(this, iDWRow, varargin)

% by default, row is valid
isValid = true;
unvalidReason = '';

% get the selected processing steps and this row's processing state
selProcOpts = this.an.procOptions.id(get(this.GUI.handles.dw.procOptsList, 'Value'));
rowProcState = getData(this, iDWRow, 'procImg', 'procState');
% if this processing is not required or if data is not imaging data or if data was already processed, abort
if ~any(strcmp(selProcOpts, 'skipFrame')) || ~strcmp(get(this, iDWRow, 'rowType'), 'Imaging data') ...
        || any(strcmp(rowProcState, 'skipFrame')) ...
        || (this.an.skipFrame.nFramesBegin <= 0 && this.an.skipFrame.nFramesEnd <= 0);
    return;
end;

% get whether to do plots or not
if nargin > 2;  doPlots = varargin{1};
else            doPlots = 0;
end;

% check if the processing should be aborted
[doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;
    
% make sure data is fully loaded
DWLoadRow(this, iDWRow, 'full');

% get the imaging data
imgData = get(this, iDWRow, 'data');
imgData = imgData.procImg.data;

% remove the first frame(s) from each channel
for iChan = 1 : numel(imgData);
    imgData{iChan} = imgData{iChan}(:, :, 1 + this.an.skipFrame.nFramesBegin : end - this.an.skipFrame.nFramesEnd);
end;

% check if the processing should be aborted
[doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;

% store the change
this.dw.table{iDWRow, strcmp(this.dw.tableIDs, 'data')}.procImg.data = imgData;

% mark row as processed for this processing step
setData(this, iDWRow, 'procImg', 'procState', [rowProcState { 'skipFrame' }]);

%%  plotting
% if requested, plot a figure illustrating what has been done
if doPlots > 0;
    
    
end;

end
