function OCIA_analysis_SI_heatMap(this, iDWRows)

%% plotting parameter UI controls
paramConf = cell2table({ ...
... categ  id                   UIType      valueType               UISize  isLabAbove      label           tooltip
    'img', 'plotLimits',        'text',     { 'array' },            [1 0],  false,          'Plot limits',  'Adjust the limits of the plot (color limit).';
    'img', 'colormap',          'dropdown', { 'gray', 'hot', 'gray_reverse', 'red_white_blue', 'jet' }', ...
                                                                    [1 0],  false,          'Colormap',     'Changes the coloring scheme (color map).';
}, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);
% append the new configuration to the table and update the row names using the ids
this.GUI.an.paramPanConfig = [this.GUI.an.paramPanConfig; paramConf];
this.GUI.an.paramPanConfig.Properties.RowNames = this.GUI.an.paramPanConfig.id;

%% get the imaging data
ANShowHideMessage(this, 1, 'Loading data ...');
loadDataTic = tic; % for performance timing purposes
% get the per-stimulus calcium traces
[PSCaTraces, ROINames] = OCIA_analysis_getPSCaTracesMatrix(this, iDWRows);
% get the size of the dataset
[nStimTypes, nStims, nROIs, nPSFrames] = size(PSCaTraces); %#ok<NASGU>

showMessage(this, sprintf('Loading data done (%3.1f sec).', toc(loadDataTic)));

% check data consistency
if nStimTypes + nStims == 2;
    ANShowHideMessage(this, 1, 'Problem during plotting: cannot average a single ROI on a single Trial.');
    return;
end;
% check data consistency
if nStimTypes ~= 2;
    ANShowHideMessage(this, 1, 'Problem during plotting: selectivity index SI can only be calculated on 2 stimulus type.');
    return;
end;
if nROIs == 1;
    ANShowHideMessage(this, 1, 'Problem during plotting: cannot show this plot for a single ROI.');
    return;
end;

%% prepare data
% get the averaged peri-stimulus traces, the selected ROI names and the time vector
[~, ~, ROIResps, ~, ROINames, ~] = OCIA_analysis_getPSCaTraceMeans(this, iDWRows, PSCaTraces, ROINames);
% get the size of the dataset
[nStimTypes, ~, nROIs] = size(ROIResps);
ROIResps = reshape(nanmean(ROIResps, 2), nStimTypes, nROIs);

% get the stimulus IDs to use
stimIDs = this.an.img.selStimIDs;
stimIDs = regexprep(reshape(stimIDs, 1, numel(stimIDs)), '_', ' ');

% calculate SI
SI = (ROIResps(1, :) - ROIResps(2, :)) ./ (ROIResps(1, :) + ROIResps(2, :));
SI = reshape(SI, 1, 1, nROIs);

% plot limits
plotLims = this.an.img.plotLimits;
if isempty(plotLims);
    plotLims = [-1 1];
end;

%% plot
plotTic = tic; % for performance timing purposes
plotROIStatHeatMap(this.GUI.handles.an.axe, SI, { }, '', ROINames, plotLims, 'red_white_blue', 'SI', ...
    sprintf('Selectivity Index (SI) \\color{blue}%s\\color{black}/\\color{red}%s', stimIDs{:}));
o('#%s: plot done (%3.1f sec).', mfilename(), toc(plotTic), 2, this.verb);

        
% hide the message and show plot
ANShowHideMessage(this, 0, 'Update analyser plot done.');
    
end
