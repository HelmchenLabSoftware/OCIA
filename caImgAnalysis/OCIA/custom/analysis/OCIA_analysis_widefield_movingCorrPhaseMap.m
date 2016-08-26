function OCIA_analysis_widefield_movingCorrPhaseMap(this, iDWRows)
% OCIA_analysis_widefield_movingCorrPhaseMap - [no description]
%
%       OCIA_analysis_widefield_movingCorrPhaseMap(this, iDWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

nFrameChunks = iff(numel(this.an.wf.frameRange) >= 3, this.an.wf.frameRange, 1, 3);

%% plotting parameter UI controls
paramConf = cell2table({ ...
... categ  id                   UIType  valueType       UISize  isLabAbove      label               tooltip
    'wf',  'powerMapCLim',      'text', { 'array' },    [1 0],  true,           'Power CLim',       'Color limits.';
    'wf',  'phaseMapCLim',      'text', { 'array' },    [1 0],  true,           'Phase CLim',       'Color limits.';
    'wf',  'dispMode',          'dropdown', { 'phase', 'pitch', 'HSV' }, [1 0], false, 'Disp. mode', 'Display mode for phase map.';
    'wf',  'iFrame',            'slider', { @OCIA_analysis_wideField_changeIFrame2, 1, nFrameChunks, 1 / (nFrameChunks - 1), 10 / (nFrameChunks - 1) }, [1 0], true, ...
                                                                            'Frame', 'Frame to display.';
    'wf',  'makeMovie',         'button', { @OCIA_analysis_wideField_makeMovie }, [1 0], false, 'Make movie', 'Create a movie.';
    
}, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);    
OCIA_analysis_widefield_addParamPanConfigUIControls(this, 'Shift|Delay|(baseFrames|evokedFrames)', paramConf);

%% get the data
if numel(iDWRows) ~= 2;
    ANShowHideMessage(this, 1, 'Please select the up and down sweeps of the same experiment.');
    return;
end;

[refImg, powerMaps, phaseMaps, meanDelay, stdDelay, ~, recordDur, DCShifts, attribs] ...
    = OCIA_analysis_widefield_getCorrectedMaps(this, iDWRows(1), iDWRows(2));

% adjust iFrame slider's settings
valType = this.GUI.an.paramPanConfig{'iFrame', 'valueType'};
nFrameChunks = size(powerMaps{1}, 3);
valType{1}(3 : 5) = { nFrameChunks, 1 / (nFrameChunks - 1), 10 / (nFrameChunks - 1) };
this.GUI.an.paramPanConfig{'iFrame', 'valueType'} = valType;
iFrame = min(round(this.an.wf.iFrame), nFrameChunks);
this.an.wf.iFrame = min(this.an.wf.iFrame, nFrameChunks);

poCLim = this.an.wf.powerMapCLim;
phCLim = this.an.wf.phaseMapCLim;
phCLim(phCLim == 3.14) = pi;
phCLim(phCLim == -3.14) = -pi;

switch this.an.wf.dispMode;
    
    % get a magnitude X phase maps
    case 'HSV';
        
        sweepDur = attribs.sweepDur;
        realSweepDur = attribs.fouNFreqs * attribs.nTones * (attribs.fouStimDur + attribs.fouToneITI);
        realMax = realSweepDur / sweepDur;
        
        corrMap = phaseMaps{3};
        corrMap(corrMap < 0) = corrMap(corrMap < 0) + pi;
        corrMap = corrMap .* 2;
        corrMap = corrMap / (2 * pi) / realMax;
        corrMap = corrMap - (1 - realMax);
        corrMap(corrMap > 1) = NaN;
        
        phaseMapCorrHSV = ones([size(corrMap, 1), size(corrMap, 2), size(corrMap, 3), 3]);
        phaseMapScaled = corrMap;
        
        powerMapScaled = max(powerMaps{1}, powerMaps{2});
        powerMapScaled(powerMapScaled < poCLim(1)) = poCLim(1);
        powerMapScaled(powerMapScaled > poCLim(2)) = poCLim(2);
        
        phaseMapCorrHSVLinear = linScale([0; 1; phaseMapScaled(:)]);
        phaseMapCorrHSV(:, :, :, 1) = reshape(phaseMapCorrHSVLinear(3 : end), size(phaseMapScaled));
        
        powerMapLinear = linScale([poCLim(1); poCLim(2); powerMapScaled(:)]);
        phaseMapCorrHSV(:, :, :, 3) = reshape(powerMapLinear(3 : end), size(powerMapScaled));
        
        phaseMaps{3} = hsv2rgb(phaseMapCorrHSV);
        
        corrMapCLIm = [0 1];
        corrMapCMap = 'hsv';
        corrMapCLab = 'Pitch [kHz]';
        corrMapCTick = [0 0.333 0.666 1];
        corrMapCTickLab = [4 8 16 32];
        
    case 'pitch';
        
        sweepDur = attribs.sweepDur;
        realSweepDur = attribs.fouNFreqs * attribs.nTones * (attribs.fouStimDur + attribs.fouToneITI);
        realMax = realSweepDur / sweepDur;
        
        corrMap = phaseMaps{3};
        corrMap(corrMap < 0) = corrMap(corrMap < 0) + pi;
        corrMap = corrMap .* 2;
        corrMap = corrMap / (2 * pi) / realMax;
        corrMap = corrMap - (1 - realMax);
        corrMap(corrMap > 1) = NaN;
        
        phaseMaps{3} = corrMap;
        corrMapCLIm = [0 1];
        corrMapCMap = 'jet';
        corrMapCLab = 'Pitch [kHz]';
        corrMapCTick = [0 0.333 0.666 1];
        corrMapCTickLab = [4 8 16 32];
        
    case 'phase';
        corrMapCLIm = phCLim;
        corrMapCMap = 'hsv';
        corrMapCLab = 'Phase [rad]';
        corrMapCTick = [];
        corrMapCTickLab = [];
        
end;

% store data
this.an.wf.storeData.powerMaps = powerMaps;
this.an.wf.storeData.phaseMaps = phaseMaps;

%% plot
ANShowHideMessage(this, 1, 'Plotting ...');
plotTic = tic; % for performance timing purposes
o('#%s: plot done (%3.1f sec).', mfilename(), toc(plotTic), 2, this.verb);

% get image and bins dimension
[imgH, imgW] = size(refImg);
thresh = this.an.wf.powerMapThresh;
thresh1 = thresh(1);
thresh2 = thresh(iff(numel(thresh) >= 2, 2, 1));

% create some lengthy titles
nFrames = this.an.wf.frameRange(2);
nFramesStep = nFrames / this.an.wf.frameRange(3);
refImgTitle = sprintf('iFrame = %d (%d->%d)', iFrame, (iFrame - 1) * nFramesStep + 1, iFrame * nFramesStep);
powerMapCombTitle = 'mean(\phi\it^+_{stim}\rm\bf, \phi\it^-_{stim}\rm\bf)';
delayMapTitle = sprintf('\\phi\\it_{delay}\\rm\\bf\\fontsize{9} (mean delay = %.2f \\pm %.2f sec)', meanDelay, stdDelay);
phase1MapTitle = sprintf('\\phi\\it^+_{stim}\\rm\\bf\\fontsize{9}(%.1f "DC" shift)', DCShifts(1));
phase2MapTitle = sprintf('\\phi\\it^-_{stim}\\rm\\bf\\fontsize{9}(%.1f "DC" shift)', DCShifts(2));
phase3MapTitle = sprintf('\\phi\\it_{stim}\\rm\\bf\\fontsize{9}(%.1f "DC" shift)', DCShifts(3));

% create the axe configuration cell-array
axeConfig = {
    
    refImg,                         refImgTitle,        'gray', 'Intensity',    true,   true,   false,  [],         [],         [],     [], [];
    powerMaps{3}(:, :, iFrame),     powerMapCombTitle,  'gray', 'Power',        false,  false,  false,  [],         poCLim,     1:2,    [], [];
    powerMaps{1}(:, :, iFrame),     '\phi\it^+_{stim}', 'gray', 'Power',        false,  false,  true,   thresh1,    poCLim,     3:4,    [], [];
    powerMaps{2}(:, :, iFrame),     '\phi\it^-_{stim}', 'gray', 'Power',        false,  false,  true,   thresh2,    poCLim,     5:6,    [], [];
    phaseMaps{1}(:, :, iFrame),     phase1MapTitle,     'hsv',  'Phase [rad]',  false,  false,  true,   [],         phCLim,     1:2,    [], [];
    phaseMaps{2}(:, :, iFrame),     phase2MapTitle,     'hsv',  'Phase [rad]',  false,  false,  true,   [],         phCLim,     3:4,    [], [];
    phaseMaps{3}(:, :, iFrame),     phase3MapTitle, corrMapCMap, corrMapCLab,   false,  false,  true,   [],         corrMapCLIm, 1:2,  ...
        corrMapCTick, corrMapCTickLab;
    phaseMaps{4}(:, :, iFrame),     delayMapTitle,      'hsv',  'Phase [rad]',  false,  false,  false,  [],         phCLim,     7:8,    [], [];

%     phaseMaps{3},   phase3MapTitle,     'hsv', 'Pitch [kHz]',   false,  false,  true,   [],     phCLim,     5:6, ...
%         [-3.14 0 3.14], round([pitchLims(1), pitchLims(end) / 2, pitchLims(end)] / 1000);
%     phaseMaps{4},   delayMapTitle, 'hsv', 'Delay [sec]', false, false, false, [],       [0 sweepDur], 1:2, ...
%         roundn([0 sweepDur / 2, sweepDur], -1), roundn([0 sweepDur / 2, sweepDur], -1);

};

% plot the maps
axeH = OCIA_analysis_widefield_plotMaps(this, 4, 2, axeConfig, imgW, imgH, recordDur);
this.an.wf.storeData.axeHandles = axeH;

% apply thresholding
powBW = powerMaps{1}(:, :, iFrame) > thresh1;
powBW = linScale(powBW);
powPolys = bwboundaries(powBW, 'noholes');
[~, sortInd] = sort(-cellfun(@numel, powPolys));
powPolys = powPolys(sortInd);
% plot outlines
hold(axeH(5), 'on');
for iPoly = 1 : min(numel(powPolys), 5);
    powPoly = powPolys{iPoly};
    powPoly = unique(powPoly, 'rows', 'stable');
    if size(powPoly, 1) < 10; continue; end;
    powPoly = powPoly * (imgW / this.an.wf.nBins(1));
    plot(powPoly(:, 2), powPoly(:, 1), 'Color', 'white', 'LineWidth', 4, 'Parent', axeH(5));
    plot(powPoly(:, 2), powPoly(:, 1), 'Color', 'black', 'LineWidth', 2, 'Parent', axeH(5));
end;
hold(axeH(5), 'off');

% apply thresholding
powBW = powerMaps{2}(:, :, iFrame) > thresh2;
powBW = linScale(powBW);
powPolys = bwboundaries(powBW, 'noholes');
[~, sortInd] = sort(-cellfun(@numel, powPolys));
powPolys = powPolys(sortInd);
% plot outlines
hold(axeH(6), 'on');
for iPoly = 1 : min(numel(powPolys), 5);
    powPoly = powPolys{iPoly};
    powPoly = unique(powPoly, 'rows', 'stable');
    if size(powPoly, 1) < 10; continue; end;
    powPoly(:, 1) = powPoly(:, 1) * (imgW / this.an.wf.nBins(1));
    powPoly(:, 2) = powPoly(:, 2) * (imgH / this.an.wf.nBins(2));
    plot(powPoly(:, 2), powPoly(:, 1), 'Color', 'white', 'LineWidth', 4, 'Parent', axeH(6));
    plot(powPoly(:, 2), powPoly(:, 1), 'Color', 'black', 'LineWidth', 2, 'Parent', axeH(6));
end;
hold(axeH(6), 'off');

% re-draw ROIs
if ~isempty(this.an.wf.ROIMasks);
    nROIs = size(this.an.wf.ROIMasks, 3);
    switch nROIs;
        case 1;     cols = [1 0 0]; % red
        case 2;     cols = [1 0 0; 0 0 1;]; % red & blue
        case 3;     cols = [1 0 0; 0 1 0; 0 0 1]; % red, green, blue
        case 4;     cols = [1 0 0; 0 1 0; 0 0 1; 0 0 0]; % red, green, blue, black
        case 5;     cols = [1 0 0; 0 1 0; 0 0 1; 1 0 1; 0 0 0]; % red, green, blue, pink, black
        otherwise;  cols = hsv(nROIs); % rainbow
    end
    for iROI = 1 : nROIs;
        mask = this.an.wf.ROIMasks(:, :, iROI);
        ROIPolys = bwboundaries(mask, 'noholes');
        ROIPolys = ROIPolys{1};
        ROIPolys(:, 1) = ROIPolys(:, 1) * (imgW / this.an.wf.nBins(1));
        ROIPolys(:, 2) = ROIPolys(:, 2) * (imgH / this.an.wf.nBins(2));
        hold(axeH(7), 'on');
        plot(ROIPolys(:, 2), ROIPolys(:, 1), 'Color', 'white', 'LineWidth', 4, 'Parent', axeH(7));
        plot(ROIPolys(:, 2), ROIPolys(:, 1), 'Color', cols(iROI, :), 'LineWidth', 2, 'Parent', axeH(7));
        hold(axeH(7), 'off');
    end;    
end;

% hide the message and show plot
ANShowHideMessage(this, 0, 'Update analyser plot done.');

end
