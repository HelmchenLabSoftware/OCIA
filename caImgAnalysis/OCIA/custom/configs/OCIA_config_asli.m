function this = OCIA_config_asli(this)
% OCIA_config_asli - "asli" OCIA configuration file
%
%       this = OCIA('asli')
%
% Configuration file for OCIA using the "asli" configuration. This function should not be called directly
%   but rather using the "this = OCIA('asli');" syntax to launch the software with this configuration.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the default configuration
configHandle = str2func('OCIA_config_default');
this = configHandle(this);

% define some path
% currentDir = regexprep(pwd(), '\\', '/');

%% - input parameters
this.main.startFunctionName = 'processWatchFolderAndExtractNotebook';

% defines whether to show or not a GUI
this.GUI.noGUI = false;
% defines the values of the DataWatcher filters at start
this.GUI.dw.DWFilt = { 'ast2', '2014_04_01', 'spot3', 's31', '', '' };
% defines which watch types should be activated at start
this.GUI.dw.DWWatchTypes = 'all';
% defines whether to skip meta-data processing
this.GUI.dw.DWSkiptMeta = true;
% defines whether to use the raw or local watch folder
this.GUI.dw.DWRawOrLocal = 'local';

%% -- properties: general: paths to relevant locations (raw data, ect.)
% path of the raw data (usually stored on the server)
this.path.rawData = 'W:/Transfer/ayaz/sample for Balasz/';
% path of the local data
this.path.localData = 'F:/RawData/Asli/Two Photon/';
% path where the OCIA related things should be saved (OCIA object itself, data, plots, etc.)
this.path.OCIASave = 'E:/Analysis/Asli/';

%% - properties: GUI
% initial position of the main window
this.GUI.pos = [345, 185, 1220, 805]; % default
this.main.modes = { 'DataWatcher', 'dw'; 'ROIDrawer', 'rd'; 'Analyser', 'an'; };

%% -- properties: DataWatcher
% tells which parts of the raw path should be used for the saving
this.dw.savePathParts = [1, 2, 3];
% name of the function that do post-processing after the notebook file parsing
this.dw.extractNotebookPostProcessFunctionName = 'default';
% name of the function that do pre-processing of the selected rows
this.dw.preProcessFunctionName = 'asli';
% specifies whether to overwrite the file where the data will be saved
this.dw.overwriteSaveFile = false;
% specifies whether to overwrite the data when saving it to HDF5 if it already exists
this.dw.overwriteHDF5Data = true;
% specifies which data should be saved in the HDF5 file
this.dw.dataAsHDF5 = { 'raw', 'preProc', 'caTraces', 'ROISets', 'stim' };
% file patterns for files inside "watchType" folders (these are kind of "sub-watchTypes")
this.dw.watchTypeFilePatterns = struct();
this.dw.watchTypeFilePatterns.roisetfile = '^ROISet_(?<date>\d{4}_\d{2}_\d{2})__(?<time>\d{2}_\d{2}_\d{2})h.mat$';
this.dw.watchTypeFilePatterns.imgdata       = ['^(?<date>\d{4}_\d{2}_\d{2})__(?<time>\d{2}_\d{2}_\d{2})h__', ...
    'channel_?(?<iChan>\d+)\.(tif|bin)$'];
this.dw.watchTypeFilePatterns.imgmetadata   = '^(?<date>\d{4}_\d{2}_\d{2})__(?<time>\d{2}_\d{2}_\d{2})h\.xml$';

%% -- properties: DataWatcher : watch types
% file/folder types that can be processed and will appear in the DataWatcher's table with their regexp pattern, stored
%   as a cell-array with 6 columns: { ID, display name, parent folder, visible in GUI, tooltip text, 
%   regular expression pattern }
this.dw.watchTypes = cell2table({
    'animal',       'Animal',       [],         true,   'Animal folder',            '^(ast|aa)\d+$';
    'day',          'Day',          'animal',   true,   'Day folder',               '^\d{4}_\d{2}_\d{2}$';
    'spot',         'Spot',         'day',      true,   'Spot folder',              '^spot\d$';
    'session',      'Session',      'spot',     false,  'Session folder',           '^s\d+$';
    'img',          'Imag. data',   'session',  true,   'Imaging data folder', ...
        '^(?<date>\d{4}_\d{2}_\d{2})__(?<time>\d{2}_\d{2}_\d{2})h$';
    'roiset',       'ROISet',       'spot',     true,   'ROISet folder',            '^ROISets$';
}, 'VariableNames', { 'id', 'label', 'parent', 'visible', 'tooltip', 'pattern' });

%% -- properties: DataWatcher : data configuration
% defines which data "modules" should be appended to the software
this.main.dataModes = { 'img' };
% define the data saving options for each "type" of saving
this.main.dataConfig = { ...
    'GUI',      'GUI',              'Save / load the GUI (table, checkboxes'' values, etc.)';
    'raw',      'Raw data',         'Save / load the raw data';
    'preProc',  'Pre-proc. data',   'Save / load the pre-processed data';
    'caTraces', 'Calcium traces',   'Save / load the extracted calcium traces';
    'exclMask', 'Exclusion masks',  'Save / load the exclusion masks (from motion detection)';
    'stim',     'Stimulus'          'Save / load the stimulus vectors for the calcium traces';
    'ROISets',  'ROISets',          'Save / load the ROISets';
};

% apply data configuration
configHandle = str2func('OCIA_modeConfig_data');
this = configHandle(this);

%% -- properties: DataWatcher: filter elements and IDs
% defines the aspect of the filtering panel: cell array with nFilt lines and 
%   5 columns: { filter name, GUI type, GUI width and DataWatcher table's column column where to apply the filter, supports range }
this.GUI.dw.filtElems = { ...
    'animal',   'dropdown',     1,      1,  false;
    'day',      'dropdown',     1,      2,  false;
    'spot',     'dropdown',     1,      1,  false;
    'session',  'dropdown',     1,      1,  false;
    'ROISet',   'textfield',    1,      1,  false;
    'rowtype',  'textfield',    0.5,    1,  false;
    'runtype',  'textfield',    0.5,    1,  false;
};
% define the "IDs" field for each drop-down DataWatcher filter element
dropDownListFilterNames = this.GUI.dw.filtElems(strcmp(this.GUI.dw.filtElems(:, 2), 'dropdown'), 1);
for iName = 1 : numel(dropDownListFilterNames);
    filtName = dropDownListFilterNames{iName}; % get the filter name
    % create a list with only a dash element, which corresponds to no filtering
    this.dw.([filtName 'IDs']) = {'-'};
end;

%% -- properties: Analyser: Imaging
% number of channel(s) to load; also the number of data files that should be in a data folder
this.an.img.nChans = 2;
% index of the channel on which the pre-processing should be calculated (motion correction/detection, etc.)
this.an.img.preProcChan = 2;
% channels to use for the RGB image display
this.an.img.colVect = [0 2 1];
% channels to use for the dFF/dRR calculations
this.an.img.chanVect = [2 1];
% frame rate of the imaging in hertz
this.an.img.defaultFrameRate = 10;
% fixed/default dimensions of the imaging data in pixels
this.an.img.defaultImDim = [100 100];
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
this.an.an.preProcOptions = { 'skipFrame' };
% number of seconds for the peri-stimulus averaging (peri-stimulus period): base and evoked
this.an.an.PSPer = [1.2, 1.2];
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
