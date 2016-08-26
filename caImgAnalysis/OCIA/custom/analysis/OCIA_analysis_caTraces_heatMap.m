function OCIA_analysis_caTraces_heatMap(this, iDWRows)
% OCIA_analysis_caTraces_heatMap - [no description]
%
%       OCIA_analysis_caTraces_heatMap(this, iDWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% plotting parameter UI controls
paramConf = cell2table({ ...
... categ  id                   UIType      valueType               UISize      isLabAbove      label           tooltip
    'img', 'plotLimits',        'text',     { 'array' },            [0.75 0],      false,          'Plot limits',  'Adjust the limits of the plot (color limit).';
    'img', 'colormap',          'dropdown', { 'gray', 'hot', 'gray_reverse', 'red_white_blue', 'jet' }', ...
                                                                    [0.75 0],      false,          'Colormap',     'Changes the coloring scheme (color map).';
}, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);
% append the new configuration to the table and update the row names using the ids
this.GUI.an.paramPanConfig = [this.GUI.an.paramPanConfig; paramConf];
this.GUI.an.paramPanConfig.Properties.RowNames = this.GUI.an.paramPanConfig.id;

%% get the data
% force the ROI combination to be true
this.an.img.combineROIs = true;
% get the concatenated trace (raw and filtered), the stimuli, the selected ROI names and the time vector
[~, concatStims, concatCaTracesSGFilt, ROINames, t] = OCIA_analysis_getConcatCaData(this, iDWRows);

% remove some option from the analysis parameters
this.GUI.an.paramPanConfig('combineROIs', :) = [];

% get the stimulus IDs to use
stimIDs = this.an.img.selStimIDs;
stimIDs = regexprep(reshape(stimIDs, 1, numel(stimIDs)), '_', ' ');
% rename stim IDs
stimIDs = OCIA_analysis_renameStimIDs(stimIDs);

%% plot
ANShowHideMessage(this, 1, 'Plotting ...');
plotTic = tic; % for performance timing purposes
plotCaTracesHeatMap(this.GUI.handles.an.axe, 0, '', [], concatCaTracesSGFilt, concatStims, ...
    stimIDs, ROINames, t, [], this.an.img.plotLimits, this.an.img.colormap);
o('#%s: plot done (%3.1f sec).', mfilename(), toc(plotTic), 2, this.verb);

% hide the message and show plot
ANShowHideMessage(this, 0, 'Update analyser plot done.');

end
