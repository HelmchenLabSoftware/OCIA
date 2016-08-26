function this = OCIA_modeConfig_trialview(this)
% OCIA_modeConfig_trialview adds the TrialView mode to the OCIA

%% -- properties: GUI: TrialView
this.GUI.tv = struct();
% defines wheter a drag event is currently ongoing on the axes
this.GUI.tv.mouseDownOnAxe = false;
% defines wheter a ROI drawing is currently ongoing on the wide-field axe
this.GUI.tv.mouseDownOnWFImg = false;

this.GUI.tv.javaInitialized = false;

%% -- properties: TrialView
this.tv = struct();

% data structure
this.tv.data = struct();
% nTrials cell array with a list of points for each trial
this.tv.data.movePoints = {};
% nTrials cell array with a vector of zeros/ones for each trial
this.tv.data.moveVects = {};

% currently displayed frame
this.tv.iFrame = 1;
% currently displayed trial
this.tv.iTrial = [];
% current behavior frame
this.tv.behavFrame = 1;
% current delay for the wide-field movie
this.tv.trigDelay = 0;
% current trial's behavior start time
this.tv.behavStartTime = 0;

% cell array of ROI handles
this.tv.ROI.ROIHandles = {};
% cell array of ROI masks
this.tv.ROI.ROIMasks = {};
% cell array of ROI names
this.tv.ROI.ROINames = {};
% array of ROI IDs
this.tv.ROI.ROIIDs = [];
% array of ROI axe handles
this.tv.ROI.axeH = [];
% cell array of ROI time courses
this.tv.ROI.ROITimeCourses = {};

% list of trial start times
this.tv.trialZeroTimes = [];

%% -- properties: TrialView: Params
% stores the wide-field file list
this.tv.params.fileList = {};

% delay period in seconds of the behavior
this.tv.params.behavDelay = 1.5;
% path where the behavior data is located
this.tv.params.behavDataPath = '';
% behavior file path
this.tv.params.behavFilePath = '';
% frame rate of behavior movie
this.tv.params.behavFrameRate = 30;
% this.tv.params.behavFrameRate = 25;
% pseudo-flat-field filtering of behavior movie
this.tv.params.behavPseudoFlatFieldRounds = 0;
% behavior movie path
this.tv.params.behavMoviePath = '';
% behavior movie size
this.tv.params.behavMovieSize = [240, 320];
% offset of time from the time 0 of the first trial compare to the start of the behavior movie. Increasing this makes
% the "behav"-ROIs time course to shift left
this.tv.params.behavTimeOffset = 0;

%%
% display config for ROIs
this.tv.params.ROIDisplayConfigs = {
... name            color (R,G,B)   line style (-, : or .-)
    'A1',           '0.494, 0.184, 0.556',      '-';
    'EC',           '0.2,0,0.5',                '-';
    'M2',           '0.000, 0.447, 0.741',      '-';
%     'M2',           '0,1,1',                  '-';
    'mouth',        '1,0,0',                    '-';
    'front',        '0,0,0',                    '--';
    'lateral',      '0,0,0',                    '--';
    'lateral2',     '0,0,0',                    '--';
    'posterior',    '0,0,0',                    '--';
    'posterior2',   '0,0,0',                    '--';
    'PPC',          '0.301, 0.745, 0.933',      '-';
    'S1BC',         '0.850, 0.325, 0.098',      '-';
    'S1FL',         '0.929, 0.694, 0.125',      '-';
    'S2',           '1,0,1',                    '-';
    'V1',           '0.466, 0.674, 0.188',      '-';
    'behavBack',    '1,0.2,0.5',                ':';
    'behavLight',   '0.7,0.7,0',                ':';
    'behavLimbs',   '0.5,0,1',                  ':';
    'behavLick',    '0.5,1,0',                  ':';
    'behavNose',    '0.7,0.9,0.1',              ':';
    'behavWater',   '0,1,1',                    ':';
};
%%
% path where the parameters or output should be saved to or loaded from
this.tv.params.saveLoadPath = '';

% path where the lick trace file is located
this.tv.params.lickFilePath = '';
% path where the lick trace file is located
this.tv.params.whiskFilePath = '';
% path where the reference image file is located
this.tv.params.refImgFilePath = '';

% display config for trial timeline
% this.tv.params.TCTimeLineConfig = {
%     'stimCue',      -2.0,                   NaN,                    '0.3,0.3,0.3',  ':';
%     'sensation',     0.0, 'behavConfig.tone.stimDur',               '0.1,0.8,0.1',  'box';
%     'delay', 'behavConfig.tone.stimDur', 'behavConfig.tone.stimDur + params.behavDelay', '0.1,0.1,0.8', 'box';
%     'respCue', 'behavConfig.tone.stimDur + params.behavDelay', NaN, '0.3,0.3,0.3', ':';
% };
this.tv.params.TCTimeLineConfig = {
    'stimCue',      -2.0,   NaN,    '0.3,0.3,0.3',  ':';
    'sensation',    0.0,    2.0,    '0.1,0.8,0.1',  'box';
    'delay',        2.0,    4.0,    '0.1,0.1,0.8',  'box';
    'respCue',      4.0,    NaN,    '0.3,0.3,0.3',  ':';
};
% Y limits for time course axis of ROIs
this.tv.params.TCYLimROI = [-0.05, 0.10];
% Y limits for time course of whiskers
this.tv.params.TCYLimWhisk = [-1.5, 12.5];
% Y limits for time course of licking
this.tv.params.TCYLimLick = [-0.005, 0.1];

% auto-play speed factor (relative to playing at actual wide-field frame rate)
this.tv.params.WFAutoplaySpeedFactor = 1;
% auto-play on/off
this.tv.params.WFAutoplay = 'off';
% show reference image or widefield data
this.tv.params.showRef = 0;
% color clipping limits for wide-field image
this.tv.params.WFCLim = [-0.05, 0.10];
% path where the widefield data is located
this.tv.params.WFDataPath = '';
% wide-field file path
this.tv.params.WFFilePath = '';
% wide-field data size
this.tv.params.WFDataSize = [256, 256, 1];
% frame rate of wide-field imaging
this.tv.params.WFFrameRate = 20;
% smooth parameters for gaussian smoothing of wide-field data. Use 0 to disable
% this.tv.params.WFSmoothDim = [0 0 0];
this.tv.params.WFSmoothDim = [5 5 1];
% time offset of wide-field imaging for defining time 0 within a trial (+3 => 0 is 3 seconds after start)
this.tv.params.WFTimeOffset = 3;

end
