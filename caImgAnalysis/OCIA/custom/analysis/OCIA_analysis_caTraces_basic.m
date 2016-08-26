function OCIA_analysis_caTraces_basic(this, iDWRows)
% OCIA_analysis_caTraces_basic - [no description]
%
%       OCIA_analysis_caTraces_basic(this, iDWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% plotting parameter UI controls
paramConf = cell2table({ ...
... categ  id                   UIType      valueType               UISize    isLabAbove    label                    tooltip
    'img', 'traceTypeToShow',   'dropdown', { 'raw only'; 'filtered only'; 'raw and filtered' }, ...
                                                                    [1 0],   false,         'Trace type',           'Selects which traces are displayed in case of filtering.';
    'img', 'noGaps',            'dropdown', { 'true'; 'false' },    [1 0],   false,         'Hide gaps',            'Hide the NaN gaps between trials.';
}, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);
% append the new configuration to the table and update the row names using the ids
this.GUI.an.paramPanConfig = [this.GUI.an.paramPanConfig; paramConf];
this.GUI.an.paramPanConfig.Properties.RowNames = this.GUI.an.paramPanConfig.id;

%% get the data
% force the ROI combination to be true
this.an.img.combineROIs = true;

% get the concatenated trace (raw and filtered), the stimuli, the selected ROI names and the time vector
[concatCaTraces, concatStims, concatCaTracesSGFilt, ROINames, t] = OCIA_analysis_getConcatCaData(this, iDWRows);
% abort if no traces came out
if isempty(concatCaTraces); return; end;

% remove some option from the analysis parameters
this.GUI.an.paramPanConfig('combineROIs', :) = [];

% get the stimulus IDs to use
stimIDs = this.an.img.selStimIDs;
stimIDs = regexprep(reshape(stimIDs, 1, numel(stimIDs)), '_', ' ');
% rename stim IDs
stimIDs = OCIA_analysis_renameStimIDs(stimIDs);

% check for gap removal
if isfield(this.an.img, 'noGaps') && this.an.img.noGaps;
    
    % get the calcium data of all rows as a cell array of matrices
    allCaTracesCell = getData(this, iDWRows, 'caTraces', 'data');
    if ~iscell(allCaTracesCell); allCaTracesCell = { allCaTracesCell }; end;
    % get the number of frames for each row
    nFramesEachRow = cell2mat(arrayfun(@(iRow) size(allCaTracesCell{iRow}, 2), 1 : size(allCaTracesCell, 1), ...
        'UniformOutput', false));
    
    % max number of frames
    nMaxFrames = max(nFramesEachRow) + this.an.img.gapSize;

    % get the index of all NaN frames
    NaNMask = find(all(isnan(concatCaTraces)));
    
    % number of NaNs to leave
    gapSize = this.an.img.gapSize;
    
    % still leave gaps at trial borders
    for iRow = 1 : numel(nFramesEachRow) + 1;
%         NaNMask(NaNMask > sum(nFramesEachRow(1 : iRow)) & NaNMask < sum(nFramesEachRow(1 : iRow)) + gapSize) = [];
        NaNMask(NaNMask > nMaxFrames * iRow - gapSize & NaNMask < nMaxFrames * iRow) = [];
    end;
    
    % remove all NaN frames
    concatStims(NaNMask) = [];
    concatCaTracesSGFilt(:, NaNMask) = [];
    concatCaTraces(:, NaNMask) = [];

    % create a new time vector
    t = (1 : size(concatCaTraces, 2)) / this.an.img.defaultFrameRate;
    
end;

%% plot
ANShowHideMessage(this, 1, 'Plotting ...');
plotTic = tic; % for performance timing purposes

% plot the data depending on the selected trace type to show
if strcmp(this.an.img.traceTypeToShow, 'raw and filtered');
    plotCaTraces(this.GUI.handles.an.axe, 0, '', concatCaTraces, concatCaTracesSGFilt, concatStims, stimIDs, ROINames, t, t, []);
elseif strcmp(this.an.img.traceTypeToShow, 'filtered only');
    plotCaTraces(this.GUI.handles.an.axe, 0, '', concatCaTracesSGFilt, [], concatStims, stimIDs, ROINames, t, [], []);
elseif strcmp(this.an.img.traceTypeToShow, 'raw only');
    plotCaTraces(this.GUI.handles.an.axe, 0, '', concatCaTraces, [], concatStims, stimIDs, ROINames, t, [], []);
else
    ANShowHideMessage(this, 0, sprintf('Unknown trace type option: "%s". Cannot plot.', this.an.img.traceTypeToShow));
end;

o('#%s: plot done (%3.1f sec).', mfilename(), toc(plotTic), 2, this.verb);

%% attach callback to quickly identify trials
childElems = get(this.GUI.handles.an.axe, 'Children');
childElemTags = get(childElems, 'Tag');
if ~isempty(childElemTags)
    stimLineElems = childElems(cellfun(@(cont)~isempty(regexp(cont, '^stimLine_', 'once')), childElemTags));
    for iElem = 1 : numel(stimLineElems);
        ownTag = get(stimLineElems(iElem), 'Tag');
        trialInfo = regexp(ownTag, 'stimLine_stim(?<trialNum>\d+)_(?<trialType>\w+)', 'names');
        selectedTableRows = get(this.GUI.handles.an.rowList, 'Value');
        set(stimLineElems(iElem), 'ButtonDownFcn', @(h, e)fprintf('%s, %s\n', DWGetRowID(this, ...
            this.an.selectedTableRows(selectedTableRows(str2double(trialInfo.trialNum)))), trialInfo.trialType));
    end;
end;

% hide the message and show plot
ANShowHideMessage(this, 0, 'Update analyser plot done.');


end
