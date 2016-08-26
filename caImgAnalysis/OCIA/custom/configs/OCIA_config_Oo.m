function this = OCIA_config_Oo(this)
% OCIA_config_Oo - "Oo" OCIA configuration file
%
%       this = OCIA('Oo')
%
% Configuration file for OCIA using the "Oo" configuration. This function should not be called directly
%   but rather using the "this = OCIA('Oo');" syntax to launch the software with this configuration.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the default configuration
configHandle = str2func('OCIA_config_default');
this = configHandle(this);

%% - input parameters
this.main.startFunctionName = 'dataWatcher';

this.GUI.noGUI = false;
this.GUI.dw.DWFilt = { 'mou_bl_141001_01', '2014_10_16', 'spot01', 'Imaging Data' };
this.GUI.dw.DWWatchTypes = 'all';
this.GUI.dw.DWSkiptMeta = false;
this.GUI.dw.DWRawOrLocal = 'local';

this.an.an.preProcOptions = { 'skipFrame', 'fShift', 'fJitt', 'moDet', 'moCorr' };

%% - properties: GUI
% initial position of the main window
this.GUI.pos = [10, 0, 1220, 805]; 

%% - properties: general
% verbosity, number telling how much debugging output should be printed out. The higher the more verbose.
this.verb = 2;

%% -- properties: general: paths to relevant locations (raw data, ect.)
% path of the raw data (usually stored on the server)
this.path.rawData = 'C:/Users/BaL/Documents/RawData/';
% path of the local data
this.path.localData = 'C:/Users/BaL/Documents/RawData/';
% path where the OCIA related things should be saved (OCIA object itself, data, plots, etc.)
this.path.OCIASave = 'D:/Users/BaL/Documents/Analysis/';

end
