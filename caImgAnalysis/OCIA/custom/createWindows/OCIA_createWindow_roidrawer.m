function OCIA_createWindow_roidrawer(this, pad)
% OCIA_createWindow_roidrawer - [no description]
%
%       OCIA_createWindow_roidrawer(this, pad)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

BGWhite = {'Background', 'white'}; %#ok<*CCAT>
NormUnits = {'Units', 'normalized'};

%% - #OCIACreateWindow: ROIDrawer
%% -- #OCIACreateWindow: ROIDrawer: image axe
alignOffsetX = -0.013; alignOffsetY = 0.0025;
frameSetterH = 0.02;
imAxeY = pad + alignOffsetY + frameSetterH + pad; imAxeX = pad + alignOffsetX;
imAxeH = 1 - frameSetterH - 3 * pad; imAxeHPix = this.GUI.pos(4) * imAxeH;
imAxeW = min(imAxeHPix / this.GUI.pos(3), 0.65);
commons = {'Parent', this.GUI.handles.panels.ROIDrawerPanel, 'Color', 'white', NormUnits{:}};
this.GUI.handles.rd.axe = axes(commons{:}, 'Tag', 'RDAxe', 'Position', [imAxeX imAxeY imAxeW imAxeH]);
%% -- #OCIACreateWindow: ROIDrawer: image handle (imshow)
% the creation of the image is done later to avoid weird flickering effect due to imshow
this.GUI.handles.rd.img = [];

%% -- #OCIACreateWindow: ROIDrawer: frame browsing slider's label
commons = {'Parent', this.GUI.handles.panels.ROIDrawerPanel, NormUnits{:}};
frameLabelW = 0.055; frameLabelX = pad; frameLabelY = pad;
this.GUI.handles.rd.frameLabel = uicontrol(commons{:}, 'Style', 'text', 'String', 'Frame 000', ...
    'Tag', 'RDFrameLabel', BGWhite{:}, 'Position', [frameLabelX, frameLabelY, frameLabelW, frameSetterH], ...
     'FontSize', this.GUI.pos(4) / 100, 'HorizontalAlignment', 'left');

%% -- #OCIACreateWindow: ROIDrawer: frame browsing slider
alignOffsetX = 0.022;
frameSetterW = imAxeW - frameLabelW - 2 * pad - alignOffsetX;
frameSetterX = frameLabelX + frameLabelW + pad; RDFrameSetterY = pad;
this.GUI.handles.rd.frameSetter = uicontrol(commons{:}, 'Style', 'slider', 'Min', 0, 'Max', 1, 'Value', 0, ...
    'SliderStep', [0 1], 'Callback', @(h, e)RDChangeFrame(this, h, e), 'TooltipString', 'Change frame', 'Tag', ...
    'RDFrameSetter', 'Enable', 'off', 'Position', [frameSetterX, RDFrameSetterY, frameSetterW, frameSetterH]);

%% - #OCIACreateWindow: ROIDrawer: ROI tool radio buttons
commons = {'Parent', this.GUI.handles.panels.ROIDrawerPanel, 'Style', 'togglebutton', NormUnits{:}, ...
    'Callback', @(h, e)RDChangeDrawTool(this, h, e)};
drawTools = this.GUI.rd.drawTools; % get the draw tool's table
nDrawTools = size(drawTools, 1); % count the number of drawing tools
alignOffsetX = -0.012; alignOffsetY = 0.004;
toolW = 0.05; toolH = 0.05; toolBaseY = 1 - pad - toolH + alignOffsetY;
toolBaseX = imAxeX + imAxeW + alignOffsetX;
% loop through all tools
for iTool = fliplr(1 : nDrawTools);
    toolID = drawTools.id{iTool}; % get the tool's ID
    % get this tool's icon's path
    iconPath = regexprep(which('OCIA'), '@OCIA.OCIA\.m', sprintf('icons/menuIcons/%sDrawTool.png', toolID));
    cData = linScale(double(imread(iconPath))); % get the icon
    cData(cData == 0) = NaN; % make transparency
    % create the tool
    this.GUI.handles.rd.drawTool.(toolID) = uicontrol(commons{:}, 'CData', cData, ...
        'ToolTipString', drawTools.tooltip{iTool}, 'Tag', ['RDDrawTool' toolID], ...
        'Position', [toolBaseX + pad + (iTool - 1) * (toolW + pad), toolBaseY, toolW, toolH], 'Value', 0);
end;
% set the default selected tool
set(this.GUI.handles.rd.drawTool.(drawTools.id{1}), 'Value', 1);

%% - #OCIACreateWindow: ROIDrawer: move ROIs buttons
commons = {'Parent', this.GUI.handles.panels.ROIDrawerPanel, NormUnits{:}, 'Value', 0, 'Style', 'pushbutton'};
moveButs = { 'leftarrow', 'uparrow', 'downarrow', 'rightarrow' };
moveButsW = toolW * 0.5; moveButsH = toolH; moveButsX = toolBaseX + pad + nDrawTools * (toolW + pad) + 2 * pad; ...
moveButsY = toolBaseY;
for iBut = 1 : numel(moveButs);
    moveButDir = regexprep(moveButs{iBut}, 'arrow', '');
    iconPath = regexprep(which('OCIA'), '@OCIA.OCIA\.m', sprintf('icons/menuIcons/%s.png', moveButs{iBut}));
    cData = linScale(double(imread(iconPath))); % get the icon
    cData = imresize(cData, 1);
    cData(cData ~= 0) = 1;
    cData(cData == 0) = NaN; % make transparency
    cData(cData == 1) = 0;
    % create GUI element
    this.GUI.handles.rd.(['moveROIs_', moveButDir]) = uicontrol(commons{:}, 'String', '', 'CData', cData, ...
        'Tag', ['RDMoveROIs_', moveButDir], 'Position', [moveButsX, moveButsY, moveButsW, moveButsH], ...
        'TooltipString', sprintf('Move all ROIs %s', moveButDir), 'Callback', @(h, e)RDMoveROIs(this, moveButDir, this.rd.moveROIsStep));
    % adjust x position
    moveButsX = moveButsX + moveButsW + pad;
end;

%% - #OCIACreateWindow: ROIDrawer: rotate ROIs buttons
rotButs = { 'rotateleft', 'rotateright' };
for iBut = 1 : numel(rotButs);
    rotButsDir = regexprep(rotButs{iBut}, 'rotate', '');
    rotButDirFactor = iff(strcmp(rotButsDir, 'left'), 1, -1);
    iconPath = regexprep(which('OCIA'), '@OCIA.OCIA\.m', sprintf('icons/menuIcons/%s.png', rotButs{iBut}));
    cData = linScale(double(imread(iconPath))); % get the icon
    cData(cData == 0) = NaN; % make transparency
    cData = 1 - cData;
    % create GUI element
    this.GUI.handles.rd.(['rotateROIs_', rotButsDir]) = uicontrol(commons{:}, 'String', '', 'CData', cData, ...
        'Tag', ['RDRotateROIs_', rotButsDir], 'Position', [moveButsX, moveButsY, moveButsW, moveButsH], ...
        'TooltipString', sprintf('Rotate all ROIs %s', rotButsDir), ...
        'Callback', @(h, e)RDRotateROIs(this, rotButDirFactor * this.rd.moveROIsStep));
    % adjust x position
    moveButsX = moveButsX + moveButsW + pad;
end;

%% - #OCIACreateWindow: ROIDrawer: shrink/expand ROIs buttons
scaleButs = { 'exp_hori', 'shrink_hori', 'exp_vert', 'shrink_vert' };
for iBut = 1 : numel(scaleButs);
    scaleButParam = regexp(scaleButs{iBut}, '_', 'split');
    scaleDir = iff(strcmp(scaleButParam{1}, 'shrink'), -1, 1);
    scaleHori = iff(strcmp(scaleButParam{2}, 'hori'), 1, 0);
    scaleVert = iff(strcmp(scaleButParam{2}, 'vert'), 0, 1);
    iconPath = regexprep(which('OCIA'), '@OCIA.OCIA\.m', sprintf('icons/menuIcons/%s.png', scaleButs{iBut}));
    cData = linScale(double(imread(iconPath))); % get the icon
    cData(cData == 0) = NaN; % make transparency
    cData = 1 - cData;
    % create GUI element
    this.GUI.handles.rd.(['scaleROIs_', scaleButs{iBut}]) = uicontrol(commons{:}, 'String', '', 'CData', cData, ...
        'Tag', ['RDScaleROIs_', scaleButs{iBut}], 'Position', [moveButsX, moveButsY, moveButsW, moveButsH], ...
        'TooltipString', sprintf('%s all ROIs', iff(strcmp(scaleButs{iBut}(1), 's'), 'Shrink', 'Expand')), ...
        'Callback', @(h, e)RDScaleROIs(this, scaleDir * this.rd.scaleROIsStep * scaleHori, ...
        scaleDir * this.rd.scaleROIsStep * scaleVert));
    % adjust x position
    moveButsX = moveButsX + moveButsW + pad;
end;

%% - #OCIACreateWindow: ROIDrawer: saveROI
commons = {'Parent', this.GUI.handles.panels.ROIDrawerPanel, NormUnits{:}, 'Style', 'pushbutton'};
saveROIW = toolW; saveROIH = toolH; saveROIX = toolBaseX + pad; saveROIY = toolBaseY - pad - saveROIH;
saveIcon = load(fullfile(matlabroot(), '/toolbox/matlab/icons/savedoc.mat'));
this.GUI.handles.rd.saveROISet = uicontrol(commons{:}, 'CData', saveIcon.cdata, 'Tag', 'RDSaveROISet', ...
    'ToolTipString', 'Save ROISet', 'Position', [saveROIX, saveROIY, saveROIW, saveROIH], ...
    'Callback', @(h, e)RDSaveROIs(this, h, e));

%% - #OCIACreateWindow: ROIDrawer: loadROI
loadROIW = saveROIW; loadROIH = saveROIH; loadROIX = saveROIX + saveROIW + pad; loadROIY = saveROIY ;
loadIcon = load(fullfile(matlabroot(), '/toolbox/matlab/icons/opendoc.mat'));
this.GUI.handles.rd.loadROISet = uicontrol(commons{:}, 'CData', loadIcon.cdata, 'Tag', 'RDWLoadROISet',  ...
    'ToolTipString', 'Load ROISet', 'Position', [loadROIX, loadROIY, loadROIW, loadROIH], ...
    'Callback', @(h, e)RDLoadROIs(this, h, e));

%% - #OCIACreateWindow: ROIDrawer: clearROIs
iconPath = regexprep(which('OCIA'), '@OCIA.OCIA\.m', 'icons/menuIcons/clearROIs.png');
cData = linScale(double(imread(iconPath))); % get the icon
cData(cData == 0) = NaN; % make transparency
clearROIsW = saveROIW; clearROIsH = saveROIH; clearROIsX = loadROIX + loadROIW + pad; clearROIsY = saveROIY;
this.GUI.handles.rd.clearROIs = uicontrol(commons{:}, 'ToolTipString', 'Delete all ROIs (reset)', 'Tag', 'RDClearROIs', ...
    'CData', cData, 'Position', [clearROIsX, clearROIsY, clearROIsW, clearROIsH], 'Callback', @(h, e)RDClearROIs(this, h, e));

%% - #OCIACreateWindow: ROIDrawer: deleteROI
iconPath = regexprep(which('OCIA'), '@OCIA.OCIA\.m', 'icons/menuIcons/deleteROIs.png');
cData = linScale(double(imread(iconPath))); % get the icon
cData(cData == 0) = NaN; % make transparency
delROIW = saveROIW; delROIH = saveROIH; delROIX = clearROIsX + clearROIsW + pad; delROIY = saveROIY;
this.GUI.handles.rd.deleteROI = uicontrol(commons{:}, 'ToolTipString', 'Delete only selected ROI(s)', 'Tag', 'RDDeleteROI', ...
    'CData', cData, 'Position', [delROIX, delROIY, delROIW, delROIH], 'Callback', @(h, e)RDDeleteROI(this, h, e));

%% - #OCIACreateWindow: ROIDrawer: renameROI
iconPath = regexprep(which('OCIA'), '@OCIA.OCIA\.m', 'icons/menuIcons/renameROIs.png');
cData = linScale(double(imread(iconPath))); % get the icon
cData(cData == 0) = NaN; % make transparency
cData = 1 - cData;
renameROIW = saveROIW; renameROIH = saveROIH; renameROIX = delROIX + delROIW + pad; renameROIY = delROIY;
this.GUI.handles.rd.renameROI = uicontrol(commons{:}, 'ToolTipString', 'Rename selected ROI(s)', 'Tag', 'RDRenameROI', ...
    'CData', cData, 'Position', [renameROIX, renameROIY, renameROIW, renameROIH], 'Callback', @(h, e)RDRenameROI(this, h, e));

%% - #OCIACreateWindow: ROIDrawer: Rename ROI edit field
commons = {'Parent', this.GUI.handles.panels.ROIDrawerPanel, BGWhite{:}, NormUnits{:}};
ROINameX = renameROIX + renameROIW + pad; ROINameY = renameROIY; ROINameW = renameROIW; ROINameH = saveROIH; 
this.GUI.handles.rd.ROIName = uicontrol(commons{:}, 'String', '', 'Tag', 'RDROIName', 'Style', 'edit', ...
    'Position', [ROINameX, ROINameY, ROINameW, ROINameH], 'TooltipString', 'Enter here the new name for the renaming.', ...
    'Callback', @(h, e)RDRenameROI(this, h, e));

%% - #OCIACreateWindow: ROIDrawer: save options label
commons = { 'Parent', this.GUI.handles.panels.ROIDrawerPanel, NormUnits{:}, BGWhite{:} };
saveOptsW = ((1 - toolBaseX - pad) - 5 * pad) / 4; saveOptsH = saveROIH * 0.6;
saveOptsX = saveROIX; saveOptsY = saveROIY - saveOptsH - pad;
this.GUI.handles.rd.saveOptsLab = uicontrol(commons{:}, 'Style', 'text', 'String', 'Save/load options:', ...
    'Tag', 'RDSaveOpts', 'Position', [saveOptsX, saveOptsY - saveOptsH * 0.25, saveOptsW, saveOptsH], ...
    'ToolTipString', 'Specifiy which elements to save for this ROISet with the checkboxes on the right.');

%% - #OCIACreateWindow: ROIDrawer: save options
commons = { 'Parent', this.GUI.handles.panels.ROIDrawerPanel, NormUnits{:}, BGWhite{:}, 'Style', 'checkbox', 'Value', 1 };
saveOptsROIsX = saveOptsX + saveOptsW + pad; saveOptsRunsValX = saveOptsROIsX + saveOptsW + pad;
saveOptsRefImX = saveOptsRunsValX + saveOptsW + pad;
this.GUI.handles.rd.saveOpts.ROIs = uicontrol(commons{:}, 'String', 'ROIs', 'Tag', 'RDSaveOptsROIs', ...
    'Position', [saveOptsROIsX, saveOptsY, saveOptsW, saveOptsH], 'ToolTipString', 'ROIs (names and position)');
this.GUI.handles.rd.saveOpts.runsVal = uicontrol(commons{:}, 'String', 'Runs validity', 'Tag', 'RDSaveOptsRunsVal', ...
    'Position', [saveOptsRunsValX, saveOptsY, saveOptsW, saveOptsH], 'ToolTipString', 'Runs (which runs are associated with this ROISet)');
this.GUI.handles.rd.saveOpts.refIm = uicontrol(commons{:}, 'String', 'Reference image', 'Tag', 'RDSaveOptsRefIm', ...
    'Position', [saveOptsRefImX, saveOptsY, saveOptsW, saveOptsH], 'ToolTipString', 'Reference image (used also for the motion correction)');

%% - #OCIACreateWindow: ROIDrawer: renumbering on delete checkbox
commons = [commons { 'Style', 'checkbox', 'Value', 0}];
renumW = ((1 - toolBaseX - pad) - 5 * pad) / 4; renumH = saveROIH * 0.6;
renumX = saveROIX; renumY = saveOptsY - renumH - pad;
this.GUI.handles.rd.renum = uicontrol(commons{:}, 'String', 'Renum. on delete', 'Tag', 'RDRenumDel', ...
    'Position', [renumX, renumY, renumW, renumH], 'ToolTipString', ...
    'When an ROI is deleted, renumber the other ROIs according to their order in the list.');

%% - #OCIACreateWindow: ROIDrawer: load type
loadTypeW = renumW; loadTypeH = renumH;
loadTypeX = renumX + renumW + pad; loadTypeY = renumY;
this.GUI.handles.rd.useAllFrames = uicontrol(commons{:}, 'String', 'Use all frames', 'Tag', 'RDUseAllFrames', ...
    'ToolTipString', 'Load all the frames for this run (instead of only the "preview" frames).', ...
    'Position', [loadTypeX, loadTypeY, loadTypeW, loadTypeH], ...
    'Callback', @(h, e)RDChangeRow(this, this.GUI.handles.rd.tableList));

%% - #OCIACreateWindow: ROIDrawer: auto-imadj
autoImAdjW = renumW; autoImAdjH = renumH;
autoImAdjX = loadTypeX + loadTypeW + pad; autoImAdjY = renumY;
this.GUI.handles.rd.autoImAdj = uicontrol(commons{:}, 'String', 'Image adjust auto', 'Tag', 'RDImAdjAuto', ...
    'ToolTipString', 'Use the automatic values for the image intensity adjustment.', ...
    'Position', [autoImAdjX, autoImAdjY, autoImAdjW, autoImAdjH]);

%% - #OCIACreateWindow: ROIDrawer: show/hide ROIs
showHideROIsW = renumW; showHideROIsH = renumH;
showHideROIsX = renumX; showHideROIsY = renumY - showHideROIsH - pad;
this.GUI.handles.rd.showHideROIs = uicontrol(commons{:}, 'String', 'Show ROIs', 'Tag', 'RDShowHideROIs', ...
    'ToolTipString', 'Show/hide the ROI outlines on the image.', ...
    'Position', [showHideROIsX, showHideROIsY, showHideROIsW, showHideROIsH], 'Value', 1, ...
    'Callback', @(h, e)RDShowHideROIs(this, h, e));

%% - #OCIACreateWindow: ROIDrawer: show/hide ROIs labels
showHideROIsLabW = renumW; showHideROIsLabH = renumH;
showHideROIsLabX = showHideROIsX + showHideROIsW + pad; showHideROIsLabY = showHideROIsY;
this.GUI.handles.rd.showHideROIsLab = uicontrol(commons{:}, 'String', 'Show ROI IDs', 'Tag', 'RDShowHideROIIDs', ...
    'ToolTipString', 'Show/hide the ROI IDs (names) on the image.', ...
    'Position', [showHideROIsLabX, showHideROIsLabY, showHideROIsLabW, showHideROIsLabH], 'Value', 1, ...
    'Callback', @(h, e)RDShowHideROIs(this, h, e));

%% - #OCIACreateWindow: ROIDrawer: show average
showAvgW = renumW; showAvgH = renumH;
showAvgX = showHideROIsLabX + showHideROIsLabW + pad; showAvgY = showHideROIsY;
this.GUI.handles.rd.showAvg = uicontrol(commons{:}, 'String', 'Avg. <-> frames', 'Tag', 'RDShowAvg', ...
    'ToolTipString', 'Switch between the average mode or the frame browsing mode.', ...
    'Value', 1, 'Position', [showAvgX, showAvgY, showAvgW, showAvgH], ...
    'Callback', @(h, e)RDChangeRow(this, this.GUI.handles.rd.tableList));

%% - #OCIACreateWindow: ROIDrawer: filter frames
filtFramesW = renumW; filtFramesH = renumH;
filtFramesX = showAvgX + showAvgW + pad; filtFramesY = showHideROIsY;
this.GUI.handles.rd.filtFrames = uicontrol(commons{:}, 'String', 'Filter frames', 'Tag', 'RDFiltFrames', ...
    'ToolTipString', 'Filter the frames for the display (only in frame browsing mode).', ...
    'Position', [filtFramesX, filtFramesY, filtFramesW, filtFramesH], ...
    'Callback', @(h, e)RDChangeRow(this, this.GUI.handles.rd.tableList));

%% - #OCIACreateWindow: ROIDrawer: Zoom tool
commons = {'Parent', this.GUI.handles.panels.ROIDrawerPanel, NormUnits{:}, 'Value', 0, 'Style', 'togglebutton'};
zToolW = toolW; zToolH = toolH; zToolX = saveROIX; zToolY = showHideROIsY - zToolH - pad;
zToolIcon = load(fullfile(matlabroot(), '/toolbox/matlab/icons/zoom.mat'));
this.GUI.handles.rd.zTool = uicontrol(commons{:}, 'CData', zToolIcon.zoomCData, ...
    'TooltipString', 'Activate zoom', 'Tag', 'RDZTool', 'Position', [zToolX, zToolY, zToolW, zToolH], ...
    'Callback', @(h, e)RDActivateZoom(this, h, e));

%% - #OCIACreateWindow: ROIDrawer: Pan tool
pToolW = toolW; pToolH = toolH; pToolX = zToolX + zToolW + pad; pToolY = zToolY;
pToolIcon = load(fullfile(matlabroot(), '/toolbox/matlab/icons/pan.mat'));
this.GUI.handles.rd.pTool = uicontrol(commons{:}, 'CData', pToolIcon.cdata, 'TooltipString', 'Activate pan', ...
    'Tag', 'RDPTool', 'Position', [pToolX, pToolY, pToolW, pToolH], ...
    'Callback', @(h, e)RDActivatePan(this, h, e));

%% - #OCIACreateWindow: ROIDrawer: ROI select button
commons = {'Parent', this.GUI.handles.panels.ROIDrawerPanel, NormUnits{:}, 'Style', 'pushbutton'};
selROIW = (saveROIW * 2 - 1.5 * pad) * 2 / 3; selROIH = saveROIH; selROIX = pToolX + pToolW + pad; selROIY = zToolY;
this.GUI.handles.rd.selROI = uicontrol(commons{:}, 'String', 'Select ROIs', 'Tag', 'RDSelROI', ...
    'Position', [selROIX, selROIY, selROIW, selROIH], 'Callback', @(h, e)RDSelROI(this, h, e), ...
    'ToolTipString', 'Click this to select the ROIs specified by the "formula" on the right of this button');

%% - #OCIACreateWindow: ROIDrawer: ROI select edit field
selROISettW = selROIW; selROISettH = saveROIH;
selROISettX = selROIX + selROIW + pad; selROISettY = zToolY;
this.GUI.handles.rd.selROISetter = uicontrol(commons{:}, 'String', '', 'Tag', 'RDSelROISett', 'Style', 'edit', ...
    'Position', [selROISettX, selROISettY, selROISettW, selROISettH], BGWhite{:}, ...
    'TooltipString', '"Formula" to evaluate for ROI selection: 3:5 or 1-10 or 1,2,7 or 1-10,3-5 or etc.', ...
    'Callback', @(h, e)RDSelROI(this, h, e));

%% - #OCIACreateWindow: ROIDrawer: ROI select edit field clear
alignOffset = 1.1;
selROISettClearW = selROISettW * 0.18; selROISettClearWPix = this.GUI.pos(3) * selROISettClearW;
selROISettClearH = selROISettClearWPix / this.GUI.pos(4);
selROISettClearX = selROISettX + selROISettW - selROISettClearW * alignOffset;
selROISettClearY = selROISettY + selROISettH - selROISettClearH * alignOffset;
this.GUI.handles.rd.selROISetterClear = uicontrol(commons{:}, 'Tag', 'RDSelROISettClear', 'String', 'X', ...
    'Position', [selROISettClearX, selROISettClearY, selROISettClearW, selROISettClearH], ...
    'Foreground', 'red', 'TooltipString', 'Clear ROI selection', 'FontSize', this.GUI.pos(4) / 110, ...
    'Callback', @(h, e)RDSelROI(this, h, e));

%% - #OCIACreateWindow: ROIDrawer: frame avereage select field label
commons = {'Parent', this.GUI.handles.panels.ROIDrawerPanel, BGWhite{:}, NormUnits{:}, 'Style', 'text'};
frameRangeLabW = selROIW * 5 / 4; frameRangeLabH = saveROIH;
frameRangeLabX = selROISettX + selROISettW + pad; frameRangeLabY = zToolY - 0.25 * saveROIH;
this.GUI.handles.rd.selFrameRangeLab = uicontrol(commons{:}, 'String', 'Avg. frame range: ', ...
    'Tag', 'RDSelFrameRangeLab', 'Position', [frameRangeLabX, frameRangeLabY, frameRangeLabW, frameRangeLabH], ...
    'TooltipString', 'Frame range on which the average image should be computed.');

%% - #OCIACreateWindow: ROIDrawer: frame average select field
selFrameRangeX = frameRangeLabX + frameRangeLabW + pad; selFrameRangeY = zToolY;
selFrameRangeW = 1 - selFrameRangeX - pad; selFrameRangeH = saveROIH;
this.GUI.handles.rd.selFrameRange = uicontrol(commons{:}, 'String', '', 'Tag', 'RDSelFrameRange', 'Style', 'edit', ...
    'Position', [selFrameRangeX, selFrameRangeY, selFrameRangeW, selFrameRangeH], BGWhite{:}, ...
    'TooltipString', 'Frame range on which the average image should be computed: 1-10 or 1-90,100-200 or etc.', ...
    'Callback', @(h, e)RDChangeRow(this, h));

%% - #OCIACreateWindow: ROIDrawer: apply mask
commons = {'Parent', this.GUI.handles.panels.ROIDrawerPanel, NormUnits{:}, 'Value', 0, 'Style', 'togglebutton', ...
    'Callback', @(h, e)RDUpdateImage(this, h, e)};
maskW = saveROIW * 2 + pad; maskH = saveROIH; maskX = saveROIX; maskY = zToolY - maskH - pad;
this.GUI.handles.rd.mask = uicontrol(commons{:}, 'String', 'Apply mask', 'Tag', 'RDMask', ...
    'Position', [maskX, maskY, maskW, maskH], 'TooltipString', 'Applies a black mask to see ROIs');

%% - #OCIACreateWindow: ROIDrawer: image adjust
imAdjW = maskW; imAdjH = saveROIH; imAdjX = saveROIX; imAdjY = maskY - imAdjH - pad;
this.GUI.handles.rd.imAdj = uicontrol(commons{:}, 'String', 'Adjust image', 'Tag', 'RDImAdj', ...
    'Position', [imAdjX, imAdjY, imAdjW, imAdjH], 'TooltipString', 'Adjusts the image''s intensity');

%% - #OCIACreateWindow: ROIDrawer: pseudo-flat field
pseudFFW = maskW; pseudFFH = saveROIH; pseudFFX = saveROIX; pseudFFY = imAdjY - pseudFFH - pad;
this.GUI.handles.rd.pseudFF = uicontrol(commons{:}, 'String', 'Pseudo flat-field', 'Tag', 'RDPseudFF', ...
    'Position', [pseudFFX, pseudFFY, pseudFFW, pseudFFH], 'TooltipString', 'Apply a pseudo flat-field correction');

%% - #OCIACreateWindow: ROIDrawer: align
alignW = maskW * 0.7; alignH = saveROIH; alignX = pseudFFX + pseudFFW + 2 * pad; alignY = pseudFFY;
this.GUI.handles.rd.align = uicontrol(commons{:}, 'Style', 'pushbutton', 'String', 'Align frames', 'Tag', 'RDAlign', ...
    'Position', [alignX, alignY, alignW, alignH], 'TooltipString', 'Align frames.', ...
    'Callback', @(h, e)RDAlign(this, h, e));

%% - #OCIACreateWindow: ROIDrawer: color channels
colChansW = maskW * 0.6; colChansH = saveROIH; colChansX = alignX + alignW + pad; colChansY = pseudFFY;
this.GUI.handles.rd.colorChannels = uicontrol(commons{:}, 'String', {'R', 'G', 'B'}, 'Tag', 'RDColChans', ...
    'Position', [colChansX, colChansY, colChansW, colChansH], 'TooltipString', 'Color channels', BGWhite{:}, ...
    'Style', 'listbox', 'Value', [1 2 3], 'FontSize', this.GUI.pos(4) / 45, 'Min', 0, 'Max', 2, ...
    'Callback', @(h, e)RDUpdateImage(this, h, e));

%% - #OCIACreateWindow: ROIDrawer: dimension reduction
dimReducW = maskW * 0.8; dimReducH = saveROIH; dimReducX = colChansX + colChansW + pad; dimReducY = pseudFFY;
this.GUI.handles.rd.dimReducFcn = uicontrol(commons{:}, 'String', { 'mean', 'std', 'median', 'max', 'min' }, ...
    'Tag', 'RDDimReduc', 'Position', [dimReducX, dimReducY, dimReducW, dimReducH], 'FontSize', this.GUI.pos(4) / 45, ...
    'TooltipString', 'Frames "reduction" method (average frames or calculate STD/median/etc.', BGWhite{:}, ...
    'Style', 'popupmenu', 'Value', 1, 'Callback', @(h, e)RDChangeRow(this, h, e));

%% - #OCIACreateWindow: ROIDrawer: compare ROI sets
commons = {'Parent', this.GUI.handles.panels.ROIDrawerPanel, NormUnits{:}, 'Value', 0, 'Style', 'togglebutton', ...
    'Callback', @(h, e)RDUpdateImage(this, h, e)};
refROISetW = maskW; refROISetH = saveROIH; refROISetX = saveROIX; refROISetY = pseudFFY - refROISetH - pad;
this.GUI.handles.rd.refROISet = uicontrol(commons{:}, 'String', 'Compare ROI sets', 'Tag', 'RDRefROISet', ...
    'Position', [refROISetX, refROISetY, refROISetW, refROISetH], 'TooltipString', 'Compare ROI sets');

%% - #OCIACreateWindow: ROIDrawer: mask opacity
commons = {'Parent', this.GUI.handles.panels.ROIDrawerPanel, NormUnits{:}, 'Style', 'slider', 'Max', 1, 'Min', 0, ...
    'Callback', @(h, e)RDUpdateImage(this, h, e)};
maskSettX = maskX + maskW + pad; maskSettY = maskY;
maskSettW = 1 - maskSettX - pad; maskSettH = maskH;
this.GUI.handles.rd.maskSetter = uicontrol(commons{:}, 'Value', 0.15, 'TooltipString', 'Mask opacity', 'Max', 0.8, ...
    'Tag', 'RDMaskSett', 'Position', [maskSettX, maskSettY, maskSettW, maskSettH]);

%% - #OCIACreateWindow: ROIDrawer: image adjust min and max value
imAdjSettW = (maskSettW - pad) / 2; imAdjSettH = imAdjH; imAdjSettY = imAdjY;
imAdjMinSettX = maskX + maskW + pad; imAdjMaxSettX = imAdjMinSettX + imAdjSettW + pad;
this.GUI.handles.rd.imAdjMinSetter = uicontrol(commons{:}, 'TooltipString', 'Minimum intensity', 'Max', 0.5, ...
    'Tag', 'RDImAdjMinSett', 'Position', [imAdjMinSettX, imAdjSettY, imAdjSettW, imAdjSettH], 'Value', 0.15);
this.GUI.handles.rd.imAdjMaxSetter = uicontrol(commons{:}, 'TooltipString', 'Maximum intensity', 'Min', 0.5, ...
    'Tag', 'RDImAdjMaxSett', 'Position', [imAdjMaxSettX, imAdjSettY, imAdjSettW, imAdjSettH], 'Value', 0.65);

%% - #OCIACreateWindow: ROIDrawer: compare ROI sets
refROISetSettAX = refROISetX + refROISetW + pad; 
refROISetSettW = (maskSettW - pad) / 2; refROISetSettH = refROISetH; refROISetSettY = refROISetY;
refROISetSettBX = refROISetSettAX + refROISetSettW + pad;
commons = {'Parent', this.GUI.handles.panels.ROIDrawerPanel, NormUnits{:}, BGWhite{:}, 'Style', 'listbox', ...
    'Value', 1, 'String', {'1', '2'}, 'FontSize', this.GUI.pos(4) / 65, 'Callback', @(h, e)RDUpdateImage(this, h, e)};
this.GUI.handles.rd.refROISetASetter = uicontrol(commons{:}, 'Tag', 'RDRefROISetASett', ...
    'TooltipString', 'Reference', 'Position', [refROISetSettAX, refROISetSettY, refROISetSettW, refROISetSettH]);
this.GUI.handles.rd.refROISetBSetter = uicontrol(commons{:}, 'Min', 0, 'Max', 2, 'Tag', 'RDRefROISetBSett', ...
    'TooltipString', 'Targets', 'Position', [refROISetSettBX, refROISetSettY, refROISetSettW, refROISetSettH]);

%% - #OCIACreateWindow: ROIDrawer: list labels
remainingWidth = 1 - toolBaseX - 2 * pad;
tableListW = remainingWidth * 0.85;
ROIsListW = remainingWidth * 0.15;
listLabelH = 0.02; listLabelY = refROISetY - listLabelH - pad;
listY = pad; listH = listLabelY - 2 * pad;
tableX = saveROIX; ROIsX = tableX + tableListW + pad;
commons = {'Parent', this.GUI.handles.panels.ROIDrawerPanel, NormUnits{:}, BGWhite{:}, 'Style', 'text', ...
    'FontSize', this.GUI.pos(4) / 80, 'HorizontalAlignment', 'center'};
this.GUI.handles.rd.tableListLabel = uicontrol(commons{:}, 'Tag', 'RDSRowsLabel', 'String', 'Row display ', ...
    'Position', [tableX, listLabelY, tableListW, listLabelH], 'ToolTipString', 'Select which row to display');
this.GUI.handles.rd.selROIsListLabel = uicontrol(commons{:}, 'Tag', 'RDSelROIsListLabel', ...
    'ToolTipString', 'Select one ore more ROIs', ...
    'String', 'ROIs  ', 'Position', [ROIsX, listLabelY, ROIsListW, listLabelH]);

%% - #OCIACreateWindow: ROIDrawer: Row list display, row list selection and ROI list selection
commons = {'Parent', this.GUI.handles.panels.ROIDrawerPanel, NormUnits{:}, BGWhite{:}, 'String', {}, ...
    'Style', 'list', 'Max', 2, 'Min', 0};
this.GUI.handles.rd.tableList = uicontrol(commons{:}, 'Position', [tableX, listY, tableListW, listH], ...
    'Tag', 'RDSRows', 'Callback', @(h, e)RDChangeRow(this, h, e), 'TooltipString', 'Selection for rows to display');
this.GUI.handles.rd.selROIsList = uicontrol(commons{:}, 'Position', [ROIsX, listY, ROIsListW, listH], ...
    'Tag', 'RDSelROIsList', 'Callback', @(h, e)RDSelROI(this, h, e), 'TooltipString', 'ROI selection');

end
