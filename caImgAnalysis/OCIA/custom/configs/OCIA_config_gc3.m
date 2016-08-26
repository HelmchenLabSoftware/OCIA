function this = OCIA_config_gc3(this)
% OCIA_config_gc3 - "gc3" OCIA configuration file
%
%       this = OCIA('gc3')
%
% Configuration file for OCIA using the "gc3" configuration. This function should not be called directly
%   but rather using the "this = OCIA('gc3');" syntax to launch the software with this configuration.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the default configuration
configHandle = str2func('OCIA_config_default');
this = configHandle(this);

%% - input parameters
this.main.startFunctionName = 'preProcessPipeline';

this.GUI.noGUI = true;
this.GUI.dw.DWFilt = { };
this.GUI.dw.DWWatchTypes = 'all';
this.GUI.dw.DWSkiptMeta = false;
this.GUI.dw.DWRawOrLocal = 'local';
this.an.an.preProcOptions = { 'skipFrame', 'fShift', 'fJitt', 'moCorr' };

%% - properties: general
% verbosity, number telling how much debugging output should be printed out. The higher the more verbose.
this.verb = 2;
%% -- properties: general: paths to relevant locations (raw data, ect.)
% path of the raw data (usually stored on the server)
this.path.rawData = '/home/gc3-user/data/'; % hifo01/hifo02
% path of the local data
this.path.localData = '/home/gc3-user/data/'; % hifo01/hifo02
% path where the OCIA related things should be saved (OCIA object itself, data, plots, etc.)
this.path.OCIASave = '/home/gc3-user/data/OCIA/'; % hifo01/hifo02

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
%% -- properties: Analyser: Analysis
% number of frames to remove in the begining of the imaging data (shutter artifact)
this.an.an.nSkipFrame = 1;
% determines which transformation should be used for the turboReg registration, which can be one
%   of: translation/rigidBody/affine/bilinear
this.an.an.regTransf = 'rigidBody';
% determines whether a filter should be applied on the images before motion correction
this.an.an.moCorrFilt = false;
% determines whether a filter should be applied on the images before motion detection
this.an.an.moDetFilt = true;
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
