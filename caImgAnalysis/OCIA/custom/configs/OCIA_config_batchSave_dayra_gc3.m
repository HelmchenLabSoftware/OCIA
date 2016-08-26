function this = OCIA_config_batchSave_dayra_gc3(this)
% OCIA_config_batchSave_dayra_gc3 - "batchSave_dayra_gc3" OCIA configuration file
%
%       this = OCIA('batchSave_dayra_gc3')
%
% Configuration file for OCIA using the "batchSave_dayra_gc3" configuration. This function should not be called directly
%   but rather using the "this = OCIA('batchSave_dayra_gc3');" syntax to launch the software with this configuration.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the default configuration
configHandle = str2func('OCIA_config_default');
this = configHandle(this);

% general parameters
this.main.startFunctionName = 'processAndSavePipeline';
this.GUI.noGUI = false;
% this.GUI.noGUI = true;
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
this.GUI.pos = [-1277, 83, 1275, 1000];

%% - properties: general
% verbosity, number telling how much debugging output should be printed out. The higher the more verbose.
this.verb = 2;

%% -- properties: general: paths to relevant locations (raw data, ect.)
% path of the raw data (usually stored on the server)
this.path.rawData = '/home/gc3-user/HIFONASHE-02/RawData/Dayra_Lorenzo/2014_07_chronic/';
% path of the local data
% this.path.localData = 'F:/RawData/Dayra/';
this.path.localData = '/home/gc3-user/HIFONASHE-02/RawData/Dayra_Lorenzo/2014_07_chronic/';
% path where the OCIA related things should be saved (OCIA object itself, data, plots, etc.)
% this.path.OCIASave = 'E:/Analysis/Dayra/';
this.path.OCIASave = '/home/gc3-user/HIFONASHE-02/Analysis/Dayra_Lorenzo/1407_chronic/';

%% properties: DataWatcher
% defines whether a warning of data flushing upon watch folder change should be displayed or not
this.dw.ignoreDataFlushWarning = true;
% HDF5 saving compression level. If empty or 0, no compression at all, otherwise specify values 
%   between 1 (best speed) and 9 (best compression)
this.dw.HDF5GZipLevel = [];
% data "types" that are to be flushed between runs once they are saved to avoid memory overflow
this.dw.savedDataToFlushBetweenRuns = { 'raw', 'preProc', 'caTraces', 'stim' };
% specifies which data should be saved in the HDF5 file
this.dw.dataAsHDF5 = { 'raw', 'preProc', 'caTraces', 'ROISets', 'stim', 'behav' };
% specifies which data should be saved in the HDF5 file
this.dw.dataAsMat = { };
% specifies whether to overwrite the file where the data will be saved
this.dw.overwriteSaveFile = false;
% specifies whether to overwrite the data when saving it to HDF5 if it already exists
this.dw.overwriteHDF5Data = true;
% time threshold in milliseconds to check for time mismatchs
this.dw.trialMatchingTimeDifferenceThreshold = 6000;

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
this.an.img.defaultFrameRate = 77.67;
% fixed/default dimensions of the imaging data in pixels
this.an.img.defaultImDim = [200 200];
% minimum number of frames for a row to be considered as a functional movie
this.an.img.funcMovieNFramesLimit = this.dw.previewNMaxFrameToLoad  + 1;
% F0/R0 method index. Methods are mean, median, prctile, polyfit, polyfitMean
this.an.img.f0method = 3;
% F0/R0 parameter (can be empty), for percentile: Nth percentile; for polyfit: polyfit degree
this.an.img.f0params = 40;
% background substraction percentile
this.an.img.bgPrctile = 1;
% degree of the polyfit correction for bleaching. Set to 0 for no correction.
this.an.img.polyfitCorrect = 0;
% percent of the trace where the polyfit correction should be calculated
this.an.img.polyfitFraction = 0.25;

%% -- properties: Analyser: Analysis
% name of the stimuli
this.an.an.stimIDs = {'low', 'high'};
% number of frames to remove in the begining of the imaging data (shutter artifact)
this.an.an.nSkipFrame = 1;
% determines which transformation should be used for the turboReg registration, which can be one
%   of: translation/rigidBody/affine/bilinear
this.an.an.regTransf = 'rigidBody';
% determines which type of motion correction should be applied (TurboReg, HMM)
this.an.an.moCorrType = 'TurboReg';
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
% determines whether single frames that are out of focus (with previous and next frame in focus) should be excluded
this.an.an.moDetRemoveSingleFrames = false;
% determines which pre-processing options should be applied. Should be a cell array containing one or
%   more of: 'skipFrame', 'fShift', 'fJitt', 'moCorr', 'moDet'
this.an.an.preProcOptions = { 'skipFrame', 'fShift', 'fJitt', 'moCorr' };
% number of seconds for the peri-stimulus averaging (peri-stimulus period)
this.an.an.PSPer = struct('base', 2, 'evoked', 5);
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
