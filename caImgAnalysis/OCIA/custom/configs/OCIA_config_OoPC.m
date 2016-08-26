function this = OCIA_config_OoPC(this)
% OCIA_config_OoPC - "OoPC" OCIA configuration file
%
%       this = OCIA('OoPC')
%
% Configuration file for OCIA using the "OoPC" configuration. This function should not be called directly
%   but rather using the "this = OCIA('OoPC');" syntax to launch the software with this configuration.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the default configuration
configHandle = str2func('OCIA_config_default');
this = configHandle(this);

%% - input parameters
this.main.startFunctionName = 'dataWatcher';
% this.main.startFunctionName = 'dataWatcherLoadAnalyse';
% this.main.startFunctionName = 'processAndSavePipeline';
% this.main.startFunctionName = 'analysisPipeline';
% this.main.startFunctionName = 'loadDataAndOpenAnalyser';

this.GUI.noGUI = false;
this.GUI.dw.DWFilt = { };
% this.GUI.dw.DWFilt = { '-', '-', '-', 'Behavior data', '' };
% this.GUI.dw.DWFilt = { 'mou_bl_141001_03', '-', 'spot01', '', '' };
this.GUI.dw.DWFilt = { 'mou_bl_150217_02', '-' };
% this.GUI.dw.DWFilt = { 'mou_bl_141001_02', '-', 'spot02', 'Imaging data', 'runType = Trial' };
% this.GUI.dw.DWFilt = { 'mou_bl_141001_01', '2014_10_25', 'spot01', 'Imaging data', 'runType = Trial' };
this.GUI.dw.DWWatchTypes = { 'animal' };
% this.GUI.dw.DWWatchTypes = 'all';
% this.GUI.dw.DWWatchTypes = { 'animal', 'day', 'behav' };
this.GUI.dw.DWSkiptMeta = false;
this.GUI.dw.DWRawOrLocal = 'local';

%% - properties: GUI
% initial position of the main window
% this.GUI.pos = [690, 190, 1220, 805]; 
this.GUI.pos = [15, 190, 1895, 835]; 

%% - properties: general
% verbosity, number telling how much debugging output should be printed out. The higher the more verbose.
this.verb = 2;

%% -- properties: general: paths to relevant locations (raw data, ect.)
% path of the raw data (usually stored on the server)
% this.path.rawData = 'D:/Users/BaL/PhD/RawData/1410_chronic/';
this.path.rawData = 'Z:/RawData/Balazs_Laurenczy/2015/1502_chronic/';
% path of the local data
% this.path.localData = 'D:/Users/BaL/PhD/RawData/1410_chronic/';
this.path.localData = 'D:/Users/BaL/PhD/RawData/1502_chronic/';
% path where the OCIA related things should be saved (OCIA object itself, data, plots, etc.)
% this.path.OCIASave = 'D:/Users/BaL/PhD/Analysis/1410_chronic/20141213/';
this.path.OCIASave = 'D:/Users/BaL/PhD/Analysis/1502_chronic/';

end
