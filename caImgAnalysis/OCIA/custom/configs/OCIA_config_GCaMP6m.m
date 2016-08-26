function this = OCIA_config_GCaMP6m(this)
% OCIA_config_GCaMP6m - "GCaMP6m" OCIA configuration file
%
%       this = OCIA('GCaMP6m')
%
% Configuration file for OCIA using the "GCaMP6m" configuration. This function should not be called directly
%   but rather using the "this = OCIA('GCaMP6m');" syntax to launch the software with this configuration.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the default configuration
configHandle = str2func('OCIA_config_default');
this = configHandle(this);

%% - input parameters
this.GUI.noGUI = false;
this.GUI.dw.DWFilt = { 'mou_bl_150225_01', '2015_02_25' };
this.GUI.dw.DWWatchTypes = 'all';
this.GUI.dw.DWSkiptMeta = false;
this.GUI.dw.DWKeepTable = false;
this.GUI.dw.DWRawOrLocal = 'local';

%% - properties: general
this.verb = 2;
% path of the raw data (usually stored on the server)
this.path.rawData = 'W:/Scratch-02 no Backup/RawDataBalazs/2015/1502_chronic/';
% path of the local data
this.path.localData = 'C:/Users/laurenczy/Documents/LabVIEW Data/';
% path where the OCIA related things should be saved (OCIA object itself, data, plots, etc.)
this.path.OCIASave = 'C:/Users/laurenczy/Documents/LabVIEW Data/OCIA/';

%% - properties: GUI
this.GUI.pos = [694, 343, 1220, 805];

%% GCaMP6m parameters

% annotate table function name
this.dw.annotateTableFunctionName = 'GCaMP6m';

% stimulus generating function name
this.an.stimulusVectorGeneratingFunctionName = 'noStim';

% number of channel(s) to load; also the number of data files that should be in a data folder
this.an.img.nChans = 2;
% index of the channel on which the pre-processing should be calculated (motion correction/detection, etc.)
this.an.img.preProcChan = 2;
% channels to use for the RGB image display
this.an.img.colVect = [1 2 0];
% channels to use for the dFF/dRR calculations
this.an.img.chanVect = 2;
% frame rate of the imaging in hertz
this.an.img.defaultFrameRate = 77.67;
% fixed/default dimensions of the imaging data in pixels
this.an.img.defaultImDim = [200 200];
% F0/R0 method index. Methods are mean, median, prctile, polyfit, polyfitMean
this.an.img.f0method = 3;
% F0/R0 parameter (can be empty), for percentile: Nth percentile; for polyfit: polyfit degree
this.an.img.f0params = 25;
% background substraction percentile
this.an.img.bgPrctile = 1;

end