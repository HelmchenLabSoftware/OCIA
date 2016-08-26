function OCIA_analysis_widefield_mappingMultiFreqPSAvg(this, iDWRows)
% OCIA_analysis_widefield_mappingMultiFreqPSAvg - [no description]
%
%       OCIA_analysis_widefield_mappingMultiFreqPSAvg(this, iDWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% plotting parameter UI controls
paramConf = cell2table({ ...
... categ  id                   UIType  valueType       UISize  isLabAbove  label               tooltip
    'wf',  'nBinsToPlot',       'text', { 'numeric' },  [1 0],  false,      'N. bins to plot',  'Number of bins to plot.';
    'wf',  'pixTCYLim',         'text', { 'array' },    [1 0],  false,      'PixTC YLim',       'Y limits of the pixel time course plot.';
    
}, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);
OCIA_analysis_widefield_addParamPanConfigUIControls(this, '(CLim|Filt|Delay|Shift|BLCorr|Thresh)', paramConf);

%% get the data
[trialsPSFrames, tPS, stimIDs] = OCIA_analysis_widefield_getTrialsMappingMultiFreq(this, iDWRows(1));
% abort if no bins
nBins = this.an.wf.nBins;
nTotBins = prod(nBins);
if isempty(nBins) || any(nBins == 0); return; end;
% no plot if no data
if isempty(trialsPSFrames); return; end;

% get dataset's size
[~, ~, nTrials, nStims, nPSFrames] = size(trialsPSFrames); %#ok<ASGLU>

%% plot
ANShowHideMessage(this, 1, 'Plotting ...');
plotTic = tic; % for performance timing purposes
o('#%s: plot done (%3.1f sec).', mfilename(), toc(plotTic), 2, this.verb);

% select the color scheme
switch nStims;
    case 1;     cols = [1 0 0]; % red
    case 2;     cols = [1 0 0; 0 0 1;]; % red & blue
    case 3;     cols = [1 0 0; 0 1 0; 0 0 1]; % red, green, blue
    case 4;     cols = [1 0 0; 0 1 0; 0 0 1; 0 0 0]; % red, green, blue, black
    otherwise;  cols = hsv(nStims); % rainbow
end;

% select which bins to plot
binsToPlot = 1 : ceil(nTotBins / this.an.wf.nBinsToPlot) : (nTotBins);

% get plotting axe
anAxeH = this.GUI.handles.an.axe;

% gather infos about original axe
axeHParent = get(anAxeH, 'Parent');
basePos = get(anAxeH, 'Position');
basePos(1) = 0.04;
basePos(2) = 0.08;
basePos(3) = 0.95;
basePos(4) = 0.6;
% hide the original axe
set(anAxeH, 'YTick', [], 'XTick', [], 'XColor', 'white', 'YColor', 'white', 'Visible', 'off');

% get the dimensions of the subplots
nBinsToPlot = numel(binsToPlot);
M = ceil(sqrt(nBinsToPlot)); M = iff(M * M >= nBinsToPlot, M, M + 1); N = iff(M * (M - 1) >= nBinsToPlot, M - 1, M);
WPad = basePos(3) * 0.005; W = (basePos(3) - (M - 1) * WPad) / M;
HPad = basePos(4) * 0.08; H = (basePos(4) - (N - 1) * HPad) / N;
[X, baseX] = deal(basePos(1)); %#ok<ASGLU>
[Y, baseY] = deal(basePos(2) + (N - 1) * (H + HPad));

% plot each axe
iY = 1; iX = 1;
axeHandles = zeros(nBinsToPlot, 1);
for iBinLoop = 1 : numel(binsToPlot);
    
    iBin = binsToPlot(iBinLoop);
    
    % create axe
    axeH = axes('Parent', axeHParent, 'Color', 'white', 'Position', [X Y W H], 'Visible', 'on');
    axeHandles(iBinLoop) = axeH;
    
    [iBinX, iBinY] = ind2sub(nBins, iBin);
    
    hold(axeH, 'on');
    stimH = zeros(nStims, 1);
    for iStim = 1 : nStims;
        stimH(iStim) = plot(axeH, tPS, squeeze(nanmean(trialsPSFrames(iBinX, iBinY, :, iStim, :), 3)), 'Color', cols(iStim, :));
    end;
    line([0 0], this.an.wf.pixTCYLim, 'Color', 'red', 'LineStyle', ':', 'Parent', axeH);
    hold(axeH, 'off');

    % annotate axes
    tDiff = (tPS(2) - tPS(1)) * 2 + 0.1;
    set(axeH, 'XLim', [tPS(1) - tDiff, tPS(end) + tDiff], 'FontSize', 15);
    if iY == N;
        xlabel(axeH, 'Time [sec]', 'FontSize', 16);
    else
        set(axeH, 'XTickLabel', []);
    end;
    if iX == 1;
        ylabel(axeH, 'F [a.u.]', 'FontSize', 15);
    else
        set(axeH, 'YTickLabel', []);
    end;
    title(axeH, sprintf('Bin [%d, %d]', iBinX, iBinY), 'FontSize', 15);
    set(axeH, 'YLim', this.an.wf.pixTCYLim);
    
    if iBin == 1;
        hLeg = legend(axeH, stimH, stimIDs, 'Orientation', 'horizontal', 'Location', 'North');
        title(axeH, sprintf('Bin [%d, %d] (%d trial)', iBinX, iBinY, nTrials), 'FontSize', 15);
    else
        title(axeH, sprintf('Bin [%d, %d]', iBinX, iBinY), 'FontSize', 15);
    end;
    
    % update position
    Y = Y - H - HPad;
    iY = iY + 1;
    if iY > N;
        X = X + W + WPad;
        Y = baseY;
        iY = 1;
        iX = iX + 1;
    end;
end;

%% link all axes
linkaxes(axeHandles, 'xy');
legPos = get(hLeg, 'Position');
legPos(1 : 2) = [0.327, 0.740];
set(hLeg, 'Position', legPos);

% hide the message and show plot
ANShowHideMessage(this, 0, 'Update analyser plot done.');


end
