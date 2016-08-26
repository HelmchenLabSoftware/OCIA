function this = OCIA_dataConfig_behavtext(this)
% OCIA_dataConfig_behavtext - [no description]
%
%       OCIA_dataConfig_behavtext(this)
%
% Adds the behavior data (texture discrimination) structures to the OCIA.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)


%% behavior data type

% defines the data storage options
this.main.dataConfig = [this.main.dataConfig; cell2table({ ...
...     rowType             id                  shortLabel              label                     saveFormat    defaultOn
        'Behavior data',    'behavtext',        'Behav. data (raw)',    'Behavior data (raw)',    'HDF5',       false;
}, 'VariableNames', this.main.dataConfig.Properties.VariableNames)];

% define the analysis parameters for this data type
this.an.be = struct();

% storage for the cached data
this.an.be.dataHash = struct();

end
