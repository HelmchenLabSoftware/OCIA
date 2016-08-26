function this = OCIA_config_batchSave_OoPC(this)
% OCIA_config_batchSave_OoPC - "batchSave_OoPC" OCIA configuration file
%
%       this = OCIA('batchSave_OoPC')
%
% Configuration file for OCIA using the "batchSave_OoPC" configuration. This function should not be called directly
%   but rather using the "this = OCIA('batchSave_OoPC');" syntax to launch the software with this configuration.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the default configuration
configHandle = str2func('OCIA_config_default');
this = configHandle(this);

%% - input parameters
this.main.startFunctionName = 'processAndSavePipeline';

this.GUI.noGUI = true;
% this.GUI.dw.DWFilt = { 'mou_bl_141001_01', '2014_10_21', 'spot01', 'Imaging data', 'runType = Trial' };
this.GUI.dw.DWFilt = { };
this.GUI.dw.DWWatchTypes = 'all';
this.GUI.dw.DWSkiptMeta = false;
this.GUI.dw.DWRawOrLocal = 'local';

% processing options
this.an.procOptions{'loadData',         'defaultOn'} = true;
this.an.procOptions{'genStimVect',      'defaultOn'} = true;
this.an.procOptions{'skipFrame',        'defaultOn'} = true;
this.an.procOptions{'fShift',           'defaultOn'} = true;
this.an.procOptions{'fJitt',            'defaultOn'} = true;
this.an.procOptions{'moCorr',           'defaultOn'} = true;
this.an.procOptions{'moDet',            'defaultOn'} = true;
this.an.procOptions{'extrCaTraces',     'defaultOn'} = true;

% save options
this.dw.dataSaveOptionsConfig{'saveGUI',            'defaultOn'} = false;
this.dw.dataSaveOptionsConfig{'overwriteSaveFile',  'defaultOn'} = false;
this.dw.dataSaveOptionsConfig{'procBefSave',        'defaultOn'} = true;
this.dw.dataSaveOptionsConfig{'flushAfterSave',     'defaultOn'} = true;
this.dw.dataSaveOptionsConfig{'HDF5GZip',           'defaultOn'} = false;
this.dw.dataSaveOptionsConfig{'HDF5OverwriteData',  'defaultOn'} = true;
this.dw.dataSaveOptionsConfig{'procDataShowDebug',  'defaultOn'} = false;

%% - properties: GUI
% initial position of the main window
this.GUI.pos = [690, 190, 1220, 805]; 

%% - properties: general
% verbosity, number telling how much debugging output should be printed out. The higher the more verbose.
this.verb = 2;

%% -- properties: general: paths to relevant locations (raw data, ect.)
% path of the raw data (usually stored on the server)
this.path.rawData = 'D:/Users/BaL/PhD/RawData/1410_chronic/';
% path of the local data
this.path.localData = 'D:/Users/BaL/PhD/RawData/1410_chronic/';
% path where the OCIA related things should be saved (OCIA object itself, data, plots, etc.)
this.path.OCIASave = 'D:/Users/BaL/PhD/Analysis/1410_chronic/';

end
