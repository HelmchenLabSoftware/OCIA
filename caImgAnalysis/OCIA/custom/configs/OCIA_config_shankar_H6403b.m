function this = OCIA_config_shankar_H6403b(this)
% OCIA_config_shankar_H6403b - "shankar_H6403b" OCIA configuration file
%
%       this = OCIA('shankar_H6403b')
%
% Configuration file for OCIA using the "shankar_H6403b" configuration. This function should not be called directly
%   but rather using the "this = OCIA('shankar_H6403b');" syntax to launch the software with this configuration.
%
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
    };

% defines which data "modules" should be appended to the software. Should be a cell-array of strings with one element
%   per data mode. Also needs to be initialized before the call to 'OCIA_config_default'.
this.main.dataModes = { 'img'; 'behavtext' };

%% get the default configuration
configHandle = str2func('OCIA_config_default');
this = configHandle(this);

%% parameters

% starting function name
this.main.startFunctionName = 'dataWatcher';
% this.main.startFunctionName = 'default';
% this.main.startFunctionName = 'processWatchFolderAndExtractNotebook';

% defines whether to show or not a GUI
this.GUI.noGUI = false;
% defines the values of the data watcher filters at start
this.GUI.dw.DWFilt = { };
this.GUI.dw.DWFilt = { 'yc2', '2015_03_12', 'r1', '', '', '' };
% this.GUI.dw.DWFilt = { 's5', '2014_12_05', '', '', '', '' };
% this.GUI.dw.DWFilt = { 's5', '2014_12_05', 'r2', '', '', '' };
% defines which watch types should be activated at start
this.GUI.dw.DWWatchTypes = 'all';
% defines whether to skip meta-data processing
this.GUI.dw.DWSkiptMeta = false;
% defines whether to keep the current table when re-updating the table (add rows instead of replacing them)
this.GUI.dw.DWKeepTable = false;
% defines whether to use the raw or local watch folder
this.GUI.dw.DWRawOrLocal = 'local';

this.GUI.pos = [22, 335, 1879, 831];

%% -- properties: general: paths to relevant locations (raw data, ect.)
% path of the raw data (usually stored on the server)
this.path.rawData = 'F:/RawData/Shankar/';
% path of the local data
this.path.localData = 'F:/RawData/Shankar/';
% path where the OCIA related things should be saved (OCIA object itself, data, plots, etc.)
this.path.OCIASave = 'E:/Analysis/Shankar/';

%% - properties: DataWatcher
% define structures
% display settings for each column of the DataWatcher's table
this.GUI.dw.tableDisplay = cell2table({ ...
...     id              label               order   width   visible     description
        'rowNum',       'Row',              01,     0.025,  true,       'Row number'; ...
        'animal',       'Animal',           02,     0.085,  true,       'Animal ID'; ...
        'spot',         'Region',           03,     0.035,  true,       'Region ID'; ...
        'day',          'Day',              04,     0.058,  true,       'Day'; ...
        'time',         'Time',             05,     0.052,  true,       'Time'; ...
        'dim',          'Dimension',        06,     0.070,  true,       'Dimension of the data'; ...
        'rowType',      'Row type',         07,     0.075,  true,       'Row type or data type (imaging, behavior, ROISet, etc.)'; ...
        'runType',      'Run type',         08,     0.040,  true,       'Run type (which stimulus was used, etc.)'; ...
        'runNum',       'Run number',       09,     0.030,  true,       'Run number (or trial number)'; ...
        'ROISet',       'ROISet ID',        10,     0.083,  true,       'ROISet''s ID'; ...
        'data',         'Data',             11,     0.170,  true,       'Data associated with this row'; ...
        'imType',       'Image type',       12,     0.033,  false,      'Image type (movie, frame, stack, etc.)'; ...
        'laserInt',     'Laser intensity',  13,     0.028,  true,       'Laser intensity in percent'; ...
        'zoom',         'Zoom factor',      14,     0.015,  true,       'Zoom factor'; ...
        'frameRate',    'Frame rate',       15,     0.030,  true,       'Imaging frame rate'; ...
        'zStep',        'Z-step',           16,     0.015,  false,      'Z-step for the stacks'; ...
        'comments',     'Comments',         17,     0.155,  true,       'Comments'; ...
        'path',         'Path',             18,     0.500,  false,      'Full path to the folder/file/data'; ...
        'rowID',        'RowID',            19,     0.085,  false,      'Row ID'; ...
...        
    }, 'VariableNames', { 'id', 'label', 'order', 'width', 'visible', 'description' });
this.GUI.dw.tableDisplay.Properties.RowNames = this.GUI.dw.tableDisplay.id; % make the ID be the row names
% store the table IDs for easier referencing
this.dw.tableIDs = this.GUI.dw.tableDisplay.id;
% cell-array holding the current data set (from the watch folder's content), displayed in a big table
this.dw.table = cell(300, numel(this.dw.tableIDs));
% specifies whether processing is currently ongoing or not
this.GUI.dw.isProcessingOnGoing = false;
% currently selected (highlighted) database row. Empty if none selected
this.dw.selectedTableRows = [];
% pattern to use to built the DataWatcher table rows' IDs
this.dw.rowIDPattern = '%s_%s';
% columns from the DataWatcher table to use to built the DataWatcher table rows' IDs using the specified pattern,
%   including the replace patterns for each column.
this.dw.rowIDColumns = { ...
...     id              replaceSourcePattern    replaceTargetPattern
        'day',          '_',                    '';
        'time',         '_',                    '';
};
% path to the folder to 'watch' for data
this.dw.watchFolder = '';
% defines whether the watch folder should be automatically processed upon changing its path
this.dw.autoProcessWatchFolder = false;
% defines whether a warning of data flushing upon watch folder change should be displayed or not
this.dw.ignoreDataFlushWarning = true;
% defines which data types to flush after saving. If empty, selected data types will be flushed
this.dw.dataTypesToFlushAfterSaving = { 'rawImg', 'procImg', 'caTraces', 'stim', 'exclMask', 'rawChan', 'behavExtr' };
% defines the maximum number of frames to load for the preview loading type
this.dw.previewNMaxFrameToLoad = 5;
% tells with which "path" configuration to save the HDF5 data
this.dw.HDF5.savePathConfig = { 'animal', 'spot', 'day' };
% HDF5 saving compression level. If empty or 0, no compression at all, otherwise specify values 
%   between 1 (best speed) and 9 (best compression)
this.dw.HDF5.GZipLevel = 0;
% name of the function that do post-processing after the notebook file parsing
this.dw.annotateTableFunctionName = 'shankar';
% name of the function that parses the notebook file
this.dw.notebookParsingFunctionName = 'default';
% time threshold in milliseconds to check for time mismatchs
this.dw.trialMatchingTimeDifferenceThreshold = 4000;
% whether to keep ROINames when importing or reseting them
this.dw.IJImportKeepROIName = false;

%% -- properties: GUI: DataWatcher
% string defining the delete on unload tag for fields that need to be deleted when the data is flushed
this.GUI.dw.deleteTag = '__DELETE_ON_UNLOAD__';
% string that is displayed for the cells of the DataWatcher's table that are empty, must be longer than 1 char !
this.GUI.dw.tableEmptyCellDisplayContent = ' - ';
% defines whether to show a summary line for folders that were not processed
this.GUI.dw.showEmptyFolderSummary = true;
% defines whether to show a small thumbnail of the currently selected row
this.GUI.dw.showThumbnailPreview = true;
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
        'animal',       'Animal',           [],         true,       'Animal folder',                    '^(?<animal>[sypg][cv]?\w?\d\d?)$';
        'day',          'Day',              'animal',   true,       'Day folder',                       '^(?<day>\d{4}_\d{2}_\d{2})$';
        'spot',         'Region',           'day',      true,       'Region folder',                    '^(?<spot>r\d\d?\w?)$';
        'img',          'Imaging folder',   'spot',     true,       'Imaging data folder for spots',    '^(?<day>\d{4}_\d{2}_\d{2})__(?<time>\d{2}_\d{2}_\d{2})h$';
        'notebook',     'Notebook',         'day',      true,       'Notebook file',                    '^notebook__(?<day>\d{4}_\d{2}_\d{2})__(?<time>\d{2}h_\d{2}m)\.txt$';
        'behavtext',    'Behavior data',    'day',      true,       'Behavior data folder',             '^(?<animal>[sypg][cv]?\w?\d\d?)(?<spot>r\d\d?\w?)(\w+)?_\d{8}$';
        'roiset',       'ROISet',           'day',      true,       'ROISet folder',                    '^ROISets$';
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
        'imgData',          'Imaging data',         false,          '^(?<day>\d{4}_\d{2}_\d{2})__(?<time>\d{2}_\d{2}_\d{2})h__channel_?(?<iChan>\d+)\.(bin|tif)$';
}, 'VariableNames', { 'id', 'label', 'createNewRow', 'pattern' }) };
% behavior data
this.dw.watchTypes{'behavtext', 'subFilePatterns'} = { cell2table({ ...
...     id                  label                   createNewRow    pattern
        'behavtextdata',    'Behavior data',        false,          '^(?<animal>[sypg][cv]?\w?\d\d?)(?<spot>r\d\d?\w?)(\w+)?_(?<date>\d{8})(?<time>\d{6})_(?<runNum>\d+)\.tdms_index$';
        'behavtextnbdata',  'Behavior data',        false,          '^(?<animal>[sypg][cv]?\w?\d\d?)(?<spot>r\d\d?\w?)(\w+)?(?<date>\d{8})\.txt$';
}, 'VariableNames', { 'id', 'label', 'createNewRow', 'pattern' }) };
% ROISet
this.dw.watchTypes{'roiset', 'subFilePatterns'} = { cell2table({ ...
...     id                  label                   createNewRow    pattern
        'ROISetMatFile',    'ROISet',               true,           '^ROISet_(?<day>\d{4}_\d{2}_\d{2})__(?<time>\d{2}_\d{2}_\d{2})h\.mat$';
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


%% - properties: GUI: ROIDrawer
% default size of the first empty left and right images
this.GUI.rd.defaultImDim = 128;
% the different tools for the ROIDRawer
this.GUI.rd.drawTools = cell2table({ ...
...     id              callback        tooltip
        'ellipse',      'imellipse',    'Ellipse';
        'freehand',     'imfreehand',   'Free-hand';
}, 'VariableNames', { 'id', 'callback', 'tooltip' });
this.GUI.rd.drawTools.Properties.RowNames = this.GUI.rd.drawTools.id;
% currently displayed image
this.GUI.rd.img = zeros(this.GUI.rd.defaultImDim, this.GUI.rd.defaultImDim, 3);
% currently applied image corrections
this.GUI.rd.applImCorr = { };
% current zoom level
this.GUI.rd.zoomLevel = 1;
% specifies which columns of the DataWatcher's table should be used for the row list display
this.GUI.rd.DWTableColumnsToUse = { 'rowNum', 'rowID', 'dim', 'rowType' };
% specifies whether to pre-load all images when launching the ROIDrawer mode
this.GUI.rd.preloadImages = false;

%% - properties: ROIDrawer
% cell array containing the averaged frames for the rows loaded in the ROIDrawer
this.rd.avgImages = {};
% cell array containing the raw frames for the rows loaded in the ROIDrawer
this.rd.rawFrames = {};
% ROIMask mask defined by the drawn ROIs
this.rd.ROIMask = [];
% stores the selected rows that are currently used for 
this.rd.selectedTableRows = [];
% current number of ROIs
this.rd.nROIs = 0;
% cell-array containing the data for the drawn ROIS. Columns are: {handles of the drawn ROIs (imroi objects),
    % ROI IDs, ROI's position, ROI type (ellipse, freehand, etc.), text handles, modified flag.
this.rd.ROIs = {};
% ROISet comparator's temporary files
this.rd.rc = struct('ROISetIDs', [], 'ROISets', [], 'refImgs', [], 'ROINamesUnion', [], 'displayedRef', -1);
% vectors of displacement when moving all ROIs at the same time
this.rd.moveROIVects = struct('up', [0 -1 0 0], 'down', [0 1 0 0], 'left', [-1 0 0 0], 'right', [1 0 0 0]);
% number of pixels/units to move ROIs when adjusting the position of ROIs
this.rd.moveROIsStep = 2;
% angle in degrees to rotate ROIs when adjusting the position of ROIs
this.rd.rotateROIsStep = 1;
% possible image corrections
this.rd.imCorr = { 'imAdj', 'pseudFF', 'mask' };

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
%     'SI_heatMap',               'Tuning heat map',                                          'Tuning of the ROIs based on the SI index of the evoked calcium activity';
    'ROIStat_distr',            'ROI statistic distribution',                               'Distribution of a statistic of the ROIs (response amplitude, response time, SI, ...)';
    'ROIStat_corr',             'ROI statistic correlation',                                'Compares different statistics of ROIs (response amplitude, response time, SI, ...)';
    'NvsNP1',                   'Multi-day same ROI comparison',                            'Compares statistics of ROIs for different days (response amplitude, response time, SI, ...)';
    'rawChannelTraces',         'Raw traces of channels',                                   'Raw traces of the channels before the DRR or DFF is calculated';
    'behav_timeseries',         'Behavior variables time series',                           'Behavioral variables as time series with different groupings';
    'behav_histograms',         'Behavior variables histograms',                            'Behavioral variables as histograms with different groupings';
}, 'VariableNames', { 'id', 'label', 'description' });
this.an.analysisTypes.Properties.RowNames = this.an.analysisTypes.id; % make the ID be the row names

%% -- properties: GUI: Analyser
% table describing how the parameter panel should be created for each analysis
this.GUI.an.analysisParamConfig = table({}, {}, {}, {}, [], [], {}, {}, 'VariableNames', ...
    { 'categ', 'id', 'UIType', 'valueType', 'UISize', 'isLabelAbove', 'label', 'tooltip' });
% specifies which columns of the DataWatcher's table should be used for the row list display
this.GUI.an.DWTableColumnsToUse = { 'rowNum', 'animal', 'spot', 'rowType', 'runType', 'runNum', 'rowID' };
% specifies a regular expression to shorten the row display, using a cell array with two columns, one for
%   the match pattern and the second for the replace patterns
this.GUI.an.DWTableColumnsRegexp = { ...
    'Imaging data',             'imgData';
};
% specifies which page of the parameter pannels is currently shown
this.GUI.an.paramPage = 1;

%% -- properties: Analyser: Analysis
% name of the stimulus vector generating function
this.an.stimulusVectorGeneratingFunctionName = 'fromBehavTextFile';
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
%     'fShift',       'Frame shift correction',   true,       true,         'Corrects for frame shifts (constant whole frame shifted on X or Y axis)';
%     'fJitt',        'Frame jitter correction',  true,       true,         'Corrects for frame jitter (line-by-line jitter on line alignments)';
    'moCorr',       'Motion correction (XY)',   true,       true,         'Corrects for XY movements artifacts (frame alignment/registration)'; 
    'moDet',        'Motion detection (Z)',     true,       true,         'Detects and masks frames that are out-of-focus on Z using frame-wise correlation'; 
    'extrCaTraces', 'Extract calcium traces',   true,       false,        'Extract the calcium traces (DF/F or DR/R time series) from the images for each ROI'; 
}, 'VariableNames', { 'id', 'label', 'defaultOn', 'isProcStep', 'description' });
this.an.procOptions.Properties.RowNames = this.an.procOptions.id; % make the ID be the row names

%% -- properties: Analyser: Processing options: skip frame
% number of frames to remove in the begining of the imaging data (shutter artifact)
this.an.skipFrame.nFramesBegin = 2;
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

%% imaging data type
% down-sampling factor to apply to the functional data to the functional data (DRR or DFF)
this.an.img.downSampFactor = 1;
% frame size of the Savitzky-Golay filter to apply to the functional data (DRR or DFF)
this.an.img.sgFiltFrameSize = 1;
% show or hide (mask) the excluded frames
this.an.img.exclFrames = 'show';
% name of the stimuli
this.an.img.allStimIDs = { ...
    'P100', 'P600', 'P1200', ''; ...
    'P100', 'P600', 'P1200', ''; ...
    'Go', 'NoResp', 'InapResp', 'NoGo';
    'Go', 'NoResp', 'InapResp', 'NoGo';
};
% selected stimulus IDs
this.an.img.selStimIDs = { };
% selected stimulus IDs for display
this.an.img.selDispStimIDs = { };
% selected stimulus type groups
this.an.img.selStimTypeGroups = { };
% duration of the stimulus in seconds
this.an.img.stimDur = 0.5;
% plotting limits. Leave empty for auto limits.
this.an.img.plotLimits = [];
% number of seconds for the peri-stimulus averaging (peri-stimulus period): base and evoked
this.an.img.PSPer = { 'all', -2, 0, 0, 4.5 };
% ID of the peri-stimulus period to use
this.an.img.PSPerID = 'all';
% colormap to use for heatmap plots
this.an.img.colormap = 'gray';
% defines whether ROIs should be averaged together in some plots
this.an.img.averageROI = 'false';
% defines whether to combine ROIs for their presence in different days/ROISets
this.an.img.combineROIs = 'true';
% defines whether to normalise trials by the mean activity of their baseline
this.an.img.normBaseline = 'true';
% defines whether to show single trials or not
this.an.img.showTrials = 'true';
% defines the minimum number of stimulus to have for a stimulus type in order to be included in the average
this.an.img.nStimsThreshold = 0;
% sorting method
this.an.img.sortMethod = 'none';
% sorting direction
this.an.img.sortDirection = 'ascending';
% sorting stimulus 
this.an.img.sortStim = 'low';
% responsiveness calculating method
this.an.img.respMethod = 'mean';
% this.an.img.respMethod = '3ppmax';
% ROI statistic to use/plot
this.an.img.ROIStat = 'responsiveness';
% ROI statistic number 2 to use/plot
this.an.img.ROIStat2 = 'response time';
% threshold for excluding non-responsive ROIs
this.an.img.ROIRespThresh = 0.5;
% group names for the ROI property grouping
this.an.img.groupNames = { 'baseline', 'naïve', 'expert', 'lateExpert' };
% defines how to plot ROI statistics, as a curve-histogram, a scatter-distribution, cumulative distributions, ...
this.an.img.ROIStatPlotType = 'distribution';
% grouping options for the data analysis
this.an.img.groupBy = 'day';
% grouping options for the data analysis
this.an.img.groupBy2 = 'stimType';
% which type of traces should be shown
this.an.img.traceTypeToShow = { 'filtered only' };
% selected ROI names
this.an.img.selROINames = {};
% noisy trial exclusion threshold
this.an.img.noisyTrialsThresh = 'Inf';
% noisy trial exclusion threshold
this.an.img.NVsNP1ShowFit = 'false';


% number of channel(s) to load; also the number of data files that should be in a data folder
this.an.img.nChans = 3;
% index of the channel on which the pre-processing should be calculated (motion correction/detection, etc.)
this.an.img.preProcChan = 2;
% channels to use for the RGB image display
this.an.img.colVect = [0 2 3];
% channels to use for the dFF/dRR calculations
this.an.img.chanVect = [2 3];
% frame rate of the imaging in hertz
this.an.img.defaultFrameRate = 15.6;
% fixed/default dimensions of the imaging data in pixels
this.an.img.defaultImDim = [128 64];
% minimum number of frames for a row to be considered as a functional movie
this.an.img.funcMovieNFramesLimit = this.dw.previewNMaxFrameToLoad + 1;
% F0/R0 method index. Methods are mean, median, prctile, polyfit, polyfitMean
this.an.img.f0method = 3;
% F0/R0 parameter (can be empty), for percentile: Nth percentile; for polyfit: polyfit degree
this.an.img.f0params = 12;
% background subtraction percentile
this.an.img.bgPrctile = 1;
% degree of the polyfit correction for bleaching. Set to 0 for no correction.
this.an.img.polyfitCorrect = 0;
% percent of the trace where the polyfit correction should be calculated
this.an.img.polyfitFraction = 0.0;

end
