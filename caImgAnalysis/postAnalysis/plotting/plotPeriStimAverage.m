function figHand = plotPeriStimAverage(axeH, PSCaTraceMeans, PSCaTraceErrors, NStims, ROINames, t, plotLimits, ...
    stimIDs, saveName, PSCaTraces, varargin)

%% init
% get the size of the data set
[nStimTypes, nROIs, nPSFrames] = size(PSCaTraceMeans);
[~, nTrials, ~, ~] = size(PSCaTraces);

% create the figure
if isempty(axeH);
    figHand = figure('Name', saveName, 'NumberTitle', 'off', 'Color', 'white');
    axeH = axes('Parent', figHand);
else
    figHand = getParentFigure(axeH);
end;

% color each trace by a specific color
if nStimTypes == 1;
    colors = [0 0 0];
    colorsLight = colors;
    colorsLight(colorsLight == 0) = 0.5;
    lineStyles = {'-'};
elseif nStimTypes == 2;
    colors = [0 0 0; 1 0 0];
    colorsLight = colors;
    colorsLight(colorsLight == 0) = 0.5;
    lineStyles = {'-', '-'};
elseif nStimTypes == 3;
    colors = [0.7 0.7 0.7; 0 0 0; 1 0 0;];
    colorsLight = colors;
    colorsLight(colorsLight == 0.7) = 0.85;
    colorsLight(colorsLight == 0) = 0.5;
    lineStyles = {'-.', '-', '-'};
else
    colors = jet(nStimTypes);
    colorsLight = colors;
    colorsLight(colorsLight == 0) = 0.5;
    lineStyles = [];
end;

% gather infos about original axe
axeHParent = get(axeH, 'Parent');
basePos = get(axeH, 'Position');
% hide the original axe
set(axeH, 'YTick', [], 'XTick', [], 'XColor', 'white', 'YColor', 'white');

% font size can change depending on the number of ROIs plotted
fontSize = 15 - nROIs * 0.5;

% get the max/min Y value to normalize axes
maxYLim = -Inf; minYLim = Inf;

% get subplot sizes
M = ceil(sqrt(nROIs)); N = iff(M * (M - 1) >= nROIs, M - 1, M);
% get the dimensions of the subplots
WPad = basePos(3) * 0.12 - nROIs * 0.005; W = (basePos(3) - (M - 1) * WPad) / M;
HPad = basePos(4) * 0.20 - nROIs * 0.005; H = (basePos(4) - (N - 1) * HPad) / N;
X = basePos(1); Y = basePos(2) + (N - 1) * (H + HPad);

% create a plot for each ROI
plotHands = nan(nROIs, 1);
for iROI = 1 : nROIs;
    
    currAxeH = axes('Parent', axeHParent, 'Color', 'white', 'Position', [X Y W H], 'Visible', 'on');
    plotHands(iROI) = currAxeH;
    X = X + W + WPad;
    if X >= basePos(1) + basePos(3);
        X = basePos(1); 
        Y = Y - H - HPad;
    end;
    
    %% plot
    stimPlotHands = cell(nStimTypes, 1);
    legHandles = zeros(1, nStimTypes);
    opengl software;
    for iStim = 1 : nStimTypes;
        
        % show the raw traces if provided
        if ~isempty(PSCaTraces);
            
            hold(currAxeH, 'on');
            for iTrial = 1 : nTrials;
                PSTrace = reshape(PSCaTraces(iStim, iTrial, iROI, :), 1, nPSFrames);
                PSTrace = PSTrace - nanmean(PSTrace(t < 0));
                plot(currAxeH, t, PSTrace, 'LineWidth', 1, 'Color', colorsLight(iStim, :));
                
            end;
            stimPlotHands{iStim} = plot(currAxeH, t, reshape(PSCaTraceMeans(iStim, iROI, :), 1, nPSFrames), ...
                'LineWidth', 2);
            set(stimPlotHands{iStim}, 'Color', colors(iStim, :), 'LineWidth', 2);
            if ~isempty(lineStyles);
                set(stimPlotHands{iStim}, 'LineStyle', lineStyles{iStim});
            end;
            legHandles(iStim) = stimPlotHands{iStim};
         
        % show mean trace with error bars
        else
            
            stimPlotHands{iStim} = shadedErrorBar(t, reshape(PSCaTraceMeans(iStim, iROI, :), 1, nPSFrames), ...
                reshape(PSCaTraceErrors(iStim, iROI, :), 1, nPSFrames), [], 1, figHand, currAxeH);
            hold(currAxeH, 'on');
            set(stimPlotHands{iStim}.mainLine, 'Color', colors(iStim, :), 'LineWidth', 2);
            if ~isempty(lineStyles); set(stimPlotHands{iStim}.mainLine, 'LineStyle', lineStyles{iStim}); end;
            set(stimPlotHands{iStim}.patch, 'FaceColor', colorsLight(iStim, :));
            set(stimPlotHands{iStim}.edge, 'Color', colors(iStim, :));
            legHandles(iStim) = stimPlotHands{iStim}.mainLine;
            
        end;
    end;

    set(currAxeH, 'LineWidth', 1.5, 'Box', 'off'); % defeat OpenGL border bug

    if isempty(plotLimits);
        yLimits = get(currAxeH, 'YLim');
        yLimits(1) = min(yLimits(1), 0);
    else
        yLimits = plotLimits;
    end;
    maxYLim = max(maxYLim, yLimits(2)); minYLim = min(minYLim, yLimits(1));
    hStimLine = plot(currAxeH, [0 0], [-300 300], 'Color', 'red', 'LineWidth', 2, 'LineStyle', '--');

    % add the legends on the first ROI's plot
    if iROI == 1;
        if nROIs == 1;
            hLeg = legend(currAxeH, [legHandles, hStimLine], [stimIDs, 'stim. onset'], 'Location', 'NorthEast', 'Orientation', 'Horizontal');
        else
%             hLeg = legend(currAxeH, [legHandles, hStimLine], [stimIDs, 'stim. onset'], 'Location', 'North', 'Orientation', 'Horizontal');
            hLeg = legend(currAxeH, [legHandles, hStimLine], [stimIDs, 'stim. onset'], 'Location', 'NorthWest', 'Orientation', 'Vertical');
        end;
        set(hLeg, 'Box', 'off'); % defeat OpenGL border bug
    end;

    % axis labels and title
    set(currAxeH, 'FontSize', fontSize, 'YLim', yLimits, 'XLim', t([1 end]));
    
    % add axis labels on the first ROI's plot
    if iROI == 1;
        if isempty(varargin) || ~ischar(varargin{1});
            ylabel(currAxeH, 'dFF/dRR [%] \pm SEM', 'FontSize', fontSize);
        else
            ylabel(currAxeH, varargin{1}, 'FontSize', fontSize);
        end;
        xlabel(currAxeH, 'Time [s]', 'FontSize', fontSize);
    end;
    
    if isempty(saveName) && ~isempty(ROINames) && numel(ROINames) >= iROI;
        nTrialsStr = regexprep(sprintf('%02d;', NStims(:, iROI)), ';$', '');
        title(currAxeH, sprintf('%s (N=%s)', ROINames{iROI}, nTrialsStr), 'Interpreter', 'none', 'FontSize', fontSize);
    else
        title(currAxeH, saveName, 'Interpreter', 'none', 'FontSize', fontSize);
    end;
    hold(currAxeH, 'off');
    
end;

% adjust the limit to make the plot equal on axes
if maxYLim < abs(minYLim); maxYLim = abs(minYLim); end;

% adjust all plot limits
set(plotHands, 'YLim', [minYLim, maxYLim]);
linkaxes(plotHands, 'xy');

end

