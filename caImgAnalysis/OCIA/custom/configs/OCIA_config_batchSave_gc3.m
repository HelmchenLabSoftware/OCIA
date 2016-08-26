function this = OCIA_config_batchSave_gc3(this)
% OCIA_config_batchSave_gc3 - "batchSave_gc3" OCIA configuration file
%
%       this = OCIA('batchSave_gc3')
%
% Configuration file for OCIA using the "batchSave_gc3" configuration. This function should not be called directly
%   but rather using the "this = OCIA('batchSave_gc3');" syntax to launch the software with this configuration.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the default configuration
configHandle = str2func('OCIA_config_default');
this = configHandle(this);

%% - input parameters
this.main.startFunctionName = 'processAndSavePipeline';

this.GUI.noGUI = true;
this.GUI.dw.DWFilt = { };
this.GUI.dw.DWWatchTypes = 'all';
this.GUI.dw.DWSkiptMeta = false;
this.GUI.dw.DWRawOrLocal = 'local';

% number of rows to process before the parallel pool should be restart (no-GUI mode only)
this.an.an.nRowBeforeParallelPoolRestart = 40;

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
this.dw.dataSaveOptionsConfig{'HDF5OverwriteData',  'defaultOn'} = false;
this.dw.dataSaveOptionsConfig{'procDataShowDebug',  'defaultOn'} = false;

% save options
this.main.dataConfig{'rawImg',    'defaultOn'} = false;
this.main.dataConfig{'procImg',   'defaultOn'} = false;
this.main.dataConfig{'caTraces',  'defaultOn'} = true;
this.main.dataConfig{'rawChan',   'defaultOn'} = true;
this.main.dataConfig{'stim',      'defaultOn'} = true;
this.main.dataConfig{'exclMask',  'defaultOn'} = true;
this.main.dataConfig{'ROISets',   'defaultOn'} = true;
this.main.dataConfig{'behavExtr', 'defaultOn'} = true;
this.main.dataConfig{'behav',     'defaultOn'} = false;

%% - properties: GUI
% initial position of the main window
this.GUI.pos = [1, 1, 1220, 805]; 

%% - properties: general
% verbosity, number telling how much debugging output should be printed out. The higher the more verbose.
this.verb = 2;

%% -- properties: general: paths to relevant locations (raw data, ect.)
% path of the raw data (usually stored on the server)
% this.path.rawData = '/home/gc3-user/HIFONASHE-02/RawData/Balazs_Laurenczy/2014/2014_chronic/1410_chronic/';
this.path.rawData = '/home/gc3-user/HIFONASHE-02/RawData/Balazs_Laurenczy/2015/1502_chronic/';
% path of the local data
% this.path.localData = '/home/gc3-user/HIFONASHE-02/RawData/Balazs_Laurenczy/2014/2014_chronic/1410_chronic/';
this.path.localData = '/home/gc3-user/HIFONASHE-02/RawData/Balazs_Laurenczy/2015/1502_chronic/';
% path where the OCIA related things should be saved (OCIA object itself, data, plots, etc.)
% this.path.OCIASave = '/home/gc3-user/HIFONASHE-02/Analysis/Balazs_Laurenczy/2014/2014_chronic/1410_chronic/';
this.path.OCIASave = '/home/gc3-user/HIFONASHE-02/Analysis/Balazs_Laurenczy/2015/1502_chronic/A/';

end
