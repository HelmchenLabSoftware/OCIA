function INInitStim(this, ~, ~)
% INInitStim - [no description]
%
%       INInitStim(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

showMessage(this, sprintf('%s | Intrinsic: initializing stim ...', INGetTime(this)), 'yellow');

% extract the parameters structure
comParams = this.in.common;

% if sound card usage is requested, initialize it
if strcmp(comParams.stimMode, 'soundCard');

    % get the sound stimulus of the current setting
    [soundToPlay, sampFreq] = INGetSoundStim(this);
    this.in.audioplayer = audioplayer(soundToPlay, sampFreq);
        
% if TDT usage is requested, initialize it without looping
elseif strcmp(comParams.stimMode, 'TDT');

    % get the sound stimulus of the current setting
    soundToPlay = INGetSoundStim(this);
    this.in.RP = playTDTSound(soundToPlay, 0, this.GUI.figH, 0);
    
% if trigger sending is required, create a DAQ session with a digital out channel
elseif strcmp(comParams.stimMode, 'trigOut');
    % suppress silly warning about on-demand channels
    warning('off', 'daq:Session:onDemandOnlyChannelsAdded');
    % create NI session with a digital channel
    this.in.daq.sessHandle = daq.createSession(this.in.daq.vendorName);
    addDigitalChannel(this.in.daq.sessHandle, this.in.daq.deviceID, this.in.daq.trigOutPort, 'OutputOnly');
    % restore silly warning
    warning('on', 'daq:Session:onDemandOnlyChannelsAdded');
    % init to TTL low
    outputSingleScan(this.in.daq.sessHandle, 0);
    
% other stimulus modes are not allowed here
else
    showWarning(this, 'OCIA:InitStim:UnknownStimMode', ...
        sprintf('%s | Intrinsic: unknown stim. mode "%s". Aborting.', INGetTime(this), comParams.stimMode));
    INEndExp(this);
    
end;

end
