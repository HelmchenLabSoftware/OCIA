function this = OCIA_config_onlineAnalysis_H6403b(this)
% OCIA_config_onlineAnalysis_H6403b - "onlineAnalysis_H6403b" OCIA configuration file
%
%       this = OCIA('onlineAnalysis_H6403b')
%
% Configuration file for OCIA using the "onlineAnalysis_H6403b" configuration. This function should not be called directly
%   but rather using the "this = OCIA('onlineAnalysis_H6403b');" syntax to launch the software with this configuration.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the default configuration
configHandle = str2func('OCIA_config_default');
this = configHandle(this);

% define some path
% currentDir = regexprep(pwd(), '\\', '/');

%% - input parameters
this.main.startFunctionName = 'onlineAnalysis';

this.GUI.noGUI = false;
this.GUI.dw.DWFilt = { '-', '-', '-', 'imgData', 'B' };
this.GUI.dw.DWWatchTypes = 'all';
this.GUI.dw.DWSkiptMeta = false;
this.GUI.dw.DWRawOrLocal = 'local';
this.an.an.preProcOptions = { 'skipFrame', 'fShift' };

%% - properties: GUI
% initial position of the main window
this.GUI.pos = [345, 185, 1220, 805]; % default

%% - properties: general
% verbosity, number telling how much debugging output should be printed out. The higher the more verbose.
this.verb = 2;
%% -- properties: general: paths to relevant locations (raw data, ect.)
% path of the raw data (usually stored on the server)
this.path.rawData = 'Z:/RawData/Balazs_Laurenczy/onlineAnalysis/';
% path of the local data
this.path.localData = 'F:/RawData/onlineAnalysis/'; % HIFOWSH640x2D03b
% path where the OCIA related things should be saved (OCIA object itself, data, plots, etc.)
this.path.OCIASave = 'E:/Analysis/onlineAnalysis/'; % HIFOWSH640x2D03b

end
