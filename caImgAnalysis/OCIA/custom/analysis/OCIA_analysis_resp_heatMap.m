function OCIA_analysis_resp_heatMap(this, iDWRows)

%% plotting parameter UI controls
paramConf = cell2table({ ...
... categ  id                   UIType      valueType               UISize  isLabAbove      label           tooltip
    'img', 'plotLimits',        'text',     { 'array' },            [1 0],  false,          'Plot limits',  'Adjust the limits of the plot (color limit).';
    'img', 'colormap',          'dropdown', { 'gray', 'hot', 'gray_reverse', 'red_white_blue', 'jet' }', ...
                                                                    [1 0],  false,          'Colormap',     'Changes the coloring scheme (color map).';
    'img', 'showTrials',        'dropdown', { 'true', 'false' }',   [1 0],  false,          'Show trials',  'Specifies whether to show the single trials or only the mean';
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
[nStimTypes, ~, nROIs] = size(ROIRespTrial);

% remove some options from the analysis parameters
this.GUI.an.paramPanConfig({ 'averageROI' }, :) = [];

% rename stim IDs
stimIDs = OCIA_analysis_renameStimIDs(stimIDs);

% use specified plot limits
plotLimits = this.an.img.plotLimits;

% if showing the single trials is required
if this.an.img.showTrials;
    ROIResps = ROIRespTrial;
    % if no plot limits specified, fix lower end
    if isempty(plotLimits);
        plotLimits = [-1 max(ROIResps(:)) * 0.9];
    end;
else
    % get the mean responsiveness for each ROI
    ROIResps = reshape(nanmean(ROIRespTrial, 2), nStimTypes, 1, nROIs);
    ROIResps(ROIResps < 0) = NaN;
end;

% abort if no data
if isempty(ROIResps);
    ANShowHideMessage(this, 1, 'No data to show.');
    return;
end;

%% plot
ANShowHideMessage(this, 1, 'Plotting ...');
plotTic = tic; % for performance timing purposes
plotROIStatHeatMap(this.GUI.handles.an.axe, ROIResps, stimIDs, '', ROINames, plotLimits, this.an.img.colormap, 'DFF/DRR [%]', '');
o('#%s: plot done (%3.1f sec).', mfilename(), toc(plotTic), 2, this.verb);

% % make NaNs appear red
% cMap = get(this.GUI.figH, 'Colormap');
% cMap(1, :) = [1, 0, 0];
% colormap(this.GUI.handles.an.axe, cMap); close(gcf);
        
% hide the message and show plot
ANShowHideMessage(this, 0, 'Update analyser plot done.');
    
end
