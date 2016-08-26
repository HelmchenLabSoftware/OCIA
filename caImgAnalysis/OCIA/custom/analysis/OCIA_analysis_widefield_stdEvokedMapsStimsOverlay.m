function OCIA_analysis_widefield_stdEvokedMapsStimsOverlay(this, iDWRows)
% OCIA_analysis_widefield_stdEvokedMapsStimsOverlay - [no description]
%
%       OCIA_analysis_widefield_stdEvokedMapsStimsOverlay(this, iDWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% plotting parameter UI controls
OCIA_analysis_widefield_addParamPanConfigUIControls(this, '(Delay|Shift)');

%% get the data
[stimMaps, refImg, stimIDs, stimIndexes, imgH, imgW] = OCIA_analysis_widefield_getEvokedMapsStims_standard(this, iDWRows);
thresh = this.an.wf.powerMapThresh;
if any(strcmp(stimIDs, 'no sound')); stimIndexes = stimIndexes - 1; end;
thresh(strcmp(stimIDs, 'no sound')) = [];
stimMaps(:, :, strcmp(stimIDs, 'no sound')) = [];
stimIDs(strcmp(stimIDs, 'no sound')) = [];
nStims = size(stimMaps, 3);
nBins = this.an.wf.nBins;

%% plot
ANShowHideMessage(this, 1, 'Plotting ...');
plotTic = tic; % for performance timing purposes
o('#%s: plot done (%3.1f sec).', mfilename(), toc(plotTic), 2, this.verb);     

% create the axe configuration cell-array with the reference image
% refImgTitle = sprintf('Reference  \\fontsize{9}[%dX,%dY,%dW,%dH]', this.an.wf.cropRect);
% axeConfig = { refImg, refImgTitle, 'gray', 'Intensity', true, true, false, [], [], [], [], [] };

refImgRGB = repmat(refImg, [1 1 3]);
% axeConfig(end + 1, :) = { refImgRGB, 'Overlay', [], '', false, false, false, [], [], [], [], [] };
if isempty(this.an.wf.cropRect);
    overlayTitle = 'Overlay';
else
    overlayTitle = sprintf('Overlay  \\fontsize{9}[%dX,%dY,%dW,%dH]', this.an.wf.cropRect);
end;
axeConfig = { refImgRGB, overlayTitle, [], '', true, true, false, [], [], [], [], [] };

% plot the maps
axeHandles = OCIA_analysis_widefield_plotMaps(this, size(axeConfig, 1), 1, axeConfig, imgW, imgH, []);
axeH = axeHandles(end);

% params
stimColors = flipud(jet(nStims));
lineH = zeros(nStims, 1);
filtSet = this.an.wf.powerMapFilt;

% add overlay
hold(axeH, 'on');
for iStim = 1 : nStims;
        
    stimMap = reshape(stimMaps(:, :, iStim), nBins, nBins);
    % if gaussian filtering is requested, apply it
    if all(filtSet(1 : 3)) > 0; stimMap = imfilter(stimMap, fspecial('gaussian', filtSet(1 : 2), filtSet(3))); end;
    % if median filtering is requested, apply it
    if all(filtSet(4 : 5)) > 0; stimMap = medfilt2(stimMap, filtSet(4 : 5)); end;
    % apply thresholding
    stimBW = stimMap > thresh(min(iStim, numel(thresh)));
    stimBW = linScale(stimBW);
    stimPolys = bwboundaries(stimBW, 'noholes');
    [~, sortInd] = sort(-cellfun(@numel, stimPolys));
    stimPolys = stimPolys(sortInd);
    for iPoly = 1 : min(numel(stimPolys), 2);
        stimPoly = stimPolys{iPoly};
        if numel(stimPoly) < 10; continue; end;
        stimPoly = stimPoly * (imgW / nBins);
        patch(stimPoly(:, 2), stimPoly(:, 1), stimColors(iStim, :), 'FaceAlpha', 0.15, ...
            'EdgeColor', stimColors(iStim, :), 'LineWidth', 0.5, 'Parent', axeH);
        lineH(iStim) = line(stimPoly(1 : 2, 2), stimPoly(1 : 2, 1), 'Color', stimColors(iStim, :), 'Parent', axeH);
    end;
end;
hold(axeH, 'off');

legend(axeH, lineH(lineH > 0), stimIDs(lineH > 0));

% hide the message and show plot
ANShowHideMessage(this, 0, 'Update analyser plot done.');


end
