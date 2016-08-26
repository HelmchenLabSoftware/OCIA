%% #OCIA:AN:OCIA_genStimVect_fromMicrAnalogIn
function [isValid, unvalidReason] = OCIA_genStimVect_fromMicrAnalogIn(this, iDWRow, varargin)

% get whether to do plots or not
if nargin > 2;      doPlotsYscan = varargin{1}; doPlotsMicr = varargin{1};
elseif nargin > 3;  doPlotsYscan = varargin{1}; doPlotsMicr = varargin{2};
else                doPlotsYscan = 0; doPlotsMicr = 0;
end;

rowID = DWGetRowID(this, iDWRow); % get the row ID 
isValid = true; % by default, the row is valid
unvalidReason = ''; % by default no reason

o('#%s(): row num: %d ...', mfilename, iDWRow, 3, this.verb);

% get the behavior data for this row
behavData = getData(this, iDWRow, 'behavExtr', 'data');

% if no behavior data is found, abort
if isempty(behavData);
    isValid = false; % set the validity flag to false
    % store the reason why this row was not valid
    unvalidReason = sprintf('cannot find associated behavior data (behavior data unavailable in row %03d)', iDWRow);
    return; % abort processing of this row
end;

iTrial = str2double(get(this, iDWRow, 'runNum')); % get the trial number
% if no behavior row found using the behavior ID, abort
if isempty(iTrial) || isnan(iTrial) || iTrial <= 0;
    isValid = false; % set the validity flag to false
    % store the reason why this row was not valid
    unvalidReason = sprintf('bad trial number ("%s" => %d")', get(this, iDWRow, 'runNum'), iTrial);
    return; % abort processing of this row
end;

% fix missing fields
if isfield(behavData, 'nTones');
    % if more than one element for nTones, there must be one element per trial
    if numel(behavData.nTones) > 1; nTones = behavData.nTones(iTrial);
    % otherwise there is only one constant number of tones
    else                            nTones = behavData.nTones;
    end;
% if no field, assume there is only one tone
else                                nTones = 1;
end;

%% init the stim vector
% get the number of skipped frames
nSkippedFrames = this.an.skipFrame.nFramesBegin + this.an.skipFrame.nFramesEnd;
imgDim = str2dim(get(this, iDWRow, 'dim'));
% compensate for the skipped frames
if numel(imgDim) < 3;   nFramesImg = 0;
else                    nFramesImg = imgDim(3) - nSkippedFrames;
end;
% stimulus vector is all zeros except where there are stimulus starts (sound, lick, spout, etc.)
stimVect = zeros(1, nFramesImg);
% string storing the stimulus types for this row
stimTypes = '';
% initialize variables
imgDelay = NaN;
trueFrameRate = NaN;
% calculate the number of bits to encode 
nMaxStimTimes = 10; nBitsToUseForStimTimes = ceil(log2(nMaxStimTimes));
% assign bits to difference encodings
iBitTime = 1 : nBitsToUseForStimTimes; iBitCloud = iBitTime(end) + (1 : 2); iBitTarg = iBitCloud(end) + (1 : 2);
iBitResp = iBitTarg(end) + (1 : 2); iBitCorr = iBitResp(end) + (1 : 2);
% other random bit
iBit = 1;

%% - #OCIA:AN:OCIA_genStimVect_fromMicrAnalogIn : delay and true frame rate analysis (yscan)
if ismember('yscan', behavData.analogInNames);
    % extract the number of frames from the microscope's y scanner's position
    yscan = behavData.analogInData(strcmp(behavData.analogInNames, 'yscan'), :); % extract the y scanner's trace
    normThresh = 3 * std(yscan(1 : 1000)); % take the first 1000 frames for normalization threshold
    yscan(abs(yscan) < normThresh) = 0; % normalize to remove the noise of parts when scanner is not moving
    yscanTopPrctile = prctile(yscan, 80); % set a threshold at the 80th percentile
    yscanTop = find(yscan > yscanTopPrctile); % find all the peaks
    yscanTopDiff = diff(yscanTop); % get the differential of the peaks to find the real peak
    yscanTopDiffPeaks = [find(yscanTopDiff > 1) size(yscanTop, 2)]; % get the peaks
    nFramesBehav = size(yscanTopDiffPeaks, 2); % get the number of frames found using the recording of the y scanner

    % get the middle part of the frames (20%-80%) to exclude starting and ending artifacts
    middleFrames = round(nFramesBehav * 0.2) : round(nFramesBehav * 0.8);
    % calculate the true frame rate (based on the y position of the scanner)
    if isfield(behavData, 'analogInSampRate'); % if there is a field containing the analog input sampling rate
        anInSampRate = behavData.analogInSampRate;
        % calculate the true frame rate using the inter-peak interval
        trueFrameRate = anInSampRate / mean(diff(yscanTop(yscanTopDiffPeaks(middleFrames))));
        
    % no field containing the analog input rate, figure it out (backward compatibility)
    else
        % try to find the sampling rate from the two possible values
        unknownBehavRate = [3000 3333];
        % two possible frame rates
        trueFrameRateOptions = unknownBehavRate / mean(diff(yscanTop(yscanTopDiffPeaks(middleFrames))));
        % find the closest frame rate to the expected frame rate
        [~, closestBehavRateInd] = min(abs(trueFrameRateOptions - 77.67));
        % get analog input sampling rate and the true frame rate corresponding to this closest frame rate
        anInSampRate = unknownBehavRate(closestBehavRateInd);
        trueFrameRate = trueFrameRateOptions(closestBehavRateInd);
        % show a warning for this assumption
        showWarning(this, 'OCIA:OCIA_genStimVect_fromMicrAnalogIn:NoAnInSampRate', ...
            sprintf(['Missing analog in sample rate for %s (%d)! Assuming it was %d Hz (=> true frame rate: ', ...
            '%.2f Hz).'], rowID, iDWRow, anInSampRate, trueFrameRate));
    end;

    % get the imaging delay by substract the time of a single frame from the first y scanner peak
    frameLength = round(anInSampRate / trueFrameRate);
    firstFrameEndInd = yscanTop(yscanTopDiffPeaks(1));
    firstFrameStartInd = firstFrameEndInd - frameLength;
    imgDelay = firstFrameStartInd / anInSampRate;

    % store the extracted number: analog input sampling rate, imaging delay and true frame rate
    
    behavData.behavSampRate = anInSampRate;
    behavData.imgDelay = imgDelay;
    behavData.imgFrameRate = trueFrameRate;

    % check whether there is a big frame difference between the imaging and the behavior recording
    nFrameDiff = nFramesBehav - nFramesImg;
    % if there is some imaging data and difference is too big (more than 1 second), abort
    if nFramesImg && nFrameDiff > 1 * trueFrameRate;
        showWarning(this, 'OCIA:genStimVect:fromMicrAnalogIn:missingFrames', sprintf(['Missing frames in the ', ...
            'imaging data: frames from behavior = %d, from imaging = %d (~= %.1f ms difference). Going on ...'], ...
            nFramesBehav, nFramesImg, 1000 * nFrameDiff / trueFrameRate));
        % change the display color
        frameDisplayColor = 'orange';
        
    elseif nFramesImg && nFrameDiff < 0;
        isValid = false; % set the validity flag to false
        % store the reason why this row was not valid
        unvalidReason = sprintf(['frame number mismatch (frames from behavior: %d, from imaging: %d ', ...
            '(~= %.1f ms difference).'], nFramesBehav, nFramesImg, 1000 * nFrameDiff / trueFrameRate);        
        % change the display color
        frameDisplayColor = 'red';
    
    % no frame mismatch
    else         
        % change the display color
        frameDisplayColor = 'green';
    end;
        
    % add the number of frames from the behavior in the comments
    comments = getR(this, iDWRow, 'comments');
    if iscell(comments); comments = comments{1}; end;
    % clean the HTML away
    comments = regexprep(comments, '^<html>', ''); % remove HTML tag
    comments = regexprep(comments, '<font[^>]+>', ''); % remove font tags
    comments = regexprep(comments, '</font>', ''); % remove font tags
    % remove the previous frame number tag
    comments = regexprep(comments, '(, )?\d+ frames \(behav\.\)', '');
    % add the HTML for a colored frame number comment
    comments = sprintf('<html><font color="black">%s%s</font><font color="%s">%d</font><font color="black"> frames (behav.)</font>', comments, ...
        iff(isempty(comments), '', ', '), frameDisplayColor, nFramesBehav);
    % put back the comments in the table and update the display
    set(this, iDWRow, 'comments', comments);
    DWUpdateColumnsDisplay(this, iDWRow, { 'comments' }, false);
    
    % if row is not valid, abort processing of this row
    if ~isValid; return; end;

    if doPlotsYscan > 0; % if requested, plot a figure illustrating the extraction procedure
        figure('Name', sprintf('%s_yscan', rowID), 'WindowStyle', 'docked', 'NumberTitle', 'off');
        plot(yscan, 'k');
        title(sprintf('nFramesBehav: %d, nFramesImag: %d', nFramesBehav, nFramesImg));
        hold on;
        yLims = get(gca, 'YLim');
        plot(yscanTop, yscan(yscanTop), 'g');
        plot(yscanTop(1 : end - 1) + 0.5, yscanTopDiff / 100, 'r');
        plot(repmat(firstFrameStartInd, 2, 1), yLims, 'r:');
        scatter(yscanTop(yscanTopDiffPeaks), repmat(0.8, nFramesBehav, 1), 'b*');
    end;

end; % end check yscan exists

%% - #OCIA:AN:OCIA_genStimVect_fromMicrAnalogIn : sound start (stimulus time) analysis (micr)
if ismember('micr', behavData.analogInNames);

    % get the number of samples
    nSamples = size(behavData.analogInData, 2);
    
    % extract the stimulus sound time and duration from the recorded sound
    micr = linScale(abs(behavData.analogInData(strcmp(behavData.analogInNames, 'micr'), :))); % extract the microphone's trace
    % get a range for the begining of the signal
    begRange = round(nSamples * 0.01 : nSamples * 0.1);
    % incrementally search for the right threshold
    nSoundsDiff = 1; soundYThresh = 0; soundThreshFactor = 5; soundThreshFactorStep = 5; nLoops = 0;
    while nSoundsDiff && soundThreshFactor < 55;
        % get a threshold for the sound onset
        soundThreshFactor = soundThreshFactor + soundThreshFactorStep;
        soundYThresh = soundThreshFactor * std(micr(begRange));
        % get the samples that exceeds the threshold, adding the first sample to catch the start of the first sound
        upSamples = [0 find(micr > soundYThresh)];
        % get the derivative of the upSamples, drops in the sample indexes indicate interruption of upSamples,
        %   which means that there is a sound start
        upSamplesDiff = diff(upSamples);
        % use the ISI to find peaks. If no ISI, use 0.5 second
        ISI = 0.5;
        if isfield(behavData, 'ISI') && behavData.ISI > 0;
            ISI = behavData.ISI;
        end;
        % difference between detected upSample derivative's peaks must be at least half of the ISI
        minISI = ISI * 0.5 * anInSampRate;
        % get the index of the peaks where the derivative exceeds the ISI threshold and increment by one to get
        %   the sound start index
        soundStartInds = upSamples(find(upSamplesDiff >= minISI) + 1);

        if ~isempty(soundStartInds);
            % calculate the sound start time
            soundStartTimes = soundStartInds / anInSampRate;
        else
            soundStartTimes = [];
        end;

        % check whether there is a big frame difference between the imaging and the behavior recording
        nSoundsDiff = abs(nTones - numel(soundStartTimes));
        nLoops = nLoops + 1;

    end;

    % if there is a mismatch in the number of sounds found and more sounds were found, show a warning
    if nSoundsDiff && ~isempty(soundStartTimes) && numel(soundStartTimes) >= nTones;
        showWarning(this, 'OCIA:OCIA_genStimVect_fromMicrAnalogIn:MissingStim', ...
            sprintf(['Problem with number of stimuli found for %s (%d)! Number of stim detected in recorded ', ...
            'data: %d, expected number of stim: %d. Taking only the first %d stim(s).'], rowID, iDWRow, ...
            numel(soundStartTimes), nTones, nTones));
        soundStartTimes = soundStartTimes(1 : nTones);
        doPlotsMicr = doPlotsMicr + 1;
        
    % if there is a mismatch in the number of sounds found and less sounds were found, show a warning
    elseif nSoundsDiff;
        showWarning(this, 'OCIA:OCIA_genStimVect_fromMicrAnalogIn:MissingStim', ...
            sprintf(['Problem with number of stimuli found for %s (%d)! Number of stim detected in recorded ', ...
            'data: %d, expected number of stim: %d.'], rowID, iDWRow, numel(soundStartTimes), nTones));
        doPlotsMicr = doPlotsMicr + 1;
    end;

    % if there is some imaging data and some sound start, create the simulus vector
    if nFramesImg && ~isempty(soundStartTimes);
        % get the stimulus time, including the imaging start delay
        soundStartTimesImgReference = soundStartTimes - imgDelay;
        stimStartIndexesImgReference = round(soundStartTimesImgReference * trueFrameRate); % get the stimulus index
        % remove stim start times that are too early
        if any(stimStartIndexesImgReference < 0);
            nRemStims = sum(stimStartIndexesImgReference < 0);
            stimStartIndexesImgReference(stimStartIndexesImgReference <= 0) = [];
            showWarning(this, 'OCIA:OCIA_genStimVect_fromMicrAnalogIn:EarlyStim', ...
                sprintf('Removed %d early stimuli found for %s (%d)!', nRemStims, rowID, iDWRow));
        end;
        
        %% annotate stimulus frames        
        % if this is an cloud of tone discrimination task
        if strcmp(behavData.taskType, 'cotDiscr');
            
            % encode the sound start stimulus
            stimTimeFrames = { stimStartIndexesImgReference };
            
            % go through each stim time
            for iStimTime = 1 : numel(stimTimeFrames);
                
                % encode the stimulus time: get the bit code for each stimulus time
                bitCode = bitget(1, 1 : nBitsToUseForStimTimes);
                % encode the bitCode into the stimulus vector
                for iBitLoop = 1 : nBitsToUseForStimTimes;
                    % annotate with the stimuli with the current bit iteratively
                    stimVect(stimTimeFrames{iStimTime}) = bitset(stimVect(stimTimeFrames{iStimTime}), ...
                        iBitTime(iBitLoop), bitCode(iBitLoop));
                    stimTypes = sprintf('%s,%s', stimTypes, 'time');
                end;
                
                % annotate the stimulus time with the cloud type using the next bit
                soundType = double(behavData.stim == 1);
                soundTypeBitCode = bitget(1 + soundType, 1 : 2);
                for iBitLoop = 1 : 2;
                    stimVect(stimTimeFrames{iStimTime}) = bitset(stimVect(stimTimeFrames{iStimTime}), ...
                    iBitCloud(iBitLoop), soundTypeBitCode(iBitLoop));
                    stimTypes = sprintf('%s,%s', stimTypes, 'cloud');
                end;
                % annotate the stimulus time with the target/non-target using the next bit
                isTarget = double(~isempty(behavData.target) && behavData.target == 1);
                isTargetBitCode = bitget(1 + isTarget, 1 : 2);
                for iBitLoop = 1 : 2;
                    stimVect(stimTimeFrames{iStimTime}) = bitset(stimVect(stimTimeFrames{iStimTime}), ...
                        iBitTarg(iBitLoop), isTargetBitCode(iBitLoop));
                    stimTypes = sprintf('%s,%s', stimTypes, 'targ');
                end;
                % annotate the stimulus time with the response / non response using the next bit
                isResp = double(~isempty(behavData.resp) && behavData.resp == 1);
                isRespBitCode = bitget(1 + isResp, 1 : 2);
                for iBitLoop = 1 : 2;
                    stimVect(stimTimeFrames{iStimTime}) = bitset(stimVect(stimTimeFrames{iStimTime}), ...
                        iBitResp(iBitLoop), isRespBitCode(iBitLoop));
                    stimTypes = sprintf('%s,%s', stimTypes, 'resp');
                end;
                % annotate the stimulus time with the correct / false using the next bit
                isCorrect = double(~xor(isTarget, isResp));
                isCorrectBitCode = bitget(1 + isCorrect, 1 : 2);
                for iBitLoop = 1 : 2;
                    stimVect(stimTimeFrames{iStimTime}) = bitset(stimVect(stimTimeFrames{iStimTime}), ...
                        iBitCorr(iBitLoop), isCorrectBitCode(iBitLoop));
                    stimTypes = sprintf('%s,%s', stimTypes, 'corr');
                end;
            end;

        % if this is an oddball experiment with the right number of sounds
        elseif strcmp(behavData.taskType, 'cotOdd') && isfield(behavData, 'oddPos') && numel(stimStartIndexesImgReference) >= behavData.oddPos;
            
            % annotate with 1 on the first bit to mark it as stimulus frame
            stimVect(stimStartIndexesImgReference) = bitset(stimVect(stimStartIndexesImgReference), iBit, 1);
            stimTypes = sprintf('%s,%s', stimTypes, 'stim');
            iBit = iBit + 1;
            
            % calculate the number of bits required for encoding 10 states (10 stimuli)
            nStims = numel(stimStartIndexesImgReference); nMaxStims = 10; nBitsToUse = ceil(log2(nMaxStims));
            % get the bit code for each stimulus number
            bitCode = zeros(nBitsToUse, nStims);
            for iStim = 1 : nStims;
                bitCode(:, iStim) = bitget(iStim, 1 : nBitsToUse);
            end;
            % encode the bitCode into the stimulus vector
            for iBitLoop = 1 : nBitsToUse;
                % annotate with the stimuli with the current bit iteratively
                stimVect(stimStartIndexesImgReference) = bitset(stimVect(stimStartIndexesImgReference), iBit, bitCode(iBitLoop, :));
                stimTypes = sprintf('%s,%s', stimTypes, 'stimNum');
                iBit = iBit + 1;
            end;
            
            % annotate with the sound type depending on the standard/odd using the next bit
            soundType = behavData.stim == 1;
            stimVect(stimStartIndexesImgReference) = bitset(stimVect(stimStartIndexesImgReference), iBit, soundType);
            stimVect(stimStartIndexesImgReference(behavData.oddPos)) = bitset(stimVect(stimStartIndexesImgReference(behavData.oddPos)), iBit, ~soundType);
            stimTypes = sprintf('%s,%s', stimTypes, 'soundType');
            iBit = iBit + 1;
            
            % calculate the number of bits required for encoding 3 states (first, pre-odd, odd)
            nStims = numel(stimStartIndexesImgReference); nMaxStims = 3; nBitsToUse = ceil(log2(nMaxStims));
            % get the bit code for each stimulus number
            bitCode = zeros(nBitsToUse, nStims);
            for iStim = 1 : nStims;
                % get the stimulus state to encode for this stimulus
                if iStim == 1;                          stimState = 1;
                elseif iStim == behavData.oddPos - 1;   stimState = 2; 
                elseif iStim == behavData.oddPos;       stimState = 3;
                else                                    stimState = 0;
                end;
                bitCode(:, iStim) = bitget(stimState, 1 : nBitsToUse);
            end;
            % encode the bitCode into the stimulus vector
            for iBitLoop = 1 : nBitsToUse;
                % annotate with the stimuli with the current bit iteratively
                stimVect(stimStartIndexesImgReference) = bitset(stimVect(stimStartIndexesImgReference), iBit, bitCode(iBitLoop, :));
                stimTypes = sprintf('%s,%s', stimTypes, 'oddball');
                iBit = iBit + 1;
            end;
            
        end;
    end;
        
    % clean up the stimTypes string
    stimTypes = regexprep(regexprep(stimTypes, '^,', ''), ',$', '');

    % store the created stimulus vector and the different stimulus types encoding
    behavData.soundStartTime = soundStartTimes;
    setData(this, iDWRow, 'stim', 'data', stimVect);
    setData(this, iDWRow, 'stim', 'loadStatus', 'full');
    setData(this, iDWRow, 'stim', 'stimTypes', stimTypes);

    if doPlotsMicr > 0; % if requested, plot a figure illustrating the extraction procedure
        figure('Name', sprintf('%s_micr', rowID), 'WindowStyle', 'docked', 'NumberTitle', 'off');
        rectangle('Position', [begRange(1) 0 begRange(end) - begRange(1) soundYThresh * 1.1], ...
            'FaceColor', [0.8 1 0.8], 'EdgeColor', [0.8 1 0.8]);
        hold on;
        plot(micr, 'k');
        yLims = get(gca, 'YLim'); xLims = get(gca, 'XLim');
        plot(upSamples(1 : end - 1) - 0.5, (upSamplesDiff / max(upSamplesDiff)) * max(micr) * 0.9, 'r');
        plot(repmat(soundStartInds, 2, 1), repmat(yLims, numel(soundStartInds), 1)', 'r:');
        plot(xLims, repmat(soundYThresh, 2, 1), 'g:');
        title(sprintf('stimYThresh: %.5f, stimStartTimes: %s', soundYThresh, sprintf(' %.2fs', soundStartTimes)));
    end;

end; % end check micr exists

%% - #OCIA:AN:OCIA_genStimVect_fromMicrAnalogIn : light cue and response time
if strcmp(behavData.taskType, 'cotDiscr') && ~isnan(imgDelay) && ~isnan(trueFrameRate);
    
    % encode the stimuli
    stimTimeFrames = { };
    
    % get the light time, including the imaging start delay
    if isfield(behavData, 'lightTime') && ~isnan(behavData.lightTime);
        lightTimeImgReference = behavData.soundStartTime - imgDelay + (behavData.lightTime - behavData.soundTime);
        stimStartIndexesImgReference = round(lightTimeImgReference * trueFrameRate); % get the stimulus index
        if stimStartIndexesImgReference <= nFramesImg;
            stimTimeFrames{end + 1} = stimStartIndexesImgReference;
        end;
    end;
        
    % get the response time, including the imaging start delay
    if isfield(behavData, 'respTime') && ~isnan(behavData.respTime);
        respTimeImgReference = behavData.soundStartTime - imgDelay + (behavData.respTime - behavData.soundTime);
        stimStartIndexesImgReference = round(respTimeImgReference * trueFrameRate); % get the stimulus index
        if stimStartIndexesImgReference <= nFramesImg;
            stimTimeFrames{end + 1} = stimStartIndexesImgReference;
        end;
    end;
        
    % get the light off time, including the imaging start delay
    if isfield(behavData, 'lightOffTime') && ~isnan(behavData.lightOffTime);
        lightOffTimeImgReference = behavData.soundStartTime - imgDelay + (behavData.lightOffTime - behavData.soundTime);
        stimStartIndexesImgReference = round(lightOffTimeImgReference * trueFrameRate); % get the stimulus index
        if stimStartIndexesImgReference <= nFramesImg;
            stimTimeFrames{end + 1} = stimStartIndexesImgReference;
        end;
    end;
    
    % go through each stim time
    for iStimTime = 1 : numel(stimTimeFrames);

        % encode the stimulus time: get the bit code for each stimulus time
        bitCode = bitget(1 + iStimTime, 1 : nBitsToUseForStimTimes);
        % encode the bitCode into the stimulus vector
        for iBitLoop = 1 : nBitsToUseForStimTimes;
            % annotate with the stimuli with the current bit iteratively
            stimVect(stimTimeFrames{iStimTime}) = bitset(stimVect(stimTimeFrames{iStimTime}), iBitTime(iBitLoop), ...
                bitCode(iBitLoop));
        end;

        % annotate the stimulus time with the cloud type using the next bit
        soundType = double(behavData.stim == 1);
        soundTypeBitCode = bitget(1 + soundType, 1 : 2);
        for iBitLoop = 1 : 2;
            stimVect(stimTimeFrames{iStimTime}) = bitset(stimVect(stimTimeFrames{iStimTime}), ...
            iBitCloud(iBitLoop), soundTypeBitCode(iBitLoop));
        end;
        % annotate the stimulus time with the target/non-target using the next bit
        isTarget = double(~isempty(behavData.target) && behavData.target == 1);
        isTargetBitCode = bitget(1 + isTarget, 1 : 2);
        for iBitLoop = 1 : 2;
            stimVect(stimTimeFrames{iStimTime}) = bitset(stimVect(stimTimeFrames{iStimTime}), ...
                iBitTarg(iBitLoop), isTargetBitCode(iBitLoop));
        end;
        % annotate the stimulus time with the response / non response using the next bit
        isResp = double(~isempty(behavData.resp) && behavData.resp == 1);
        isRespBitCode = bitget(1 + isResp, 1 : 2);
        for iBitLoop = 1 : 2;
            stimVect(stimTimeFrames{iStimTime}) = bitset(stimVect(stimTimeFrames{iStimTime}), ...
                iBitResp(iBitLoop), isRespBitCode(iBitLoop));
        end;
        % annotate the stimulus time with the correct / false using the next bit
        isCorrect = double(~xor(isTarget, isResp));
        isCorrectBitCode = bitget(1 + isCorrect, 1 : 2);
        for iBitLoop = 1 : 2;
            stimVect(stimTimeFrames{iStimTime}) = bitset(stimVect(stimTimeFrames{iStimTime}), ...
                iBitCorr(iBitLoop), isCorrectBitCode(iBitLoop));
        end;
    end;
    
    % if some stimulus was found
    if ~isempty(stimTypes);
        
        % clean up the stimTypes string
        stimTypes = regexprep(regexprep(stimTypes, '^,', ''), ',$', '');

        % store the created stimulus vector and the different stimulus types encoding
        setData(this, iDWRow, 'stim', 'data', stimVect);
        setData(this, iDWRow, 'stim', 'loadStatus', 'full');
        setData(this, iDWRow, 'stim', 'stimTypes', regexprep(stimTypes, '^,', ''));
        
    end;
    
end;

% store back the data
setData(this, iDWRow, 'behavExtr', 'data', behavData);

% % display message
% showMessage(this, sprintf(['Extracting behavior data for %s (%d) done (frames behav: %d, ', ...
%     'frames img: %d, nStims: %d, nLoops: %d, %3.1f sec).'], rowID, iDWRow, nFramesBehav, ...
%     nFramesImg, numel(stimStartTimes), nLoops, toc(behavExtrTic)));

end
