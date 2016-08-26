function INAnalyseFourier(this, ~, ~)
% INAnalyseFourier - [no description]
%
%       INAnalyseFourier(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

showMessage(this, 'Intrinsic: analyse fourier ...');
    
% get parameter structure
params = this.in.fourier;
% performance measure
analyseTic = tic;

% check if data is available
if isempty(params.camFPS);
    showWarning(this, 'OCIA:INAnalyseFourier:NoData', 'Intrinsic: missing camera frame rate.');
    return;
end;

% get size of dataset, time vector and axis handle
[H, W, nFrames] = size(this.in.data.stimFrames);
t = (1 : nFrames) / params.camFPS;
anAxeH = this.GUI.handles.in.anAxe;

% clear axes
cla(anAxeH);

% gather infos about original axe
basePos = get(anAxeH, 'Position');
axeHParent = get(anAxeH, 'Parent');

% plots in new figure or in analyser panel of intrinsic pannel
newFigs = true;
figArgs = { 'Position', [100 100 1200 800] };

% remove everything except AnAxe
childrenOfAxeHParent = get(axeHParent, 'Children');
childTags = get(childrenOfAxeHParent, 'Tag');
childrenOfAxeHParent(strcmp(childTags, 'INAnAxe')) = [];
delete(childrenOfAxeHParent);
pause(0.05);
% reset axe handles
this.GUI.in.fouSubAxeHands = struct();

% hide the original axe
set(anAxeH, 'YTick', [], 'XTick', [], 'XColor', 'white', 'YColor', 'white', 'Visible', 'on');
    
%% time course
% get number of bins
nBins = params.NBins;

% binning mode
binMode = iff(nBins > 0, 'bin', 'ROI');

% get the data in memory
hashStruct = struct('nBins', nBins, 'dataSetSize', [H, W, nFrames], 'camFPS', params.camFPS, ...
    'binMode', binMode, 'dataType', 'wideFieldFourierPixelTimeCourse');
cachedData = ANGetCachedData(this, 'in', hashStruct);

% if the data is not in cache yet, generate it
if isempty(cachedData);

    % binning pixels
    if strcmp(binMode, 'bin');

        % check if binning factor is a divider of the image size (same pixel number in each bin)
        if mod(H, nBins) ~= 0 || mod(W, nBins) ~= 0;
            showWarning(this, 'OCIA:INPixelTimeCourse:BadBinning', ...
                'Intrinsic: binning factor is not a perfect divider for image size.');
            return;
        end;

        % get bin size
        binSizeX = W / nBins; binSizeY = H / nBins;
        showMessage(this, sprintf('Intrinsic: analyse fourier: binning mode ''bin'', binSizeX = %d, binSizeY = %d.', ...
            binSizeX, binSizeY));

        % calculate pixel time course for each bin
        pixelTimeCourse = nan(nBins * nBins, nFrames);
        for iBin = 1 : nBins * nBins;
            % get bin's X and Y range
            [iY, iX] = ind2sub([nBins, nBins], iBin);
            xRange = ((iX - 1) * binSizeX + 1) : (iX * binSizeX);
            yRange = ((iY - 1) * binSizeY + 1) : (iY * binSizeY);
            % get average of selected pixels
            pixelTimeCourse(iBin, :) = reshape(nanmean(nanmean( ...
                this.in.data.stimFrames(yRange, xRange, :), 1), 2), 1, nFrames);
        end;

    % ROI mode
    elseif strcmp(binMode, 'ROI');

        nBins = abs(nBins);
        pixelTimeCourse = nan(nBins * nBins, nFrames);
        for iROI = 1 : nBins;
            if nBins == 1 && isempty(this.GUI.in.freeHandROIHandle) || ~isvalid(this.GUI.in.freeHandROIHandle);
                freeHandROIHandle = imfreehand(this.GUI.handles.in.refAxe);
                ROIMask = freeHandROIHandle.createMask();
                this.GUI.in.freeHandROIHandle = freeHandROIHandle;
            else
                freeHandROIHandle = imfreehand(this.GUI.handles.in.refAxe);
                ROIMask = freeHandROIHandle.createMask();
                delete(freeHandROIHandle);
            end;
            stimFrames = this.in.data.stimFrames;
            parfor iFrame = 1 : nFrames;
                frame = stimFrames(:, :, iFrame);
                pixelTimeCourse(iROI, iFrame) = nanmean(frame(ROIMask));
            end;
        end;

    end;


    showMessage(this, 'Intrinsic: correcting traces ...');
    % time course corrections: high-pass filter with a filter of N times the stimulation frequency
    N = 3;
    windowSize = N * this.in.fourier.camFPS / this.in.fourier.stimFreqSingle;
    parfor iBin = 1 : nBins * nBins;
        % get the trace
        trace = pixelTimeCourse(iBin, :);
        % high-pass filter with a filter of N times the stimulation frequency
        slidingAvg = zeros(size(trace));
        for iFrame = 1 : nFrames;
            slidingAvg(iFrame) = nanmean(trace( ...
                max(round(iFrame - 0.5 * windowSize), 1) : min(round(iFrame + 0.5 * windowSize), nFrames)));
        end;
        slidWindCorrTrace = trace - slidingAvg;
        % store
        pixelTimeCourse(iBin, :) = slidWindCorrTrace;

        %{ 
        %% debug plot      
        figure('Name', 'Correction debug plot', 'WindowStyle', 'docked');
        subplot(2, 2, 1);  plot(rawTrace); title('Raw'); 
        subplot(2, 2, 2);
        hold(gca, 'on'); plot(medCorrTrace); plot(slidingAvg, 'r'); hold(gca, 'off'); title('Median-baseline corrected');
        subplot(2, 2, 3); plot(slidWindCorrTrace); title('Sliding window corrected');
        subplot(2, 2, 4); validIndexes = 1 : floor(nFrames / 2);
        freqVect = (params.camFPS / 2) * linspace(0, 1, numel(validIndexes));
        FFTVectAll = fft(slidWindCorrTrace, nFrames) / nFrames; FFTVectAll(1) = 0;
        FFTVectValid = FFTVectAll(validIndexes); powVect = abs(FFTVectValid) .^ 2;
        loglog(freqVect, powVect); set(gca, 'XLim', [freqVect(1), freqVect(end)]);
        %}
    end;
    
    % store the variables in the cached structure
    cachedData = struct('pixelTimeCourse', pixelTimeCourse, 'dataType', 'wideFieldFourierPixelTimeCourse', ...
        'params', hashStruct);
    % store the data in memory
    ANStoreCachedData(this, 'in', hashStruct, cachedData);
    
% if data was directly in memory, fetch it
else
    
    % fetch the data
    showMessage(this, 'Intrinsic: fetching time course from cache ...');
    pixelTimeCourse = cachedData.pixelTimeCourse;

end;

% get subplot sizes
if strcmp(binMode, 'bin');
    M = 2; N = 3;
elseif strcmp(binMode, 'ROI');
    M = 1; N = 2;
end;

% select the color scheme
cols = jet(nBins * nBins);
if nBins * nBins == 1;
    cols = [1 0 0];
elseif nBins * nBins == 2;
    cols = [1 0 0; 0 0 1;];
elseif nBins * nBins == 3;
    cols = [1 0 0; 0 1 0; 0 0 1];
elseif nBins * nBins == 4;
    cols = [1 0 0; 0 1 0; 0 0 1; 1 1 0];
end;

% get the dimensions of the subplots
WPad = basePos(3) * 0.07; axeW = (basePos(3) - (M - 1) * WPad) / M + 0.007;
HPad = basePos(4) * 0.12; axeH = (basePos(4) - (N - 1) * HPad) / N;
axeX = basePos(1) - 0.01; axeY = basePos(2) + (N - 1) * (axeH + HPad) - 0.01;

% open new fig if needed
if newFigs;
    [axeX, axeY, axeW, axeH] = deal(0.1, 0.1, 0.8, 0.8);
    axeHParent = figure(figArgs{:});
end;

showMessage(this, 'Intrinsic: plotting pixel time course ...');
currAxeH = axes('Parent', axeHParent, 'Color', 'white', 'Position', [axeX axeY axeW axeH], 'Tag', 'INPixTimeCourseAxe');
% store handle
this.GUI.in.fouSubAxeHands.pixTC = currAxeH;
% update axe position
axeX = axeX + axeW + WPad;
if axeX >= basePos(1) + basePos(3);
    axeX = basePos(1); 
    axeY = axeY - axeH - HPad;
end;

% subplot(axeH, 2, 1, 1);
hold(currAxeH, 'on');
for iBin = 1 : nBins * nBins;
    % do not plot everything
    if nBins * nBins > 50 && mod(iBin, 5) ~= 0; continue; end;
    if nBins * nBins > 100 && mod(iBin, 10) ~= 0; continue; end;
    if nBins * nBins > 500 && mod(iBin, 50) ~= 0; continue; end;
    if nBins * nBins > 1000 && mod(iBin, 100) ~= 0; continue; end;
    if nBins * nBins > 5000 && mod(iBin, 500) ~= 0; continue; end;
    if nBins * nBins > 10000 && mod(iBin, 1000) ~= 0; continue; end;
    plot(currAxeH, t, reshape(pixelTimeCourse(iBin, :), 1, nFrames), 'Color', cols(iBin, :));
end;

hold(currAxeH, 'off');
if newFigs;
    makePrettyFigure();
end;

% annotate axes
% set(currAxeH, 'XLim', [t(1) - t(2) t(end) + (t(end) - t(end - 1))], 'FontSize', iff(newFigs, 20, 13));
set(currAxeH, 'XLim', [-0.5 5.5], 'FontSize', iff(newFigs, 20, 13));
% set(currAxeH, 'XLim', [t(1) - t(2) t(end) + (t(end) - t(end - 1))], 'YLim', params.pixTCYLim);
xlabel(currAxeH, 'Time [sec]', 'FontSize', iff(newFigs, 28, 13));
ylabel(currAxeH, 'Fluorescence [a.u.]', 'FontSize', iff(newFigs, 28, 13));

% adjust limit automatically
this.in.fourier.pixTCYLim = get(currAxeH, 'YLim');
set(this.GUI.handles.in.paramPanElems.pixTCYLim, 'String', ...
    ['[' regexprep(num2str(this.in.fourier.pixTCYLim), ' +', ' ') ']']);

if newFigs;
    export_fig([this.path.OCIASave 'pixelTimeCourse.png'], '-r75', gcf);
end;
%% spectrogram
% open new fig if needed
if newFigs;
    [axeX, axeY, axeW, axeH] = deal(0.1, 0.1, 0.8, 0.8);
    axeHParent = figure(figArgs{:});
end;
currAxeH = axes('Parent', axeHParent, 'Color', 'white', 'Position', [axeX axeY axeW axeH], 'Tag', 'INSpectroAxe');
% store handle
this.GUI.in.fouSubAxeHands.spectr = currAxeH;
% update axe position
axeX = axeX + axeW + WPad;
if axeX >= basePos(1) + basePos(3);
    axeX = basePos(1); 
    axeY = axeY - axeH - HPad;
end;

% get analysable frequencies
validIndexes = 1 : floor(nFrames / 2);
freqVect = (params.camFPS / 2) * linspace(0, 1, numel(validIndexes));
    
% get the data in memory
hashStruct.dataType = 'wideFieldFourierFFT';
cachedData = ANGetCachedData(this, 'in', hashStruct);

% if the data is not in cache yet, generate it
if isempty(cachedData);
    
    showMessage(this, 'Intrinsic: calculating FFTs ...');

    % analyse FFT mean signal
    powVect = nan(nBins, numel(validIndexes));
    phaseVect = nan(nBins, numel(validIndexes));
    parfor iBin = 1 : nBins * nBins;
        signal = pixelTimeCourse(iBin, :);
        FFTVectAll = fft(signal, nFrames) / nFrames;
        FFTVectAll(1) = 0;
        FFTVectValid = FFTVectAll(validIndexes);
        powVect(iBin, :) = abs(FFTVectValid) .^ 2;
        phaseVect(iBin, :) = angle(FFTVectValid);
    end;
    
    % store the variables in the cached structure
    cachedData = struct('powVect', powVect, 'phaseVect', phaseVect, 'dataType', 'wideFieldFourierFFT', ...
        'params', hashStruct);
    % store the data in memory
    ANStoreCachedData(this, 'in', hashStruct, cachedData);
    
% if data was directly in memory, fetch it
else
    
    % fetch the data
    showMessage(this, 'Intrinsic: fetching FFT vects from cache ...');
    powVect = cachedData.powVect;
    phaseVect = cachedData.phaseVect;

end;

showMessage(this, 'Intrinsic: plotting spectrogram ...');
hold(currAxeH, 'on');
for iBin = 1 : nBins * nBins;
    % do not plot everything
    if nBins * nBins > 50 && mod(iBin, 25) ~= 0; continue; end;
    if nBins * nBins > 100 && mod(iBin, 50) ~= 0; continue; end;
    if nBins * nBins > 500 && mod(iBin, 250) ~= 0; continue; end;
    if nBins * nBins > 1000 && mod(iBin, 500) ~= 0; continue; end;
    plot(currAxeH, freqVect, powVect(iBin, :), 'Color', cols(iBin, :));
end;
hold(currAxeH, 'off');
if newFigs;
    makePrettyFigure();
end;
% set(currAxeH, 'YScale', 'log', 'YLim', params.spectrYLim, 'XLim', [freqVect(1) freqVect(end)]);
set(currAxeH, 'XScale', 'log', 'YScale', 'log', 'XLim', [freqVect(1) freqVect(end)], 'FontSize', iff(newFigs, 20, 13));
xlabel(currAxeH, 'Frequency [Hz]', 'FontSize', iff(newFigs, 28, 12));
ylabel(currAxeH, 'Power [a.u.]', 'FontSize', iff(newFigs, 28, 12));

% adjust limit automatically
this.in.fourier.spectrYLim = get(currAxeH, 'YLim');
set(this.GUI.handles.in.paramPanElems.spectrYLim, 'String', ...
    ['[' regexprep(num2str(this.in.fourier.spectrYLim), ' +', ' ') ']']);

% add label for currently analysed frequency
hold(currAxeH, 'on');
[~, stimFreqIndex] = min(abs(freqVect - params.stimFreqSingle));
this.GUI.in.fouSubAxeHands.spectrArrow = text(freqVect(stimFreqIndex), this.in.fourier.spectrYLim(end) * 0.8, ...
    '\downarrow', 'FontSize', iff(newFigs, 25, 10), 'Color', 'black', 'HorizontalAlignment', 'Center', ...
    'VerticalAlignment', 'bottom', 'Parent', currAxeH);
this.GUI.in.fouSubAxeHands.spectrArrowTxt = text(freqVect(stimFreqIndex) * 1.2, this.in.fourier.spectrYLim(end), ...
    'Stim. freq.', 'FontSize', iff(newFigs, 25, 10), 'Color', 'black', 'HorizontalAlignment', 'Left', ...
    'VerticalAlignment', 'bottom', 'Parent', currAxeH);
hold(currAxeH, 'off');

if newFigs;
    export_fig([this.path.OCIASave 'spectrogram.png'], '-r75', gcf);
end;
% abort unless binning mode is on
if ~strcmp(binMode, 'bin'); return; end;

%% power map
% open new fig if needed
if newFigs;
    [axeX, axeY, axeW, axeH] = deal(0.1, 0.1, 0.8, 0.8);
    axeHParent = figure(figArgs{:});
    currAxeH = axes('Parent', axeHParent, 'Color', 'white', 'Tag', 'INPhaseMapAxe', 'Position', [axeX axeY axeW axeH]);
else 
    currAxeH = axes('Parent', axeHParent, 'Color', 'white', 'Tag', 'INPowerMapAxe', ...
        'Position', [axeX - 0.05 axeY - 1.75 * axeH  axeW * 1.1 2.25 * axeH]);
end;
% store handle
this.GUI.in.fouSubAxeHands.powerMap = currAxeH;
% update axe position
axeX = axeX + axeW + WPad;
if axeX >= basePos(1) + basePos(3);
    axeX = basePos(1);
    axeY = axeY - 2.25 * axeH - HPad;
end;

powerMap = zeros(nBins);
phaseMap = zeros(nBins);
% stimFreq = stimFreq + params.stimFreqSingle;
parfor iBin = 1 : nBins * nBins;
    powerMap(iBin) = powVect(iBin, stimFreqIndex);
    phaseMap(iBin) = phaseVect(iBin, stimFreqIndex);
end;
% if gaussian filtering is requested, apply it
if sum(params.powerMapFilt(1 : 3)) > 0;
    powerMap = imfilter(powerMap, fspecial('gaussian', params.powerMapFilt(1 : 2), params.powerMapFilt(3)));
end;
% if median filtering is requested, apply it
if sum(params.powerMapFilt(4 : 5)) > 0;
    powerMap = medfilt2(powerMap, params.powerMapFilt(4 : 5));
end;
% if gaussian filtering is requested, apply it
if sum(params.phaseMapFilt(1 : 3)) > 0;
    phaseMap = imfilter(phaseMap, fspecial('gaussian', params.phaseMapFilt(1 : 2), params.phaseMapFilt(3)));
end;
% if median filtering is requested, apply it
if sum(params.phaseMapFilt(4 : 5)) > 0;
    phaseMap = medfilt2(phaseMap, params.phaseMapFilt(4 : 5));
end;

% plot and store handle of image
% logPowerMap = log10(powerMap);
% this.GUI.in.fouSubAxeHands.powerMapImg = imagesc([1 W], [1 H], logPowerMap, 'Parent', currAxeH);
this.GUI.in.fouSubAxeHands.powerMapImg = imagesc([1 W], [1 H], powerMap, 'Parent', currAxeH);
if newFigs;
    axis(currAxeH, 'equal');
    makePrettyFigure();
end;
% ylabel(currAxeH, 'Power Map', 'Color', 'black', 'FontSize', 12);
title(currAxeH, sprintf('Power Map @ %.3f Hz', this.in.fourier.stimFreqSingle), 'FontSize', iff(newFigs, 25, 12));
hColorBar = colorbar('EastOutside', 'peer', currAxeH);
this.GUI.in.fouSubAxeHands.powerMapColBar = hColorBar;
set(hColorBar, 'FontSize', iff(newFigs, 15, 8));
set(currAxeH, 'YTick', [], 'XTick', [], 'XColor', 'white', 'YColor', 'white');
colormap(this.GUI.in.fouSubAxeHands.powerMap, 'gray'); if ~newFigs; close(gcf); end;

% adjust limit automatically
this.in.fourier.powerMapCLim = [1, round(max(powerMap(:)))];
% this.in.fourier.powerMapCLim = [1, roundn(max(powerMap(:)), -1)];
cLim = this.in.fourier.powerMapCLim;
set(this.GUI.handles.in.paramPanElems.powerMapCLim, 'String', ['[' regexprep(num2str(cLim), ' +', ' ') ']']);
% cLim = log10(cLim);
set(this.GUI.in.fouSubAxeHands.powerMap, 'CLim', cLim);
YTick = cLim(1) : diff(cLim([1, end])) / 10 : cLim(end);
% YTickLabel = round(10 .^ YTick);
% set(hColorBar, 'YTick', YTick, 'YTickLabel', YTickLabel);

if newFigs;
    export_fig([this.path.OCIASave 'powerMap.png'], '-r75', gcf);
end;

%% phase map
showMessage(this, 'Intrinsic: calculating phase map ...');
% open new fig if needed
if newFigs;
    [axeX, axeY, axeW, axeH] = deal(0.1, 0.1, 0.8, 0.8);
    axeHParent = figure(figArgs{:});
    currAxeH = axes('Parent', axeHParent, 'Color', 'white', 'Tag', 'INPhaseMapAxe', 'Position', [axeX axeY axeW axeH]);
else
    currAxeH = axes('Parent', axeHParent, 'Color', 'white', 'Tag', 'INPhaseMapAxe', ...
        'Position', [axeX - 0.05 axeY - 1.75 * axeH  axeW * 1.1 2.25 * axeH]);
end;
% store handle
this.GUI.in.fouSubAxeHands.phaseMap = currAxeH;
% update axe position
axeX = axeX + axeW + WPad;
if axeX >= basePos(1) + basePos(3);
    axeX = basePos(1); 
    axeY = axeY - 2.5 * axeH - HPad;
end;

% get lower threshold of power map
powerMapMask = powerMap < this.in.fourier.powerMapThresh(1);
% mask values of phase map that do not have enough power with NaN
phaseMap(powerMapMask) = 0;

% plot and store handle of image
this.GUI.in.fouSubAxeHands.phaseMapImg = imagesc([1 W], [1 H], phaseMap, 'Parent', currAxeH);
if newFigs;
    axis(currAxeH, 'equal');
    makePrettyFigure();
end;
% ylabel(currAxeH, 'Phase Map', 'Color', 'black', 'FontSize', 12);
title(currAxeH, sprintf('Phase Map @ %.3f Hz', this.in.fourier.stimFreqSingle), 'FontSize', iff(newFigs, 25, 12));
hColBar = colorbar('EastOutside', 'peer', currAxeH);
set(hColBar, 'FontSize', iff(newFigs, 15, 8));
set(currAxeH, 'YTick', [], 'XTick', [], 'XColor', 'white', 'YColor', 'white');
colormap(this.GUI.in.fouSubAxeHands.phaseMap, 'jet'); if ~newFigs; close(gcf); end;

% adjust limit automatically
% this.in.fourier.phaseMapCLim = [roundn(min(phaseMap(:)), -1), roundn(max(phaseMap(:)), -1)];
this.in.fourier.phaseMapCLim = [round(min(phaseMap(:))), round(max(phaseMap(:)))];
set(this.GUI.handles.in.paramPanElems.phaseMapCLim, 'String', ...
    ['[' regexprep(num2str(this.in.fourier.phaseMapCLim), ' +', ' ') ']']);

if newFigs;
    export_fig([this.path.OCIASave 'phaseMap.png'], '-r75', gcf);
end;
%% update GUI
linkaxes([this.GUI.in.fouSubAxeHands.powerMap, this.GUI.in.fouSubAxeHands.phaseMap, this.GUI.handles.in.refAxe], 'xy');
INUpdateGUI(this);

showMessage(this, sprintf('Intrinsic: fourier analysis done (%.3f sec).', toc(analyseTic)));

% %% test
% powerMapData = get(this.GUI.in.fouSubAxeHands.powerMapImg, 'CData');
% phaseMapData = get(this.GUI.in.fouSubAxeHands.phaseMapImg, 'CData');
% figure('WindowStyle', 'docked');
% 
% subplot(2, 2, 1);
% imagesc(phaseMapData);
% colorbar();
% set(gca, 'CLim', [1.2 pi]);
% subplot(2, 2, 2);
% imagesc(powerMapData);
% colorbar();
% set(gca, 'CLim', [1 140]);
% 
% subplot(2, 2, 3);
% imagesc(log2(phaseMapData - min(phaseMapData(:))));
% set(gca, 'CLim', log2([1.2 pi] - min(phaseMapData(:))));
% hColBar = colorbar();
% set(hColBar, 'YTickLabel', roundn((get(hColBar, 'YTick') .^ 2) + min(phaseMapData(:)), -2));
% subplot(2, 2, 4);
% imagesc(log2(powerMapData));
% set(gca, 'CLim', log2([1 140]));
% hColBar2 = colorbar();
% set(hColBar2, 'YTickLabel', get(hColBar2, 'YTick') .^ 2);
% tightfig();
% set(gcf, 'WindowStyle', 'docked');

end