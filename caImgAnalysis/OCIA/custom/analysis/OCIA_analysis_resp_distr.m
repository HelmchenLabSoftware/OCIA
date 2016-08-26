function OCIA_analysis_resp_distr(this, iDWRows)

%% plotting parameter UI controls
paramConf = cell2table({ ...
... categ  id                   UIType      valueType               UISize  isLabAbove      label               tooltip
    'img', 'plotLimits',        'text',     { 'array' },            [1 0],  false,          'Plot limits',      'Adjust the limits of the plot (color limit).';
    'img', 'groupBy',           'dropdown', { 'ROI', 'stimType', 'stim' },  [1 0], false,   'Grouping type',    'Defines how to group the data';
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

% check data consistency
if nStimTypes + nStims == 2;
    ANShowHideMessage(this, 1, 'Problem during plotting: cannot average a single ROI on a single Trial.');
    return;
end;
if nROIs == 1;
    ANShowHideMessage(this, 1, 'Problem during plotting: cannot show this plot for a single ROI.');
    return;
end;

%% prepare data
% get the stimulus IDs to use
stimIDs = regexprep(reshape(stimIDs, 1, numel(stimIDs)), '_', ' ');

% make sure not to average ROIs
this.an.img.averageROI = false;

% get the output stats, the selected ROI names and the time vector
[PSCaTracesStats, ROINames, ~] = OCIA_analysis_getPSCaTraceStats(this, iDWRows, PSCaTraces, ROINames, stimIDs);
ROIRespTrial = PSCaTracesStats.ROIRespTrial;
% get the size of the dataset
[nStimTypes, nStims, nROIs] = size(ROIRespTrial);

% rename stim IDs
stimIDs = OCIA_analysis_renameStimIDs(stimIDs);

% remove some option from the analysis parameters
this.GUI.an.paramPanConfig({ 'averageROI', 'sortMethod', 'sortDirection', 'sortStim' }, :) = [];

% use specified plot limits
plotLimits = this.an.img.plotLimits;

% showing the single trials is required
this.an.img.showTrials = true;

% create the grouping variable
switch this.an.img.groupBy;
    case 'ROI';
        grouping = repmat(reshape(1 : nROIs, [1, 1, nROIs]), [nStimTypes, nStims, 1]);
        groupLabels = ROINames;
    case 'stimType';
        grouping = repmat(reshape(1 : nStimTypes, [nStimTypes, 1, 1]), [1, nStims, nROIs]);
        groupLabels = stimIDs;
    case 'stim';
        grouping = repmat(reshape(1 : nStims, [1, nStims, 1]), [nStimTypes, 1, nROIs]);
        groupLabels = 1 : nStims;
end;

% exclude negative responses
ROIRespTrial(ROIRespTrial < -0.5) = NaN;

% create plot limits if none specified
if isempty(plotLimits);
    plotLimits = [-1 max(ROIRespTrial(:))];
end;


%% plot
ANShowHideMessage(this, 1, 'Plotting ...');
plotTic = tic; % for performance timing purposes
plotROIStatScatter(this.GUI.handles.an.axe, ROIRespTrial(:), grouping(:), groupLabels, [], '', plotLimits, ...
    sprintf('%s DFF/DRR [%%]', this.an.img.respMethod), '');
o('#%s: plot done (%3.1f sec).', mfilename(), toc(plotTic), 2, this.verb);
        
% hide the message and show plot
ANShowHideMessage(this, 0, 'Update analyser plot done.');
    
end
