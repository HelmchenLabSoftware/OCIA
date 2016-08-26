function OCIA_analysis_whisk_crossCorr_heatMap(this, iDWRows)
% OCIA_analysis_whisk_crossCorr_heatMap - [no description]
%
%       OCIA_analysis_whisk_crossCorr_heatMap(this, iDWRows)
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
    'whisk',    'selCCWhiskTraceType',  'dropdown',   {},           [1 0],      false, ...
        'Whisk trace',        'Select which whisker trace should be used to do the cross correlation.';
    'img', 'sortDirection',     'dropdown', { 'ascending', 'descending' }, [1 0], false,    'Sorting direction',    'Sorting direction (highest response top or bottom).';
    'img', 'sortMethod',        'dropdown', { 'none', 'mean', 'max' }, ...
                                                                        [1 0],  false,          'Sorting method',       'Statistic to use to define the sorting order.';
    'img', 'PSPer',             'text',     { 'cellArray' },        [1 0],  false,          'Peri-stim. per.',    'Peri-stimulus period values for all PS periods (baseline vs. evoked) to display and to use for the analysis.';
    'img', 'PSPerID',           'list',     this.an.img.PSPer(:, 1), [1 3], false,          'Peri-stim. ID',        'Peri-stimulus period to display and to use for the analysis.';
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
    whiskTrace = [whiskTrace, zeros(size(whiskTrace, 1), this.an.img.gapSize)];
else
    whiskTrace = whiskTraces{iWhiskTypeToUse};
    % extend the whisker traces by one NaN frame at the end to be aligned to the calcium traces
    %   (this is also done on the calcium traces)
    whiskTrace = [whiskTrace, nan(size(whiskTrace, 1), this.an.img.gapSize)];
end;

% concatenate the whisker traces
whiskTrace = reshape(whiskTrace', 1, numel(whiskTrace));

% get the number of ROIs
nROIs = numel(ROINames);

% get the currently selected peri-stimulus period
PSPer = cell2mat(this.an.img.PSPer(ismember(this.an.img.PSPer(:, 1), this.an.img.PSPerID), 2 : end));

lagTime = max(PSPer(1), PSPer(4)); % in seconds
lagFrames = lagTime * this.an.img.defaultFrameRate;

% get the data in memory
hashStruct = struct('iDWRows', iDWRows, 'selCCWhiskTraceType', { this.an.whisk.selCCWhiskTraceType }, ...
    'lagTime', lagTime, 'whiskTraceTypes', { whiskTraceTypes }, 'ROINames', { ROINames }, ...
    'frameRate', this.an.img.defaultFrameRate, 'dataType', 'crossCorr');
cachedData = ANGetCachedData(this, 'whisk', hashStruct);

% if the data is not in cache yet, create it
if isempty(cachedData) || iscell(cachedData);
    
    % get time vector
    t = (-lagFrames : lagFrames) / this.an.img.defaultFrameRate;
    
    % perform cross correlation on each ROI
    xcfROIs = nan(1, nROIs, lagFrames * 2 + 1);
    maxCrossCorr = nan(nROIs, 1);
    tMaxCrossCorr = nan(nROIs, 1);
    pVals = nan(nROIs, 1);
    isCorrSignif = nan(nROIs, 1);
    parfor iROI = 1 : nROIs;
        % get a mask for the nan values
        nanMask = isnan(whiskTrace) | isnan(concatCaTraces(iROI, :));
        whiskTraceForROINoNaN = whiskTrace(~nanMask);
        caTraceForROINoNaN = concatCaTraces(iROI, ~nanMask); %#ok<PFBNS>
        % do the cross correlation between the whisker trace and the calcium trace
        xcf = crosscorr(whiskTraceForROINoNaN, caTraceForROINoNaN, lagFrames);
        % store cross correlation values
        xcfROIs(1, iROI, :) = xcf;
        
        % do shuffling to get statistics
        nRepeatsShuffle = 100;
        xcfShuff = zeros(nRepeatsShuffle, lagFrames * 2 + 1);
        for iRepeat = 1 : nRepeatsShuffle;
            caTraceForROINoNaNShuffle = caTraceForROINoNaN(randperm(numel(caTraceForROINoNaN)));
            xcfShuff(iRepeat, :) = crosscorr(whiskTraceForROINoNaN, caTraceForROINoNaNShuffle, lagFrames);
        end

        % extract the mean and standard deviation of the distribution
        [mu, sigma] = normfit(xcfShuff);
        % see where the true correlation value lays in the shuffled distribution
        pVal = 1 - (normcdf(abs(xcf), mu, sigma));
        
        % get best lag time from the significant lag times
        xcfMask = xcf;
        xcfMask(pVal >= 0.05) = NaN;
        % do not used the masked xcf if it is all nans
        if all(isnan(xcfMask));
            isCorrSignif(iROI) = false;
            [~, iMaxVal] = max(abs(xcf));
        else
            isCorrSignif(iROI) = true;
            [~, iMaxVal] = max(abs(xcfMask));
        end;
        % store the best lag time and the correlation at that time
        maxCrossCorr(iROI) = xcf(iMaxVal);
        corrDirection(iROI) = sign(maxCrossCorr(iROI));
        tMaxCrossCorr(iROI) = t(iMaxVal); %#ok<PFBNS>
        % store the p-value at the best lag time
        pVals(iROI) = pVal(iMaxVal);
        
    end;
    
    % store the variables
    cachedData = struct('xcfROIs', xcfROIs, 't', t, 'maxCrossCorr', maxCrossCorr, 'tMaxCrossCorr', tMaxCrossCorr, ...
        'pVals', pVals, 'isCorrSignif', isCorrSignif, 'corrDirection', corrDirection, ...
        'dataType', 'crossCorr', 'params', hashStruct);
    % store the data in memory
    ANStoreCachedData(this, 'whisk', hashStruct, cachedData);

% if data was in memory, fetch it
else
    % fetch the data
    xcfROIs = cachedData.xcfROIs;
    t = cachedData.t;
    maxCrossCorr = cachedData.maxCrossCorr;
    tMaxCrossCorr = cachedData.tMaxCrossCorr;
    pVals = cachedData.pVals;
    isCorrSignif = cachedData.isCorrSignif;
    corrDirection = cachedData.corrDirection;

end;

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
