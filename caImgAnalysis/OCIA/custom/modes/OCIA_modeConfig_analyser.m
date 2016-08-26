function this = OCIA_modeConfig_analyser(this)
% adds the analyser mode to the OCIA

%% - properties: Analyser
this.an = struct();
% defines whether to set 0-value pixels to NaN when loading images
this.an.loadImageSetValueToNaNWhenZero = true;
% stores the list of selected rows from the DataWatcher
this.an.selectedTableRows = [];
% plot save resolution for PNG save format
this.an.plotSaveResolution = '-r150';

%% -- properties: Analyser : analysis types
% different analysis types available
this.an.analysisTypes = cell2table({ ...
... id                          label                                                       description
    'caTraces_basic',           'Calcium traces (basic)',                                   'Basic plot of the calcium traces';
    'caTraces_heatMap',         'Calcium traces as heat map',                               'Heat map plot of the calcium traces';
%     'caTraces_crossCorr',       'Cross correlation',                                        'Cross-correlation analysis';
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
    'behav_licks',              'Behavior variables histograms',                            'Licking profile';
}, 'VariableNames', { 'id', 'label', 'description' });
this.an.analysisTypes.Properties.RowNames = this.an.analysisTypes.id; % make the ID be the row names

%% -- properties: GUI: Analyser
% table describing how the parameter panel should be created
this.GUI.an.paramPanConfig = table({}, {}, {}, {}, [], [], {}, {}, 'VariableNames', ...
    { 'categ', 'id', 'UIType', 'valueType', 'UISize', 'isLabelAbove', 'label', 'tooltip' });
% specifies which columns of the DataWatcher's table should be used for the row list display
this.GUI.an.DWTableColumnsToUse = { 'rowNum', 'animal', 'spot', 'rowType', 'runType', 'runNum', 'rowID' };
% specifies a regular expression to shorten the row display, using a cell array with two columns, one for
%   the match pattern and the second for the replace patterns
this.GUI.an.DWTableColumnsRegexp = { ...
    'mou_[bd]l_(\d+)_(\d+)',    'A$2';
    'spot(\d+)',                'S$1';
    '(A\d+) - (S\d+)',          '$1 $2';
    'Trial - (\d+)',            'Trial$1';
    'Imaging data',             'imgData';
    'Behavior data',            'behavData';
};
% specifies which page of the parameter pannels is currently shown
this.GUI.an.paramPage = 1;

%% -- properties: Analyser: Analysis
this.an.an = struct();
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
this.an.fShift.corrThreshFactor = 0.6;
% minimum and maximum to use as threshold for detecting a frame shift
this.an.fShift.maxCorrThresh = 0.8;
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
% this.an.moCorr.frameCorrToRefAbsThresh = 0.85;
this.an.moCorr.frameCorrToRefAbsThresh = 0.70;
% determines whether to use the non-aligned imaging data if the quality control failed
this.an.moCorr.useNonCorrectedIfQualityControlFailed = false;
%% -- properties: Analyser: Processing options: motion detection (Z motion)
% determines whether a filter should be applied on the images before motion detection
this.an.moDet.useFilt = true;
% determines at which threshold is a frame consider out of focus
this.an.moDet.threshFactor = 1.6;
% determines whether single frames that are out of focus (with previous and next frame in focus) should be excluded
this.an.moDet.removeSingleFrames = false;


% number of rows to process before the parallel pool should be restart (no-GUI mode only)
this.an.an.nRowBeforeParallelPoolRestart = 100;

end
