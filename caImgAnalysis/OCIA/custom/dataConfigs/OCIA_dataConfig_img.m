function this = OCIA_dataConfig_img(this)
% OCIA_dataConfig_img - [no description]
%
%       OCIA_dataConfig_img(this)
%
% Adds the imaging data structures to the OCIA.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% imaging data type

% defines the data storage options
this.main.dataConfig = [this.main.dataConfig; cell2table({ ...
...     rowType         id              shortLabel      label                               saveFormat  defaultOn
        'Imaging data', 'rawImg',       'Raw im.',      'Raw images',                       'HDF5',     false;
        'Imaging data', 'procImg',      'Proc. im.',    'Processed images',                 'HDF5',     false;
        'Imaging data', 'caTraces',     'Ca.',          'Calcium traces',                   'HDF5',     true;
        'Imaging data', 'rawChan',      '',             'Raw traces',                       'HDF5',     true;
        'Imaging data', 'stim',         'Stim.',        'Stimulus vectors',                 'HDF5',     true;
        'Imaging data', 'exclMask',     '',             'Exclusion masks',                  'HDF5',     true;
        'ROISet',       'ROISets',      'ROISet',       'ROISets',                          'HDF5',     true;
        'Imaging data', 'behavExtr',    'Behav.',       'Behavior data (extr.)',            'HDF5',     true;
}, 'VariableNames', this.main.dataConfig.Properties.VariableNames)];

% define the analysis parameters for this data type
this.an.img = struct();

% down-sampling factor to apply to the functional data to the functional data (DRR or DFF)
this.an.img.downSampFactor = 1;
% frame size of the Savitzky-Golay filter to apply to the functional data (DRR or DFF)
this.an.img.sgFiltFrameSize = 15;
% show or hide (mask) the excluded frames
this.an.img.exclFrames = 'show';
% name of the stimuli
this.an.img.allStimIDs = { ...
    'sound', 'light', 'lick', 'lightOff'; 'high', 'low', 'HL3', 'HL4'; 'distr', 'targ', 'DT3', 'DT4'; ...
    'noResp', 'resp', 'NR3', 'NR4'; 'false', 'corr', 'FC3', 'FC4'; ...
};
% selected stimulus IDs
this.an.img.selStimIDs = { };
% selected stimulus IDs for display
this.an.img.selDispStimIDs = { };
% selected stimulus type groups
this.an.img.selStimTypeGroups = { };
% duration of the stimulus in seconds
this.an.img.stimDur = 0.5;
% number of frames to put as gap for display
this.an.img.gapSize = 10;
% plotting limits. Leave empty for auto limits.
this.an.img.plotLimits = [];
% number of seconds for the peri-stimulus averaging (peri-stimulus period): base and evoked
this.an.img.PSPer = {'all', -2, 0, 0, 2; 'on', -2, 0, 0, 0.5; 'off', -2, 0, 0.5, 1; 'late', -2, 0, 1, 2};
% ID of the peri-stimulus period to use
this.an.img.PSPerID = 'all';
% colormap to use for heatmap plots
this.an.img.colormap = 'gray_reverse';
% defines whether ROIs should be averaged together in some plots
this.an.img.averageROI = false;
% defines whether to combine ROIs for their presence in different days/ROISets
this.an.img.combineROIs = true;
% defines whether to normalise trials by the mean activity of their baseline
this.an.img.normBaseline = true;
% defines whether to show single trials or not
this.an.img.showTrials = true;
% defines the minimum number of stimulus to have for a stimulus type in order to be included in the average
this.an.img.nStimsThreshold = 3;
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
this.an.img.NVsNP1ShowFit = false;
% number of repeats for ROC analysis
this.an.img.ROCNReps = 500;

% starting time in seconds after which to look for stims for construction of stim. vector
this.an.img.stimVectMinStartTime = 2;
% minimum peak height (in number of STD above mean) for construction of stim. vector
this.an.img.stimVectPeakSTDThresh = 2;
% minimum inter-peak distance in seconds for construction of stim. vector
this.an.img.stimVectInterPeakDistThresh = 1;
% fraction of the peak that we must go below to find the onset of the peak
this.an.img.stimVectPeakStartThreshold = 0.3;
% array of the ROIs for which a debuging plot should be plotted
this.an.img.stimVectDbgPlotROIs = [];

% stim vector derived from the ROI event detection
this.an.img.ROIStimVects = [];

% storage for the cached data
this.an.img.dataHash = struct();

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
this.an.img.f0params = 35;
% expfit correction for bleaching/initial decay. Set to 0 for no correction.
this.an.img.expfitCorrect = 0;
% expfit - window size for sliding minimum search for expfit (in sec)
this.an.img.expfitWindow = 4;
% background substraction percentile
this.an.img.bgPrctile = 1;
% degree of the polyfit correction for bleaching. Set to 0 for no correction.
this.an.img.polyfitCorrect = 0;
% percent of the trace where the polyfit correction should be calculated
this.an.img.polyfitFraction = 0.0;

end
