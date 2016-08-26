function this = OCIA_config_behaviorH30_dayra(this)
% OCIA_config_behaviorH30_dayra - "behaviorH30_dayra" OCIA configuration file
%
%       this = OCIA('behaviorH30_dayra')
%
% Configuration file for OCIA using the "behaviorH30_dayra" configuration. This function should not be called directly
%   but rather using the "this = OCIA('behaviorH30_dayra');" syntax to launch the software with this configuration.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the default configuration
configHandle = str2func('OCIA_config_default');
this = configHandle(this);

%% - input parameters
this.main.startFunctionName = 'dataWatcher';

this.GUI.noGUI = false;
this.GUI.dw.DWFilt = { 'mou_dl_140710_01', '2014_08_05', 'spot01', 'imgData', 'B', '', '' };
this.GUI.dw.DWWatchTypes = 'all';
this.GUI.dw.DWSkiptMeta = false;
this.an.an.preProcOptions = { 'skipFrame', 'fShift', 'fJitt', 'moCorr' };
this.GUI.dw.DWRawOrLocal = 'local';

%% - properties: general
this.verb = 2;
docPath = 'C:/Users/lorenzo/Documents';
% path of the raw data (usually stored on the server)
this.path.rawData = 'Z:/RawData/Dayra_Lorenzo/';
% path of the local data
this.path.localData = 'C:/Users/lorenzo/Documents/LabVIEW Data/2014_07_chronic/';
% path where the OCIA related things should be saved (OCIA object itself, data, plots, etc.)
this.path.OCIASave = 'C:/Users/lorenzo/Documents/LabVIEW Data/OCIA/';
% path of the behavior configuration mat-file
this.path.behavConf = sprintf('%s/mainConf.mat', docPath);
% path where the behavior data should be saved
this.path.behavSave = sprintf('%s/LabVIEW Data/%s/', docPath, ...
    datestr(date, 'yyyy_mm_dd'));

% time threshold in milliseconds to check for time mismatchs
this.dw.trialMatchingTimeDifferenceThreshold = 6000;

%% - properties: GUI
this.GUI.pos = [1945, 360, 1220, 805];
%% -- properties: GUI: Behavior
% update rate of the GUI elements in second
this.GUI.be.updateRate = 1;
% update rate of the trial while-loop when in paused mode (avoids full-speed looping)
this.GUI.be.trialLoopUpdateRate = 0.3;
% analog input's magnification factor on the behavior monitoring plot
this.GUI.be.anInMagnifs = [3 20 30 70];
% analog input's filtering options on the behavior monitoring plot
this.GUI.be.anInFilt = [0 11 0 3];

%% - properties: Behavior
% enables to run the behavior software for testing with no actual device connected to the computer
this.be.debugMode = 0;
%% -- properties: Behavior: Hardware
% analog input channels, loaded using the hardware configure structure
this.be.hw.analogIns = { 'yscan', 'motion', 'micr' };
% digital output channels, loaded using the hardware configure structure
this.be.hw.digitalOuts = { };
% analog output channels, loaded using the hardware configure structure
this.be.hw.analogOuts = { 'imagTTL' };

end
