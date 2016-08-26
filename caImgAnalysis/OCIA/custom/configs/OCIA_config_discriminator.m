function this = OCIA_config_discriminator(this)
% OCIA_config_discriminator - "discriminator" OCIA configuration file
%
%       this = OCIA('discriminator')
%
% Configuration file for OCIA using the "discriminator" configuration. This function should not be called directly
%   but rather using the "this = OCIA('discriminator');" syntax to launch the software with this configuration.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the default configuration
configHandle = str2func('OCIA_config_default');
this = configHandle(this);

%% - input parameters
this.main.startFunctionName = 'discriminator';

%% - properties: GUI
% initial position of the main window
this.GUI.pos = [-1279          83        1280        1002];

%% - properties: general
% verbosity, number telling how much debugging output should be printed out. The higher the more verbose.
this.verb = 2;

%% -- properties: general: paths to relevant locations (raw data, ect.)
% path of the raw data (usually stored on the server)
this.path.rawData = 'C:/Users/laurenczy/Documents/Discriminator/';
% path of the local data
this.path.localData = 'C:/Users/laurenczy/Documents/Discriminator/';
% path where the OCIA related things should be saved (OCIA object itself, data, plots, etc.)
this.path.OCIASave = 'C:/Users/laurenczy/Documents/Discriminator/';

end
