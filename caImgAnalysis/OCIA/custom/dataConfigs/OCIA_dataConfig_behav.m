function this = OCIA_dataConfig_behav(this)
% OCIA_dataConfig_behav - [no description]
%
%       OCIA_dataConfig_behav(this)
%
% Adds the behavior data structures to the OCIA.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)


%% behavior data type

% defines the data storage options
this.main.dataConfig = [this.main.dataConfig; cell2table({ ...
...     rowType             id                  shortLabel              label                     saveFormat    defaultOn
        'Behavior data',    'behav',            'Behav. data (raw)',    'Behavior data (raw)',    'HDF5',       false;
}, 'VariableNames', this.main.dataConfig.Properties.VariableNames)];

% define the analysis parameters for this data type
this.an.be = struct();
this.an.be.nTrialsSkip = [3, 3];
this.an.be.nMinRespTrialSkip = [4, 7];

this.an.be.binWidth = 150;
this.an.be.behavVarToPlot = { 'days', 'session', 'training phase', 'hit rate - session', ...
    'false alarm rate - session', 'performance (d'') - session' };
this.an.be.miceInfoFilePath = '';
this.an.be.plotLims = [];
this.an.be.PSPer = [-3 6];
this.an.be.includeEO = true;

this.an.be.anInSampleRate = 3000;

this.an.be.selTimes = { 'sound', 'lightCueOn', 'respTime' };
this.an.be.allTimes = { 'imgStart', 'sound', 'lightCueOn', 'respTime', 'lightCueOff' };
this.an.be.selTrialTypes = { 'hit', 'CR', 'FA', 'miss', 'early', 'auto' };
this.an.be.allTrialTypes = { 'hit', 'CR', 'FA', 'miss', 'early', 'auto' };
this.an.be.sgFiltFrameSize = 51;
this.an.be.plotLimits = [0.002, 0.0021];
this.an.be.colormap = 'gray_reverse';

this.an.be.normTrialsPrctile = [75.001, 75.002];

this.an.be.groupBehavVar = { };

% storage for the cached data
this.an.be.dataHash = struct();

end
