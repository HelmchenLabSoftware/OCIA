function OCIA_createWindow_jointtracker(this, pad)
% OCIA_createWindow_jointtracker - [no description]
%
%       OCIA_createWindow_jointtracker(this, pad)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

BGWhite = {'Background', 'white'}; %#ok<*CCAT>
NormUnits = {'Units', 'normalized'};

%% - #OCIACreateWindow: JointTracker
%% -- #OCIACreateWindow: JointTracker: image axe
alignOffsetX = 0; alignOffsetY = 0.0025;
JTFrameSetterH = 0.03;
JTImAxeY = pad + alignOffsetY + JTFrameSetterH + pad; JTImAxeX = pad + alignOffsetX;
JTImAxeH = 1 - JTFrameSetterH - 2 * pad; JTImAxeHPix = this.GUI.pos(4) * JTImAxeH;
JTImAxeW = (JTImAxeHPix / this.GUI.pos(3));
commons = {'Parent', this.GUI.handles.panels.JointTrackerPanel, 'Color', 'black', NormUnits{:}};
this.GUI.handles.jt.axe = axes(commons{:}, 'Tag', 'JTAxe', 'Position', [JTImAxeX JTImAxeY JTImAxeW JTImAxeH]);
%% -- #OCIACreateWindow: JointTracker: image handle (imshow)
% the creation of the image is done later to avoid weird flickering effect due to imshow
this.GUI.handles.jt.img = [];

%% -- #OCIACreateWindow: JointTracker: frame browsing slider's label
alignOffsetY = 0.005;
commons = {'Parent', this.GUI.handles.panels.JointTrackerPanel, NormUnits{:}};
JTFrameLabelW = 0.055; JTFrameLabelX = pad; JTFrameLabelY = pad - alignOffsetY;
this.GUI.handles.jt.frameLabel = uicontrol(commons{:}, 'Style', 'text', 'String', 'Frame 000', ...
    'Tag', 'JTFrameLabel', BGWhite{:}, 'Position', [JTFrameLabelX, JTFrameLabelY, JTFrameLabelW, JTFrameSetterH], ...
     'FontSize', this.GUI.pos(4) / 100, 'HorizontalAlignment', 'left');

%% -- #OCIACreateWindow: JointTracker: frame browsing slider
alignOffsetX = -0.009;
JTFrameSetterW = JTImAxeW - JTFrameLabelW - 2 * pad - alignOffsetX;
JTFrameSetterX = JTFrameLabelX + JTFrameLabelW + pad; JTFrameSetterY = pad;
this.GUI.handles.jt.frameSetter = uicontrol(commons{:}, 'Style', 'slider', 'Min', 0, 'Max', 1, 'Value', 0, ...
    'SliderStep', [0 1], 'TooltipString', 'Change frame', 'Tag', ...
    'JTFrameSetter', 'Enable', 'off', 'Position', [JTFrameSetterX, JTFrameSetterY, JTFrameSetterW, JTFrameSetterH]);
set(this.GUI.handles.jt.frameSetter, 'KeyPressFcn', @(h, e) keyPressed(this, h, e));

%% - #OCIACreateWindow: JointTracker: load
commons = {'Parent', this.GUI.handles.panels.JointTrackerPanel, NormUnits{:}, 'Style', 'pushbutton'};
alignOffsetX = 0.005; alignOffsetY = -0.005;
loadX = JTImAxeX + JTImAxeW + pad + alignOffsetX; loadW = (1 - loadX - 5 * pad) / 4;
loadH = 0.05; loadY = 1 - pad - loadH + alignOffsetY;
this.GUI.handles.jt.load = uicontrol(commons{:}, 'String', 'Load joints', 'Tag', 'JTLoad', ...
    'Position', [loadX, loadY, loadW, loadH], 'Callback', @(h, e)JTLoadJoints(this, h, e), ...
    'ToolTipString', 'Load the joint coordinates.');
%% - #OCIACreateWindow: JointTracker: save
saveX = loadX + loadW + pad; saveW = loadW; saveH = loadH; saveY = loadY;
this.GUI.handles.jt.save = uicontrol(commons{:}, 'String', 'Save joints', 'Tag', 'JTSave', ...
    'Position', [saveX, saveY, saveW, saveH], 'Callback', @(h, e)JTSaveJoints(this, h, e), ...
    'ToolTipString', 'Save the joint coordinates.');
%% - #OCIACreateWindow: JointTracker: clear
clearX = saveX + saveW + pad; clearW = loadW; clearH = loadH; clearY = loadY;
this.GUI.handles.jt.clear = uicontrol(commons{:}, 'String', 'Clear joints', 'Tag', 'JTClear', ...
    'Position', [clearX, clearY, clearW, clearH], 'Callback', @(h, e)JTClearJoints(this, 'current', [], h, e), ...
    'ToolTipString', 'Clear the joint coordinates for this frame.');
%% - #OCIACreateWindow: JointTracker: reset
resetX = clearX + saveW + pad; resetW = loadW; resetH = loadH; resetY = loadY;
this.GUI.handles.jt.reset = uicontrol(commons{:}, 'String', 'Reset joints', 'Tag', 'JTReset', ...
    'Position', [resetX, resetY, resetW, resetH], 'Callback', @(h, e)JTResetJoints(this, h, e), ...
    'ToolTipString', 'Clear the joint coordinates for all frames.');

%% - #OCIACreateWindow: JointTracker: process
processX = loadX; processW = loadW; processH = loadH; processY = loadY - pad - processH;
this.GUI.handles.jt.process = uicontrol(commons{:}, 'String', 'Process joints', 'Tag', 'JTProcess', ...
    'Position', [processX, processY, processW, processH], 'Callback', @(h, e)JTProcess(this, 'single', h, e), ...
    'ToolTipString', 'Automatically process this frame to find the joint coordinates.');
%% - #OCIACreateWindow: JointTracker: process all
procAllX = processX + loadW + pad; procAllW = loadW; procAllH = loadH; procAllY = processY;
this.GUI.handles.jt.processAll = uicontrol(commons{:}, 'String', 'Process all joints', 'Tag', 'JTProcessAll', ...
    'Position', [procAllX, procAllY, procAllW, procAllH], 'Callback', @(h, e)JTProcess(this, 'all', h, e), ...
    'ToolTipString', 'Automatically process the whole movie to find the joint coordinates.');
%% - #OCIACreateWindow: JointTracker: process virtuals
procVirtX = procAllX + procAllW + pad; procVirtW = loadW; procVirtH = loadH; procVirtY = processY;
this.GUI.handles.jt.processVirt = uicontrol(commons{:}, 'String', 'Process virtuals', 'Tag', 'JTProcessVirtual', ...
    'Position', [procVirtX, procVirtY, procVirtW, procVirtH], 'Callback', @(h, e)JTProcessVirtualJoints(this, h, e), ...
    'ToolTipString', 'Process (or re-process) the virtual joints.');
%% - #OCIACreateWindow: JointTracker: process virtuals
preProcFrameX = procVirtX + procVirtW + pad; preProcFrameW = loadW; preProcFrameH = loadH; preProcFrameY = processY;
this.GUI.handles.jt.preProcFrames = uicontrol(commons{:}, 'String', 'Pre-proc. frames', 'Tag', 'JTPreProcFrames', ...
    'Position', [preProcFrameX, preProcFrameY, preProcFrameW, preProcFrameH], 'Callback', @(h, e)JTPreProcessFrames(this, h, e), ...
    'ToolTipString', 'Pre-process the frames');

%% -- #OCIACreateWindow: DataWatcher: view opt check boxes settings
viewOpts = this.GUI.jt.viewOpts; nOpts = size(viewOpts, 1);
% define the max number of rows and the number of items to place
nMaxRows = 2;
% calculate the number of acutal columns and rows
nCols = ceil(nOpts / nMaxRows); nRows = min(nMaxRows, nOpts);
%% #OCIACreateWindow: DataWatcher: watch type check boxes group
commons = {'Parent', this.GUI.handles.panels.JointTrackerPanel, BGWhite{:}, NormUnits{:}};
viewOptsGroupX = loadX; viewOptsGroupW = 1 - viewOptsGroupX - 2 * pad; viewOptsGroupH = (loadH * 0.5) * (nMaxRows + 1);
viewOptsGroupY = processY - pad - viewOptsGroupH + alignOffsetY;
this.GUI.handles.jt.viewOptsGroup = uibuttongroup(commons{:}, 'Title', 'View options', ...
    'Tag', 'DWWatchTypeGroup', 'Position', [viewOptsGroupX, viewOptsGroupY, viewOptsGroupW, viewOptsGroupH]);
%% #OCIACreateWindow: DataWatcher: view opt check boxes
commons = {'Parent', this.GUI.handles.jt.viewOptsGroup, 'Style', 'checkbox', BGWhite{:}, NormUnits{:}, 'Value', 1, ...
    'Callback', @(h, e)JTUpdateGUI(this, h, e)};
inPad = 0.01; % inner padding for the radio group
elemW = (1 - (nCols + 1) * inPad) / nCols; % width depends on the number of columns
elemH = (1 - (nRows + 1) * inPad) / nRows; % height depends on the number of rows
iRow = 1; iCol = 1; % init the row and column indexes
% go through all elements, create them and place them
for iOpt = 1 : nOpts;
    % calculate indexes and positions
    if iCol > nCols; iCol = 1; iRow = iRow + 1; end;
    elemPosX = (iCol - 1) * (inPad + elemW) + inPad; % calculate X position
    elemPosY = 1 - iRow * (elemH + inPad) + inPad; % calculate Y position    
    % create the label for the checkbox
    viewOptID = viewOpts{iOpt, 1};
    viewOptLabel = viewOpts{iOpt, 2};
    viewOptToolTip = viewOpts{iOpt, 3};
    % create the GUI element
    this.GUI.handles.jt.viewOpts.(viewOptID) = uicontrol(commons{:}, 'String', viewOptLabel, ...
        'Tag', sprintf('JTViewOpt_%s', viewOptID), 'Position', [elemPosX, elemPosY, elemW, elemH], ...
        'ToolTipString', viewOptToolTip);
    iCol = iCol + 1;
end;

%% - #OCIACreateWindow: JointTracker: Auto-track toggle button
commons = {'Parent', this.GUI.handles.panels.JointTrackerPanel, NormUnits{:}, 'Value', 0, 'Style', 'togglebutton'};
autoTrackW = loadW; autoTrackH = loadH; autoTrackX = loadX; autoTrackY = viewOptsGroupY - autoTrackH - pad;
this.GUI.handles.jt.autoTrack = uicontrol(commons{:}, 'String', 'Auto-track', 'TooltipString', ...
    'Automatically tracks joints upon changing frame', 'Tag', 'JTAutoProc', ...
    'Position', [autoTrackX, autoTrackY, autoTrackW, autoTrackH], ...
    'Callback', @(h, e)JTProcess(this, 'autoTrackChanged', h, e));
%% - #OCIACreateWindow: JointTracker: Manual-track toggle button
commons = {'Parent', this.GUI.handles.panels.JointTrackerPanel, NormUnits{:}, 'Value', 0, 'Style', 'togglebutton'};
manuTrackW = loadW; manuTrackH = loadH; manuTrackX = autoTrackX + autoTrackW + pad; manuTrackY = autoTrackY;
this.GUI.handles.jt.manuTrack = uicontrol(commons{:}, 'String', 'Manual track', 'TooltipString', ...
    'Manually track joints upon changing frame', 'Tag', 'JTAutoProc', ...
    'Position', [manuTrackX, manuTrackY, manuTrackW, manuTrackH], ...
    'Callback', @(h, e)JTManualTrackStart(this, 'manuTrackChanged', h, e));
%% - #OCIACreateWindow: JointTracker: Zoom tool
zToolW = loadW; zToolH = loadH; zToolX = manuTrackX + manuTrackW + pad; zToolY = manuTrackY;
this.GUI.handles.jt.zTool = uicontrol(commons{:}, 'String', 'Zoom', 'TooltipString', 'Activate zoom', ...
    'Tag', 'JTZTool', 'Position', [zToolX, zToolY, zToolW, zToolH], ...
    'Callback', @(h, e)JTActivateZoom(this, h, e));
%% - #OCIACreateWindow: JointTracker: Pan tool
pToolW = loadW; pToolH = loadH; pToolX = zToolX + zToolW + pad; pToolY = manuTrackY;
this.GUI.handles.jt.pTool = uicontrol(commons{:}, 'String', 'Pan', 'TooltipString', 'Activate pan', ...
    'Tag', 'JTPTool', 'Position', [pToolX, pToolY, pToolW, pToolH], ...
    'Callback', @(h, e)JTActivatePan(this, h, e));

%% - #OCIACreateWindow: JointTracker: define ROI button
commons = {'Parent', this.GUI.handles.panels.JointTrackerPanel, NormUnits{:}, 'Value', 0, 'Style', 'pushbutton'};
defineROIW = loadW; defineROIH = loadH; defineROIX = loadX; defineROIY = manuTrackY - defineROIH - pad;
this.GUI.handles.jt.defineROI = uicontrol(commons{:}, 'String', 'Define ROI', 'TooltipString', ...
    'Define a Region Of Interest for the selected joint', 'Tag', 'JTDefineROI', 'Callback', @(h, e)JTDefineROI(this, h, e), ...
    'Position', [defineROIX, defineROIY, defineROIW, defineROIH]);
%% - #OCIACreateWindow: JointTracker: crop button
cropW = loadW; cropH = loadH; cropX = defineROIX + defineROIW + pad; cropY = defineROIY;
this.GUI.handles.jt.crop = uicontrol(commons{:}, 'String', 'Crop movie', 'TooltipString', ...
    'Define a Region Of Interest for cropping the movie', 'Tag', 'JTCrop', 'Callback', @(h, e)JTCrop(this, h, e), ...
    'Position', [cropX, cropY, cropW, cropH]);
%% - #OCIACreateWindow: JointTracker: show informations button
showInfoW = loadW; showInfoH = loadH; showInfoX = cropX + cropW + pad; showInfoY = defineROIY;
this.GUI.handles.jt.showInfo = uicontrol(commons{:}, 'String', 'Show info.', 'TooltipString', ...
    'Show some informations about the joints', 'Tag', 'JTShowInfo', 'Callback', @(h, e)JTShowInfo(this, h, e), ...
    'Position', [showInfoX, showInfoY, showInfoW, showInfoH]);

%% - #OCIACreateWindow: JointTracker: Joint and joint type manipulation selector label
commons = {'Parent', this.GUI.handles.panels.JointTrackerPanel, NormUnits{:}, BGWhite{:}};
alignOffsetY = -0.015;
jointSelLabX = loadX; jointSelLabW = (1 - jointSelLabX - 4 * pad) * 0.1;
jointSelLabH = loadH; jointSelLabY = cropY - jointSelLabH - pad + alignOffsetY;
this.GUI.handles.jt.jointSelLabel = uicontrol(commons{:}, 'String', 'Manip.', 'Tag', 'JTJointSelLabel', ...
    'Style', 'text', 'HorizontalAlignment', 'center', ...
    'Position', [jointSelLabX, jointSelLabY, jointSelLabW, jointSelLabH]);
%% - #OCIACreateWindow: JointTracker: Joint and joint type display selector label
jointSelDispLabX = loadX; jointSelDispLabW = (1 - jointSelDispLabX - 4 * pad) * 0.1;
jointSelDispLabH = loadH; jointSelDispLabY = jointSelLabY - jointSelDispLabH - pad;
this.GUI.handles.jt.jointSelDispLabel = uicontrol(commons{:}, 'String', 'Display', 'Tag', 'JTJointSelLabel', ...
    'Style', 'text', 'HorizontalAlignment', 'center', ...
    'Position', [jointSelDispLabX, jointSelDispLabY, jointSelDispLabW, jointSelDispLabH]);

%% - #OCIACreateWindow: JointTracker: Joint and joint type manipulation selector
commons = {'Parent', this.GUI.handles.panels.JointTrackerPanel, NormUnits{:}, BGWhite{:}, 'Style', 'listbox', ...
    'FontSize', this.GUI.pos(4) / 35, 'Callback', @(h, e)JTChangeJointOrJointType(this, h, e), 'Min', 0, 'Max', 2};
jointSelX = jointSelLabX + jointSelLabW + pad; jointSelW = (1 - jointSelLabX - 4 * pad) * 0.65;
jointSelH = loadH; jointSelY = cropY - jointSelH - pad;
this.GUI.handles.jt.jointSelSetter = uicontrol(commons{:}, 'Tag', 'JTJointManipSelSett', 'Value', [], ...
    'TooltipString', 'Joint manipulator', 'Position', [jointSelX, jointSelY, jointSelW, jointSelH], ...
    'String', regexp(regexprep(sprintf(' %d,', 1 : this.jt.nJoints), ',$', ''), ',', 'split'));
jointTypeSelX = jointSelX + jointSelW + pad; jointTypeSelW = (1 - jointSelLabX - 4 * pad) * 0.25;
this.GUI.handles.jt.jointTypeSelSetter = uicontrol(commons{:}, 'Tag', 'JTJointTypeManipSelSett', 'Value', [], ...
    'TooltipString', 'Joint type manipulator', 'Position', [jointTypeSelX, jointSelY, jointTypeSelW, jointSelH], ...
    'String', regexp(regexprep(sprintf(' %d,', 1 : this.jt.nJointTypes), ',$', ''), ',', 'split'));
%% - #OCIACreateWindow: JointTracker: Joint and joint type manipulation selector
jointSelDispX = jointSelDispLabX + jointSelDispLabW + pad; jointSelDispW = (1 - jointSelDispLabX - 4 * pad) * 0.65;
jointSelDispH = loadH; jointSelDispY = jointSelY - jointSelDispH - pad;
this.GUI.handles.jt.jointSelDispSetter = uicontrol(commons{:}, 'Tag', 'JTJointDispSelSett', ...
    'TooltipString', 'Joint display', 'Position', [jointSelDispX, jointSelDispY, jointSelDispW, jointSelDispH], ...
    'String', regexp(regexprep(sprintf(' %d,', 1 : this.jt.nJoints), ',$', ''), ',', 'split'), ...
    'Value', 1 : this.jt.nJoints);
jointTypeSelDispX = jointSelDispX + jointSelDispW + pad; jointTypeSelDispW = (1 - jointSelDispLabX - 4 * pad) * 0.25;
this.GUI.handles.jt.jointTypeSelDispSetter = uicontrol(commons{:}, 'Tag', 'JTJointDispTypeSelSett', ...
    'TooltipString', 'Joint type display', 'Position', [jointTypeSelDispX, jointSelDispY, jointTypeSelDispW, jointSelDispH], ...
    'String', regexp(regexprep(sprintf(' %d,', 1 : this.jt.nJointTypes), ',$', ''), ',', 'split'), ...
    'Value', 1 : this.jt.nJointTypes);
    
end
