function OCIA_analysis_behav_licks(this, iDWRows)
% OCIA_analysis_behav_licks - [no description]
%
%       OCIA_analysis_behav_licks(this, iDWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% plotting parameter UI controls
paramConf = cell2table({ ...
... categ  id                   UIType      valueType               UISize      isLabAbove      label               tooltip
    'be',  'selTrialTypes',     'list',     {  },                   [2 4],      true,           'Trial types',      'Selection of trial types.';
    'be',  'allTrialTypes',     'text',     { 'cellArray' },        [1 0],      false,          'All trial types',  'Trial types for all the trial type as a cell-array.';
    'be',  'plotLimits',        'text',     { 'array' },            [0.75 0],   false,          'Plot limits',      'Adjust the limits of the plot (color limit).';
    'be',  'colormap',          'dropdown', { 'gray', 'hot', 'gray_reverse', 'red_white_blue', 'jet' }', ...
                                                                    [0.75 0],   false,          'Colormap',         'Changes the coloring scheme (color map).';
}, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);
% append the new configuration to the table and update the row names using the ids
this.GUI.an.paramPanConfig = [this.GUI.an.paramPanConfig; paramConf];
this.GUI.an.paramPanConfig.Properties.RowNames = this.GUI.an.paramPanConfig.id;

this.GUI.an.paramPanConfig{'selTrialTypes', 'valueType'} = { this.an.be.allTrialTypes };

%% get pre-processed PS lick data
[PSLickDataProc, trialRespTypes, ~, selTimes] = OCIA_analysis_behav_getPSLickData(this, iDWRows);

%% exclude non-selected trial types
allTrialTypes = this.an.be.allTrialTypes;
selTrialTypes = this.an.be.selTrialTypes;
excludedTrialTypeIndexes = find(~ismember(allTrialTypes, selTrialTypes));
PSLickDataProc(:, ismember(trialRespTypes, excludedTrialTypeIndexes), :) = [];
trialRespTypes(ismember(trialRespTypes, excludedTrialTypeIndexes)) = [];
% update trial number
nTotTrials = size(PSLickDataProc, 2);

%% plot the data
ANShowHideMessage(this, 1, 'Plotting ...');

% create time vector
t = ((1 : size(PSLickDataProc, 3)) ./ this.an.be.anInSampleRate) + this.an.be.PSPer(1);

% two numbers
if isnumeric(this.an.be.plotLimits) && numel(this.an.be.plotLimits) == 2;
    plotLimits = this.an.be.plotLimits;
    
% single number
elseif isnumeric(this.an.be.plotLimits) && numel(this.an.be.plotLimits) == 1;
    plotLimits = [-this.an.be.plotLimits, this.an.be.plotLimits];
    
% automatic plot limits
else
    plotLimits = [prctile(PSLickDataProc(:), 25), prctile(PSLickDataProc(:), 80)];
    
end;

% create the label axe
labelAxe = axes('Parent', get(this.GUI.handles.an.axe, 'Parent'), 'YTick', [], 'XTick', [], 'XColor', 'white', ...
    'YColor', 'white', 'Color', 'white', 'Position', get(this.GUI.handles.an.axe, 'Position'), ...
    'YDir', 'reverse');
    
% plot the heatmap
[~, axeHandles] = plotPeriStimAverageHeatMap(this.GUI.handles.an.axe, PSLickDataProc, t, selTimes, '', {}, ...
    plotLimits, this.an.be.colormap, [], 'Lick [A.U.]');

% re-link axes
linkaxes([axeHandles; labelAxe], 'y');

iCount = 1;
for iRespType = 1 : numel(allTrialTypes);
    
    if ~ismember(allTrialTypes{iRespType}, selTrialTypes); continue; end;
    
    respTypeStartIndex = find(trialRespTypes == iRespType, 1, 'first');
    respTypeStopIndex = find(trialRespTypes == iRespType, 1, 'last');
    if isempty(respTypeStartIndex) || isempty(respTypeStopIndex); continue; end;
    meanRespTypeIndex = round(nanmean(find(trialRespTypes == iRespType)));
    for iAxeHandle = 1 : numel(axeHandles);
        if iCount ~= 1;
            line([-1000, 1000], repmat(respTypeStartIndex - 0.5, 1, 2), 'Color', 'blue', 'LineWidth', 1, ...
                'Parent', axeHandles(iAxeHandle));
        end;
    end;
    text(-0.025 + iff(mod(iCount, 2), 0, -0.025), meanRespTypeIndex, ...
        allTrialTypes{iRespType}, 'Color', 'black', 'Parent', labelAxe, 'HorizontalAlignment', 'center', ...
        'Interpreter', 'none', 'FontSize', 21, 'FontWeight', 'bold', 'Rotation', 90);
    iCount = iCount + 1;
end;

filterText = get(this.GUI.handles.an.rowFilt, 'String');
if ~isempty(filterText) && ~isempty(regexp(filterText, '^\d{4} \d{2} \d{2}$', 'once'));
    text(-0.09, round(nTotTrials * 0.5), filterText, 'Color', 'black', 'Parent', labelAxe, ...
        'HorizontalAlignment', 'center', 'Interpreter', 'none', 'FontSize', 23, 'Rotation', 90);
end;

% hide the message and show plot
ANShowHideMessage(this, 0, 'Update analyser plot done.');
end
