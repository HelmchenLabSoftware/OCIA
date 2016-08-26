function this = OCIA_config_batchAnalysis_wideField(this)
% OCIA_config_batchAnalysis_wideField - "batchAnalysis_wideField" OCIA configuration file
%
%       this = OCIA('batchAnalysis_wideField')
%
% Configuration file for OCIA using the "batchAnalysis_wideField" configuration. This function should not be called directly
%   but rather using the "this = OCIA('batchAnalysis_wideField');" syntax to launch the software with this configuration.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the default configuration
configHandle = str2func('OCIA_config_default');
this = configHandle(this);

% load widefield config
this = OCIA_config_widefield(this);

%% - input parameters
this.main.startFunctionName = 'analysisPipeline_wideField';

end
