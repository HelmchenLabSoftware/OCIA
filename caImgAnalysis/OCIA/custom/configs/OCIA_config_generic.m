function this = OCIA_config_generic(this)
% #OCIA:CONFIG:OCIA_config_generic - Calls the default configuration
%
%       this = OCIA_config_generic(this)
%
% Initiates the current instance of the OCIA ('this') with a generic configuration and returns it. This file is supposed
% to contain all parameters that can be changed in a config file. Use this as a template to create your own custom
% configuration file. Feel free to delete (or leave unchanged) any parameters, default values will then apply.

% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% initialize the requested mode
% defines which modes should be initiated for this instance of OCIA. Should be a N_MODES x 2 cell-array, first column
%   being the mode's name ('DataWatcher') and the second the short name ('dw'). This needs to be created before the
%   call to the 'OCIA_config_default' because that function will actually initialize the different modes.
this.main.modes = { ...
        % mode name         short name
        'DataWatcher',      'dw';
        'ROIDrawer',        'rd';
        'Analyser',         'an';
        'Behavior',         'be';
        'JointTracker',     'jt';
    };

% defines which data "modules" should be appended to the software. Should be a cell-array of strings with one element
%   per data mode. Also needs to be initialized before the call to 'OCIA_config_default'.
this.main.dataModes = { 'img'; 'behav'; };

%% get the default configuration
% initialize the default version of the OCIA's configuration
configHandle = str2func('OCIA_config_default');
this = configHandle(this);

%% - properties: general
% verbosity, number telling how much debugging output should be printed out. The higher the more verbose.
this.verb = 2;
% defines which start function should be called, refering to a file named 'OCIA_startFunction_[NAME]'
this.main.startFunctionName = 'default';

%% - properties: paths to relevant locations (raw data, ect.)
% get the current directory
currentDir = regexprep(pwd(), '\\', '/');
% path of the raw data (usually stored on the server)
this.path.rawData = currentDir;
% path of the local data
this.path.localData = currentDir;
% path where the OCIA related things should be saved (OCIA object itself, data, plots, etc.)
this.path.OCIASave = currentDir;

%% - properties: GUI
% initial position of the main window
this.GUI.pos = [345, 285, 1220, 805];
% option to hide or show any display/window/GUI
this.GUI.noGUI = false;

%% - properties: DataWatcher
% display settings for each column of the DataWatcher's table
this.GUI.dw.tableDisplay = cell2table({ ...
...     id              label               order   width   visible     description
        'rowNum',       'Row',              01,     0.025,  true,       'Row number'; ...
        'animal',       'Animal',           02,     0.085,  true,       'Animal ID'; ...
        'spot',         'Spot',             03,     0.035,  true,       'Spot ID'; ...
        'day',          'Day',              04,     0.058,  true,       'Day'; ...
        'time',         'Time',             05,     0.052,  true,       'Time'; ...
        'dim',          'Dimension',        06,     0.070,  true,       'Dimension of the data'; ...
        'rowType',      'Row type',         07,     0.075,  true,       'Row type or data type (imaging, behavior, ROISet, etc.)'; ...
        'runType',      'Run type',         08,     0.050,  true,       'Run type (which stimulus was used, etc.)'; ...
        'runNum',       'Run number',       09,     0.030,  true,       'Run number (or trial number)'; ...
        'behav',        'Behavior ID',      10,     0.083,  true,       'Behavior''s ID'; ...
        'ROISet',       'ROISet ID',        11,     0.083,  true,       'ROISet''s ID'; ...
        'data',         'Data',             12,     0.170,  true,       'Data associated with this row'; ...
        'imType',       'Image type',       13,     0.033,  false,      'Image type (movie, frame, stack, etc.)'; ...
        'laserInt',     'Laser intensity',  14,     0.028,  true,       'Laser intensity in percent'; ...
        'zoom',         'Zoom factor',      15,     0.015,  true,       'Zoom factor'; ...
        'frameRate',    'Frame rate',       16,     0.030,  false,      'Imaging frame rate'; ...
        'zStep',        'Z-step',           17,     0.015,  false,      'Z-step for the stacks'; ...
        'comments',     'Comments',         18,     0.145,  true,       'Comments'; ...
        'path',         'Path',             19,     0.500,  false,      'Full path to the folder/file/data'; ...
        'rowID',        'RowID',            20,     0.085,  false,      'Row ID'; ...
...        
    }, 'VariableNames', { 'id', 'label', 'order', 'width', 'visible', 'description' });
this.GUI.dw.tableDisplay.Properties.RowNames = this.GUI.dw.tableDisplay.id; % make the ID be the row names
% store the table IDs for easier referencing
this.dw.tableIDs = this.GUI.dw.tableDisplay.id;
% cell-array holding the current data set (from the watch folder's content), displayed in a big table
this.dw.table = cell(300, numel(this.dw.tableIDs));
% pattern to use to built the DataWatcher table rows' IDs
this.dw.rowIDPattern = '%s_%s';
% columns from the DataWatcher table to use to built the DataWatcher table rows' IDs using the specified pattern,
%   including the replace patterns for each column.
this.dw.rowIDColumns = { ...
...     id              replaceSourcePattern    replaceTargetPattern
        'day',          '_',                    '';
        'time',         '_',                    '';
};
% defines whether the watch folder should be automatically processed upon changing its path
this.dw.autoProcessWatchFolder = false;
% defines whether a warning of data flushing upon watch folder change should be displayed or not
this.dw.ignoreDataFlushWarning = true;
% defines which data types to flush after saving. If empty, selected data types will be flushed
this.dw.dataTypesToFlushAfterSaving = { 'rawImg', 'procImg', 'caTraces', 'stim', 'exclMask', 'rawChan', 'behavExtr' };
% defines the maximum number of frames to load for the preview loading type
this.dw.previewNMaxFrameToLoad = 100;
% tells with which "path" configuration to save the HDF5 data
this.dw.HDF5.savePathConfig = { 'animal', 'spot', 'day' };
% HDF5 saving compression level. If empty or 0, no compression at all, otherwise specify values 
%   between 1 (best speed) and 9 (best compression)
this.dw.HDF5.GZipLevel = 0;
% name of the function that do post-processing after the notebook file parsing
this.dw.annotateTableFunctionName = 'default';
% name of the function that parses the notebook file
this.dw.notebookParsingFunctionName = 'default';
% time threshold in milliseconds to check for time mismatchs
this.dw.trialMatchingTimeDifferenceThreshold = 6000;

%% -- properties: GUI: DataWatcher
% string that is displayed for the cells of the DataWatcher's table that are empty, must be longer than 1 char !
this.GUI.dw.tableEmptyCellDisplayContent = ' - ';
% defines whether to show a summary line for folders that were not processed
this.GUI.dw.showEmptyFolderSummary = true;
% defines whether to show a small thumbnail of the currently selected row
this.GUI.dw.showThumbnailPreview = true;
% defines which filter settings should be active at start
this.GUI.dw.DWFilt = { };
% defines which watch types should be activated at start
this.GUI.dw.DWWatchTypes = { };
% defines whether to skip meta-data processing
this.GUI.dw.DWSkiptMeta = true;
% defines whether to keep the current table when re-updating the table (add rows instead of replacing them)
this.GUI.dw.DWKeepTable = false;
% defines whether to use the raw or local watch folder
this.GUI.dw.DWRawOrLocal = 'local';
% list of buttons that are available to further process the data, as a table array with 4 columns: { ID, label, tag, 
%   tooltip }
this.GUI.dw.processButtons = cell2table({ ...
...     id              label               	tag                 tooltip
        'drawROIs',     'Draw ROIs',            'DWDrawROIs',       'Draw Regions Of Interest for selected rows';
        'processRows',  'Process',              'DWProc',           'Process selected rows with the processing steps from the list';
        'analyseRows',  'Analyse',              'DWAnalyse',        'Analyse selected rows (import selected data to Analyser mode)';
}, 'VariableNames', { 'id', 'label', 'tag', 'tooltip' });
this.GUI.dw.processButtons.Properties.RowNames = this.GUI.dw.processButtons.id; % make the ID be the row names

%% -- properties: DataWatcher : watch types
% file/folder types that can be processed and will appear in the DataWatcher's table with their regexp pattern, stored
%   as a table with 6 columns: { ID, label, parent watch type's ID, visible in GUI, tooltip text, 
%   regular expression pattern }
this.dw.watchTypes = cell2table({
...     id              label               parent    	visible     tooltip                     pattern
        'animal',       'Animal',           [],         true,       'Animal folder',                    '^(?<animal>mou_[db]l_\d{6}_\d{2})$';
        'day',          'Day',              'animal',   true,       'Day folder',                       '^(?<day>\d{4}_\d{2}_\d{2})$';
        'spot',         'Spot',             'day',      true,       'Spot folder',                      '^(?<spot>spot\d{2})$';
        'img',          'Imaging data',     'spot',     true,       'Imaging data folder for spots',    '^(?<day>\d{4}_\d{2}_\d{2})__(?<time>\d{2}_\d{2}_\d{2})h$';
        'notebook',     'Notebook',         'day',      true,       'Notebook file',                    '^notebook__(?<day>\d{4}_\d{2}_\d{2})__(?<time>\d{2}h_\d{2}m)\.txt$';
        'behav',        'Behavior data',    'day',      true,       'Behavior data folder',             '^behav$';
        'roiset',       'ROISet',           'day',      true,       'ROISet folder',                    '^ROISets$';
        'intrinsic',    'Intrinsic',        'day',      true,       'Intrinsic folder',                 '^intr(Fourier)?_?(?<day>\d{4}_\d{2}_\d{2})?$';
}, 'VariableNames', { 'id', 'label', 'parent', 'visible', 'tooltip', 'pattern' });
this.dw.watchTypes.Properties.RowNames = this.dw.watchTypes.id; % make the ID be the row names
% number of folders above the imaging data folder where the ROISet should be saved
this.dw.ROISetNFolderAbove = 1;
% create a variable in the table for file patterns for files inside "watchType" folders (these are 
%   kind of "sub-watchTypes") and fill-in the sub-file patterns for each required watch type:
this.dw.watchTypes.subFilePatterns = cell(size(this.dw.watchTypes, 1), 1);
% imaging data
this.dw.watchTypes{'img', 'subFilePatterns'} = { cell2table({ ...
...     id                  label                   createNewRow    pattern
        'imgMeta',          'Imaging meta-data',    false,          '^(?<day>\d{4}_\d{2}_\d{2})__(?<time>\d{2}_\d{2}_\d{2})h\.xml$';
        'imgData',          'Imaging data',         false,          '^(?<day>\d{4}_\d{2}_\d{2})__(?<time>\d{2}_\d{2}_\d{2})h__channel_?(?<iChan>\d+)\.(bin|tif)$';
}, 'VariableNames', { 'id', 'label', 'createNewRow', 'pattern' }) };
% behavior data
this.dw.watchTypes{'behav', 'subFilePatterns'} = { cell2table({ ...
...     id                  label                   createNewRow    pattern
        'behavData',        'Behavior data',        true,           '^Behavior_(?<day>\d{4}_\d{2}_\d{2})__(?<time>\d{2}_\d{2}_\d{2})\.mat$';
...        'behavMovie',       'Behavior movie',       true,           '^(?<day>\d{4}\d{2}\d{2})_(?<time>\d{2}\d{2}\d{2})_trial(?<runNum>\d+)\.avi$';
}, 'VariableNames', { 'id', 'label', 'createNewRow', 'pattern' }) };
% ROISet
this.dw.watchTypes{'roiset', 'subFilePatterns'} = { cell2table({ ...
...     id                  label                   createNewRow    pattern
        'ROISetMatFile',    'ROISet',               true,           '^ROISet_(?<day>\d{4}_\d{2}_\d{2})__(?<time>\d{2}_\d{2}_\d{2})h\.mat$';
}, 'VariableNames', { 'id', 'label', 'createNewRow', 'pattern' }) };
% intrinsic imaging data
this.dw.watchTypes{'intrinsic', 'subFilePatterns'} = { cell2table({ ...
...     id                  label                           createNewRow    pattern
        'intrBinary',       'Intrinsic data (standard)',    true,           '^intr(?<runNum>\d+)_(?<comments>[\w\d_]+)$';
        'intrFourier',      'Intrinsic data (fourier)',     true,           '^intr(?<runNum>\d+)_?(?<comments>[\w\d_]+)?\.mat$';
        'intrScreen',       'Intrinsic screenshot',         true,           '^intr(?<runNum>\d+)_(?<comments>[\w\d_]+)\.png$';
        'intrVessel',       'Intrinsic reference',          true,           '^vessels(?<runNum>\d+)?\.tif$';
}, 'VariableNames', { 'id', 'label', 'createNewRow', 'pattern' }) };

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
        'spot',             'dropdown',     0.5,    'spot',     false;
        'rowType',          'dropdown',     0.5,    'rowType',  false;
        'all',              'textfield',    1,      '*',        false;
        'dataLoadStatus',   'textfield',    1,      'data',     false;
        'rowNum',           'textfield',    0.5,    'rowNum',   true;
        'runNum',           'textfield',    0.5,    'runNum',   true;
}, 'VariableNames', { 'id', 'GUIType', 'width', 'DWTableID', 'rangeSupport' });
this.GUI.dw.filtElems.Properties.RowNames = this.GUI.dw.filtElems.id; % make the ID be the row names


%% - properties: ROIDrawer
% vectors of displacement when moving all ROIs at the same time
this.rd.moveROIVects = struct('up', [0 -1 0 0], 'down', [0 1 0 0], 'left', [-1 0 0 0], 'right', [1 0 0 0]);
% number of pixels/units to move ROIs when adjusting the position of ROIs
this.rd.moveROIsStep = 2;
% angle in degrees to rotate ROIs when adjusting the position of ROIs
this.rd.rotateROIsStep = 1;
% possible image corrections
this.rd.imCorr = { 'imAdj', 'pseudFF', 'mask' };

%% - properties: GUI: ROIDrawer
% default size of the first empty left and right images
this.GUI.rd.defaultImDim = 200;
% the different tools for the ROIDRawer
this.GUI.rd.drawTools = cell2table({ ...
...     id              callback        tooltip
        'ellipse',      'imellipse',    'Ellipse';
        'freehand',     'imfreehand',   'Free-hand';
}, 'VariableNames', { 'id', 'callback', 'tooltip' });
this.GUI.rd.drawTools.Properties.RowNames = this.GUI.rd.drawTools.id;
% specifies which columns of the DataWatcher's table should be used for the row list display
this.GUI.rd.DWTableColumnsToUse = { 'rowNum', 'rowID', 'dim', 'rowType' };
% specifies whether to pre-load all images when launching the ROIDrawer mode
this.GUI.rd.preloadImages = false;


%% - properties: Analyser
% defines whether to set 0-value pixels to NaN when loading images
this.an.loadImageSetValueToNaNWhenZero = true;

%% -- properties: Analyser : analysis types
% different analysis types available
this.an.analysisTypes = cell2table({ ...
... id                          label                                                       description
    'caTraces_basic',           'Calcium traces (basic)',                                   'Basic plot of the calcium traces';
    'caTraces_heatMap',         'Calcium traces as heat map',                               'Heat map plot of the calcium traces';
    'PSAvg_basic',              'Calcium traces peri-stimulus average',                     'Peri-stimulus time average of the calcium traces, average for all ROIs and all trial';
    'PSAvg_heatMap',            'Calcium traces peri-stimulus average as heat map',         'Peri-stimulus time average of the calcium traces for each ROI, average for all trials';
    'resp_heatMap',             'Responsiveness heat map',                                  'Responsiveness of the ROIs based on the evoked calcium activity as heat map';
    'resp_distr',               'Responsiveness distribution',                              'Responsiveness of the ROIs based on the evoked calcium activity as distribution';
    'SI_heatMap',               'Tuning heat map',                                          'Tuning of the ROIs based on the SI index of the evoked calcium activity';
    'ROIStat',                  'ROI statistic distribution',                               'Distribution of a statistic of the ROIs (response amplitude, response time, SI, ...)';
    'rawChannelTraces',         'Raw traces of channels',                                   'Raw traces of the channels before the DRR or DFF is calculated';
    'behav_timeseries',         'Behavior variables time series',                           'Behavioral variables as time series with different groupings';
    'behav_histograms',         'Behavior variables histograms',                            'Behavioral variables as histograms with different groupings';
    'caTraces_ext',             'Calcium traces & external',                                'Combined plot of the calcium traces and some other time-serie';
    'caTraces_extCorrHeatMap',  'Calcium traces correlation with external as heat map',     'Correlation heat map plot of the calcium traces with an other time serie';
    'caTraces_extCorrDistr',    'Calcium traces correlation distribution with external',    'Correlation distribution of the calcium traces with an other time serie';
}, 'VariableNames', { 'id', 'label', 'description' });
this.an.analysisTypes.Properties.RowNames = this.an.analysisTypes.id; % make the ID be the row names

%% -- properties: GUI: Analyser
% specifies which columns of the DataWatcher's table should be used for the row list display
this.GUI.an.DWTableColumnsToUse = { 'rowNum', 'animal', 'rowID', 'spot', 'rowType', 'runType', 'runNum' };
% specifies a regular expression to shorten the row display, using a cell array with two columns, one for
%   the match pattern and the second for the replace patterns
this.GUI.an.DWTableColumnsRegexp = { ...
    'mou_bl_(\d+)_(\d+)',       'A$2';
    'spot(\d+)',                'S$1';
    'Trial - (\d+)',            'Trial$1';
    'Imaging data',             'imgData';
    'Behavior data',            'behavData';
};

%% -- properties: Analyser: Analysis
% name of the stimulus vector generating function
this.an.stimulusVectorGeneratingFunctionName = 'fromMicrAnalogIn';
% fraction of the image that should excluded on the borders for the neuropil mask
this.an.an.nPilMaskBord = 0.15;
% determines whether a temporal filter (Savitzky-Golay) should be applied on the ROI time series of each channel
%   before ratio (DFF/DRR) calculation
this.an.an.channelSFGiltFrameSize = 1;
% determines whether a down sampling factor should be applied on the ROI time series of each channel
%   before ratio (DFF/DRR) calculation
this.an.an.channelDownSampFactor = 1;

%% -- properties: Analyser: Processing options
% table that determines which pre-processing options can be applied.
this.an.procOptions = cell2table({ ...
... id              label                       defaultOn   isProcStep    description    
    'loadData',     'Load data (full)',         true,       false,        'Fully load the data for this row';
    'genStimVect',  'Generate stim. vector',    true,       false,        'Generate a stimulus vector using fixed times or the behavior data';
    'skipFrame',    'Frame skipping',           true,       true,         'Skip first frame(s) to avoid shutter artifact';
    'fShift',       'Frame shift correction',   true,       true,         'Corrects for frame shifts (constant whole frame shifted on X or Y axis)';
    'fJitt',        'Frame jitter correction',  true,       true,         'Corrects for frame jitter (line-by-line jitter on line alignments)';
    'moCorr',       'Motion correction (XY)',   true,       true,         'Corrects for XY movements artifacts (frame alignment/registration)'; 
    'moDet',        'Motion detection (Z)',     true,       true,         'Detects and masks frames that are out-of-focus on Z using frame-wise correlation'; 
    'extrCaTraces', 'Extract calcium traces',   true,       false,        'Extract the calcium traces (DF/F or DR/R time series) from the images for each ROI'; 
}, 'VariableNames', { 'id', 'label', 'defaultOn', 'isProcStep', 'description' });
this.an.procOptions.Properties.RowNames = this.an.procOptions.id; % make the ID be the row names

%% -- properties: Analyser: Processing options: skip frame
% number of frames to remove in the begining of the imaging data (shutter artifact)
this.an.skipFrame.nFramesBegin = 1;
% number of frames to remove at the end of the imaging data (shutter artifact)
this.an.skipFrame.nFramesEnd = 1;

%% -- properties: Analyser: Processing options: frame shift
% number of times the standard deviation to use as threshold for detecting a frame shift
this.an.fShift.corrThreshFactor = 15;
% minimum and maximum to use as threshold for detecting a frame shift
this.an.fShift.maxCorrThresh = 0.7;
this.an.fShift.minCorrThresh = 0.3;

%% -- properties: Analyser: Processing options: motion correction XY
% determines which type of motion correction should be applied (TurboReg, HMM, ...)
this.an.moCorr.type = 'TurboReg';
% determines which transformation should be used for the turboReg registration, which can be one
%   of: translation/rigidBody/affine/bilinear
this.an.moCorr.regTransf = 'translation';
% determines whether a filter should be applied on the images before motion correction
this.an.moCorr.useFilt = false;
% determines the minimum difference of the 5th percentile of the frame-wise correlation of each aligned frame to the reference
% frame for the motion correction to pass the quality control
this.an.moCorr.meanFrameCorrDiffThresh = -0.05;
% determines the minimum difference of correlation of the average of the aligned frames to the reference
% frame for the motion correction to pass the quality control
this.an.moCorr.frameCorrToRefDiffThresh = -0.1;
% determines the minimum correlation (absolute number) of the average of the aligned frames to the reference
% frame for the motion correction to pass the quality control
this.an.moCorr.frameCorrToRefAbsThresh = 0.85;
% determines whether to use the non-aligned imaging data if the quality control failed
this.an.moCorr.useNonCorrectedIfQualityControlFailed = false;

%% -- properties: Analyser: Processing options: motion detection (Z motion)
% determines whether a filter should be applied on the images before motion detection
this.an.moDet.useFilt = true;
% determines at which threshold is a frame consider out of focus
this.an.moDet.threshFactor = 1.6;
% determines whether single frames that are out of focus (with previous and next frame in focus) should be excluded
this.an.moDet.removeSingleFrames = false;

%% - properties: Behavior

%% -- properties: path: Behavior
myDocumentsPath = 'C:/Users/laurenczy/Documents';
% path of the behavior configuration mat-file
this.path.behavConf = sprintf('%s/LabVIEW Data/mainConf.mat', myDocumentsPath);
% path where the behavior data should be saved
this.path.behavSave = sprintf('%s/LabVIEW Data/%s/', myDocumentsPath, datestr(date, 'yyyy_mm_dd'));

%% -- properties: GUI: Behavior
% update rate of the GUI elements in second
this.GUI.be.updateRate = 1;
% update rate of the trial while-loop when in paused mode (avoids full-speed looping)
this.GUI.be.trialLoopUpdateRate = 0.3;
% names of the behavior auto-reward modes
this.GUI.be.autoRewModes = { 'EarlyOn', 'On', 'Auto', 'Off' };
% names of the behavior configiguration table's columns
this.GUI.be.confTableColNames = { 'AnimalID', 'TaskType', 'Phase' };
% widths of the behavior animal config table's columns
this.GUI.be.confTableColW = { 0.4 0.4 0.2 };
% names of the behavior experiment table's columns
this.GUI.be.expTableColNames = { 'Prev.', 'Curr.', 'Next' };
% widths of the behavior experiment table's columns
this.GUI.be.expTableColW = { 0.22 0.21 0.21 0.21 };
% names of the behavior experiment table's rows
this.GUI.be.expTableRowNames = { 'iTrial', 'Freq', 'Target', 'Response', 'Resp. Time', 'Correct', 'Reward' };
% analog input's magnification factor on the behavior monitoring plot
this.GUI.be.anInMagnifs = [3 20 30 70];
% analog input's filtering options on the behavior monitoring plot
this.GUI.be.anInFilt = [0 11 0 3];
% analog input's absolute-apply options on the behavior monitoring plot
this.GUI.be.anInDoAbs = [0 0 0 1];
% y plot limits for the behavior mode's monitoring plot
this.GUI.be.monPlotLimits = [-3.1, 3.1];
% analog input's display color on the behavior monitoring plot
this.GUI.be.anInColors = { 'b', 'g', 'c', 'r' };

%% -- properties: Behavior: others
% enables to run the behavior software for testing with no actual device connected to the computer
this.be.debugMode = 0;

%% -- properties: Behavior: Hardware
% analog input channels, loaded using the hardware configure structure
this.be.hw.analogIns = { 'yscan', 'motion', 'micr', 'piezo' };
% digital output channels, loaded using the hardware configure structure
this.be.hw.digitalOuts = { 'valve', 'airPuff' };
% analog output channels, loaded using the hardware configure structure
this.be.hw.analogOuts = { 'imagTTL' };
% number of samples to record from the analog input channels
this.be.hw.sampToRec = 200;
% maximum record duration before the recorded data is flushed, only when behavior experiment is not running
this.be.hw.maxRecDur = 25;
% analog input channels' fixed sampling rate
this.be.hw.anInSampRate = 3000;
% analog output channels' fixed sampling rate
this.be.hw.anOutSampRate = 3000;

%% -- properties: Behavior: Params
% threshold for the piezo-sensor "activation" detection (e.g. licking event)
this.be.params.piezoThresh = 0.007;
% valve opening time in seconds ("reward duration")
this.be.params.rewDur = 0.02;
% valve opening time in seconds ("punishment duration")
this.be.params.punishDur = 0.5;
% current mode of rewarding
this.be.params.autoRewardMode = 'Auto';
% time between the imaging end and the trial end in seconds
this.be.params.imgEndStopTime = 3;   


end
