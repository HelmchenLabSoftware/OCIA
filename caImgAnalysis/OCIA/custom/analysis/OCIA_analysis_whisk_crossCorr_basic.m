function OCIA_analysis_whisk_crossCorr_basic(this, iDWRows)
% OCIA_analysis_whisk_crossCorr_basic - [no description]
%
%       OCIA_analysis_whisk_crossCorr_basic(this, iDWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

ANShowHideMessage(this, 1, 'This analysis is not yet implemented.');
return;

%% plotting parameter UI controls
paramConf = cell2table({ ...
... categ  id                   UIType      valueType               UISize      isLabAbove      label           tooltip
    'img', 'plotLimits',        'text',     { 'array' },            [1 0],      false,          'Plot limits',  'Adjust the limits of the plot (color limit).';
    'img', 'colormap',          'dropdown', { 'gray', 'hot', 'gray_reverse', 'red_white_blue', 'jet' }', ...
                                                                    [1 0],      false,          'Colormap',     'Changes the coloring scheme (color map).';
    'whisk',    'selCCWhiskTraceType',  'dropdown',   {},           [1 0],      false, ...
        'Whisk trace',        'Select which whisker trace should be used to do the cross correlation.';
    'img', 'sortDirection',     'dropdown', { 'ascending', 'descending' }, [1 0], false,    'Sorting direction',    'Sorting direction (highest response top or bottom).';
    'img', 'sortMethod',        'dropdown', { 'none', 'mean', 'max' }, ...
                                                                        [1 0],  false,          'Sorting method',       'Statistic to use to define the sorting order.';
}, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);
% append the new configuration to the table and update the row names using the ids
this.GUI.an.paramPanConfig = [this.GUI.an.paramPanConfig; paramConf];
this.GUI.an.paramPanConfig.Properties.RowNames = this.GUI.an.paramPanConfig.id;

%% get the data
% get the concatenated trace (raw and filtered), the stimuli, the selected ROI names and the time vector
[concatCaTraces, ~, ~, ROINames, ~] = OCIA_analysis_getConcatCaData(this, iDWRows);
% abort if no traces came out
if isempty(concatCaTraces); return; end;
% get the matrix of the whisker traces
[whiskTraces, whiskStimVect, whiskTraceTypes] = OCIA_analysis_getWhiskTraces(this, iDWRows);

whiskTraceTypes = [ whiskTraceTypes, 'stim. vector' ];

%% update parameter pannel
this.GUI.an.paramPanConfig(ismember(this.GUI.an.paramPanConfig.id, { 'selWhiskTraceType', ...
    'stimVectMinStartTime', 'stimVectPeakSTDThresh', 'stimVectInterPeakDistThresh', ...
    'stimVectInterPeakDistThresh', 'stimVectPeakStartThreshold', 'stimVectDbgPlotRows' }), :) = [];

this.GUI.an.paramPanConfig(ismember(this.GUI.an.paramPanConfig.id, { 'selStimTypeGroups', ...
    'selStimIDs', 'allStimIDs', 'noisyTrialsThresh', 'sgFiltFrameSize', 'exclFrames', 'combineROIs' }), :) = [];

this.GUI.an.paramPanConfig{'selCCWhiskTraceType', 'valueType'} = { whiskTraceTypes };  

%% do analysis

% get which whisker trace should be used for stim vector
if isempty(this.an.whisk.selCCWhiskTraceType) || ~ismember(this.an.whisk.selCCWhiskTraceType, whiskTraceTypes);
    this.an.whisk.selCCWhiskTraceType = 'stim. vector';
elseif iscell(this.an.whisk.selCCWhiskTraceType) && numel(this.an.whisk.selCCWhiskTraceType) > 1;
    this.an.whisk.selCCWhiskTraceType = this.an.whisk.selCCWhiskTraceType{1};
end;

% get index
iWhiskTypeToUse = find(strcmp(whiskTraceTypes, this.an.whisk.selCCWhiskTraceType));

% get the whisker trace to use
if iWhiskTypeToUse > size(whiskTraces, 1);
    whiskTrace = whiskStimVect;
    % extend the whisker traces by one frame at the end to be aligned to the calcium traces
    %   (this is also done on the calcium traces)
    whiskTrace = [whiskTrace, zeros(size(whiskTrace, 1), 1)];
else
    whiskTrace = whiskTraces{iWhiskTypeToUse};
    % extend the whisker traces by one NaN frame at the end to be aligned to the calcium traces
    %   (this is also done on the calcium traces)
    whiskTrace = [whiskTrace, nan(size(whiskTrace, 1), 1)];
end;

% concatenate the whisker traces
whiskTrace = reshape(whiskTrace', 1, numel(whiskTrace));

% get the number of ROIs
nROIs = numel(ROINames);

lagTime = 5; % in seconds
lagFrames = lagTime * this.an.img.defaultFrameRate;

% perform cross correlation on each ROI
xcfROIs = nan(1, nROIs, lagFrames * 2 + 1);
parfor iROI = 1 : nROIs;
    nanMask = isnan(whiskTrace) | isnan(concatCaTraces(iROI, :));
    xcf = crosscorr(whiskTrace(~nanMask), concatCaTraces(iROI, ~nanMask), lagFrames); %#ok<PFBNS>
    xcfROIs(1, iROI, :) = xcf;
end;

% get time vector
t = (-lagFrames : lagFrames) / this.an.img.defaultFrameRate;

%% sort
% get the sorting parameters
sortMethod = this.an.img.sortMethod;
sortDirection = iff(strcmp(this.an.img.sortDirection, 'ascending'), -1, 1);

% if sorting is required
if ~isempty(this.an.img.sortMethod) && ~strcmp(this.an.img.sortMethod, 'none');
    sortTic = tic; % for performance timing purposes
    
    % get the evoked evoked activity for the sorting stimulus
    xcfROIsEvoked = reshape(xcfROIs(1, :, t > 0), [nROIs, sum(t > 0)]);

    % get sorted values with the specified method on the specified stimulus
    if strcmp(sortMethod, 'mean');
        sortValues = nanmean(xcfROIsEvoked, 2);
    elseif strcmp(sortMethod, 'max');
        sortValues = max(xcfROIsEvoked, [], 2);
    else
        sortValues = [];
    end;

    % if there is something to sort
    if ~isempty(sortValues);
        [~, sortIndexes] = sort(sortDirection * sortValues);
        % apply the sorting
        xcfROIs = xcfROIs(:, sortIndexes, :);
        ROINames = ROINames(sortIndexes);
    end;
    o('#%s: sorting done (%3.1f sec).', mfilename(), toc(sortTic), 2, this.verb);
end;


%% plot

plotPeriStimAverageHeatMap(this.GUI.handles.an.axe, xcfROIs, t, whiskTraceTypes(iWhiskTypeToUse), '', ROINames, ...
    this.an.img.plotLimits, this.an.img.colormap, [], 'Cross-corr.');


% hide the message and show plot
ANShowHideMessage(this, 0, 'Update analyser plot done.');

end
