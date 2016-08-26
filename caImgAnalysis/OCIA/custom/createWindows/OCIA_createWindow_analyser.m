function OCIA_createWindow_analyser(this, pad)
% OCIA_createWindow_analyser - [no description]
%
%       OCIA_createWindow_analyser(this, pad)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

BGWhite = {'Background', 'white'}; %#ok<*CCAT>
NormUnits = {'Units', 'normalized'};

%% - #OCIACreateWindow: Analyser: plot axes
% axePadLeft = 0.08; axePadRight = 0.08; axePadTop = 0.85; axePadBottom = 0.065;
% axePadLeft = 0.08; axePadRight = 0.08; axePadTop = 0.290; axePadBottom = 0.065; % original
axePadLeft = 0.08; axePadRight = 0.08; axePadTop = 0.260; axePadBottom = 0.065;
axeW = 1 - axePadLeft - axePadRight - 2 * pad; axeH = 1 - axePadTop - axePadBottom - 1.5 * pad;
axeY = pad + axePadBottom; axeX = pad + axePadLeft;
commons = {'Parent', this.GUI.handles.panels.AnalyserPanel, NormUnits{:}};
this.GUI.handles.an.axe = axes(commons{:}, 'Tag', 'ANAxe', 'Color', 'white', 'Position', ...
    [axeX axeY axeW axeH]);

%% - #OCIACreateWindow: Analyser: loading text
commons = [commons, BGWhite{:}];
this.GUI.handles.an.message = uicontrol(commons{:}, 'Tag', 'ANMessage', 'Style', 'text', ...
    'String', 'Loading ...', 'Visible', 'off', 'FontSize', this.GUI.pos(4) / 45, ...
    'Position', [0 axeY * 0.1 1 axeH + axeY * 0.9]);

%% - #OCIACreateWindow: Analyser: runTable, plotList and ROI selection list
commons = [commons, { 'Style', 'list', 'Callback', @(h, e)ANUpdatePlot(this, h, e) }];
labelCommons = [commons(1 : end - 2), 'Style', 'text', 'FontSize', this.GUI.pos(4) / 80, 'HorizontalAlignment', 'center'];
availH = axePadTop * 0.75 - 1.5 * pad - pad; labH = availH * 0.1; labY = 1 - labH - pad;
listH = availH - labH; listY = labY - listH - pad;
nList = 2; allListsW = 0.4 - (nList + 1) * pad;
plotListW = allListsW * 0.360;
rowListW = allListsW - plotListW;
% groupListW = allListsW * 0.120;
% ROIListW = allListsW * 0.110;
listX = pad;

this.GUI.handles.an.plotListLab = uicontrol(labelCommons{:}, 'String', 'Plot/Analysis', 'Tag', 'ANPlotListLab', ...
    'Position', [listX, labY, plotListW, labH]);
this.GUI.handles.an.plotList = uicontrol(commons{:}, 'Tag', 'ANPlotList', 'Position', [listX, listY, plotListW, listH]);
listX = listX + plotListW + pad;

% this.GUI.handles.an.groupListLab = uicontrol(labelCommons{:}, 'String', 'Group by', 'Tag', 'ANGroupListLab', ...
%     'Position', [listX, labY, groupListW, labH]);
% this.GUI.handles.an.groupList = uicontrol(commons{:}, 'Tag', 'ANGroupList', 'Position', [listX, listY, groupListW, listH]);
% listX = listX + groupListW + pad;

this.GUI.handles.an.rowListLab = uicontrol(labelCommons{:}, 'String', 'Data rows    ', 'Tag', 'ANRowListLab', ...
    'Position', [listX, labY, rowListW, labH]);
this.GUI.handles.an.rowList = uicontrol(commons{:}, 'Tag', 'ANRowList', 'Max', 2, 'Min', 0, ...
    'Position', [listX, listY, rowListW, listH]);
listX = listX + rowListW + pad;

% this.GUI.handles.an.ROIList = uicontrol(labelCommons{:}, 'Tag', 'ANROIListLab', 'String', 'ROIs  ', ...
%     'Position', [listX, labY, ROIListW, labH]);
% this.GUI.handles.an.ROIList = uicontrol(commons{:}, 'Tag', 'ANROIList', 'Max', 2, 'Min', 0, ...
%     'Position', [listX, listY, ROIListW, listH]);
% listX = listX + ROIListW + pad;

%% - #OCIACreateWindow: Analyser: zoom button
commons = {'Parent', this.GUI.handles.panels.AnalyserPanel, NormUnits{:}, 'Value', 0, 'Style', 'togglebutton'};
zToolW = 0.025; zToolH = 0.03; zToolX = listX; zToolY = 1 - zToolH - pad;
zToolIcon = load(fullfile(matlabroot(), '/toolbox/matlab/icons/zoom.mat'));
this.GUI.handles.an.zTool = uicontrol(commons{:}, 'Tag', 'ANZTool', 'CData', zToolIcon.zoomCData, ...
    'Position', [zToolX, zToolY, zToolW, zToolH], 'Callback', @(h, e)ANActivateZoom(this, h, e), ...
    'ToolTipString', 'Zoom');

%% - #OCIACreateWindow: Analyser: pan button
pToolW = zToolW; pToolH = zToolH; pToolX = zToolX + zToolW + pad; pToolY = zToolY;
pToolIcon = load(fullfile(matlabroot(), '/toolbox/matlab/icons/pan.mat'));
this.GUI.handles.an.pTool = uicontrol(commons{:}, 'CData', pToolIcon.cdata, 'Tag', 'ANPTool', ...
    'Position', [pToolX, pToolY, pToolW, pToolH], 'Callback', @(h, e)ANActivatePan(this, h, e), ...
    'ToolTipString', 'Pan (scroll)');

%% - #OCIACreateWindow: Analyser: data cursor button
cToolW = zToolW; cToolH = zToolH; cToolX = pToolX + pToolW + pad; cToolY = zToolY;
cToolIcon = load(fullfile(matlabroot(), '/toolbox/matlab/icons/datatip.mat'));
this.GUI.handles.an.cTool = uicontrol(commons{:}, 'CData', cToolIcon.cdata, 'Tag', 'ANCTool', ...
    'Position', [cToolX, cToolY, cToolW, cToolH], 'Callback', @(h, e)ANActivateDataCursor(this, h, e), ...
    'ToolTipString', 'Data cursor');

%% - #OCIACreateWindow: Analyser: save plot button
commons = {'Parent', this.GUI.handles.panels.AnalyserPanel, NormUnits{:}, 'Style', 'pushbutton', 'FontSize', 13};
savePlotW = zToolW; savePlotH = zToolH; savePlotX = zToolX; savePlotY = zToolY - savePlotH - pad;
savePlotIcon = load(fullfile(matlabroot(), '/toolbox/matlab/icons/savedoc.mat'));
this.GUI.handles.an.savePlot = uicontrol(commons{:}, 'CData', savePlotIcon.cdata, 'Tag', 'ANSavePlot', ...
    'Position', [savePlotX, savePlotY, savePlotW, savePlotH], 'Callback', @(~, ~)ANSavePlot(this, []), ...
    'ToolTipString', 'Save the currently displayed plot to a figure (.fig) or to an image (.png/.jpg/...)).');

%% - #OCIACreateWindow: Analyser: save output button
saveOutW = zToolW; saveOutH = zToolH; saveOutX = savePlotX + savePlotW + pad; saveOutY = savePlotY;
saveOutIcon = linScale(double(imread(regexprep(which('OCIA'), '@OCIA.OCIA\.m', 'icons/menuIcons/saveOutput.png'))));
saveOutIcon(saveOutIcon == 0) = NaN;
this.GUI.handles.an.saveOut = uicontrol(commons{:}, 'CData', saveOutIcon, 'Tag', 'ANSaveOutput', ...
    'Position', [saveOutX, saveOutY, saveOutW, saveOutH], 'Callback', @(~, ~)ANSaveOutput(this, []), ...
    'ToolTipString', 'Save output results as a MAT-file');

%% - #OCIACreateWindow: Analyser: load output button
loadOutW = zToolW; loadOutH = zToolH; loadOutX = saveOutX + saveOutW + pad; loadOutY = savePlotY;
loadOutIcon = linScale(double(imread(regexprep(which('OCIA'), '@OCIA.OCIA\.m', 'icons/menuIcons/loadOutput.png'))));
loadOutIcon(loadOutIcon == 0) = NaN;
this.GUI.handles.an.loadOut = uicontrol(commons{:}, 'CData', loadOutIcon, 'Tag', 'ANLoadOutput', ...
    'Position', [loadOutX, loadOutY, loadOutW, loadOutH], 'Callback', @(~, ~)ANLoadOutput(this, []), ...
    'ToolTipString', 'Load output results from MAT-file');

%% - #OCIACreateWindow: Analyser: clear cached data
clearCacheW = zToolW; clearCacheH = zToolH; clearCacheX = loadOutX + loadOutW + pad; clearCacheY = savePlotY;
iconPath = regexprep(which('OCIA'), '@OCIA.OCIA\.m', 'icons/menuIcons/reset.png');
clearCacheIcon = linScale(double(imread(iconPath)));
clearCacheIcon(clearCacheIcon == 0) = NaN;
this.GUI.handles.an.clearCache = uicontrol(commons{:}, 'CData', clearCacheIcon, 'Tag', 'ANClearCache', ...
    'Position', [clearCacheX, clearCacheY, clearCacheW, clearCacheH], 'Callback', @(~, ~)ANClearData(this, []), ...
    'ToolTipString', 'Clear the cached data. Next run of analysis/plot will be re-calculated from scratch.');

%% - #OCIACreateWindow: Analyser: edit field for row filtering
baseW = 0.115; baseH = 0.035;
rowFiltW = (baseW - pad) * 0.6; rowFiltH = baseH; rowFiltX = zToolX; rowFiltY = savePlotY - baseH - pad;
this.GUI.handles.an.rowFilt = uicontrol(commons{:}, BGWhite{:}, 'Style', 'edit', 'String', '', 'Tag', 'ANRowFilt', ...
    'Position', [rowFiltX, rowFiltY, rowFiltW, rowFiltH], 'ToolTipString', 'Regular expression for row filtering.');

%% - #OCIACreateWindow: Analyser: button for row filtering
rowFiltButW = baseW - pad - rowFiltW; rowFiltButH = baseH;
rowFiltButX = rowFiltX + rowFiltW + pad; rowFiltButY = rowFiltY;
this.GUI.handles.an.rowFiltBut = uicontrol(commons{:}, 'String', 'Filter', 'Tag', 'ANRowFiltBut', ...
    'Position', [rowFiltButX, rowFiltButY, rowFiltButW, rowFiltButH], 'Callback', @(~, ~)ANFiltRows(this), ...
    'ToolTipString', 'Filter the rows using the expression in the edit box.');

% %% - #OCIACreateWindow: Analyser: clear data
% clearDataW = baseW; clearDataH = baseH; clearDataRunsX = zToolX; clearDataRunsY = savePlotY - clearDataH - pad;
% this.GUI.handles.an.clearDataRuns = uicontrol(commons{:}, 'String', 'Clear data', 'Tag', 'ANClearData', ...
%     'Position', [clearDataRunsX, clearDataRunsY, clearDataW, clearDataH], 'Callback', @(~, ~)ANClearData(this), ...
%     'ToolTipString', 'Clear the cached data and run analysis/plot from scratch.');

% %% - #OCIACreateWindow: Analyser: all runs
% baseW = 0.115; selAllH = clearDataH; selAllRunsX = zToolX; selAllRunsY = clearDataRunsY - selAllH - pad;
% this.GUI.handles.an.selAllRuns = uicontrol(commons{:}, 'String', 'Select all runs', 'Tag', 'ANSelAllRuns', ...
%     'Position', [selAllRunsX, selAllRunsY, baseW, selAllH], 'Callback', @(~, ~)ANSelRuns(this, 'all'));

% %% - #OCIACreateWindow: Analyser: select all ROIs
% selAllROIsX = zToolX; selAllROIsY = selAllRunsY - selAllH - pad;
% this.GUI.handles.an.selAllROIs = uicontrol(commons{:}, 'String', 'Select all ROIs', 'Tag', 'ANSelAllROIs', ...
%     'Position', [selAllROIsX, selAllROIsY, baseW, selAllH], 'Callback', @(~, ~)ANSelROIs(this, 'all'));

%% - #OCIACreateWindow: Analyser: update Plot
upPlotW = baseW; upPlotH = baseH; upPlotX = zToolX; upPlotY = rowFiltY - upPlotH - pad;
this.GUI.handles.an.upPlot = uicontrol(commons{:}, 'String', 'Update Plot', 'Tag', 'ANUpdatePlot', ...
    'Position', [upPlotX, upPlotY, upPlotW, upPlotH], 'Callback', @(h, e)ANUpdatePlot(this, h, e), 'FontSize', 16);

%% - #OCIACreateWindow: Analyser: auto-update Plot
commons = {'Parent', this.GUI.handles.panels.AnalyserPanel, NormUnits{:}, BGWhite{:}};
autoUpPlotW = baseW; autoUpPlotH = baseH * 0.5;
autoUpPlotX = zToolX; autoUpPlotY = upPlotY - autoUpPlotH - pad;
this.GUI.handles.an.autoUpPlot = uicontrol(commons{:}, 'Style', 'checkbox', 'String', 'Auto-update plot', ...
    'Tag', 'ANAutoUpdatePlot', 'Position', [autoUpPlotX, autoUpPlotY, autoUpPlotW, autoUpPlotH], ...
    'ToolTipString', 'Automatically update plot when a setting is changed.');

%% - #OCIACreateWindow: Analyser: parameter panel
paramPansX = autoUpPlotX + autoUpPlotW + pad; paramPansY = listY;
paramPansW = 1 - paramPansX - pad; paramPansH = 1 - paramPansY;
this.GUI.handles.an.paramPan = uipanel(commons{:}, 'Title', 'Parameters for plot/analysis', 'Tag', 'ANParamPan', ...
    'Position', [paramPansX paramPansY paramPansW paramPansH], 'FontSize', this.GUI.pos(4) / 60);

end
