function this = OCIA_config_wideFieldH42_stim(this)
% OCIA_config_wideFieldH42_stim - "wideFieldH42_stim" OCIA configuration file
%
%       this = OCIA('wideFieldH42_stim')
%
% Configuration file for OCIA using the "wideFieldH42_stim" configuration. This function should not be called directly
%   but rather using the "this = OCIA('wideFieldH42_stim');" syntax to launch the software with this configuration.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% call parent config file
this = OCIA_config_widefield(this);

%% change details for this file
% defines the stimulus mode for handling stimuli: soundCard, TDT, trigOut, or trigIn
% this.in.common.stimMode = 'trigIn';
this.in.common.stimMode = 'trigInTTLOut';

% for trigIn - TTL out mode
this.in.daq.vendorName = 'ni';
this.in.daq.deviceID = 'BehaviorBox';
this.in.daq.trigOutPort = { 'ao0', 'ao1' };
this.in.daq.trigInPort = 'ai1';

this.main.startFunctionName = 'intrinsic';

% path of the data
this.path.localData = 'C:/Users/laurenczy/Documents/LabVIEW Data/';
this.path.rawData = this.path.localData;
% path where the OCIA related things should be saved (OCIA object itself, data, plots, etc.)
this.path.OCIASave = 'C:/Users/laurenczy/Documents/LabVIEW Data/OCIA/';
% path where the intrinsic data should be saved
this.path.intrSave = sprintf('C:/Users/laurenczy/Documents/LabVIEW Data/%s/wideField/', datestr(date, 'yyyy_mm_dd'));

% windows position
this.GUI.pos = [5, 50, 1265, 950];

end
