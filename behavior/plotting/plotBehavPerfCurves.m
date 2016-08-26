function fig = plotBehavPerfCurves(axeH, saveName, TGOs, NTGOs, RESPs, DPRIMEs, maxDPRIME, DPRIMEThresh, ...
    dayIDs, imagIDs, behavValues, behavPlotParams)
% plot the behavior performance
% daysIDs can be 'noLabel' for no axis labeling
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Originally created on           17 / 02 / 2014 %
%     in a galaxy far, far away... :D            %
% Written by B. Laurenczy (blaurenczy@gmail.com) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% initialize axe/figure
% create a figure if needed
if isempty(axeH) || axeH == 0;
    fig = figure('Name', saveName, 'NumberTitle', 'off', 'Color', 'white');
    axeH = axes('Parent', fig);
else
    fig = getParentFigure(axeH);
end;

%% initialize plot with limits
nTrials = size(TGOs, 2);
yOffset = 0;
if ~isempty(dayIDs); yOffset = -16; end;
yLims = [yOffset 101];
ylim(axeH, yLims);
xlim(axeH, [0 nTrials + 1]);
hold(axeH, 'on');

%% imaged trials
if ~isempty(imagIDs);
    blockBoundaries = find(diff(imagIDs) ~= 0);
    if imagIDs(1);      blockBoundaries = [1 blockBoundaries];      end;
    if imagIDs(end);    blockBoundaries = [blockBoundaries nTrials]; end;
    for iBlock = 1 : 2 : size(blockBoundaries, 2);
        startInd = blockBoundaries(iBlock);
        endInd = blockBoundaries(iBlock + 1);
        rectangle('Parent', axeH, 'Position', [startInd, yLims(1), endInd - startInd, yLims(end) - yLims(1)], ...
            'FaceColor', [0.7 0.8 0.8], 'EdgeColor', 'none');
    end;
end;

%% day labels
if ~isempty(dayIDs);
    
    uniqueDayIDs = unique(dayIDs);
    nDayID = size(uniqueDayIDs, 2);
    evenDay = 0; evenDayCounter = -1;
    for iDayID = 1 : nDayID;
        
        dayID = uniqueDayIDs{iDayID};
        dayWithNoPMAM = regexprep(dayID, '_[ap]m$', '');
        dayIDMask = strcmp(dayIDs, dayID);
        blockBoundaries = find(diff(dayIDMask) ~= 0);
        if dayIDMask(1);      blockBoundaries = [1 blockBoundaries];      end; %#ok<AGROW>
        if dayIDMask(end);    blockBoundaries = [blockBoundaries nTrials]; end; %#ok<AGROW>        
        
        evenDayCounter = evenDayCounter + 1;
        if iDayID > 1; % if not the first day, check for difference with previous day
            prevDayWithNoPMAM = regexprep(uniqueDayIDs{iDayID - 1}, '_[ap]m$', '');
            if ~strcmp(prevDayWithNoPMAM, dayWithNoPMAM); % if previous day is different, force the color change
                evenDayCounter = 0;
                evenDay = evenDay + 1;
            end;
        end;
        if evenDayCounter > 1; evenDayCounter = 0; evenDay = evenDay + 1; end;
        if evenDay > 1; evenDay = 0; end;
        
        if evenDay;
            if      regexp(dayID, '_pm$'); faceCol = [0.47 0.47 0.9];
            elseif  regexp(dayID, '_am$'); faceCol = [0.33 0.33 0.9];
            else                           faceCol = [0.33 0.33 0.9];
            end;
        else
            if      regexp(dayID, '_pm$'); faceCol = [0.47 0.9 0.47];
            elseif  regexp(dayID, '_am$'); faceCol = [0.33 0.9 0.33];
            else                           faceCol = [0.33 0.9 0.33];
            end;
        end;
        
        for iBlock = 1 : 2 : size(blockBoundaries, 2);
            startInd = blockBoundaries(iBlock);
            endInd = blockBoundaries(iBlock + 1);
            rectangle('Parent', axeH, 'Position', [startInd, yOffset, endInd - startInd, abs(yOffset) - 1], ...
                'FaceColor', faceCol, 'EdgeColor', 'black');
        end;
        
        middleTrial = mean(find(dayIDMask > 0));
        text(middleTrial, -2, dayWithNoPMAM, 'HorizontalAlignment', 'right', ...
            'Rotation', 90, 'Parent', axeH, 'FontSize', 7.5, 'Interpreter', 'none');
    end;
end;

%% plotting of the behavior performance
plot(axeH, 1 : nTrials, TGOs, 'g', 'LineWidth', 3);

if ~isempty(NTGOs);
    plot(axeH, 1 : nTrials, NTGOs, 'r', 'LineWidth', 3);
    if ~isempty(DPRIMEs);
        DPRIMEs(isnan(NTGOs)) = NaN;
    end;
end;

if ~isempty(RESPs);
    plot(axeH, 1 : nTrials, RESPs, 'k--', 'LineWidth', 1);
end;


if ~isempty(DPRIMEs);
    DPRIMEsNorm = (max(min(DPRIMEs / maxDPRIME, 1), -1) + 1) * 100 / 2;
    DPRIMEsNorm(isnan(DPRIMEs)) = NaN;
    DPRIMEThreshNorm = ((DPRIMEThresh / maxDPRIME) + 1) * 100 / 2;
    plot(axeH, 1 : nTrials, DPRIMEsNorm, 'b', 'LineWidth', 4);
    plot(axeH, [1 nTrials], repmat(DPRIMEThreshNorm(1), 2, 1), 'b:');
    if size(DPRIMEThreshNorm, 2) > 2; % in case we have 2 thresholds
        plot(axeH, [1 nTrials], repmat(DPRIMEThreshNorm(2), 2, 1), 'b-.');
    end;
    
    yTicks = 0 : 10 : 100;
    yTickLabels = linScale(yTicks, -maxDPRIME, maxDPRIME);
    dPrimeAxe = axes('Position', get(axeH, 'Position'), 'Parent', get(axeH, 'Parent'), ...
        'YAxisLocation', 'right', 'XAxisLocation', 'top', 'YLim', yLims, 'XColor', 'white', ...
        'YTick', yTicks, 'YTickLabel', yTickLabels);
    if ~ischar(dayIDs) || strcmpi(dayIDs, 'noLabel');
        ylabel(dPrimeAxe, '{\itd''}');
    end;
    linkaxes([axeH, dPrimeAxe], 'y');
    % make the axe the figure's current axe
    set(fig, 'CurrentAxes', axeH);
    restackAxes(axeH, 'top');
end;

if ~isempty(behavValues);
    roundMax = round(max(behavValues));
    if roundMax > 10;
        roundMax = roundn(max(behavValues) + 5, 1);
    end;
    if behavValues > 20;
        zeroToUse = 20;
    else
        zeroToUse = 0;
    end;
    if ~isempty(behavPlotParams{2});
        zeroToUse = behavPlotParams{2}(1);
        roundMax = behavPlotParams{2}(2);
    end;
    zeroToUse = min(zeroToUse, min(behavValues));
    roundMax = max(roundMax, max(behavValues));
    behavValues = linScale([zeroToUse behavValues roundMax], 1, 99);
    zeroValue = behavValues(1);
    behavValues([1 end]) = [];
    if strcmp(behavPlotParams{1}, 'scatter');
        hScat = scatter(axeH, 1 : nTrials, behavValues, 'x');
        set(hScat, 'MarkerFaceColor', behavPlotParams{3}, 'MarkerEdgeColor', behavPlotParams{3});
    elseif strcmp(behavPlotParams{1}, 'bigscatterline');
        x = 1 : nTrials; y = behavValues; nonNan = ~isnan(behavValues);
        plot(axeH, x(nonNan), y(nonNan), 'Color', behavPlotParams{3});
        hScat = scatter(axeH, x(nonNan), y(nonNan), 50, 's', 'fill');
        set(hScat, 'MarkerFaceColor', behavPlotParams{3}, 'MarkerEdgeColor', behavPlotParams{3});
    elseif strcmp(behavPlotParams{1}, 'bigscatter');
        hScat = scatter(axeH, 1 : nTrials, behavValues, 50, 's', 'fill');
        set(hScat, 'MarkerFaceColor', behavPlotParams{3}, 'MarkerEdgeColor', behavPlotParams{3});
    elseif strcmp(behavPlotParams{1}, 'bigline');
        plot(axeH, 1 : nTrials, behavValues, '-', 'LineWidth', 3, 'Color', behavPlotParams{3});
    elseif strcmp(behavPlotParams{1}, 'line');
        plot(axeH, 1 : nTrials, behavValues, '-', 'LineWidth', 1.5, 'Color', behavPlotParams{3});
    else
        
    end;
    ticks = ((0 : 0.2 : 1) * (roundMax - zeroToUse)) + zeroToUse;
    if zeroToUse > 1;
        ticks = roundn(ticks, -1);
    elseif zeroToUse > 10;
        ticks = round(ticks);
    end;
    plot(axeH, [1 nTrials], ones(2, 1), ':', 'Color', behavPlotParams{3});
    plot(axeH, [1 nTrials], ones(2, 1) * 20, ':', 'Color', behavPlotParams{3});
    plot(axeH, [1 nTrials], ones(2, 1) * 40, ':', 'Color', behavPlotParams{3});
    plot(axeH, [1 nTrials], ones(2, 1) * 60, ':', 'Color', behavPlotParams{3});
    plot(axeH, [1 nTrials], ones(2, 1) * 80, ':', 'Color', behavPlotParams{3});
    plot(axeH, [1 nTrials], ones(2, 1) * 99, ':', 'Color', behavPlotParams{3});
    text(6, zeroValue + 2, num2str(zeroToUse), 'Color', behavPlotParams{3}, 'Parent', axeH);
    text(6, 20 + 2, num2str(ticks(2)), 'Color', behavPlotParams{3}, 'Parent', axeH);
    text(6, 40 + 2, num2str(ticks(3)), 'Color', behavPlotParams{3}, 'Parent', axeH);
    text(6, 60 + 2, num2str(ticks(4)), 'Color', behavPlotParams{3}, 'Parent', axeH);
    text(6, 80 + 2, num2str(ticks(5)), 'Color', behavPlotParams{3}, 'Parent', axeH);
    text(6, 97, num2str(roundMax), 'Color', behavPlotParams{3}, 'Parent', axeH);
end;

if ~isempty(saveName); title(axeH, saveName, 'Interpreter', 'none'); end;
if ~ischar(dayIDs) || strcmpi(dayIDs, 'noLabel');
    ylabel(axeH, 'Proportion of trial [%]');
    xlabel(axeH, 'Trials');
end;
hold(axeH, 'off');


end
