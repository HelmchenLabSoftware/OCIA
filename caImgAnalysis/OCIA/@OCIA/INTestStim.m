
function INTestStim(this, ~, ~)
% INTestStim - [no description]
%
%       INTestStim(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% update button
set(this.GUI.handles.in.testStimBut, 'Value', 1, 'Enable', 'off', 'BackgroundColor', 'yellow');
% disable run exp button
set(this.GUI.handles.in.runExpBut, 'Enable', 'off');

% extract the parameters structure
comParams = this.in.common;

try
    
    % test stimulus differently depending on the stimulus mode
    switch comParams.stimMode;
    
        % play through the sound card
        case 'soundCard';

            % get the sound stimulus of the current setting
            [soundToPlay, sampFreq] = INGetSoundStim(this);
            if isempty(soundToPlay); return; end;
            % use MATLAB sound function
            this.in.audioplayer = audioplayer(soundToPlay, sampFreq);
            this.in.audioplayer.playblocking();
            
        % play by software triggering the TDT
        case { 'TDT', 'trigIn' };

            % get the sound stimulus of the current setting
            [soundToPlay, sampFreq] = INGetSoundStim(this);
            if isempty(soundToPlay); return; end;
            % 1 loop for standard mode and nSweeps for fourier mode
            nLoops = iff(strcmp(this.in.expMode, 'standard'), 1, this.in.fourier.nSweeps);
            % calculate wait time
            waitTime = 1.1 * numel(soundToPlay) * nLoops / sampFreq;
            % load stimulus
            this.in.RP = playTDTSound(soundToPlay, 0, this.GUI.figH, nLoops);
            % launch stimulus with software trigger
            this.in.RP.SoftTrg(1);
            
            % wait for sound to finish
            startWait = tic;
            while ~isempty(this.in.RP) && toc(startWait) < waitTime;
                pause(0.01);
            end;
            
        % send trigger out
        case 'trigOut';
            % show message
            showMessage(this, 'Intrinsic: sending out TTL ...', 'yellow');
            % suppress silly warning about on-demand channels
            warning('off', 'daq:Session:onDemandOnlyChannelsAdded');
            % create NI session with a digital channel
            this.in.daq.sessHandle = daq.createSession(this.in.daq.vendorName);
            addDigitalChannel(this.in.daq.sessHandle, this.in.daq.deviceID, this.in.daq.trigOutPort, 'OutputOnly');
            % restore silly warning
            warning('on', 'daq:Session:onDemandOnlyChannelsAdded');
            % init to TTL low
            outputSingleScan(this.in.daq.sessHandle, 0);
            % send trigger
            outputSingleScan(this.in.daq.sessHandle, 1); % TTL high
            outputSingleScan(this.in.daq.sessHandle, 0); % back to TTL low
            
    end;

% if something failed, capture and abort but still clean up
catch err;
    
    showWarning(this, 'OCIA:INTestStim:TestFailed', ...
        sprintf('Intrinsic: error during testing of stimulation ("%s"): %s.', err.identifier, err.message));
    
end;

% release resources
INCleanUp(this);

end
