function this = OCIA_config_widefield(this)
% OCIA_config_widefield - "widefield" OCIA configuration file
%
%       this = OCIA('widefield')
%
% Configuration file for OCIA using the "widefield" configuration. This function should not be called directly
%   but rather using the "this = OCIA('widefield');" syntax to launch the software with this configuration.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% configure modes
this.main.modes = { 'DataWatcher', 'dw'; 'Intrinsic', 'in'; 'Analyser', 'an' };

% defines which data "modules" should be appended to the software. Should be a cell-array of strings with one element
%   per data mode. Also needs to be initialized before the call to 'OCIA_config_default'.
this.main.dataModes = { 'wf'; 'behav' };

% get the default configuration
configHandle = str2func('OCIA_config_default');
this = configHandle(this);

%% display pitchLims, recordDur, attribs] ...
% display settings for each column of the DataWatcher's table
this.GUI.dw.tableDisplay = cell2table({ ...
...     id              label               order   width   visible     description
        'rowNum',       'Row',              01,     0.030,  true,       'Row number'; ...
        'animal',       'Animal',           02,     0.090,  true,       'Animal ID'; ...
        'day',          'Day',              03,     0.060,  true,       'Day'; ...
        'wfLVSess',     'Session',          04,     0.050,  true,       'Session ID'; ...
        'rowType',      'Row type',         05,     0.075,  true,       'Row type or data type (imaging, behavior, ROISet, etc.)'; ...
        'time',         'Time',             06,     0.055,  true,       'Time'; ...
        'runNum',       'Run number',       07,     0.040,  true,       'Run number (or trial number)'; ...
        'behav',        'Behavior ID',      08,     0.083,  true,       'Behavior''s ID'; ...
        'dim',          'Dimension',        09,     0.110,  true,       'Dimension of the data'; ...
        'data',         'Data',             10,     0.160,  true,       'Data associated with this row'; ...
        'imType',       'Image type',       11,     0.033,  false,      'Image type (movie, frame, stack, etc.)'; ...
%         'stimFreq',     'Stim. freq',       11,     0.040,  true,       'Stimulation frequency in Hz'; ...
%         'sweepDir',     'Sweep dir.',       12,     0.030,  true,       'Sweep direction'; ...
        'frameRate',    'Frame rate',       13,     0.030,  true,       'Imaging frame rate in Hz'; ...
%         'pitchLims',    'Pitch',            14,     0.040,  true,       'Pitch limits in kHz'; ...
%         'recordDur',    'Rec. dur.',        15,     0.025,  true,       'Record duration in seconds'; ...
%         'amplif',       'Amplif.',          16,     0.025,  true,       'Amplification factor (arbitrary units)'; ...
        'comments',     'Comments',         17,     0.210,  true,       'Comments'; ...
        'path',         'Path',             18,     0.500,  false,      'Full path to the folder/file/data'; ...
        'rowID',        'RowID',            19,     0.085,  false,      'Row ID'; ...
...        
    }, 'VariableNames', { 'id', 'label', 'order', 'width', 'visible', 'description' });
this.GUI.dw.tableDisplay.Properties.RowNames = this.GUI.dw.tableDisplay.id; % make the ID be the row names
% store the table IDs for easier referencing
this.dw.tableIDs = this.GUI.dw.tableDisplay.id;
this.GUI.an.DWTableColumnsToUse = { 'animal', 'day', 'wfLVSess', 'runNum' };
% cell-array holding the current data set (from the watch folder's content), displayed in a big table
this.dw.table = cell(300, numel(this.dw.tableIDs));
% defines the maximum number of frames to load for the preview loading type
this.dw.previewNMaxFrameToLoad = 3;
% tells with which "path" configuration to save the HDF5 data
this.dw.HDF5.savePathConfig = { 'animal', 'day', 'session' };
% name of the function that do post-processing after the notebook file parsing
this.dw.annotateTableFunctionName = 'widefield';
% name of the function that parses the notebook file
this.dw.notebookParsingFunctionName = 'widefield';
% name of the function that does the online analysis
this.dw.onlineAnalysisFunctionName = 'widefield';
% list of buttons that are available to further process the data, as a table array with 4 columns:
%   { ID, label, tag, tooltip }
this.GUI.dw.processButtons = cell2table({ ...
...     id              label               	tag                 tooltip
        'drawROIs',     'Draw ROIs',            'DWDrawROIs',       'Draw Regions Of Interest for selected rows';
        'processRows',  'Process',              'DWProc',           'Process selected rows with the processing steps from the list';
        'analyseRows',  'Analyse',              'DWAnalyse',        'Analyse selected rows (import selected data to Analyser mode)';
        'WFAnalyse',    'WF analyse',           'DWWFAnalyse',      'Analyse selected rows (import selected data to Analyser mode [WF])';
}, 'VariableNames', { 'id', 'label', 'tag', 'tooltip' });
this.GUI.dw.processButtons.Properties.RowNames = this.GUI.dw.processButtons.id; % make the ID be the row names

%% -- properties: DataWatcher : watch types
% file/folder types that can be processed and will appear in the DataWatcher's table with their regexp pattern, stored
%   as a table with 6 columns: { ID, label, parent watch type's ID, visible in GUI, tooltip text, 
%   regular expression pattern }
this.dw.watchTypes = cell2table({
...     id              label               parent    	visible     tooltip                             pattern
        'animal',       'Animal',           [],         true,       'Animal folder',                    '^(?<animal>mou_[db]l_\d{6}_\d{2})$';
        'day',          'Day',              'animal',   true,       'Day folder',                       '^(?<day>\d{4}_\d{2}_\d{2})$';
        'behav',        'Behavior data',    'day',      true,       'Behavior data folder',             '^behav$';
        'wf',           'WF folder',        'day',      true,       'Wide-field folder',                '^[wW]ide[fF]ield$';
        'wfLV',         'WFLV folder',      'day',      true,       'Wide-field Labview folder',        '^[wW]ide[fF]ield_labview$';
        'wfLVSess',     'WFLV session',     'wfLV',     true,       'Wide-field Labview session',       '^(exp|session)(?<runNum>\d+)_(?<wfLVSess>[^\.]+)';
        'wfLVMat',      'WFLV data',        'wfLVSess', true,       'Wide-field Labview data folder',   '^Matt_files$';
        'wfAn',         'WF analysis',      'day',      true,       'Wide-field analysis folder',       '^newAnalysis$';
%         'wfAn',         'WF analysis',      'day',      true,       'Wide-field analysis folder',       '^(newAnalysis|oldPlots|phaseAnalysis|analysis)$';
}, 'VariableNames', { 'id', 'label', 'parent', 'visible', 'tooltip', 'pattern' });
this.dw.watchTypes.Properties.RowNames = this.dw.watchTypes.id; % make the ID be the row names
% create a variable in the table for file patterns for files inside "watchType" folders (these are 
%   kind of "sub-watchTypes") and fill-in the sub-file patterns for each required watch type:
this.dw.watchTypes.subFilePatterns = cell(size(this.dw.watchTypes, 1), 1);
% wide-field data
this.dw.watchTypes{'wf', 'subFilePatterns'} = { cell2table({ ...
...     id                  label                   createNewRow    pattern
        'wfLog',            'WF log',               false,          '^(?<day>\d{8})_(?<time>\d{6})_exp(?<runNum>\d+)_(?<fileNameParams>[^\.]+)\.log$';
        'wfData',           'WF data',              true,           '^(?<day>\d{8})_(?<time>\d{6})_exp(?<runNum>\d+)_(?<fileNameParams>[^\.]+)\.h5$';
}, 'VariableNames', { 'id', 'label', 'createNewRow', 'pattern' }) };
% wide-field data
this.dw.watchTypes{'wfLVMat', 'subFilePatterns'} = { cell2table({ ...
...     id                  label                   createNewRow    pattern
        'wfTr',             'WF trial',             true,          '^stim_trial(?<runNum>\d+)\.mat$';
        'wfTrAvg',          'WF average',           true,          '^(stim_ave|cond)_?(?<condition>[^_]+)?(_average)?.mat$';
        'wfRef',            'WF reference',         true,          '^refImg.mat$';
}, 'VariableNames', { 'id', 'label', 'createNewRow', 'pattern' }) };
% wide-field analysis folder data
this.dw.watchTypes{'wfAn', 'subFilePatterns'} = { cell2table({ ...
...     id                  label                   createNewRow    pattern
        'wfAnMatFile',      'WF an. data',          true,           '^(?<day>\d{8})_exp(?<runNum>\d+to\d+)_(?<fileNameParams>[^\.]+)\.mat$';
}, 'VariableNames', { 'id', 'label', 'createNewRow', 'pattern' }) };
% behavior data
this.dw.watchTypes{'behav', 'subFilePatterns'} = { cell2table({ ...
...     id                  label                   createNewRow    pattern
        'behavData',        'Behavior data',        true,           '^Behavior_(?<day>\d{4}_\d{2}_\d{2})__(?<time>\d{2}_\d{2}_\d{2})\.mat$';
...        'behavMovie',       'Behavior movie',       true,           '^(?<day>\d{4}\d{2}\d{2})_(?<time>\d{2}\d{2}\d{2})_trial(?<runNum>\d+)\.avi$';
}, 'VariableNames', { 'id', 'label', 'createNewRow', 'pattern' }) };

%% -- properties: Analyser: Processing options
% table that determines which pre-processing options can be applied.
this.an.procOptions = cell2table({ ...
... id              label                       defaultOn   isProcStep    description    
    'loadData',     'Load data (full)',         true,       false,        'Fully load the data for this row';
    'genStimVect',  'Generate stim. vector',    true,       false,        'Generate a stimulus vector using fixed times or the behavior data';
    'moCorr',       'Motion correction (XY)',   true,       true,         'Corrects for XY movements artifacts (frame alignment/registration)'; 
    'extrCaTraces', 'Extract calcium traces',   true,       false,        'Extract the calcium traces (DF/F or DR/R time series) from the images for each ROI'; 
}, 'VariableNames', { 'id', 'label', 'defaultOn', 'isProcStep', 'description' });
this.an.procOptions.Properties.RowNames = this.an.procOptions.id; % make the ID be the row names

%% -- properties: DataWatcher : data configuration
% defines the data saving general options as a table with 3 columns: { ID, label, tooltip text }
this.dw.dataSaveOptionsConfig = cell2table({ ...
...     id                      label                           defaultOn       tooltip
        'saveGUI',              'Save/load the GUI',            false,          'Save / load the user interface.';
        'overwriteSaveFile',    'Overwrite save file',          false,          'Overwrite (delete) the save file when saving, if it exists.';
        'procBefSave',          'Proc. before save',            true,           'Process the data with the selected processing steps before saving it to HDF5.';
        'flushAfterSave',       'Flush mem. at save',           false,          'Flush the data in memory after each row is saved to HDF5.';
        'HDF5GZip',             'Compress data',                false,          'Compress data when saving it to HDF5.';
        'HDF5OverwriteData',    'Overwrite HDF5 data',          true,           'Overwrite already existing data when saving it to HDF5 file.';
        'procDataShowDebug',    'Show debug plots',             false,          'Show the debuging plots when proessing the data.';
}, 'VariableNames', { 'id', 'label', 'defaultOn', 'tooltip'});
this.dw.dataSaveOptionsConfig.Properties.RowNames = this.dw.dataSaveOptionsConfig.id; % make the ID be the row names

%% -- properties: DataWatcher: filter elements and IDs
% defines the aspect of the filtering panel as a table with one row per filter and 5 columns: 
%   { ID, GUI element's type, GUI width and DataWatcher's table column where to apply the filter, supports range }
this.GUI.dw.filtElems = cell2table({ ...
...     id                  GUIType         width   DWTableID   rangeSupport
        'animal',           'dropdown',     0.5,    'animal',   false;
        'day',              'dropdown',     0.5,    'day',      false;
        'wfLVSess',         'dropdown',     0.5,    'wfLVSess', false;
        'rowType',          'dropdown',     0.5,    'rowType',  false;
        'all',              'textfield',    1,      '*',        false;
        'dataLoadStatus',   'textfield',    1,      'data',     false;
        'rowNum',           'textfield',    0.5,    'rowNum',   true;
        'runNum',           'textfield',    0.5,    'runNum',   true;
}, 'VariableNames', { 'id', 'GUIType', 'width', 'DWTableID', 'rangeSupport' });
this.GUI.dw.filtElems.Properties.RowNames = this.GUI.dw.filtElems.id; % make the ID be the row names

%% -- properties: Analyser : analysis types
% different analysis types available
this.an.analysisTypes = cell2table({ ...
... id                                      label                               description
    'widefield_refImg',                     'Reference image',                  'Reference image.';
%     'widefield_powerAndPhaseMaps',          'Power and phase maps',             'Power and phase maps for a specific frequency.';
%     'widefield_correctedPhaseMap',          'Corrected phase map',              'Delay corrected phase map.';
%     'widefield_correctedPhaseMapOverlay',   'Corrected phase map overlay',      'Delay corrected phase map overlay on vessels.';
%     'widefield_corrPhaseMapSummary',        'Phase map summary',                'Delay corrected phase maps summary.';
%     'widefield_pixelTimeCourse',            'Pixel time course',                'Pixel time courses.';
%     'widefield_spectrogram',                'Spectrogram',                      'Spectrogram of the pixel time courses.';
%     'widefield_movingCorrPhaseMap',         'Moving corrected phase map',       'Moving delay corrected phase map.';
    'widefield_mappingMultiFreqPSAvg',      'Mapping multi-freq. PSAvg',        'Mapping multi-freq. peri-stimulus average.';
    'widefield_mappingMultiFreqTrialMaps',  'Mapping multi-freq. trial maps',   'Mapping multi-freq. trial maps';
    'widefield_mappingEvokedMapsStims',     'Evoked response maps (stims)',     'Mapping multi-freq. stimulus maps';
    'widefield_mappingEvokedMapsOverlay',   'Evoked response maps overlay',     'Mapping multi-freq. stimulus maps overlay';
    'widefield_mappingLineProfiles',        'Evoked response line profiles',    'Lines profiles of evoked maps';
%     'widefield_mappingLineProfiles'
%     'widefield_stdPixelTimeCourse',         'Pixel time course (std)',          'Pixel time course (std).';
%     'widefield_stdEvokedMapsTrials',        'Evoked response maps (trials)',    'Evoked response maps for all trials.';
%     'widefield_stdEvokedMapsStims',         'Evoked response maps (stims)',     'Evoked response maps for all stimuli.';
%     'widefield_stdEvokedMapsStimsOverlay',  'Overlay stim. maps',               'Overlayed evoked response maps for all stimuli.';
    'behav_timeseries',                     'Behavior variables time series',       'Behavioral variables as time series with different groupings';
    'behav_histograms',                     'Behavior variables histograms',        'Behavioral variables as histograms with different groupings';
    'behav_licks',                          'Licking traces as heatmaps',           'Licking profile (heatmap)';
    'behav_licks_raster',                   'Licking traces as raster plots',       'Licking profile (raster)';
   
}, 'VariableNames', { 'id', 'label', 'description' });
this.an.analysisTypes.Properties.RowNames = this.an.analysisTypes.id; % make the ID be the row names

% stimulus generating function
this.an.stimulusVectorGeneratingFunctionName = 'fromAnalogInWideField';

%% TODO
%{
    ANALYSIS
    - create a phase difference plot/analysis where phase is checked on a running-window average manner
        - create a phase STD map (standard deviation of the phase difference for each pixel)
    - test the stim freq interval on runs where the spectrogram seems to be consistent
        in neighbouring frequencies


%}

%% - properties: GUI
[~, computerName] = system('hostname');
computerName = genvarname(computerName); %#ok<DEPGENAM>
% computer-dependent settings
switch computerName;
    case 'HIFOWSH640x2D03b';
        this.GUI.pos = [5, 230, 1260, 760];
%         this.GUI.pos = [5, 300, 1260, 850];
%         this.GUI.pos = [-1275, 5, 1260, 990];
%         this.GUI.pos = [1930, 20, 1260, 975];
%         this.path.intrSave = 'F:/RawData/1509_tonotopy/mou_bl_151007_02/2015_11_30/widefield/';
        this.path.intrSave = 'F:/RawData/1601_behav/';
        
        this.main.startFunctionName = 'dataWatcher';
        
%         this.GUI.dw.DWWatchTypes = { 'animal', 'day', 'wf', 'wfAn' };
        this.GUI.dw.DWWatchTypes = { 'animal', 'day', 'behav', 'wfLV', 'wfLVSess', 'wfLVMat' };
%         this.GUI.dw.DWWatchTypes = { 'animal', 'day' };
%         this.GUI.dw.DWWatchTypes = { };
        
%         this.GUI.dw.DWFilt = { };
%         this.GUI.dw.DWFilt = { '-', '2015_12_10' };
%         this.GUI.dw.DWFilt = { 'mou_bl_151125_03', '2015_12_11' };
%         this.GUI.dw.DWFilt = { 'mou_bl_160105_02', '2016_03_01', 'session03_115500' };
        this.GUI.dw.DWFilt = { 'mou_bl_160105_03', '2016_03_18' };
%         this.GUI.dw.DWFilt = { '-', '-' };
        
%         this.main.startFunctionName = 'analysisPipeline_wideField';
%         this.main.startFunctionName = 'analysisPipeline_wideFieldMultiMap';
%         this.main.startFunctionName = 'intrinsic';
        

    case 'HIFOWSH300x2D03';
        this.GUI.pos = [10, 200, 1900, 840];
        this.path.intrSave = 'C:/Users/laurenczy/Documents/LabVIEW Data/1509_tonotopy/mou_bl_151008_02/2015_10_27/widefield/';

    case 'HIFOWSH420x2D01';
        this.main.startFunctionName = 'behaviorSummary';
        this.GUI.pos = [5, 50, 1265, 950];
%         this.path.intrSave = 'D:/RawData/1509_tonotopy/mou_bl_151007_01/2015_11_23/widefield/';
%         this.path.intrSave = 'Z:/RawData/Balazs_Laurenczy/2016/1601_behav/';
%         this.path.intrSave = 'W:/Neurophysiology-Storage1/Laurenczy/2016/1601_behav/';
        this.path.intrSave = 'D:/RawData/1601_behav/';
        this.GUI.dw.DWWatchTypes = { 'animal', 'day', 'wf' };
%         this.GUI.dw.DWFilt = { 'mou_bl_160105_03', '2016_03_18' };
        this.GUI.dw.DWFilt = { 'mou_bl_160105_03', '2016_03_23' };
        
    case 'HIFOWSH420x2D04';
        this.GUI.pos = [5, 50, 1265, 950];
        
    case 'OoPC';
        this.GUI.pos = [10, 200, 1900, 850];
        this.path.intrSave = 'D:/Users/BaL/PhD/RawData/1509_tonotopy/mou_bl_151007_02/2015_10_27/widefield/';
        
    case 'yOoPC';
        this.GUI.pos = [10, 180, 1250, 510];
        this.path.intrSave = 'C:/Users/blaur/Documents/1601_behav/';
        
        this.GUI.dw.DWWatchTypes = { 'animal', 'day', 'wf', 'wfAn' };
        this.GUI.dw.DWFilt = { 'mou_bl_160105_02', '2016_01_08' };
        
    case 'OoPCMac';
        this.GUI.dw.DWWatchTypes = { 'animal', 'day', 'wf' };
        this.GUI.dw.DWFilt = { 'mou_bl_160105_02', '2016_01_22' };
        this.GUI.pos = [5, 190, 1260, 580];
        this.path.intrSave = 'C:/Users/BaL/Documents/RawData/1601_behav/';
        
end;

% save plots where data is
this.path.rawData = this.path.intrSave;
this.path.localData = this.path.intrSave;
this.path.OCIASave = this.path.intrSave;

end
