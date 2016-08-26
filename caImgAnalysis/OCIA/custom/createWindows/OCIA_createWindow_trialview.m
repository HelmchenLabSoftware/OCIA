function OCIA_createWindow_trialview(this, pad)
% OCIA_createWindow_trialview - [no description]
%
%       OCIA_createWindow_trialview(this, pad)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

BGWhite = {'Background', 'white'}; %#ok<*CCAT>
NormUnits = {'Units', 'normalized'};

%% common input arguments
padX = pad; padY = pad;
imAxeCommons = { NormUnits{:}, 'XColor', 'white', 'YColor', 'white', 'XGrid', 'off', 'YGrid', 'off', ...
    'XTick', [], 'YTick', [], 'FontSize', this.GUI.pos(3) / 120, 'DataAspectRatio', [1 1 1] };
tcAxeCommons = { NormUnits{:}, 'Box', 'off', 'XColor', 'white', 'YColor', 'black', 'XGrid', 'off', 'YGrid', 'off', ...
    'XTick', [], 'XLim', [0, 1], 'FontSize', this.GUI.pos(3) / 120, 'YTick', [], 'TickDir', 'out', ...
    'ButtonDownFcn', @(h, e) OCIA_trialview_changeFrame(this, h, e) };
panCommons = { NormUnits{:}, BGWhite{:}, 'Parent', this.GUI.handles.panels.TrialViewPanel, ...
    'FontSize', this.GUI.pos(3) / 125 };

%% configuration
% main panel
panX = padX; panH = (1 - 3 * padY) * 0.5; panY = 1 - panH - padY; panW = (1 - 4 * padX) * 0.25;
tvH.paramPan = uipanel(panCommons{:}, 'Title', 'Parameters', 'Position', [panX panY panW panH]);

%% behavior camera viewer
% main panel
panX = panX + panW + padX; panH = (1 - 3 * padY) * 0.5; panY = 1 - panH - padY; panW = (1 - 4 * padX) * 0.38;
tvH.behav.panel = uipanel(panCommons{:}, 'Title', 'Behavior', 'Position', [panX, panY, panW, panH]);
% axe with image
tvH.behav.axe = axes(imAxeCommons{:}, 'Parent', tvH.behav.panel, 'Position', [padX, padY, 1 - 2 * padX, 1 - 2 * padY], ...
    'Tag', 'behav');
tvH.behav.img = imagesc(zeros(this.tv.params.behavMovieSize), 'Parent', tvH.behav.axe);
% restore aspect ratio
set(tvH.behav.axe, 'DataAspectRatio', [1 1 1], 'XTick', [], 'YTick', []);

%% wide-field data viewer
panX = panX + panW + padX; panH = (1 - 4 * padY ) * 0.5; panY = 1 - panH - padY; panW = (1 - 4 * padX) * 0.37;
tvH.wf.panel = uipanel(panCommons{:}, 'Title', 'Wide-field', 'Position', [panX, panY, panW, panH]);
% axe with image
tvH.wf.axe = axes(imAxeCommons{:}, 'Parent', tvH.wf.panel, 'Position', [padX, padY, 1 - 2 * padX, 1 - 2 * padY], ...
    'Tag', 'wf');
tvH.wf.img = imagesc(zeros(this.tv.params.WFDataSize(1 : 2)), 'Parent', tvH.wf.axe);
tvH.wf.cBar = colorbar(tvH.wf.axe, 'EastOutside'); set(tvH.wf.cBar, 'FontSize', this.GUI.pos(3) / 170);
% set display parameters
set(tvH.wf.axe, 'CLim', this.tv.params.WFCLim, 'DataAspectRatio', [1 1 1], 'XTick', [], 'YTick', []);

%% time-course viewer
panX = padX; tcPanH = (1 - 4 * padY ) * 0.5; panY = 1 - panH - tcPanH - 2 * padY; panW = (1 - 2 * padX) * 1;
tvH.tc.panel = uipanel(panCommons{:}, 'Title', 'Time course', 'Position', [panX, panY, panW, tcPanH]);
% axes
nAxes = 2; innerPadY = 0.01; padTop = 0.05; padLeft = 0.05; padRight = 0.05; padBot = 0.12;
totAxeH = (1 - padBot - padTop - (nAxes + 1) * innerPadY);
pAxeY = padBot + padY; axeH = totAxeH * 0.2; axeW = 1 - padRight - padLeft - 2 * padX;
tvH.tc.whiskLickAxe = axes(tcAxeCommons{:}, 'Parent', tvH.tc.panel, 'Position', [padLeft, pAxeY, axeW, axeH], ...
    'XTick', [0, 1], 'XColor', 'black');
pAxeY = pAxeY + axeH + innerPadY; axeH = totAxeH * 0.8;
tvH.tc.ROIAxe = axes(tcAxeCommons{:}, 'Parent', tvH.tc.panel, 'Position', [padLeft, pAxeY, axeW, axeH]);

% link all axes on the X axis (time)
linkaxes([tvH.tc.ROIAxe, tvH.tc.whiskLickAxe(1), tvH.tc.whiskLickAxe(1)], 'x');

% init storage for timeline info elements, ROI time courses and move vector elements
tvH.tc.timeLineInfoElems = {};
tvH.tc.ROITimeCourses = {};
tvH.tc.moveVectElems = {};

% customize the whisk/lick axes with a yy-plot
[tvH.tc.whiskLickAxe, tvH.tc.whiskTrace, tvH.tc.lickTrace]...
    = plotyy(tvH.tc.whiskLickAxe, [1, 2], [0, 1], [1, 2], [0, 1], 'plot');
hold(tvH.tc.whiskLickAxe(2), 'on');
tvH.tc.micrTrace = plot(tvH.tc.whiskLickAxe(2), [1, 2], [0, 1]);
tvH.tc.trigTrace = plot(tvH.tc.whiskLickAxe(2), [1, 2], [0, 1]);
hold(tvH.tc.whiskLickAxe(2), 'off');
% set colors of whisker trace and its axe
set(tvH.tc.whiskTrace, 'Color', 'black', 'XData', [0, 0], 'YData', [0, 0]);
set(tvH.tc.whiskLickAxe(1), tcAxeCommons{:}, 'YColor', 'black', 'XColor', 'black');
% set colors of lick trace and its axe
set(tvH.tc.lickTrace, 'Color', 'red', 'XData', [0, 0], 'YData', [0, 0]);
set(tvH.tc.whiskLickAxe(2), tcAxeCommons{:}, 'YColor', 'red');
% set colors of micr and trig trace
set(tvH.tc.micrTrace, 'Color', 'green', 'XData', [0, 0], 'YData', [0, 0]);
set(tvH.tc.trigTrace, 'Color', 'blue', 'XData', [0, 0], 'YData', [0, 0]);

% plot the time bar on all axis
axeNames = fieldnames(tvH.tc);
axeNames(arrayfun(@(i)isempty(regexp(axeNames{i}, 'Axe$', 'once')), 1 : numel(axeNames))) = [];
tvH.tc.timeBar = zeros(numel(axeNames), 1);
for iAxe = 1 : numel(axeNames);
    axeH = tvH.tc.(axeNames{iAxe});
    if numel(axeH) > 1; axeH = axeH(1); end;
    % get Y limits of the time course axe
    yLims = get(axeH, 'YLim');
    % plot the line without changing the rest
    hold(axeH, 'on');
    tvH.tc.timeBar(iAxe) = plot(axeH, [0, 0], yLims, 'Color', 'red', 'LineStyle', ':', 'LineWidth', 1);
    hold(axeH, 'off');
end;
% store handles
this.GUI.handles.tv = tvH;

end
