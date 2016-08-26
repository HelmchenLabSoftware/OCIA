function INRunExp_trigInTTLOut_prepare(this)
% INRunExp_trigInTTLOut_prepare - [no description]
%
%       INRunExp_trigInTTLOut_prepare(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

o('#%s ...', mfilename, 3, this.verb);

% timing reference
t0 = nowUNIX();
this.in.expStartTime = t0;

% get the parameters
params = this.in.(this.in.expMode);
comParams = this.in.common;

% show message
showMessage(this, 'Intrinsic: preparing for trigger in & TTL out...', 'yellow');

%% init daq components
% create NI session with an input for trigger
this.in.daq.sessHandle = {};
this.in.daq.sessHandle{1} = daq.createSession(this.in.daq.vendorName);
% add trigger input channel
addAnalogInputChannel(this.in.daq.sessHandle{1}, this.in.daq.deviceID, this.in.daq.trigInPort, 'Voltage');
addlistener(this.in.daq.sessHandle{1}, 'DataAvailable', ...
    @(h, e)INCheckTriggerInData(this, h, e, @INRunExp_trigInTTLOut, { this }));
this.in.daq.sessHandle{1}.IsContinuous = true;
this.in.daq.sessHandle{1}.Rate = 5000;

% create NI session with an output for stimulation
this.in.daq.sessHandle{2} = daq.createSession(this.in.daq.vendorName);
% suppress silly warning about on-demand channels
warning('off', 'daq:Session:onDemandOnlyChannelsAdded');
% add trigger output channel
addAnalogOutputChannel(this.in.daq.sessHandle{2}, this.in.daq.deviceID, this.in.daq.trigOutPort{1}, 'Voltage');
addAnalogOutputChannel(this.in.daq.sessHandle{2}, this.in.daq.deviceID, this.in.daq.trigOutPort{2}, 'Voltage');
% restore silly warning
warning('on', 'daq:Session:onDemandOnlyChannelsAdded');
% init to TTL low
outputSingleScan(this.in.daq.sessHandle{2}, [0, 0]);

%% prepare auditory stimulus
% create stimulation protocol holding structure
TTLOutStr = struct();
TTLOutStr.isWorking = false;

% get the stimulus IDs
TTLOutStr.stimVect = repmat(params.stimVect, 1, comParams.nSweeps);
TTLOutStr.stimNames = params.stimIDs(TTLOutStr.stimVect);
TTLOutStr.stimIDs = params.stimIDs;

TTLOutStr.iTrial = 1;
TTLOutStr.nTrials = numel(TTLOutStr.stimVect);

TTLOutStr.amplif = 40;
TTLOutStr.fixedTrigDelay = 0.02;
% TTLOutStr.fixedTrigDelay = -0.09;
sampRate = this.in.common.TDTSampFreq;
    
% multi-sensory
if numel(params.stimIDs) == 4 && all(strcmp(params.stimIDs, { 'auditory', 'visual', 'somatosensory', 'blank' }));
    
    % get the white noise to play
    toneDur = this.in.trial.triStimDur;
    soundsToPlay = makeNoiseTone([1000 25000], toneDur, sampRate);
    
    BLSamples = zeros(1, round((params.BLDur + TTLOutStr.fixedTrigDelay) * sampRate));
    soundsToPlay = [BLSamples, soundsToPlay];
    TTLOutStr.soundsToPlay = soundsToPlay;
    
    % load stimulus
    this.in.RP = playTDTSound(soundsToPlay .* TTLOutStr.amplif, 0, this.GUI.figH, 0);
   
% auditory-only
else

    % create the array of sounds to play
    soundsToPlay = makePureTone(cell2mat(params.stimIDs), params.triStimDur, sampRate);
    if iscell(soundsToPlay); soundsToPlay = cell2mat(soundsToPlay); end;
    BLSamples = zeros(size(soundsToPlay, 1), round((params.BLDur + TTLOutStr.fixedTrigDelay) * sampRate));
    soundsToPlay = [BLSamples, soundsToPlay];
    TTLOutStr.soundsToPlay = soundsToPlay;
    
    % load first stimulus
    this.in.RP = playTDTSound(soundsToPlay(TTLOutStr.stimVect(TTLOutStr.iTrial), :) .* TTLOutStr.amplif, 0, this.GUI.figH, 0);
    
end;

% store the structure
this.in.TTLOutStr = TTLOutStr;


%% start waiting for triggers
if isempty(this.in.daq.sessHandle); return; end;
startBackground(this.in.daq.sessHandle{1});
showMessage(this, 'Intrinsic: waiting for trigger ...', 'yellow');

end


