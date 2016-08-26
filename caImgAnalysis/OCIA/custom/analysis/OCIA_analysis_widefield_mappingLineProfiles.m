function OCIA_analysis_widefield_mappingLineProfiles(this, iDWRows)
% OCIA_analysis_widefield_mappingLineProfiles - [no description]
%
%       OCIA_analysis_widefield_mappingLineProfiles(this, iDWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)


%% plotting parameter UI controls
paramConf = cell2table({ ...
... categ  id                   UIType  valueType       UISize  isLabAbove  label               tooltip
%     'wf',  'excludeTrials',     'text', { 'cellArray' }, [1 0], true,       'Excl. trials',     'List of trials to exclude.';
    'wf',  'powerMapCLim',      'text', { 'array' },    [1 0],  false,      'CLim',             'Color limits.';
    'wf',  'subRange',          'text', { 'array' },    [1 0],  false,      'SubRange',         'Evoked frames sub-range.';
    
}, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);
OCIA_analysis_widefield_addParamPanConfigUIControls(this, '(crop|Rot|Frames|Freq|phaseMapFilt|CLim|Delay|Shift|BLCorr)', paramConf);

%% get the data
[averageMaps, stimIDs, tPS, subRange] = OCIA_analysis_widefield_getAverageMaps(this, iDWRows(1));
if numel(iDWRows) > 1 && size(averageMaps, 3) == 1;
    averageMapsForRow = averageMaps;
    stimIDsForRow = stimIDs;
    
    averageMaps = nan(size(averageMapsForRow, 1), size(averageMapsForRow, 2), numel(iDWRows), size(averageMapsForRow, 4));
    stimIDs = cell(numel(iDWRows), 1);
    
    averageMaps(:, :, 1, :) = averageMapsForRow;
    stimIDs(1) = stimIDsForRow;
    
    for iRow = 2 : numel(iDWRows);
        [averageMapsForRow, stimIDsForRow] = OCIA_analysis_widefield_getAverageMaps(this, iDWRows(iRow));
        averageMaps(:, :, iRow, :) = averageMapsForRow;
        stimIDs(iRow) = stimIDsForRow;
    end;
end;
if isempty(averageMaps); return; end;

% average all frames
averageMaps = nanmean(averageMaps, 4);

% get dataset's size
[~, ~, nStims] = size(averageMaps);
thresh = this.an.wf.powerMapThresh;
wfParams = this.an.wf;

% normalize each stim
for iStim = 1 : nStims;
    averageMaps(:, :, iStim) = linScale(averageMaps(:, :, iStim));
end;

%% plot
ANShowHideMessage(this, 1, 'Plotting ...');
pause(0.02);

%% get reference image
[~, ~, ~, refImg] = OCIA_analysis_widefield_getFileInfo(this, iDWRows(1));
% crop image if needed
if ~isempty(refImg) && ~isempty(wfParams.cropRect);
    refImg = refImg(wfParams.cropRect(2) + (0 : wfParams.cropRect(4) - 1), ...
        wfParams.cropRect(1) + (0 : wfParams.cropRect(3) - 1));
end;
imgH = size(refImg, 1); imgW = size(refImg, 2);
    
% create the axe configuration cell-array with the reference image
refImgTitle = '';
if ~isempty(wfParams.cropRect);
    refImgTitle = sprintf('%s \\fontsize{9}[%dX,%dY,%dW,%dH]', refImgTitle, wfParams.cropRect);
end;
evokedTPS = tPS(tPS > 0);
timeInfoStr = sprintf(' T+%.2fs(F%02d)', evokedTPS(subRange(1)), subRange(1));
if subRange(1) ~= subRange(2);
    timeInfoStr = [timeInfoStr, sprintf('->T+%.2fs(F%02d)', evokedTPS(subRange(2)), subRange(2))];
end;
refImgTitle = [refImgTitle timeInfoStr sprintf('\n') sprintf('FILT:[GAUSS:%.0f,%.0f,%.1f|MED:%.0f,%.0f]', wfParams.powerMapFilt)];

%% prepare plotting
% get plotting axe
anAxeH = this.GUI.handles.an.axe;
axeHandles = [];

% gather infos about original axe
axeHParent = get(anAxeH, 'Parent');
basePos = get(anAxeH, 'Position');
basePos(1) = 0.04;
basePos(2) = 0.08;
basePos(3) = 0.93;
basePos(4) = 0.60;
% hide the original axe
set(anAxeH, 'YTick', [], 'XTick', [], 'XColor', 'white', 'YColor', 'white', 'Visible', 'off');

% get the dimensions of the subplots
M = 7; N = 4; pads = [0.025, 0.045];
WPad = basePos(3) * pads(1); W = (basePos(3) - (M - 1) * WPad) / M;
HPad = basePos(4) * pads(2); H = (basePos(4) - (N - 1) * HPad) / N;
[X, baseX] = deal(basePos(1)); %#ok<ASGLU>
[Y, baseY] = deal(basePos(2) + (N - 1) * (H + HPad));
iY = 1;

% params
stimColors = hsv(nStims);
lineH = zeros(nStims, 1);

% store main polygon for each stimulus
mainPoly = cell(nStims, 1);
centroidCoord = zeros(nStims, 2);

% get line profile parameters
midX = round(size(averageMaps, 2) / 2);
midY = round(size(averageMaps, 1) / 2);

%% stim maps
for iStim = 1 : nStims;
    
    averageMap = averageMaps(:, :, iStim);
    coordMapX = repmat(1 : size(averageMap, 2), size(averageMap, 1), 1);
    weightedMapX = coordMapX .* linScale(averageMap);
    weightedCoordX = nanmean(weightedMapX(:));
    coordMapY = repmat((1 : size(averageMap, 1))', 1, size(averageMap, 2));
    weightedMapY = coordMapY .* linScale(averageMap);
    weightedCoordY = nanmean(weightedMapY(:));
    centroidCoord(iStim, :) = [weightedCoordX, weightedCoordY];
    
    axeH = axes('Parent', axeHParent, 'Color', 'white', 'Position', [X Y W H], 'Visible', 'on');
    axeHandles(end + 1) = axeH;  %#ok<AGROW>
    imagesc([1 imgW], [1 imgH], averageMap, 'Parent', axeH);
    hold(axeH, 'on');
    scatter(axeH, centroidCoord(iStim, 1), centroidCoord(iStim, 2), 25, stimColors(iStim, :), 'x');
    hold(axeH, 'off');
    cLimInd = 1 : 2;
    set(axeH, 'CLim', wfParams.powerMapCLim(cLimInd));
    text(imgW * 0.95, imgH * 0.9, '\bf\leftarrow A', 'Color', 'white', 'FontSize', 10, ...
        'HorizontalAlignment', 'right', 'Parent', axeH);
    text(imgW * 0.95, imgH * 0.95, '\bf\downarrow L', 'Color', 'white', 'FontSize', 10, ...
        'HorizontalAlignment', 'right', 'Parent', axeH);
    axis(axeH, 'equal');
    set(axeH, 'XLim', [1 imgW], 'YLim', [1 imgH], 'XAxisLocation', 'top');
    title(axeH, stimIDs{iStim}, 'FontSize', 13, 'Color', stimColors(iStim, :));
    hCBar = colorbar('EastOutside', 'peer', axeH);
    set(hCBar, 'FontSize', 8);
    xlabel(hCBar, '\DeltaF / F [%]', 'FontSize', 10);
    if iStim ~= 1;
        set(hCBar, 'Visible', 'off');
    end;
    set(axeH, 'XTick', [], 'YTick', []);
    colormap(axeH, 'jet'); figH = gcf;
    if figH ~= this.GUI.figH && ~strcmp(get(figH, 'Name'), 'ChunkFrames'); close(figH); end;
    cMap = colormap(axeH);
    cMap(1, :) = [0 0 0];
    colormap(axeH, cMap);
    
    stimMap = reshape(averageMaps(:, :, iStim), size(averageMaps, 1), size(averageMaps, 2));
    % apply thresholding
    stimBW = stimMap > thresh(min(iStim, numel(thresh)));
    stimBW = linScale(stimBW);
    stimPolys = bwboundaries(stimBW, 'noholes');
    [~, sortInd] = sort(-cellfun(@numel, stimPolys));
    stimPolys = stimPolys(sortInd);
    % plot outlines
    hold(axeH, 'on');
    for iPoly = 1 : min(numel(stimPolys), 2);
        stimPoly = stimPolys{iPoly};
        if numel(stimPoly) < 10; continue; end;
        stimPoly(:, 2) = stimPoly(:, 2) * (imgW / wfParams.nBins(1));
        stimPoly(:, 1) = stimPoly(:, 1) * (imgH / wfParams.nBins(2));
        plot(stimPoly(:, 2), stimPoly(:, 1), 'Color', 'black', 'LineWidth', 2, 'Parent', axeH);
    end;
    
%     % get center of mass
%     stimMapNoNaN = stimMap;
%     stimMapNoNaN(isnan(stimMapNoNaN)) = 0;
%     imagesc(stimMapNoNaN);
%     CoM = centerOfMass(stimMapNoNaN);
%     scatter(axeH, CoM(2), CoM(1), 60, 'white', 'Marker', 'o', 'MarkerFaceColor', 'white');
%     scatter(axeH, CoM(2), CoM(1), 20, 'red', 'Marker', 'o', 'MarkerFaceColor', 'red');
    
    hold(axeH, 'off');
    
    % update position
    Y = Y - H - HPad;
    iY = iY + 1;
    if iY > N;
        X = X + W + WPad;
        Y = baseY;
        iY = 1;
    end;
end;

%% ref image
Y = Y - H - HPad;
xScaleFact = imgW / this.an.wf.nBins(2);
yScaleFact = imgH / this.an.wf.nBins(1);
axeH = axes('Parent', axeHParent, 'Color', 'white', 'Position', [X Y 2 * W + WPad 2 * H + HPad], 'Visible', 'on');
axeHandles(end + 1) = axeH; 
imagesc([1 imgW], [1 imgH], refImg, 'Parent', axeH);
text(imgW * 0.95, imgH * 0.88, '\bf\leftarrow A', 'Color', 'white', 'FontSize', 8, ...
    'HorizontalAlignment', 'right', 'Parent', axeH);
text(imgW * 0.95, imgH * 0.95, '\bf\downarrow L', 'Color', 'white', 'FontSize', 8, ...
    'HorizontalAlignment', 'right', 'Parent', axeH);
axis(axeH, 'equal');
set(axeH, 'XLim', [1 imgW], 'YLim', [1 imgH], 'XAxisLocation', 'top');
hold(axeH, 'on');
plot(axeH, [midY, midY] .* yScaleFact, [0, imgW], 'Color', 'red', 'LineStyle', ':');
plot(axeH, [0, imgH], [midX, midX] .* xScaleFact, 'Color', 'red', 'LineStyle', ':');
plot(axeH, [0; imgH], [0; imgW], 'Color', 'red', 'LineStyle', ':');
line([0, imgW], [imgH, 0], 'Parent', axeH, 'Color', 'red', 'LineStyle', ':');
hold(axeH, 'off');
title(axeH, refImgTitle, 'FontSize', 10);
hCBar = colorbar('EastOutside', 'peer', axeH);
set(hCBar, 'FontSize', 10);
xlabel(hCBar, '[A. U.]', 'FontSize', 13);
set(hCBar, 'Visible', 'off');

% add overlay
hold(axeH, 'on');
for iStim = 1 : nStims;
        
    stimMap = reshape(averageMaps(:, :, iStim), wfParams.nBins);
    % apply thresholding
    stimBW = stimMap > thresh(min(iStim, numel(thresh)));
    stimBW = linScale(stimBW);
    stimPolys = bwboundaries(stimBW, 'noholes');
    [~, sortInd] = sort(-cellfun(@numel, stimPolys));
    stimPolys = stimPolys(sortInd);
    if ~isempty(stimPolys);
        mainPoly{iStim} = stimPolys{1};
    end;
    for iPoly = 1 : min(numel(stimPolys), 2);
        stimPoly = stimPolys{iPoly};
        if numel(stimPoly) < 10; continue; end;
        stimPoly(:, 2) = stimPoly(:, 2) * (imgW / wfParams.nBins(1));
        stimPoly(:, 1) = stimPoly(:, 1) * (imgH / wfParams.nBins(2));
        patch(stimPoly(:, 2), stimPoly(:, 1), stimColors(iStim, :), 'FaceAlpha', 0.15, ...
            'EdgeColor', stimColors(iStim, :), 'LineWidth', 1, 'Parent', axeH);
        lineH(iStim) = line(stimPoly(1 : 2, 2), stimPoly(1 : 2, 1), 'Color', stimColors(iStim, :), 'Parent', axeH);
    end;
    
%     % get center of mass
%     CoM = centerOfMass(stimMap);
%     scatter(axeH, CoM(2), CoM(1), 60, 'white', 'Marker', 'o', 'MarkerFaceColor', 'white');
%     scatter(axeH, CoM(2), CoM(1), 20, stimColors(iStim, :), 'Marker', 'o', 'MarkerFaceColor', stimColors(iStim, :));
end;
hold(axeH, 'off');
    
% update position
Y = Y - 2 * H - 2 * HPad;

%% ROI time series
axeH = axes('Parent', axeHParent, 'Color', 'white', 'Position', [X Y W * 2 + WPad * 1 H * 2 + HPad * 0.5], 'Visible', 'on');
axeHandles(end + 1) = axeH; 

% get the time-series
% trialsPSFramesMap = OCIA_analysis_widefield_getTrialsMappingMultiFreq(this, iDWRows(1));
% nFrames = size(trialsPSFramesMap, 5);
% nTrials = size(trialsPSFramesMap, 3);
% hold(axeH, 'on');
% % go through each stimulus
% for iStim = 1 : nStims;
%     % get the frames over threshold
%     stimMapTime = reshape(trialsPSFramesMap(:, :, :, iStim, :), [size(averageMaps, 1), size(averageMaps, 2), nTrials, nFrames]);
%     % get thresholding
%     stimMap = reshape(averageMaps(:, :, iStim), size(averageMaps, 1), size(averageMaps, 2));
%     stimBW = stimMap > thresh(min(iStim, numel(thresh)));
%     timeSerie = zeros(nFrames, 1);
%     for iFrame = 1 : nFrames;
%         stimMapForFrame = stimMapTime(:, :, iFrame);
%         timeSerie(iFrame) = nanmean(nanmean(stimMapForFrame(stimBW)));
%     end;
%     % plot the time-serie
%     plot(axeH, tPS, timeSerie, 'Color', stimColors(iStim, :), 'LineWidth', 2);
% end;
% % set limits
% xLims = [2 * tPS(1) - tPS(2), 2 * tPS(end) - tPS(end - 1)];
% xlim(axeH, xLims);
% yLims = get(axeH, 'YLim');
% % plot subRange
% plot(axeH, repmat(evokedTPS(subRange(1)), 1, 2), yLims, 'Color', 'blue');
% plot(axeH, repmat(evokedTPS(subRange(2)), 1, 2), yLims, 'Color', 'blue');
% % plot stimulus line
% plot(axeH, [0, 0], yLims, 'Color', 'red', 'LineStyle', ':');
% % plot threshold
% plot(axeH, xLims, repmat(thresh(1), 1, 2), 'Color', 'red', 'LineStyle', ':');
% hold(axeH, 'off');
% xlabel(axeH, 'Time [s]');
% ylabel(axeH, '\DeltaF / F [%]');

% update position
Y = baseY - H - HPad;
X = X + W + WPad;

%% ref image with maximum stimulus map
averageMapsNaN = averageMaps;
averageMapsNaN(averageMapsNaN < thresh(1)) = NaN;
[~, maxStimMap] = nanmax(averageMapsNaN, [], 3);
maxStimMap(all(isnan(averageMapsNaN), 3)) = NaN;

refImgDS = imresize(refImg, size(maxStimMap));
refImgRGB = linScale(repmat(double(refImgDS), [1, 1, 3]));
for x = 1 : size(refImgRGB, 2);
    for y = 1 : size(refImgRGB, 1);
        if ~isnan(maxStimMap(y, x));
            refImgRGB(y, x, :) = stimColors(maxStimMap(y, x), :);
        end;
    end;
end;

axeH = axes('Parent', axeHParent, 'Color', 'white', 'Position', [X Y 2 * W + WPad 2 * H + HPad], 'Visible', 'on');
axeHandles(end + 1) = axeH; 
imagesc([1 imgW], [1 imgH], refImgRGB, 'Parent', axeH);
text(imgW * 0.95, imgH * 0.88, '\bf\leftarrow A', 'Color', 'white', 'FontSize', 8, ...
    'HorizontalAlignment', 'right', 'Parent', axeH);
text(imgW * 0.95, imgH * 0.95, '\bf\downarrow L', 'Color', 'white', 'FontSize', 8, ...
    'HorizontalAlignment', 'right', 'Parent', axeH);
set(axeH, 'XTick', [], 'YTick', []);
axis(axeH, 'equal');
set(axeH, 'XLim', [1 imgW], 'YLim', [1 imgH]);
hCBar = colorbar('EastOutside', 'peer', axeH);
set(hCBar, 'FontSize', 10);
xlabel(hCBar, '[A. U.]', 'FontSize', 13);
set(hCBar, 'Visible', 'off');
    
% update position
X = X + 2 * W + 2 * WPad;
Y = baseY - H - HPad;

% link image axes
warning('off', 'MATLAB:linkaxes:RequireDataAxes');
linkaxes(axeHandles([1 : end - 2, end]), 'xy');
warning('on', 'MATLAB:linkaxes:RequireDataAxes');

%% line profiles
%{
axeH = axes('Parent', axeHParent, 'Color', 'white', 'Position', [X Y W H * 2 + HPad * 0.5], 'Visible', 'on');
axeHandles(end + 1) = axeH; 
hold(axeH, 'on');
% go through each stimulus
for iStim = 1 : nStims;
    averageMap = averageMaps(:, :, iStim);
    plot(axeH, 1 : size(averageMap, 1), averageMap(:, midX), 'Color', stimColors(iStim, :));
end;
hold(axeH, 'off');
ylabel(axeH, '\Delta F / F [%]');
xlabel(axeH, 'Antero-posterior axis');
set(axeH, 'XAxisLocation', 'top');
% update position
Y = Y - 2 * H - 2 * HPad;


axeH = axes('Parent', axeHParent, 'Color', 'white', 'Position', [X Y W H * 2 + HPad * 0.5], 'Visible', 'on');
axeHandles(end + 1) = axeH; 
hold(axeH, 'on');
% go through each stimulus
for iStim = 1 : nStims;
    averageMap = averageMaps(:, :, iStim);
    plot(axeH, 1 : size(averageMap, 2), averageMap(midY, :), 'Color', stimColors(iStim, :));
end;
hold(axeH, 'off');
ylabel(axeH, '\Delta F / F [%]');
xlabel(axeH, 'Medio-lateral axis');
% update position
X = X + W + WPad;
Y = baseY - H - HPad;


axeH = axes('Parent', axeHParent, 'Color', 'white', 'Position', [X Y W H * 2 + HPad * 0.5], 'Visible', 'on');
axeHandles(end + 1) = axeH;
hold(axeH, 'on');
% go through each stimulus
for iStim = 1 : nStims;
    averageMap = averageMaps(:, :, iStim);
    diag1 = diag(averageMap);
    plot(axeH, 1 : numel(diag1), diag1, 'Color', stimColors(iStim, :));
end;
hold(axeH, 'off');
xlabel(axeH, 'Top-left -> bottom right diag.');
set(axeH, 'YTick', [], 'XAxisLocation', 'top');
% update position
Y = Y - 2 * H - 2 * HPad;


axeH = axes('Parent', axeHParent, 'Color', 'white', 'Position', [X Y W H * 2 + HPad * 0.5], 'Visible', 'on');
axeHandles(end + 1) = axeH;
hold(axeH, 'on');
% go through each stimulus
for iStim = 1 : nStims;
    averageMap = averageMaps(:, :, iStim);
    diag2 = diag(fliplr(averageMap));
    plot(axeH, 1 : numel(diag2), diag2, 'Color', stimColors(iStim, :));
end;
hold(axeH, 'off');
xlabel(axeH, 'Top-right -> bottom left diag.');
set(axeH, 'YTick', []);
%}

%%
%{
axeConfig = cell(20, 12);
iConfig = 1;
axeConfig(iConfig, :) = { refImg, refImgTitle, 'gray', '', true, true, false, [], [], [], [], [] };
iConfig = iConfig + 1;

% add average maps to axe config
for iStim = 1 : nStims;
    axeConfig(iConfig, :) = { averageMapsNaN(:, :, iStim)', stimIDs{iStim}, 'jet', iff(iStim == 1, 'Scaled \DeltaF / F [%]', ''), ...
        false, false, false, [], wfParams.powerMapCLim, 1:2, wfParams.powerMapCLim, {'Min'; 'Max'} };
    iConfig = iConfig + 1;
end;

axeConfig(cellfun(@isempty, axeConfig(:, 1)), :) = [];

% plot the maps
axeHandles = OCIA_analysis_widefield_plotMaps(this, ceil(size(axeConfig, 1) / 2), 2, axeConfig, imgW, imgH, [], [0.00, 0.0]);

for iStim = 1 : nStims;
    stimMap = reshape(averageMapsNaN(:, :, iStim), size(averageMapsNaN, 1), size(averageMapsNaN, 2));
    % apply thresholding
    stimBW = stimMap > thresh(min(iStim, numel(thresh)));
    stimBW = linScale(stimBW);
    stimPolys = bwboundaries(stimBW, 'noholes');
    [~, sortInd] = sort(-cellfun(@numel, stimPolys));
    stimPolys = stimPolys(sortInd);
    % plot outlines
    hold(axeHandles(iStim + 1), 'on');
    for iPoly = 1 : min(numel(stimPolys), 2);
        stimPoly = stimPolys{iPoly};
        if numel(stimPoly) < 10; continue; end;
        stimPoly(:, 1) = stimPoly(:, 1) * (imgW / wfParams.nBins(1));
        stimPoly(:, 2) = stimPoly(:, 2) * (imgH / wfParams.nBins(2));
        plot(stimPoly(:, 1), stimPoly(:, 2), 'Color', 'black', 'LineWidth', 2, 'Parent', axeHandles(iStim + 1));
    end;
    hold(axeHandles(iStim + 1), 'off');
end;
o('#%s: plot done (%3.1f sec).', mfilename(), toc(plotTic), 2, this.verb);    

%}

% hide the message and show plot
ANShowHideMessage(this, 0, 'Update analyser plot done.');


end
