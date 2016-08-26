function this = OCIA_config_intrinsicH30(this)
% OCIA_config_intrinsicH30 - "intrinsicH30" OCIA configuration file
%
%       this = OCIA('intrinsicH30')
%
% Configuration file for OCIA using the "intrinsicH30" configuration. This function should not be called directly
%   but rather using the "this = OCIA('intrinsicH30');" syntax to launch the software with this configuration.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% configure modes
this.main.modes = { 'DataWatcher', 'dw'; 'Intrinsic', 'in'; };
% this.main.dataModes = { 'intr' };

% get the default configuration
configHandle = str2func('OCIA_config_default');
this = configHandle(this);

%% - input parameters
this.main.startFunctionName = 'intrinsic';

%% - properties: general
this.verb = 2;
% path of the raw data (usually stored on the server)
this.path.rawData = 'W:/Scratch-02 no Backup/RawDataBalazs/2015/1502_chronic/';
% path of the local data
this.path.localData = 'C:/Users/laurenczy/Documents/LabVIEW Data/';
% path where the OCIA related things should be saved (OCIA object itself, data, plots, etc.)
this.path.OCIASave = 'C:/Users/laurenczy/Documents/LabVIEW Data/OCIA/';
% path where the intrinsic data should be saved
this.path.intrSave = sprintf('C:/Users/laurenczy/Documents/LabVIEW Data/%s/intr/', datestr(date, 'yyyy_mm_dd'));

%% - properties: GUI
% this.GUI.pos = [-1272, 90, 1265, 985];
this.GUI.pos = [120, -25, 1200, 700]; % presentation and figures

end
