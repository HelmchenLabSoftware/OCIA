function PSData = extractPSTraceSingleTrace(data, stimVector, stimTypes, baseFrames, evokedFrames)
% extracts the peri-stimulus average of a single trace for different stimulus types

% number of stimulus types
nStimTypes = numel(stimTypes);
% get the peri-stimulus frames' range
PSFrames = unique([baseFrames(1) : baseFrames(2) evokedFrames(1) : evokedFrames(2)]);
% number of frames
nFrames = numel(stimVector);
nPeriStimFrames = max(PSFrames) - min(PSFrames) + 1;
% maximum number of stimulus in the stimulus vector for a given stimulus type
nStims = max(arrayfun(@(i) sum(stimVector == stimTypes(i)), 1 : nStimTypes));

% peri-stimulus data for each stimulus type
PSData = nan(nStimTypes, nStims, nPeriStimFrames);

% go through each stimulus type
for iStimType = 1 : nStimTypes;
    
    % get the current stimulus type
    currStimType = stimTypes(iStimType);
    % get the number of stimuli for this type
    stimFrames = find(stimVector == currStimType);
    nCurrStims = numel(stimFrames);
    
    % if no stimulus of this type exists, skip
    if nCurrStims == 0; continue; end;
    
    % go through each frame and check if it contains a stimulus
    for iStim = 1 : nCurrStims;
        
        % get the stimulus frame
        iFrame = stimFrames(iStim);
        
        % get the range of peri-stimulus frames for the current stimulus
        PSFramesCurrStim = PSFrames + iFrame;
        
        nanPad = 0; % set the nan-padding to 0
        startFrame = PSFramesCurrStim(1); % find the start frame        

        % if the start frame is before the first frame, add a nan-padding
        if startFrame < 1;
            nanPad = startFrame - 1; % will be negative
            PSFramesCurrStim(PSFramesCurrStim < 1) = []; % remove exceeding frames
            nTotTraceSize = max(PSFramesCurrStim) - min(PSFramesCurrStim) + 1;
            if nTotTraceSize + abs(nanPad) < nPeriStimFrames;
                nanPad = - (nPeriStimFrames - nTotTraceSize);
            end;
        end

        stopFrame = PSFramesCurrStim(end); % find the stop frame
        % if the stop frame is after the last frame, add a nan-padding
        if stopFrame > nFrames;
            nanPad = stopFrame - nFrames; % will be positive
            PSFramesCurrStim(PSFramesCurrStim > nFrames) = []; % remove exceeding frames
            nTotTraceSize = max(PSFramesCurrStim) - min(PSFramesCurrStim) + 1;
            if nTotTraceSize + abs(nanPad) < nPeriStimFrames;
                nanPad = nPeriStimFrames - nTotTraceSize;
            end;
        end

        % create the trace with the eventual nan-padding
        if nanPad == 0; % no nan-padding
            currentTrace = data(1, PSFramesCurrStim(1) : PSFramesCurrStim(end));
        elseif nanPad < 0; % nan-padding before the trace
            currentTrace = [nan(1, abs(nanPad)), data(1, PSFramesCurrStim(1) : PSFramesCurrStim(end))];
        elseif nanPad > 0; % nan-padding after the trace
            currentTrace = [data(1, PSFramesCurrStim(1) : PSFramesCurrStim(end)), nan(1, nanPad)];
        end
        
        % mask irrelevant frames
        currentTrace(~ismember(PSFramesCurrStim(1) : PSFramesCurrStim(end), PSFramesCurrStim)) = NaN;

        % store the trace in the cell-array
        PSData(iStimType, iStim, :) = currentTrace;
        
    end; % end of frame loop
    
end; % end of stimulus type loop

end