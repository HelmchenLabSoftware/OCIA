function this = OCIA_config_wolfgangCaData(this)
% OCIA_config_wolfgangCaData - "wolfgangCaData" OCIA configuration file
%
%       this = OCIA('wolfgangCaData')
%
% Configuration file for OCIA using the "wolfgangCaData" configuration. This function should not be called directly
%   but rather using the "this = OCIA('wolfgangCaData');" syntax to launch the software with this configuration.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the default configuration
configHandle = str2func('OCIA_config_default');
this = configHandle(this);

%% - input parameters
this.main.startFunctionName = 'dataWatcher';

% defines whether to show or not a GUI
this.GUI.noGUI = false;
% defines the values of the DataWatcher filters at start
this.GUI.dw.DWFilt = { '' };
% defines which watch types should be activated at start
this.GUI.dw.DWWatchTypes = 'all';
% defines whether to skip meta-data processing
this.GUI.dw.DWSkiptMeta = false;
% defines whether to use the raw or local watch folder
this.GUI.dw.DWRawOrLocal = 'local';

%% -- properties: general: paths to relevant locations (raw data, ect.)
% path of the raw data (usually stored on the server)
this.path.rawData = 'V:/Folder_TWO/YCnano140_2/YCnano2_Optogenetic Mapping/YCnano2_M8/M8_Calcium_Imaging/04.09.2013_CIData_Reg_SN1/2013_09_04/';
% path of the local data
this.path.localData = 'V:/Folder_TWO/YCnano140_2/YCnano2_Optogenetic Mapping/YCnano2_M8/M8_Calcium_Imaging/04.09.2013_CIData_Reg_SN1/2013_09_04/';
% path where the OCIA related things should be saved (OCIA object itself, data, plots, etc.)
this.path.OCIASave = '';

% mini-hack: check computerID and eventually change path
[~, rawComputerID] = system('hostname');
if strcmp(genvarname(rawComputerID), 'HIFOWSH640x2D03b');
    this.path.rawData = 'F:/RawData/WolfgangCa/';
    this.path.localData = 'F:/RawData/WolfgangCa/';
    this.path.OCIASave = 'F:/RawData/WolfgangCa/';
end;

%% - properties: GUI
% initial position of the main window
this.GUI.pos = [300, 300, 1220, 805]; % default
this.main.modes = { 'DataWatcher', 'dw'; 'ROIDrawer', 'rd'; 'Analyser', 'an' };

%% -- properties: DataWatcher
% tells which parts of the raw path should be used for the saving
this.dw.savePathParts = [1, 2];% defines whether the watch folder should be automatically processed upon changing its path
% name of the function that parses the notebook file
this.dw.notebookParsingFunctionName = '';
% name of the function that do post-processing after the notebook file parsing
this.dw.annotateTableFunctionName = 'default';
% name of the function that parses the notebook file
this.dw.notebookParsingFunctionName = 'default';
% name of the function that do pre-processing of the selected rows
this.dw.preProcessFunctionName = 'wolfgangCaData';
% specifies whether to overwrite the file where the data will be saved
this.dw.overwriteSaveFile = false;
% specifies whether to overwrite the data when saving it to HDF5 if it already exists
this.dw.overwriteHDF5Data = true;
% data "types" that are to be flushed between runs once they are saved to avoid memory overflow
this.dw.savedDataToFlushBetweenRuns = { 'raw', 'preProc' };
% specifies which data should be saved in the HDF5 file
this.dw.dataAsHDF5 = { 'raw', 'preProc', 'caTraces', 'ROISets' };
% file patterns for files inside "watchType" folders (these are kind of "sub-watchTypes")
this.dw.watchTypeFilePatterns = struct();
this.dw.watchTypeFilePatterns.roisetfile = '^ROISet_(?<date>\d{4}_\d{2}_\d{2})__(?<time>\d{2}_\d{2}_\d{2})h.mat$';
this.dw.watchTypeFilePatterns.imgdata       = ['^(?<date>\d{4}_\d{2}_\d{2})__(?<time>\d{2}_\d{2}_\d{2})h__', ...
    'channel_?(?<iChan>\d+)\.(tif|bin)$'];
this.dw.watchTypeFilePatterns.imgmetadata   = '';
this.dw.watchTypeFilePatterns.ijroisetfile  = '^RoiSet_(?<time>\d{2}_\d{2}_\d{2})h.zip$';

% specifies which further processing step buttons are available as a cell array with 4 columns: { ID, label, tag, 
%   tooltip }
this.GUI.dw.processButtons = { ...
    'drawROIs',     'Draw ROIs',            'DWDrawROIs',       'Draw Regions Of Interest for selected rows';
    'preProcRows',  'Pre-process row(s)',   'DWPreProcRows',    'Pre-process selected rows';
    'analyseRows',  'Analyse row(s)',       'DWAnalyseRows',    'Analyse selected rows';
    'saveResults',  'Save results',         'DWSaveResults',    'Save results';
    'importIJROIs', 'Import ROIs',          'DWImportIJROIs',   'Import ImageJ ROI set zip file';
};

%% -- properties: DataWatcher : watch types
% file/folder types that can be processed and will appear in the DataWatcher's table with their regexp pattern, stored
%   as a cell-array with 6 columns: { ID, display name, parent folder, visible in GUI, tooltip text, 
%   regular expression pattern }
this.dw.watchTypes = cell2table({
    'day',          'Day',          [],         true,   'Day folder',               '^\d{4}_\d{2}_\d{2}$';
    'img',          'Imag. data',   'day',     true,   'Imaging data folder', ...
        '^(?<date>\d{4}_\d{2}_\d{2})__(?<time>\d{2}_\d{2}_\d{2})h(?<add>_X.*)$';
    'ijroiset',     'IJ ROIs',      'day',      true,   'ImageJ ROIs folder',       '^ROIs$';
    'roiset',       'ROISet',       'day',      true,   'ROISet folder',            '^ROISets$';
}, 'VariableNames', { 'id', 'label', 'parent', 'visible', 'tooltip', 'pattern' });

%% -- properties: DataWatcher : data configuration
% defines which data "modules" should be appended to the software
this.main.dataModes = { 'img'; };
% define the data saving options for each "type" of saving
this.main.dataConfig = { ...
    'GUI',      'GUI',              'Save / load the GUI (table, checkboxes'' values, etc.)';
    'raw',      'Raw data',         'Save / load the raw data';
    'preProc',  'Pre-proc. data',   'Save / load the pre-processed data';
    'caTraces', 'Calcium traces',   'Save / load the extracted calcium traces';
    'ROISets',  'ROISets',          'Save / load the ROISets';
};

% apply data configuration
configHandle = str2func('OCIA_modeConfig_data');
this = configHandle(this);

%% -- properties: DataWatcher: filter elements and IDs
% defines the aspect of the filtering panel: cell array with nFilt lines and 
%   5 columns: { filter name, GUI type, GUI width and DataWatcher table's column column where to apply the filter, supports range }
this.GUI.dw.filtElems = { ...
    'day',      'dropdown',     1,      2,  false;
    'spot',     'dropdown',     1,      1,  false;
    'rowtype',  'textfield',    1,      1,  false;
    'runtype',  'textfield',    1,      9,  true;
};
% define the "IDs" field for each drop-down DataWatcher filter element
dropDownListFilterNames = this.GUI.dw.filtElems(strcmp(this.GUI.dw.filtElems(:, 2), 'dropdown'), 1);
for iName = 1 : numel(dropDownListFilterNames);
    filtName = dropDownListFilterNames{iName}; % get the filter name
    % create a list with only a dash element, which corresponds to no filtering
    this.dw.([filtName 'IDs']) = {'-'};
end;

%% -- properties: Analyser
% available plot types in the analyser panel
this.an.plotTypes = { 'ROICaTraces', 'ROICaTracesHeatMap', 'RawTraces' };

%% -- properties: Analyser: Imaging
% number of channel(s) to load; also the number of data files that should be in a data folder
this.an.img.nChans = 2;
% index of the channel on which the pre-processing should be calculated (motion correction/detection, etc.)
this.an.img.preProcChan = 1;
% channels to use for the RGB image display
this.an.img.colVect = [0 1 2];
% channels to use for the dFF/dRR calculations
this.an.img.chanVect = [1 2];
% frame rate of the imaging in hertz
this.an.img.defaultFrameRate = 10;
% fixed/default dimensions of the imaging data in pixels
this.an.img.defaultImDim = [128 64];
% minimum number of frames for a row to be considered as a functional movie
this.an.img.funcMovieNFramesLimit = 2;
% F0/R0 method index. Methods are mean, median, prctile, polyfit, polyfitMean
this.an.img.f0method = 3;
% F0/R0 parameter (can be empty), for percentile: Nth percentile; for polyfit: polyfit degree
this.an.img.f0params = 12;
% degree of the polyfit correction for bleaching. Set to 0 for no correction.
this.an.img.polyfitCorrect = 0;
% percent of the trace where the polyfit correction should be calculated
this.an.img.polyfitFraction = 0;
%% -- properties: Analyser: Analysis
% name of the stimuli
this.an.an.stimIDs = {};
% duration of the stimulus in seconds
this.an.an.stimDur = 0;
% number of frames to remove in the begining of the imaging data (shutter artifact)
this.an.an.nSkipFrame = 1;
% determines which transformation should be used for the turboReg registration, which can be one
%   of: translation/rigidBody/affine/bilinear
this.an.an.regTransf = 'rigidBody';
% determines whether a filter should be applied on the images before motion correction
this.an.an.moCorrFilt = false;
% determines the minimum difference of the 5th percentile of the frame-wise correlation of each aligned frame to the reference
% frame for the motion correction to pass the quality control
this.an.an.moCorMeanFrameCorrDiffThresh = -0.05;
% determines the minimum difference of correlation of the average of the aligned frames to the reference
% frame for the motion correction to pass the quality control
this.an.an.moCorFrameCorrToRefDiffThresh = -0.1;
% determines the minimum correlation (absolute number) of the average of the aligned frames to the reference
% frame for the motion correction to pass the quality control
this.an.an.moCorFrameCorrToRefAbsThresh = 0.85;
% determines whether to use the non-aligned stacks if the quality control failed
this.an.an.moCorUseNonCorrectedIfQualityControlFailed = false;
% determines whether a filter should be applied on the images before motion detection
this.an.an.moDetFilt = true;
% determines at which threshold is a frame consider out of focus
this.an.an.moDetOOFThreshFactor = 1.6;
% determines which pre-processing options should be applied. Should be a cell array containing one or
%   more of: 'skipFrame', 'fShift', 'fJitt', 'moCorr', 'moDet'
this.an.an.preProcOptions = { 'skipFrame', 'moCorr' };
% number of seconds for the peri-stimulus averaging (peri-stimulus period): base and evoked
this.an.an.PSPer = [0 0];
% fraction of the image that should excluded on the borders for the neuropil mask
this.an.an.nPilMaskBord = 0.15;
% down-sampling factor to apply to the functional data to the functional data (DRR or DFF)
this.an.an.downSampFactor = 1;
% frame size of the Savitzky-Golay filter to apply to the functional data (DRR or DFF)
this.an.an.sgFiltFrameSize = 1;
% determines whether a temporal filter (Savitzky-Golay) should be applied on the ROI time series of each channel
%   before ratio (DFF/DRR) calculation
this.an.an.channelSFGiltFrameSize = 1;
% determines whether a down sampling factor should be applied on the ROI time series of each channel
%   before ratio (DFF/DRR) calculation
this.an.an.channelDownSampFactor = 1;

end
