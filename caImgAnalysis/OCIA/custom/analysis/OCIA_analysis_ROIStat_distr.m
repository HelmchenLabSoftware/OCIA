function OCIA_analysis_ROIStat_distr(this, iDWRows)

%% plotting parameter UI controls
paramConf = cell2table({ ...
... categ  id                   UIType      valueType               UISize      isLabAbove  label           tooltip
    'img', 'plotLimits',        'text',     { 'array' },            [0.75 0],   false,      'Plot limits',  'Adjust the limits of the plot (color limit).';
    'img', 'ROIRespThresh',     'text',     { 'numeric' },          [0.75 0],   false,      'Resp. thresh.', 'Minimum responsiveness value for a ROI to be included in the analysis.';
    'img', 'selDispStimIDs',    'list',     { },                    [2 2],      true,       'Displ. stimIDs', 'Selection of stimuli for display.';
    'img', 'ROIStat',           'dropdown', { 'responsiveness', 'response time', 'SI', 'd''' }, ...
                                                                    [0.75 0],   false,      'ROI Prop.',    'Selects which ROI statistic should be plotted/analyzed.';
    'img', 'ROIStatPlotType',   'dropdown', { 'distribution', 'histogram', 'cumDistr' }, ...
                                                                    [0.75 0],   false,      'Plot type',    'Defines which type of plot should be done: a scatter plot (distribution) or a histogram.';
    'img', 'groupBy',           'dropdown', { 'ROI', 'day', 'stimType', 'PSPer', 'stimTypePSPer' }, ...
                                                                    [1 0], false, 'Grouping type',   'Defines how to group the data (second grouping).';
    'img', 'groupBy2',          'dropdown', { 'ROI', 'day', 'stimType', 'PSPer', 'stimTypePSPer', 'none' }, ...
                                                                    [1 0], false, 'Grouping type 2', 'Defines how to group the data (second grouping).';
}, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);
% append the new configuration to the table and update the row names using the ids
this.GUI.an.paramPanConfig = [this.GUI.an.paramPanConfig; paramConf];
this.GUI.an.paramPanConfig.Properties.RowNames = this.GUI.an.paramPanConfig.id;

%% get the imaging data
ANShowHideMessage(this, 1, 'Loading data ...');
loadDataTic = tic; % for performance timing purposes

% do not combine ROIs
this.an.img.combineROIs = false;
this.an.img.averageROI = false;
% no sorting
this.an.img.sortMethod = 'none';
this.an.img.sortDirection = 'descending';
this.an.img.sortStim = 'low';

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
% get the output stats, the selected ROI names and the time vector
[PSCaTracesStats, ROINames, ~] = OCIA_analysis_getPSCaTraceStats(this, iDWRows, PSCaTraces, ROINames, stimIDs);

% fix double underscore bug
ROINames = regexprep(ROINames, '__', '_');

% if there is a threshold for remove non-responsive ROIs, use it
if ~isempty(this.an.img.ROIRespThresh);
    % get the non-responsive ROIs
    nonRespROIResps = PSCaTracesStats.ROIRespTrial < this.an.img.ROIRespThresh;
    % remove them (by setting them to NaN)
    PSCaTracesStats.ROIRespTrial(nonRespROIResps) = NaN;
end;

% remove some option from the analysis parameters
this.GUI.an.paramPanConfig({ 'combineROIs', 'averageROI', 'sortMethod', 'sortDirection', 'sortStim' }, :) = [];

% get the stimulus IDs to use
stimIDs = regexprep(reshape(stimIDs, 1, numel(stimIDs)), '_', ' ');

%% update the analysis parameters
% set the stimulus selection in the param. config to be displayed
this.GUI.an.paramPanConfig{'selDispStimIDs', 'valueType'} = { stimIDs };

if ~isfield(this.an.img, 'selDispStimIDs');
    this.an.img.selDispStimIDs = [];
end;
if ~isfield(this.an.img, 'groupBy2');
    this.an.img.groupBy2 = 'none';
end;

% if no display stimulus ID selected, select them all
selDispStimIDs = this.an.img.selDispStimIDs;
if isempty(selDispStimIDs);
    selDispStimIDs = stimIDs;
    this.an.img.selDispStimIDs = stimIDs;
end;

% get the list of indexes selected stimulus IDs for display
[~, stimIDIndexes] = ismember(selDispStimIDs, stimIDs);
% if nothing selected or only zeros, select all
if isempty(stimIDIndexes) || sum(stimIDIndexes) == 0; stimIDIndexes = 1 : numel(selDispStimIDs); end;

% check that exactly 2 stimuli have to be selected for SI and d' calculation
if ismember(this.an.img.ROIStat, { 'SI', 'd''' }) && numel(stimIDIndexes) ~= 2;
    ANShowHideMessage(this, 1, sprintf('Problem during plotting: for property "%s", exactly 2 stimuli have to be selected.', ...
        this.an.img.ROIStat));
    return;
end;
% check that exactly 2 stimuli have to be selected for SI and d' calculation
if ismember(this.an.img.ROIStat, { 'SI', 'd''' }) && strcmp(this.an.img.groupBy, 'stimType');
    ANShowHideMessage(this, 1, sprintf('Problem during plotting: grouping by stimulus type for property "%s" is not possible.', ...
        this.an.img.ROIStat));
    return;
end;

% rename stim IDs
stimIDs = OCIA_analysis_renameStimIDs(stimIDs);
selDispStimIDs = OCIA_analysis_renameStimIDs(selDispStimIDs);

% get the ROI statistic
[ROIStat, yLab] = OCIA_analysis_getROIStat(this.an.img.ROIStat, this.an.img.respMethod, PSCaTracesStats, stimIDIndexes, stimIDs);

% get the grouping n°1
[grouping1, groupLabels1] = OCIA_analysis_getGrouping(this, iDWRows, stimIDIndexes, selDispStimIDs, this.an.img.groupBy, ROINames);
% get the grouping n°2
[grouping2, groupLabels2] = OCIA_analysis_getGrouping(this, iDWRows, stimIDIndexes, selDispStimIDs, this.an.img.groupBy2, ROINames);

% concatenate the grouping variables
grouping = { grouping1, grouping2 };
groupLabels = { groupLabels1, groupLabels2 };

% plot limits
plotLims = this.an.img.plotLimits;

%% plot
ANShowHideMessage(this, 1, 'Plotting ...');
plotTic = tic; % for performance timing purposes
switch this.an.img.ROIStatPlotType;
    case 'distribution';
        plotROIStatScatter(this.GUI.handles.an.axe, ROIStat, grouping, groupLabels, '', plotLims, yLab, '');
    case 'histogram';
        plotROIStatHist(this.GUI.handles.an.axe, ROIStat, grouping, groupLabels, '', plotLims, yLab, '');
    case 'cumDistr';
        plotROIStatCumDistr(this.GUI.handles.an.axe, ROIStat, grouping, groupLabels, '', plotLims, yLab, '', 'dotted95%CIStairs');
end;
o('#%s: plot done (%3.1f sec).', mfilename(), toc(plotTic), 2, this.verb);

        
% hide the message and show plot
ANShowHideMessage(this, 0, 'Update analyser plot done.');
    
end