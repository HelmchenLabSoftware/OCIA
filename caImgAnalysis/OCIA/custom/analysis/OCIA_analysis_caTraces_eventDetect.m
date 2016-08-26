function OCIA_analysis_caTraces_eventDetect(this, iDWRows)
% OCIA_analysis_caTraces_eventDetect - [no description]
%
%       OCIA_analysis_caTraces_eventDetect(this, iDWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% plotting parameter UI controls
paramConf = cell2table({ ...
... categ       id                  UIType      valueType       UISize   isLabAbove    label           tooltip
    'img',      'traceTypeToShow',  'dropdown', { 'raw only'; 'filtered only'; 'raw and filtered' }, ...
                                                            [1 0],   false,         'Trace type',   'Selects which traces are displayed in case of filtering.';    
    'img',    'storeStims', 'button',   { @OCIA_analysis_storeStimVectorsFromEventDetect }, ...
         [0.8 0],   false,         'Store stim. vect.', 'Stores the displayed stimulus vector as the stimulus vector for the selected rows.';
    'img',    'stimVectMinStartTime',  'text',   { 'numeric' },   [1 0],  false, ...
        'Stim. min. start time',    'Starting time in seconds after which to look for stim. for construction of stim. vector.';
    'img',    'stimVectPeakSTDThresh',  'text',   { 'numeric' },  [1 0],  false, ...
        'Stim. peak thresh',        'Minimum peak height (in number of STDs above mean) for construction of stim. vector.';
    'img',    'stimVectInterPeakDistThresh',  'text',   { 'numeric' },   [1 0],  false, ...
        'Stim. inter-peak dist.',   'Minimum inter-peak distance in seconds for construction of stim. vector.';
    'img',    'stimVectPeakStartThreshold',  'text',   { 'numeric' },   [1 0],  false, ...
        'Stim. onset thresh.',      'Fraction of the peak that we must go below to find the onset of the peak in the construction of stim. vector.';
    'img',    'stimVectDbgPlotROIs', 'text',   { 'array' },   	[1 0],  false, ...
        'Stim. debug plot',         'Array of the ROIs for which a debuging plot should be plotted.';
}, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);
% append the new configuration to the table and update the row names using the ids
this.GUI.an.paramPanConfig = [this.GUI.an.paramPanConfig; paramConf];
this.GUI.an.paramPanConfig.Properties.RowNames = this.GUI.an.paramPanConfig.id;

%% get the data
% get the concatenated trace (raw and filtered), the stimuli, the selected ROI names and the time vector
caTraces = OCIA_analysis_getCaTracesMatrix(this, iDWRows, true);
% get the concatenated trace (raw and filtered), the stimuli, the selected ROI names and the time vector
[concatCaTraces, ~, concatCaTracesSGFilt, ROINames, t] = OCIA_analysis_getConcatCaData(this, iDWRows);
% abort if no traces came out
if isempty(concatCaTraces) || isempty(caTraces); return; end;

%% stim vector

warning('off', 'signal:findpeaks:largeMinPeakHeight');
this.an.img.ROIStimVects = cell(numel(iDWRows), 1);
    
% go through each ROI
for iROI = 1 : numel(ROINames);
    
    % use data with no negative values
    concatCaTracesNoNeg = concatCaTraces(iROI, :) - min(concatCaTraces(iROI, :));

    % extract the stimulus vector by thresholding
    [~, minPeakHeight] = getStimVectFromTrace(concatCaTracesNoNeg, this.an.img.stimVectPeakSTDThresh, [], ...
        this.an.img.stimVectInterPeakDistThresh, this.an.img.stimVectMinStartTime, ...
        this.an.img.stimVectPeakStartThreshold, this.an.img.defaultFrameRate, ...
        ismember(iROI, this.an.img.stimVectDbgPlotROIs), sprintf('ROI %02d: %s', iROI, ROINames{iROI}), ROINames{iROI});

    % calculate stim vect for each peak
    for iRow = 1 : numel(iDWRows);
        
        % use data with no negative values
        caTracesNoNeg = squeeze(caTraces(iRow, iROI, 1 : end - 1));
        caTracesNoNeg = caTracesNoNeg - min(caTracesNoNeg(:));
        
        stimForROI = getStimVectFromTrace(caTracesNoNeg, [], minPeakHeight, ...
            this.an.img.stimVectInterPeakDistThresh, this.an.img.stimVectMinStartTime, ...
            this.an.img.stimVectPeakStartThreshold, this.an.img.defaultFrameRate, ...
            ismember(iROI, this.an.img.stimVectDbgPlotROIs), sprintf('ROI %02d: %s', iROI, ROINames{iROI}), ...
            ROINames{iROI});
        
        % add final 0 frame for padding (like in the caTraces)
        stimForROI(end + 1) = 0; %#ok<AGROW>
        
        % init the storage cell-array
        if iROI == 1;
            this.an.img.ROIStimVects{iRow} = zeros(size(stimForROI));
        end;
        
        % check for overlapping stim frame for an ROI
        badFrame = 1;
        while any(badFrame);
            badFrame = this.an.img.ROIStimVects{iRow} & stimForROI > 0;
            if any(badFrame);
                for iFrame = 1 : numel(find(badFrame));
                    badFrames = find(badFrame);
                    showMessage(this, sprintf(['Bad frame found for row %02d, ROI %02d, frame: %02d (previous ROI at that ', ...
                        'frame: %02d)'], iRow, iROI, badFrames(iFrame), ...
                        this.an.img.ROIStimVects{iRow}(badFrames(iFrame))), 'yellow');
                end;
                stimForROI(badFrame) = 0;
                stimForROI(find(badFrame) + 1) = 1;
            end;
        end;
        
        % assign stim to ROI
        this.an.img.ROIStimVects{iRow} = this.an.img.ROIStimVects{iRow} + stimForROI * iROI;
        
    end;
    
end;

% create the stim vector
concatStimVect = cell2mat(this.an.img.ROIStimVects);

% store the number of ROIs
this.an.img.nROIForStimVect = numel(ROINames);

warning('on', 'signal:findpeaks:largeMinPeakHeight');
    

%% process traces
stimIDs = ROINames;

% create color map
ROIColors = lines(size(ROINames, 1));
ROIColors(ROIColors > 0.4) = 0.4;

%% update the analysis parameters
this.an.img.allStimIDs = ROINames';
% remove some option from the analysis parameters
this.GUI.an.paramPanConfig({ 'selStimTypeGroups', 'selStimIDs', 'allStimIDs' }, :) = [];

%% plot
ANShowHideMessage(this, 1, 'Plotting ...');
plotTic = tic; % for performance timing purposes

plotCaTraces(this.GUI.handles.an.axe, 0, '', concatCaTracesSGFilt, [], concatStimVect, stimIDs, ...
    ROINames, t, [], ROIColors, ROIColors);

o('#%s: plot done (%3.1f sec).', mfilename(), toc(plotTic), 2, this.verb);

% hide the message and show plot
ANShowHideMessage(this, 0, 'Update analyser plot done.');


end
