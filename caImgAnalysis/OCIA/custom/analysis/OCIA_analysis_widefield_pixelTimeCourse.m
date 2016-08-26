function OCIA_analysis_widefield_pixelTimeCourse(this, iDWRows)
% OCIA_analysis_widefield_pixelTimeCourse - [no description]
%
%       OCIA_analysis_widefield_pixelTimeCourse(this, iDWRows)
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
OCIA_analysis_widefield_addParamPanConfigUIControls(this, '(CLim|Filt|Delay|Shift|baseFrames|evokedFrames|Thresh)', paramConf);

%% get the data
[pixelTimeCourse, t] = OCIA_analysis_widefield_getPixTimeCourse(this, iDWRows(1));
% abort if no bins
nBins = this.an.wf.nBins;
nTotBins = prod(nBins);
if isempty(nBins) || any(nBins == 0); return; end;
% no plot if no data
if isempty(pixelTimeCourse); return; end;

if ~isempty(this.an.wf.ROIMasks);
    nTotBins = size(this.an.wf.ROIMasks, 3);
end;

%% get stim vector if there is one
% fetch info
[~, ~, ~, ~, framesDim, frameRate, ~, ~, ~, attribs] = OCIA_analysis_widefield_getFileInfo(this, iDWRows(1), true);

% limit frame range
frameRange = this.an.wf.frameRange;
if frameRange(2) == -1; frameRange(2) = Inf; end;
frameRange = [max(1, frameRange(1)), min(framesDim(3), frameRange(end))];
framesDim(3) = diff(frameRange) + 1;

% create stim vector using stimulus frequency
stimFreq = 1 / (attribs.sweepDur / numel(attribs.fouBaseFreq));
nFrames = framesDim(3);

% calculate dimensions
nMaxTrials = round(round(nFrames / frameRate) * stimFreq);
nFramesTrial = round((1 / stimFreq) * frameRate);

% create stim vector
stimVect = zeros(1, nFrames);
stimVect(1 : nFramesTrial : (nMaxTrials * nFramesTrial - 1)) = 1;
stimFrames = find(stimVect);
uniqueFreqs = unique(attribs.fouBaseFreq);
nStimTypes = numel(uniqueFreqs);
[~, stimSeq] = ismember(attribs.fouBaseFreq, uniqueFreqs);
iStim = 1;
% create stimulus vector sequence
for iStimFrame = 1 : numel(stimFrames);
    stimVect(stimFrames(iStimFrame)) = stimSeq(iStim);
    iStim = iStim + 1;
    if iStim > numel(stimSeq); iStim = 1; end;
end;

% % create stimulus IDs
% stimIDs = regexp(regexprep(sprintf('%dkHz-', round(uniqueFreqs / 1000)), '-$', ''), '-', 'split');

%% plot
ANShowHideMessage(this, 1, 'Plotting ...');
plotTic = tic; % for performance timing purposes
o('#%s: plot done (%3.1f sec).', mfilename(), toc(plotTic), 2, this.verb);

% get plotting axe
axeH = this.GUI.handles.an.axe;
% basePos = get(axeH, 'Position');
% basePos(1) = 0.07;
% basePos(3) = 0.9;
% basePos(2) = 0.12;
% basePos(4) = 0.70;
% set(axeH, 'Position', basePos);

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

hold(axeH, 'on');
for iBin = binsToPlot;
    plot(axeH, t, pixelTimeCourse(iBin, :), 'Color', cols(iBin, :));
end;
hold(axeH, 'off');

if ~isempty(stimVect);

    hold(axeH, 'on');
    stimColors = lines(nStimTypes);
    for iStim = 1 : nStimTypes;
        stimFramesForStim = stimVect == iStim;
        tVect = repmat(t(stimFramesForStim), 2, 1);
        limsVect = repmat(this.an.wf.pixTCYLim', 1, size(tVect, 2));
        plot(axeH, tVect, limsVect, 'Color', stimColors(iStim, :));
    end;
    hold(axeH, 'off');
end;

% annotate axes
tDiff = (t(2) - t(1)) * 2 + 0.1;
set(axeH, 'XLim', [t(1) - tDiff t(end) + tDiff], 'FontSize', 15);
xlabel(axeH, 'Time [sec]', 'FontSize', 16);
ylabel(axeH, 'Fluorescence [a.u.]', 'FontSize', 25);
set(axeH, 'YLim', this.an.wf.pixTCYLim);

% hide the message and show plot
ANShowHideMessage(this, 0, 'Update analyser plot done.');


end
