function this = OCIA_config_behaviorSummary_H30(this)
% OCIA_config_behaviorSummary_H30 - "behaviorSummary_H30" OCIA configuration file
%
%       this = OCIA('behaviorSummary_H30')
%
% Configuration file for OCIA using the "behaviorSummary_H30" configuration. This function should not be called directly
%   but rather using the "this = OCIA('behaviorSummary_H30');" syntax to launch the software with this configuration.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the default configuration
configHandle = str2func('OCIA_config_default');
this = configHandle(this);

%% - input parameters
this.main.startFunctionName = 'behaviorSummary';

this.GUI.noGUI = false;
this.GUI.dw.DWFilt = { };
this.GUI.dw.DWWatchTypes = { 'animal', 'day', 'spot', 'img', 'notebook' };
this.GUI.dw.DWSkiptMeta = false;
this.GUI.dw.DWKeepTable = false;
this.GUI.dw.DWRawOrLocal = 'local';

%% - properties: general
this.verb = 2;
% path of the raw data (usually stored on the server)
this.path.rawData = 'D:/RawData/1601_behav/';
% path of the local data
this.path.localData = 'D:/RawData/1601_behav/';
% path where the OCIA related things should be saved (OCIA object itself, data, plots, etc.)
this.path.OCIASave = 'D:/RawData/1601_behav/';

%% - properties: GUI
this.GUI.pos = [-1272, 272, 1265, 805];

end
