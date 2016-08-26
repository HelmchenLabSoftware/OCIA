function this = OCIA_modeConfig_datawatcher(this)
% adds the DataWatcher mode to the OCIA

%% - properties: DataWatcher
% define structures
this.dw = struct();
this.GUI.dw = struct();
% display settings for each column of the DataWatcher's table
this.GUI.dw.tableDisplay = cell2table({ ...
...     id              label               order   width   visible     description
        'rowNum',       'Row',              01,     0.025,  true,       'Row number'; ...
        'animal',       'Animal',           02,     0.085,  true,       'Animal ID'; ...
        'day',          'Day',              03,     0.058,  true,       'Day'; ...
        'spot',         'Spot',             04,     0.035,  true,       'Spot ID'; ...
        'rowType',      'Row type',         05,     0.075,  true,       'Row type or data type (imaging, behavior, ROISet, etc.)'; ...
        'time',         'Time',             06,     0.052,  true,       'Time'; ...
        'runType',      'Run type',         07,     0.040,  true,       'Run type (which stimulus was used, etc.)'; ...
        'runNum',       'Run number',       08,     0.030,  true,       'Run number (or trial number)'; ...
        'behav',        'Behavior ID',      09,     0.083,  true,       'Behavior''s ID'; ...
        'ROISet',       'ROISet ID',        10,     0.083,  true,       'ROISet''s ID'; ...
        'dim',          'Dimension',        11,     0.070,  true,       'Dimension of the data'; ...
        'data',         'Data',             12,     0.170,  true,       'Data associated with this row'; ...
        'imType',       'Image type',       13,     0.033,  false,      'Image type (movie, frame, stack, etc.)'; ...
        'laserInt',     'Laser intensity',  14,     0.028,  true,       'Laser intensity in percent'; ...
        'zoom',         'Zoom factor',      15,     0.015,  true,       'Zoom factor'; ...
        'frameRate',    'Frame rate',       16,     0.030,  false,      'Imaging frame rate'; ...
        'zStep',        'Z-step',           17,     0.015,  false,      'Z-step for the stacks'; ...
        'comments',     'Comments',         18,     0.140,  true,       'Comments'; ...
        'path',         'Path',             19,     0.500,  false,      'Full path to the folder/file/data'; ...
        'rowID',        'RowID',            20,     0.085,  false,      'Row ID'; ...
...        
    }, 'VariableNames', { 'id', 'label', 'order', 'width', 'visible', 'description' });
this.GUI.dw.tableDisplay.Properties.RowNames = this.GUI.dw.tableDisplay.id; % make the ID be the row names
% store the table IDs for easier referencing
this.dw.tableIDs = this.GUI.dw.tableDisplay.id;
% cell-array holding the current data set (from the watch folder's content), displayed in a big table
this.dw.table = cell(300, numel(this.dw.tableIDs));
% defines whether to sort the table's rows upon displaying it or keep the rows as they were found
this.GUI.dw.sortTableOnDisplay = true;
% specifies whether processing is currently ongoing or not
this.GUI.dw.isProcessingOnGoing = false;
% stores the handle to the Timer object that calls the online analysis function
this.GUI.dw.onlineAnalysisTimer = [];
% specifies the delay between the
this.GUI.dw.onlineAnalysisUpdatePeriod = 5; % in seconds
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
% name of the function that does the online analysis
this.dw.onlineAnalysisFunctionName = 'default';
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
% defines which filter settings should be active at start
this.GUI.dw.DWFilt = { };
% defines which watch types should be activated at start
this.GUI.dw.DWWatchTypes = { };
% defines whether to skip meta-data processing
this.GUI.dw.DWSkiptMeta = true;
% defines whether to keep the current table when re-updating the table (add rows instead of replacing them)
this.GUI.dw.DWKeepTable = false;
% defines the state of the online monitoring of a watch folder
this.GUI.dw.DWOnlineMonitor = false;
% defines whether to use the raw or local watch folder
this.GUI.dw.DWRawOrLocal = 'local';
% list of buttons that are available to further process the data, as a table array with 4 columns: { ID, label, tag, 
%   tooltip }
this.GUI.dw.processButtons = cell2table({ ...
...     id              label               	tag                 tooltip
        'drawROIs',     'Draw ROIs',            'DWDrawROIs',       'Draw Regions Of Interest for selected rows';
        'processRows',  'Process',              'DWProc',           'Process selected rows with the processing steps from the list';
        'analyseRows',  'Analyse',              'DWAnalyse',        'Analyse selected rows (import selected data to Analyser mode)';
        'onlineAnalysis', 'Online analysis',    'DWOnlineAnalysis', 'Update the table constantly in a loop and do some processing with the rows';
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
        'img',          'Imaging folder', { 'spot', 'day' }, true,  'Imaging data folder',              '^(?<day>\d{4}_\d{2}_\d{2})__(?<time>\d{2}_\d{2}_\d{2})h$';
        'notebook',     'Notebook',         'day',      true,       'Notebook file',                    '^notebook__(?<day>\d{4}_\d{2}_\d{2})__(?<time>\d{2}h_\d{2}m)\.txt$';
        'behav',        'Behavior data',    'day',      true,       'Behavior data folder',             '^behav$';
        'roiset',       'ROISet',           'day',      true,       'ROISet folder',                    '^ROISets$';
        'intrinsic',    'Intrinsic',        'day',      true,       'Intrinsic folder',                 '^intr(Fourier)?_?(?<day>\d{4}_\d{2}_\d{2})?$';
%         'wffold',       'Widefield folder', 'day',      false,      'Widefield folder',                 '^widefield$';
%         'wfrun',        'Widefield run',    'wffold',   true,       'Widefield run',                    '^run(?<runNum>\d+)$';
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
% % widefield data
% this.dw.watchTypes{'wfrun', 'subFilePatterns'} = { cell2table({ ...
% ...     id                  label                           createNewRow    pattern
%         'wftrial',          'Widefield trial',              true,           '^(?<day>\d{8})_(?<time>\d{6})_(?<runNum>\d+)$';
% }, 'VariableNames', { 'id', 'label', 'createNewRow', 'pattern' }) };

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

end
