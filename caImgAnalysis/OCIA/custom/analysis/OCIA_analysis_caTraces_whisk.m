function OCIA_analysis_caTraces_whisk(this, iDWRows)
% OCIA_analysis_caTraces_whisk - [no description]
%
%       OCIA_analysis_caTraces_whisk(this, iDWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% plotting parameter UI controls
paramConf = cell2table({ ...
... categ       id                  UIType      valueType       UISize   isLabAbove    label           tooltip
    'img',      'traceTypeToShow',  'dropdown', { 'raw only'; 'filtered only'; 'raw and filtered' }, ...
                                                            [1 0],   false,         'Trace type',   'Selects which traces are displayed in case of filtering.';    
    'whisk',    'traceScaling',     'text',     { 'numeric' },  [1 0],   false,         'Whisk. scale', 'Whiker traces scaling factor (will be multiplied by the number of ROIs).';
    'whisk',    'storeWhiskTraces', 'button',   { @OCIA_analysis_storeStimVectorsFromWhiskTraces }, ...
                                                            [0.8 0],   false,         'Store stim. vect.', 'Stores the displayed stimulus vector as the stimulus vector for the selected rows.';    
    'whisk',    'shownWhiskTraceType', 'list',  { },             [2 2],      true, ...
                                'Shown whisk trace',        'Select which whisker trace should be shown.';
    
}, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);
% append the new configuration to the table and update the row names using the ids
this.GUI.an.paramPanConfig = [this.GUI.an.paramPanConfig; paramConf];
this.GUI.an.paramPanConfig.Properties.RowNames = this.GUI.an.paramPanConfig.id;

%% get the data
% get the concatenated trace (raw and filtered), the stimuli, the selected ROI names and the time vector
[concatCaTraces, ~, concatCaTracesSGFilt, ROINames, t] = OCIA_analysis_getConcatCaData(this, iDWRows);
% abort if no traces came out
if isempty(concatCaTraces); return; end;

% get the matrix of the whisker traces
[whiskTraces, whiskStimVect, whiskTraceTypes] = OCIA_analysis_getWhiskTraces(this, iDWRows);


%% update parameter pannel
this.GUI.an.paramPanConfig{'shownWhiskTraceType', 'valueType'} = { whiskTraceTypes };

%% remove hidden whisker traces
% make sure the one used for stimulus is always selected: get its index
iWhiskTypeToUse = strcmp(whiskTraceTypes, this.an.whisk.selWhiskTraceType);

shownMask = ismember(whiskTraceTypes, this.an.whisk.shownWhiskTraceType);
shownMask(iWhiskTypeToUse) = 1;
whiskTraces(~shownMask) = [];
whiskTraceTypes(~shownMask) = [];

% store the change
this.an.whisk.shownWhiskTraceType = whiskTraceTypes;

% re-update the index
iWhiskTypeToUse = find(strcmp(whiskTraceTypes, this.an.whisk.selWhiskTraceType));

%% process traces
% extend the whisker traces by one NaN frame at the end to be aligned to the calcium traces
%   (this is also done on the calcium traces)
whiskStimVect = [whiskStimVect, zeros(size(whiskStimVect, 1), 1)];
% concatenate the whisker traces
concatStimVect = reshape(whiskStimVect', 1, numel(whiskStimVect));
        
% loop through all whisker traces
for iWhiskType = 1 : size(whiskTraces, 1);
    
    % extend the whisker traces by one NaN frame at the end to be aligned to the calcium traces
    %   (this is also done on the calcium traces)
%     if size(whiskTraces{iWhiskType}, 2) * size(whiskTraces{iWhiskType}, 1) < size(concatCaTraces, 2);
%         whiskTraces{iWhiskType} = [whiskTraces{iWhiskType}, nan(size(whiskTraces{iWhiskType}, 1), 1)];
%     end;
    whiskTraces{iWhiskType} = [whiskTraces{iWhiskType}, nan(size(whiskTraces{iWhiskType}, 1), this.an.img.gapSize)];
    
    % concatenate the whisker traces
    whiskTracesConcat = reshape(whiskTraces{iWhiskType}', 1, numel(whiskTraces{iWhiskType}));
    
    % scale the amplitude of the whisking according to the calcium data
    whiskTracesConcat = linScale(whiskTracesConcat, 0, size(ROINames, 1) * this.an.whisk.traceScaling);
    
    % extend the calcium traces with the whisker traces
    concatCaTraces = [whiskTracesConcat; concatCaTraces]; %#ok<AGROW>
    concatCaTracesSGFilt = [whiskTracesConcat; concatCaTracesSGFilt];%#ok<AGROW>

end;

stimIDs = { '' };

% create color map
ROIColors = jet(size(ROINames, 1) + numel(whiskTraceTypes));
ROIColors(ROIColors > 0.4) = 0.4;
ROIColors(1 : size(whiskTraces, 1), :) = repmat([0 0 0], size(whiskTraces, 1), 1);
if ~isempty(iWhiskTypeToUse);
    ROIColors(size(whiskTraces, 1) - iWhiskTypeToUse + 1, :) = [1 0 0];
end;

% change names for display
ROINamesForPlot = unique([fliplr(whiskTraceTypes)'; ROINames], 'stable');

%% update the analysis parameters
% remove some option from the analysis parameters
this.GUI.an.paramPanConfig({ 'selStimTypeGroups', 'selStimIDs', 'allStimIDs' }, :) = [];

%% plot
ANShowHideMessage(this, 1, 'Plotting ...');
plotTic = tic; % for performance timing purposes

% plot the data depending on the selected trace type to show
if strcmp(this.an.img.traceTypeToShow, 'raw and filtered');
    plotCaTraces(this.GUI.handles.an.axe, 0, '', concatCaTraces, concatCaTracesSGFilt, concatStimVect, ...
        stimIDs, ROINamesForPlot, t, t, ROIColors);
elseif strcmp(this.an.img.traceTypeToShow, 'filtered only');
    plotCaTraces(this.GUI.handles.an.axe, 0, '', concatCaTracesSGFilt, [], concatStimVect, stimIDs, ...
        ROINamesForPlot, t, [], ROIColors);
elseif strcmp(this.an.img.traceTypeToShow, 'raw only');
    plotCaTraces(this.GUI.handles.an.axe, 0, '', concatCaTraces, [], concatStimVect, stimIDs, ...
        ROINamesForPlot, t, [], ROIColors);
else
    ANShowHideMessage(this, 0, sprintf('Unknown trace type option: "%s". Cannot plot.', this.an.img.traceTypeToShow));
end;

o('#%s: plot done (%3.1f sec).', mfilename(), toc(plotTic), 2, this.verb);

% hide the message and show plot
ANShowHideMessage(this, 0, 'Update analyser plot done.');


end
