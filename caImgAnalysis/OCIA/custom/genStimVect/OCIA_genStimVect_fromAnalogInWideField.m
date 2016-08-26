%% #OCIA:AN:OCIA_genStimVect_fromAnalogInWideField
function [isValid, unvalidReason] = OCIA_genStimVect_fromAnalogInWideField(this, iDWRow, varargin)

% get whether to do plots or not
if nargin > 2;      doPlotsTrig = varargin{1}; doPlotsMicr = varargin{1}; doPlotsSummary = varargin{1}; %#ok<NASGU>
elseif nargin > 3;  doPlotsTrig = varargin{1}; doPlotsMicr = varargin{2}; doPlotsSummary = 0; %#ok<NASGU>
else                doPlotsTrig = 0; doPlotsMicr = 0; doPlotsSummary = 0; %#ok<NASGU>
end;

rowID = DWGetRowID(this, iDWRow); % get the row ID 
isValid = true; % by default, the row is valid
unvalidReason = ''; % by default no reason

o('#%s(): row num: %d ...', mfilename, iDWRow, 3, this.verb);

% get the behavior data for this row
behavData = getData(this, iDWRow, 'wfTrBehav', 'data');

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
imgDim = str2dim(get(this, iDWRow, 'dim'));
% compensate for the skipped frames
if numel(imgDim) < 3;   nFramesImg = 0;
else                    nFramesImg = imgDim(3);
end;
% stimulus vector is all zeros except where there are stimulus starts (sound, lick, spout, etc.)
stimVect = zeros(1, nFramesImg);
% string storing the stimulus types for this row
stimTypes = '';
% cell-array storing the relevant time points for the imaging
stimTimeFrames = {};
% initialize variables
imgFrameRate = 20;
% calculate the number of bits to encode 
nMaxStimTimes = 10; nBitsToUseForStimTimes = ceil(log2(nMaxStimTimes));
% assign bits to difference encodings
iBitTime = 1 : nBitsToUseForStimTimes; iBitCloud = iBitTime(end) + (1 : 2); iBitTarg = iBitCloud(end) + (1 : 2);
iBitResp = iBitTarg(end) + (1 : 2); iBitCorr = iBitResp(end) + (1 : 2);

%% delay analysis (trig)
trigData = behavData.analogInData(strcmp(behavData.analogInNames, 'trig'), :); % extract the triger's trace
normThresh = 3 * std(trigData(1 : 100)); % take the first frames for normalization threshold
trigData(abs(trigData) < normThresh) = 0; % normalize to remove the noise of parts when there is no trigger
trigTop = find(trigData > 0); % find all the peaks

% get the trigger delay
anInSampRate = behavData.analogInSampRate;
trigInd = trigTop(1);
trigDelay = trigInd / anInSampRate;

% store the extracted number: analog input sampling rate, trigger delay
behavData.behavSampRate = anInSampRate;
behavData.trigDelay = trigDelay;

% if doPlotsTrig > 0; % if requested, plot a figure illustrating the extraction procedure
%     figure('Name', sprintf('%s_trig', rowID), 'WindowStyle', 'docked', 'NumberTitle', 'off');
%     plot(trigData, 'k');
%     hold on;
%     scatter(trigTop(1), trigData(trigTop(1)), 200, 'b');
%     title(sprintf('trigDelay: %.3f', trigDelay));
% end;

%% sound start (stimulus time) analysis (micr)

% get the number of samples
nSamples = size(behavData.analogInData, 2);

% extract the stimulus sound time and duration from the recorded sound
micr = linScale(abs(behavData.analogInData(strcmp(behavData.analogInNames, 'micr'), :)));
% get a range for the begining of the signal
begRange = round(nSamples * 0.01 : nSamples * 0.1);
% incrementally search for the right threshold
nSoundsDiff = 1; soundYThresh = 0; soundThreshFactor = 5; soundThreshFactorStep = 5; nLoops = 0; %#ok<NASGU>
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
    showWarning(this, sprintf('OCIA:%s:MissingStim', mfilename()), ...
        sprintf(['Problem with number of stimuli found for %s (%d)! Number of stim detected in recorded ', ...
        'data: %d, expected number of stim: %d. Taking only the first %d stim(s).'], rowID, iDWRow, ...
        numel(soundStartTimes), nTones, nTones));
    soundStartTimes = soundStartTimes(1 : nTones);
    doPlotsMicr = doPlotsMicr + 1; %#ok<NASGU>

% if there is a mismatch in the number of sounds found and less sounds were found, show a warning
elseif nSoundsDiff;
    showWarning(this, sprintf('OCIA:%s:MissingStim', mfilename()), ...
        sprintf(['Problem with number of stimuli found for %s (%d)! Number of stim detected in recorded ', ...
        'data: %d, expected number of stim: %d.'], rowID, iDWRow, numel(soundStartTimes), nTones));
    doPlotsMicr = doPlotsMicr + 1; %#ok<NASGU>
end;

% get the stimulus time, including the imaging start delay
soundStartTimesImgReference = soundStartTimes - trigDelay;
soundStartIndexesImgReference = round(soundStartTimesImgReference * imgFrameRate); % get the stimulus index
% remove stim start times that are too early
if any(soundStartIndexesImgReference < 0);
    nRemStims = sum(soundStartIndexesImgReference < 0);
    soundStartIndexesImgReference(soundStartIndexesImgReference <= 0) = [];
    showWarning(this, sprintf('OCIA:%s:EarlyStim', mfilename()), ...
        sprintf('Removed %d early stimuli found for %s (%d)!', nRemStims, rowID, iDWRow));
end;

% store the starting time
behavData.soundStartTime = soundStartTimes;

% encode the sound end stimulus
soundEndTimesImgReference = soundStartTimesImgReference + behavData.stimDur;
soundEndIndexesImgReference = round(soundEndTimesImgReference * imgFrameRate); % get the stimulus index


% if doPlotsMicr > 0; % if requested, plot a figure illustrating the extraction procedure
%     figure('Name', sprintf('%s_micr', rowID), 'WindowStyle', 'docked', 'NumberTitle', 'off');
%     rectangle('Position', [begRange(1) 0 begRange(end) - begRange(1) soundYThresh * 1.1], ...
%         'FaceColor', [0.8 1 0.8], 'EdgeColor', [0.8 1 0.8]);
%     hold on;
%     plot(micr, 'k');
%     yLims = get(gca, 'YLim'); xLims = get(gca, 'XLim');
%     plot(upSamples(1 : end - 1) - 0.5, (upSamplesDiff / max(upSamplesDiff)) * max(micr) * 0.9, 'r');
%     plot(repmat(soundStartInds, 2, 1), repmat(yLims, numel(soundStartInds), 1)', 'r:');
%     plot(xLims, repmat(soundYThresh, 2, 1), 'g:');
%     title(sprintf('stimYThresh: %.5f, stimStartTimes: %s', soundYThresh, sprintf(' %.2fs', soundStartTimes)));
% end;

%% other stim times based one behavior recording
% get the light time, including the imaging start delay
if isfield(behavData, 'trialStartCue') && ~isnan(behavData.trialStartCue);
    trialStartCueImgReference = behavData.soundStartTime - trigDelay + (behavData.trialStartCue - behavData.soundTime);
    stimStartIndexesImgReference = round(trialStartCueImgReference * imgFrameRate); % get the stimulus index
    if stimStartIndexesImgReference <= nFramesImg;
        stimTimeFrames{end + 1} = stimStartIndexesImgReference;
    end;
end;

% add the sound stimulus frames
stimTimeFrames{end + 1} = soundStartIndexesImgReference;
stimTimeFrames{end + 1} = soundEndIndexesImgReference;

% REMOVED BECAUSE NOT ACCURATE
% get the response time, including the imaging start delay
% if isfield(behavData, 'respTime') && ~isnan(behavData.respTime);
%     respTimeImgReference = behavData.soundStartTime - trigDelay + (behavData.respTime - behavData.soundTime);
%     stimStartIndexesImgReference = round(respTimeImgReference * imgFrameRate); % get the stimulus index
%     if stimStartIndexesImgReference <= nFramesImg;
%         stimTimeFrames{end + 1} = stimStartIndexesImgReference;
%     end;
% end;

% get the response window light cue time, including the imaging start delay
if isfield(behavData, 'lightTime') && ~isnan(behavData.lightTime);
    lightCueTimeImgReference = behavData.soundStartTime - trigDelay + (behavData.lightTime - behavData.soundTime);
    stimStartIndexesImgReference = round(lightCueTimeImgReference * imgFrameRate); % get the stimulus index
    if stimStartIndexesImgReference <= nFramesImg;
        stimTimeFrames{end + 1} = stimStartIndexesImgReference;
    end;
end;

%% encode the stimuli
if ~isempty(stimTimeFrames);
    
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
            stimTypes = sprintf('%s,%s', stimTypes, 'freq');
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
        % annotate the stimulus time with the auto / normal using the next bit
        isAuto = double(~isempty(behavData.autoReward) && behavData.autoReward == 1);
        isAutoBitCode = bitget(1 + isAuto, 1 : 2);
        for iBitLoop = 1 : 2;
            stimVect(stimTimeFrames{iStimTime}) = bitset(stimVect(stimTimeFrames{iStimTime}), ...
                iBitCorr(iBitLoop), isAutoBitCode(iBitLoop));
            stimTypes = sprintf('%s,%s', stimTypes, 'auto');
        end;
    end;
        
    % clean up the stimTypes string
    stimTypes = regexprep(regexprep(stimTypes, '^,', ''), ',$', '');

    % store the created stimulus vector and the different stimulus types encoding
    setData(this, iDWRow, 'stim', 'data', stimVect);
    setData(this, iDWRow, 'stim', 'loadStatus', 'full');
    setData(this, iDWRow, 'stim', 'stimTypes', stimTypes);
        
end;

% store back the data
setData(this, iDWRow, 'wfTrBehav', 'data', behavData);

%% summary plot
if doPlotsSummary > 0; % if requested, plot a figure illustrating the extraction procedure
    figure('Name', sprintf('%s_summary', rowID), 'WindowStyle', 'docked', 'NumberTitle', 'off');
    hold on;
    yLims = [- 0.3, 1.2];
    % trigger
    plot((1 : numel(trigData)) / anInSampRate - trigDelay, linScale(trigData, [-1, 1]), 'k');
    plot(repmat(trigTop(1) / anInSampRate - trigDelay, 2, 1), yLims, 'k:');
    
    % microphone
    plot((1 : numel(micr)) / anInSampRate - trigDelay, micr, 'g');
    plot(repmat(soundStartTimesImgReference, 2, 1), yLims, 'g:');
    plot(repmat(soundEndTimesImgReference, 2, 1), yLims, 'g:');
    
    % piezo
    lickData = abs(behavData.analogInData(strcmp(behavData.analogInNames, 'piezo'), :)) * 15;
    plot((1 : numel(lickData)) / anInSampRate - trigDelay, lickData, 'r');
    plot([1, numel(lickData)] / anInSampRate - trigDelay, repmat(behavData.piezoThresh, 2, 1) * 15, 'r:');
    if ~exist('respTimeImgReference', 'var'); respTimeImgReference = NaN; end;
    plot(repmat(respTimeImgReference, 2, 1), yLims, 'r:');
    
    % light
    plot(repmat(trialStartCueImgReference, 2, 1), yLims, 'b:');
    if ~exist('lightCueTimeImgReference', 'var'); lightCueTimeImgReference = NaN; end;
    plot(repmat(lightCueTimeImgReference, 2, 1), yLims, 'b:');
    
    hold off;
    ylim(yLims);
    title( { sprintf('trigDelay: %.3f, trialStartCue: %.3f, soundStart: %.3f, soundEnd: %.3f', ...
                trigDelay, trialStartCueImgReference, soundStartTimesImgReference, soundEndTimesImgReference), ...
        sprintf('lightCue: %.3f, respTime: %.3f, respDelay: %.3f (actual: %.3f)', lightCueTimeImgReference, ...
        respTimeImgReference, behavData.respDelay, respTimeImgReference - lightCueTimeImgReference)});
end;

end
