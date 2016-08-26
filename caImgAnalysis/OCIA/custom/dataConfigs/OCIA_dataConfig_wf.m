function this = OCIA_dataConfig_wf(this)
% OCIA_dataConfig_wf - [no description]
%
%       OCIA_dataConfig_wf(this)
%
% Adds the wide-field data structures to the OCIA.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% wide-field data type
% defines the data storage options
this.main.dataConfig = [this.main.dataConfig; cell2table({ ...
...     rowType             id           shortLabel         label                      saveFormat  defaultOn
        'WF trial',         'wfTrIm',    'WF im.',          'WF trial data',           'HDF5',     false;
        'WF average',       'wfTrAvg',   'WF im. avg.',     'WF average data',         'HDF5',     false;
        'WF trial',         'wfTrBehav', 'WF behav.',       'WF trial behavior',       'HDF5',     false;
        'WF trial',         'wfStim',    'WF stim.',        'WF stimulus vector',      'HDF5',     false;
        'WF reference',     'wfRef',     'WF reference',    'WF reference image',      'HDF5',     false;
        'WF data',          'wf',        'WF data',         'WF data',                 'HDF5',     false;
        'WF an. data',      'wfAn',      'WF an. data',     'WF analysed data',        'HDF5',     false;
}, 'VariableNames', this.main.dataConfig.Properties.VariableNames)];

% define the analysis parameters for this data type
this.an.wf = struct();

% defines the crop rectangle position's as [X Y W H]. No cropping if empty
this.an.wf.cropRect = [];

% defines the frequency (in Hertz) of stimulation for a single pitch/tone
this.an.wf.stimFreq = 0;
% defines the number of bins for the pixel time course
this.an.wf.nBins = [1, 1];
% defines the baseline correction method: "none", "mean", "slidingAvg", "bpfilter", "polynomial"
this.an.wf.BLCorrMethod = 'bpfilter';
this.an.wf.BLCorrParam = [0.15 0.25];
% defines the number of chunks to use for the pixel time course extraction (low = memory, high = speed)
this.an.wf.chunkSizeFactor = [4 4];
% defines the frame numbers for baseline calculation
this.an.wf.baseFrames = [-10 0];
% defines the frame numbers for evoked response calculation
this.an.wf.evokedFrames = [0 60];
% defines the sub-range of frame numbers for evoked response calculation
this.an.wf.subRange = [];
% defines frequency interval (in Hertz) relative to the stimulation frequency that is still used for the power &
%   phase map (stimFreq +- stimFreqInterval)';
this.an.wf.stimFreqInterval = 0;
% defines the number of bins to plot
this.an.wf.nBinsToPlot = 13;
% defines whether to show single trials
this.an.wf.showSingleTrials = false;
% defines the frame range to use
this.an.wf.frameRange = [1 -1];
% defines the rotation to use
this.an.wf.imRotationAngle = 0;

% defines the list of trials to exclude
this.an.wf.excludeTrials = {};
% defines the list of stimulus IDs
this.an.wf.stimIDs = {};


% defines the display mode for the phase maps
this.an.wf.dispMode = 'phase';
% defines which subplots to show
this.an.wf.subPlotsToShow = [1, 1, 1, 1];
% defines the frame number to display
this.an.wf.iFrame = 1;

% store some data in the analyser for interactive use
this.an.wf.storeData = [];
% store the ROI masks
this.an.wf.ROIMasks = [];

% defines the maximum size of array before switching to pixel by pixel mode
% this.an.wf.sizeLimitForPixByPixMode = 128 * 128 * 100 * 10; % 128 pixels by 128 pixels, 100Hz frameRate, 31 seconds
this.an.wf.sizeLimitForPixByPixMode = 0; % always go for pixel by pixel
    
% defines the Y limits of the pixel time course plot
this.an.wf.pixTCYLim = [-3 5];
% defines the Y limits of the pixel spectrogram plot
this.an.wf.spectrYLim = [0.00001 1000000];
% defines the color limits of the power map
this.an.wf.powerMapCLim = [0 4];
% this.an.wf.powerMapCLim = [0 20];
% defines the filtering parameters for the power map: [gaussX gaussY gaussSigma medianX medianY]. Use 0 to desactivate.
% this.an.wf.powerMapFilt = [0 0 0 0 0];
this.an.wf.powerMapFilt = [3 3 0.5 0 0];
% this.an.wf.powerMapFilt = [5 5 1 3 3];
% defines the color limits of the phase map
% this.an.wf.phaseMapCLim = [-3.14 3.14];
this.an.wf.phaseMapCLim = [0 1];
% defines the filtering parameters for the phase map: [gaussX gaussY gaussSigma medianX medianY]. Use 0 to desactivate.
% this.an.wf.phaseMapFilt = [0 0 0 0 0];
this.an.wf.phaseMapFilt = [3 3 0.5 0 0];
% this.an.wf.phaseMapFilt = [10 10 2 5 5];

% defines the threshold of the power map to mask the phase map
this.an.wf.powerMapThresh = 0.5;
% defines the phase shift for the phase maps
this.an.wf.phaseShift = 0;
% defines the phase map's delay in seconds
this.an.wf.phaseMapDelay = 0;

% defines the tolerance (in seconds) between the expected and real duration of stimulus cycle
this.an.wf.stimDurDiffTolerance = 0.001;


end
