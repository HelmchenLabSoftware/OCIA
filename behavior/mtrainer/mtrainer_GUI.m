function varargout = mtrainer_GUI(varargin)

% TODO:
%   - stopping the experiment: trial no 100 ? plot ? set buttons to stop ?
%   - reward anyway system
%   - forbid disconnecting HW or changing mouseID while experiment is running
%   - piezoThresh calibrator with setter
%   - online lick ploting
%   - online performance
%   - logging into GUI window
%   - config setter



% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mtrainer_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @mtrainer_GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
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

% --- Executes just before mtrainer_GUI is made visible.
function mtrainer_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mtrainer_GUI (see VARARGIN)

% Choose default command line output for mtrainer_GUI
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
initialize_gui(hObject, handles, false);
set(hObject, 'DeleteFcn', @onWindowClose);
set(hObject, 'Position', [200 800 800 620]);
% --- Outputs from this function are returned to the command line.
function varargout = mtrainer_GUI_OutputFcn(hObject, eventdata, handles) %#ok<*INUSL>
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
% updateGUI();
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

% updateGUI();
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
    
% updateGUI();
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

% updateGUI();

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

% updateGUI();
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
function piezoThreshSetter_Callback(hObject, eventdata, handles)
% hObject    handle to piezoThreshSetter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global main;
main.piezoThresh = get(hObject, 'Value');
set(handles.piezoThresh, 'String', sprintf('%04.2f', main.piezoThresh));
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
% updateGUI();
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
main.basePath = 'C:/Users/laurenczy/Documents/programming/Work/PhD/matlab/behavior/mtrainer/';
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
main.hw = struct();
main.hw.conf = main.configs.hardware.(roomMatch.room);
main.hw.connected = false;
main.hw.analogIns = {'piezo', 'micr', 'yscan'};
main.hw.digitalOuts = {'valve'};
main.hw.recordDur = 8.1;
main.updateRate = 0.1; % 100ms update rate
main.piezoThresh = 0.1;
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
main.GUIUpdateTimer = timer('TimerFcn', @(~, ~)updateGUI(), 'ExecutionMode', 'fixedRate', ...
    'Period', main.updateRate * 1, 'StopFcn', @(~, ~)o('GUIUpdateTimer stopped.', 1, main.dbgLvl), ...
    'ErrorFcn', @(~, ~)o('GUIUpdateTimer stopped with error.', 1, main.dbgLvl));
start(main.GUIUpdateTimer);
main.mouseId = '';
o('Mouse trainer v1.0 initiated.', 1, main.dbgLvl);
function onWindowClose(src, eventData)

global main;
stop(main.GUIUpdateTimer);
delete(main.GUIUpdateTimer);
main.isClosed = true;
%% #connectHW
function connectHW()

global main;
o('Connecting hardware ...', 1, main.dbgLvl);
set(main.handles.connectHW, 'BackgroundColor', 'yellow');
        
main.hw.sampleRate = 0;
nAnIn = numel(main.hw.analogIns);
    
if nAnIn;
    main.analogInData = struct();
    main.hw.anIn = daq.createSession(main.hw.conf.adaptorID);
end;
for iAnIn = 1 : nAnIn;
    
    anInName = main.hw.analogIns{iAnIn};
    
    if ~main.debugMode;
        
        main.hw.sampleRate = main.hw.sampleRate + main.hw.conf.(anInName).sampleRate;
        main.hw.anIn.addAnalogInputChannel(main.hw.conf.(anInName).deviceName, ...
            main.hw.conf.(anInName).channel, 'Voltage');
        main.hw.anIn.Channels(iAnIn).Name = anInName;
        main.hw.anIn.Channels(iAnIn).InputType = main.hw.conf.(anInName).inputType;
        main.hw.anIn.Channels(iAnIn).Range = main.hw.conf.(anInName).range;
        main.analogInData.(anInName) = [];
    else
        o('  "Connecting" fake analog input %d/%d (%s).', iAnIn, nAnIn, anInName, 1, main.dbgLvl);
        main.hw.(anInName) = struct();
%         main.hw.([anInName 'Listener']) = struct();
        main.hw.(anInName).stop = 1;
        main.hw.(anInName).startBackground = 1;
    %     main.hw.(analogInName).IsRunning = @()(round(rand + 0.4));
    %     main.hw.(analogInName).IsRunning = @()(round(rand - 0.4));
        main.hw.(anInName).IsRunning = 1;
        pause(1);
    end;
    o('  Analog input %d/%d (%s): OK.', iAnIn, nAnIn, anInName, 1, main.dbgLvl);
end;
if nAnIn;
    main.hw.([anInName 'Listener']) = main.hw.anIn.addlistener('DataAvailable', @(src, event) storeData(src, event));
    main.hw.anIn.IsNotifyWhenDataAvailableExceedsAuto = true;
    main.hw.anIn.IsContinuous = true;
    main.hw.sampleRate = main.hw.sampleRate / nAnIn;
    main.hw.anIn.Rate = main.hw.sampleRate;
    main.hw.anIn.NotifyWhenDataAvailableExceeds = 200;
%     main.hw.anIn.Rate = 3000;
    main.hw.anIn.prepare();
end;
for iDigOut = 1 : numel(main.hw.digitalOuts);
    digOutName = main.hw.digitalOuts{iDigOut};
    if ~main.debugMode;
        main.hw.(digOutName) = daq.createSession(main.hw.conf.adaptorID);
        main.hw.(digOutName).addDigitalChannel(main.hw.conf.(digOutName).deviceName, ...
            main.hw.conf.(digOutName).portLine, 'OutputOnly');
        main.hw.(digOutName).outputSingleScan(0); % make sure valve is closed
    else
        o('  "Connecting" fake digital output %d (%s).', iDigOut, digOutName, 1, main.dbgLvl);
        main.hw.valve = struct();
        pause(1);
    end;
    o('  Digital output %d (%s): OK.', iDigOut, digOutName, 1, main.dbgLvl);
end;
main.hw.connected = true;
o('Hardware connected.', 1, main.dbgLvl);
if ~strcmp(main.GUIUpdateTimer.Running, 'on');
    start(main.GUIUpdateTimer);
end;
main.hw.anIn.startBackground();
%% #disconnectHW
function disconnectHW()

global main;
o('Disconnecting hardware ...', 1, main.dbgLvl);
if ~main.debugMode;
    
    main.hw.anIn.stop();
    
%     % analog inputs
%     for iAnIn = 1 : numel(main.hw.analogIns);
%         anInName = main.hw.analogIns{iAnIn};
%         if isfield(main.hw, ([anInName 'Listener']));
%             main.hw = rmfield(main.hw, [anInName 'Listener']);
%         end;
%         if isfield(main.hw, anInName);
%             main.hw.(anInName).stop();
%             main.hw = rmfield(main.hw, anInName);
%         end;
%     end;
%     % digital outputs
%     for iDigOut = 1 : numel(main.hw.digitalOuts);
%         digOutName = main.hw.digitalOuts{iDigOut};
%         if isfield(main.hw, digOutName);
% %             main.hw.(digOutName).stop();
%             main.hw = rmfield(main.hw, digOutName);
%         end;
%     end;
    daqreset();
end;
main.hw.connected = false;
o('Hardware disconnected.', 1, main.dbgLvl);
%% #giveReward
function giveReward(rewDur, rewDelay)
    
global main;
if main.hw.connected && isfield(main.hw, 'valve');
    if ~main.debugMode;
        t_rewardStart = tic;
        % wait until for start delay
        while toc(t_rewardStart) < rewDelay; end;
        t_rewardStart = tic;
        % open digital out
%         main.hw.valve.outputSingleScan(0);
        main.hw.valve.outputSingleScan(1);
        % wait until for open duration
        while toc(t_rewardStart) < rewDur; end;
        % close digital out
%         main.hw.valve.outputSingleScan(1);
        main.hw.valve.outputSingleScan(0);
    end;
    o('Rewarding for %.2f sec with a delay of %.2f.', rewDur, rewDelay, 3, main.dbgLvl);
else
    warning('mtrainerGUI:NoRewardHardwareDisconnected', 'Cannot give reward because hardware is disconnected.');
end

%% #updateGUI
function updateGUI()

global main;
% o('#updateGUI()', 1, main.dbgLvl);
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
    
%     stateData(:, 1) = stateData(:, 2);
    stateData(:, 1) = getTrialInfo(main.iTrial - 1);
    stateData(:, 2) = getTrialInfo(main.iTrial);
    if main.iTrial < main.config.training.nTrials;
        stateData(:, 3) = getTrialInfo(main.iTrial + 1);
    else
        stateData(:, 3) = getTrialInfo(0);
    end;
    
else
    
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
delete(get(handles.piezoAxes, 'Children')); % delete previous plot
if isfield(main, 'analogInData');
    hold(handles.piezoAxes, 'on');
    if isfield(main.analogInData, 'yscan');
        nSamples = size(main.analogInData.yscan, 1);
        if nSamples;
            t = (1 : nSamples) / main.hw.sampleRate;
            plot(handles.piezoAxes, t, main.analogInData.yscan * 3, 'b');
        end;
    end;
    if isfield(main.analogInData, 'micr');
        nSamples = size(main.analogInData.micr, 1);
        if nSamples;
            t = (1 : nSamples) / main.hw.sampleRate;
            plot(handles.piezoAxes, t, main.analogInData.micr * 2, 'g');
        end;
    end;
    if isfield(main.analogInData, 'piezo');
        nSamples = size(main.analogInData.piezo, 1);
        if nSamples;
            t = (1 : nSamples) / main.hw.sampleRate;
            plot(handles.piezoAxes, t, main.analogInData.piezo * 10, 'r');
            if isfield(main, 'piezoThresh');
                plot(handles.piezoAxes, [0, t(end)], [main.piezoThresh, main.piezoThresh] * 10, 'r:');
            end;
        end;
    end;
end;
xlim(handles.piezoAxes, [0 main.hw.recordDur]);
ylim(handles.piezoAxes, [-3, 3]);
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
% main.piezoThresh = NaN;
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
% c = onCleanup(@()closeDiaryAndSaveOutput(main.savePath, main.hw.piezoListener, ...
%     main.hw.piezo, main.hw.valve));
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
o('piezoThresh: %1.2f, ISI: %1.2f', main.piezoThresh, main.config.tone.ISI, 1, main.dbgLvl);
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
%             o('Trial %d: pause ended, updating trial number.', main.iTrial, 2, main.dbgLvl);
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
%         updateGUI();
    else
        if ~displayedPause; o(' --- PAUSED --- ', 1, main.dbgLvl); displayedPause = 1; end;
        o('mainLoop#: waiting for %f sec (trial %d).', main.updateRate, main.iTrial, 3, main.dbgLvl);
        pause(main.updateRate);
    end;
    
end;
%% #runTrial
function runTrial()

global main;
nTrials = main.config.training.nTrials;
iTrial = main.iTrial;
% listen for response
% main.hw.anIn.startBackground();
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
%     fprintf('CheckingA: main.hw.piezo.IsRunning()? %d\n', main.hw.piezo.IsRunning());
    % check if experiment is paused/stopped
    if ~main.isRunning; return; end;
    while main.isPaused; pause(main.updateRate); end;
    if ~main.isRunning; return; end;
%     % check if no lick has been done
%     if ~main.hw.piezo.IsRunning(); % if not running anymore, it means a licking has been done
%         remainingTime = main.trialStartDelays(iTrial) - toc(uint64(main.trialStartTimes(iTrial)));
%         if interTrialLickCount > 0;
%             fprintf('|%.1f', remainingTime);
%         else
%             fprintf('    inter-trial licking: |%.1f', remainingTime);
%         end;
% 
%         % reset the starting delay to main.config.training.InTriLickTimerDur
%         main.trialStartTimes(iTrial) = tic;
%         if main.isPunish;
%             main.trialStartDelays(iTrial) = max(main.config.training.InTriLickTimerDur, remainingTime);
%         else
%             main.trialStartDelays(iTrial) = main.config.training.InTriLickTimerDur;
%         end;
%         interTrialLickCount = interTrialLickCount + 1;
%         pause(1);
%         % restart the listening
% %         main.hw.piezo.startBackground();
% %         pause(0.1);
% %             fprintf('CheckingB: main.hw.piezo.IsRunning()? %d\n', main.hw.piezo.IsRunning());
%     end
    % avoid full-speed looping
    pause(0.1);
%     updateGUI();
end;
% if interTrialLickCount;
%     fprintf('|: %d inter-trial lick(s).\n', interTrialLickCount);
% end
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
% if main.hw.piezo.IsRunning();
    
    soundToPlay = main.toneArray{iTrial};
    player = audioplayer(soundToPlay, main.config.tone.samplingFreq);
    player.play;
    
% else
%     fprintf('early (already licking, lick sensor: min/mean/max: %.2f/%.2f/%.2f).\n', recordedValues);
%     main.isPunish = 1;
%     main.respTypes(iTrial) = 5;
%     % analyse every 10 trials
%     if ~rem(iTrial, 10) && iTrial ~= nTrials;
%         mtrainerAnalyser_performance(main.respTypes, 0);
%     end;
%     return;
% end

breakOut = 0;
%% Experiment - wait for response
while toc(t_trialStart) < main.config.training.trialDur;
    
    % check if experiment is paused/stopped
    if ~main.isRunning; return; end;
%     while main.isPaused; pause(main.updateRate); end;
%     if ~main.isRunning; return; end;
    
%     if main.hw.piezo.IsRunning();
    if 1;
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
%     updateGUI();
end;
if breakOut;
    main.trialEndTimes(iTrial) = toc(uint64(main.trialStartTimes(iTrial)));
    % analyse every 10 trials
    if ~rem(iTrial, 10) && iTrial ~= nTrials;
        mtrainerAnalyser_performance(main.respTypes, 0);
    end;
    return; % continue for loop
end;
% if main.hw.piezo.IsRunning();
%     main.hw.piezo.stop();
% end;
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

% global main recordedValues;
% [recordedValues, main.recordedData] = stopWhenExceedThreshold(src, event, main.piezoThresh);
% updateGUI();
%% #storeData
function storeData(src, event)

global main;
nChans = size(event.Data, 2);
for iChan = 1 : nChans;
    anInName = main.hw.analogIns{iChan};
    prevData = main.analogInData.(anInName);
%     currChanData = linScale(event.Data(:, iChan) - mean(event.Data(:, iChan)));
    currChanData = event.Data(:, iChan) - mean(event.Data(:, iChan));
%     currChanData = event.Data(:, iChan);
    allChanData = [prevData; currChanData];
    if size(allChanData, 1) / main.hw.sampleRate > main.hw.recordDur;
        main.analogInData.(anInName) = currChanData;
    else    
        main.analogInData.(anInName) = allChanData;
    end;
    
%     if (size(allChanData, 1) + nSamples) / main.hw.sampleRate > main.hw.recordDur;
%         updateGUI();
%     end;
end;
% normAbsData = abs(normData);
% allData = event.Data;
% supThreshData = normAbsData(normAbsData > main.piezoThresh);
% recordedValues = [min(supThreshData), mean(supThreshData), max(supThreshData)];
% main.recordedData = allData;
% recordDur

% if any(normAbsData > threshold);
% end;
% 
% [recordedValues, main.recordedData] = stopWhenExceedThreshold(src, event, main.piezoThresh);
% updateGUI();


%% #closeDiaryAndSaveOutput
function closeDiaryAndSaveOutput()
    
global main;
o('\nClosing diary... ', 2, main.dbgLvl);
diary off;
o('Closing diary done.', 1, main.dbgLvl);
out = main;
try out.hw = rmfield(out.hw, 'toneArray');          catch e; end; %#ok<NASGU>
try out.hw = rmfield(out.hw, 'piezoListener'); catch e; end; %#ok<NASGU>
try out.hw = rmfield(out.hw, 'piezo');         catch e; end; %#ok<NASGU>
try out.hw = rmfield(out.hw, 'valve');       catch e; end; %#ok<NASGU>
try out.hw = rmfield(out.hw, 'recordedData');           catch e; end; %#ok<NASGU>

if exist('out', 'var');
    matFileName = sprintf('%s_out.mat', main.savePath);
    o('Saving output as %s... ', matFileName, 2, main.dbgLvl);
    save(matFileName, 'out');
    o('Saving output done.', matFileName, 1, main.dbgLvl);
else
    o('/!\\ Output not saved !', 1, main.dbgLvl);
end;
% disconnectHW();
