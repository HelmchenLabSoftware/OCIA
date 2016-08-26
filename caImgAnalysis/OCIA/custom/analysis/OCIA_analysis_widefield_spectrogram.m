function OCIA_analysis_widefield_spectrogram(this, iDWRows)
% OCIA_analysis_widefield_spectrogram - [no description]
%
%       OCIA_analysis_widefield_spectrogram(this, iDWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% plotting parameter UI controls
paramConf = cell2table({ ...
... categ  id                   UIType  valueType       UISize  isLabAbove  label               tooltip
    'wf',  'nBinsToPlot',       'text', { 'numeric' },  [1 0],  false,      'N. bins to plot',  'Number of bins to plot.';
    'wf',  'spectrYLim',        'text', { 'array' },    [1 0],  false,      'PixTC YLim',       'Y limits of the pixel time course plot.';
    'wf',  'subPlotsToShow',    'text', { 'array' },    [1 0],  false,      'Sub-plots to show', 'Array of 0/1 defining whether to show the power, phase and phase diff. subplots.';
    
}, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);
OCIA_analysis_widefield_addParamPanConfigUIControls(this, '(CLim|Filt|Delay|Shift|baseFrames|evokedFrames|Thresh)', paramConf);

%% get the data
[powVect, phaseVect, freqVect] = OCIA_analysis_widefield_getPowerAndPhase(this, iDWRows(1));
% abort if no bins
nBins = this.an.wf.nBins;
nTotBins = prod(nBins);
if isempty(nBins) || any(nBins == 0); return; end;
% no plot if no data
if isempty(powVect); return; end;
% no plots to show
if ~any(this.an.wf.subPlotsToShow); 
    ANShowHideMessage(this, 1, 'No sub-plot selected.');
    return;
end;

if ~isempty(this.an.wf.ROIMasks);
    nTotBins = size(this.an.wf.ROIMasks, 3);
end;

%% plot
ANShowHideMessage(this, 1, 'Plotting ...');
plotTic = tic; % for performance timing purposes

% get plotting axe
anAxeH = this.GUI.handles.an.axe;

% gather infos about original axe
axeHParent = get(anAxeH, 'Parent');
basePos = get(anAxeH, 'Position');
basePos(1) = 0.07;
basePos(3) = 0.9;
basePos(2) = 0.10;
% basePos(4) = 0.70;
% hide the original axe
set(anAxeH, 'YTick', [], 'XTick', [], 'XColor', 'white', 'YColor', 'white', 'Visible', 'off');

% get the dimensions of the subplots
M = sum(this.an.wf.subPlotsToShow); N = 1;
if M >= 4; M = 2; N = 2; end;
WPad = basePos(3) * 0.07; W = (basePos(3) - (M - 1) * WPad) / M;
HPad = basePos(4) * 0.15; H = (basePos(4) - (N - 1) * HPad) / N;
[X, baseX] = deal(basePos(1));
[Y, baseY] = deal(basePos(2) + (N - 1) * (H + HPad)); %#ok<ASGLU>

% select the color scheme
switch nTotBins;
    case 1;     cols = [1 0 0]; % red
    case 2;     cols = [1 0 0; 0 0 1;]; % red & blue
    case 3;     cols = [1 0 0; 0 1 0; 0 0 1]; % red, green, blue
    case 4;     cols = [1 0 0; 0 1 0; 0 0 1; 0 0 0]; % red, green, blue, black
    case 5;     cols = [1 0 0; 0 1 0; 0 0 1; 1 0 1; 0 0 0]; % red, green, blue, pink, black
    otherwise;  cols = hsv(nTotBins); % rainbow
end;

% select which bins to plot
binsToPlot = 1 : ceil(nTotBins / this.an.wf.nBinsToPlot) : (nTotBins);

axeHands = [];

%% frequency
if this.an.wf.subPlotsToShow(1);
    
     % create axe
    axeH = axes('Parent', axeHParent, 'Color', 'white', 'Position', [X Y W H], 'Visible', 'on');
    axeHands(end + 1) = axeH;

    hold(axeH, 'on');
    if this.an.wf.stimFreq > 0;
        % rectangle label of currently analysed frequency
        [~, stimFreqIndex] = min(abs(freqVect - this.an.wf.stimFreq));
        if this.an.wf.stimFreqInterval > 0;
            rectangle('Position', [freqVect(stimFreqIndex) - this.an.wf.stimFreqInterval, this.an.wf.spectrYLim(1) + 10E-9, ...
                this.an.wf.stimFreqInterval * 2, diff(this.an.wf.spectrYLim) * 0.95], 'FaceColor', [0.9 0.9 0.9]', 'EdgeColor', 'none', ...
                'Parent', axeH);
        end;
    end;
    for iBin = binsToPlot;
        plot(axeH, freqVect, powVect(iBin, :), 'Color', cols(iBin, :));
    end;
    if this.an.wf.stimFreq > 0;
        % add label for currently analysed frequency
        hLine = line(repmat(freqVect(stimFreqIndex), 1, 2), this.an.wf.spectrYLim, 'Color', [0.2 0.2 0.2]', 'LineWidth', 0.5, ...
            'LineStyle', ':', 'Parent', axeH);
    end;
    hold(axeH, 'off');
    % annotate axes
    set(axeH, 'XScale', 'log', 'YScale', 'log', 'XLim', [freqVect(1) freqVect(end)], 'FontSize', 15);
    xlabel(axeH, 'Frequency [Hz]', 'FontSize', 16);
    ylabel(axeH, 'Power [a.u.]', 'FontSize', 25);
    set(axeH, 'YLim', this.an.wf.spectrYLim);
    
    % update position
    X = X + W + WPad;
    
end;

%% phase
if this.an.wf.subPlotsToShow(2);

    % create axe
    axeH = axes('Parent', axeHParent, 'Color', 'white', 'Position', [X Y W H], 'Visible', 'on');
    axeHands(end + 1) = axeH;
    yLims = [-3.5 3.5];

    hold(axeH, 'on');
    if this.an.wf.stimFreq > 0;
        % rectangle label of currently analysed frequency
        [~, stimFreqIndex] = min(abs(freqVect - this.an.wf.stimFreq));
        if this.an.wf.stimFreqInterval > 0;
            rectangle('Position', [freqVect(stimFreqIndex) - this.an.wf.stimFreqInterval, yLims(1) + 10E-9, ...
                this.an.wf.stimFreqInterval * 2, diff(yLims) * 0.95], 'FaceColor', [0.9 0.9 0.9]', 'EdgeColor', 'none', ...
                'Parent', axeH);
        end;
    end;
    for iBin = binsToPlot;
        plot(axeH, freqVect, phaseVect(iBin, :), 'Color', cols(iBin, :));
    end;
    if this.an.wf.stimFreq > 0;
        % add label for currently analysed frequency
        hLine = line(repmat(freqVect(stimFreqIndex), 1, 2), yLims, 'Color', [0.2 0.2 0.2]', 'LineWidth', 0.5, ...
            'LineStyle', ':', 'Parent', axeH);
    end;
    hold(axeH, 'off');
    % annotate axes
    set(axeH, 'XScale', 'log', 'XLim', [freqVect(1) freqVect(end)], 'FontSize', 15);
    xlabel(axeH, 'Frequency [Hz]', 'FontSize', 16);
    ylabel(axeH, 'Phase [rad]', 'FontSize', 25);
    set(axeH, 'YLim', yLims);
    
    % update position
    X = X + W + WPad;
    if sum(this.an.wf.subPlotsToShow) >= 4;
        Y = Y - H - HPad;
        X = baseX;
    end;
    
end;

%% phase diff
if this.an.wf.subPlotsToShow(3);

    % create axe
    axeH = axes('Parent', axeHParent, 'Color', 'white', 'Position', [X Y W H], 'Visible', 'on');
    axeHands(end + 1) = axeH;

    hold(axeH, 'on');
    plot(axeH, freqVect, nanmedian(abs(diff(abs(phaseVect)))), 'Color', 'black');
    yLims = get(axeH, 'YLim');
    yLims(1) = -0.5;
    if this.an.wf.stimFreq > 0;
        % add label for currently analysed frequency
        hLine = line(repmat(freqVect(stimFreqIndex), 1, 2), yLims, 'Color', [0.2 0.2 0.2]', 'LineWidth', 0.5, ...
            'LineStyle', ':', 'Parent', axeH);
    end;
    hold(axeH, 'off');
    % annotate axes
    set(axeH, 'XScale', 'log', 'XLim', [freqVect(1) freqVect(end)], 'YLim', yLims, 'FontSize', 15);
    xlabel(axeH, 'Frequency [Hz]', 'FontSize', 16);
    ylabel(axeH, '\Deltaabs(phase)', 'FontSize', 25);
    
    % update position
    X = X + W + WPad;
    
end;

%% phase diff with power
if this.an.wf.subPlotsToShow(4);

    % create axe
    axeH = axes('Parent', axeHParent, 'Color', 'white', 'Position', [X Y W H], 'Visible', 'on');
    axeHands(end + 1) = axeH;

    hold(axeH, 'on');
    plot(axeH, freqVect, nanmean(log10(powVect)) .* nanmedian(abs(diff(abs(phaseVect)))), 'Color', 'black');
    yLims = get(axeH, 'YLim');
    yLims(1) = -0.5;
    yLims(2) = 5;
    if this.an.wf.stimFreq > 0;
        % add label for currently analysed frequency
        hLine = line(repmat(freqVect(stimFreqIndex), 1, 2), yLims, 'Color', [0.2 0.2 0.2]', 'LineWidth', 0.5, ...
            'LineStyle', ':', 'Parent', axeH);
    end;
    hold(axeH, 'off');
    % annotate axes
    set(axeH, 'XScale', 'log', 'XLim', [freqVect(1) freqVect(end)], 'YLim', yLims, 'FontSize', 15);
    xlabel(axeH, 'Frequency [Hz]', 'FontSize', 16);
    ylabel(axeH, '\Deltaabs(phase) * log_{10}(power)', 'FontSize', 15);
    
    % update position
    X = X + W + WPad; %#ok<NASGU>
    
end;

% legend
if this.an.wf.stimFreq > 0;
    legend(axeHands(1), hLine, sprintf('Stim. freq. (%.3f Hz%s)', this.an.wf.stimFreq, ...
        iff(this.an.wf.stimFreqInterval == 0, '', sprintf(' \\pm %.3f Hz', this.an.wf.stimFreqInterval))), 'Location', 'best');
end;

linkaxes(axeHands, 'x');

o('#%s: plot done (%3.1f sec).', mfilename(), toc(plotTic), 2, this.verb);

% hide the message and show plot
ANShowHideMessage(this, 0, 'Update analyser plot done.');


end
