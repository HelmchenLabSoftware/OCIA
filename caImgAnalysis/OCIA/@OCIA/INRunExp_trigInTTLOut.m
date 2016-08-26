function INRunExp_trigInTTLOut(this)
% INRunExp_trigInTTLOut - [no description]
%
%       INRunExp_trigInTTLOut(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

params = this.in.(this.in.expMode);
if this.in.TTLOutStr.isWorking; return; end;

if ~this.in.expRunning;
    exitTriggerMode(this, struct('identifier', 'OCIA:INRunExp_trigInTTLOut:Aborted', ...
        'message', 'Error during stimulation ("OCIA:INRunExp_trigInTTLOut:Aborted"): aborted.'));
end;

% showMessage(this, sprintf('%s | Intrinsic: trigger time !', INGetTime(this)));
this.in.TTLOutStr.isWorking = true;

try    

    this.in.TTLOutStr.trigTime = nowUNIXSec();
    iTrial = this.in.TTLOutStr.iTrial;
    stimNum = this.in.TTLOutStr.stimVect(iTrial);
    stimID = this.in.TTLOutStr.stimNames{iTrial};
    if isnumeric(stimID); stimID = sprintf('%d', stimID); end;
    showMessage(this, sprintf('%s | Intrinsic: trial %d / %d, current stimulus: %d (%s) ...', ...
        INGetTime(this), iTrial, this.in.TTLOutStr.nTrials, stimNum, stimID));

    % stimulation depends on current trial type
    switch stimID;
        
        case 'auditory';
%             % launch stimulus with software trigger
%             this.in.RP.SoftTrg(1);
            
        case 'visual';
            INSendTTLOutTrigger(this, [5 0], 1, [0.1, 0], this.in.trial.BLDur + this.in.TTLOutStr.fixedTrigDelay);
            
        case 'somatosensory';
            INSendTTLOutTrigger(this, [0 2], 2, [0.025, 0.025], this.in.trial.BLDur + this.in.TTLOutStr.fixedTrigDelay);
            
        case 'blank';
            % do nothing
        
        otherwise;
            % if it is a frequency
            if regexp(stimID, '\d+');
                % launch stimulus with software trigger
                this.in.RP.SoftTrg(1);
                
            else
                exitTriggerMode(this, struct('identifier', 'OCIA:INRunExp_trigInTTLOut:UnknownStim', ...
                    'message', 'Error during stimulation ("OCIA:INRunExp_trigInTTLOut:UnknownStim"): unknown stimulus.'));
            end;
    end;
        
    this.in.TTLOutStr.iTrial = this.in.TTLOutStr.iTrial + 1;
    
    isMultiSensory = numel(params.stimIDs) == 4 ...
        && all(strcmp(params.stimIDs, { 'auditory', 'visual', 'somatosensory', 'blank' }));
    
    % if number of trials is reached
    if this.in.TTLOutStr.iTrial > this.in.TTLOutStr.nTrials;
        pauseTicToc(1);
        exitTriggerMode(this, []);
        return;
    
    % multi-sensory
    elseif isMultiSensory;
        % wait and prepare next stimulus
        pause(1.1 * (this.in.trial.BLDur + this.in.trial.triStimDur));
        iNextTrial = this.in.TTLOutStr.iTrial;
        stimNumNextTrial = this.in.TTLOutStr.stimVect(iNextTrial);
        stimIDNextTrial = this.in.TTLOutStr.stimNames{iNextTrial};
        if isnumeric(stimIDNextTrial); stimIDNextTrial = sprintf('%d', stimIDNextTrial); end;
        
        % next stim is auditory
        if strcmp(stimIDNextTrial, 'auditory');
            showMessage(this, sprintf('%s | Intrinsic: preparing next trial as auditory %d / %d, %d (%s) ...', ...
                INGetTime(this), iNextTrial, this.in.TTLOutStr.nTrials, stimNumNextTrial, stimIDNextTrial));
            % load sound stimulus
            this.in.RP = playTDTSound(this.in.TTLOutStr.soundsToPlay .* this.in.TTLOutStr.amplif, 0, this.GUI.figH, 0);
        else
            showMessage(this, sprintf('%s | Intrinsic: preparing next trial as no-sound %d / %d, %d (%s) ...', ...
                INGetTime(this), iNextTrial, this.in.TTLOutStr.nTrials, stimNumNextTrial, stimIDNextTrial));
            % load empty stimulus
            this.in.RP = playTDTSound([0 0], 0, this.GUI.figH, 0);
        end;
        
    % if not in multi-sensory mode  
    elseif ~isMultiSensory;
        % wait and prepare next stimulus
        pause(1.1 * (this.in.trial.BLDur + this.in.trial.triStimDur));
        iNextTrial = this.in.TTLOutStr.iTrial;
        stimNumNextTrial = this.in.TTLOutStr.stimVect(iNextTrial);
        stimIDNextTrial = this.in.TTLOutStr.stimNames{iNextTrial};
        if isnumeric(stimIDNextTrial); stimIDNextTrial = sprintf('%d', stimIDNextTrial); end;
        showMessage(this, sprintf('%s | Intrinsic: preparing next trial with freq %d / %d, %d (%s) ...', ...
            INGetTime(this), iNextTrial, this.in.TTLOutStr.nTrials, stimNumNextTrial, stimIDNextTrial));
        % prepare next stimulus
        currentSoundToPlay = this.in.TTLOutStr.soundsToPlay(this.in.TTLOutStr.stimVect(this.in.TTLOutStr.iTrial), :);
        this.in.RP = playTDTSound(currentSoundToPlay .* this.in.TTLOutStr.amplif, 0, this.GUI.figH, 0);
        
    end;
    
% if something failed
catch err;
    exitTriggerMode(this, err);
    
end;

this.in.TTLOutStr.isWorking = false;

end

function exitTriggerMode(this, err)

warning('off', 'MATLAB:callback:error');

% stop data aquisition
stop(this.in.daq.sessHandle{1});

% stop timer
if isfield(this.in.TTLOutStr, 'timer');
    stop(this.in.TTLOutStr.timer);
end;
this.in.TTLOutStr.isWorking = false;

if ~isempty(err);
    showWarning(this, 'OCIA:INRunExp_trigInTTLOut:StimFailed', ...
        sprintf('Error during stimulation ("%s"): %s.', err.identifier, err.message));
    
end;

% release resources
INCleanUp(this);

% set flags, update counter and update GUI
this.in.expRunning = false;
set(this.GUI.handles.in.runExpBut, 'BackgroundColor', 'red', 'Value', 0);

if isempty(err);
    showMessage(this, sprintf('%s | Intrinsic: finished.', INGetTime(this)));
else
    showMessage(this, sprintf('%s | Intrinsic: aborted.', INGetTime(this)));
end;

warning('on', 'MATLAB:callback:error');
    
end


