function OCIA_analysis_widefield_refImg(this, iDWRows)
% OCIA_analysis_widefield_refImg - [no description]
%
%       OCIA_analysis_widefield_refImg(this, iDWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% get the data
% get information about selected file
try
    [~, ~, ~, refImg] = OCIA_analysis_widefield_getFileInfo_standard(this, iDWRows(1));
catch
    [filePath, ~, ~, refImg, ~, ~, ~, pitchLims, ~, attribs] = OCIA_analysis_widefield_getFileInfo(this, iDWRows(1)); %#ok<ASGLU>
end;
% ANShowHideMessage(this, 1, sprintf('Pitch: %d - %d, amplif.: %d', round(pitchLims / 1000), attribs.amplifFactor));
% save(regexprep(filePath, '\.h5', '_stimInfo.mat'), 'attribs');
% pause(0.2);

%% plotting parameter UI controls
paramConf = cell2table({ ...
... categ  id                   UIType  valueType       UISize  isLabAbove  label               tooltip
    'wf',  'nBinsToPlot',       'text',   { 'numeric' },  [1 0],  false,      'N. bins to plot',  'Number of bins to plot.';
    'wf',  'drawCropRect',      'button', { @OCIA_analysis_wideField_drawCropRect }, [0.8 0], false, 'Draw crop rect.',  'Draw crop rectangle.';
    'wf',  'drawROIs',          'button', { @OCIA_analysis_wideField_drawROIs }, [1 0], false, 'Draw ROIs', 'Draw ROIs.';
    'wf',  'createRawMovie',    'button', { @OCIA_analysis_widefield_createRawMovie }, [1 0], false, 'Create raw movie', 'Create raw movie.';

}, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);
OCIA_analysis_widefield_addParamPanConfigUIControls(this, '(CLim|Filt|Delay|Shift|Thresh)', paramConf);

%% plot
ANShowHideMessage(this, 1, 'Plotting ...');
plotTic = tic; % for performance timing purposes
o('#%s: plot done (%3.1f sec).', mfilename(), toc(plotTic), 2, this.verb);

% get plotting axe
axeH = this.GUI.handles.an.axe;
axePos = get(axeH, 'Position');

% get image size and plot it
[H, W] = size(refImg);
imagesc([1 W], [1 H], refImg, 'Parent', axeH);

% annotate axes
hColorBar = colorbar('EastOutside', 'peer', axeH);
set(hColorBar, 'FontSize', 10);
colormap(axeH, 'gray'); if gcf ~= this.GUI.figH; close(gcf); end;
axis(axeH, 'equal');
set(axeH, 'XLim', [1 W], 'YLim', [1 H]);
% restore axe position
set(axeH, 'Position', axePos);

if ~isempty(this.an.wf.cropRect);
    rectangle('Position', this.an.wf.cropRect, 'LineWidth', 2, 'EdgeColor', 'white', 'LineStyle', ':', 'Parent', axeH);
end;

% if there are some bins, display them
nBins = this.an.wf.nBins;
nTotBins = prod(nBins);
if ~isempty(nBins) && all(nBins > 0);
    % use cropped dimensions if any
    cropX = iff(isempty(this.an.wf.cropRect), 1, this.an.wf.cropRect, [], 1);
    cropY = iff(isempty(this.an.wf.cropRect), 1, this.an.wf.cropRect, [], 2);
    cropW = iff(isempty(this.an.wf.cropRect), W, this.an.wf.cropRect, [], 3);
    cropH = iff(isempty(this.an.wf.cropRect), H, this.an.wf.cropRect, [], 4);
    % select the color scheme
    switch nTotBins;
        case 1;     cols = [1 0 0]; % red
        case 2;     cols = [1 0 0; 0 0 1;]; % red & blue
        case 3;     cols = [1 0 0; 0 1 0; 0 0 1]; % red, green, blue
        case 4;     cols = [1 0 0; 0 1 0; 0 0 1; 0 0 0]; % red, green, blue, black
        otherwise;  cols = hsv(nTotBins); % rainbow
    end;
    % display bins
    binSizeX = cropW / nBins(1); binSizeY = cropH / nBins(2);
    binsToPlot = 1 : ceil(nTotBins / this.an.wf.nBinsToPlot) : (nTotBins);
    for iBin = binsToPlot;
        % get bin's X and Y range
        [iX, iY] = ind2sub(nBins, iBin);
        xStart = ((iX - 1) * binSizeX + cropX);
        yStart = ((iY - 1) * binSizeY + cropY);
        rectangle('Position', [xStart, yStart, binSizeX, binSizeY], 'LineWidth', 1, ...
            'EdgeColor', cols(iBin, :), 'Parent', axeH);
    end;
end;



% hide the message and show plot
ANShowHideMessage(this, 0, 'Update analyser plot done.');


end
