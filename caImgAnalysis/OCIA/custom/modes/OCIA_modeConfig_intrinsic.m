function this = OCIA_modeConfig_intrinsic(this)
% adds the intrinsic/widefield mode to the OCIA

% add the wide-field data mode
this.main.dataModes{end + 1} = 'wf';
this.main.dataModes = unique(this.main.dataModes, 'stable');

%% -- properties: path: Intrinsic
if ispc();
    docPath = winqueryreg('HKEY_CURRENT_USER', 'Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders', 'Personal');
else
    docPath = char(java.lang.System.getProperty('user.home'));
end;
% path where the intrinsic data should be saved
this.path.intrSave = sprintf('%s/%s/intr/', docPath, datestr(date, 'yyyy_mm_dd'));

%% -- properties: GUI: Intrinsic
this.GUI.intr = struct();

% defines whether the axes should be drawn in a 1-1 aspect ratio
this.GUI.in.axisEqual = true;

% defines whether to show the saturation on the preview
this.GUI.in.prevSaturationBounds = [1, 2 ^ 8 - 1];
% defines the number of frames to use for the reference image
this.GUI.in.nFramesRef = 50;
% defines the fraction of preview images that should be displayed
this.GUI.in.prevImgFrac = 0.75;
% counter for the update of preview image
this.GUI.in.iPrevImg = 1;
% default image dimension
this.GUI.in.imDim = [100 100];
% shrinking factor for the outline
this.GUI.in.shrinkFactor = 0.9;
% color of the outline
this.GUI.in.refROIOutlineColor = [1 0 0];
% starting preset's index
this.GUI.in.startPresetConfig = 1;

% axe handle holder for sub-axes in analysis pannel
this.GUI.in.fouSubAxeHands = struct();

% image filter for DFF averages
this.GUI.in.filt = fspecial('gauss', [10, 10], 1.5);

% handles of the Region Of Interest
this.GUI.in.ROIHandle = {};

%% parameter pannel
% table describing how the parameter panel should be created
this.GUI.in.paramPanConfig = cell2table({ ...
    
... categ       id                      UIType  valueType       UISize  isLabAbove  label               tooltip
    'common',   'stimMode',             'dropdown', { 'soundCard', 'TDT', 'trigOut', 'trigIn', 'trigInTTLOut' }, [1 0], false, 'Stimulus mode', 'Stimulus mode for handling stimuli: soundCard, TDT, trigOut, trigIn.';
    'common',   'animalID',             'text', { 'text' },     [1 0],  true,       'Animal ID',        'Current animal''s ID.';
    'common',   'anesthesiaState',      'dropdown', { 'unknown', 'light', 'deep', 'awake' }, [1 0], false, 'Anesthesia', 'Anesthesia state.';
    'common',   'h5saveDeflate',        'text', { 'numeric' },  [1 0],  false,      'HDF5 deflate',     'Compression level of the saving: 0 = no compression (fast), 9 = maximum compression (slow).';
    'common',   'expNumber',            'text', { 'numeric' },  [1 0],  false,      'Exp. num.',        'Experiment number.';
    'common',   'ROIPosition',          'text', { 'array' },    [1 0],  false,      'ROI pos.',         'ROI position of the camera (subpixel region).';
    'common',   'frameRate',            'text', { 'numeric' },  [1 0],  false,      'Frame rate',       'Frame rate of the camera (Hz).';
    'common',   'soundType',            'dropdown', { 'pure tone', 'COT' }, [1 0], false, 'Sound type', 'Which sound type should be used as stimulation, pure tones or Cloud Of Tones.';
    'common',   'startDelay',           'text', { 'numeric' },  [1 0],  false,      'Start delay',      'Duration (in seconds) of the waiting period at the begining of the experiment (only once).';
    'common',   'amplifFactor',         'text', { 'numeric' },  [1 0],  false,      'Amplif.',          'Amplification factor that should be used before playing the sound.';
    'common',   'spatialDSFactor',      'text', { 'numeric' },  [1 0],  false,      'Spatial DS fact.', 'Spatial down-sampling factor.';
    'common',   'nSweeps',              'text', { 'numeric' },  [1 0],  false,      'Num. sweeps',      'Number of runs/sweeps/cycles.';
     
   
... categ       id                      UIType  valueType       UISize  isLabAbove  label               tooltip
    'standard', 'cLim',                 'text', { 'array' },    [1 0],  false,      'Col. lim.',        'Color limits for the DFF images.';
    'standard', 'baselineAvgDur',       'text', { 'numeric' },  [1 0],  false,      'Baseline avg.',    'Duration (in seconds) of the averaging for the baseline condition.';
    'standard', 'baseline1ToBaseline2Delay', 'text', { 'numeric' }, [1 0], false,   'Inter-b. delay',   'Duration (in seconds) of the waiting period between the two baseline averagings.';
    'standard', 'baselineToStimDelay',  'text', { 'numeric' },  [1 0],  false,      'Baseline delay',   'Duration (in seconds) of the waiting period between the baseline averaging and the stimulus.';
    'standard', 'stdStimDur',           'text', { 'numeric' },  [1 0],  false,      'Stim. dur.',       'Duration (in seconds) of the stimulus.';
    'standard', 'stimToStimAvgDelay',   'text', { 'numeric' },  [1 0],  false,      'Stim. delay',      'Duration (in seconds) of the waiting period between the stimulus'' end and the stimulus'' averaging.';
    'standard', 'stimAvgDur',           'text', { 'numeric' },  [1 0],  false,      'Stim. avg.',       'Duration (in seconds) of the averaging for the stimulus condition.';
    'standard', 'waitPeriod',           'text', { 'numeric' },  [1 0],  false,      'Wait period',      'Duration (in seconds) of the waiting period at the end of each run (recovery period).';
    'standard', 'stdBaseFreq',          'text', { 'numeric' },  [1 0],  false,      'Base freq.',       'Pure tone''s frequency or parameter for the cloud-of-tones frequencies based on the formula: baseFreq * (2 .^ ((0 : nFreqs) * (2 ^ powOf2))).';
    'standard', 'stdToneDur',           'text', { 'numeric' },  [1 0],  false,      'Tone dur.',        'Duration (in seconds) of single pure tone or a single tone within a cloud.';
    'standard', 'stdToneISI',           'text', { 'numeric' },  [1 0],  false,      'Tone ISI',         'Duration (in seconds) between pure tones or the duration of overlap between tones within a cloud.';
    'standard', 'stdNFreqs',            'text', { 'numeric' },  [1 0],  false,      'COT nFreqs',       'Parameter for the cloud-of-tones frequencies based on the formula: baseFreq * (2 .^ ((0 : nFreqs) * (2 ^ powOf2))).';
    'standard', 'stdPowOf2',            'text', { 'numeric' },  [1 0],  false,      'COT powOf2',       'Parameter for the cloud-of-tones frequencies based on the formula: baseFreq * (2 .^ ((0 : nFreqs) * (2 ^ powOf2))).';
    'standard', 'stdCloudDispersion',   'text', { 'numeric' },  [1 0],  false,      'COT dispersion',   'Dispersion (broadness) of the clouds in number of adjacent frequencies on each side (2 => 5 freqs).';
    'standard', 'stdCloudCenter',       'text', { 'numeric' },  [1 0],  false,      'COT center',       'Index of center frequency of the cloud of tones.';
     
... categ       id                      UIType  valueType       UISize  isLabAbove  label               tooltip
    'fourier',  'sweepDir',             'dropdown', { 'up', 'down' }, [1 0], false, 'Direction',        'Which direction should the ramp go, upwards or downwards.';
    'fourier',  'fouBaseFreq',          'text', { 'array' },    [1 0],  false,      'BaseFreq',         'Parameter for the "ramp" frequencies and/or the cloud-of-tones frequencies based on the formula: baseFreq * (2 .^ ((0 : nFreqs) * (2 ^ powOf2))).';
    'fourier',  'fouNFreqs',            'text', { 'numeric' },  [1 0],  false,      'NFreqs',           'Parameter for the "ramp" frequencies and/or cloud-of-tones frequencies based on the formula: baseFreq * (2 .^ ((0 : nFreqs) * (2 ^ powOf2))).';
    'fourier',  'fouPowOf2',            'text', { 'numeric' },  [1 0],  false,      'PowOf2',           'Parameter for the "ramp" frequencies and/or cloud-of-tones frequencies based on the formula: baseFreq * (2 .^ ((0 : nFreqs) * (2 ^ powOf2))).';
    'fourier',  'sweepDur',             'text', { 'numeric' },  [1 0],  false,      'Sweep dur.',       'Duration (in seconds) of a single stimulus sweep.';
    'fourier',  'fouStimDur',           'text', { 'numeric' },  [1 0],  false,      'Stim. dur.',       'Duration (in seconds) of single tone/cloud within a sweep.';
    'fourier',  'nTones',               'text', { 'numeric' },  [1 0],  false,      'N. tones',         '';
    'fourier',  'fouToneITI',           'text', { 'numeric' },  [1 0],  false,      'Tone ITI',         'Inter-tone interval (in seconds).';... categ       id                      UIType  valueType       UISize  isLabAbove  label               tooltip
    
... categ       id                      UIType  valueType       UISize  isLabAbove  label               tooltip
    'trial',    'stimIDs',              'text', { 'cellArray' }, [1 0], false,      'Stim. IDs',        'List of stimulus IDs used by the stimulus vector.';
    'trial',    'stimVect',             'text', { 'array' },    [1 0],  false,      'Stim. vect.',      'List of stimuli to present.';
    'trial',    'trialDur',             'text', { 'numeric' },  [1 0],  false,      'Trial dur.',       'Total duration (in seconds) of a single trial.';
    'trial',    'BLDur',                'text', { 'numeric' },  [1 0],  false,      'Baseline dur.',    'Baseline period duration (in seconds) for a trial.';
    'trial',    'EVDur',                'text', { 'numeric' },  [1 0],  false,      'Evoked dur.',      'Evoked period duration (in seconds) for a trial.';
    'trial',    'triStimDur',           'text', { 'numeric' },  [1 0],  false,      'Stim. dur.',       'Duration (in seconds) of the stimulus.';
 
}, 'VariableNames', { 'categ', 'id', 'UIType', 'valueType', 'UISize', 'isLabelAbove', 'label', 'tooltip' });
% append the new configuration to the table and update the row names using the ids
this.GUI.in.paramPanConfig.Properties.RowNames = this.GUI.in.paramPanConfig.id;
% specifies which page of the parameter pannels is currently shown
this.GUI.in.paramPage = 1;

%% - properties: Intrinsic
this.in = struct();

% defines the connection state with the camera
this.in.connected = false;
% defines whether we are in preview mode or not
this.in.previewRunning = false;
% defines whether we are in an experiment or not
this.in.expRunning = false;
% defines the experiment's starting time
this.in.expStartTime = 0;

% defines the DAQ vendor name
this.in.daq.vendorName = 'ni';
% defines the DAQ device ID
this.in.daq.deviceID = 'Dev2';
% defines the trigger out port
this.in.daq.trigOutPort = 'Port0/Line0';
% defines the trigger in's port
this.in.daq.trigInPort = 'Port0/Line0';
% handle for the DAQ sessions
this.in.daq.sessHandle = [];

% handle to the camera's viedeoinput object
this.in.camH = [];
% string defining the camera's adaptor name
this.in.adaptorName = 'ni';
% number defining the camera's device ID
this.in.deviceID = 1;
% cell-array of strings defining the available camera formats
this.in.availableCamFormats = {};

% handle to ActiveX control of the TuckerDavis
this.in.RP = [];
% handle for the audioplayer (sound card)
this.in.audioplayer = [];

% stores the reference image
this.in.data.refImg = [];
% stores the first baseline's frames
this.in.data.base1Frames = {};
% stores the second baseline' frames
this.in.data.base2Frames = {};
% stores the stimulus frames
this.in.data.stimFrames = {};
% stores the baseline DFF average images ((BL2 - BL1) / BL1)
this.in.data.baseDFFAvg = {};
% stores the stimulus DFF average images ((stim - BL1) / BL1)
this.in.data.stimDFFAvg = {};
% stores the include property of each run
this.in.data.includeInAvg = [];

% experiment mode: 'standard' (stimulus-average-wait cycles) vs 'fourier' (continuous stimulus steps with fourier
%   transform and power at stimulus frequency) vs 'trial', (trial-based recording with single stimulus per trial)
this.in.expModes = { 'standard', 'fourier', 'trial' };
this.in.expMode = this.in.expModes{1};
% timestamp of the current experiment
this.in.timestamp = 'xxxxxx_xxxxxx';
% save name for files and datasets in standard mode
this.in.standard_saveName = [ '[this.in.timestamp]_exp[this.in.common.expNumber]_soundFreq[this.in.standard.stdBaseFreq  / 1000]kHz_', ...
    '[this.in.standard.nRuns]Runs' ];
% save name for files and datasets in fourier mode
this.in.fourier_saveName = [ '[this.in.timestamp]_exp[this.in.common.expNumber]_', ...
    'stim[1 / this.in.fourier.sweepDur]Hz_[round(this.in.fourier.sweepDur * this.in.fourier.nSweeps)]sec_', ...
    '[round(this.in.fourier.fouBaseFreq / 1000)]to', ...
    '[round(this.in.fourier.fouBaseFreq / 1000 * (2 .^ ((this.in.fourier.fouNFreqs - 1) * ', ...
    '(2 ^ this.in.fourier.fouPowOf2))))]kHz_[this.in.fourier.sweepDir]Sweep_', ...
    'amplif[this.in.common.amplifFactor]_[this.in.common.frameRate]HzFrameRate' ];
% save name for files and datasets in trial mode
this.in.trial_saveName = [ '[this.in.timestamp]_exp[this.in.common.expNumber]_', ...
    'amplif[this.in.common.amplifFactor]_[this.in.common.frameRate]HzFrameRate' ];


%% - properties: Intrinsic: common properties

% defines the current animal's ID
this.in.common.animalID = 'mou_bl_160105_XX';
% defines the anesthesia state
this.in.common.anesthesiaState = 'unknown';
% defines the compression level of the saving: 0 = no compression (fast), 9 = maximum compression (slow)
this.in.common.h5saveDeflate = 1;
% experiment number
this.in.common.expNumber = 0;
% ROI position of the camera
% this.in.common.ROIPosition = [130, 150, 256, 256];
this.in.common.ROIPosition = [0, 0, 512, 512];
% frame rate of the camera in hertz
this.in.common.frameRate = 30;
% sampling frequencies (TDT and standard sound speakers)
this.in.common.TDTSampFreq = 195312.5; % 200kHz
this.in.common.standardSampFreq = 44100;
% ramp fraction for pure tones
this.in.common.rampFrac = 0.05;
    
% defines the stimulus mode for handling stimuli: soundCard, TDT, trigOut, or trigIn
this.in.common.stimMode = 'trigOut';
% defines which sound type should be used as stimulation: 'pure tone' or 'COT' (Cloud Of Tones)
this.in.common.soundType = 'pure tone';
% defines what amplification factor should be used before playing the sound
this.in.common.amplifFactor = 2;
% defines by how much the image should be spatially down-sampled
this.in.common.spatialDSFactor = 1;
% % defines by how much the image should be termporally down-sampled (1 = no down-sampling)
% this.in.common.tempDSFactor = 1;
% string defining the camera's format
this.in.common.camFormat = '';

% defines the duration (in seconds) of the waiting period at the begining of the experiment (only once)
this.in.common.startDelay = 2;
% defines the number of sweeps
this.in.common.nSweeps = 10;

%% - properties: Intrinsic: fourier mode
% defines the properties for the fourier intrinsic imaging (continuous stimulus steps with fourier transform and power
%   at stimulus frequency)
% the sequence of the experiment is the following:
% startDelay - [stim1 delay stim2 delay ... stimN delay] x nRuns

% defines the direction of the ramp
this.in.fourier.sweepDir = 'up';

% defines the list of frequencies for the stimulation based on the following formula:
%   baseFreq * (2 .^ ((0 : nFreqs) * (2 ^ powOf2)))
this.in.fourier.fouBaseFreq = 4000;
this.in.fourier.fouNFreqs = 33;
this.in.fourier.fouPowOf2 = -4;
% defines the duration (in seconds) of a single stimulus sweep
this.in.fourier.sweepDur = 30;
% defines the duration (in seconds) of single tone/cloud within a sweep
this.in.fourier.fouStimDur = 0.2;
% defines the number of tones for a given sound frequency
this.in.fourier.nTones = 3;
% defines the inter-tone interval (in seconds).
this.in.fourier.fouToneITI = 0.1;

%% - properties: Intrinsic: standard mode
% defines the properties for the standard intrinsic imaging (stimulus-average-wait cycles)
% the sequence of the experiment is the following:
% startDelay - [baseline1Avg -> baseline1ToBaseline2Delay -> baseline2Avg -> baselineToStimDelay -> stimulus
%   -> stimToStimAvgDelay -> stimAvg -> waitPeriod] x nRuns

% defines the color limits for the DFF images
this.in.standard.cLim = [0.05, 0.15];
% defines the duration (in seconds) of the averaging for the baseline condition (used both for baseline 1 and 2)
this.in.standard.baselineAvgDur = 4;
% defines the duration (in seconds) of the waiting period between the two baseline averagings
this.in.standard.baseline1ToBaseline2Delay = 2;
% defines the duration (in seconds) of the waiting period between the baseline averaging and the stimulus
this.in.standard.baselineToStimDelay = 2;
% defines the duration (in seconds) of the stimulus
this.in.standard.stdStimDur = 4;
% defines the duration (in seconds) of the waiting period between the stimulus' end and the stimulus' averaging
this.in.standard.stimToStimAvgDelay = 2;
% defines the duration (in seconds) of the averaging for the stimulus condition
this.in.standard.stimAvgDur = 4;
% defines the duration (in seconds) of the waiting period at the end of each run (recovery period)
this.in.standard.waitPeriod = 15;

% 'baseFreq' defines the frequency of the pure tone sound type or in the cloud of tones sound type, it
% defines the list of frequencies for the cloud-of-tones stimulation based on the following formula:
%   baseFreq * (2 .^ ((0 : nFreqs) * (2 ^ powOf2)))
this.in.standard.stdBaseFreq = 4000;
this.in.standard.stdNFreqs = 0;
this.in.standard.stdPowOf2 = 0;
% defines the duration (in seconds) of a single pure tone or a single tone within a cloud
this.in.standard.stdToneDur = 0.05;
% defines the duration (in seconds) between pure tones or the duration of overlap between tones within a cloud
this.in.standard.stdToneISI = 0.1;
% defines the dispersion (broadness) of the clouds in number of adjacent frequencies on each side (2 => 5 freqs)
this.in.standard.stdCloudDispersion = 0;
% defines the center frequency of the cloud of tones
this.in.standard.stdCloudCenter = 0;

%% - properties: Intrinsic: trial mode
% defines the properties for the trial-based imaging

% defines the list of stimulus IDs used by the stimulus vector
this.in.trial.stimIDs = {};
% defines the list of stimulus to present
this.in.trial.stimVect = [];
% defines the total duration (in seconds) of a single trial
this.in.trial.trialDur = 0;
% defines the duration (in seconds) of the baseline period in a trial
this.in.trial.BLDur = 0;
% defines the duration (in seconds) of the evoked period in a trial
this.in.trial.EVDur = 0;
% defines the duration (in seconds) of the stimulus
this.in.trial.triStimDur = 0;

%% - properties: Intrinsic: analyser
% define the analysis parameters for this data type
this.an.in = struct();

%% - properties: Intrinsic: pre-set config
% stores all the pre-set configurations
this.in.configs = struct();
cfg = struct();

%% -- properties: Intrinsic: pre-set config: trial-based pure tone multi-freq mapping
cfg.expMode = 'trial';
cfg.common.soundType = 'pure tone';
cfg.common.startDelay = 2;
cfg.common.nSweeps = 20;
cfg.common.frameRate = 100;
cfg.trial.stimIDs = num2cell(1000 * [2, 4, 6, 8, 11, 16, 23, 32]);
cfg.trial.stimVect = [1, 3, 6, 8, 7, 5, 2, 3, 7, 4, 6, 1, 8, 4, 5, 2];
cfg.trial.trialDur = 4;
cfg.trial.BLDur = 0.3;
cfg.trial.EVDur = 0.7;
cfg.trial.triStimDur = 0.1;
cfg.trial_saveName = [ '[this.in.timestamp]_exp[this.in.common.expNumber]_', ...
    '[this.in.common.nSweeps * round(numel(this.in.trial.stimVect) / numel(this.in.trial.stimIDs))]trialsPerStim_', ...
    '[numel(this.in.trial.stimIDs)]stims_multiFreqMapping_', ...
    'amplif[this.in.common.amplifFactor]_[this.in.common.frameRate]HzFrameRate' ];
this.in.configs.x01_trial_8freqs_pure_tone_multi_freq_mapping = cfg;

%% -- properties: Intrinsic: pre-set config: trial-based pure tone multi-freq mapping
cfg.common.nSweeps = 40;
cfg.trial.stimIDs = num2cell(1000 * [4, 8, 16, 28]);
cfg.trial.stimVect = [1, 3, 2, 4, 3, 1, 4, 2];
this.in.configs.x02_trial_4freqs_pure_tone_multi_freq_mapping = cfg;

%% -- properties: Intrinsic: pre-set config: trial-based multi-modality mapping
cfg.common.nSweeps = 20;
cfg.common.frameRate = 100;
cfg.trial.stimIDs =  { 'auditory', 'visual', 'somatosensory', 'blank' };
cfg.trial.stimVect = [1, 3, 4, 2, 3, 4, 1, 2];
cfg.trial.trialDur = 4;
cfg.trial.BLDur = 0.3;
cfg.trial.EVDur = 0.7;
cfg.trial.triStimDur = 0.5;
cfg.trial_saveName = regexprep(cfg.trial_saveName, '_multiFreqMapping_', '_multiModalityMapping_');
this.in.configs.x03_trial_multi_modality_mapping = cfg;

%{
%% -- properties: Intrinsic: pre-set config: fourier multi modality mapping
cfg.fourier.nSweeps = 10;
cfg.fourier.fouBaseFreq = [1,3,2,3,2,1,3,2,1,3,1,2,3,2,1,2,1,3,1,3,1,2,3,2,1,3,2,1,2,3];
cfg.fourier.fouNFreqs = 1;
cfg.fourier.stimIDs = { 'auditory', 'visual', 'somatosensory' };
cfg.fourier.fouPowOf2 = 0;
cfg.fourier.sweepDur = 90;
cfg.fourier.fouStimDur = 1;
cfg.fourier.nTones = 0;
cfg.fourier.fouToneITI = 2;
cfg.fourier_saveName = [ '[this.in.timestamp]_exp[this.in.common.expNumber]_', ...
    '[round(this.in.fourier.sweepDur * this.in.fourier.nSweeps)]sec_', ...
    'multiModalityMapping_[this.in.common.frameRate]HzFrameRate' ];
this.in.configs.x08_fourier_multi_modality_mapping = cfg;


%% -- properties: Intrinsic: pre-set config: fourier pure tone 4kHz -> 64kHz, 1Hz, 60sec
cfg.expMode = 'fourier';
cfg.common.soundType = 'pure tone';
cfg.common.startDelay = 2;
cfg.fourier.nSweeps = 60;
cfg.fourier.sweepDir = 'up';
cfg.fourier.fouBaseFreq = 4000;
cfg.fourier.fouNFreqs = 33;
cfg.fourier.fouPowOf2 = -3;
cfg.fourier.stimDurDiffTolerance = 0.001;
cfg.fourier.sweepDur = 1;
cfg.fourier.fouStimDur = 0.03;
cfg.fourier.nTones = 1;
cfg.fourier.fouToneITI = 0;
cfg.fourier_saveName = [ '[this.in.timestamp]_exp[this.in.common.expNumber]_', ...
    'stim[1 / this.in.fourier.sweepDur]Hz_[round(this.in.fourier.sweepDur * this.in.fourier.nSweeps)]sec_', ...
    '[round(this.in.fourier.fouBaseFreq / 1000)]to', ...
    '[round(this.in.fourier.fouBaseFreq / 1000 * (2 .^ ((this.in.fourier.fouNFreqs - 1) * ', ...
    '(2 ^ this.in.fourier.fouPowOf2))))]kHz_[this.in.fourier.sweepDir]Sweep_', ...
    'amplif[this.in.common.amplifFactor]_[this.in.common.frameRate]HzFrameRate' ];
% store in configuration structure
this.in.configs.x01_fourier_pure_tone_4_to_64_kHz_1Hz_60sec = cfg;

%% -- properties: Intrinsic: pre-set config: fourier pure tone 4kHz -> 64kHz, 0.9Hz, 66sec
cfg.fourier.nSweeps = 60;
cfg.fourier.sweepDur = 1.1111111;
this.in.configs.x02_fourier_pure_tone_4_to_64_kHz_0p9Hz_66sec = cfg;

%% -- properties: Intrinsic: pre-set config: fourier pure tone 4kHz -> 64kHz, 0.8Hz, 75sec
cfg.fourier.nSweeps = 60;
cfg.fourier.sweepDur = 1.25;
this.in.configs.x03_fourier_pure_tone_4_to_64_kHz_0p8Hz_75sec = cfg;

%% -- properties: Intrinsic: pre-set config: fourier pure tone 4kHz -> 64kHz, 1.1Hz, 54sec
cfg.fourier.nSweeps = 60;
cfg.fourier.sweepDur = 0.909090;
cfg.fourier.fouStimDur = 0.025;
this.in.configs.x04_fourier_pure_tone_4_to_64_kHz_1p1Hz_54sec = cfg;

%{
%% -- properties: Intrinsic: pre-set config: fourier pure tone 4kHz -> 64kHz, 2Hz, 30sec
cfg.fourier.nSweeps = 60;
cfg.fourier.fouPowOf2 = -3;
cfg.fourier.sweepDur = 0.5;
cfg.fourier.fouStimDur = 0.015;
this.in.configs.x02_fourier_pure_tone_4_to_64_kHz_2Hz_30sec = cfg;

%% -- properties: Intrinsic: pre-set config: fourier pure tone 4kHz -> 64kHz, 0.5Hz, 30sec
cfg.fourier.nSweeps = 15;
cfg.fourier.fouPowOf2 = -3;
cfg.fourier.sweepDur = 2;
cfg.fourier.fouStimDur = 0.06;
this.in.configs.x03_fourier_pure_tone_4_to_64_kHz_0p5Hz_30sec = cfg;

%% -- properties: Intrinsic: pre-set config: fourier pure tone 4kHz -> 64kHz, 0.25Hz, 60sec
cfg.fourier.fouNFreqs = 65;
cfg.fourier.nSweeps = 15;
cfg.fourier.fouPowOf2 = -4;
cfg.fourier.sweepDur = 4;
cfg.fourier.fouStimDur = 0.06;
this.in.configs.x04_fourier_pure_tone_4_to_64_kHz_0p25Hz_60sec = cfg;

%% -- properties: Intrinsic: pre-set config: fourier pure tone 4kHz -> 64kHz, 0.1Hz, 120sec
cfg.fourier.nSweeps = 12;
cfg.fourier.fouPowOf2 = -4;
cfg.fourier.sweepDur = 10;
cfg.fourier.fouStimDur = 0.1;
this.in.configs.x05_fourier_pure_tone_4_to_64_kHz_0p1Hz_120sec = cfg;

%% -- properties: Intrinsic: pre-set config: fourier pure tone single freq, 1Hz, 30sec
cfg.fourier.nSweeps = 30;
cfg.fourier.fouBaseFreq = 4000;
cfg.fourier.fouNFreqs = 1;
cfg.fourier.fouPowOf2 = 0;
cfg.fourier.sweepDur = 1;
cfg.fourier.fouStimDur = 0.050;
cfg.fourier_saveName = [ '[this.in.timestamp]_exp[this.in.common.expNumber]_', ...
    'stim[1 / this.in.fourier.sweepDur]Hz_[round(this.in.fourier.sweepDur * this.in.fourier.nSweeps)]sec_', ...
    '[round(this.in.fourier.fouBaseFreq / 1000)]kHz_', ...
    'amplif[this.in.common.amplifFactor]_[this.in.common.frameRate]HzFrameRate' ];
this.in.configs.x06_fourier_pure_tone_single_freq_1Hz_30sec = cfg;

%% -- properties: Intrinsic: pre-set config: fourier multiple pure tone 8kHz to 32kHz, 360sec
cfg.fourier.nSweeps = 30;
cfg.fourier.fouBaseFreq = 8000;
cfg.fourier.fouNFreqs = 9;
cfg.fourier.fouPowOf2 = -2;
cfg.fourier.sweepDur = 12;
cfg.fourier.fouStimDur = 0.2;
cfg.fourier.nTones = 3;
cfg.fourier.fouToneITI = 0.1;
cfg.fourier_saveName = [ '[this.in.timestamp]_exp[this.in.common.expNumber]_', ...
    'stim[1 / this.in.fourier.sweepDur]Hz_[round(this.in.fourier.sweepDur * this.in.fourier.nSweeps)]sec_', ...
    '[round(this.in.fourier.fouBaseFreq / 1000)]to', ...
    '[round(this.in.fourier.fouBaseFreq / 1000 * (2 .^ ((this.in.fourier.fouNFreqs - 1) * ', ...
    '(2 ^ this.in.fourier.fouPowOf2))))]kHz_[this.in.fourier.sweepDir]Sweep_', ...
    'amplif[this.in.common.amplifFactor]_[this.in.common.frameRate]HzFrameRate_', ...
    '[this.in.fourier.nTones]tones'];
this.in.configs.x07_fourier_multiple_pure_tone_8_to_32_kHz_360sec = cfg;
%}

%% -- properties: Intrinsic: pre-set config: fourier pure tone 4 to 32kHz (13 freqs), 0p2Hz, 0.25s ITI, 600sec
cfg.fourier.nSweeps = 120;
cfg.fourier.fouBaseFreq = 4000;
cfg.fourier.fouNFreqs = 13;
cfg.fourier.fouPowOf2 = -2;
cfg.fourier.sweepDur = 5;
cfg.fourier.fouStimDur = 0.05;
cfg.fourier.nTones = 1;
cfg.fourier.fouToneITI = 0.25;
cfg.fourier_saveName = [ '[this.in.timestamp]_exp[this.in.common.expNumber]_', ...
    'stim[1 / this.in.fourier.sweepDur]Hz_[round(this.in.fourier.sweepDur * this.in.fourier.nSweeps)]sec_', ...
    '[round(this.in.fourier.fouBaseFreq / 1000)]to', ...
    '[round(this.in.fourier.fouBaseFreq / 1000 * (2 .^ ((this.in.fourier.fouNFreqs - 1) * ', ...
    '(2 ^ this.in.fourier.fouPowOf2))))]kHz_[this.in.fourier.sweepDir]Sweep_', ...
    'amplif[this.in.common.amplifFactor]_[this.in.common.frameRate]HzFrameRate_', ...
    '[this.in.fourier.fouToneITI]ToneITI' ];
this.in.configs.x05_fourier_pure_tone_4_to_32_kHz_0p2Hz_0p25ITI_13freqs_600sec = cfg;

%% -- properties: Intrinsic: pre-set config: fourier pure tone 4 to 32kHz (13 freqs), 0p75Hz, 0.04s ITI, 100sec
cfg.fourier.nSweeps = 75;
cfg.fourier.fouBaseFreq = 4000;
cfg.fourier.fouNFreqs = 13;
cfg.fourier.fouPowOf2 = -2;
cfg.fourier.sweepDur = 1.3333333333;
cfg.fourier.fouStimDur = 0.04;
cfg.fourier.nTones = 1;
cfg.fourier.fouToneITI = 0.04;
this.in.configs.x06_fourier_pure_tone_4_to_32_kHz_0p75Hz_0p05ITI_13freqs_100sec = cfg;

%{
%% -- properties: Intrinsic: pre-set config: fourier pure tone 4 to 32kHz (13 freqs), 0p33Hz, 0.1s ITI, 150sec
cfg.fourier.nSweeps = 50;
cfg.fourier.fouBaseFreq = 4000;
cfg.fourier.fouNFreqs = 13;
cfg.fourier.fouPowOf2 = -2;
cfg.fourier.sweepDur = 3;
cfg.fourier.fouStimDur = 0.05;
cfg.fourier.nTones = 1;
cfg.fourier.fouToneITI = 0.1;
this.in.configs.x04_fourier_pure_tone_4_to_32_kHz_0p33Hz_0p1ITI_13freqs_150sec = cfg;

%% -- properties: Intrinsic: pre-set config: fourier pure tone 4 to 32kHz (13 freqs), 0p4Hz, 0.1s ITI, 125sec
cfg.fourier.nSweeps = 50;
cfg.fourier.fouBaseFreq = 4000;
cfg.fourier.fouNFreqs = 13;
cfg.fourier.fouPowOf2 = -2;
cfg.fourier.sweepDur = 2.5;
cfg.fourier.fouStimDur = 0.05;
cfg.fourier.nTones = 1;
cfg.fourier.fouToneITI = 0.1;
this.in.configs.x05_fourier_pure_tone_4_to_32_kHz_0p4Hz_0p1ITI_13freqs_125sec = cfg;

%% -- properties: Intrinsic: pre-set config: fourier pure tone 4 to 32kHz (7 freqs), 0p4Hz, 0.25s ITI, 125sec
cfg.fourier.nSweeps = 50;
cfg.fourier.fouBaseFreq = 4000;
cfg.fourier.fouNFreqs = 7;
cfg.fourier.fouPowOf2 = -1;
cfg.fourier.sweepDur = 2.5;
cfg.fourier.fouStimDur = 0.05;
cfg.fourier.nTones = 1;
cfg.fourier.fouToneITI = 0.25;
this.in.configs.x05_fourier_pure_tone_4_to_32_kHz_0p4Hz_0p25ITI_7freqs_125sec = cfg;

%% -- properties: Intrinsic: pre-set config: fourier pure tone 4 to 32kHz (26 freqs), 0p4Hz, 0.025s ITI, 125sec
cfg.fourier.nSweeps = 50;
cfg.fourier.fouBaseFreq = 4000;
cfg.fourier.fouNFreqs = 25;
cfg.fourier.fouPowOf2 = -3;
cfg.fourier.sweepDur = 2.5;
cfg.fourier.fouStimDur = 0.05;
cfg.fourier.nTones = 1;
cfg.fourier.fouToneITI = 0.025;
this.in.configs.x05_fourier_pure_tone_4_to_32_kHz_0p4Hz_0p025ITI_25freqs_125sec = cfg;

%% -- properties: Intrinsic: pre-set config: fourier pure tone 4 to 32kHz (13 freqs), 0p5Hz, 0.1s ITI, 100sec
cfg.fourier.nSweeps = 50;
cfg.fourier.fouBaseFreq = 4000;
cfg.fourier.fouNFreqs = 13;
cfg.fourier.fouPowOf2 = -2;
cfg.fourier.sweepDur = 2;
cfg.fourier.fouStimDur = 0.05;
cfg.fourier.nTones = 1;
cfg.fourier.fouToneITI = 0.1;
this.in.configs.x06_fourier_pure_tone_4_to_32_kHz_0p5Hz_0p1ITI_13freqs_100sec = cfg;

%% -- properties: Intrinsic: pre-set config: fourier pure tone 4 to 32kHz (7 freqs), 0.2Hz, 0.25s ITI, 600sec
cfg.fourier.nSweeps = 120;
cfg.fourier.fouBaseFreq = 4000;
cfg.fourier.fouNFreqs = 7;
cfg.fourier.fouPowOf2 = -1;
cfg.fourier.sweepDur = 5;
cfg.fourier.fouStimDur = 0.05;
cfg.fourier.nTones = 1;
cfg.fourier.fouToneITI = 0.25;
this.in.configs.x03_fourier_pure_tone_4_to_32_kHz_0p2Hz_0p25ITI_7freqs_600sec = cfg;

%% -- properties: Intrinsic: pre-set config: fourier pure tone 4 to 32kHz (13 freqs), 0.2Hz, 0.30s ITI, 600sec
cfg.fourier.nSweeps = 120;
cfg.fourier.fouBaseFreq = 4000;
cfg.fourier.fouNFreqs = 13;
cfg.fourier.fouPowOf2 = -2;
cfg.fourier.sweepDur = 5;
cfg.fourier.fouStimDur = 0.05;
cfg.fourier.nTones = 1;
cfg.fourier.fouToneITI = 0.30;
this.in.configs.x04_fourier_pure_tone_4_to_32_kHz_0p2Hz_0p30ITI_13freqs_600sec = cfg;

%% -- properties: Intrinsic: pre-set config: fourier pure tone 4 to 32kHz (13 freqs), 0.25Hz, 0.25s ITI, 600sec
cfg.fourier.nSweeps = 150;
cfg.fourier.fouBaseFreq = 4000;
cfg.fourier.fouNFreqs = 13;
cfg.fourier.fouPowOf2 = -2;
cfg.fourier.sweepDur = 4;
cfg.fourier.fouStimDur = 0.05;
cfg.fourier.nTones = 1;
cfg.fourier.fouToneITI = 0.25;
this.in.configs.x05_fourier_pure_tone_4_to_32_kHz_0p25Hz_0p25ITI_13freqs_600sec = cfg;

%% -- properties: Intrinsic: pre-set config: fourier pure tone 4 to 32kHz (7 freqs), 0.25Hz, 0.25s ITI, 600sec
cfg.fourier.nSweeps = 150;
cfg.fourier.fouBaseFreq = 4000;
cfg.fourier.fouNFreqs = 7;
cfg.fourier.fouPowOf2 = -1;
cfg.fourier.sweepDur = 4;
cfg.fourier.fouStimDur = 0.05;
cfg.fourier.nTones = 1;
cfg.fourier.fouToneITI = 0.25;
this.in.configs.x06_fourier_pure_tone_4_to_32_kHz_0p25Hz_0p25ITI_7freqs_600sec = cfg;

%% -- properties: Intrinsic: pre-set config: fourier pure tone 4 to 32kHz (13 freqs), 0.0625Hz, 0.25s ITI, 640ec
cfg.fourier.nSweeps = 40;
cfg.fourier.fouBaseFreq = 4000;
cfg.fourier.fouNFreqs = 13;
cfg.fourier.fouPowOf2 = -2;
cfg.fourier.sweepDur = 16;
cfg.fourier.fouStimDur = 0.1;
cfg.fourier.nTones = 1;
cfg.fourier.fouToneITI = 0.75;
this.in.configs.x07_fourier_pure_tone_4_to_32_kHz_0p0625Hz_0p55ITI_640sec = cfg;

%% -- properties: Intrinsic: pre-set config: fourier pure tone 4 to 32kHz, 0p125Hz, 0.45s ITI, 320ec
cfg.fourier.nSweeps = 40;
cfg.fourier.fouBaseFreq = 4000;
cfg.fourier.fouNFreqs = 13;
cfg.fourier.fouPowOf2 = -2;
cfg.fourier.sweepDur = 8;
cfg.fourier.fouStimDur = 0.05;
cfg.fourier.nTones = 1;
cfg.fourier.fouToneITI = 0.45;
this.in.configs.x09_fourier_pure_tone_4_to_32_kHz_0p125Hz_0p45ITI_320sec = cfg;

%}

%% -- properties: Intrinsic: pre-set config: fourier pure tone multi freq mapping
cfg.fourier.nSweeps = 40;
cfg.fourier.fouBaseFreq = 1000 * [32, 4, 64, 16, 8, 64, 32, 8, 4, 16, 4, 64, 8, 32, 16];
cfg.fourier.fouNFreqs = 1;
cfg.fourier.fouPowOf2 = 0;
cfg.fourier.sweepDur = 30;
cfg.fourier.fouStimDur = 0.2;
cfg.fourier.nTones = 1;
cfg.fourier.fouToneITI = 1.8;
cfg.fourier_saveName = [ '[this.in.timestamp]_exp[this.in.common.expNumber]_', ...
    '[round(this.in.fourier.sweepDur * this.in.fourier.nSweeps)]sec_', ...
    '[min(round(this.in.fourier.fouBaseFreq / 1000))]to', ...
    '[max(round(this.in.fourier.fouBaseFreq / 1000 * (2 .^ ((this.in.fourier.fouNFreqs - 1) * ', ...
    '(2 ^ this.in.fourier.fouPowOf2)))))]kHz_multiFreqMapping_', ...
    'amplif[this.in.common.amplifFactor]_[this.in.common.frameRate]HzFrameRate' ];
this.in.configs.x07_fourier_pure_tone_multi_freq_mapping = cfg;

%% -- properties: Intrinsic: pre-set config: fourier multi modality mapping
cfg.fourier.nSweeps = 10;
cfg.fourier.fouBaseFreq = [1,3,2,3,2,1,3,2,1,3,1,2,3,2,1,2,1,3,1,3,1,2,3,2,1,3,2,1,2,3];
cfg.fourier.fouNFreqs = 1;
cfg.fourier.stimIDs = { 'auditory', 'visual', 'somatosensory' };
cfg.fourier.fouPowOf2 = 0;
cfg.fourier.sweepDur = 90;
cfg.fourier.fouStimDur = 1;
cfg.fourier.nTones = 0;
cfg.fourier.fouToneITI = 2;
cfg.fourier_saveName = [ '[this.in.timestamp]_exp[this.in.common.expNumber]_', ...
    '[round(this.in.fourier.sweepDur * this.in.fourier.nSweeps)]sec_', ...
    'multiModalityMapping_[this.in.common.frameRate]HzFrameRate' ];
this.in.configs.x08_fourier_multi_modality_mapping = cfg;
%{
%% -- properties: Intrinsic: pre-set config: standard pure tone
cfg = struct();
cfg.expMode = 'standard';
cfg.common.soundType = 'pure tone';
cfg.common.startDelay = 5;
cfg.standard.nRuns = 10;
cfg.standard.baselineAvgDur = 2;
cfg.standard.baseline1ToBaseline2Delay = 1;
cfg.standard.baselineToStimDelay = 1;
cfg.standard.stdStimDur = 2;
cfg.standard.stimToStimAvgDelay = 0.5;
cfg.standard.stimAvgDur = 2;
cfg.standard.waitPeriod = 10;
cfg.standard.stdBaseFreq = 6000;
cfg.standard.stdNFreqs = 0;
cfg.standard.stdPowOf2 = 0;
cfg.standard.stdToneDur = 0.05;
cfg.standard.stdToneISI = 0.1;
cfg.standard.stdCloudDispersion = 0;
cfg.standard.stdCloudCenter = 0;
cfg.fourier_saveName = this.in.fourier_saveName;
% store in configuration structure
this.in.configs.x999_standard_pure_tone_10_runs = cfg;
%}

%}

end
