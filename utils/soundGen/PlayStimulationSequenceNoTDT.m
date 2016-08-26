function [stim, abort] = PlayStimulationSequenceNoTDT(varargin)
% Plays a sequence of sound stimulations.
% The required recording length is dutyCycle * nStimuli, adding [startDelay]
% seconds of circuit delay before the first sound.
% With the default input parameters, this time is 65 sec (5 + (0.8 * 65)).
%
%
% PARAMETERS (stars '*' indicate REQUIRED parameters):
% *stimType     tells which type of stimulation should be played, choices are
%               'BF', 'SSA_DEV', 'SSA_OMI', 'SSA_DEVALONE', 'OddTrial'.
% attenLevel    attenuation level, usually 10, 20 or 90 (default: 10).
% randomSeed    chooses which sequence of tones should be played.
%               Corresponds to a column of the data table 'stimMatrix', so
%               must be between 0 and 4 (SSA_DEV & SSA_OMI), 0 and 11 (BF) or
%               0 and 3 (ODD_TRIAL). Can also be -1, which then selects
%               a random seed randomly O_o (default: -1).
% nStimuli      number of stimulus/pulse (default: 75 pulses)
% BFreqIndex    index of the best frequency to use as standard (default: 1).
% proba         probability of deviant, 10, 30 or 50 (default: 10);
% freqDev       number of octaves of difference between the standard and
%               the deviant tone, usually 0.5 or 0.25 (default: 0.5).
% swap          tells whether to use the best frequency as standard (swap = 1)
%               or deviant (-1) (default: 1).
% stimDur       stimulus duration [ms] (default: 100 ms)
% dutyCycle     interval between the onset of two stimuli [ms] (default: 500 ms).
% startDelay    starting delay before first sound is played [ms] (default: 5000 ms).
% useExtTrig    tells whether to launch immediately the softTrigger for the
%               TDT (useExtTrig = 0) or wait for an external trigger using
%               the 'externalTrigger_nidaq' function (useExtTrig > 0). If
%               activated (useExtTrig > 0), the value is used as timeout
%               for the external trigger waiting. In case the waiting times
%               out, the sound is NOT played (default: 0).
% useBLN        tells whether to use band-limited-noise (useBLN > 0) or    
%               pure tones (useBLN = 0). If activated (useBLN > 0), the
%               value is used as freqRange (default: 0).
% useFMSweep    tells whether to use FM sweeps (useFMSweep > 0) or    
%               pure tones (useFMSweep = 0). If activated (useFMSweep > 0),
%               the value is used as freqRange (default: 0).
% v             verbosity (0 - 5) (default: 0).
% d             debug (0 - 5) (default 0).
%
% RETURNS:
% a stimulation structure, containing all the parameters used for this
% stimulation and the times and frequencies returned by the TDT circuit.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Created first by an unknown author (Marco?) in a galaxy far far away       %
% Adapted first on ???? by I-Wen Chen                                        %
% Adapted the adapted on 2012-11-19 by B. Laurenczy                          %
% Further modifications on 2013-03-20 by B. Laurenczy                        %
% More additional further modifications on 2013-10-01 by B. Laurenczy        %
% More additional further supplementary modifications on 2013-12-16 by B.L   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% parse inputs
IP = inputParser;

addRequired(IP, 'stimType',             @ischar);
addOptional(IP, 'attenLevel',   10,     @isnumeric);
addOptional(IP, 'randomSeed',   -1,     @(x) isnumeric(x) && ((x >= 0 && x <= 11) || x == -1));
addOptional(IP, 'nStimuli',     100,    @isnumeric);
addOptional(IP, 'BFreqIndex',   1,      @isnumeric);
addOptional(IP, 'proba',        10,     @isnumeric);
addOptional(IP, 'freqDev',      0.5,    @isnumeric);
addOptional(IP, 'swap',         1,      @isnumeric);
addOptional(IP, 'stimDur',      100,    @isnumeric);
addOptional(IP, 'dutyCycle',    500,    @isnumeric);
addOptional(IP, 'startDelay',   1000,   @isnumeric);
addOptional(IP, 'useExtTrig',   0,      @isnumeric);
addOptional(IP, 'useBLN',       0,      @isnumeric);
addOptional(IP, 'useFMSweep',   0,      @isnumeric);
addOptional(IP, 'v',            0,      @isnumeric);
addOptional(IP, 'd',            0,      @isnumeric);
addOptional(IP, 'noTDT',        0,      @isnumeric);

parse(IP, varargin{:});

% transfer the parsed arguments into the stim structure
stim = IP.Results;

abort = 0;

% generate a random randomSeed if required
if stim.randomSeed == -1;
    switch(stim.stimType)
        case 'BF'; stim.randomSeed = randi(10) - 1;
        case 'SSA_DEV'; stim.randomSeed = randi(5) - 1;
        case 'SSA_OMI'; stim.randomSeed = randi(5) - 1;
        % 0: no oddball, 1-3: oddball in last, before-last and before-before-last position 
        case 'ODD_TRIAL'; stim.randomSeed = randi(4) - 1;
        otherwise
    end;
end;

notImplemented = 1;
% stimMatrix = [];
toneArray = {};
stimMatrixRootPath = 'P:/stuff';

switch(stim.stimType);
    case 'BF' % best frequency characterization
        if ~stim.useBLN && ~stim.useFMSweep;
            notImplemented = 0;
%             stimMatrixMatFile = load(sprintf('%s/stimMatrix_15stim_30rep', stimMatrixRootPath));
            nStimTypes = 10;
%             stimMatrix = stimMatrixMatFile.(cell2mat(fieldnames(stimMatrixMatFile)));
            frequencies = 4000 * (2 .^ (((1 : nStimTypes) - 1) * 0.25));
%             stimIDs = stimMatrix(:, stim.randomSeed);
            uniqueStimIDs = repmat(1 : nStimTypes, 1, 10);
            stimIDs = uniqueStimIDs(randperm(numel(uniqueStimIDs)));
%             stimIDs(stimIDs > nStimTypes) = [];
%             if numel(stimIDs) < stim.nStimuli;
%                 error('PlayStimulationSequence:stimMatrixTooSmall', ...
%                     'Not enough stimuli: stimIDs = %d, requested: %d.', numel(stimIDs), stim.nStimuli);
%             end;
            stimIDs = stimIDs(1 : stim.nStimuli);
            toneArray = MakePureToneArray(frequencies, stimIDs, stim.stimDur / 1000, 44100);
%             toneArrayRamp = MakePureToneArray(frequencies, 1 : 10, stim.stimDur / 1000, 44100);
        else
        end;
end;

if notImplemented;
    error('PlayStimulationSequence:StimTypeNotImplemented', ...
        'Error %s & BLN: %d & FMSweep: %d not implemented!', stim.stimType, stim.useBLN, stim.useFMSweep);
end;

o(['    - Stimulation sequence: type "%s", attenLevel: %d, randomSeed: %d, ' ...
    'nStimuli: %d, BFreqIndex: %d, proba: %d, freqDev: %.2f, swap: %d, stimDur: %d ms, ' ...
    'duty cycle: %d ms, external trigger: %d (s).'], ...
    stim.stimType, stim.attenLevel, stim.randomSeed, stim.nStimuli, stim.BFreqIndex, ...
    stim.proba, stim.freqDev, stim.swap, stim.stimDur, stim.dutyCycle, stim.useExtTrig, 1, stim.v);

if stim.d < 2; % if not in high level debug mode
    
% RP.SetTagVal('AttLevel', stim.attenLevel); % for BF and SSA_DEV
% RP.SetTagVal('Att', stim.attenLevel); % for SSA_OMI

% % feed some additional parameters to the circuit if needed
% switch(stim.stimType)
%     case 'SSA_DEV'
%         RP.SetTagVal('CFIdx', stim.BFreqIndex);
%         RP.SetTagVal('fDev', stim.freqDev);
%         RP.SetTagVal('Swap', stim.swap);
%     case 'SSA_OMI'
%         RP.SetTagVal('CFIdx', stim.BFreqIndex);
%         RP.SetTagVal('Swap', stim.swap);
%     case 'ODD_TRIAL'
%         RP.SetTagVal('CFIdx', stim.BFreqIndex);
%         RP.SetTagVal('Swap', stim.swap);
% end;
% 
% % set the band limited noise's frequency range above and under the current frequency played
% if stim.useBLN > 0;
%     RP.SetTagVal('FreqRange', stim.useBLN);
%     RP.SetTagVal('FreqMultiply', 4000);
%     RP.SetTagVal('FreqAdd', 1000);
% % sets the FM sweeps's frequency ramp above the current frequency played
% elseif stim.useFMSweep > 0;
%     RP.SetTagVal('FreqRange', stim.useFMSweep);
% end;

% create a figure to be able to check for an abort command
f = gcf;

if stim.useExtTrig > 0;
    o('      Waiting for trigger (%d sec timeout)...', stim.useExtTrig, 1, stim.v);
    status = externalTrigger_nidaq(stim.useExtTrig);
    if status == 0; % timeout
        abort = 1;
        doStimulation = 0;
        warning('PlayStimulationSequence:TriggerTimedOut', 'Trigger timed out!');
    elseif status == 2; % connection problem
        abort = 1;
        doStimulation = 0;
        warning('PlayStimulationSequence:TriggerConnectionFailed', 'Trigger connection failed!');
    else % trigger well received
        doStimulation = 1;
    end;
else % no trigger used, go ahead directly
    o('      No trigger.', 1, stim.v);
    doStimulation = 1;
end;

% if not ext. trig. required or if it was successfully received, proceed...
if doStimulation;

    %% start stimulation
    % send start signal to circuit to start stimulus
%     RP.SoftTrg(1);
    o('    - Beginning stimulation... (press any key while on figure to stop)', 2, stim.v);
%     end;
%     % Check every second for an abort command
%     while (RP.GetTagVal('Index') < stim.nStimuli);

    nTones = size(toneArray, 1);
    stim.nStimuli = nTones;
    
    stim.timePoints   = nan(nTones, 1);
    stim.freqSeries   = nan(nTones, 1);
    stim.freqIdSeries = nan(nTones, 1);

    tStart = tic;
%     o('      - tStart: %d ...', tStart, 1, stim.v);
    lastPercentageDisplayed = -1;

    pause(stim.startDelay / 1000);
    o('      ', 1, stim.v);
    
    
%     nTones = size(toneArrayRamp, 1);
    iTone = 1;
    while iTone <= nTones;
        
        stim.timePoints(iTone) = toc(tStart);
        stim.freqIdSeries(iTone) = stimIDs(iTone);
        stim.freqSeries(iTone) = frequencies(stim.freqIdSeries(iTone));
%         fprintf('Playing: %d => %4.2f kHz at %d\n', stim.freqSeries(iTone) / 1000, ...
%             stim.timePoints(iTone), stim.freqIdSeries(iTone));
        sound(toneArray{iTone} * (1 - (stim.attenLevel / 100)), 44100);
        
%         fprintf('Playing: %d => %4.2f kHz\n', iTone, frequencies(iTone));
%         sound(toneArrayRamp{iTone}, 44100);

        pauseTicToc((stim.dutyCycle - stim.stimDur) / 1000);
        
        if strcmp(get(f,'CurrentCharacter'), '') == 0;
            o('', 1, stim.v);
            o('    - Stimulation interrupted.', 1, stim.v);
            abort = 1;
            break;
        end;
        
        if stim.v >= 1;
            percentage = 100 * iTone / stim.nStimuli;
            if mod(percentage, 10) == 0 && percentage ~= lastPercentageDisplayed;
                fprintf('%d%%', percentage);
                lastPercentageDisplayed = percentage;
            else
                fprintf('.');
            end;
        end;

        iTone = iTone + 1;
    end;

    if abort ~= 1;
        o('', 1, stim.v);
        o('    - Stimulation complete.', 1, stim.v);
    end;
    
end;

%% store data
o('    - Saving data...', 2, stim.v);

%     % store the timePoints
%     % a 'quick and dirty' way of using 'lastPulse + 1'
%     stim.timePoints   = RP.ReadTagV('Time',       0,  lastPulse + 1)';
%     stim.freqSeries   = RP.ReadTagV('ToneFreq',   0,  lastPulse + 1)';
%     stim.freqIdSeries = RP.ReadTagV('ToneIdx',    0,  lastPulse + 1)';
% 
%     % remove the starting 0
%     stim.timePoints = stim.timePoints(2:end);
%     stim.freqSeries = stim.freqSeries(2:end);
%     stim.freqIdSeries = stim.freqIdSeries(2:end);


% pause(1);
% stop the circuit
% RP.Halt;

% clean up the figure
close(f);


else % if in high level debug mode    
    if stim.v >= 2;
    % wait user input to send start signal to circuit to start stimulus
    disp('    - Beginning stimulation... (press a key while on figure to stop)');
    disp('    - Stimulation complete.');
    disp('    - Saving data...');
    end;
    stim.timePoints = 0:10:1000;
    stim.freqSeries = rand(100);
    stim.freqIdSeries = rand(100) .* randi(15) - 1;
end % end of 'd < 1' condition

o('    - Saving data done.', 2, stim.v);

% remove the debug 'd' field if not used
if stim.d == 0;
    stim = rmfield(stim, 'd');
end;
% remove the verbosity 'v' field if not used
if stim.v == 0;
    stim = rmfield(stim, 'v');
end;

end


