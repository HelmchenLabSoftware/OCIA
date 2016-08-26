function [figHand, imAxeHandles] = plotPeriStimAverageHeatMap(axeH, PSCaTraceMeans, t, stimIDs, saveName, ...
    ROINames, plotLimits, colorMapName, NStims, cBarName)

%% init
% get the size of the data set
[nStimTypes, nROIs, nPSFrames] = size(PSCaTraceMeans);

% create the figure
if isempty(axeH);
    figHand = figure('Name', saveName, 'NumberTitle', 'off', 'Color', 'white');
    axeH = axes('Parent', figHand);
else
    figHand = getParentFigure(axeH);
    axeParent = get(axeH, 'Parent');
end;

% make sure the plots are scaled the same way in negative and positive for the red-white-blue color map
if isempty(plotLimits) && strcmp(colorMapName, 'red_white_blue');
    absMax = max(abs(PSCaTraceMeans(:)));
    plotLimits = [-absMax absMax];

elseif isempty(plotLimits);
%     plotLimits = [prctile(PSCaTraceMeans(:), 5) prctile(PSCaTraceMeans(:), 99)];

end;

%% plot
% find the stimulus frame
stimFrame = find(t == 0, 1) + 0.5;
% look for a gap in the time
tDiff = diff(t);
gapFrame = find(tDiff > (nanmean(tDiff) + 2 * std(tDiff)), 1, 'first');
gapSize = roundn(tDiff(gapFrame), -1);
% get the last time point's value
lastTimePoint = t(end);
if ~isempty(gapSize); lastTimePoint = lastTimePoint - gapSize; end;
% get the position of the initial axe
baseAxePosition = get(axeH, 'Position');
% hide the original axe
set(axeH, 'YTick', [], 'XTick', [], 'XColor', 'white', 'YColor', 'white');
% create a holder for the handles of the sub-axes
imAxeHandles = nan(nStimTypes, 1);
% create one sub-plot for each stimulus type
for iStimType = 1 : nStimTypes;
    
    % calculate the new position
    axePosition = baseAxePosition;
    axePosition(3) = (baseAxePosition(3) / (nStimTypes + 0.05)) * 0.98;
    axePosition(1) = baseAxePosition(1) + (iStimType - 1) * axePosition(3) * 1.02;
    % create the new axe
    imAxeHandles(iStimType) = axes('Parent', axeParent, 'Color', 'blue', 'Position', axePosition, 'Visible', 'off');
    
    % plot the matrix as heat map
    imH = imagesc([t(1) lastTimePoint], [1 nROIs], reshape(PSCaTraceMeans(iStimType, :, :), nROIs, nPSFrames), ...
        'Parent', imAxeHandles(iStimType));

    % adjust XTicks according to gap, if necessary
    if ~isempty(gapFrame);
        xTicks = get(imAxeHandles(iStimType), 'XTick');
        xTicks(xTicks > t(gapFrame)) = xTicks(xTicks > t(gapFrame)) + gapSize;
        xTickLabels = num2cell(xTicks);
        if any(xTicks == t(gapFrame));
            xTickLabels{xTicks == t(gapFrame)} = sprintf('%.1f/%.1f', t(gapFrame), roundn(t(gapFrame) + gapSize, -1));
            set(imAxeHandles(iStimType), 'XTickLabel', xTickLabels);
        end;
    end;
    
    % if there are plot limits, apply them
    if ~isempty(plotLimits);
        set(imAxeHandles(iStimType), 'CLim', plotLimits);
    else
        plotLimits = get(imAxeHandles(iStimType), 'CLim');
    end;
    % change the colormap
    colormap(imAxeHandles(iStimType), colorMapName);
    if isempty(regexp(get(gcf, 'Name'), 'OCIA', 'once')); close(gcf); end;
    % remove ticks
    set(imAxeHandles(iStimType), 'YTick', []);
    
    % show NaN values as NaNs
    cData = get(imH, 'CData');
    midVal = 0.5 * (plotLimits(2) - plotLimits(1));
    cData(isnan(squeeze(PSCaTraceMeans(iStimType, :, :)))) = midVal;
    set(imH, 'CData', cData);
    
    % plot the stimulus line
    hold(imAxeHandles(iStimType), 'on');
    if ~isempty(stimFrame);
        plot(imAxeHandles(iStimType), [0 0], [0 nROIs + 1], 'LineWidth', 1.5, 'LineStyle', '--', 'Color', 'red');
    end;
    
    % plot the stimulus ID
    yPos = 0.0005 * nROIs * nROIs - 0.0483 * nROIs + 0.5467;
    if yPos > 0; yPos = - yPos * 0.5; end;
%     if yPos < 0 && yPos > -3; yPos = -3; end;
    if yPos < -20; yPos = -20; end;
    text(0, yPos, stimIDs{iStimType}, 'Color', 'black', 'FontWeight', 'bold', ...
        'HorizontalAlignment', 'center', 'Parent', imAxeHandles(iStimType), 'FontSize', iff(nStimTypes > 5, 10, 15));
    hold(imAxeHandles(iStimType), 'off');
    
    if iStimType == 1;
        xlabel(imAxeHandles(iStimType), 'Time [s]');
    end;
    
end;

% add the color bar on the last axe
hColBar = colorbar('peer', imAxeHandles(end));
set(get(hColBar, 'YLabel'), 'String', cBarName);
% compensate the width
colBarPos = get(hColBar, 'Position');
set(imAxeHandles(end), 'Position', get(imAxeHandles(end), 'Position') + [0 0 colBarPos(3) * 2 0]);
% set(hColBar, 'Color', 'red');
% create the ROI label axe
textAxeH = axes('Parent', axeParent, 'Color', 'blue', 'Position', get(imAxeHandles(1), 'Position'), 'Visible', 'off', ...
    'XLim', get(imAxeHandles(1), 'XLim'), 'YLim', get(imAxeHandles(1), 'YLim'));
% add ROI labels
if ~isempty(ROINames);
    ROINamesFlipped = flipud(ROINames);
    NStimsFlipped = fliplr(NStims);
    for iROI = 1 : nROIs;
        if ~isempty(NStimsFlipped)
            nTrialsStr = regexprep(sprintf('%02d;', NStimsFlipped(:, iROI)), ';$', '');
        else
            nTrialsStr = '';
        end;
        if ~isempty(nTrialsStr);
            ROIText = sprintf('%s, N=%s', ROINamesFlipped{iROI}, nTrialsStr);
        else
            ROIText = ROINamesFlipped{iROI};
        end;
        ROIText = regexprep(ROIText, ';$', ''); fullROIText = ROIText;
        % if text is too long, truncate it
        if numel(ROIText) > 15; ROIText = sprintf('%s ..', ROIText(1 : 12)); end;
        text(t(1) - (t(2) - t(1)), iROI, ROIText, 'Parent', textAxeH, 'HorizontalAlignment', 'right', ...
            'Interpreter', 'none', 'FontSize', max(min(15 - (0.166 * nROIs), 20), 6), 'ButtonDownFcn', @(h, e)disp(fullROIText));
    end;
end;
% link all these axes
linkaxes([imAxeHandles; textAxeH]', 'y');
% put the label axe at the bottom
restackAxes(textAxeH, 'bottom');

end
