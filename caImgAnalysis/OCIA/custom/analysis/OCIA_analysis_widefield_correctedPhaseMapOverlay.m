function OCIA_analysis_widefield_correctedPhaseMapOverlay(this, iDWRows)
% OCIA_analysis_widefield_correctedPhaseMapOverlay - [no description]
%
%       OCIA_analysis_widefield_correctedPhaseMapOverlay(this, iDWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% plotting parameter UI controls
paramConf = cell2table({ ...
... categ  id                   UIType  valueType       UISize  isLabAbove      label               tooltip
    'wf',  'powerMapCLim',      'text', { 'array' },    [1 0],  true,           'Power CLim',       'Color limits.';
    'wf',  'phaseMapCLim',      'text', { 'array' },    [1 0],  true,           'Phase CLim',       'Color limits.';
    'wf',  'dispMode',          'dropdown', { 'phase', 'pitch', 'HSV' }, [1 0], false, 'Disp. mode', 'Display mode for phase map.';
    
}, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);    
OCIA_analysis_widefield_addParamPanConfigUIControls(this, 'Shift|Delay|(baseFrames|evokedFrames)', paramConf);

%% get the data
if numel(iDWRows) ~= 2;
    ANShowHideMessage(this, 1, 'Please select the up and down sweeps of the same experiment.');
    return;
end;

[refImg, powerMaps, phaseMaps, ~, ~, pitchLims, recordDur, DCShifts, attribs] ...
    = OCIA_analysis_widefield_getCorrectedMaps(this, iDWRows(1), iDWRows(2));

poCLim = this.an.wf.powerMapCLim;
phCLim = this.an.wf.phaseMapCLim;
phCLim(phCLim == 3.14) = pi;
phCLim(phCLim == -3.14) = -pi;
        
sweepDur = attribs.sweepDur;
if isfield(attribs, 'nTones');
    realSweepDur = attribs.fouNFreqs * attribs.nTones * (attribs.fouStimDur + attribs.fouToneITI);
else
    realSweepDur = sweepDur;
end;
realMax = realSweepDur / sweepDur;
if any(round(pitchLims / 1000) == 4) && any(round(pitchLims / 1000) == 32);
    corrMapCTick = [0 0.333 0.666 1];
    corrMapCTickLab = [4 8 16 32];

elseif any(round(pitchLims / 1000) == 4) && any(round(pitchLims / 1000) == 64);
    corrMapCTick = [0 0.25 0.5 0.75 1];
    corrMapCTickLab = [4 8 16 32 64];

elseif any(round(pitchLims / 1000) == 8) && any(round(pitchLims / 1000) == 32);
    corrMapCTick = [0 0.5 1];
    corrMapCTickLab = [8 16 32];

elseif any(round(pitchLims / 1000) == 8) && any(round(pitchLims / 1000) == 64);
    corrMapCTick = [0 0.333 0.666 1];
    corrMapCTickLab = [8 16 32 64];

else
    corrMapCTick = [0 1];
    corrMapCTickLab = round(pitchLims / 1000);
    
end;

switch this.an.wf.dispMode;
    
    % get a magnitude X phase maps
    case 'HSV';
        
        corrMap = phaseMaps{3};
        corrMap(corrMap < 0) = corrMap(corrMap < 0) + pi;
        corrMap = corrMap .* 2;
        corrMap = corrMap / (2 * pi) / realMax;
        corrMap(corrMap > 1) = NaN;
        
        phaseMapCorrHSV = ones([size(corrMap), 3]);
        phaseMapScaled = corrMap;
        
        powerMapScaled = max(powerMaps{1}, powerMaps{2});
        powerMapScaled(powerMapScaled < poCLim(1)) = poCLim(1);
        powerMapScaled(powerMapScaled > poCLim(2)) = poCLim(2);
        
        phaseMapCorrHSVLinear = linScale([0; 1; phaseMapScaled(:)]);
        phaseMapCorrHSV(:, :, 1) = reshape(phaseMapCorrHSVLinear(3 : end), size(phaseMapScaled));
        
        powerMapLinear = linScale([poCLim(1); poCLim(2); powerMapScaled(:)]);
        phaseMapCorrHSV(:, :, 3) = reshape(powerMapLinear(3 : end), size(powerMapScaled));
        
        overlayMap = hsv2rgb(phaseMapCorrHSV);
        
        corrMapCLIm = [0 1];
        corrMapCMap = 'hsv';
        corrMapCLab = 'Pitch [kHz]';
        
    case 'pitch';
        
%         corrMap = phaseMaps{3};
%         corrMap(corrMap < 0) = corrMap(corrMap < 0) + pi;
%         corrMap = corrMap .* 2;
%         corrMap = corrMap / (2 * pi) / roundn(realMax, -1);
%         corrMap(corrMap > 1) = NaN;
        
        corrMap = phaseMaps{3};
        corrMap(corrMap < 0) = corrMap(corrMap < 0) + pi;
        corrMap = corrMap .* 2;
        corrMap = corrMap / (2 * pi) / realMax;
%         corrMap = corrMap - (1 - realMax);
        corrMap(corrMap > 1) = NaN;
        
        overlayMap = corrMap;
        corrMapCLIm = [0 1];
        corrMapCMap = 'jet';
        corrMapCLab = 'Pitch [kHz]';
        
    case 'phase';
        
        overlayMap = phaseMaps{3};
        
        corrMapCLIm = phCLim;
        corrMapCMap = 'hsv';
        corrMapCLab = 'Phase [rad]';
        corrMapCTick = [];
        corrMapCTickLab = [];
        
end;   


% add the blood vessels
refImgCorr = PseudoFlatfieldCorrect(double(refImg), round(size(refImg)) ./ 10);
refImgCorr = PseudoFlatfieldCorrect(refImgCorr, round(size(refImg)) ./ 2);
% refImgBW = double(refImgCorr > graythresh(refImgCorr));
refImgBW = double(refImgCorr > (graythresh(refImgCorr) * 0.95));
% refImgBW = double(refImgCorr > (graythresh(refImgCorr) * 0.79));
% refImgBW = double(refImgCorr > (graythresh(refImgCorr) * 1.1));

overlayMap = imresize(overlayMap, size(refImgBW));
overlayMap(refImgBW <= 0) = NaN;


%% plot
ANShowHideMessage(this, 1, 'Plotting ...');
plotTic = tic; % for performance timing purposes
o('#%s: plot done (%3.1f sec).', mfilename(), toc(plotTic), 2, this.verb);

% get image and bins dimension
[imgH, imgW] = size(refImg);
% thresh = this.an.wf.powerMapThresh;

% create some lengthy titles
if isempty(this.an.wf.cropRect);
    refImgTitle = 'Reference';
else
    refImgTitle = sprintf('Reference  \\fontsize{9}[%dX,%dY,%dW,%dH]', this.an.wf.cropRect);
end;

% create the axe configuration cell-array
axeConfig = {
    
    refImg,         refImgTitle,        'gray', 'Intensity',    true,   true,   false,  [],         [],         [],     [], [];
%     refImgCorr,     'refImgCorr',     'gray', '',    false,   false,   false,  [],         [],         [],     [], [];
%     refImgBW,       'RefImgThresh',     'gray', '',    false,   false,   false,  [],         [],         [],     [], [];
    overlayMap,     'Overlay',          corrMapCMap, corrMapCLab, false, false, true, [], corrMapCLIm, 1:2,  ...
        corrMapCTick, corrMapCTickLab;
   
};

% plot the maps
axeH = OCIA_analysis_widefield_plotMaps(this, 2, 1, axeConfig, imgW, imgH, recordDur);


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
        hold(axeH(2), 'on');
        plot(ROIPolys(:, 2), ROIPolys(:, 1), 'Color', 'white', 'LineWidth', 4, 'Parent', axeH(2));
        plot(ROIPolys(:, 2), ROIPolys(:, 1), 'Color', cols(iROI, :), 'LineWidth', 2, 'Parent', axeH(2));
        hold(axeH(2), 'off');
    end;    
end;

% hide the message and show plot
ANShowHideMessage(this, 0, 'Update analyser plot done.');

end
