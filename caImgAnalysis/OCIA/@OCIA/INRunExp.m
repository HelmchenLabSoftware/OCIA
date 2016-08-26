function INRunExp(this, ~, ~)
% INRunExp - [no description]
%
%       INRunExp(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

runExpTic = tic;
o('#%s ...', mfilename, 4, this.verb);

%% init
% check for hardware connection state
if ~this.in.connected ...
        && ~strcmp(this.in.common.stimMode, 'trigIn') && ~strcmp(this.in.common.stimMode, 'trigInTTLOut');
    showWarning(this, 'OCIA:INRunExp:HardwareNotConnected', 'Intrinsic: hardware is not connected');
    set(this.GUI.handles.in.runExpBut, 'BackgroundColor', 'red', 'Value', 0);
    return;
end;

% if preview is running, stop it
isPreview = this.in.previewRunning;
if isPreview;
    INPreview(this);
end;

% if already running an experiment abort it
if this.in.expRunning;
    this.in.expRunning = false;
    showMessage(this, sprintf('%s | Intrinsic: stopping experiment ...', INGetTime(this)), 'yellow');
    return;
end;

% otherwise start running an experiment
this.in.expRunning = true;

showMessage(this, sprintf('Intrinsic: running experiment, mode: "%s" ("%s") ...', this.in.expMode, ...
    this.in.common.soundType), 'yellow');
set(this.GUI.handles.in.runExpBut, 'BackgroundColor', 'yellow', 'Value', 1);
pause(0.01);

%% run requested experiment
try
    
    % trigger in mode is different (slave mode)
    if strcmp(this.in.common.stimMode, 'trigIn');
        INRunExp_trigIn(this);
        
    elseif strcmp(this.in.common.stimMode, 'trigInTTLOut');
        INRunExp_trigInTTLOut_prepare(this);
        
    % otherwise run normal experiment
    else
        runExpFuncHandle = str2func(sprintf('INRunExp_%s', this.in.expMode));
        runExpFuncHandle(this);
        
    end;
catch err;
    showWarning(this, 'OCIA:INRunExp:RunError', sprintf('"Intrinsic: error while running experiment: %s (%s)\n%s.', ...
        err.message, err.identifier, getStackText(err)));
    INEndExp(this);
    % make sure internal parameters are matching displayed parameters
    OCIAUpdateVariablesFromParamPanel(this, 'in');
end;
o('#%s: running experiment done: %.1f sec', mfilename, toc(runExpTic), 3, this.verb);

end
