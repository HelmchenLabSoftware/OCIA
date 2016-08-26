function OCIA_analysis_whiskPSAvg_heatMap(this, iDWRows)
% OCIA_analysis_whiskPSAvg_heatMap - [no description]
%
%       OCIA_analysis_whiskPSAvg_heatMap(this, iDWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% plotting parameter UI controls
paramConf = cell2table({ ...
... categ  id                   UIType      valueType               UISize      isLabAbove      label           tooltip
    'img', 'plotLimits',        'text',     { 'array' },            [1 0],      false,          'Plot limits',  'Adjust the limits of the plot (color limit).';
    'img', 'colormap',          'dropdown', { 'gray', 'hot', 'gray_reverse', 'red_white_blue', 'jet' }', ...
                                                                    [1 0],      false,          'Colormap',     'Changes the coloring scheme (color map).';
}, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);
% append the new configuration to the table and update the row names using the ids
this.GUI.an.paramPanConfig = [this.GUI.an.paramPanConfig; paramConf];
this.GUI.an.paramPanConfig.Properties.RowNames = this.GUI.an.paramPanConfig.id;

%% get the data
ANShowHideMessage(this, 1, 'Loading data ...');
loadDataTic = tic; % for performance timing purposes
% get the per-stimulus whisker traces
[PSWhiskTraces, whiskNames, stimIDs, allROINames] = OCIA_analysis_getPSWhiskTraceMatrix(this, iDWRows);
% get the size of the dataset
[nStimTypes, nStims, nWhiskTraceTypes, nPSFrames] = size(PSWhiskTraces); %#ok<NASGU>

showMessage(this, sprintf('Loading data done (%3.1f sec).', toc(loadDataTic)));

% abort if no data
if isempty(PSWhiskTraces);
    ANShowHideMessage(this, 1, 'No data to show.');
    return;
end;

% check data consistency
if nStimTypes + nStims == 2;
    ANShowHideMessage(this, 1, 'Problem during plotting: cannot show this plot for a single Trial.');
    return;
end;

%% update the analysis parameters
this.an.img.allStimIDs = allROINames';
% remove some option from the analysis parameters
this.GUI.an.paramPanConfig({ 'selROINames', 'sgFiltFrameSize', 'noisyTrialsThresh', 'exclFrames', 'combineROIs' }, :) = [];

%% prepare data
% get the stimulus IDs to use
stimIDs = regexprep(reshape(stimIDs, 1, numel(stimIDs)), '_', ' ');

if nWhiskTraceTypes == 1;
    ANShowHideMessage(this, 1, 'Problem during plotting: cannot show this plot for a single ROI.');
    return;
end;

% force ROIs not to be averaged together
this.an.img.averageROI = false;

% get the output stats, the selected ROI names and the time vector
[PSCaTracesStats, whiskNames, t] = OCIA_analysis_getPSCaTraceStats(this, iDWRows, PSWhiskTraces, whiskNames, stimIDs);
PSCaTraceMeans = PSCaTracesStats.PSCaTraceMeans;
NStims = PSCaTracesStats.NStims;

% rename stim IDs
stimIDs = OCIA_analysis_renameStimIDs(stimIDs);

% remove some options from the analysis parameters
this.GUI.an.paramPanConfig({ 'averageROI', 'respMethod' }, :) = [];

if isempty(PSCaTraceMeans);
    ANShowHideMessage(this, 1, 'Problem during plotting: no data to show.');
    return;
end;

%% plot
ANShowHideMessage(this, 1, 'Plotting ...');
plotTic = tic; % for performance timing purposes
plotPeriStimAverageHeatMap(this.GUI.handles.an.axe, PSCaTraceMeans, t, stimIDs, '', fliplr(whiskNames), ...
    this.an.img.plotLimits, this.an.img.colormap, NStims, 'Whisker angle');
o('#%s: plot done (%3.1f sec).', mfilename(), toc(plotTic), 2, this.verb);
        
% hide the message and show plot
ANShowHideMessage(this, 0, 'Update analyser plot done.');
    
end
