%% #OCIA:OCIA_dataProcess_imgData
function [isValid, unvalidReason] = OCIA_dataProcess_imgData(this, iDWRow)

% set a flag that tells whether this row is valid for processing or not
isValid = false;
% create a string holding the reason why this row was flagged as not valid
unvalidReason = 'unknown reason';
rowID = DWGetRowID(this, iDWRow); % get the row ID 

dimTag = get(this, iDWRow, 'dim'); % get the dimension tag
nFrames = str2double(strrep(regexp(dimTag, 'x\d+$', 'match'), 'x', '')); % get the number of frames

% if the number of frames is smaller than "funcMovieNFramesLimit" frames, movie is not a functional movie
if nFrames <= this.an.img.funcMovieNFramesLimit;
    isValid = false; % set the validity flag to false
    % store the reason why this row was not valid
    unvalidReason = sprintf('not a functional imaging movie (nFrames = %d, limit = %d)', nFrames, ...
        this.an.img.funcMovieNFramesLimit);
    return; % abort processing of this row
end;

% check whether to show the debug plots or not
showDebugPlots = get(this.GUI.handles.dw.SLROpts.procDataShowDebug, 'Value');

% if calcium data is not present
if isempty(getData(this, iDWRow, 'caTraces', 'data'));
        
    % get the selected processing steps and this row's processing state
    selProcSteps = get(this.GUI.handles.dw.procOptsList, 'Value');
    rowProcState = getData(this, iDWRow, 'procImg', 'procState');
    
    % go through each step and execute the associated function
    nSteps = size(this.an.procOptions.id, 1);
    for iStep = 1 : nSteps;
        
        % check if the processing should be aborted
        [doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason);
        if doAbort; return; end;
        
        % get the processing step's id and label
        stepID = this.an.procOptions.id{iStep};
        stepLabel = this.an.procOptions.label{iStep};
        
        % if processing step is not selected, skip it
        if ~ismember(iStep, selProcSteps); continue; end;
        
        % if processing step if loading, load the row fully
        if strcmp(stepID, 'loadData');
            DWLoadRow(this, iDWRow, 'full');
            continue;
        end;
        
        % if processing step is already done for the current row, skip it with a message
        if any(strcmp(rowProcState, stepID));
            showMessage(this, sprintf('%s for %s (%03d) already done.', stepLabel, rowID, iDWRow));
            continue;
        end;
        
        % call the custom function for this processing step
        warning('off', 'OCIA:dataProcess_imgData:FunctionNotFound');
        [funcHandle, validityCell] = OCIAGetCallCustomFile(this, 'dataProcess_imgData', ...
            stepID, 1, { this, iDWRow, showDebugPlots }, 0);
        warning('on', 'OCIA:dataProcess_imgData:FunctionNotFound');
        
        % if the function was found (function handle not empty) and the row is valid
        if ~isempty(funcHandle) && ~isempty(validityCell) && numel(validityCell) >= 2 && validityCell{1};
            % show step is complete
            showMessage(this, sprintf('%s for %s (%03d) done.', stepLabel, rowID, iDWRow));
            
        % if the function was not found (function handle is empty), show warning and go on
        elseif isempty(funcHandle);
            showWarning(this, 'OCIA:dataProcess_imgData:ProcessFunctionNotFound', ...
                sprintf('%s for %s (%03d): no processing function found ("%s"), skipping this step.', ...
                stepLabel, rowID, iDWRow, stepID));
            
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
        
        % allow time for GUI update
        if isGUI(this); pause(0.005); end;
    end;
end;

% update the row's loading and processing status
DWGetUpdateDataLoadStatus(this, iDWRow);

% if we managed to come this far, then the row is valid and unvalidity reason is empty
isValid = true;
unvalidReason = '';


end
