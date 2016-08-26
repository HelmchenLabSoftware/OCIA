function [stim, abort] = PlayStimulationSequence(varargin)
% Runs a Tucker Davis circuit to play a sequence of sound stimulations.
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
% ephysRate     rate of the ephys recording [Hz]. If -1, not saved in stim
%               struct (default: -1).
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
addOptional(IP, 'ephysRate',    -1,     @isnumeric);
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

if stim.noTDT;
    PlayStimulationSequenceNoTDT(varargin{:});
    return;
end;

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

rootPath = 'C:\TDT\Balazs_RPvdsEx_Circuits\';

% select the right circuit according to stimulation type
% use for deviants probability: XXX_pp1 is the file for 10%, XXX_pp3 for 30% and XXX_pp5 for 50%.
switch(stim.stimType);
    case 'BF' % best frequency characterization
        if stim.useBLN > 0;
            stim.circuitPath  = [rootPath 'RandomFreqBandLimitedNoise.rcx'];
        elseif stim.useFMSweep > 0;
            stim.circuitPath  = [rootPath 'RandomFreqFMSweep.rcx'];
        else
            stim.circuitPath  = [rootPath 'PureTone_exp.rcx'];
%             stim.circuitPath  = [rootPath 'PureTone_linear.rcx'];
        end;
    case 'SSA_DEV' % SSA with a deviant frequency
        if stim.useBLN > 0;
            stim.circuitPath  = sprintf('%sSSA_pp%d_BLN.rcx', rootPath, stim.proba / 10);
        elseif stim.useFMSweep > 0 && stim.proba == 10;
            stim.circuitPath  = sprintf('%sSSA_pp%d_FMSweep.rcx', rootPath, stim.proba / 10);
        elseif stim.useFMSweep > 0;
            error('PlayStimulationSequence:CircuitNotImplemented', ...
                'Error SSA_DEV with FM sweep not implemented!');
        else
            stim.circuitPath  = sprintf('%sSSA_pp%d.rcx', rootPath, stim.proba / 10);
        end;
    case 'SSA_OMI' % SSA with an omission as deviant
        if stim.useBLN > 0;
            stim.circuitPath  = [rootPath 'SSA_DevOmi_pp' num2str(stim.proba / 10) '_BLN.rcx'];
        elseif stim.useFMSweep > 0;
            error('PlayStimulationSequence:CircuitNotImplemented', ...
                'Error SSA_OMI with FM sweep not implemented!');
        else
            stim.circuitPath  = [rootPath 'SSA_DevOmi_pp' num2str(stim.proba / 10) '.rcx'];
        end;
    case 'ODD_TRIAL' % short (~6 tones) sequence with an oddball in one of the last 3 positions
        if stim.useBLN > 0;
            error('PlayStimulationSequence:CircuitNotImplemented', ...
                'Error ODD_TRIAL with BLN not implemented!');
        elseif stim.useFMSweep > 0;
            stim.circuitPath  = [rootPath 'OddTrial.rcx'];
        else
            error('PlayStimulationSequence:CircuitNotImplemented', ...
                'Error ODD_TRIAL with tones not implemented!');
        end;
    otherwise
        error('PlayStimulationSequence:UnknownStimType', ...
            'Unknown stim type: "%s"!', stim.stimType);
end;

if stim.v >= 1;
fprintf(['    - Stimulation sequence: type "%s", attenLevel: %d, randomSeed: %d, ' ...
    'nStimuli: %d, BFreqIndex: %d, proba: %d, freqDev: %.2f, swap: %d, stimDur: %d ms, ' ...
    'duty cycle: %d ms, ephys rate: %d Hz.\n'], ...
    stim.stimType, stim.attenLevel, stim.randomSeed, stim.nStimuli, stim.BFreqIndex, ...
    stim.proba, stim.freqDev, stim.swap, stim.stimDur, stim.dutyCycle, stim.ephysRate);
end;

if stim.d < 2; % if not in high level debug mode
%% connect to device and circuit
fprintf('    - Connecting to device with circuit: "%s" ...\n', stim.circuitPath);
RP = actxcontrol('RPco.x', [0 0 0 0]);
if RP.ConnectRZ6('GB', 1) == 0;
    error('PlayStimulationSequence:ConnectRZ6Failed', 'Error connecting to device! (#ConnectRZ6)');
end;
if RP.LoadCOF(stim.circuitPath) == 0;
    error('PlayStimulationSequence:LoadCOFFailed', 'Error connecting to device! (#LoadCOF)');
end;

% calculate the Hi and Low times for the ramp of the pulses and between pulses
TimeHi = 1; % [ms]
TimeLow = stim.dutyCycle - TimeHi;
TimeHi_S = stim.stimDur;
TimeLow_S = stim.stimDur + 100; % TimeHi_S + TimeLow_S < dutyCycle!

%% start the circuit
RP.Run;
pause(1);

% feed the circuit with the inputs
RP.SetTagVal('TimeHi', TimeHi);
RP.SetTagVal('TimeLow', TimeLow);
RP.SetTagVal('NumPulse', stim.nStimuli);
RP.SetTagVal('AttLevel', stim.attenLevel); % for BF and SSA_DEV
RP.SetTagVal('Att', stim.attenLevel); % for SSA_OMI
RP.SetTagVal('TimeHi_S', TimeHi_S);
RP.SetTagVal('TimeLow_S', TimeLow_S);
RP.SetTagVal('startDelay', stim.startDelay);
RP.SendParTable('stimMatrix', stim.randomSeed);

% feed some additional parameters to the circuit if needed
switch(stim.stimType)
    case 'SSA_DEV'
        RP.SetTagVal('CFIdx', stim.BFreqIndex);
        RP.SetTagVal('fDev', stim.freqDev);
        RP.SetTagVal('Swap', stim.swap);
    case 'SSA_OMI'
        RP.SetTagVal('CFIdx', stim.BFreqIndex);
        RP.SetTagVal('Swap', stim.swap);
    case 'ODD_TRIAL'
        RP.SetTagVal('CFIdx', stim.BFreqIndex);
        RP.SetTagVal('Swap', stim.swap);
end;

% set the band limited noise's frequency range above and under the current frequency played
if stim.useBLN > 0;
    RP.SetTagVal('FreqRange', stim.useBLN);
    RP.SetTagVal('FreqMultiply', 4000);
    RP.SetTagVal('FreqAdd', 1000);
% sets the FM sweeps's frequency ramp above the current frequency played
elseif stim.useFMSweep > 0;
    RP.SetTagVal('FreqRange', stim.useFMSweep);
end;

% create a figure to be able to check for an abort command
f = gcf;

if stim.useExtTrig > 0;
    if stim.v >= 1;
        fprintf('      Waiting for trigger (%d sec timeout)...\n', stim.useExtTrig);
    end;
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
    doStimulation = 1;
end;

% if not ext. trig. required or if it was successfully received, proceed...
if doStimulation;

    %% start stimulation
    % send start signal to circuit to start stimulus
    RP.SoftTrg(1);
    if stim.v >= 2;
    disp('    - Beginning stimulation... (press any key while on figure to stop)');
    end;

    if stim.v >= 1;
        fprintf('      ');
        lastPercentageDisplayed = -1;
    end;
    % Check every second for an abort command
    while (RP.GetTagVal('Index') < stim.nStimuli);
        pause(stim.dutyCycle / 1000);
        lastPulse = RP.GetTagVal('Index');
        if strcmp(get(f,'CurrentCharacter'), '') == 0;
            if stim.v >= 1;
                fprintf('\n');
                disp('    - Stimulation interrupted.');
            end;
            abort = 1;
            break;
        end;

        if stim.v >= 1;
            percentage = 100 * RP.GetTagVal('Index') / stim.nStimuli;
            if mod(percentage, 10) == 0 && percentage ~= lastPercentageDisplayed;
                fprintf('%d%%', percentage);
                lastPercentageDisplayed = percentage;
            else
                fprintf('.');
            end;
        end;

    end;

    if abort ~= 1 && stim.v >= 1;
        fprintf('\n');
        disp('    - Stimulation complete.');
    end;

    %% store data
    if stim.v >= 2;
    disp('    - Saving data...');
    end;

    % store the timePoints
    % a 'quick and dirty' way of using 'lastPulse + 1'
    stim.timePoints   = RP.ReadTagV('Time',       0,  lastPulse + 1)';
    stim.freqSeries   = RP.ReadTagV('ToneFreq',   0,  lastPulse + 1)';
    stim.freqIdSeries = RP.ReadTagV('ToneIdx',    0,  lastPulse + 1)';

    % remove the starting 0
    stim.timePoints = stim.timePoints(2:end);
    stim.freqSeries = stim.freqSeries(2:end);
    stim.freqIdSeries = stim.freqIdSeries(2:end);
end;

pause(1);
% stop the circuit
RP.Halt;

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

if stim.v >= 2;
disp('    - Stimulation done.');
end;

% remove the ephysRate field if not used
if stim.ephysRate == -1;
    stim = rmfield(stim, 'ephysRate');
end;
% remove the debug 'd' field if not used
if stim.d == 0;
    stim = rmfield(stim, 'd');
end;
% remove the verbosity 'v' field if not used
if stim.v == 0;
    stim = rmfield(stim, 'v');
end;

end


