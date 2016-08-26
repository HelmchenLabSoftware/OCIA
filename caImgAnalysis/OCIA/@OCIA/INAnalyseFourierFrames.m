function INAnalyseFourierFrames(this)
% INAnalyseFourierFrames - [no description]
%
%       INAnalyseFourierFrames(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

showMessage(this, 'Intrinsic: analysing fourier experiment ...', 'yellow');

% get data and variables
frames = this.in.data.stimFrames;
imgDim = [size(frames, 1), size(frames, 2)];
camFPS = this.in.fourier.realCamFPS;

interval = 0.05;
stimFreqInterv = this.in.fourier.stimFreqAll .* (1 + interval * [-1 1]);
% stimFreqInterv = this.in.fourier.stimFreqSingle .* (1 + interval * [-1 1]);

% how to open figures
figArgs = { 'NumberTitle', 'off', 'WindowStyle', 'docked', 'Position', [1 1 1280 905] };

%% downsample, filter, etc.
temporalDSFactor = this.in.fourier.temporalDSFactor;
if temporalDSFactor > 1;
    camFPS = camFPS / temporalDSFactor;
    showMessage(this, sprintf('Intrinsic: temporal down-sampling stim. frames by a factor of %d ...', temporalDSFactor), 'yellow');
    if mod(size(frames, 3), temporalDSFactor) > 0;
        frames(:, :, end - mod(size(frames, 3), temporalDSFactor) + 1 : end) = [];
    end;
    frames = downSampleBinAvg(frames, 3, temporalDSFactor);
end;

%% draw sub-region ROI
showMessage(this, 'Intrinsic: selecting sub-region ...', 'yellow');
refImg = this.in.data.refImg;

figure('Name', 'Reference image', figArgs{:});
imH = imagesc(refImg);
axeH = get(imH, 'Parent');

ROIHandle = imrect(axeH);
if isempty(ROIHandle); return; end;
ROIPos = round(ROIHandle.getPosition());

% reduce the region to the selected area
refImg = refImg(ROIPos(2) : (ROIPos(2) + ROIPos(4)), ROIPos(1) : (ROIPos(1) + ROIPos(3)));
frames = frames(ROIPos(2) : (ROIPos(2) + ROIPos(4)), ROIPos(1) : (ROIPos(1) + ROIPos(3)), :);

% re-adjust image dim
imgDim = [size(frames, 1), size(frames, 2)];


%% analyse FFT mean signal
stimSign = squeeze(mean(mean(frames, 1), 2));
stimSignLength = numel(stimSign);
stimFFT = fft(stimSign, stimSignLength) / stimSignLength;
stimFFT(1) = 0;
stimFInds = 1 : floor(stimSignLength / 2);
stimFreqVect = (camFPS / 2) * linspace(0, 1, numel(stimFInds));
stimStimIndexes = stimFreqVect > stimFreqInterv(1) & stimFreqVect < stimFreqInterv(2);
stimPowVect = 2 * abs(stimFFT(stimFInds));
stimPower = nanmean(stimPowVect(stimStimIndexes));
showMessage(this, sprintf('Intrinsic: power at stimulus frequency (%.3f Hz) = %.3f ...', this.in.fourier.stimFreqAll, stimPower), 'yellow');

figure('Name', 'LogLog on mean signal', figArgs{:});
loglog(stimFreqVect, stimPowVect, 'r');

%% analyse FFT
showMessage(this, 'Intrinsic: fourier analysis ...', 'yellow'); pause(0.05);
nPixels = prod(imgDim);
fftVects = cell(1, nPixels);
fourierTic = tic; % for performance timing purposes
% make the fourier analysis independently for each pixel
parfor iPixPF = 1 : nPixels;
    [y, x] = ind2sub(imgDim, iPixPF);
    signal = squeeze(frames(y, x, :))'; %#ok<PFBNS>     
    signLength = numel(signal);
    fftVects{iPixPF} = fft(signal, signLength) / signLength;
    fftVects{iPixPF}(1) = fftVects{iPixPF}(2); % remove artifact    
end;
showMessage(this, sprintf('Intrinsic: fourier analysis done (%.1f sec) ...', toc(fourierTic)));


%% analyse power and phase
showMessage(this, 'Intrinsic: power and phase extraction ...', 'yellow'); pause(0.05);
mapTic = tic; % for performance timing purposes
powVects = cell(1, nPixels);
phaseVects = cell(1, nPixels);
signLength = size(frames, 3);
fInds = 1 : floor(signLength / 2);
freqVect = (camFPS / 2) * linspace(0, 1, numel(fInds));
parfor iPix = 1 : nPixels;
    powVects{iPix} = abs(fftVects{iPix}(fInds)) .^ 2;
%     powVect = 2 * abs(fftVects{iPix}(fInds));
    phaseVects{iPix} = angle(fftVects{iPix}(fInds));
end;
showMessage(this, sprintf('Intrinsic: power and phase extraction done (%.1f sec) ...', toc(mapTic)));
   
%% plot power and phase
map2Tic = tic; % for performance timing purposes
showMessage(this, 'Intrinsic: power and phase map creation ...', 'yellow'); pause(0.05);
powerMap = zeros(imgDim);
phaseMap = zeros(imgDim);
stimIndexes = find(freqVect > stimFreqInterv(1) & freqVect < stimFreqInterv(2));
parfor iPix = 1 : prod(imgDim);
    powerMap(iPix) = nanmean(powVects{iPix}(stimIndexes));
    phaseMap(iPix) = nanmean(phaseVects{iPix}(stimIndexes));
end;
showMessage(this, sprintf('Intrinsic: power and phase map creation done (%.1f sec) ...', toc(map2Tic)));

powerMap = imfilter(powerMap, fspecial('gaussian', [15 15], 5));
powerMapMask = ones(size(powerMap));
phaseMap = imfilter(phaseMap, fspecial('gaussian', [10 10], 3));
phaseMap = medfilt2(phaseMap, [10 10]);
powerMap(~powerMapMask) = NaN;
phaseMap(~powerMapMask) = NaN;

%% create window area mask
showMessage(this, 'Intrinsic: power and phase map creation ...', 'yellow'); pause(0.05);
figure('Name', 'Window area selection', figArgs{:});
imagesc(refImg);
windAreaROIHandle = imfreehand();
windAreaMask = windAreaROIHandle.createMask();

% mask the non-selected regions
refImg = linScale(refImg);
refImg(~windAreaMask) = 1;
powerMap(~windAreaMask) = 0;
phaseMap(~windAreaMask) = 0;
refImageRGB = repmat(refImg, [1 1 3]);

powerMapThreshValue = 0.018;
powerMapThresh = powerMap;
powerMapThresh(powerMapThresh < powerMapThreshValue) = NaN;

figure('Name', 'powerMap2', figArgs{:});
cMap = hot(300);
cMap(1 : 100, :) = [];
nContours = 20;
colormap(cMap);
imagesc(refImageRGB);
set(gca, 'XTick', [], 'YTick', []);
hold on;
[~, h] = contourf(powerMapThresh, nContours);
child = get(h, 'Children');
set(child, 'FaceAlpha', 0.15, 'EdgeColor', 'none');
[~, h] = contour(powerMapThresh, [powerMapThreshValue powerMapThreshValue]);
set(get(h, 'Child'), 'LineWidth', 2, 'EdgeColor', 'black');


figure('Name', 'phaseMap', figArgs{:});
cMap = hsv(300);
cMap(1 : 100, :) = [];
colormap(cMap);
imagesc(refImageRGB);
set(gca, 'XTick', [], 'YTick', []);
hold on;
nContours = 20;
phaseMapThresh = phaseMap;
phaseMapThresh(powerMap < powerMapThreshValue) = NaN;
[~, h] = contourf(phaseMapThresh, nContours);
child = get(h, 'Children');
set(child, 'FaceAlpha', 0.15, 'EdgeColor', 'none');
[~, h] = contour(powerMapThresh, [powerMapThreshValue powerMapThreshValue]);
set(get(h, 'Child'), 'LineWidth', 2, 'EdgeColor', 'black');

   
%% try different frequencies
interval = 2;
freqsToTry = freqVect(1 : round((1 / 5) * numel(freqVect)) : numel(freqVect));
nFreqsToTry = numel(freqsToTry);

powerMaps = zeros([imgDim, nFreqsToTry]);
phaseMaps = zeros([imgDim, nFreqsToTry]);
% powerMapCLim = [0.005 0.2]; phaseMapCLim = [-pi pi];
powerMapCLim = [0.5 1]; phaseMapCLim = [-pi pi];

figure('Name', 'phaseAndPowerMapsFreqsTry', figArgs{:});
for iFreq = 1 : nFreqsToTry;
    mapTic = tic;
    stimIndex = find(freqVect == freqsToTry(iFreq));
    stimIndexes = (stimIndex - interval) : (stimIndex + interval);
    stimIndexes = min(max(stimIndexes, 1), numel(freqVect));
    stimFreqInterv = freqVect([stimIndexes(1), stimIndexes(end)]);
    for iPix = 1 : prod(imgDim);
        [i, j] = ind2sub(imgDim, iPix);
        powerMaps(i, j, iFreq) = nanmean(powVects{iPix}(stimIndexes));
        phaseMaps(i, j, iFreq) = nanmean(phaseVects{iPix}(stimIndexes));
    end;
    poMap = squeeze(powerMaps(:, :, iFreq));
    poMap = imfilter(poMap, fspecial('gauss'));
    phMap = squeeze(phaseMaps(:, :, iFreq));
    subplot(2, nFreqsToTry, iFreq);
    imagesc(poMap, powerMapCLim);
    title(sprintf('PowerMap@%.3fHz-%.3fHz', stimFreqInterv));
    subplot(2, nFreqsToTry, iFreq + nFreqsToTry);
    imagesc(phMap, phaseMapCLim);
    title(sprintf('PhaseMap@%.3fHz-%.3fHz', stimFreqInterv));
    showMessage(this, sprintf('Intrinsic: maps extractions for %.3fHz-%.3fHz done (%.3f sec)', stimFreqInterv, toc(mapTic)));
end;

end
