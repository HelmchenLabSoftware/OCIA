function this = OCIA_config_behaviorH4201(this)
% OCIA_config_behaviorH4201 - "behaviorH4201" OCIA configuration file
%
%       this = OCIA('behaviorH4201')
%
% Configuration file for OCIA using the "behaviorH4201" configuration. This function should not be called directly
%   but rather using the "this = OCIA('behaviorH4201');" syntax to launch the software with this configuration.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the default configuration
configHandle = str2func('OCIA_config_default');
this = configHandle(this);

%% - input parameters
this.main.startFunctionName = 'behavior';

this.GUI.noGUI = false;
this.GUI.dw.DWFilt = { };
this.GUI.dw.DWWatchTypes = 'all';
this.GUI.dw.DWSkiptMeta = false;
this.GUI.dw.DWKeepTable = false;
this.GUI.dw.DWRawOrLocal = 'local';

%% - properties: general
this.verb = 2;
% path of the raw data (usually stored on the server)
this.path.rawData = 'C:/Users/laurenczy/Documents/LabVIEW Data/';
% path of the local data
this.path.localData = 'C:/Users/laurenczy/Documents/LabVIEW Data/';
% path where the OCIA related things should be saved (OCIA object itself, data, plots, etc.)
this.path.OCIASave = 'C:/Users/laurenczy/Documents/LabVIEW Data/OCIA/';

%% - properties: GUI
% this.GUI.pos = [15, 175, 1575, 995];
% this.GUI.pos = [15, 25, 1290, 995];
% this.GUI.pos = [15, 315, 1375, 850];
% this.GUI.pos = [15, 25, 1250, 1140];
this.GUI.pos = [8, 246, 935, 748];

end
