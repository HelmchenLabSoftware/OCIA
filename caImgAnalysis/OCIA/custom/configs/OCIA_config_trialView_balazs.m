function this = OCIA_config_trialView_balazs(this)
% OCIA_config_trialView_balazs - "trialView_balazs" OCIA configuration file
%
%       this = OCIA('trialView_balazs')
%
% Configuration file for OCIA using the "trialView_balazs" configuration. This function should not be called directly
%   but rather using the "this = OCIA('trialView_balazs');" syntax to launch the software with this configuration.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% -- initialize mode (do not touch this)
% configure modes
this.main.modes = { 'DataWatcher', 'dw'; 'TrialView', 'tv'; 'Analyser', 'an'; };

% defines which data "modules" should be appended to the software. Should be a cell-array of strings with one element
%   per data mode. Also needs to be initialized before the call to 'OCIA_config_default'.
this.main.dataModes = { 'wf'; 'behav' };

% get the default configuration
configHandle = str2func('OCIA_config_default');
this = configHandle(this);

%% -- properties: changeable properties
% name of the starting function
% this.main.startFunctionName = 'dataWatcher';
this.main.startFunctionName = 'trialView';
% this.main.startFunctionName = 'dataWatcherToTrialView';

% watch type and filters
% this.GUI.dw.DWWatchTypes = { };
this.GUI.dw.DWWatchTypes = { 'animal', 'day', 'behav', 'wfLV', 'wfLVSess' };
% this.GUI.dw.DWWatchTypes = { 'animal', 'day', 'behav', 'wfLV', 'wfLVSess', 'wfLVMat' };

% this.GUI.dw.DWFilt = { };
% this.GUI.dw.DWFilt = { 'mou_bl_160105_03', '2016_03_18', 'session01_121500' };
this.GUI.dw.DWFilt = { 'mou_bl_160105_03', '2016_05_12', 'session04_121800' };

% set raw & local data path and save path
% this.path.rawData = 'F:/RawData/1601_behav/';
% this.path.localData = 'F:/RawData/1601_behav/';
% this.path.OCIASave = 'F:/RawData/1601_behav/';
this.path.rawData = 'E:/Users/blaur/PhD/RawData/mou_bl_160105_03/2016_05_12/widefield_labview/session01_104000/Matt_files';
this.path.localData = 'E:/Users/blaur/PhD/RawData/mou_bl_160105_03/2016_05_12/widefield_labview/session01_104000/Matt_files';
this.path.OCIASave = 'E:/Users/blaur/PhD/RawData/mou_bl_160105_03/2016_05_12/widefield_labview/session01_104000/Matt_files';

% allPath = 'F:/RawData/1601_behav/mou_bl_160105_03/2016_05_11/widefield_labview/session02_125500/Matt_files/';
% allPath = 'F:/RawData/1601_behav/mou_bl_160105_03/2016_05_11/widefield_labview/session05_140900/Matt_files/';
% allPath = 'F:/RawData/1601_behav/mou_bl_160105_03/2016_03_18/widefield_labview/session02_125400/Matt_files/';
% allPath = 'C:/Users/BaL/Documents/PhD/RawData/trialViewBalazs/';
% allPath = 'F:/RawData/1601_behav/trialViewBalazs/';
allPath = 'E:/Users/blaur/PhD/RawData/mou_bl_160105_03/2016_05_12/widefield_labview/session01_104000/Matt_files';

% path where the widefield data is located
this.tv.params.WFDataPath = allPath;
% path where the parameters or output should be saved to or loaded from
this.tv.params.saveLoadPath = allPath;
% path where the behavior data is located
this.tv.params.behavDataPath = allPath;

this.tv.params.behavPseudoFlatFieldRounds = 0;

% position and size of the window
% this.GUI.pos = [310, 60, 1440, 970]; % on OoPC
% this.GUI.pos = [130, 50, 950, 630]; % on yOoPC
% this.GUI.pos = [130, -65, 1275, 850]; % on H64-03b
% this.GUI.pos = [55, 125, 1795, 1015]; % on H64-03b remote
% this.GUI.pos = [5, -135, 1895, 1100]; % on H64-03b remote
% this.GUI.pos = [120, -25, 1200, 700]; % presentation and figures
this.GUI.pos = [181, 22, 1483, 979]; % presentation and figures

%% call default TrialView config (do not touch this)
this = OCIA_config_trialView(this);

end
