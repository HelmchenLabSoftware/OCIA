function OCIA_analysis_widefield_powerAndPhaseMaps(this, iDWRows)
% OCIA_analysis_widefield_powerAndPhaseMaps - [no description]
%
%       OCIA_analysis_widefield_powerAndPhaseMaps(this, iDWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% plotting parameter UI controls
paramConf = cell2table({ ...
... categ  id                   UIType  valueType       UISize  isLabAbove  label               tooltip
    'wf',  'powerMapCLim',      'text', { 'array' },    [1 0],  true,      'Power CLim',        'Color limits.';
    'wf',  'phaseMapCLim',      'text', { 'array' },    [1 0],  true,      'Phase CLim',         'Color limits.';
    'wf',  'drawROIs',         'button', { @OCIA_analysis_wideField_drawROIs }, [1 0], false, 'Draw ROIs', 'Draw ROIs.';
    
}, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);    
OCIA_analysis_widefield_addParamPanConfigUIControls(this, '(baseFrames|evokedFrames)', paramConf);

%% get the data
% get maps
[powerMap, phaseMap, pitchLims, recordDur] = OCIA_analysis_widefield_getPowerAndPhaseMap(this, iDWRows(1));
% no plot if no data
if isempty(powerMap); return; end;
% get information about selected file
[~, ~, ~, refImg] = OCIA_analysis_widefield_getFileInfo(this, iDWRows(1));
% crop image if needed
if ~isempty(refImg) && ~isempty(this.an.wf.cropRect);
    refImg = refImg(this.an.wf.cropRect(2) + (0 : this.an.wf.cropRect(4) - 1), ...
        this.an.wf.cropRect(1) + (0 : this.an.wf.cropRect(3) - 1));
end;

%% filter maps
powFiltSet = this.an.wf.powerMapFilt;
phaFiltSet = this.an.wf.phaseMapFilt;
% if gaussian filtering is requested, apply it
if sum(powFiltSet(1 : 3)) > 0; powerMap = imfilter(powerMap, fspecial('gaussian', powFiltSet(1 : 2), powFiltSet(3))); end;
if sum(powFiltSet(4 : 5)) > 0; powerMap = medfilt2(powerMap, powFiltSet(4 : 5)); end;
if sum(phaFiltSet(1 : 3)) > 0; phaseMap = imfilter(phaseMap, fspecial('gaussian', phaFiltSet(1 : 2), phaFiltSet(3))); end;
if sum(phaFiltSet(4 : 5)) > 0; phaseMap = medfilt2(phaseMap, phaFiltSet(4 : 5)); end;

%% threshold maps
% get lower threshold of power map
powerMapMask = powerMap < this.an.wf.powerMapThresh(1);
% calculate DC shift of unresponsive areas and correct for it
DCShift = nanmean(phaseMap(powerMapMask));
phaseMap = phaseMap - iff(isnan(DCShift), 0, DCShift);

%% get a corrected phase map
sweepDur = 1 / this.an.wf.stimFreq;
realDelay = sign(this.an.wf.phaseMapDelay) * mod(abs(this.an.wf.phaseMapDelay), sweepDur);
% up sweep
if pitchLims(end) >= pitchLims(1);
    phaseMapCorr = phaseMap;
    phaseMapCorr = phaseMapCorr + (realDelay * pi);
    
% down sweep
else
    pitchLims = [pitchLims(end), pitchLims(1)];
    phaseMapCorr = -phaseMap;
    phaseMapCorr = phaseMapCorr - (realDelay * pi);
    
end;
phaseMapCorr(phaseMapCorr < -pi) = phaseMapCorr(phaseMapCorr < -pi) + 2 * pi;
phaseMapCorr(phaseMapCorr > pi) = phaseMapCorr(phaseMapCorr > pi) - 2 * pi;

%% get a magnitude X phase maps
poCLim = this.an.wf.powerMapCLim;
phCLim = this.an.wf.phaseMapCLim;
phCLim(phCLim == 3.14) = pi;
phCLim(phCLim == -3.14) = -pi;
phaseMapCorrHSV = ones([size(phaseMapCorr), 3]);
phaseMapScaled = phaseMapCorr;
phaseMapScaled(phaseMapScaled < phCLim(1)) = phCLim(1);
phaseMapScaled(phaseMapScaled > phCLim(2)) = phCLim(2);
powerMapScaled = powerMap;
powerMapScaled(powerMapScaled < poCLim(1)) = poCLim(1);
powerMapScaled(powerMapScaled > poCLim(2)) = poCLim(2);
phaseMapCorrHSVLinear = linScale([phCLim(1); phCLim(2); phaseMapScaled(:)]);
phaseMapCorrHSV(:, :, 1) = reshape(phaseMapCorrHSVLinear(3 : end), size(phaseMapScaled));
powerMapLinear = linScale([poCLim(1); poCLim(2); powerMapScaled(:)]);
phaseMapCorrHSV(:, :, 3) = reshape(powerMapLinear(3 : end), size(powerMapScaled));
phaseMapCorrRGB = hsv2rgb(phaseMapCorrHSV);

%% plot
ANShowHideMessage(this, 1, 'Plotting ...');
plotTic = tic; % for performance timing purposes
o('#%s: plot done (%3.1f sec).', mfilename(), toc(plotTic), 2, this.verb);

if isempty(this.an.wf.cropRect);
    refImgTitle = 'Reference';
else
    refImgTitle = sprintf('Reference  \\fontsize{9}[%dX,%dY,%dW,%dH]', this.an.wf.cropRect);
end;
% phaseMapCorrTitle = sprintf('\\phi\\it_{stim}\\rm\\bf\\fontsize{9}(%+.2f sec delay)', realDelay);
phaseMapTitle = sprintf('\\phi\\it^+_{stim}\\rm\\bf\\fontsize{9}(%.1f "DC" shift)', DCShift);
thresh = this.an.wf.powerMapThresh;
[imgH, imgW] = size(refImg);

% create the axe configuration cell-array
axeConfig = {
    
    refImg,         refImgTitle,        'gray', 'Intensity',    true,   true,   false,  [],     [],         [],     [], [];
    powerMap,       '\phi\it^+_{stim}', 'gray', 'Power',        false,  false,  true,   thresh, poCLim,     1:2,    [], [];
    phaseMap,       phaseMapTitle,      'hsv',  'Phase [rad]',  false,  false,  true,   [],     phCLim,     1:2,    [], [];
%     phaseMapCorr,   phaseMapCorrTitle,  'hsv',  'Pitch [kHz]',  false,  false,  true,   [],     phCLim,     3:4, ...
%         [-3.14 0 3.14], round([pitchLims(1), pitchLims(end) / 2, pitchLims(end)] / 1000);
    phaseMapCorrRGB,'\phi\it^+_{stim}', [],     [],             false,  false,  true,   [],     [],         [],     [], [];
    
};

% plot the maps
% axeH = OCIA_analysis_widefield_plotMaps(this, 3, 2, axeConfig, imgW, imgH, recordDur);
axeH = OCIA_analysis_widefield_plotMaps(this, 4, 1, axeConfig, imgW, imgH, recordDur);
this.an.wf.axeHandles = axeH;

if this.an.wf.powerMapThresh(1) > 0;
    % apply thresholding
    powBW = powerMap > this.an.wf.powerMapThresh(1);
    powBW = linScale(powBW);
    powPolys = bwboundaries(powBW, 'noholes');
    [~, sortInd] = sort(-cellfun(@numel, powPolys));
    powPolys = powPolys(sortInd);
    % plot outlines
    for iAxe = 2 : 4;
        hold(axeH(iAxe), 'on');
        for iPoly = 1 : min(numel(powPolys), 5);
            powPoly = powPolys{iPoly};
            if numel(powPoly) < 10; continue; end;
            powPoly(:, 1) = powPoly(:, 1) * (imgW / this.an.wf.nBins(1));
            powPoly(:, 2) = powPoly(:, 2) * (imgH / this.an.wf.nBins(2));
            if iAxe == 2;
                plot(powPoly(:, 2), powPoly(:, 1), 'Color', 'red', 'LineWidth', 0.5, 'Parent', axeH(iAxe));
            else
                plot(powPoly(:, 2), powPoly(:, 1), 'Color', 'white', 'LineWidth', 4, 'Parent', axeH(iAxe));
                plot(powPoly(:, 2), powPoly(:, 1), 'Color', 'black', 'LineWidth', 2, 'Parent', axeH(iAxe));
            end;
        end;
        hold(axeH(iAxe), 'off');
    end;
end;

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
        hold(axeH(3), 'on');
        plot(ROIPolys(:, 2), ROIPolys(:, 1), 'Color', 'white', 'LineWidth', 4, 'Parent', axeH(3));
        plot(ROIPolys(:, 2), ROIPolys(:, 1), 'Color', cols(iROI, :), 'LineWidth', 2, 'Parent', axeH(3));
        hold(axeH(3), 'off');
    end;    
end;

% hide the message and show plot
ANShowHideMessage(this, 0, 'Update analyser plot done.');


end
