function OCIA_createWindow_intrinsic(this, pad)
% OCIA_createWindow_intrinsic - [no description]
%
%       OCIA_createWindow_intrinsic(this, pad)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

BGWhite = {'Background', 'white'}; %#ok<*CCAT>
NormUnits = {'Units', 'normalized'};
bPad = 0.005;

%% - #OCIACreateWindow: Intrinsic panels
commons = {'Parent', this.GUI.handles.panels.IntrinsicPanel, BGWhite{:}, 'Units', ...
    'normalized', 'Visible', 'on', 'FontSize', this.GUI.pos(4) / 95};

totWTop = (1 - 4 * pad);
totWBottom = (1 - 3 * pad);
prevPanW = 1/3 * totWTop; prevPanH = 0.5 - 1.5 * pad; prevPanX = pad; prevPanY = 1 - pad - prevPanH;
expPanW = 1/3 * totWTop; expPanH = 0.5 - 1.5 * pad;
expPanLX = prevPanX + prevPanW + pad; expPanLY = prevPanY;
expPanRX = expPanLX + expPanW + pad; expPanRY = prevPanY;
anaPanX = expPanLX; anaPanY = prevPanY; anaPanW = 2/3 * totWTop + pad; anaPanH = prevPanH;
refPanW = 1/3 * totWBottom; refPanH = 0.5 - 0.5 * pad; refPanX = pad; refPanY = pad;
paramPanW = 2/3 * totWBottom; paramPanH = 0.5 - 0.5 * pad; paramPanX = refPanX + refPanW + pad; paramPanY = pad;

this.GUI.handles.in.panels.prev = uipanel(commons{:}, 'Title', 'Preview image', 'Tag', 'INPrevPan', ...
    'Position', [prevPanX prevPanY prevPanW prevPanH]);
this.GUI.handles.in.standard.expLeft = uipanel(commons{:}, 'Title', 'Average image BASELINE', 'Tag', 'INExpLeftPan', ...
    'Position', [expPanLX expPanLY expPanW expPanH]);
this.GUI.handles.in.standard.expRight = uipanel(commons{:}, 'Title', 'Average image STIMULUS', 'Tag', 'INExpRightPan', ...
    'Position', [expPanRX expPanRY expPanW expPanH]);
this.GUI.handles.in.fourier.anaPan = uipanel(commons{:}, 'Title', 'Analysis', 'Tag', 'INAnaPan', ...
    'Position', [anaPanX anaPanY anaPanW anaPanH]);
this.GUI.handles.in.panels.ref = uipanel(commons{:}, 'Title', 'Reference image', 'Tag', 'INRefPan', ...
    'Position', [refPanX refPanY refPanW refPanH]);
this.GUI.handles.in.panels.param = uipanel(commons{:}, 'Title', 'Parameters', 'Tag', 'INParamPan', ...
    'Position', [paramPanX paramPanY paramPanW paramPanH]);

%% - #OCIACreateWindow: Intrinsic: preview imadjust axe
axePadX = 0.01; axePadY = 0.01;
sliderCommons = { 'Parent', this.GUI.handles.in.panels.prev, NormUnits{:}, 'Style', 'slider', 'SliderStep', [0.01 0.1] };
prevAxeW = 1 - 2 * axePadX - 2 * bPad; prevAxeH = 1 - 2 * axePadY - 2 * bPad; prevAxeX = axePadX + bPad;
imAdjPrevSliderW = (prevAxeW - bPad) * 0.4; imAdjPrevSliderH = axePadY * 3;
imAdjPrevSliderX = prevAxeX; imAdjPrevSliderY = axePadY + bPad;
this.GUI.handles.in.imAdjMinPrev = uicontrol(sliderCommons{:}, 'Min', 0, 'Max', 1, 'Tag', 'INPrevAxeImAdjMin', ...
    'Position', [imAdjPrevSliderX imAdjPrevSliderY imAdjPrevSliderW imAdjPrevSliderH], 'Value', 0.05);
this.GUI.handles.in.imAdjMaxPrev = uicontrol(sliderCommons{:}, 'Min', 0, 'Max', 1, 'Tag', 'INPrevAxeImAdjMax', ...
    'Position', [imAdjPrevSliderX + imAdjPrevSliderW + bPad imAdjPrevSliderY imAdjPrevSliderW imAdjPrevSliderH], ...
    'Value', 0.95);


%% - #OCIACreateWindow: Intrinsic: show saturation or not
checkBoxCommons = { 'Parent', this.GUI.handles.in.panels.prev, NormUnits{:}, 'Style', 'checkbox', ...
    'FontSize', this.GUI.pos(4) / 75, BGWhite{:}, 'Value', 0 };
showSatW = (prevAxeW - bPad) * 0.2; showSatH = imAdjPrevSliderH;
showSatX = imAdjPrevSliderX + 2 * imAdjPrevSliderW + 3 * bPad; showSatY = imAdjPrevSliderY;
this.GUI.handles.in.prevShowSaturation = uicontrol(checkBoxCommons{:}, 'String', 'Sat. ?', 'Tag', 'INShoSat', ...
    'Position', [showSatX showSatY showSatW showSatH]);

%% - #OCIACreateWindow: Intrinsic: preview axes
axesCommons = { 'Color', [0.5 0.5 0.5], NormUnits{:}, 'XTick', [], 'YTick', [] };
prevAxeY = imAdjPrevSliderY + imAdjPrevSliderH + axePadY + bPad;
this.GUI.handles.in.prevAxe = axes(axesCommons{:}, 'Parent', this.GUI.handles.in.panels.prev, 'Tag', 'INPrevAxe', ...
    'Position', [prevAxeX prevAxeY prevAxeW prevAxeH]);
% the creation of the image is done later to avoid weird flickering effect due to imshow
this.GUI.handles.in.prevImg = [];

%% - #OCIACreateWindow: Intrinsic: reference axes
this.GUI.handles.in.refAxe = axes(axesCommons{:}, 'Parent', this.GUI.handles.in.panels.ref, 'Tag', 'INRefAxe', ...
    'Position', [prevAxeX prevAxeY prevAxeW prevAxeH]);

%% - #OCIACreateWindow: Intrinsic: experiment axes
axePadX = 0.01; axePadY = 0.02;
expAxeLeftW = 1 - 2 * axePadX - 2 * bPad; expAxeLeftH = 1 - 2 * axePadY - 2 * bPad;
expAxeLeftX = axePadX + bPad; expAxeLeftY = axePadY + bPad;
this.GUI.handles.in.expAxeLeft = axes(axesCommons{:}, 'Parent', this.GUI.handles.in.standard.expLeft, ...
    'Tag', 'INExpAxeLeft', 'Position', [expAxeLeftX expAxeLeftY expAxeLeftW expAxeLeftH]);
expAxeRightW = 1 - 2 * axePadX - 2 * bPad; expAxeRightH = 1 - 2 * axePadY - 2 * bPad;
expAxeRightX = axePadX + bPad; expAxeRightY = axePadY + bPad;
this.GUI.handles.in.expAxeRight = axes(axesCommons{:}, 'Parent', this.GUI.handles.in.standard.expRight, ...
    'Tag', 'INExpAxeRight', 'Position', [expAxeRightX expAxeRightY expAxeRightW expAxeRightH]);


%% - #OCIACreateWindow: Intrinsic: analysis axes
axePadL = 0.05; axePadB = 0.09; axePadT = 0.025; axePadR = 0.01;
anAxeX = axePadL + bPad; anAxeY = axePadB + bPad;
anAxeW = 1 - axePadL - axePadR - 2 * bPad; anAxeH = 1 - axePadB - axePadT - 2 * bPad;
this.GUI.handles.in.anAxe = axes('Parent', this.GUI.handles.in.fourier.anaPan, NormUnits{:}, 'Tag', 'INAnAxe', ...
    'Position', [anAxeX anAxeY anAxeW anAxeH], 'Color', 'none', 'Visible', 'off');

%% - #OCIACreateWindow: Intrinsic: Parameter panel: general button
commons = {'Parent', this.GUI.handles.in.panels.param, NormUnits{:}, 'Style', 'togglebutton', 'FontSize', this.GUI.pos(4) / 75};
nButs = 10; totW = (1 - (nButs + 1) * bPad);

connW = 0.1 * totW; connH = 0.07; connX = bPad; connY = 1 - connH - bPad;
this.GUI.handles.in.connect = uicontrol(commons{:}, 'String', 'Connect', 'BackgroundColor', iff(this.in.connected, 'green', 'red'), ...
    'Position', [connX connY connW connH], 'Callback', @(h, e)INConnect(this, h, e), 'Tag', 'INConnect');
prevButW = 0.1 * totW; prevButH = connH; prevButX = connX + connW + bPad; prevButY = connY;
this.GUI.handles.in.prevBut = uicontrol(commons{:}, 'String', 'Preview', 'BackgroundColor', iff(this.in.previewRunning, 'green', 'red'), ...
    'Position', [prevButX prevButY prevButW prevButH], 'Callback', @(h, e)INPreview(this, h, e), 'Tag', 'INPrev');
refButW = 0.1 * totW; refButH = connH; refButX = prevButX + prevButW + bPad; refButY = connY;
this.GUI.handles.in.refBut = uicontrol(commons{:}, 'String', 'Grab ref.', 'Tag', 'INGrabRef', ...
    'Position', [refButX refButY refButW refButH], 'Callback', @(h, e)INGrabReferenceImage(this, h, e));
testStimButW = 0.1 * totW; testStimButH = connH; testStimButX = refButX + refButW + bPad; testStimButY = connY;
this.GUI.handles.in.testStimBut = uicontrol(commons{:}, 'String', 'Test stim.', 'Tag', 'INTestStim', ...
    'Position', [testStimButX testStimButY testStimButW testStimButH], 'Callback', @(h, e)INTestStim(this, h, e));
runExpButW = 0.08 * totW; runExpButH = connH; runExpButX = testStimButX + testStimButW + bPad; runExpButY = connY;
this.GUI.handles.in.runExpBut = uicontrol(commons{:}, 'String', 'Run', 'Tag', 'INRunExp', 'BackgroundColor', 'red', ...
    'Position', [runExpButX runExpButY runExpButW runExpButH], 'Callback', @(h, e)INRunExp(this, h, e));
stopButW = 0.08 * totW; stopButH = connH; stopButX = runExpButX + runExpButW + bPad; stopButY = connY;
this.GUI.handles.in.stopBut = uicontrol(commons{:}, 'String', 'Stop', 'Tag', 'INStop', 'BackgroundColor', 'red', ...
    'Style', 'pushbutton', 'Position', [stopButX stopButY stopButW stopButH], ...
    'Callback', @(h, e)INCleanUp(this, h, e));

%% - #OCIACreateWindow: Intrinsic: zoom button
commons = {'Parent', this.GUI.handles.in.panels.param, NormUnits{:}, 'Value', 0, 'Style', 'togglebutton'};
zToolW = totW * 0.045; zToolH = connH; zToolX = stopButX + stopButW + bPad; zToolY = stopButY;
zToolIcon = load(fullfile(matlabroot(), '/toolbox/matlab/icons/zoom.mat'));
this.GUI.handles.in.zTool = uicontrol(commons{:}, 'Tag', 'INZTool', 'CData', zToolIcon.zoomCData, ...
    'Position', [zToolX, zToolY, zToolW, zToolH], 'Callback', @(h, e)INActivateZoom(this, h, e), ...
    'ToolTipString', 'Zoom');

%% - #OCIACreateWindow: Intrinsic: pan button
pToolW = zToolW; pToolH = zToolH; pToolX = zToolX + zToolW + bPad; pToolY = zToolY;
pToolIcon = load(fullfile(matlabroot(), '/toolbox/matlab/icons/pan.mat'));
this.GUI.handles.in.pTool = uicontrol(commons{:}, 'CData', pToolIcon.cdata, 'Tag', 'INPTool', ...
    'Position', [pToolX, pToolY, pToolW, pToolH], 'Callback', @(h, e)INActivatePan(this, h, e), ...
    'ToolTipString', 'Pan (scroll)');

%% - #OCIACreateWindow: Intrinsic: data cursor button
cToolW = zToolW; cToolH = zToolH; cToolX = pToolX + pToolW + bPad; cToolY = zToolY;
cToolIcon = load(fullfile(matlabroot(), '/toolbox/matlab/icons/datatip.mat'));
this.GUI.handles.in.cTool = uicontrol(commons{:}, 'CData', cToolIcon.cdata, 'Tag', 'INCTool', ...
    'Position', [cToolX, cToolY, cToolW, cToolH], 'Callback', @(h, e)INActivateDataCursor(this, h, e), ...
    'ToolTipString', 'Data cursor');

%% - #OCIACreateWindow: Intrinsic: draw ROI
commons = {'Parent', this.GUI.handles.in.panels.param, NormUnits{:}, 'Style', 'pushbutton', 'FontSize', 13};
drawROIW = zToolW; drawROIH = zToolH; drawROIX = cToolX + cToolW + bPad; drawROIY = zToolY;
iconPath = regexprep(which('OCIA'), '@OCIA.OCIA\.m', 'icons/menuIcons/freehandDrawTool.png');
cData = linScale(double(imread(iconPath))); % get the icon
cData(cData == 0) = NaN; % make transparency
this.GUI.handles.in.drawROI = uicontrol(commons{:}, 'CData', cData, 'Tag', 'INCTool', ...
    'Position', [drawROIX, drawROIY, drawROIW, drawROIH], 'Callback', @(h, e)INDrawROI(this, h, e), ...
    'ToolTipString', 'Draw ROI');

%% - #OCIACreateWindow: Intrinsic: save plot button
savePlotW = zToolW; savePlotH = zToolH; savePlotX = drawROIX + drawROIW + bPad; savePlotY = zToolY;
% savePlotW = zToolW; savePlotH = zToolH; savePlotX = zToolX; savePlotY = zToolY - savePlotH - bPad;
savePlotIcon = load(fullfile(matlabroot(), '/toolbox/matlab/icons/savedoc.mat'));
this.GUI.handles.in.savePlot = uicontrol(commons{:}, 'CData', savePlotIcon.cdata, 'Tag', 'INSavePlot', ...
    'Position', [savePlotX, savePlotY, savePlotW, savePlotH], 'Callback', @(~, ~)INSaveImages(this, []), ...
    'ToolTipString', 'Save the currently displayed images to figures (.fig) or images (.png/.jpg/...)).');

%% - #OCIACreateWindow: Intrinsic: save output button
saveOutW = zToolW; saveOutH = zToolH; saveOutX = savePlotX + savePlotW + bPad; saveOutY = savePlotY;
saveOutIcon = linScale(double(imread(regexprep(which('OCIA'), '@OCIA.OCIA\.m', 'icons/menuIcons/saveOutput.png'))));
saveOutIcon(saveOutIcon == 0) = NaN;
this.GUI.handles.in.saveOut = uicontrol(commons{:}, 'CData', saveOutIcon, 'Tag', 'INSaveOutput', ...
    'Position', [saveOutX, saveOutY, saveOutW, saveOutH], 'Callback', @(~, ~)INSave(this, []), ...
    'ToolTipString', 'Save output results as a MAT-file');

%% - #OCIACreateWindow: Intrinsic: load output button
loadOutW = zToolW; loadOutH = zToolH; loadOutX = saveOutX + saveOutW + bPad; loadOutY = savePlotY;
loadOutIcon = linScale(double(imread(regexprep(which('OCIA'), '@OCIA.OCIA\.m', 'icons/menuIcons/loadOutput.png'))));
loadOutIcon(loadOutIcon == 0) = NaN;
this.GUI.handles.in.loadOut = uicontrol(commons{:}, 'CData', loadOutIcon, 'Tag', 'INLoadOutput', ...
    'Position', [loadOutX, loadOutY, loadOutW, loadOutH], 'Callback', @(~, ~)INLoad(this, []), ...
    'ToolTipString', 'Load output results from MAT-file');

%% - #OCIACreateWindow: Intrinsic: clear data
clearCacheW = zToolW; clearCacheH = zToolH; clearCacheX = loadOutX + loadOutW + bPad; clearCacheY = savePlotY;
iconPath = regexprep(which('OCIA'), '@OCIA.OCIA\.m', 'icons/menuIcons/reset.png');
clearCacheIcon = linScale(double(imread(iconPath)));
clearCacheIcon(clearCacheIcon == 0) = NaN;
this.GUI.handles.in.clearCache = uicontrol(commons{:}, 'CData', clearCacheIcon, 'Tag', 'INClearCache', ...
    'Position', [clearCacheX, clearCacheY, clearCacheW, clearCacheH], 'Callback', @(~, ~)INReset(this, []), ...
    'ToolTipString', 'Clear the data.');

%% - #OCIACreateWindow: Intrinsic: Parameter panel: experiment mode drop-down menu
expModeW = 0.12 * totW; expModeH = connH; expModeX = bPad; expModeY = connY - connH - bPad;
this.GUI.handles.in.expMode = uicontrol('Parent', this.GUI.handles.in.panels.param, NormUnits{:}, 'Style', 'popupmenu', ...
    BGWhite{:}, 'FontSize', this.GUI.pos(4) / 75, 'String', this.in.expModes, ...
    'Position', [expModeX expModeY expModeW expModeH], 'Callback', @(h, e)INChangeExpMode(this, h, e), ...
    'Value', find(strcmp(this.in.expMode, this.in.expModes)), 'Tag', 'INExpMode', 'ToolTipString', 'Experiment mode');

%% - #OCIACreateWindow: Intrinsic: Parameter panel: pre-set configurations drop-down menu
cfgW = 0.55 * totW; cfgH = connH; cfgX = expModeX + expModeW + bPad; cfgY = expModeY;
configLabels = sort(fieldnames(this.in.configs));
configLabels = regexprep(regexprep(regexprep(configLabels, 'x\d+_', ''), '_', ' '), '0p', '0.');
this.GUI.handles.in.cfg = uicontrol('Parent', this.GUI.handles.in.panels.param, NormUnits{:}, 'Style', 'popupmenu', ...
    BGWhite{:}, 'FontSize', this.GUI.pos(4) / 75, 'String', configLabels, 'Value', this.GUI.in.startPresetConfig, ...
    'Position', [cfgX cfgY cfgW cfgH], 'Callback', @(h, e)INChangePreSetConfig(this, h, e), ...
    'ToolTipString', 'Pre-set configuration for parameter pannel', 'Tag', 'INPreSetConfig');

%% - #OCIACreateWindow: Intrinsic: Parameter panel: camera formats drop down
camFormatW = 0.35 * totW; camFormatH = connH; camFormatX = cfgX + cfgW + bPad; camFormatY = expModeY;
this.GUI.handles.in.camFormat = uicontrol('Parent', this.GUI.handles.in.panels.param, NormUnits{:}, 'Style', 'popupmenu', ...
    BGWhite{:}, 'FontSize', this.GUI.pos(4) / 75, 'String', this.in.availableCamFormats, ...
    'Value', find(strcmp(this.in.common.camFormat, this.in.availableCamFormats)), ...
    'Position', [camFormatX camFormatY camFormatW camFormatH], 'Callback', @(h, e)INChangeCameraFormat(this, h, e), ...
    'ToolTipString', 'Available camera formats', 'Tag', 'INCameraFormat');

%% - #OCIACreateWindow: Intrinsic: Parameter panel: standard & fourier options pannel
commons = { 'Parent', this.GUI.handles.in.panels.param, BGWhite{:}, 'Units', ...
    'normalized' };
this.GUI.handles.in.fourier.fourierPanel = uipanel(commons{:}, 'Title', '', 'Tag', 'INFourierPan', ...
    'Position', [bPad expModeY - expModeH - 2 * bPad 1 - 2 * bPad connH], ...
    'Visible', iff(strcmp(this.in.expMode, 'fourier'), 'on', 'off'));
this.GUI.handles.in.standard.standardPanel = uipanel(commons{:}, 'Title', '', 'Tag', 'INStandardPan', ...
    'Position', [bPad expModeY - expModeH - 2 * bPad 1 - 2 * bPad connH], ...
    'Visible', iff(strcmp(this.in.expMode, 'standard'), 'on', 'off'));
this.GUI.handles.in.trial.trialPanel = uipanel(commons{:}, 'Title', '', 'Tag', 'INTrialPan', ...
    'Position', [bPad expModeY - expModeH - 2 * bPad 1 - 2 * bPad connH], ...
    'Visible', iff(strcmp(this.in.expMode, 'trial'), 'on', 'off'));

%% - #OCIACreateWindow: Intrinsic: Parameter panel: standard options pannel : average or single image checkbox
checkBoxCommons = { 'Parent', this.GUI.handles.in.standard.standardPanel, NormUnits{:}, 'Style', 'checkbox', ...
    'FontSize', this.GUI.pos(4) / 75, BGWhite{:}, 'Value', 1 };
showAvgW = 0.14; showAvgH = 1 - 2 * bPad; showAvgX = bPad; showAvgY = bPad;
this.GUI.handles.in.standard.showAvg = uicontrol(checkBoxCommons{:}, 'String', 'Average ?', 'Tag', 'INShowAvg', ...
    'Position', [showAvgX showAvgY showAvgW showAvgH], 'Callback', @(h, e)INUpdateGUI(this, h, e));

%% - #OCIACreateWindow: Intrinsic: Parameter panel: standard options pannel : single image include/exclude
inclRunW = showAvgW; inclRunH = showAvgH; inclRunX = showAvgX + showAvgW + bPad; inclRunY = showAvgY;
this.GUI.handles.in.standard.inclRun = uicontrol(checkBoxCommons{:}, 'String', 'Include ?', 'Tag', 'INInclRun', ...
    'Position', [inclRunX inclRunY inclRunW inclRunH], 'Callback', @(h, e)INSetInclRun(this, h, e), 'Enable', 'off');

%% - #OCIACreateWindow: Intrinsic: Parameter panel: standard options pannel : single image slider
runChoserW = 1 - inclRunX - inclRunW - 2 * bPad; runChoserH = showAvgH * 0.8;
runChoserX = inclRunX + inclRunW + bPad; runChoserY = showAvgY + showAvgH * 0.1;
this.GUI.handles.in.standard.runChooser = uicontrol('Parent', this.GUI.handles.in.standard.standardPanel, ...
    NormUnits{:}, 'Style', 'slider', ...
    'Position', [runChoserX runChoserY runChoserW runChoserH], 'Min', 0, 'Max', 10, 'Enable', 'off', ...
    'Callback', @(h, e)INUpdateGUI(this, h, e), 'Value', 1, 'SliderStep', [0.1 0.1], 'Tag', 'INRunChooser');

%% - #OCIACreateWindow: Intrinsic: Parameter panel: fourier options pannel : analysis buttons
butCommons = {'Parent', this.GUI.handles.in.fourier.fourierPanel, NormUnits{:}, 'Style', 'pushbutton', ...
    'FontSize', this.GUI.pos(4) / 75};
analyseFouW = 0.25; analyseFouH = 1 - 4 * bPad; analyseFouX = bPad; analyseFouY = bPad;
this.GUI.handles.in.fourier.analyseFou = uicontrol(butCommons{:}, 'String', 'Analyse (fou)', ...
    'Tag', 'INAnalyse', 'Position', [analyseFouX analyseFouY analyseFouW analyseFouH], ...
    'Callback', @(h, e)INAnalyse(this, h, e));

%% - #OCIACreateWindow: Intrinsic: Parameter panel: standard options pannel : analysis buttons
analyseStdW = 0.25; analyseStdH = 1 - 4 * bPad; analyseStdX = analyseFouX + analyseFouW + bPad; analyseStdY = bPad;
this.GUI.handles.in.standard.analyseStd = uicontrol(butCommons{:}, 'String', 'Analyse (std)', ...
    'Tag', 'INAnalyseStandard', 'Position', [analyseStdX analyseStdY analyseStdW analyseStdH], ...
    'Callback', @(h, e)INAnalyseStandard(this, h, e));

%% - #OCIACreateWindow: Intrinsic: Parameter panel: parameter panels
commons = {'Parent', this.GUI.handles.in.panels.param, BGWhite{:}, 'Units', ...
    'normalized', 'Visible', 'on', 'FontSize', this.GUI.pos(4) / 95};
paramPanPanW = 1 - 2 * bPad; paramPanPanH = cfgY - cfgH - 3 * bPad; paramPanPanX = bPad; paramPanPanY = bPad;
this.GUI.handles.in.paramPans.standard = uipanel(commons{:}, 'Title', 'Standard mode', 'Tag', 'INStdParamPan', ...
    'Position', [paramPanPanX paramPanPanY paramPanPanW paramPanPanH], 'Visible', iff(strcmp(this.in.expMode, 'standard'), 'on', 'off'));
this.GUI.handles.in.paramPans.fourier = uipanel(commons{:}, 'Title', 'Fourier mode', 'Tag', 'INFourParamPan', ...
    'Position', [paramPanPanX paramPanPanY paramPanPanW paramPanPanH], 'Visible', iff(strcmp(this.in.expMode, 'fourier'), 'on', 'off'));
this.GUI.handles.in.paramPans.trial = uipanel(commons{:}, 'Title', 'Trial mode', 'Tag', 'INTrialParamPan', ...
    'Position', [paramPanPanX paramPanPanY paramPanPanW paramPanPanH], 'Visible', iff(strcmp(this.in.expMode, 'trial'), 'on', 'off'));


end
