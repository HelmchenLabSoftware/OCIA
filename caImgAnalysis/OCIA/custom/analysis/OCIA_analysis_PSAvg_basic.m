function OCIA_analysis_PSAvg_basic(this, iDWRows)
% OCIA_analysis_PSAvg_basic - [no description]
%
%       OCIA_analysis_PSAvg_basic(this, iDWRows)
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
% get the per-stimulus calcium traces
[PSCaTraces, ROINames, stimIDs] = OCIA_analysis_getPSCaTracesMatrix(this, iDWRows);
% get the size of the dataset
[nStimTypes, nStims, nROIs, ~] = size(PSCaTraces);

showMessage(this, sprintf('Loading data done (%3.1f sec).', toc(loadDataTic)));

% abort if no data
if isempty(PSCaTraces);
    ANShowHideMessage(this, 1, 'No data to show.');
    return;
end;

% check data consistency
if nStimTypes + nStims + nROIs == 3;
    ANShowHideMessage(this, 1, 'Problem during plotting: cannot average a single ROI on a single Trial.');
    return;
end;

%% prepare data
% get the stimulus IDs to use
stimIDs = regexprep(reshape(stimIDs, 1, numel(stimIDs)), '_', ' ');

% make sure data is not sorted
this.an.img.sortMethod = 'none';

% get the output stats, the selected ROI names and the time vector
[PSCaTracesStats, ROINames, t] = OCIA_analysis_getPSCaTraceStats(this, iDWRows, PSCaTraces, ROINames, stimIDs);
PSCaTraceMeans = PSCaTracesStats.PSCaTraceMeans;
PSCaTraceErrors = PSCaTracesStats.PSCaTraceErrors;
NStims = PSCaTracesStats.NStims;

% rename stim IDs
stimIDs = OCIA_analysis_renameStimIDs(stimIDs);

% remove some option from the analysis parameters
this.GUI.an.paramPanConfig({ 'respMethod', 'sortMethod', 'sortDirection', 'sortStim' }, :) = [];

% check data consistency
if numel(ROINames) > 16 && ~this.an.img.averageROI;
    ANShowHideMessage(this, 1, 'Problem during plotting: cannot show single averages of ROI for more than 16 ROIs.');
    return;
end;

if numel(ROINames) == 0;
    ANShowHideMessage(this, 1, 'Problem during plotting: selected ROIs are excluded from the analysis.');
    return;
end;

if isempty(PSCaTraceMeans);
    ANShowHideMessage(this, 1, 'Problem during plotting: no data to show.');
    return;
end;

% if not averaging nor combining ROIs, check for changing the names of the ROIs
if this.an.img.averageROI && ~this.an.img.combineROIs;
    % get the clean version of the ROI names without the 'RSXX_' tag
    cleanROINames = regexprep(ROINames, 'RS\d+_', '');
    % get the grouping from ROISet number
    ROISetIndexes = cellfun(@(ROIName)str2double(regexprep(regexp(ROIName, 'RS\d+_', 'match'), '[^\d]', '')), ROINames);
    % get the days from the rows and from the ROISet IDs
    allDays = regexprep(unique(get(this, iDWRows, 'day')), '_', '');
    allROISetsDays = regexprep(unique(get(this, iDWRows, 'ROISet')), '_\d+$', '');
    % re-map the grouping using the actual unique days
    for iROISetDay = 1 : numel(allROISetsDays);
        ROISetIndexes(ROISetIndexes == iROISetDay) = find(strcmp(allROISetsDays{iROISetDay}, allDays));    
    end;

%     % get the group labels phases
%     uniquePhases = { 'baseline', 'naïve', 'expert', 'lateExpert' };
    % create the new names
    for iName = 1 : numel(ROINames);
%         ROINames{iName} = sprintf('%s %s', cleanROINames{iName}, uniquePhases{ROISetIndexes(iName)});
        ROINames{iName} = sprintf('%s %s', cleanROINames{iName}, allROISetsDays{ROISetIndexes(iName)});
    end;    
end;

%% plot
ANShowHideMessage(this, 1, 'Plotting ...');
plotTic = tic; % for performance timing purposes
plotPeriStimAverage(this.GUI.handles.an.axe, PSCaTraceMeans, PSCaTraceErrors, NStims, ROINames, t, ...
    this.an.img.plotLimits, stimIDs, '', []);
%     this.an.img.plotLimits, stimIDs, '', PSCaTraces);
o('#%s: plot done (%3.1f sec).', mfilename(), toc(plotTic), 2, this.verb);
        
% hide the message and show plot
ANShowHideMessage(this, 0, 'Update analyser plot done.');

end
