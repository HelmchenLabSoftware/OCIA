function this = OCIA_config_analysis_H6403b(this)
% OCIA_config_analysis_H6403b - "analysis_H6403b" OCIA configuration file
%
%       this = OCIA('analysis_H6403b')
%
% Configuration file for OCIA using the "analysis_H6403b" configuration. This function should not be called directly
%   but rather using the "this = OCIA('analysis_H6403b');" syntax to launch the software with this configuration.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% this.main.modes = { 'DataWatcher', 'dw'; 'ROIDrawer', 'rd'; 'Analyser', 'an'; };
% this.main.dataModes = { 'img'; 'behav'; };

% get the default configuration
configHandle = str2func('OCIA_config_default');
this = configHandle(this);

%% - input parameters
% this.main.startFunctionName = 'behaviorSummary';
this.main.startFunctionName = 'dataWatcher';
% this.main.startFunctionName = 'loadDataAndOpenAnalyserFromGUI';
% this.main.startFunctionName = 'loadDataAndOpenAnalyser';
% this.main.startFunctionName = 'analysisPipeline';
% this.main.startFunctionName = 'pooledAnalysis';
% this.main.startFunctionName = 'analysisPipelineMultiGUI';
% this.main.startFunctionName = 'multiAnimalAnalysisPipeline';

this.GUI.noGUI = false;
this.GUI.dw.DWFilt = { };
this.GUI.dw.DWFilt = { 'mou_bl_150217_05', '2015_03_10' };
% this.GUI.dw.DWFilt = { 'mou_bl_141001_01', '', 'spot01' };
% this.GUI.dw.DWFilt = { 'mou_bl_141001_01', '', 'spot01' };
% this.GUI.dw.DWFilt = { 'mou_bl_141001_02', '2014_10_16', 'spot01' };
% this.GUI.dw.DWFilt = { 'mou_bl_141001_01', '-', '-', 'Behavior data' };
this.GUI.dw.DWWatchTypes = { };
this.GUI.dw.DWWatchTypes = 'all';
% this.GUI.dw.DWWatchTypes = { 'animal', 'day' };
% this.GUI.dw.DWWatchTypes = { 'animal', 'day', 'behav' };
% this.GUI.dw.DWWatchTypes = { 'animal', 'day', 'spot', 'img', 'notebook', 'roiset' };
% this.GUI.dw.DWWatchTypes = 'all';
this.GUI.dw.DWSkiptMeta = false;
this.GUI.dw.DWKeepTable = false;
this.GUI.dw.DWRawOrLocal = 'local';

%% - properties: GUI
% initial position of the main window
% this.GUI.pos = [1950, 175, 1220, 805];
% this.GUI.pos = [100, 175, 1220, 805];
% this.GUI.pos = [1921, 1, 1280, 1002];
% this.GUI.pos = [1921, -119, 1280, 1002];
% this.GUI.pos = [9, 9, 1200, 850];
% this.GUI.pos = [8, 300, 1902, 871];
this.GUI.pos = [120, 125, 1200, 700]; % presentation and figures

%% - properties: general
% verbosity, number telling how much debugging output should be printed out. The higher the more verbose.
this.verb = 2;

%% -- properties: general: paths to relevant locations (raw data, ect.)
% path of the raw data (usually stored on the server)
% this.path.rawData = 'Z:/RawData/Balazs_Laurenczy/2014/2014_chronic/1410_chronic/';
% this.path.rawData = 'Z:/RawData/Balazs_Laurenczy/2015/1502_chronic/';
this.path.rawData = 'W:/Neurophysiology-Storage1/Laurenczy/2015/1502_chronic/';
% path of the local data
% this.path.localData = 'F:/RawData/1410_chronic/';
% this.path.localData = 'F:/RawData/1502_chronic/';
this.path.localData = 'W:/Neurophysiology-Storage1/Laurenczy/2015/1502_chronic/';
% path where the OCIA related things should be saved (OCIA object itself, data, plots, etc.)
% this.path.OCIASave = 'E:/Analysis/1410_chronic/20141213/';
this.path.OCIASave = 'E:/Analysis/1502_chronic/';

end
