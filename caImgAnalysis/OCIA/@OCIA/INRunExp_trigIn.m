function INRunExp_trigIn(this)
% INRunExp_trigIn - [no description]
%
%       INRunExp_trigIn(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

o('#%s ...', mfilename, 3, this.verb);

% timing reference
t0 = nowUNIX();
this.in.expStartTime = t0;

% get the sound stimulus of the current setting
soundToPlay = INGetSoundStim(this);

try  

    % load stimulus
    showMessage(this, sprintf('%s | Intrinsic: "trigIn" mode, uploading sound to TDT ...', INGetTime(this)), 'yellow');
    % 1 loop for standard mode and nSweeps for fourier mode
    nLoops = iff(strcmp(this.in.expMode, 'standard'), 1, this.in.fourier.nSweeps);
    this.in.RP = playTDTSound(soundToPlay, 0, this.GUI.figH, nLoops);
    
    showMessage(this, sprintf('%s | Intrinsic: "trigIn" mode, waiting for trigger ...', INGetTime(this)), 'yellow');

    % wait for the experiment to stop
    while this.in.expRunning;
        
        o('%s | Intrinsic: "trigIn" mode: waiting for triggers ...', INGetTime(this), 4, this.verb);
        % avoid full-speed looping
        pause(1);
    end;
    
% if something failed
catch err;
    
    showWarning(this, 'OCIA:INRunExp_trigIn:StimFailed', sprintf('Error during playing of stimulation ("%s"): %s.', ...
        err.identifier, err.message));
    
end;

% release resources
INCleanUp(this);

% set flags, update counter and update GUI
this.in.expRunning = false;
set(this.GUI.handles.in.runExpBut, 'BackgroundColor', 'red', 'Value', 0);
showMessage(this, sprintf('%s | Intrinsic: done.', INGetTime(this)));


end
