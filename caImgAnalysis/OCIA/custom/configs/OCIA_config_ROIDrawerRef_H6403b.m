function this = OCIA_config_ROIDrawerRef_H6403b(this)
% OCIA_config_ROIDrawerRef_H6403b - "ROIDrawerRef_H6403b" OCIA configuration file
%
%       this = OCIA('ROIDrawerRef_H6403b')
%
% Configuration file for OCIA using the "ROIDrawerRef_H6403b" configuration. This function should not be called directly
%   but rather using the "this = OCIA('ROIDrawerRef_H6403b');" syntax to launch the software with this configuration.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the default configuration
configHandle = str2func('OCIA_config_default');
this = configHandle(this);

%% - input parameters
this.main.startFunctionName = 'dataWatcher';
% this.main.startFunctionName = 'dataWatcherLoadAnalyse';
% this.main.startFunctionName = 'processAndSavePipeline';

this.GUI.noGUI = false;
% this.GUI.dw.DWFilt = { 'mou_bl_141001_02', '-', '-', 'Behavior data', '' };
this.GUI.dw.DWFilt = { 'mou_bl_141001_01', '-', 'spot02', 'ROISet' };
% this.GUI.dw.DWFilt = { 'mou_bl_141001_01', '2014_10_25', 'spot01', 'Imaging data', 'runType = Trial' };
% this.GUI.dw.DWWatchTypes = 'all';
this.GUI.dw.DWWatchTypes = { 'animal', 'day', 'spot', 'roiset' };
this.GUI.dw.DWSkiptMeta = false;
this.GUI.dw.DWRawOrLocal = 'local';

%% - properties: GUI
% initial position of the main window
this.GUI.pos = [10, 190, 1220, 805]; 

%% - properties: general
% verbosity, number telling how much debugging output should be printed out. The higher the more verbose.
this.verb = 2;

%% -- properties: general: paths to relevant locations (raw data, ect.)
% path of the raw data (usually stored on the server)
this.path.rawData = 'W:/Scratch-02 no Backup/RawDataBalazs/2014_chronic/1410_chronic/';
% path of the local data
this.path.localData = 'F:/RawData/1410_chronic/';
% path where the OCIA related things should be saved (OCIA object itself, data, plots, etc.)
this.path.OCIASave = 'E:/Analysis/1410_chronic/';

end
