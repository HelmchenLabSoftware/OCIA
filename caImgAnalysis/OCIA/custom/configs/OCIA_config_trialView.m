function this = OCIA_config_trialView(this)
% OCIA_config_trialView - "trialView" OCIA configuration file
%
%       this = OCIA('trialView')
%
% Configuration file for OCIA using the "trialView" configuration. This function should not be called directly
%   but rather using the "this = OCIA('trialView');" syntax to launch the software with this configuration.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% -- properties: TrialView : parameter pannel
% table describing how the parameter panel should be created
this.GUI.tv.paramPanConfig = table({}, {}, {}, {}, [], [], {}, {}, 'VariableNames', ...
    { 'categ', 'id', 'UIType', 'valueType', 'UISize', 'isLabelAbove', 'label', 'tooltip' });
this.GUI.tv.paramPanConfig = cell2table({ ...
    
    ... categ       id              UIType  valueType       UISize  isLabAbove  label       tooltip
        'params',   'fileList',     'list'	{},             [10 0],  true,       'Files',    'File selection list.';
        'params',   'loadRow',      'button', { @OCIA_trialview_loadWideFieldData }, [1 0], false, 'Load row', ...
            'Load the currently selected row.';
        'params',   'saveParams',   'button', { @OCIA_trialview_saveParams }, [1 0.5], false, 'Save params.', 'Save parameters.';
        'params',   'loadParams',   'button', { @OCIA_trialview_loadParams }, [1 0.5], false, 'Load params.', 'Load parameters.';
        'params',   'resetGUI',     'button', { @OCIA_startFunction_trialView }, [1 0], false, 'Reset GUI', 'Reset GUI and start over.';
        'params',   'saveROIs',     'button', { @OCIA_trialview_saveROIs }, [1 0.5], false, 'Save ROIs', 'Save ROIs.';
        'params',   'loadROIs',     'button', { @OCIA_trialview_loadROIs }, [1 0.5], false, 'Load ROIs', 'Load ROIs.';
        'params',   'resetMove',    'button', { @OCIA_trialview_resetMovePoints }, [1 0], false, 'Reset current move vector', 'Reset the move vector for the current trial.';
        'params',   'resetAllMove', 'button', { @OCIA_trialview_resetMovePoints, 'all' }, [1 0], false, 'Reset ALL move vector', 'Reset the move vector for all trials.';
        'params',   'recordMovie',  'button', { @OCIA_trialview_recordMovie }, [1 0], false, 'Record movie', 'Record movie.';
        'params',   'extractROITraces',  'button', { @OCIA_trialview_extractROITraces }, [1 0], false, 'Extract ROI traces', 'Extract ROI traces and save them in a mat file.';
        'params',   'WFAutoplay',   'dropdown', { 'on', 'off' }, [1 0],  false, 'WF auto-play', 'Play/stop the "movie".';
        'params',   'showRef',      'dropdown', { 'true', 'false' }, [1 0],  false, 'Show ref.', 'Show reference image (or calcium data).';
        
    }, 'VariableNames', { 'categ', 'id', 'UIType', 'valueType', 'UISize', 'isLabelAbove', 'label', 'tooltip' });
this.GUI.tv.paramPanConfig.Properties.RowNames = this.GUI.tv.paramPanConfig.id;
% specifies which page of the parameter pannels is currently shown
this.GUI.tv.paramPage = 1;

% handle for autoplay timer
this.GUI.tv.autoplayTimer = timer('Name', 'AutoPlayTimer', 'ExecutionMode', 'fixedRate', ...
    'Period', (this.tv.params.WFAutoplaySpeedFactor * this.tv.params.WFFrameRate), ...
    'TimerFcn', @(h, e)OCIA_trialview_changeFrame(this, 'timer'));

% clean up paths and fill the config parameter panel with values from the parameters structure
paramFields = fieldnames(this.tv.params);
[~, sortInd] = sort(lower(paramFields));
paramFields = paramFields(sortInd);
for iField = 1 : numel(paramFields);
    fieldName = paramFields{iField};
    
    % if current field is a path
    if ~isempty(regexp(fieldName, 'Path$', 'once'));
        currPath = this.tv.params.(fieldName);
        % if no path, use current directory
        if isempty(currPath); currPath = pwd(); end;
        % only use slash instead of backslash
        currPath = regexprep(currPath, '\', '/');
        % make sure path ends with a backslash
        if ~strcmp(currPath(end), '/'); currPath(end + 1) = '/'; end; %#ok<AGROW>
        % store path
        this.tv.params.(fieldName) = currPath;
    end;
    
    % put labels above if they are too long
    isLabAbove = numel(fieldName) >= 7;
    if ismember(fieldName, this.GUI.tv.paramPanConfig.id); continue; end;
    % create configuration depending on the parameter's type
    param = this.tv.params.(fieldName);
    switch class(param);
        case 'char';
            UIType = 'text';
            valueType = { 'text' };
        case { 'int', 'uin16', 'double' };
            UIType = 'text';
            valueType = iff(numel(param) == 1, { 'numeric' }, { 'array' });
        case 'cell';
            UIType = 'text';
            valueType = { 'cellArray' };
        otherwise
            continue;
    end;
    %                        categ       id          UIType  valueType  UISize  isLabAbove  label       tooltip
    paramConf = cell2table({ 'params',   fieldName,  UIType, valueType, [1 0],  isLabAbove, fieldName,  '';
        }, 'VariableNames', this.GUI.tv.paramPanConfig.Properties.VariableNames);
    % append the new configuration to the table and update the row names using the ids
    this.GUI.tv.paramPanConfig = [this.GUI.tv.paramPanConfig; paramConf];
    this.GUI.tv.paramPanConfig.Properties.RowNames = this.GUI.tv.paramPanConfig.id;
end;


%% -- properties: DataWatcher : table display
% loading of Java events
this.GUI.tv.javaInitialized = false;
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
        'dim',          'Dimension',        09,     0.180,  true,       'Dimension of the data'; ...
        'data',         'Data',             10,     0.070,  true,       'Data associated with this row'; ...
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
        'trialView',    '-> TrialView',         'DWTrialView',      'Import selected data to TrialView mode';
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
        'wfTr',             'WF trial',             true,          '^(stim|cond_)(?<condition>hit|CR|100|1200)?_trial(?<runNum>\d+)\.mat$';
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

end
