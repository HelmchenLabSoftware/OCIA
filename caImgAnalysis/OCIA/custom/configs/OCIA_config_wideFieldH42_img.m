function this = OCIA_config_wideFieldH42_img(this)
% OCIA_config_wideFieldH42_img - "wideFieldH42_img" OCIA configuration file
%
%       this = OCIA('wideFieldH42_img')
%
% Configuration file for OCIA using the "wideFieldH42_img" configuration. This function should not be called directly
%   but rather using the "this = OCIA('wideFieldH42_img');" syntax to launch the software with this configuration.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% call parent config file
this = OCIA_config_widefield(this);

%% - parameters
this.main.startFunctionName = 'intrinsic';

% string defining the camera's adaptor name
this.in.adaptorName = 'hamamatsu';
% this.in.adaptorName = 'winvideo';

% string defining the camera's format
this.in.common.camFormat = 'MONO16_BIN4x4_512x512_FastMode';
% cell-array of strings defining the available camera formats
this.in.availableCamFormats = { this.in.common.camFormat };

% defines the stimulus mode for handling stimuli: soundCard, TDT, trigOut, or trigIn
this.in.common.stimMode = 'trigOut';

this.main.startFunctionName = 'intrinsic';

%% - properties: general
% path of the data
this.path.localData = 'C:/Users/WideField/Documents/LabVIEW Data/';
this.path.rawData = this.path.localData;
% path where the OCIA related things should be saved (OCIA object itself, data, plots, etc.)
this.path.OCIASave = 'C:/Users/WideField/Documents/LabVIEW Data/OCIA/';
% path where the intrinsic data should be saved
this.path.intrSave = sprintf('C:/Users/WideField/Documents/LabVIEW Data/%s/widefield/', datestr(date, 'yyyy_mm_dd'));


end
