function varargout = mtrainer_GUI_export(varargin)

% TODO:
%   - stopping the experiment: trial no 100 ? plot ? set buttons to stop ?
%   - reward anyway system
%   - forbid disconnecting HW or changing mouseID while experiment is running
%   - lickThresh calibrator with setter
%   - online lick ploting
%   - online performance
%   - logging into GUI window
%   - config setter



% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mtrainer_GUI_export_OpeningFcn, ...
                   'gui_OutputFcn',  @mtrainer_GUI_export_OutputFcn, ...
                   'gui_LayoutFcn',  @mtrainer_GUI_export_LayoutFcn, ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1});
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout;
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before mtrainer_GUI_export is made visible.
function mtrainer_GUI_export_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mtrainer_GUI_export (see VARARGIN)

% Choose default command line output for mtrainer_GUI_export
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
initialize_gui(hObject, handles, false);
set(hObject, 'DeleteFcn', @onWindowClose);
set(hObject, 'Position', [100 100 800 620]);
% --- Outputs from this function are returned to the command line.
function varargout = mtrainer_GUI_export_OutputFcn(hObject, eventdata, handles) %#ok<*INUSL>
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% --------------------------------------------------------------------
function initialize_gui(fig_handle, handles, isreset) %#ok<*INUSD>
% If the metricdata field is present and the start flag is false, it means
% we are we are just re-initializing a GUI by calling it from the cmd line
% while it is up. So, bail out as we dont want to start the data.

initMain(handles);
updateGUI();
% --- Executes on button press in connectHW.
function connectHW_Callback(hObject, eventdata, handles)
% hObject    handle to connectHWButton_Callback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global main;
if isfield(main.hw, 'connected') && main.hw.connected;
    disconnectHW();
else
    connectHW();
end

updateGUI();
% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global main;
if main.isRunning;
    warning('mtrainerGUI:CannotStartAlreadyRunning', ...
        'Cannot start because experiment is already running and not paused.');
    updateGUI();
    return;
else
    startExperiment();
end
    
updateGUI();
try
    mainLoop();
catch e;
    closeDiaryAndSaveOutput();
    throw(e);
end;
% --- Executes on button press in pause.
function pause_Callback(hObject, eventdata, handles)
% hObject    handle to pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global main;
if main.isRunning;
    if main.isPaused;
        main.isPaused = false;
    else
        main.isPaused = true;
    end
else
    warning('mtrainerGUI:CannotPauseNotRunning', ...
        'Cannot pause because experiment is not running.');
end

updateGUI();

% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles) %#ok<*DEFNU>
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global main;
if main.isRunning;
    main.isRunning = false;
    closeDiaryAndSaveOutput();
else
    warning('mtrainerGUI:CannotStopNotRunning', 'Cannot stop because experiment is not running.');
end

updateGUI();
% --- Executes on button press in reward.
function reward_Callback(hObject, eventdata, handles)
% hObject    handle to reward (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global main;
giveReward(main.rewardDur, 0);
% --- Executes on slider movement.
function rewardDurSetter_Callback(hObject, eventdata, handles)
% hObject    handle to rewardDurSetter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global main;
main.rewardDur = get(hObject,'Value');
set(handles.rewardDur, 'String', sprintf('%04.2f', main.rewardDur));
% --- Executes on slider movement.
function lickThreshSetter_Callback(hObject, eventdata, handles)
% hObject    handle to lickThreshSetter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global main;
main.lickThresh = get(hObject,'Value');
set(handles.lickThresh, 'String', sprintf('%04.2f', main.lickThresh));
% --- Executes when selected cell(s) is changed in config.
function config_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to config (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)

global main;
o('#config_CellSelectionCallback: selection changed: row %d, col %d.', eventdata.Indices, 3, main.dbgLvl);
row = eventdata.Indices(1);
configCell = get(main.handles.config, 'Data');
main.mouseId = configCell{row, 1};
main.taskType = configCell{row, 2};
main.phase = configCell{row, 3};
main.configLoaded = false;
o('#config_CellSelectionCallback: mouseId: %s, taskType: %s, phase: %s.', ...
    main.mouseId, main.taskType, main.phase, 3, main.dbgLvl);
updateGUI();
% --- Executes on button press in loadConfig.
function loadConfig_Callback(hObject, eventdata, handles)
% hObject    handle to loadConfig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

loadConfig();
%% #initMain
function initMain(handles)

global main;
main = struct();
main.dbgLvl = 3;
main.debugMode = 0;
main.basePath = 'P:/programming/Work/PhD/matlab/behavior/mtrainer/';
% main.basePath = 'D:/Users/BaL/programming/Work/PhD/matlab/behavior/mtrainer/';
configsPath = sprintf('%sconfigs.mat', main.basePath);
if ~exist(configsPath, 'file');
    error('mtrainerGUI:initMain:ConfigsFileNotFound', ...
        'Cannot find the configs at "%s" (file not found).', configsPath);
end;
configsMat = load(configsPath);
main.configs = configsMat.configs;
[~, computerName] = system('hostname');
roomMatch = regexp(computerName, '^HIFOWS(?<room>H\d+)\-\d+\s+$', 'names');
if main.debugMode;
    warning('mtrainer_GUI:initMain:DebugMode', 'Debug mode is ON.');
    roomMatch = struct('room', 'H30');
    o('#initMain: debug mode => room tag enforced to: "%s".', roomMatch.room, 1, main.dbgLvl);
end;
if isempty(roomMatch);
    error('mtrainerGUI:initMain:HardwareLoad:NoRoomTagFound', ...
        'Cannot load hardware because there''s no room tag in the computer''s name.');
elseif ~isfield(main.configs.hardware, roomMatch.room);
    error('mtrainerGUI:initMain:HardwareLoad:UnknownRoom', ...
        'Cannot load hardware because room "%s" is unknown.', roomMatch.room);
end;
main.hw = main.configs.hardware.(roomMatch.room);
main.hw.connected = false;
main.updateRate = 0.1; % 100ms update rate

main.isRunning = false;
main.isPaused = false;
main.isClosed = false;
main.configLoaded = false;
main.iTrial = 0;
main.rewardDur = str2double(get(handles.rewardDur,'String'));
main.handles = handles;
stateData = get(main.handles.state, 'Data');
stateData(:, 1) = getTrialInfo(0);
stateData(:, 2) = getTrialInfo(0);
stateData(:, 3) = getTrialInfo(0);
set(main.handles.state, 'Data', stateData);
set(main.handles.config, 'Data', main.configs.animals);
main.mouseId = '';
o('Mouse trainer v1.0 initiated.', 1, main.dbgLvl);
function onWindowClose(src, eventData)

global main;
main.isClosed = true;
%% #connectHW
function connectHW()

global main;
o('Connecting hardware ...', 1, main.dbgLvl);
set(main.handles.connectHW, 'BackgroundColor', 'yellow');
if ~main.debugMode;
    main.hw.lickSensor = daq.createSession(main.hw.adaptorID);
    main.hw.lickSensor.Rate = main.hw.analogIn_SampleRate;
    main.hw.lickSensor.addAnalogInputChannel(main.hw.analogIn_Device, main.hw.analogIn_Channel, 'Voltage');
    main.hw.lickSensor.Channels(1).InputType = main.hw.analogIn_InputType;
    main.hw.lickSensor.Channels(1).Range = main.hw.analogIn_Range;
    
    main.hw.lickSensor.IsNotifyWhenDataAvailableExceedsAuto = true;
    main.hw.lickSensorListener = main.hw.lickSensor.addlistener('DataAvailable', ...
        @(src, event) recordAndStop(src, event));
    main.hw.lickSensor.IsContinuous = true;
    main.hw.lickSensor.prepare();
else
    o('  "Connecting" fake analog input.', 1, main.dbgLvl);
    main.hw.lickSensor = struct();
    main.hw.lickSensorListener = struct();
    main.hw.lickSensor.stop = 1;
    main.hw.lickSensor.startBackground = 1;
%     main.hw.lickSensor.IsRunning = @()(round(rand + 0.4));
%     main.hw.lickSensor.IsRunning = @()(round(rand - 0.4));
    main.hw.lickSensor.IsRunning = 1;
    pause(1);
end;
o('  Analog input (lick sensor and listener): OK.', 1, main.dbgLvl);
if ~main.debugMode;
    main.hw.valveControl = daq.createSession(main.hw.adaptorID);
    main.hw.valveControl.addDigitalChannel(main.hw.digitalOut_Device, main.hw.digitalOut_PortLine, 'OutputOnly');
    main.hw.valveControl.outputSingleScan(0); % make sure valve is closed
else
    o('  "Connecting" fake digital output.', 1, main.dbgLvl);
    main.hw.valveControl = struct();
    pause(1);
end;
o('  Digital output (valve control): OK.', 1, main.dbgLvl);
main.hw.connected = true;
o('Hardware connected.', 1, main.dbgLvl);
%% #disconnectHW
function disconnectHW()

global main;
o('Disconnecting hardware ...', 1, main.dbgLvl);
% analog input
if ~main.debugMode;
    if isfield(main.hw, 'lickSensorListener');
        main.hw = rmfield(main.hw, 'lickSensorListener');
    end;
    if isfield(main.hw, 'lickSensor');
        main.hw.lickSensor.stop();
        main.hw = rmfield(main.hw, 'lickSensor');
    end;
    if isfield(main.hw, 'valveControl');
    %     main.hw.valveControl.stop();
        main.hw = rmfield(main.hw, 'valveControl');
    end;
    daqreset;
end;
main.hw.connected = false;
o('Hardware disconnected.', 1, main.dbgLvl);
%% #giveReward
function giveReward(rewDur, rewDelay)
    
global main;
if main.hw.connected && isfield(main.hw, 'valveControl');
    if ~main.debugMode;
        t_rewardStart = tic;
        % wait until for start delay
        while toc(t_rewardStart) < rewDelay; end;
        t_rewardStart = tic;
        % open digital out
%         main.hw.valveControl.outputSingleScan(0);
        main.hw.valveControl.outputSingleScan(1);
        % wait until for open duration
        while toc(t_rewardStart) < rewDur; end;
        % close digital out
%         main.hw.valveControl.outputSingleScan(1);
        main.hw.valveControl.outputSingleScan(0);
    end;
    o('Rewarding for %.2f sec with a delay of %.2f.', rewDur, rewDelay, 3, main.dbgLvl);
else
    warning('mtrainerGUI:NoRewardHardwareDisconnected', 'Cannot give reward because hardware is disconnected.');
end

%% #updateGUI
function updateGUI()

global main;
if main.isClosed; return; end;
stateData = get(main.handles.state, 'Data');
handles = main.handles;
if main.hw.connected;
    set(handles.connectHW, 'BackgroundColor', 'green');
    set(handles.connectHW, 'Value', 1);
else
    set(handles.connectHW, 'BackgroundColor', 'red');
    set(handles.connectHW, 'Value', 0);
end;
if main.isRunning;
    set(handles.start, 'Value', 1);
    set(handles.start, 'BackgroundColor', 'green');
    if main.isPaused;
        set(handles.pause, 'Value', 1);
        set(handles.pause, 'BackgroundColor', [1 1 0]);
    else
        set(handles.pause, 'Value', 0);
        set(handles.pause, 'BackgroundColor', 'green');
    end;
    
    if isfield(main, 'lickData');
        axes(handles.lickSensorAxes);
        data = abs(main.lickData);
        nSamples = numel(data);
        t = (1 : nSamples) / main.hw.analogIn_SampleRate;
        plot(t, data);
        line([0, t(end)], [main.lickThresh, main.lickThresh], 'Color', 'r');
        ylim([0, 1]);
    end;
    
%     stateData(:, 1) = stateData(:, 2);
    stateData(:, 1) = getTrialInfo(main.iTrial - 1);
    stateData(:, 2) = getTrialInfo(main.iTrial);
    if main.iTrial < main.config.training.nTrials;
        stateData(:, 3) = getTrialInfo(main.iTrial + 1);
    else
        stateData(:, 3) = getTrialInfo(0);
    end;
    
else
    
    axes(handles.lickSensorAxes);
    plot(0, 0);
    
    set(handles.start, 'Value', 0);
    set(handles.start, 'BackgroundColor', 'red');
    set(handles.pause, 'Value', 0);
    set(handles.pause, 'BackgroundColor', 'red');
        
    if main.configLoaded && main.iTrial == 0;
        stateData(:, 3) = getTrialInfo(1);
    else
        stateData(:, 3) = getTrialInfo(0);
    end;
end;
set(main.handles.state, 'Data', stateData);
set(main.handles.configLoaded, 'Value', logical(main.configLoaded));
%% #getTrialInfo
function trialInfo = getTrialInfo(iTrial)

global main;
if iTrial;
    freq = sprintf('%4.2f', main.config.tone.freqs(main.stims(iTrial)) / 1000);
    if isfield(main.config.tone, 'oddProba') && main.config.tone.oddProba > 0; % oddball discrimination
        isTarget = double(main.stims(iTrial) ~= main.odds(iTrial) && main.config.tone.goStim);
    else % frequency discrimination
        isTarget = double(main.stims(iTrial) == main.config.tone.goStim);
    end;
    if isfield(main, 'resps') && ~isnan(main.resps(iTrial));
        resp = main.resps(iTrial);
        respTime = main.respTimes(iTrial);
        if isnan(respTime); respTime = '-'; end;
        corr = double((isTarget && resp) || (~isTarget && ~resp));
        ITL = main.nInTriLick(iTrial);
    else
        resp = '-';
        respTime = '-';
        corr = '-';
        ITL = '-';
    end;
    trialInfo = {iTrial, freq, isTarget, resp, respTime, corr, ITL};
    
else
    trialInfo = {'-', '-', '-', '-', '-', '-', '-'};
end;
%% #loadConfig
function loadConfig()

global main;
o('Loading configuration ...', 2, main.dbgLvl);
if isempty(main.mouseId);
    warning('loadConfig:NoMouseIdSelected', 'Cannot load config because no mouseId is selected.');
    return;
end;
% main.doEmptyWater = 0;
% main.doEmptyWater = 1;
% if > 0, sets the number of seconds to wait before a new run of mtrainer
% main.automode = 5;

main.iTrial = 0;
main.lickThresh = 0.14;
% main.lickThresh = NaN;
main.config = main.configs.behavior.(main.taskType).(main.phase);
%% Setup - stimuli and trials
o('  loadConfig#: setup stimuli and trials... ', 3, main.dbgLvl);
% set up stimulus vector
stims = [];
for iFreq = 1 : numel(main.config.tone.freqs);
    stimForFreq = repmat(iFreq, 1, ...
        round(main.config.tone.stimProba(iFreq) * main.config.training.nTrials));
    stims = [stims, stimForFreq]; %#ok<AGROW>
end

% stim vector should not be randomly permuted
stims = stims(randperm(numel(stims)));
stims = stims(1 : main.config.training.nTrials);
clear stim;
switch(main.taskType);
    case {'freqDiscr', 'oddDiscr'};
        % set up oddball vector by altering stims with a certain probability
        odds = stims;
        oddPos = zeros(size(odds));
        uniqueStims = unique(stims);
        isOdd = rand(1, numel(stims)) < main.config.tone.oddProba;
        uniqueOddPos = main.config.tone.nTones - 1 : main.config.tone.nTones; % last 2 tones can be odd
        for iStim = 1 : numel(isOdd);
            if isOdd(iStim);
                otherStims = uniqueStims(uniqueStims ~= stims(iStim));
                otherStims = otherStims(randperm(numel(otherStims)));
                mixedOddPos = uniqueOddPos(randperm(numel(uniqueOddPos)));
                odds(iStim) = otherStims(1);
                oddPos(iStim) = mixedOddPos(1);
            end;
        end;
        % set up tone array
        main.toneArray = MakePureMultiToneOddballArray(main.config.tone.freqs, stims, odds, oddPos, ...
            main.config.tone.nTones, main.config.tone.stimDur, main.config.tone.ISI, ...
            main.config.tone.samplingFreq);
        
    case 'cotDiscr';
        
        odds = zeros(size(stims));
        oddPos = zeros(size(stims));
        isOdd = zeros(size(stims));
        
        atten = 0.5;
        main.toneArray = MakeCloudOfTonesSound(main.config.tone.uniqueFreqs, main.config.tone.freqIndexes, ...
            main.config.tone.cloudDispersion, stims, main.config.tone.toneDur, main.config.tone.toneISI, ...
            main.config.tone.stimDur, atten, main.config.tone.samplingFreq, 0, 0);
        
        
end;
main.stims = stims;
main.odds = odds;
main.oddPos = oddPos;
main.isOdd = isOdd;
main.configLoaded = true;
updateGUI();
o('  loadConfig#: setup stimuli and trials done. ', 2, main.dbgLvl);
o('Loading configuration done.', 2, main.dbgLvl);
%% #startExperiment
function startExperiment()

global main;
if ~main.configLoaded;
    warning('startExperiment:configNotLoaded', 'Cannot start experiment because config is not loaded.');
    return;
end;
if isempty(main.mouseId);
    warning('startExperiment:NoMouseId', 'Cannot start experiment because there is no mouseId.');
    return;
end;
if ~main.hw.connected;
    warning('startExperiment:HardwareDisconnected', ...
        'Cannot start experiment because hardware is disconnected.');
    return;
end;
o('startExperiment#: initializing experiment ... ', 2, main.dbgLvl);
main.isPaused = false;
main.isRunning = true;
main.iTrial = 1;
    
main.saveTime = datestr(now(), 'yyyy_mm_dd__HH_MM_SS');
% saveFolder = sprintf('D:/Balazs/2013/mtrainerTests/%s/', ...
% saveFolder = sprintf('C:/Users/laurenczy.HIFO/Documents/LocalData/2013/mtrainerTests/%s/', ...
saveFolder = sprintf('C:/Users/laurenczy/mtrainerTests/%s/', main.mouseId);
% saveFolder = sprintf('D:/Users/BaL/PhD/mtrainerTests/%s/', main.mouseId);
main.savePath = sprintf('%s%s__%s', saveFolder, main.mouseId, main.saveTime);
mkdir(saveFolder);
logfile = sprintf('%s_log.txt', main.savePath);
main.logDateFormat = 'yyyy-mm-dd HH:MM:SS.FFF';
% % create an 'onCleanup' function to handle interruptions by CTRL+C
% c = onCleanup(@()closeDiaryAndSaveOutput(main.savePath, main.hw.lickSensorListener, ...
%     main.hw.lickSensor, main.hw.valveControl));
o('  startExperiment#: logFile initialized. Starting diary...', 2, main.dbgLvl);
diary(logfile);
%% Start experiment
o('Experiment start: %s\n\n', datestr(now(), main.logDateFormat), 1, main.dbgLvl);
    

%% Setup - saving settings
global recordedValues;
recordedValues = 0;
o('config: %s phase %s (%dF%dT)', main.taskType, main.phase, numel(main.config.tone.freqs), ...
    main.config.tone.nTones, 0, main.dbgLvl);
o('animal: %s', main.mouseId, 0, main.dbgLvl);
o('savePath: %s', main.savePath, 0, main.dbgLvl);
o('lickThresh: %1.2f, ISI: %1.2f', main.lickThresh, main.config.tone.ISI, 1, main.dbgLvl);
o('rewardCollectionTime: %1.2f, InTriLickTimerDur: %1.2f', main.config.training.rewCollTime, ...
    main.config.training.InTriLickTimerDur, 1, main.dbgLvl);
nTrials = main.config.training.nTrials;
main.trialStartDelays = zeros(1, nTrials);
main.trialStartTimes = zeros(1, nTrials);
main.trialEndTimes = zeros(1, nTrials);
main.respTimes = nan(1, nTrials);
main.nInTriLick = nan(1, nTrials);
main.resps = nan(1, nTrials);
main.respDelays = nan(1, nTrials);
% for each trial: 1 = correct detect, 2 = correct reject, 3 = false alarm, 4 = miss, 5 = early
main.respTypes = nan(1, nTrials);
main.expStartTime = tic;
main.isPunish = 0;
%% #mainLoop
function mainLoop()

global main;
displayedPause = 0;
while main.isRunning;
    
    o('mainLoop#: iTrial = %d.', main.iTrial, 4, main.dbgLvl);
    
    if ~main.isPaused;
        if displayedPause; o(' --- RESUMED --- ', 1, main.dbgLvl); displayedPause = 0; end;
        o('mainLoop#: running trial %d.', main.iTrial, 3, main.dbgLvl);
        runTrial();
        if main.isRunning;
            o('Trial %d: pause ended, updating trial number.', main.iTrial, 2, main.dbgLvl);
            if main.iTrial == main.config.training.nTrials;
                main.isRunning = false;
                %% End experiment
                o('\nExperiment end: %s', datestr(now(), main.logDateFormat), 1, main.dbgLvl);
                main.expTotDurTime = toc(main.expStartTime);
                o('Total time: %02.0f:%02.0f', ...
                    main.expTotDurTime / 60, mod(main.expTotDurTime, 60), main.dbgLvl);
                mtrainerAnalyser_performance(main.respTypes, 2, main.savePath, main.nInTriLick);
                closeDiaryAndSaveOutput();
            else
                main.iTrial = main.iTrial + 1;
                o('Trial %d: updated trial number: %d.', main.iTrial - 1, main.iTrial, 2, main.dbgLvl);
            end;
        else
            o('Trial %d: not running anymore, no update of trial number.', main.iTrial, 2, main.dbgLvl);
        end;
        o('mainLoop#: running trial %d done.', main.iTrial, 3, main.dbgLvl);
        updateGUI();
    else
        if ~displayedPause; o(' --- PAUSED --- ', 1, main.dbgLvl); displayedPause = 1; end;
        o('mainLoop#: waiting for %f sec (trial %d).', main.updateRate, main.iTrial, 3, main.dbgLvl);
        pause(main.updateRate);
    end;
    
end;
%% #runTrial
function runTrial()

global main recordedValues;
nTrials = main.config.training.nTrials;
iTrial = main.iTrial;
% listen for response
main.hw.lickSensor.startBackground();
pause(0.01)
interTrialLickCount = 0;
main.trialStartTimes(iTrial) = tic;
% introduce a random delay for starting the tone
main.trialStartDelays(iTrial) = main.config.training.startDelay + ...
    (rand(1) - 0.5) * 2 * main.config.training.startDelayRand;
% add punishement time-out if needed
if main.isPunish;
    main.trialStartDelays(iTrial) = main.trialStartDelays(iTrial) + main.config.training.timeoutPunish;
end;
%% Experiment - initial wait
while toc(uint64(main.trialStartTimes(iTrial))) < main.trialStartDelays(iTrial);
%             fprintf('CheckingA: main.hw.lickSensor.IsRunning()? %d\n', main.hw.lickSensor.IsRunning());
    % check if experiment is paused/stopped
    if ~main.isRunning; return; end;
%     while main.isPaused; pause(main.updateRate); end;
%     if ~main.isRunning; return; end;
    % check if no lick has been done
    if ~main.hw.lickSensor.IsRunning(); % if not running anymore, it means a licking has been done
        remainingTime = main.trialStartDelays(iTrial) - toc(uint64(main.trialStartTimes(iTrial)));
        if interTrialLickCount > 0;
            fprintf('|%.1f', remainingTime);
        else
            fprintf('    inter-trial licking: |%.1f', remainingTime);
        end;
        % reset the starting delay to main.config.training.InTriLickTimerDur
        main.trialStartTimes(iTrial) = tic;
        if main.isPunish;
            main.trialStartDelays(iTrial) = max(main.config.training.InTriLickTimerDur, remainingTime);
        else
            main.trialStartDelays(iTrial) = main.config.training.InTriLickTimerDur;
        end;
        interTrialLickCount = interTrialLickCount + 1;
        pause(1);
        % restart the listening
        main.hw.lickSensor.startBackground();
        pause(0.1);
%             fprintf('CheckingB: main.hw.lickSensor.IsRunning()? %d\n', main.hw.lickSensor.IsRunning());
    end
    % avoid full-speed looping
    pause(0.01);
end;
if interTrialLickCount;
    fprintf('|: %d inter-trial lick(s).\n', interTrialLickCount);
end
main.nInTriLick(iTrial) = interTrialLickCount;
resp = 0;
main.isPunish = 0;
% check if experiment is paused/stopped
if ~main.isRunning; return; end;
% while main.isPaused; pause(main.updateRate); end;
% if ~main.isRunning; return; end;
    
t_trialStart = tic;
fprintf('Trial %03d/%03d - %s        ... ', iTrial, nTrials, datestr(now(), main.logDateFormat));
%% Experiment - play sound
if main.hw.lickSensor.IsRunning();
    
    soundToPlay = main.toneArray{iTrial};
    player = audioplayer(soundToPlay, main.config.tone.samplingFreq);
    player.play;
    
else
    fprintf('early (already licking, lick sensor: min/mean/max: %.2f/%.2f/%.2f).\n', recordedValues);
    main.isPunish = 1;
    main.respTypes(iTrial) = 5;
    % analyse every 10 trials
    if ~rem(iTrial, 10) && iTrial ~= nTrials;
        mtrainerAnalyser_performance(main.respTypes, 0);
    end;
    return;
end

breakOut = 0;
%% Experiment - wait for response
while toc(t_trialStart) < main.config.training.trialDur;
    
    % check if experiment is paused/stopped
    if ~main.isRunning; return; end;
%     while main.isPaused; pause(main.updateRate); end;
%     if ~main.isRunning; return; end;
    
    if main.hw.lickSensor.IsRunning()
        % no response detected
    else
        % seconds since trial start
        respTime = toc(t_trialStart);
        main.respTimes(iTrial) = respTime;
        % response should be 'minRespTime' after the end of the tone!
        totStimDur = (main.config.tone.stimDur + main.config.tone.ISI) * main.config.tone.nTones - main.config.tone.ISI;
        limitRespTime = totStimDur + main.config.training.minRespTime;
%                 limitRespTime = main.config.training.minRespTime;
        main.respDelays(iTrial) = limitRespTime - respTime;
        % early response, count as kind of false alarm
        if respTime < limitRespTime;
%                     fprintf('early (lick sensor: min/mean/max: %.2f/%.2f/%.2f).\n', recordedValues);
            fprintf('early (response time: %.4f, limit response time: %.4f, diff: %.5f).\n', ...
                respTime, limitRespTime, limitRespTime - respTime);
            main.isPunish = 1;
            main.respTypes(iTrial) = 5;
            breakOut = 1;
            break;
        else
%                     fprintf('Lick at %s\n', datestr(clock, main.logDateFormat))
            resp = 1;
        end;
        break; % break out of while loop
    end;
    pause(0.02); % necessary to allow time for data collection
end;
if breakOut;
    main.trialEndTimes(iTrial) = toc(uint64(main.trialStartTimes(iTrial)));
    % analyse every 10 trials
    if ~rem(iTrial, 10) && iTrial ~= nTrials;
        mtrainerAnalyser_performance(main.respTypes, 0);
    end;
    return; % continue for loop
end;
if main.hw.lickSensor.IsRunning();
    main.hw.lickSensor.stop();
end;
% check if experiment is paused/stopped
if ~main.isRunning; return; end;
% while main.isPaused; pause(main.updateRate); end;
% if ~main.isRunning; return; end;
%% Experiment - analyse response
main.resps(iTrial) = resp;
isOddTrial = main.stims(iTrial) ~= main.odds(iTrial);
if isfield(main.config.tone, 'oddProba') && main.config.tone.oddProba > 0; % oddball discrimination
    isTargetStim = isOddTrial && main.config.tone.goStim;
else % frequency discrimination
    isTargetStim = main.stims(iTrial) == main.config.tone.goStim;
end;
if resp == 1 && isTargetStim;
    % correct response
%             fprintf('correct detection (lick sensor: min/mean/max: %.2f/%.2f/%.2f).\n', recordedValues);
    fprintf('correct detection (response time: %.4f, limit response time: %.4f, diff: %.5f).\n', ...
        respTime, limitRespTime, limitRespTime - respTime);
    main.respTypes(iTrial) = 1;
    % give reward
    giveReward(main.config.training.rewDur, main.config.training.rewDelay);
    % wait to collect the reward
    pause(main.config.training.rewCollTime);
elseif resp == 1 && ~isTargetStim;
    % false alarm
%             fprintf('false alarm (lick sensor: min/mean/max: %.2f/%.2f/%.2f).\n', recordedValues);
    fprintf('false alarm (response time: %.4f, limit response time: %.4f, diff: %.5f).\n', ...
        respTime, limitRespTime, limitRespTime - respTime);
    main.respTypes(iTrial) = 3;
    % punish time-out
    main.isPunish = 1;
elseif resp == 0 && isTargetStim;
    fprintf('miss.\n');
    main.respTypes(iTrial) = 4;
    % punish time-out
    main.isPunish = 1;
 elseif resp == 0 && ~isTargetStim;
    fprintf('correct rejection.\n');
    main.respTypes(iTrial) = 2;
    % go to next trial
end
main.trialEndTimes(iTrial) = toc(uint64(main.trialStartTimes(iTrial)));
% analyse every 10 trials
if ~rem(iTrial, 10) && iTrial ~= nTrials;
    mtrainerAnalyser_performance(main.respTypes, 0);
end;
%% #recordAndStop
function recordAndStop(src, event)

global main recordedValues;
[recordedValues, main.lickData] = stopWhenExceedThreshold(src, event, main.lickThresh);
updateGUI();

%% #closeDiaryAndSaveOutput
function closeDiaryAndSaveOutput()
    
global main;
o('\nClosing diary... ', 2, main.dbgLvl);
diary off;
o('Closing diary done.', 1, main.dbgLvl);
out = main;
try out.hw = rmfield(out.hw, 'toneArray');          catch e; end; %#ok<NASGU>
try out.hw = rmfield(out.hw, 'lickSensorListener'); catch e; end; %#ok<NASGU>
try out.hw = rmfield(out.hw, 'lickSensor');         catch e; end; %#ok<NASGU>
try out.hw = rmfield(out.hw, 'valveControl');       catch e; end; %#ok<NASGU>
try out.hw = rmfield(out.hw, 'lickData');           catch e; end; %#ok<NASGU>

if exist('out', 'var');
    matFileName = sprintf('%s_out.mat', main.savePath);
    o('Saving output as %s... ', matFileName, 2, main.dbgLvl);
    save(matFileName, 'out');
    o('Saving output done.', matFileName, 1, main.dbgLvl);
else
    o('/!\\ Output not saved !', 1, main.dbgLvl);
end;
% disconnectHW();

% --- Creates and returns a handle to the GUI figure. 
function h1 = mtrainer_GUI_export_LayoutFcn(policy)
% policy - create a new figure or use a singleton. 'new' or 'reuse'.

persistent hsingleton;
if strcmpi(policy, 'reuse') & ishandle(hsingleton)
    h1 = hsingleton;
    return;
end
load mtrainer_GUI_export.mat


appdata = [];
appdata.GUIDEOptions = struct(...
    'active_h', [], ...
    'taginfo', struct(...
    'figure', 2, ...
    'pushbutton', 15, ...
    'text', 24, ...
    'edit', 8, ...
    'frame', 4, ...
    'radiobutton', 22, ...
    'uipanel', 15, ...
    'slider', 5, ...
    'popupmenu', 4, ...
    'listbox', 3, ...
    'togglebutton', 3, ...
    'checkbox', 4, ...
    'uitable', 4, ...
    'axes', 2), ...
    'override', 1, ...
    'release', 13, ...
    'resize', 'none', ...
    'accessibility', 'callback', ...
    'mfile', 1, ...
    'callbacks', 1, ...
    'singleton', 1, ...
    'syscolorfig', 1, ...
    'blocking', 0, ...
    'lastSavedFile', 'P:\programming\Work\PhD\matlab\behavior\mtrainer_GUI_export.m', ...
    'lastFilename', 'P:\programming\Work\PhD\matlab\behavior\mtrainer\mtrainer_GUI.fig');
appdata.lastValidTag = 'figure1';
appdata.GUIDELayoutEditor = [];
appdata.initTags = struct(...
    'handle', [], ...
    'tag', 'figure1');

h1 = figure(...
'PaperUnits',get(0,'defaultfigurePaperUnits'),...
'Color',[0.941176470588235 0.941176470588235 0.941176470588235],...
'Colormap',[0 0 0.5625;0 0 0.625;0 0 0.6875;0 0 0.75;0 0 0.8125;0 0 0.875;0 0 0.9375;0 0 1;0 0.0625 1;0 0.125 1;0 0.1875 1;0 0.25 1;0 0.3125 1;0 0.375 1;0 0.4375 1;0 0.5 1;0 0.5625 1;0 0.625 1;0 0.6875 1;0 0.75 1;0 0.8125 1;0 0.875 1;0 0.9375 1;0 1 1;0.0625 1 1;0.125 1 0.9375;0.1875 1 0.875;0.25 1 0.8125;0.3125 1 0.75;0.375 1 0.6875;0.4375 1 0.625;0.5 1 0.5625;0.5625 1 0.5;0.625 1 0.4375;0.6875 1 0.375;0.75 1 0.3125;0.8125 1 0.25;0.875 1 0.1875;0.9375 1 0.125;1 1 0.0625;1 1 0;1 0.9375 0;1 0.875 0;1 0.8125 0;1 0.75 0;1 0.6875 0;1 0.625 0;1 0.5625 0;1 0.5 0;1 0.4375 0;1 0.375 0;1 0.3125 0;1 0.25 0;1 0.1875 0;1 0.125 0;1 0.0625 0;1 0 0;0.9375 0 0;0.875 0 0;0.8125 0 0;0.75 0 0;0.6875 0 0;0.625 0 0;0.5625 0 0],...
'DockControls','off',...
'IntegerHandle','off',...
'InvertHardcopy',get(0,'defaultfigureInvertHardcopy'),...
'MenuBar','none',...
'Name','mtrainer_GUI',...
'NumberTitle','off',...
'PaperPosition',get(0,'defaultfigurePaperPosition'),...
'PaperSize',get(0,'defaultfigurePaperSize'),...
'PaperType',get(0,'defaultfigurePaperType'),...
'Position',[544 0 801 625],...
'Resize','off',...
'HandleVisibility','callback',...
'UserData',[],...
'Tag','figure1',...
'Visible','on',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'hwPanel';

h2 = uipanel(...
'Parent',h1,...
'Units','characters',...
'Title','Hardware',...
'Tag','hwPanel',...
'Clipping','on',...
'Position',[1.8 28.6923076923077 24.2 18.5384615384615],...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'connectHW';

h3 = uicontrol(...
'Parent',h2,...
'Units','characters',...
'BackgroundColor',[1 0 0],...
'Callback',@(hObject,eventdata)mtrainer_GUI_export('connectHW_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[1.8 15.3846153846154 20 1.76923076923077],...
'String','CONNECT HW',...
'Style','togglebutton',...
'Tag','connectHW',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'reward';

h4 = uicontrol(...
'Parent',h2,...
'Units','characters',...
'Callback',@(hObject,eventdata)mtrainer_GUI_export('reward_Callback',hObject,eventdata,guidata(hObject)),...
'CData',[],...
'ListboxTop',0,...
'Position',[1.8 13.0769230769231 20.2 1.76923076923077],...
'String','REWARD',...
'UserData',[],...
'Tag','reward',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'rewardDurLabel';

h5 = uicontrol(...
'Parent',h2,...
'Units','characters',...
'HorizontalAlignment','left',...
'Position',[1.8 10 17.2 2.46153846153846],...
'String',{  'reward dur.'; '[sec]' },...
'Style','text',...
'Tag','rewardDurLabel',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'rewardDur';

h6 = uicontrol(...
'Parent',h2,...
'Units','characters',...
'FontSize',10,...
'Position',[13.8 10.3076923076923 8.2 1.61538461538462],...
'String','0.3',...
'Style','text',...
'Tag','rewardDur',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'rewardDurSetter';

h7 = uicontrol(...
'Parent',h2,...
'Units','characters',...
'BackgroundColor',[0.9 0.9 0.9],...
'Callback',@(hObject,eventdata)mtrainer_GUI_export('rewardDurSetter_Callback',hObject,eventdata,guidata(hObject)),...
'Max',20,...
'Min',0.01,...
'Position',[1.6 8.38461538461538 20.2 1.61538461538462],...
'String',{  'Slider' },...
'Style','slider',...
'SliderStep',[0.01 0],...
'Value',0.3,...
'Tag','rewardDurSetter',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'lickThreshLabel';

h8 = uicontrol(...
'Parent',h2,...
'Units','characters',...
'HorizontalAlignment','left',...
'Position',[2 5.46153846153846 17.2 2.46153846153846],...
'String',{  'lick threshold'; '[sec]' },...
'Style','text',...
'Tag','lickThreshLabel',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'lickThresh';

h9 = uicontrol(...
'Parent',h2,...
'Units','characters',...
'FontSize',10,...
'Position',[14 5.76923076923077 8.2 1.61538461538462],...
'String','0.14',...
'Style','text',...
'Tag','lickThresh',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'lickThreshSetter';

h10 = uicontrol(...
'Parent',h2,...
'Units','characters',...
'BackgroundColor',[0.9 0.9 0.9],...
'Callback',@(hObject,eventdata)mtrainer_GUI_export('lickThreshSetter_Callback',hObject,eventdata,guidata(hObject)),...
'Max',0.5,...
'Min',0.01,...
'Position',[1.8 3.84615384615385 20.2 1.61538461538462],...
'String',{  'Slider' },...
'Style','slider',...
'SliderStep',[0.01 0],...
'Value',0.3,...
'Tag','lickThreshSetter',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'expControlPanel';

h11 = uipanel(...
'Parent',h1,...
'Units','characters',...
'Title','Experiment control',...
'Tag','expControlPanel',...
'Clipping','on',...
'Position',[26.6 43.3076923076923 56.4 3.92307692307692],...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'stop';

h12 = uicontrol(...
'Parent',h11,...
'Units','characters',...
'Callback',@(hObject,eventdata)mtrainer_GUI_export('stop_Callback',hObject,eventdata,guidata(hObject)),...
'CData',[],...
'ListboxTop',0,...
'Position',[38 0.538461538461539 16.4 1.76923076923077],...
'String','STOP',...
'UserData',[],...
'Tag','stop',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'start';

h13 = uicontrol(...
'Parent',h11,...
'Units','characters',...
'Callback',@(hObject,eventdata)mtrainer_GUI_export('start_Callback',hObject,eventdata,guidata(hObject)),...
'CData',[],...
'ListboxTop',0,...
'Position',[1.8 0.538461538461539 16.2 1.76923076923077],...
'String','START',...
'Style','togglebutton',...
'HitTest','off',...
'UserData',[],...
'Tag','start',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'pause';

h14 = uicontrol(...
'Parent',h11,...
'Units','characters',...
'Callback',@(hObject,eventdata)mtrainer_GUI_export('pause_Callback',hObject,eventdata,guidata(hObject)),...
'CData',[],...
'ListboxTop',0,...
'Position',[19.8 0.538461538461539 16.2 1.76923076923077],...
'String','PAUSE',...
'Style','togglebutton',...
'UserData',[],...
'Tag','pause',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'currStatePanel';

h15 = uipanel(...
'Parent',h1,...
'Units','characters',...
'Title','Current state',...
'Tag','currStatePanel',...
'Clipping','on',...
'Position',[27 27.9230769230769 55 14.6923076923077],...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'state';
appdata.PropertyMetaData = {  {  'DataPropertyDimension' 'DataPropertyConditionedDimension' 'DataPropertySource' 'BackgroundColorPropertyDimension' 'ColumnNameTyped' 'RowNameTyped' } {  [4 2] [7 3] 'DataDefault' [2 3] {  'prev' 'curr' 'next' } {  'iTrial' 'freq' 'targ?' 'resp?' 'respTime' 'corr?' 'ITL' } } };

h16 = uitable(...
'Parent',h15,...
'Units','characters',...
'BackgroundColor',[1 1 1;0.96078431372549 0.96078431372549 0.96078431372549],...
'ColumnFormat',{  'numeric' 'numeric' 'numeric' },...
'ColumnEditable',mat{1},...
'ColumnName',{  'prev'; 'curr'; 'next' },...
'ColumnWidth',{  53 53 53 },...
'Data',{  [] [] []; [] [] []; [] [] []; [] [] []; [] [] []; [] [] []; [] [] [] },...
'FontSize',7,...
'Position',[1.8 0.692307692307692 50.4 12.4615384615385],...
'RowName',{  'iTrial'; 'freq'; 'targ?'; 'resp?'; 'respTime'; 'corr?'; 'ITL' },...
'UserData',[],...
'Tag','state',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'configPanel';

h17 = uipanel(...
'Parent',h1,...
'Units','characters',...
'Title','Config',...
'Tag','configPanel',...
'Clipping','on',...
'Position',[83.8 14.0769230769231 74.2 33.1538461538462],...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'config';
appdata.PropertyMetaData = {  {  'DataPropertyDimension' 'DataPropertyConditionedDimension' 'DataPropertySource' 'BackgroundColorPropertyDimension' 'ColumnNameTyped' 'RowNameTyped' } {  [4 2] [4 3] 'DataDefault' [2 3] {  'mouseId' 'taskType' 'phase' } {  blanks(0) blanks(0) blanks(0) blanks(0) } } };

h18 = uitable(...
'Parent',h17,...
'Units','characters',...
'ColumnFormat',{  [] [] [] },...
'ColumnEditable',mat{2},...
'ColumnName',{  'mouseId'; 'taskType'; 'phase' },...
'ColumnWidth',{  85 100 50 },...
'Data',{  blanks(0) blanks(0) blanks(0); blanks(0) blanks(0) blanks(0); blanks(0) blanks(0) blanks(0); blanks(0) blanks(0) blanks(0) },...
'Position',[1.4 17.6153846153846 48.6 13.9230769230769],...
'RowName',blanks(0),...
'CellSelectionCallback',@(hObject,eventdata)mtrainer_GUI_export('config_CellSelectionCallback',hObject,eventdata,guidata(hObject)),...
'UserData',[],...
'Tag','config',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'loadConfig';

h19 = uicontrol(...
'Parent',h17,...
'Units','characters',...
'Callback',@(hObject,eventdata)mtrainer_GUI_export('loadConfig_Callback',hObject,eventdata,guidata(hObject)),...
'CData',[],...
'ListboxTop',0,...
'Position',[51.8 29.7692307692308 16.4 1.76923076923077],...
'String','LOAD',...
'UserData',[],...
'Tag','loadConfig',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'configLoaded';

h20 = uicontrol(...
'Parent',h17,...
'Units','characters',...
'Enable','inactive',...
'Position',[51.8 27.4615384615385 21.2 1.76923076923077],...
'String','Config loaded ?',...
'Style','checkbox',...
'SelectionHighlight','off',...
'Tag','configLoaded',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'lickSensorAxes';

h21 = axes(...
'Parent',h1,...
'Units','characters',...
'Position',[5.8 14.8461538461538 74.2 12.4615384615385],...
'CameraPosition',[0.5 0.5 9.16025403784439],...
'CameraPositionMode',get(0,'defaultaxesCameraPositionMode'),...
'Color',get(0,'defaultaxesColor'),...
'ColorOrder',get(0,'defaultaxesColorOrder'),...
'LooseInset',[23.218 6.19384615384616 16.967 4.22307692307692],...
'XColor',get(0,'defaultaxesXColor'),...
'YColor',get(0,'defaultaxesYColor'),...
'ZColor',get(0,'defaultaxesZColor'),...
'Tag','lickSensorAxes',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

h22 = get(h21,'title');

set(h22,...
'Parent',h21,...
'Units','data',...
'FontUnits','points',...
'BackgroundColor','none',...
'Color',[0 0 0],...
'DisplayName',blanks(0),...
'EdgeColor','none',...
'EraseMode','normal',...
'DVIMode','auto',...
'FontAngle','normal',...
'FontName','Helvetica',...
'FontSize',10,...
'FontWeight','normal',...
'HorizontalAlignment','center',...
'LineStyle','-',...
'LineWidth',0.5,...
'Margin',2,...
'Position',[0.5 1.04012345679012 1.00005459937205],...
'Rotation',0,...
'String',blanks(0),...
'Interpreter','tex',...
'VerticalAlignment','bottom',...
'ButtonDownFcn',[],...
'CreateFcn', {@local_CreateFcn, [], ''} ,...
'DeleteFcn',[],...
'BusyAction','queue',...
'HandleVisibility','off',...
'HelpTopicKey',blanks(0),...
'HitTest','on',...
'Interruptible','on',...
'SelectionHighlight','on',...
'Serializable','on',...
'Tag',blanks(0),...
'UserData',[],...
'Visible','on',...
'XLimInclude','on',...
'YLimInclude','on',...
'ZLimInclude','on',...
'CLimInclude','on',...
'ALimInclude','on',...
'IncludeRenderer','on',...
'Clipping','off');

h23 = get(h21,'xlabel');

set(h23,...
'Parent',h21,...
'Units','data',...
'FontUnits','points',...
'BackgroundColor','none',...
'Color',[0 0 0],...
'DisplayName',blanks(0),...
'EdgeColor','none',...
'EraseMode','normal',...
'DVIMode','auto',...
'FontAngle','normal',...
'FontName','Helvetica',...
'FontSize',10,...
'FontWeight','normal',...
'HorizontalAlignment','center',...
'LineStyle','-',...
'LineWidth',0.5,...
'Margin',2,...
'Position',[0.497304582210243 -0.145061728395062 1.00005459937205],...
'Rotation',0,...
'String',blanks(0),...
'Interpreter','tex',...
'VerticalAlignment','cap',...
'ButtonDownFcn',[],...
'CreateFcn', {@local_CreateFcn, [], ''} ,...
'DeleteFcn',[],...
'BusyAction','queue',...
'HandleVisibility','off',...
'HelpTopicKey',blanks(0),...
'HitTest','on',...
'Interruptible','on',...
'SelectionHighlight','on',...
'Serializable','on',...
'Tag',blanks(0),...
'UserData',[],...
'Visible','on',...
'XLimInclude','on',...
'YLimInclude','on',...
'ZLimInclude','on',...
'CLimInclude','on',...
'ALimInclude','on',...
'IncludeRenderer','on',...
'Clipping','off');

h24 = get(h21,'ylabel');

set(h24,...
'Parent',h21,...
'Units','data',...
'FontUnits','points',...
'BackgroundColor','none',...
'Color',[0 0 0],...
'DisplayName',blanks(0),...
'EdgeColor','none',...
'EraseMode','normal',...
'DVIMode','auto',...
'FontAngle','normal',...
'FontName','Helvetica',...
'FontSize',10,...
'FontWeight','normal',...
'HorizontalAlignment','center',...
'LineStyle','-',...
'LineWidth',0.5,...
'Margin',2,...
'Position',[-0.0768194070080863 0.490740740740741 1.00005459937205],...
'Rotation',90,...
'String',blanks(0),...
'Interpreter','tex',...
'VerticalAlignment','bottom',...
'ButtonDownFcn',[],...
'CreateFcn', {@local_CreateFcn, [], ''} ,...
'DeleteFcn',[],...
'BusyAction','queue',...
'HandleVisibility','off',...
'HelpTopicKey',blanks(0),...
'HitTest','on',...
'Interruptible','on',...
'SelectionHighlight','on',...
'Serializable','on',...
'Tag',blanks(0),...
'UserData',[],...
'Visible','on',...
'XLimInclude','on',...
'YLimInclude','on',...
'ZLimInclude','on',...
'CLimInclude','on',...
'ALimInclude','on',...
'IncludeRenderer','on',...
'Clipping','off');

h25 = get(h21,'zlabel');

set(h25,...
'Parent',h21,...
'Units','data',...
'FontUnits','points',...
'BackgroundColor','none',...
'Color',[0 0 0],...
'DisplayName',blanks(0),...
'EdgeColor','none',...
'EraseMode','normal',...
'DVIMode','auto',...
'FontAngle','normal',...
'FontName','Helvetica',...
'FontSize',10,...
'FontWeight','normal',...
'HorizontalAlignment','right',...
'LineStyle','-',...
'LineWidth',0.5,...
'Margin',2,...
'Position',[-0.0795148247978437 2.65740740740741 1.00005459937205],...
'Rotation',0,...
'String',blanks(0),...
'Interpreter','tex',...
'VerticalAlignment','middle',...
'ButtonDownFcn',[],...
'CreateFcn', {@local_CreateFcn, [], ''} ,...
'DeleteFcn',[],...
'BusyAction','queue',...
'HandleVisibility','off',...
'HelpTopicKey',blanks(0),...
'HitTest','on',...
'Interruptible','on',...
'SelectionHighlight','on',...
'Serializable','on',...
'Tag',blanks(0),...
'UserData',[],...
'Visible','off',...
'XLimInclude','on',...
'YLimInclude','on',...
'ZLimInclude','on',...
'CLimInclude','on',...
'ALimInclude','on',...
'IncludeRenderer','on',...
'Clipping','off');


hsingleton = h1;


% --- Set application data first then calling the CreateFcn. 
function local_CreateFcn(hObject, eventdata, createfcn, appdata)

if ~isempty(appdata)
   names = fieldnames(appdata);
   for i=1:length(names)
       name = char(names(i));
       setappdata(hObject, name, getfield(appdata,name));
   end
end

if ~isempty(createfcn)
   if isa(createfcn,'function_handle')
       createfcn(hObject, eventdata);
   else
       eval(createfcn);
   end
end


% --- Handles default GUIDE GUI creation and callback dispatch
function varargout = gui_mainfcn(gui_State, varargin)

gui_StateFields =  {'gui_Name'
    'gui_Singleton'
    'gui_OpeningFcn'
    'gui_OutputFcn'
    'gui_LayoutFcn'
    'gui_Callback'};
gui_Mfile = '';
for i=1:length(gui_StateFields)
    if ~isfield(gui_State, gui_StateFields{i})
        error(message('MATLAB:guide:StateFieldNotFound', gui_StateFields{ i }, gui_Mfile));
    elseif isequal(gui_StateFields{i}, 'gui_Name')
        gui_Mfile = [gui_State.(gui_StateFields{i}), '.m'];
    end
end

numargin = length(varargin);
if numargin == 0
    % MTRAINER_GUI_EXPORT
    % create the GUI only if we are not in the process of loading it
    % already
    gui_Create = true;
elseif local_isInvokeActiveXCallback(gui_State, varargin{:})
    % MTRAINER_GUI_EXPORT(ACTIVEX,...)
    vin{1} = gui_State.gui_Name;
    vin{2} = [get(varargin{1}.Peer, 'Tag'), '_', varargin{end}];
    vin{3} = varargin{1};
    vin{4} = varargin{end-1};
    vin{5} = guidata(varargin{1}.Peer);
    feval(vin{:});
    return;
elseif local_isInvokeHGCallback(gui_State, varargin{:})
    % MTRAINER_GUI_EXPORT('CALLBACK',hObject,eventData,handles,...)
    gui_Create = false;
else
    % MTRAINER_GUI_EXPORT(...)
    % create the GUI and hand varargin to the openingfcn
    gui_Create = true;
end

if ~gui_Create
    % In design time, we need to mark all components possibly created in
    % the coming callback evaluation as non-serializable. This way, they
    % will not be brought into GUIDE and not be saved in the figure file
    % when running/saving the GUI from GUIDE.
    designEval = false;
    if (numargin>1 && ishghandle(varargin{2}))
        fig = varargin{2};
        while ~isempty(fig) && ~ishghandle(fig,'figure')
            fig = get(fig,'parent');
        end
        
        designEval = isappdata(0,'CreatingGUIDEFigure') || isprop(fig,'__GUIDEFigure');
    end
        
    if designEval
        beforeChildren = findall(fig);
    end
    
    % evaluate the callback now
    varargin{1} = gui_State.gui_Callback;
    if nargout
        [varargout{1:nargout}] = feval(varargin{:});
    else       
        feval(varargin{:});
    end
    
    % Set serializable of objects created in the above callback to off in
    % design time. Need to check whether figure handle is still valid in
    % case the figure is deleted during the callback dispatching.
    if designEval && ishghandle(fig)
        set(setdiff(findall(fig),beforeChildren), 'Serializable','off');
    end
else
    if gui_State.gui_Singleton
        gui_SingletonOpt = 'reuse';
    else
        gui_SingletonOpt = 'new';
    end

    % Check user passing 'visible' P/V pair first so that its value can be
    % used by oepnfig to prevent flickering
    gui_Visible = 'auto';
    gui_VisibleInput = '';
    for index=1:2:length(varargin)
        if length(varargin) == index || ~ischar(varargin{index})
            break;
        end

        % Recognize 'visible' P/V pair
        len1 = min(length('visible'),length(varargin{index}));
        len2 = min(length('off'),length(varargin{index+1}));
        if ischar(varargin{index+1}) && strncmpi(varargin{index},'visible',len1) && len2 > 1
            if strncmpi(varargin{index+1},'off',len2)
                gui_Visible = 'invisible';
                gui_VisibleInput = 'off';
            elseif strncmpi(varargin{index+1},'on',len2)
                gui_Visible = 'visible';
                gui_VisibleInput = 'on';
            end
        end
    end
    
    % Open fig file with stored settings.  Note: This executes all component
    % specific CreateFunctions with an empty HANDLES structure.

    
    % Do feval on layout code in m-file if it exists
    gui_Exported = ~isempty(gui_State.gui_LayoutFcn);
    % this application data is used to indicate the running mode of a GUIDE
    % GUI to distinguish it from the design mode of the GUI in GUIDE. it is
    % only used by actxproxy at this time.   
    setappdata(0,genvarname(['OpenGuiWhenRunning_', gui_State.gui_Name]),1);
    if gui_Exported
        gui_hFigure = feval(gui_State.gui_LayoutFcn, gui_SingletonOpt);
        % make figure invisible here so that the visibility of figure is
        % consistent in OpeningFcn in the exported GUI case
        if isempty(gui_VisibleInput)
            gui_VisibleInput = get(gui_hFigure,'Visible');
        end
        set(gui_hFigure,'Visible','off')

        % openfig (called by local_openfig below) does this for guis without
        % the LayoutFcn. Be sure to do it here so guis show up on screen.
        movegui(gui_hFigure,'onscreen');
    else
        gui_hFigure = local_openfig(gui_State.gui_Name, gui_SingletonOpt, gui_Visible);
        % If the figure has InGUIInitialization it was not completely created
        % on the last pass.  Delete this handle and try again.
        if isappdata(gui_hFigure, 'InGUIInitialization')
            delete(gui_hFigure);
            gui_hFigure = local_openfig(gui_State.gui_Name, gui_SingletonOpt, gui_Visible);
        end
    end
    if isappdata(0, genvarname(['OpenGuiWhenRunning_', gui_State.gui_Name]))
        rmappdata(0,genvarname(['OpenGuiWhenRunning_', gui_State.gui_Name]));
    end

    % Set flag to indicate starting GUI initialization
    setappdata(gui_hFigure,'InGUIInitialization',1);
    % Fetch GUIDE Application options
    gui_Options = getappdata(gui_hFigure,'GUIDEOptions');
    % Singleton setting in the GUI M-file takes priority if different
    gui_Options.singleton = gui_State.gui_Singleton;
    if ~isappdata(gui_hFigure,'GUIOnScreen')
        % Adjust background color
        if gui_Options.syscolorfig
            set(gui_hFigure,'Color', get(0,'DefaultUicontrolBackgroundColor'));
        end

        % Generate HANDLES structure and store with GUIDATA. If there is
        % user set GUI data already, keep that also.
        data = guidata(gui_hFigure);
        handles = guihandles(gui_hFigure);
        if ~isempty(handles)
            if isempty(data)
                data = handles;
            else
                names = fieldnames(handles);
                for k=1:length(names)
                    data.(char(names(k)))=handles.(char(names(k)));
                end
            end
        end
        guidata(gui_hFigure, data);
    end

    % Apply input P/V pairs other than 'visible'
    for index=1:2:length(varargin)
        if length(varargin) == index || ~ischar(varargin{index})
            break;
        end

        len1 = min(length('visible'),length(varargin{index}));
        if ~strncmpi(varargin{index},'visible',len1)
            try set(gui_hFigure, varargin{index}, varargin{index+1}), catch break, end
        end
    end

    % If handle visibility is set to 'callback', turn it on until finished
    % with OpeningFcn
    gui_HandleVisibility = get(gui_hFigure,'HandleVisibility');
    if strcmp(gui_HandleVisibility, 'callback')
        set(gui_hFigure,'HandleVisibility', 'on');
    end

    feval(gui_State.gui_OpeningFcn, gui_hFigure, [], guidata(gui_hFigure), varargin{:});
    if isscalar(gui_hFigure) && ishghandle(gui_hFigure)
        % Handle the default callbacks of predefined toolbar tools in this
        % GUI, if any
        guidemfile('restoreToolbarToolPredefinedCallback',gui_hFigure);
        
        % Update handle visibility
        set(gui_hFigure,'HandleVisibility', gui_HandleVisibility);
        % Call openfig again to pick up the saved visibility or apply the
        % one passed in from the P/V pairs
        if ~gui_Exported
            gui_hFigure = local_openfig(gui_State.gui_Name, 'reuse',gui_Visible);
        elseif ~isempty(gui_VisibleInput)
            set(gui_hFigure,'Visible',gui_VisibleInput);
        end
        if strcmpi(get(gui_hFigure, 'Visible'), 'on')
            figure(gui_hFigure);
            
            if gui_Options.singleton
                setappdata(gui_hFigure,'GUIOnScreen', 1);
            end
        end

        % Done with GUI initialization
        if isappdata(gui_hFigure,'InGUIInitialization')
            rmappdata(gui_hFigure,'InGUIInitialization');
        end

        % If handle visibility is set to 'callback', turn it on until
        % finished with OutputFcn
        gui_HandleVisibility = get(gui_hFigure,'HandleVisibility');
        if strcmp(gui_HandleVisibility, 'callback')
            set(gui_hFigure,'HandleVisibility', 'on');
        end
        gui_Handles = guidata(gui_hFigure);
    else
        gui_Handles = [];
    end

    if nargout
        [varargout{1:nargout}] = feval(gui_State.gui_OutputFcn, gui_hFigure, [], gui_Handles);
    else
        feval(gui_State.gui_OutputFcn, gui_hFigure, [], gui_Handles);
    end

    if isscalar(gui_hFigure) && ishghandle(gui_hFigure)
        set(gui_hFigure,'HandleVisibility', gui_HandleVisibility);
    end
end

function gui_hFigure = local_openfig(name, singleton, visible)

% openfig with three arguments was new from R13. Try to call that first, if
% failed, try the old openfig.
if nargin('openfig') == 2
    % OPENFIG did not accept 3rd input argument until R13,
    % toggle default figure visible to prevent the figure
    % from showing up too soon.
    gui_OldDefaultVisible = get(0,'defaultFigureVisible');
    set(0,'defaultFigureVisible','off');
    gui_hFigure = openfig(name, singleton);
    set(0,'defaultFigureVisible',gui_OldDefaultVisible);
else
    gui_hFigure = openfig(name, singleton, visible);
    %workaround for CreateFcn not called to create ActiveX
    if feature('HGUsingMATLABClasses')
        peers=findobj(findall(allchild(gui_hFigure)),'type','uicontrol','style','text');
        for i=1:length(peers)
            if isappdata(peers(i),'Control')
                actxproxy(peers(i));
            end            
        end
    end
end

function result = local_isInvokeActiveXCallback(gui_State, varargin)

try
    result = ispc && iscom(varargin{1}) ...
             && isequal(varargin{1},gcbo);
catch
    result = false;
end

function result = local_isInvokeHGCallback(gui_State, varargin)

try
    fhandle = functions(gui_State.gui_Callback);
    result = ~isempty(findstr(gui_State.gui_Name,fhandle.file)) || ...
             (ischar(varargin{1}) ...
             && isequal(ishghandle(varargin{2}), 1) ...
             && (~isempty(strfind(varargin{1},[get(varargin{2}, 'Tag'), '_'])) || ...
                ~isempty(strfind(varargin{1}, '_CreateFcn'))) );
catch
    result = false;
end


