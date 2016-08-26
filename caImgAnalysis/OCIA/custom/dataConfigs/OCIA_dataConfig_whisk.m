function this = OCIA_dataConfig_whisk(this)
% OCIA_dataConfig_whisk - [no description]
%
%       OCIA_dataConfig_whisk(this)
%
% Adds the whisker data structures to the OCIA.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% whisker data type

% defines the data storage options
this.main.dataConfig = [this.main.dataConfig; cell2table({ ...
...     rowType         id              shortLabel      label                               saveFormat  defaultOn
        'Imaging data', 'whisk',        'Whisk.',       'Whisking data',                    'HDF5',     true;
}, 'VariableNames', this.main.dataConfig.Properties.VariableNames)];

% define the analysis parameters for this data type
this.an.whisk = struct();

% scaling of the whisker traces for display
this.an.whisk.traceScaling = 50;
% whisker trace to use for stimulus vector generation
this.an.whisk.selWhiskTraceType = 'exploratory';
% whisker trace to use for cross correlation
this.an.whisk.selCCWhiskTraceType = 'raw';
% whisker trace to show
this.an.whisk.shownWhiskTraceType = { 'raw', 'envelope', 'amplitude', 'set point', 'exploratory', 'foveal' };
% starting time in seconds after which to look for stims for construction of whisk stim. vector
this.an.whisk.stimVectMinStartTime = 3;
% minimum peak height (in number of STD above mean) for construction of whisk stim. vector
this.an.whisk.stimVectPeakSTDThresh = 0.7;
% minimum inter-peak distance in seconds for construction of whisk stim. vector
this.an.whisk.stimVectInterPeakDistThresh = 1.5;
% array of the rows for which a debuging plot should be plotted
this.an.whisk.stimVectDbgPlotRows = [];
% fraction of the peak that we must go below to find the onset of the peak
this.an.whisk.stimVectPeakStartThreshold = 0.1;

end
