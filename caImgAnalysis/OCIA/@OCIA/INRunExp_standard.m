function INRunExp_standard(this)
% INRunExp_standard - [no description]
%
%       INRunExp_standard(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

o('#%s ...', mfilename, 3, this.verb);

%% init
% extract the parameters structure
params = this.in.standard;
comParams = this.in.common;

% timing reference
t0 = nowUNIX();
this.in.expStartTime = t0;
this.in.timestamp = datestr(unix2dn(t0), 'HHMMSS');

% update experiment counter
this.in.common.expNumber = this.in.common.expNumber + 1;

% stores the baseline 1 frames for each run
this.in.data.base1Frames = cell(params.nRuns, 1);
% stores the baseline 2 frames for each run
this.in.data.base2Frames = cell(params.nRuns, 1);
% stores the stimulus frames for each run
this.in.data.stimFrames = cell(params.nRuns, 1);

% stores the DFF average frame for each run
this.in.data.baseDFFAvg = cell(params.nRuns, 1);
this.in.data.stimDFFAvg = cell(params.nRuns, 1);

% set the include states
this.in.data.includeInAvg = ones(params.nRuns, 1);

% initialize stimulation
INInitStim(this);

%% init camera
% flush the previous data
stop(this.in.camH);
flushdata(this.in.camH);
% switch to non-stop collection mode and set logging to memory
triggerconfig(this.in.camH, 'manual');
set(this.in.camH, 'FramesPerTrigger', Inf, 'LoggingMode', 'memory');
% start camera but it waits for trigger
start(this.in.camH);

%% starting delay
showMessage(this, sprintf('%s | Intrinsic: starting delay (%.1f sec) ...', INGetTime(this), comParams.startDelay), ...
    'yellow');
pause(comParams.startDelay);
if ~this.in.expRunning; INEndExp(this); return; end;

%% run loop
% loop over all runs
for iRun = 1 : params.nRuns;

    % create the title string
    titleString = sprintf(' | Intrinsic: Run %02d/%02d:', iRun, params.nRuns);

    % collect the baseline frames
    showMessage(this, sprintf('%s%s baseline 1 frames collection ...', INGetTime(this), titleString), 'yellow');
    this.in.data.base1Frames{iRun} = collectData(this, params.baselineAvgDur);
    if ~this.in.expRunning; INEndExp(this); return; end;

    % wait until stimulus time
    showMessage(this, sprintf('%s%s waiting for second baseline ...', INGetTime(this), titleString), 'yellow');
    pause(params.baselineToStimDelay);
    if ~this.in.expRunning; INEndExp(this); return; end;

    % collect the baseline frames
    showMessage(this, sprintf('%s%s baseline 2 frames collection ...', INGetTime(this), titleString), 'yellow');
    this.in.data.base2Frames{iRun} = collectData(this, params.baselineAvgDur);
    % calculate DFF of baseline data
    this.in.data.baseDFFAvg{iRun} = getDFFAvg(this, this.in.data.base1Frames{iRun}, this.in.data.base2Frames{iRun});
    % display data
    INUpdateGUI(this);
    if ~this.in.expRunning; INEndExp(this); return; end;

    % wait until stimulus time
    showMessage(this, sprintf('%s%s waiting for stimulus time ...', INGetTime(this), titleString), 'yellow');
    pause(params.baselineToStimDelay);
    if ~this.in.expRunning; INEndExp(this); return; end;

    % stimulus
    showMessage(this, sprintf('%s%s stimulus ...', INGetTime(this), titleString), 'yellow');
    % play sound using TDT
    if strcmp(comParams.stimMode, 'TDT');
        % use the software trigger to launch the sound
        this.in.RP.SoftTrg(1);
        % wait for it to finish
        pause(params.stdStimDur);
        
    % play sound without TDT
    elseif strcmp(comParams.stimMode, 'soundCard');
        % blocking so that the program waits for the stimlus to finish
        this.in.audioplayer.playblocking();
        
    % send out a digital trigger
    elseif strcmp(comParams.stimMode, 'trigOut');
        outputSingleScan(this.in.daq.sessHandle, 1); % TTL high
        outputSingleScan(this.in.daq.sessHandle, 0); % back to TTL low
        % wait for it to finish
        pause(params.stdStimDur);
        
    end;
    if ~this.in.expRunning; INEndExp(this); return; end;

    % wait until stimulus data collection time
    showMessage(this, sprintf('%s%s waiting for stimulus collection time ...', INGetTime(this), titleString), 'yellow');
    pause(params.stimToStimAvgDelay);
    if ~this.in.expRunning; INEndExp(this); return; end;

    % collect the stimulus frames
    showMessage(this, sprintf('%s%s stimulus frames collection ...', INGetTime(this), titleString), 'yellow');
    this.in.data.stimFrames{iRun} = collectData(this, params.stimAvgDur);
    % calculate DFF of stimulus data
    this.in.data.stimDFFAvg{iRun} = getDFFAvg(this, this.in.data.base1Frames{iRun}, this.in.data.stimFrames{iRun});
    % display data
    INUpdateGUI(this);
    if ~this.in.expRunning; INEndExp(this); return; end;
    
    % wait the end period (recovery), unless it is the last run
    if iRun ~= params.nRuns;
        showMessage(this, sprintf('%s%s waiting for recovery period ...', INGetTime(this), titleString), 'yellow');
        pause(params.waitPeriod);
    end;
    if ~this.in.expRunning; INEndExp(this); return; end;

end;

% clean up and free ressources
INCleanUp(this);

%% spatial downsampling loop
showMessage(this, sprintf('%s | Intrinsic: spatial down-sampling ...', INGetTime(this)));
% loop over all runs
for iRun = 1 : params.nRuns;
    this.in.data.base1Frames{iRun} = INSpatialDownSample(this, this.in.data.base1Frames{iRun});
    this.in.data.base2Frames{iRun} = INSpatialDownSample(this, this.in.data.base2Frames{iRun});
    this.in.data.stimFrames{iRun} = INSpatialDownSample(this, this.in.data.stimFrames{iRun});
end;
showMessage(this, sprintf('%s | Intrinsic: spatial down-sampling done.', INGetTime(this)));

% set flags, update counter and update GUI
this.in.expRunning = false;
set(this.GUI.handles.in.paramPanElems.expNumber, 'String', sprintf('%d', this.in.common.expNumber)); % update in GUI
set(this.GUI.handles.in.runExpBut, 'BackgroundColor', 'red', 'Value', 0);
showMessage(this, sprintf('%s | Intrinsic: experiment number %02d done !', INGetTime(this), this.in.common.expNumber));

end

function frames = collectData(this, collectDur)

% collection start time
t0 = nowUNIXSec();

% start collecting
trigger(this.in.camH);

% start waiting loop
while nowUNIXSec() - t0 < collectDur;
    pause(0.01); % avoid full-speed looping
end;

% stop and collect frames
stop(this.in.camH);
frames = getdata(this.in.camH);
o(['#%s: collected ' regexprep(repmat('%02dx', 1, ndims(frames)), 'x$', '') ' frame(s) ...'], ...
    mfilename(), size(frames), 4, this.verb);

pause(0.02);

% flush data
flushdata(this.in.camH);
% restart camera
start(this.in.camH);

end

% extracts the DFF average of the frames as (F2 - F1) / F1
function DFFAvg = getDFFAvg(this, frames1, frames2)
    % average frames1 over time
    frames1 = INSpatialDownSample(this, nanmean(squeeze(frames1), 3));    
    % average frames2 over time
    frames2 = INSpatialDownSample(this, nanmean(squeeze(frames2), 3));
    
    %% calculate DFF
    DFFAvg = (frames2 - frames1) ./ frames1;
end
