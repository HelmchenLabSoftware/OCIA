function this = OCIA_modeConfig_behavior(this)
% adds the behavior mode to the OCIA

%% -- properties: path: Behavior
if ispc();
    docPath = winqueryreg('HKEY_CURRENT_USER', 'Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders', 'Personal');
else
    docPath = char(java.lang.System.getProperty('user.home'));
end;
% path of the behavior configuration mat-file
this.path.behavConf = sprintf('%s/LabVIEW Data/mainConf.mat', docPath);
% path where the behavior data should be saved
this.path.behavSave = sprintf('%s/LabVIEW Data/%s/', docPath, datestr(date, 'yyyy_mm_dd'));

%% -- properties: GUI: Behavior
this.GUI.be = struct();
% update rate
this.GUI.be.updateRate = 0.01;
% GUI update rate
this.GUI.be.GUIUpdateRate = 0.25;
% update rate of the trial timer
this.GUI.be.GUILastUpdateTime = -1;
% handle for the GUI updating timer object
this.GUI.be.updateTimer = [];
% handle for the video triggering timer object
this.GUI.be.vidTrigTimer = [];
% handle for the behavior looping
this.GUI.be.loopBehavTimer = [];
% currently selected behavior configuration row
this.GUI.be.selConfigRow = [];
% names of the behavior auto-reward modes
this.GUI.be.autoRewModes = { 'EarlyOn', 'On', 'Auto', 'Off' };
% names of the behavior configiguration table's columns
this.GUI.be.confTableColNames = { 'AnimalID', 'TaskType', 'Phase' };
% widths of the behavior animal config table's columns
this.GUI.be.confTableColW = { 0.35 0.4 0.2 };
% names of the behavior experiment table's columns
this.GUI.be.expTableColNames = { 'Prev.', 'Curr.', 'Next' };
% widths of the behavior experiment table's columns
this.GUI.be.expTableColW = { 0.22 0.21 0.21 0.21 };
% names of the behavior ETL table's rows
this.GUI.be.expTableRowNames = { 'iTrial', 'Spot', 'Freq', 'Target', 'Response', 'Resp. Time', 'Correct', 'Reward' };
% names of the behavior ETL table's columns
this.GUI.be.ETLTableColNames = { 'Name', 'Volt', 'Depth', 'Laser' };
% widths of the behavior ETL table's columns
this.GUI.be.ETLTableColW = { 0.40 0.19 0.19 0.19 };
% analog input's magnification factor on the behavior monitoring plot
this.GUI.be.anInMagnifs = [0.1 3 50];
% analog input's offset on the behavior monitoring plot
this.GUI.be.anInOffset = [0 0 -2];
% analog input's filtering options on the behavior monitoring plot
this.GUI.be.anInFilt = [0 0 0];
% analog input's absolute-apply options on the behavior monitoring plot
this.GUI.be.anInDoAbs = [0 0 1];
% analog input's sum-apply options on the behavior monitoring plot
this.GUI.be.anInDoSpecial = [0, 0, 0];
% analog input's sum-apply options on the behavior monitoring plot
this.GUI.be.anInDoSumChunckLength = [0, 0, 0];
% y plot limits for the behavior mode's monitoring plot
this.GUI.be.monPlotLimits = [-3.1, 3.1];
% analog input's display color on the behavior monitoring plot
this.GUI.be.anInColors = { 'b', 'g', 'r' };
% defines whether to show the performance plot or not
this.GUI.be.showPerformance = 1;

% table describing how the parameter panel should be created
this.GUI.be.paramPanConfig = table({}, {}, {}, {}, [], [], {}, {}, 'VariableNames', ...
    { 'categ', 'id', 'UIType', 'valueType', 'UISize', 'isLabelAbove', 'label', 'tooltip' });
this.GUI.be.paramPage = 1;

%% - properties: Behavior
this.be = struct();
% raw analog input data
this.be.anInData = [];
% processed analog input data
this.be.procAnInData = [];
% phase in which the trial is
this.be.trialPhase = '';
% enables to run the behavior software for testing with no actual device connected to the computer
this.be.debugMode = 0;
% version number
this.be.version = '9001.9002'; % it's over 9000 !!
% room ID where the behavior is being done (allows different hardware configuration for each room)
this.be.room = '';
% timing storage
this.be.times = struct();
% defines whether the behavior experiment is running or not
this.be.isRunning = false;
% defines whether the behavior experiment is paused or not
this.be.isPaused = false;
% defines whether the behavior experiment has to be reset or not
this.be.isToReset = false;
% defines whether the behavior configuration is loaded or not
this.be.configLoaded = false;
% current index of trial, incremented every new trial
this.be.iTrial = 0;
% current number of samples
this.be.nSamples = 0;
% defines whether to use the TuckerDavisTechnologies sound box or not
this.be.useTDT = true;
% handle for the TDT ActiveX Control object
this.be.TDTRP = [];
% handle for the standard sound system audio player
this.be.audioplayer = [];
% currently used/loaded behavior configuration
this.be.config = [];
% "main" or "parent" configuration structure containing all configurations -(content of mainConf.mat)
this.be.configs = [];

%% -- properties: Behavior: Hardware
this.be.hw = struct();
% hardware configure structure, loaded in a room-dependent manner
this.be.hw.conf = [];
% defines whether the hardware is connected or not
this.be.hw.connected = false;
% analog input channels, loaded using the hardware configure structure
% this.be.hw.analogIns = { 'yscan', 'micr', 'piezo' };
this.be.hw.analogIns = { 'trig', 'micr', 'piezo' };
% this.be.hw.analogIns = { 'micr', 'piezo' };
% digital output channels, loaded using the hardware configure structure
% this.be.hw.digitalOuts = { 'valve', 'airPuff' };
this.be.hw.digitalOuts = { 'valve' };
% analog output channels, loaded using the hardware configure structure
% this.be.hw.analogOuts = { 'imagTTL', 'ETL', 'light' };
this.be.hw.analogOuts = { 'imagTTL', 'light' };
% number of samples to record from the analog input channels
this.be.hw.sampToRec = 200;
% maximum record duration before the recorded data is flushed, only when behavior experiment is not running
% this.be.hw.maxRecDur = 26;
this.be.hw.maxRecDur = 15;
% analog input channels' fixed sampling rate
this.be.hw.anInSampRate = 3000;
% analog output channels' fixed sampling rate
this.be.hw.anOutSampRate = 3000;
%% -- properties: Behavior: Params
% threshold for the piezo-sensor "activation" detection (e.g. licking event)
this.be.params.piezoThresh = 0.019;
% valve opening time in seconds ("reward duration")
this.be.params.rewDur = 0.02;
% valve opening time in seconds ("punishment duration")
this.be.params.punishDur = 0.0001;
% video triggering delays
this.be.params.vidRecDelay = [2.5 1.5];
% delay between looping behavior in seconds
this.be.params.loopBehavDelay = 50;
% spout movement delays
% this.be.params.spoutDelay = [0.2 0.2];
this.be.params.spoutDelay = [0 0];
% current mode of rewarding
this.be.params.autoRewardMode = 'Auto';
% fraction of the rewsponse window when the early on reward should come
this.be.params.autoRewardEarlyOnTimeFraction = 0.25;
% time between the imaging end and the trial end in seconds
this.be.params.imgEndStopTime = 1;
% defines whether to adjust for the delay using the microphone and the sound
this.be.params.adjustForDelayWithSound = 1;

% minimum voltage to apply to the ETL
this.be.params.minETLV = 5;
% maximum voltage to apply to the ETL
this.be.params.maxETLV = 1.95;
% minimum depth of ETL in micrometers
this.be.params.minETLDepth = 0;
% maximum depth of the ETL in micrometers
this.be.params.maxETLDepth = 100;
% minimum laser intensity
this.be.params.minLaserInt = 0;
% maximum laser intensity
this.be.params.maxLaserInt = 100;
% maximum light voltage
this.be.params.maxLight = 5;
% this.be.params.maxLight = 1.847;
   
% piezo baseline level for normalization
this.be.params.piezoBL = 0.005;
% piezo current median
this.be.params.piezoBLMed = 0;


end
