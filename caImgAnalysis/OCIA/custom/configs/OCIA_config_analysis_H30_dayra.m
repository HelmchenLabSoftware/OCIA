function this = OCIA_config_analysis_H30_dayra(this)
% OCIA_config_analysis_H30_dayra - "analysis_H30_dayra" OCIA configuration file
%
%       this = OCIA('analysis_H30_dayra')
%
% Configuration file for OCIA using the "analysis_H30_dayra" configuration. This function should not be called directly
%   but rather using the "this = OCIA('analysis_H30_dayra');" syntax to launch the software with this configuration.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the default configuration
configHandle = str2func('OCIA_config_default');
this = configHandle(this);

% general parameters
this.main.startFunctionName = 'dataWatcher';
% this.main.startFunctionName = 'loadDataAndOpenAnalyser';
this.GUI.noGUI = false;
this.GUI.dw.DWFilt = { 'mou_dl_141227_03', '2015_01_17', 'spot02' };
% this.GUI.dw.DWWatchTypes = { 'animal', 'day', 'spot' };
this.GUI.dw.DWWatchTypes = 'all';
this.GUI.dw.DWSkiptMeta = false;
this.GUI.dw.DWRawOrLocal = 'local';

%% - properties: GUI
% initial position of the main window
this.GUI.pos = [-1277, 83, 1275, 1000]; 

%% - properties: general
% verbosity, number telling how much debugging output should be printed out. The higher the more verbose.
this.verb = 2;

%% -- properties: general: paths to relevant locations (raw data, ect.)
% path of the raw data (usually stored on the server)
this.path.rawData = 'Z:/RawData/Dayra_Lorenzo/2014_12_chronic/';
% path of the local data
% this.path.localData = 'F:/RawData/Dayra/';
this.path.localData = 'C:/Users/lorenzo/Documents/LabVIEW Data/2014_12_chronic/';
% path where the OCIA related things should be saved (OCIA object itself, data, plots, etc.)
% this.path.OCIASave = 'E:/Analysis/Dayra/';
this.path.OCIASave = 'C:/Users/lorenzo/Documents/LabVIEW Data/OCIA/';

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


% determines the minimum difference of the 5th percentile of the frame-wise correlation of each aligned frame to the reference
% frame for the motion correction to pass the quality control
this.an.moCorr.meanFrameCorrDiffThresh = -0.05;
% determines the minimum difference of correlation of the average of the aligned frames to the reference
% frame for the motion correction to pass the quality control
this.an.moCorr.frameCorrToRefDiffThresh = -0.1;
% determines the minimum correlation (absolute number) of the average of the aligned frames to the reference
% frame for the motion correction to pass the quality control
this.an.moCorr.frameCorrToRefAbsThresh = 0.75;


%% -- properties: Analyser: Imaging% down-sampling factor to apply to the functional data to the functional data (DRR or DFF)
this.an.img.downSampFactor = 1;
% frame size of the Savitzky-Golay filter to apply to the functional data (DRR or DFF)
this.an.img.sgFiltFrameSize = 1;
% show or hide (mask) the excluded frames
this.an.img.exclFrames = 'show';
% name of the stimuli
this.an.img.allStimIDs = { ...
    'stim', 'noStim', '', '', '', '', '', '', '', '';
    '1', '2', '3', '4', '5', '6', '7', '8', '9', '10';
    'low', 'high', '', '', '', '', '', '', '', '';
    'first', 'preOdd', 'odd', '', '', '', '', '', '', '';
};
% duration of the stimulus in seconds
this.an.img.stimDur = 0.5;
% plotting limits. Leave empty for auto limits.
this.an.img.plotLimits = [];
% number of seconds for the peri-stimulus averaging (peri-stimulus period): base and evoked
% this.an.img.PSPer = [1.5, 3];
this.an.img.PSPer = [1, 1.5];
% colormap to use for heatmap plots
this.an.img.colormap = 'gray';
% defines whether ROIs should be averaged together in some plots
this.an.img.averageROI = true;
% defines whether to combine ROIs for their presence in different days/ROISets
this.an.img.combineROIs = true;
% defines whether to normalise trials by the mean activity of their baseline
this.an.img.normBaseline = true;
% defines whether to show single trials or not
this.an.img.showTrials = true;
% defines whether to group curves in a single plot or not
this.an.img.groupCurves = true;
% defines the minimum number of stimulus to have for a stimulus type in order to be included in the average
this.an.img.nStimsThreshold = 3;
% sorting method
this.an.img.sortMethod = 'none';
% sorting direction
this.an.img.sortDirection = 'ascending';
% sorting stimulus 
this.an.img.sortStim = 'low';
% responsiveness calculating method
this.an.img.respMethod = '3ppmax';
% ROI property to plot
this.an.img.ROIStat = 'respStim1';
% grouping options for the data analysis
this.an.img.groupBy = 'stimType';
% which type of traces should be shown
this.an.img.traceTypeToShow = { 'filtered only' };
% selected stimulus type names
this.an.img.selStimTypeGroups = {};
% selected ROI names
this.an.img.selROINames = {};

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
this.an.img.funcMovieNFramesLimit = this.dw.previewNMaxFrameToLoad + 1;
% F0/R0 method index. Methods are mean, median, prctile, polyfit, polyfitMean
this.an.img.f0method = 3;
% F0/R0 parameter (can be empty), for percentile: Nth percentile; for polyfit: polyfit degree
this.an.img.f0params = 40;
% background substraction percentile
this.an.img.bgPrctile = 1;
% degree of the polyfit correction for bleaching. Set to 0 for no correction.
this.an.img.polyfitCorrect = 0;
% percent of the trace where the polyfit correction should be calculated
this.an.img.polyfitFraction = 0.0;


end
