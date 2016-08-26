function this = OCIA_config_trialView_ariel(this)
% OCIA_config_trialView_ariel - "trialView_ariel" OCIA configuration file
%
%       this = OCIA('trialView_ariel')
%
% Configuration file for OCIA using the "trialView_ariel" configuration. This function should not be called directly
%   but rather using the "this = OCIA('trialView_ariel');" syntax to launch the software with this configuration.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% -- initialize mode (do not touch this)
% configure modes
this.main.modes = { 'DataWatcher', 'dw'; 'TrialView', 'tv'; };

% defines which data "modules" should be appended to the software. Should be a cell-array of strings with one element
%   per data mode. Also needs to be initialized before the call to 'OCIA_config_default'.
this.main.dataModes = { 'wf'; 'behav' };

% get the default configuration
configHandle = str2func('OCIA_config_default');
this = configHandle(this);

%% -- properties: changeable properties
% position and size of the window
this.GUI.pos = [225, 10, 1550, 1000];

% allPaths = 'W:\Neurophysiology-Storage1\Gilad\Data_per_mouse\mouse_tgg6fl23_3\20150610\c';
allPaths = 'W:\Neurophysiology-Storage1\Gilad\Data_per_mouse\mouse_tgg6fl23_3\20150520\c';

% path where the widefield data is located
this.tv.params.WFDataPath = allPaths;
% path where the parameters or output should be saved to or loaded from
this.tv.params.saveLoadPath = allPaths;
% path where the behavior data is located
this.tv.params.behavDataPath = allPaths;

% name of the starting function
this.main.startFunctionName = 'trialView';

% delay period in seconds of the behavior
this.tv.params.behavDelay = 3.4;
% behavior movie size
this.tv.params.behavMovieSize = [480, 720];
% behavior movie's frame rate
this.tv.params.behavFrameRate = 30.034;
% offset of time from the time 0 of the first trial compare to the start of the behavior movie
this.tv.params.behavTimeOffset = 9.1;

% display config for ROIs
this.tv.params.ROIDisplayConfigs = {
... name            color (R,G,B)   line style (-, : or .-)
    'A1',           '0,1,0',        '-';
    'EC',           '0.2,0,0.5',    '-';
    'M2',           '0,1,1',        '-';
    'mouth',        '1,0,0',        '-';
    'PPC',          '1,0,0',        '-';
    'S1BC',         '1,0,1',        '-';
    'S1FL',         '1,0,0',        '-';
    'S1HL',         '0.5,0.5,0.5',        '-';
    'S2',           '1,0,1',        '-';
    'V1',           '0,0,1',        '-';
    'Behav_back',   '1,0,1',        ':';
    'Behav_lick',   '0,1,1',        ':';
    'Behav_fl',   '1,0,0',        ':';
    'Behav_hl',   '0,1,0',        ':';
};

% display config for trial timeline
this.tv.params.TCTimeLineConfig = {
    'stimCue',      -2.0,               NaN,                        '0.3,0.3,0.3',  ':';
    'sensation',     0.0,               1.9,                        '0.1,0.8,0.1',  'box';
    'delay',         1.9,               '1.9 + params.behavDelay',  '0.1,0.1,0.8',  'box';
    'respCue',      '1.9 + params.behavDelay',  NaN,                '0.3,0.3,0.3', ':';
};

% Y limits for time course axis of ROIs
this.tv.params.TCYLimROI = [-0.05, 0.10];
% Y limits for time course of whiskers
this.tv.params.TCYLimWhisk = [-1.5, 8.5];
% Y limits for time course of licking
this.tv.params.TCYLimLick = [-0.01, 0.12];
% Y limits for time course of licking
this.tv.params.WFCLim = [-0.02, 0.07];

% auto-play speed factor (relative to playing at actual wide-field frame rate)
this.tv.params.WFAutoplaySpeedFactor = 1;
% frame rate of wide-field imaging
this.tv.params.WFFrameRate = 20;
% smooth parameters for gaussian smoothing of wide-field data. Use 0 to disable
% this.tv.params.WFSmoothDim = [0 0 0];
this.tv.params.WFSmoothDim = [5 5 1];
% time offset of wide-field imaging for defining time 0 within a trial (+3 => 0 is 3 seconds after start of trial)
this.tv.params.WFTimeOffset = 3;

%% call default TrialView config (do not touch this)
this = OCIA_config_trialView(this);

end
