%% #OCIA:OCIA_dataProcess_imgData_genStimVect
function [isValid, unvalidReason] = OCIA_dataProcess_imgData_genStimVect(this, iDWRow, varargin)

% by default, row is valid
isValid = true;
unvalidReason = '';

% get the selected processing steps and this row's processing state
selProcOpts = this.an.procOptions.id(get(this.GUI.handles.dw.procOptsList, 'Value'));
caData = getData(this, iDWRow, 'caTraces', 'data');
% if this processing is not required or if data is not imaging data or if data was already processed, abort
if ~any(strcmp(selProcOpts, 'genStimVect')) || ~strcmp(get(this, iDWRow, 'rowType'), 'Imaging data') ...
        || ~isempty(caData);
    return;
end;

% get whether to do plots or not
if nargin > 2;  doPlots = varargin{1};
else            doPlots = 0;
end;
        
% check if the processing should be aborted
[doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;

% generate the stimulus vector using the custom function, and get out the validity cell-array as output
[funcHandle, validityCell] = OCIAGetCallCustomFile(this, 'genStimVect', ...
    this.an.stimulusVectorGeneratingFunctionName, 1, { this, iDWRow, doPlots }, 0);

% if the generate stimulus function was not found (function handle is empty) or if no validity cell is returned
if isempty(funcHandle) || isempty(validityCell);
    
    % create the unvalidity reason
    isValid = false;
    unvalidReason = 'function not found';
    return; % abort processing of this row
    
% if there was an error and the validity was returned but is false (first element of the validity cell-array)
elseif ~isempty(validityCell) && ~validityCell{1};
    
    % extract the validity and the unvalidity reason into the output parameters
    [isValid, unvalidReason] = validityCell{:};
    return; % abort processing of this row
    
end;

end
