function OCIA_analysis_PSAvg_heatMap(this, iDWRows)
% OCIA_analysis_PSAvg_heatMap - [no description]
%
%       OCIA_analysis_PSAvg_heatMap(this, iDWRows)
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

%% get the imaging data
ANShowHideMessage(this, 1, 'Loading data ...');
loadDataTic = tic; % for performance timing purposes
% get the per-stimulus calcium traces
[PSCaTraces, ROINames, stimIDs] = OCIA_analysis_getPSCaTracesMatrix(this, iDWRows);
% get the size of the dataset
[nStimTypes, nStims, nROIs, nPSFrames] = size(PSCaTraces); %#ok<NASGU>

showMessage(this, sprintf('Loading data done (%3.1f sec).', toc(loadDataTic)));

% abort if no data
if isempty(PSCaTraces);
    ANShowHideMessage(this, 1, 'No data to show.');
    return;
end;

% check data consistency
if nStimTypes + nStims == 2;
    ANShowHideMessage(this, 1, 'Problem during plotting: cannot show this plot for a single Trial.');
    return;
end;

%% prepare data
% get the stimulus IDs to use
stimIDs = regexprep(reshape(stimIDs, 1, numel(stimIDs)), '_', ' ');

if nROIs == 1;
    ANShowHideMessage(this, 1, 'Problem during plotting: cannot show this plot for a single ROI.');
    return;
end;

% force ROIs not to be averaged together
this.an.img.averageROI = false;

% get the output stats, the selected ROI names and the time vector
[PSCaTracesStats, ROINames, t] = OCIA_analysis_getPSCaTraceStats(this, iDWRows, PSCaTraces, ROINames, stimIDs);
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
plotPeriStimAverageHeatMap(this.GUI.handles.an.axe, PSCaTraceMeans, t, stimIDs, '', ROINames, ...
    this.an.img.plotLimits, this.an.img.colormap, NStims, 'DFF/DRR [%]');
o('#%s: plot done (%3.1f sec).', mfilename(), toc(plotTic), 2, this.verb);
        
% hide the message and show plot
ANShowHideMessage(this, 0, 'Update analyser plot done.');
    
end
