%% #OCIA:OCIA_dataProcess_imgData_moCorr
function [isValid, unvalidReason] = OCIA_dataProcess_imgData_moCorr(this, iDWRow, varargin)

        
% check if the processing should be aborted
[doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, [], []); if doAbort; return; end;
        
% call the custom function for the selected type of motion correction (TurboReg, HMM, ...)
warning('off', 'OCIA:OCIA_dataProcess_imgData_moCorrFunctionNotFound');
[funcHandle, validityCell] = OCIAGetCallCustomFile(this, 'dataProcess_imgData_moCorr', ...
    this.an.moCorr.type, 1, { this, iDWRow, varargin{:} }, 0); %#ok<CCAT>
warning('on', 'OCIA:OCIA_dataProcess_imgData_moCorrFunctionNotFound');

% if the function was found (function handle not empty) and the row is valid
if ~isempty(funcHandle) && ~isempty(validityCell) && numel(validityCell) >= 2 && validityCell{1};
    [isValid, unvalidReason] = validityCell{:};
    
% if the function was not found (function handle is empty), show warning and go on
elseif isempty(funcHandle);
    isValid = false;
    unvalidReason = sprintf('no processing function found for motion correction type "%s"', this.an.moCorr.type);

% if the row was flagged as not valid
elseif ~isempty(validityCell) && numel(validityCell) >= 2;
    [isValid, unvalidReason] = validityCell{:};
    return;

% otherwise something else went wrong
else
    isValid = false;
    unvalidReason = 'unknown error';
    return;

end;

end
