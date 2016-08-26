function this = OCIA_config_ephysCourse_H6403b(this)
% OCIA_config_ephysCourse_H6403b - "ephysCourse_H6403b" OCIA configuration file
%
%       this = OCIA('ephysCourse_H6403b')
%
% Configuration file for OCIA using the "ephysCourse_H6403b" configuration. This function should not be called directly
%   but rather using the "this = OCIA('ephysCourse_H6403b');" syntax to launch the software with this configuration.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the default configuration
configHandle = str2func('OCIA_config_default');
this = configHandle(this);

%% - input parameters
% this.main.startFunctionName = 'behaviorSummary';
this.main.startFunctionName = 'dataWatcher';

this.GUI.noGUI = false;
this.GUI.dw.DWFilt = { 'mou_bl_000000_00', '2014_12_04', 'spot01' };
this.GUI.dw.DWWatchTypes = 'all';
this.GUI.dw.DWSkiptMeta = false;
this.GUI.dw.DWRawOrLocal = 'local';

this.an.an.preProcOptions = { 'skipFrame', 'fShift', 'fJitt', 'moCorr', 'moDet' };

%% - properties: GUI
% initial position of the main window
% this.GUI.pos = [1950, 175, 1220, 805];
this.GUI.pos = [10, 320, 1430, 840];
% this.GUI.pos = [1920, 1, 1280, 1000];

%% - properties: general
% verbosity, number telling how much debugging output should be printed out. The higher the more verbose.
this.verb = 2;

%% -- properties: general: paths to relevant locations (raw data, ect.)
% path of the raw data (usually stored on the server)
this.path.rawData = 'F:/RawData/ephysCourseData/';
% path of the local data
this.path.localData = 'F:/RawData/ephysCourseData/';
% path where the OCIA related things should be saved (OCIA object itself, data, plots, etc.)
this.path.OCIASave = 'E:/Analysis/ephysCourseData/';

%% -- properties: analysis parameters
% stimulus generating function
this.an.stimulusVectorGeneratingFunctionName = 'noStim';

%% -- properties: imaging parameters
% number of channel(s) to load; also the number of data files that should be in a data folder
this.an.img.nChans = 3;
% index of the channel on which the pre-processing should be calculated (motion correction/detection, etc.)
this.an.img.preProcChan = 2;
% channels to use for the RGB image display
this.an.img.colVect = [1 2 3];
% channels to use for the dFF/dRR calculations
this.an.img.chanVect = 2;
% frame rate of the imaging in hertz
this.an.img.defaultFrameRate = 28.0;
% fixed/default dimensions of the imaging data in pixels
this.an.img.defaultImDim = [128 64];
% minimum number of frames for a row to be considered as a functional movie
this.an.img.funcMovieNFramesLimit = 2;
% F0/R0 method index. Methods are mean, median, prctile, polyfit, polyfitMean
this.an.img.f0method = 3;
% F0/R0 parameter (can be empty), for percentile: Nth percentile; for polyfit: polyfit degree
this.an.img.f0params = 25;
% background substraction percentile
this.an.img.bgPrctile = 1;
% degree of the polyfit correction for bleaching. Set to 0 for no correction.
this.an.img.polyfitCorrect = 0;
% percent of the trace where the polyfit correction should be calculated
this.an.img.polyfitFraction = 0.0;

end
