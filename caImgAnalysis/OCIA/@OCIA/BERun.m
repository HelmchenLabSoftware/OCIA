function BERun(this, ~, ~)
% BERun - [no description]
%
%       BERun(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% capture any error to be sure to save output
try
    
    % if experiment is running
    if this.be.isRunning;

        % if trial 1 and no experiment start time, experiment just started so initialize it
        if this.be.iTrial == 1 && ~isfield(this.be, 'expStartTime') || isempty(this.be.expStartTime);
            this.GUI.be.displayedPause = 0;
            this.be.expStartTime = nowUNIXSec;
            this.be.trialPhase = 'init'; % start the trial with the initialization
            
        end;

        o('#%s: iTrial = %d.', mfilename(), this.be.iTrial, 3, this.verb);

        % if experiment needs to be paused, do not do it yet
        if this.be.isPaused;
            o('#%s: waiting for the right phase to pause ...', mfilename(), 3, this.verb);
        end;

        % if trial is not yet finished
        if ~strcmp(this.be.trialPhase, 'finished') && ~strcmp(this.be.trialPhase, 'paused');

            % run the trial
            o('#%s: running trial %03d ...', mfilename(), this.be.iTrial, 3, this.verb);
            BERunTrial(this);
            
        end;

        % if trial is finished or experiment aborted
        if this.be.iTrial > 0 && (strcmp(this.be.trialPhase, 'finished') ...
                || strcmp(this.be.trialPhase, 'paused') || ~this.be.isRunning);

            % only end trial if it was not already ended
            if isnan(this.be.times.end(this.be.iTrial)) || ~this.be.isRunning; 
                
                o('#%s: ending trial %03d ...', mfilename(), this.be.iTrial, 3, this.verb);
                BEEndTrial(this);  
                
            end;

            % if in pause mode
            if this.be.isPaused;

                % pause message not yet displayed, so display it
                if ~this.GUI.be.displayedPause;
                    o(' --- PAUSED --- ', 1, this.verb);
                    this.GUI.be.displayedPause = 1;
                    
                    % mark trial as paused
                    this.be.trialPhase = 'paused';
                
                end;
                o('#%s: waiting for pause to end (trial %d) ...', mfilename(), this.be.iTrial, 3, this.verb);
                
                
            % not in pause mode, go on
            else
                
                % if experiment is still running
                if this.be.isRunning;
                
                    % if "paused" was displayed, display the "resumed" message
                    if this.GUI.be.displayedPause;
                        o(' --- RESUMED --- ', 1, this.verb);
                        this.GUI.be.displayedPause = 0;
                        
                        % move to next phase
                        this.be.trialPhase = 'finished';
                        
                    end;

                    % if this was the last trial, stop experiment
                    if this.be.iTrial == this.be.config.training.nTrials;

                        % stop experiment
                        this.be.isRunning = false;
                        o('Behavior: last trial.', 3, this.verb);

                    % if not the last trial, update the trial number and start a new trial
                    else
                        this.be.trialPhase = 'init'; % start the trial with the initialization
                        this.be.iTrial = this.be.iTrial + 1;
                        o('Behavior: trial %03d -> %03d.', this.be.iTrial - 1, this.be.iTrial, 3, this.verb);

                    end;

                % experiment aborted
                else
                    o('Trial %d: not running anymore, no update of trial number.', this.be.iTrial, 3, this.verb);

                end;
                
            end;

        end;

        % if experiment was running but is not anymore, it was either finished or aborted
        if ~this.be.isRunning;

            o('#%s: experiment stopped/aborted ...', mfilename(), 2, this.verb);
            set(this.GUI.handles.be.startExp, 'BackgroundColor', 'red', 'Value', 0);
            set(this.GUI.handles.be.pauseExp, 'BackgroundColor', 'red', 'Value', 0);

            % finalize experiment
            this.be.expEndTime = nowUNIXSec - this.be.expStartTime;
            showMessage(this, sprintf('Behavior: experiment ended (%d/%d trials, %.0f seconds).', this.be.iTrial, ...
                this.be.config.training.nTrials, this.be.expEndTime));

            % save the output the recorded data
            BESaveOutput(this);

            % mark the variables to be reset on next launch
            this.be.isToReset = true;
            
            % if experiment is to be looped
            if get(this.GUI.handles.be.loopBehavOn, 'Value');
                showMessage(this, sprintf('Behavior: re-starting experimenet in %.1f seconds ...', ...
                    this.be.params.loopBehavDelay));
                this.GUI.be.loopBehavTimer = timer('Name', 'ExperimentLooperTimer', 'TimerFcn', @(h, e)BEStartExp(this), ...
                    'StartDelay', this.be.params.loopBehavDelay);
                start(this.GUI.be.loopBehavTimer);
                
            else
                this.GUI.be.loopBehavTimer = [];
                
            end;
        end;
        

    % experiment not running anymore
    elseif this.be.iTrial > 0 && this.be.iTrial <= this.be.config.training.nTrials && isfield(this.be.times, 'start') ...
            && ~isnan(this.be.times.start(this.be.iTrial)) && isnan(this.be.times.end(this.be.iTrial)); 

        o('#%s: ending trial %03d ...', mfilename(), this.be.iTrial, 3, this.verb);
        BEEndTrial(this);  

    end;
    
% update GUI if it is time to do so
if nowUNIXSec() - this.GUI.be.GUILastUpdateTime > this.GUI.be.GUIUpdateRate;
    % update the GUI and the "lastUpdateTime" field as well
    BEUpdateGUI(this);
end;

% capture any error
catch err;
    
    % save output
    BESaveOutput(this);
   
    % show error
    errStack = getStackText(err);
    showWarning(this, 'OCIA:BERun', sprintf('Behavior: caught error (%s): "%s".', err.identifier, err.message));
    o(errStack, 0, 0);
    
end;


end

