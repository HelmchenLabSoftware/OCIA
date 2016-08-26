function OCIA_analysis_whiskPSAvg_basic(this, iDWRows)
% OCIA_analysis_whiskPSAvg_basic - [no description]
%
%       OCIA_analysis_whiskPSAvg_basic(this, iDWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% plotting parameter UI controls
paramConf = cell2table({ ...
... categ  id                   UIType      valueType               UISize  isLabAbove      label                   tooltip
    'img', 'plotLimits',        'text',     { 'array' },            [1 0],  false,          'Plot limits',          'Adjust the Y-axis limits of the plot.';
}, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);
% append the new configuration to the table and update the row names using the ids
this.GUI.an.paramPanConfig = [this.GUI.an.paramPanConfig; paramConf];
this.GUI.an.paramPanConfig.Properties.RowNames = this.GUI.an.paramPanConfig.id;

%% get the imaging data
ANShowHideMessage(this, 1, 'Loading data ...');
loadDataTic = tic; % for performance timing purposes
% get the per-stimulus whisker traces
[PSWhiskTraces, whiskNames, stimIDs] = OCIA_analysis_getPSWhiskTraceMatrix(this, iDWRows);
% get the size of the dataset
[nStimTypes, nStims, nWhiskTraces, ~] = size(PSWhiskTraces);

showMessage(this, sprintf('Loading data done (%3.1f sec).', toc(loadDataTic)));

% abort if no data
if isempty(PSWhiskTraces);
    ANShowHideMessage(this, 1, 'No data to show.');
    return;
end;

% check data consistency
if nStimTypes + nStims + nWhiskTraces == 3;
    ANShowHideMessage(this, 1, 'Problem during plotting: cannot average a single trace on a single Trial.');
    return;
end;

%% prepare data
% get the stimulus IDs to use
stimIDs = regexprep(reshape(stimIDs, 1, numel(stimIDs)), '_', ' ');

% make sure data is not sorted
this.an.img.sortMethod = 'none';

% get the output stats, the selected ROI names and the time vector
[PSCaTracesStats, whiskNames, t] = OCIA_analysis_getPSCaTraceStats(this, iDWRows, PSWhiskTraces, whiskNames, stimIDs);
PSCaTraceMeans = PSCaTracesStats.PSCaTraceMeans;
PSCaTraceErrors = PSCaTracesStats.PSCaTraceErrors;
NStims = PSCaTracesStats.NStims;

% rename stim IDs
stimIDs = OCIA_analysis_renameStimIDs(stimIDs);

% remove some option from the analysis parameters
this.GUI.an.paramPanConfig({ 'respMethod', 'sortMethod', 'sortDirection', 'sortStim' }, :) = [];

% check data consistency
if numel(whiskNames) > 16 && ~this.an.img.averageROI;
    ANShowHideMessage(this, 1, 'Problem during plotting: cannot show single averages of trace for more than 16 traces.');
    return;
end;

if numel(whiskNames) == 0;
    ANShowHideMessage(this, 1, 'Problem during plotting: selected traces are excluded from the analysis.');
    return;
end;

if isempty(PSCaTraceMeans);
    ANShowHideMessage(this, 1, 'Problem during plotting: no data to show.');
    return;
end;

%% plot
ANShowHideMessage(this, 1, 'Plotting ...');
plotTic = tic; % for performance timing purposes
plotPeriStimAverage(this.GUI.handles.an.axe, PSCaTraceMeans, PSCaTraceErrors, NStims, whiskNames, t, ...
    this.an.img.plotLimits, stimIDs, '', [], 'Whisker angle');
%     this.an.img.plotLimits, stimIDs, '', PSCaTraces);
o('#%s: plot done (%3.1f sec).', mfilename(), toc(plotTic), 2, this.verb);
        
% hide the message and show plot
ANShowHideMessage(this, 0, 'Update analyser plot done.');

end
