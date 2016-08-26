%% #OCIA:OCIA_dataProcess_behavData
function [isValid, unvalidReason] = OCIA_dataProcess_behavData(this, iDWRow)

% set a flag that tells whether this row is valid for processing or not
isValid = false; %#ok<NASGU>
% create a string holding the reason why this row was flagged as not valid
unvalidReason = 'unknown reason'; %#ok<NASGU>

% load the row
DWLoadRow(this, iDWRow, 'full');

% update the row's loading and processing status
DWGetUpdateDataLoadStatus(this, iDWRow);

% if we managed to come this far, then the row is valid and unvalidity reason is empty
isValid = true;
unvalidReason = '';

end
