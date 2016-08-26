function this = OCIA_config_dayra(this)
% OCIA_config_dayra - "dayra" OCIA configuration file
%
%       this = OCIA('dayra')
%
% Configuration file for OCIA using the "dayra" configuration. This function should not be called directly
%   but rather using the "this = OCIA('dayra');" syntax to launch the software with this configuration.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the default configuration
configHandle = str2func('OCIA_config_default');
this = configHandle(this);

% define some path
%% - input parameters
this.main.startFunctionName = 'dataWatcher';

this.GUI.noGUI = false;
% this.GUI.dw.DWFilt = { 'mou_dl_140604_03', '2014_06_25', 'spot01', 'imgData', 'B', '', '.|P'};
this.GUI.dw.DWFilt = { 'mou_dl_140604_03', '2014_06_25', 'spot01', 'imgData', 'B', '', ''};
this.GUI.dw.DWWatchTypes = 'all';
this.GUI.dw.DWSkiptMeta = false;
this.GUI.dw.DWRawOrLocal = 'local';

this.an.an.preProcOptions = { 'skipFrame', 'fShift', 'fJitt', 'moCorr' };

%% - properties: GUI
% initial position of the main window
% this.GUI.pos = [1950, 175, 1220, 805];
this.GUI.pos = [345, 185, 1220, 805];

%% -- properties: general: paths to relevant locations (raw data, ect.)
% path of the raw data (usually stored on the server)
this.path.rawData = 'Z:/RawData/Dayra_Lorenzo/2014_06_chronic/';
% path of the local data
this.path.localData = 'F:/RawData/Dayra/';
% path where the OCIA related things should be saved (OCIA object itself, data, plots, etc.)
this.path.OCIASave = 'E:/Analysis/Dayra/';

end
