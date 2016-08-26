function OCIA_analysis_widefield_stdPixelTimeCourse(this, iDWRows)
% OCIA_analysis_widefield_stdPixelTimeCourse - [no description]
%
%       OCIA_analysis_widefield_stdPixelTimeCourse(this, iDWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% plotting parameter UI controls
paramConf = cell2table({ ...
... categ  id                   UIType      valueType       UISize  isLabAbove  label               tooltip
    'wf',  'nBinsToPlot',       'text',     { 'numeric' },  [1 0],  false,      'N. bins to plot',  'Number of bins to plot.';
    'wf',  'pixTCYLim',         'text',     { 'array' },    [1 0],  false,      'PixTC YLim',       'Y limits of the pixel time course plot.';
    'wf',  'showSingleTrials',  'dropdown', { 'true', 'false' }, [1 0], false,  'Show trials',      'Show single trials.';
    
}, 'VariableNames', this.GUI.an.paramPanConfig.Properties.VariableNames);
OCIA_analysis_widefield_addParamPanConfigUIControls(this, '(CLim|Filt|Delay|Shift|Thresh)', paramConf);

%% get the data
try
    [pixelTimeCourse, t] = OCIA_analysis_widefield_getPixTimeCourse_standard(this, iDWRows(1));
catch
    [pixelTimeCourse, t, attribs] = OCIA_analysis_widefield_getPixTimeCourse_trials(this, iDWRows(1));
end;
% abort if no bins
nBins = this.an.wf.nBins;
nTrials = size(pixelTimeCourse, 3);
if isempty(nBins) || nBins == 0; return; end;
% no plot if no time course
if isempty(pixelTimeCourse); return; end;

%% plot
ANShowHideMessage(this, 1, 'Plotting ...');
plotTic = tic; % for performance timing purposes
o('#%s: plot done (%3.1f sec).', mfilename(), toc(plotTic), 2, this.verb);

% get plotting axe
axeH = this.GUI.handles.an.axe;

% select the color scheme
switch nBins * nBins;
    case 1;     cols = [1 0 0]; % red
    case 2;     cols = [1 0 0; 0 0 1;]; % red & blue
    case 3;     cols = [1 0 0; 0 1 0; 0 0 1]; % red, green, blue
    case 4;     cols = [1 0 0; 0 1 0; 0 0 1; 0 0 0]; % red, green, blue, black
    otherwise;  cols = hsv(nBins * nBins); % rainbow
end;

% select which bins to plot
binsToPlot = 1 : ceil(nBins * nBins / this.an.wf.nBinsToPlot) : (nBins * nBins);

hold(axeH, 'on');

% rectangle label of baseline frames
baseFrames = this.an.wf.baseFrames;
evokedFrames = this.an.wf.evokedFrames;
yOff = 3;

if all(baseFrames > 0);
    rectangle('Position', [t(baseFrames(1)) - 0.01, this.an.wf.pixTCYLim(1) + 0.1, ...
        t(baseFrames(end)) - t(baseFrames(1)) + 0.02, diff(this.an.wf.pixTCYLim) * 0.98], ...
        'FaceColor', [1 0.85 0.85]', 'EdgeColor', 'none', 'Parent', axeH);
    line([t(baseFrames(1)) - 0.01, t(baseFrames(1)) - 0.01], ...
        [this.an.wf.pixTCYLim(1) + 0.1, this.an.wf.pixTCYLim(1) + yOff + diff(this.an.wf.pixTCYLim) * 0.98], ...
        'Color', [1 0 0], 'Parent', axeH);
    hBase = line([t(baseFrames(end)) + 0.01, t(baseFrames(end)) + 0.01], ...
        [this.an.wf.pixTCYLim(1) + yOff, this.an.wf.pixTCYLim(1) + yOff + diff(this.an.wf.pixTCYLim) * 0.98], ...
        'Color', [1 0 0], 'Parent', axeH);

    rectangle('Position', [t(evokedFrames(1)) - 0.01, this.an.wf.pixTCYLim(1) + yOff, ...
        t(evokedFrames(end)) - t(evokedFrames(1)) + 0.02, diff(this.an.wf.pixTCYLim) * 0.98], ...
        'FaceColor', [0.85 0.85 1]', 'EdgeColor', 'none', 'Parent', axeH);
    line([t(evokedFrames(1)) - 0.01, t(evokedFrames(1)) - 0.01], ...
        [this.an.wf.pixTCYLim(1) + yOff, this.an.wf.pixTCYLim(1) + yOff + diff(this.an.wf.pixTCYLim) * 0.98], ...
        'Color', [0 0 1], 'Parent', axeH);
    hEvok = line([t(evokedFrames(end)) + 0.01, t(evokedFrames(end)) + 0.01], ...
        [this.an.wf.pixTCYLim(1) + yOff, this.an.wf.pixTCYLim(1) + yOff + diff(this.an.wf.pixTCYLim) * 0.98], ...
        'Color', [0 0 1], 'Parent', axeH);
end;

if exist('attribs', 'var');
    rectangle('Position', [0, this.an.wf.pixTCYLim(1) + yOff, attribs.fouStimDur, diff(this.an.wf.pixTCYLim) * 0.98], ...
        'FaceColor', [0.85 0.85 0.85]', 'EdgeColor', 'none', 'Parent', axeH);
    line([0 0], [this.an.wf.pixTCYLim(1) + yOff, this.an.wf.pixTCYLim(1) + yOff + diff(this.an.wf.pixTCYLim) * 0.98], ...
        'Color', [0 0 0], 'Parent', axeH);
    hStim = line([attribs.fouStimDur, attribs.fouStimDur], ...
        [this.an.wf.pixTCYLim(1) + yOff, this.an.wf.pixTCYLim(1) + yOff + diff(this.an.wf.pixTCYLim) * 0.98], ...
        'Color', [0 0 0], 'Parent', axeH);
end;

for iBin = binsToPlot;
    if this.an.wf.showSingleTrials;
        for iTrial = 1 : nTrials;
            plot(axeH, t, pixelTimeCourse(iBin, :, iTrial), 'Color', cols(iBin, :), 'LineStyle', ':');
        end;
    end;
    plot(axeH, t, nanmean(pixelTimeCourse(iBin, :, :), 3), 'Color', cols(iBin, :), 'LineWidth', 2);
end;

hold(axeH, 'off');

% annotate axes
tDiff = (t(2) - t(1)) * 2 + 0.05;
set(axeH, 'XLim', [t(1) - tDiff t(end) + tDiff], 'FontSize', 15);
xlabel(axeH, 'Time [sec]', 'FontSize', 16);
ylabel(axeH, '\DeltaF / F [%]', 'FontSize', 25);
set(axeH, 'YLim', this.an.wf.pixTCYLim);
if all(baseFrames > 0);
    legend(axeH, [hBase hEvok], { 'baseline', 'evoked' });
end;
if exist('attribs', 'var');
    legend(axeH, hStim, 'stimulus');
end;

% hide the message and show plot
ANShowHideMessage(this, 0, 'Update analyser plot done.');


end
