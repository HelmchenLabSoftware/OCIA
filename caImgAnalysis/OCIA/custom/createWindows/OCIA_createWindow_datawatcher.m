function OCIA_createWindow_datawatcher(this, pad)
% OCIA_createWindow_datawatcher - [no description]
%
%       OCIA_createWindow_datawatcher(this, pad)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

BGWhite = {'Background', 'white'}; %#ok<*CCAT>
NormUnits = {'Units', 'normalized'};

%% - #OCIACreateWindow: DataWatcher
nHoriGroup = 8;
% width and height for standard elements within the DataWatcher panel
stdElemW = (1 - (nHoriGroup + 1) * pad) / nHoriGroup; stdElemH = 0.025;
PBElemH = 0.04; % height for the pushbuttons within the DataWatcher panel

%% -- #OCIACreateWindow: DataWatcher: watch type check boxes settings
watchTypes = this.dw.watchTypes;
nWatchTypes = size(watchTypes, 1);
% define the max number of rows and the number of items to place (+ 1 for the select all/none button)
nMaxRows = 6; nVisibWatchTypes = sum(watchTypes{:, 'visible'}) + 1;
% calculate the number of acutal columns and rows
nCols = ceil(nVisibWatchTypes / nMaxRows); nRows = min(nMaxRows, nVisibWatchTypes);

%% #OCIACreateWindow: DataWatcher: watch type check boxes group
commons = {'Parent', this.GUI.handles.panels.DataWatcherPanel, BGWhite{:}, NormUnits{:}};
watchTypeGroupW = stdElemW * 1.4; watchTypeGroupH = stdElemH * (nMaxRows + 1);
watchTypeGroupX = pad; watchTypeGroupY = 1 - watchTypeGroupH;
this.GUI.handles.dw.watchTypeGroup = uibuttongroup(commons{:}, 'Title', 'Watch type', ...
    'Tag', 'DWWatchTypeGroup', 'Position', [watchTypeGroupX, watchTypeGroupY, watchTypeGroupW, watchTypeGroupH]);

%% #OCIACreateWindow: DataWatcher: watch type check boxes
commons = {'Parent', this.GUI.handles.dw.watchTypeGroup, 'Style', 'checkbox', BGWhite{:}, NormUnits{:}};
inPad = 0.01; % inner padding for the radio group
elemW = (1 - (nCols + 1) * inPad) / nCols; % width depends on the number of columns
elemH = (1 - (nRows + 1) * inPad) / nRows; % height depends on the number of rows
elemPosX = inPad;       % initial X position
elemPosY = 1 - inPad;   % initial Y position
iRow = 1; iCol = 1; % init the row and column indexes
% go through all elements, create them and place them
for iType = 1 : nWatchTypes + 1;
    
    % only update position for visible items
    if (iType == nWatchTypes + 1) || (iType <= nWatchTypes && watchTypes.visible(iType));
        visible = 'on';
        value = 0;
        if iRow > nMaxRows; iRow = 1; iCol = iCol + 1; end;
        elemPosX = (iCol - 1) * (inPad + elemW) + inPad; % calculate X position
        elemPosY = 1 - iRow * (elemH + inPad) + inPad; % calculate Y position
        
    % if element should *not* be displayed, set the visibility to 'off' but make it checked (value = 1)
    else
        visible = 'off';
        value = 1;
    end;
    
    % select all/none checkbox
    if iType == nWatchTypes + 1;
        % make this button at the last row and be smaller
        elemPosButX = elemPosX + inPad; % calculate X position
        elemPosButY = 1 - nMaxRows * (elemH + inPad) + inPad; % calculate Y position
        elemButW = elemW - 2 * inPad;
        % create the GUI element
        this.GUI.handles.dw.watchTypesAllNone = uicontrol('Parent', this.GUI.handles.dw.watchTypeGroup, ...
            'Style', 'pushbutton', NormUnits{:}, 'String', 'All/None', ...
            'Tag', 'DWWatchTypeAllNone', 'Position', [elemPosButX, elemPosButY, elemButW, elemH], ...
            'ToolTipString', 'Toggle between selecting all elements or none', 'Value', 0);
        
    % normal watch type checkbox
    else
        % create the GUI element
        this.GUI.handles.dw.watchTypes.(watchTypes.id{iType}) = uicontrol(commons{:}, ...
            'String', watchTypes.label{iType}, 'ToolTipString', watchTypes.tooltip{iType}, ...
            'Tag', sprintf('DWWatchType_%s', watchTypes.id{iType}), 'Visible', visible, 'Value', value, ...
            'Position', [elemPosX, elemPosY, elemW, elemH]);
    end;
    
    % only update position for visible items
    if iType <= nWatchTypes && watchTypes{iType, 'visible'};
        iRow = iRow + 1;
    end;
end;

%% -- #OCIACreateWindow: DataWatcher: raw/local button group
commons = {'Parent', this.GUI.handles.panels.DataWatcherPanel, BGWhite{:}, NormUnits{:}};
rawLocSelW = watchTypeGroupW; rawLocSelH = stdElemH * 2;
rawLocSelX = watchTypeGroupX; rawLocSelY = watchTypeGroupY - pad - rawLocSelH;
this.GUI.handles.dw.rawLocGroup = uibuttongroup(commons{:}, 'Title', 'Raw/Local folder', ...
    'Position', [rawLocSelX rawLocSelY rawLocSelW rawLocSelH]);
%% -- #OCIACreateWindow: DataWatcher: raw/local radio buttons
commons = {'Parent', this.GUI.handles.dw.rawLocGroup, 'Style', 'radiobutton', BGWhite{:}, NormUnits{:}};
elemH = 1 - 2 * pad; elemW = (1 - 3 * pad) / 2;
this.GUI.handles.dw.rawLocSel.loc = uicontrol(commons{:}, 'String', 'local', 'Tag', 'DWLocSel', ...
    'Position', [pad, 1 - elemH, elemW, elemH], 'ToolTipString', 'Switch to local path');
this.GUI.handles.dw.rawLocSel.raw = uicontrol(commons{:}, 'String', 'raw', 'Tag', 'DWRawSel', ...
    'Position', [pad + elemW + pad, 1 - elemH, elemW, elemH], 'ToolTipString', 'Switch to raw path');
% set the change function and set the first "mode" to be selected 
set(this.GUI.handles.dw.rawLocGroup, 'SelectionChangeFcn', @(h, e)DWChangeRawLoc(this, h, e), ...
    'SelectedObject', this.GUI.handles.dw.rawLocSel.loc);

%% -- #OCIACreateWindow: DataWatcher: table filtering
%% #OCIACreateWindow: DataWatcher: table filtering: filtering panel
alignOffset = 0.005;
nFilt = size(this.GUI.dw.filtElems, 1); % get the total number of filters
nFiltY = sum(this.GUI.dw.filtElems{:, 'width'}) + 1; % get the number of rows to allocate for the filters
filtPanW = stdElemW * 1.3; filtPanH = stdElemH * 9 + alignOffset;
filtPanX = watchTypeGroupX + watchTypeGroupW + pad; filtPanY = 1 - pad - filtPanH + alignOffset;
% create the panel for the filters
this.GUI.handles.dw.filterPanel = uipanel('Parent', this.GUI.handles.panels.DataWatcherPanel, BGWhite{:}, ...
    NormUnits{:}, 'Title', 'Row filters', 'Tag', 'DWFiltPanel', 'Position', [filtPanX, filtPanY, filtPanW, filtPanH]);
%% #OCIACreateWindow: DataWatcher: table filtering: filtering elements
inPad = 0.025; % inner padding for the filter "group"
filtElemH = (1 - (nFiltY + 1) * inPad) / nFiltY;
filtElemX = inPad; filtElemY = 1 - inPad - filtElemH;
% adjust the font sizes
fontSizeValues = [52 60];
if nFilt < 4; fontSizeValues = [32 40]; end;
commons = {'Parent', this.GUI.handles.dw.filterPanel,BGWhite{:}, NormUnits{:}};
commonsDropDown = [commons, 'Style', 'popupmenu', 'FontSize', filtElemH * fontSizeValues(1)];
commonsTextField = [commons, 'Style', 'edit', 'FontSize', filtElemH * fontSizeValues(2)];
% go through each filter
for iFilt = 1 : nFilt;
    filtID = char(this.GUI.dw.filtElems{iFilt, 'id'}); % get the filter's ID
    filtWidth = this.GUI.dw.filtElems{iFilt, 'width'}; % get the filter's width
    % different filt width depending on the number of elements on this row
    if filtWidth == 1;  filtW = filtWidth - (filtWidth * inPad * 2);
    else                filtW = filtWidth - (filtWidth * inPad * 2.5);
    end;
    
    % process differently depending on the filter's GUI type
    switch char(this.GUI.dw.filtElems{iFilt, 'GUIType'});        
        % drop-down list
        case 'dropdown';
            this.GUI.handles.dw.filt.([filtID 'ID']) = uicontrol(commonsDropDown{:}, ...
                'String', this.dw.([filtID 'IDs']), 'Tag', ['DW_' filtID 'IDs'], ...
                'Position', [filtElemX, filtElemY, filtW, filtElemH], 'ToolTipString', ['Filter for ' filtID]);
        % text field
        case 'textfield';
            this.GUI.handles.dw.filt.(filtID) = uicontrol(commonsTextField{:}, 'String', '', ...
                'Tag', ['DW_' filtID 'IDs'], 'Position', [filtElemX, filtElemY, filtW, filtElemH], ...
                'ToolTipString', ['Filter for ' filtID ' using regular expressions']);
        
    end;
    
    % update the next filter's position: if current element is filling the row
    if filtElemX + filtWidth >= 1;
        % update both Y and X positions
        filtElemY = filtElemY - inPad - filtElemH;
        filtElemX = inPad;
    % if current filter is not filling the row, only update X position
    else
        filtElemX = filtElemX + filtW + 0.5 * inPad;
    end;
    
end;
%% ---- #OCIACreateWindow: DataWatcher: table filtering: filter buttons
commons = {'Parent', this.GUI.handles.dw.filterPanel, NormUnits{:}, 'Style', 'pushbutton'};
filtElemX = inPad; filtButW = (1 - 4 * inPad) / 2; filtButAddRemW = filtButW / 2;
filtButAddX = filtElemX + inPad + filtButW; filtButRemX = filtButAddX + inPad + filtButAddRemW;
this.GUI.handles.dw.filtNew = uicontrol(commons{:}, 'String', '<html><b>Filter', 'Tag', 'DWFiltNew', ...
    'Position', [filtElemX, filtElemY, filtButW, filtElemH], ...
    'Callback', @(~, ~)DWFilterSelectTable(this, 'new'), ...
    'ToolTipString', 'Filter the table with the current settings, creating a *NEW* selection');
this.GUI.handles.dw.filtAdd = uicontrol(commons{:}, 'String', '+', 'Tag', 'DWFiltAdd', ...
    'Position', [filtButAddX, filtElemY, filtButAddRemW, filtElemH], ...
    'Callback', @(~, ~)DWFilterSelectTable(this, 'add'), ...
    'ToolTipString', 'Filter the table with the current settings, *ADDING* to current selection');
this.GUI.handles.dw.filtRem = uicontrol(commons{:}, 'String', '-', 'Tag', 'DWFiltRem', ...
    'Position', [filtButRemX, filtElemY, filtButAddRemW, filtElemH], ...
    'Callback', @(~, ~)DWFilterSelectTable(this, 'rem'), ...
    'ToolTipString', 'Filter the table with the current settings, *REMOVING* from current selection');

%% -- #OCIACreateWindow: DataWatcher: update table button
commons = {'Parent', this.GUI.handles.panels.DataWatcherPanel, NormUnits{:}, 'Style', 'pushbutton'};
alignOffset = 0.0032; % small offset for better alignment
upTableW = stdElemW * 0.7; upTableH = 2 * PBElemH; upTableX = filtPanX + filtPanW + pad;
upTableY = 1 - pad - upTableH - alignOffset;
this.GUI.handles.dw.procFold = uicontrol(commons{:}, 'String', '<html><b>UPDATE</b><br>&nbsp;TABLE', ...
    'Tag', 'DWProcFold', ...
    'Callback', @(h, e)DWProcessWatchFolder(this, h, e), 'Position', [upTableX, upTableY, upTableW, upTableH], ...
    'ToolTipString', ['Scan for relevant files and folders in the watch folder and its sub-folders and' ...
        'fill/update the table accordingly.'], 'FontSize', this.GUI.pos(4) / 55);
   
%% -- #OCIACreateWindow: DataWatcher: skipMeta checkbox
commons = {'Parent', this.GUI.handles.panels.DataWatcherPanel, NormUnits{:}, BGWhite{:}};
skipMetaW = upTableW; skipMetaH = 2 * stdElemH; skipMetaX = upTableX; skipMetaY = upTableY - pad - skipMetaH;
this.GUI.handles.dw.skipMeta = uicontrol(commons{:}, 'Style', 'checkbox', 'Tag', 'DWSkipMetadata', ...
    'String', '<html>Skip metadata<br>&nbsp;&nbsp;processing', 'Value', this.GUI.dw.DWSkiptMeta, ...
    'Position', [skipMetaX, skipMetaY, skipMetaW, skipMetaH], ...
    'ToolTipString', 'Skip metadata processing: .xml header file, imaging file size estimation, etc. can be time consuming.');
   
%% -- #OCIACreateWindow: DataWatcher: keepRows
keepTableW = upTableW; keepTableH = 2 * stdElemH; keepTableX = upTableX; keepTableY = skipMetaY - pad - keepTableH;
this.GUI.handles.dw.keepTable = uicontrol(commons{:}, 'Style', 'checkbox', 'Tag', 'DWKeepTable', ...
    'String', 'Keep table', 'Value', this.GUI.dw.DWKeepTable, 'Position', [keepTableX, keepTableY, keepTableW, keepTableH], ...
    'ToolTipString', 'Keep the table when re-updating the table: add new rows to the table instead of replacing them.');

%% -- #OCIACreateWindow: DataWatcher: process buttons
commons = {'Parent', this.GUI.handles.panels.DataWatcherPanel, NormUnits{:}, 'Style', 'pushbutton', ...
    'FontSize', this.GUI.pos(4) / 55};
alignOffset = -0.003;
processButtons = this.GUI.dw.processButtons;
nStepsButtons = size(processButtons, 1);
stepButtonW = stdElemW * 0.9; stepButtonH = (PBElemH * 4) / nStepsButtons;
stepButtonX = upTableX + upTableW + pad; stepButtonY = 1 - pad - stepButtonH + alignOffset;
for iStep = 1 : nStepsButtons;
    stepButtonID = char(processButtons{iStep, 'id'});
    this.GUI.handles.dw.(stepButtonID) = uicontrol(commons{:}, ...
        'String', char(processButtons{iStep, 'label'}), 'Tag', char(processButtons{iStep, 'tag'}), ...
        'Position', [stepButtonX, stepButtonY, stepButtonW, stepButtonH], ...
        'ToolTipString', char(processButtons{iStep, 'tooltip'}));
    stepButtonY = stepButtonY - stepButtonH - pad;
    
    % get the DataWatcher process function's handle
    callBackFun = OCIAGetCallCustomFile(this, 'dataWatcherProcess', stepButtonID, 0, {}, 0);
    % add callback if it exists
    if ~isempty(callBackFun);
        set(this.GUI.handles.dw.(stepButtonID), 'Callback', @(h, e)callBackFun(this, h, e));
    end;
end;
% stepButtonY = stepButtonY + stepButtonH + pad; % remove last modification so that Y position is correctly set for later

%% -- #OCIACreateWindow: DataWatcher: preview image (thumbnail)
commons = {'Parent', this.GUI.handles.panels.DataWatcherPanel};
prevImW = 1.58 * stdElemW; prevImH = prevImW; alignOffsetX = 0.035; alignOffsetY = -0.004;
prevImX = stepButtonX + stepButtonW + pad - alignOffsetX; prevImY = 1 - pad - prevImH + alignOffsetY;
this.GUI.handles.dw.prevImAx = axes(commons{:}, ...
    'Position', [prevImX, prevImY, prevImW, prevImH], 'Color', 'white', 'XColor', 'white', 'YColor', 'white', ...
    'XGrid', 'off', 'YGrid', 'off', 'XTick', [], 'YTick', []);
% the creation of the image is done later to avoid weird flickering effect due to imshow
this.GUI.handles.dw.prevIm = [];
%% -- #OCIACreateWindow: DataWatcher: preview image (thumbnail) open as figure button
openPrevW = 0.35 * prevImW; openPrevH = 0.6 * (filtPanH - prevImH); alignOffsetX = 0.032;
openPrevX = prevImX + alignOffsetX; openPrevY = filtPanY;
this.GUI.handles.dw.openPrev = uicontrol(commons{:}, NormUnits{:}, 'Style', 'pushbutton', 'String', 'Open preview', ...
    'Position', [openPrevX, openPrevY, openPrevW, openPrevH], 'Callback', @(h, e) DWOpenPreviewAsFigure(this, h, e), ...
    'ToolTipString', 'Open preview in an external figure.');
this.GUI.handles.dw.prevIm = [];
%% -- #OCIACreateWindow: DataWatcher: open data as figure button
openDataW = 0.3 * prevImW; openDataH = openPrevH;
openDataX = openPrevX + openPrevW + 0.5 * pad; openDataY = openPrevY;
this.GUI.handles.dw.openData = uicontrol(commons{:}, NormUnits{:}, 'Style', 'pushbutton', 'String', 'Open data', ...
    'Position', [openDataX, openDataY, openDataW, openDataH], 'Callback', @(h, e) DWOpenDataAsFigure(this, h, e), ...
    'ToolTipString', 'Open data in an external figure.');

%% #OCIACreateWindow: DataWatcher: save/load buttons
commons = {'Parent', this.GUI.handles.panels.DataWatcherPanel, NormUnits{:}, 'Style', 'pushbutton'};
% saveW = 0.025; saveH = 0.03;
% saveX = SLRLabelX + SLRLabelW + pad; saveY = SLRLabelY - (saveH - SLRLabelH) / 2;
saveW = 0.03; saveH = 0.035; saveX = prevImX + prevImW + pad - alignOffsetX; saveY = 1 - pad - saveH;
saveIcon = load(fullfile(matlabroot(), '/toolbox/matlab/icons/savedoc.mat'));
this.GUI.handles.dw.save = uicontrol(commons{:}, 'String', '', 'Tag', 'DWSave', 'CData', saveIcon.cdata, ...
    'Position', [saveX, saveY, saveW, saveH], 'Callback', @(~, ~)DWSave(this, []), 'ToolTipString', 'Save data');
loadW = saveW; loadH = saveH; loadX = saveX + saveW + pad; loadY = saveY;
loadIcon = load(fullfile(matlabroot(), '/toolbox/matlab/icons/opendoc.mat'));
this.GUI.handles.dw.load = uicontrol(commons{:}, 'String', '', 'CData', loadIcon.cdata, 'ToolTipString', 'Load data', ...
    'Callback', @(~, ~)DWLoad(this, []), 'Tag', 'DWLoad', 'Position', [loadX, loadY, loadW, loadH]);
resetW = saveW; resetH = saveH; resetX = loadX + loadW + pad; resetY = loadY;
resetIcon = linScale(double(imread(regexprep(which('OCIA'), '@OCIA.OCIA\.m', 'icons/menuIcons/reset.png'))));
resetIcon(resetIcon == 0) = NaN;
this.GUI.handles.dw.reset = uicontrol(commons{:}, 'String', '', 'CData', resetIcon, ...
    'ToolTipString', 'Reset data in the selected rows', ...
    'Callback', @(~, ~)DWReset(this, []), 'Tag', 'DWLoad', 'Position', [resetX, resetY, resetW, resetH]);

%% #OCIACreateWindow: DataWatcher: save/load options group
commons = {'Parent', this.GUI.handles.panels.DataWatcherPanel, NormUnits{:}, BGWhite{:}};
alignOffsetY = 0.006;
SLROptGroupW = resetX + resetW - saveX; SLROptGroupH = saveY - rawLocSelY - pad;
SLROptGroupX = saveX; SLROptGroupY = resetY - SLROptGroupH - pad + alignOffsetY;
this.GUI.handles.dw.SLROptGroup = uibuttongroup(commons{:}, 'Title', 'Save / load options', 'Tag', ...
    'DWSLROptGroup', 'Position', [SLROptGroupX, SLROptGroupY, SLROptGroupW, SLROptGroupH]);
%% #OCIACreateWindow: DataWatcher: save/load options checkboxes
commons = {'Parent', this.GUI.handles.dw.SLROptGroup, 'Style', 'checkbox', BGWhite{:}, NormUnits{:}};
% define the max number of rows and the number of items to place button
nMaxCols = 1; nOpts = size(this.dw.dataSaveOptionsConfig, 1);
% calculate the number of acutal columns and rows
nRows = ceil(nOpts / nMaxCols); nCols = min(nMaxCols, nOpts);
inPad = 0.01; % inner padding for the radio group
elemW = (1 - (nCols + 1) * inPad) / nCols; % width depends on the number of columns
elemH = (1 - (nRows + 1) * inPad) / nRows; % height depends on the number of rows
iRow = 1; iCol = 1; % init the row and column indexes
% go through all elements, create them and place them
for iOpt = 1 : nOpts;
    optID = this.dw.dataSaveOptionsConfig.id{iOpt}; % get this option's ID
%     if iRow > nRows; iRow = 1; iCol = iCol + 1; end;
    if iCol > nCols; iCol = 1; iRow = iRow + 1; end;
    elemPosX = (iCol - 1) * (inPad + elemW) + inPad; % calculate X position
    elemPosY = 1 - iRow * (elemH + inPad) + inPad; % calculate Y position
    % create the GUI element
    this.GUI.handles.dw.SLROpts.(optID) = uicontrol(commons{:}, ...
        'String', this.dw.dataSaveOptionsConfig.label{iOpt}, ...
        'Tag', sprintf('DWSLROpts%s', optID), 'Position', [elemPosX, elemPosY, elemW, elemH], ...
        'ToolTipString', this.dw.dataSaveOptionsConfig.tooltip{iOpt}, ...
        'Value', this.dw.dataSaveOptionsConfig.defaultOn(iOpt));
%     iRow = iRow + 1;
    iCol = iCol + 1;
end;

%% #OCIACreateWindow: DataWatcher: save/load data options
commons = {'Parent', this.GUI.handles.panels.DataWatcherPanel, NormUnits{:}, BGWhite{:}, ...
    'Style', 'list', 'String', '', 'Min', 0, 'Max', 2};
SLROptDataX = resetX + resetW + pad; SLROptDataY = SLROptGroupY;
SLROptDataW = (1 - 2 * pad - SLROptDataX) * 0.5; SLROptDataH = SLROptGroupH + pad + saveH - pad;
this.GUI.handles.dw.SLROptDataList = uicontrol(commons{:}, 'Tag', 'DWSLROptData', 'Position', [SLROptDataX, SLROptDataY, SLROptDataW, SLROptDataH], ...
    'ToolTipString', 'Select the data "types" you want to save/load/reset.', 'Value', find(this.main.dataConfig.defaultOn));

%% #OCIACreateWindow: DataWatcher: processing options
procOptsX = SLROptDataX + SLROptDataW + pad; procOptsY = SLROptGroupY;
procOptsW = SLROptDataW; procOptsH = SLROptDataH;
this.GUI.handles.dw.procOptsList = uicontrol(commons{:}, 'Tag', 'DWProcOpts', 'Position', [procOptsX, procOptsY, procOptsW, procOptsH], ...
    'ToolTipString', 'Select the processing options to use.', 'Value', []);

%% -- #OCIACreateWindow: DataWatcher: table
% define dimensions for the table and the watch folder's display
tableX = pad; tableW = 1 - tableX - pad; tableY = pad;
watchFoldDispH = 0.02; watchFoldDispW = tableW * 0.455;
figBorder = 9; scrollBarW = 18; randomOffset = 0;
tableH = min(rawLocSelY, upTableY) - watchFoldDispH - 3 * pad;
watchFoldDispX = tableX; watchFoldDispY = tableY + tableH + pad;
% get the table's width in pixels
tableWInPixel = tableW * this.GUI.pos(3) - scrollBarW - 2 * figBorder + randomOffset;
% get the table's display table
tabDisplay = this.GUI.dw.tableDisplay;
% get the column lablels, re-order them and remove the non-visible ones
tableColumnLabels = tabDisplay.label;
order = 1 : numel(tabDisplay.order);
[~, tabOrderInd] = sort(tabDisplay.order);
order = order(tabOrderInd);
tableColumnLabels = tableColumnLabels(order);
tableColumnLabels(~tabDisplay.visible) = [];
% get the column widths, re-order them and remove the non-visible ones
columnWidths = num2cell(arrayfun(@(x) x * tableWInPixel, tabDisplay.width)');
columnWidths = columnWidths(order);
columnWidths(~tabDisplay.visible) = [];
% get the table's content, re-order its columns and remove the non-visible ones
tableContent = this.dw.table;
tableContent = tableContent(:, order);
tableContent(:, ~tabDisplay.visible) = [];
% only use uitable if the GUI is active (uitable is not available in "nodisplay" mode
if isGUI(this);
    this.GUI.handles.dw.table = uitable('Parent', this.GUI.handles.panels.DataWatcherPanel, NormUnits{:}, ...
        'Position', [tableX tableY tableW tableH], 'Tag', 'DWTable', 'Data', tableContent, ...
        'RowName', [], 'ColumnName', tableColumnLabels, 'ColumnWidth', columnWidths, ...
        'CellSelectionCallback', @(h, e)DWTableClick(this, h, e), 'FontSize', max(min(this.GUI.pos(3) / 170, 22), 8));
% if no GUI, use a simple uicontrol
else
    this.GUI.handles.dw.table = uicontrol('Parent', this.GUI.handles.panels.DataWatcherPanel, NormUnits{:}, ...
        'Position', [tableX tableY tableW tableH], 'Tag', 'DWTable');
end;
%% -- #OCIACreateWindow: DataWatcher: watchFolder path display
commons = {'Parent', this.GUI.handles.panels.DataWatcherPanel, NormUnits{:}};
this.GUI.handles.dw.watchFoldDisp = uicontrol(commons{:}, 'Style', 'text', 'Tag', 'DWWatchFoldDisp', ...
    'String', sprintf('Watch folder: %s', this.dw.watchFolder), 'HorizontalAlignment', 'left', ...
    'Position', [watchFoldDispX, watchFoldDispY, watchFoldDispW, watchFoldDispH], BGWhite{:});
%% -- #OCIACreateWindow: DataWatcher: change watchFolder button
alignOffset = 0.002;
changeWFW = tableW * 0.5 - watchFoldDispW - pad - alignOffset; changeWFH = watchFoldDispH + 2 * alignOffset;
changeWFX = watchFoldDispX + watchFoldDispW + pad; changeWFY = watchFoldDispY - alignOffset;
this.GUI.handles.dw.changeWatchFold = uicontrol(commons{:}, 'Style', 'pushbutton', 'Tag', 'DWChangeWatchFold', ...
    'String', '...', 'Position', [changeWFX, changeWFY, changeWFW, changeWFH], ...
    'Callback', @(h, e)DWUpdateWatchFolderPath(this, ''));
set(this.GUI.handles.dw.changeWatchFold, 'ToolTipString', 'Change watch folder''s path');
%% -- #OCIACreateWindow: DataWatcher: waitbar
alignOffset = 0.002;
waitBarW = 1 - 2 * pad - changeWFW - changeWFX - alignOffset; waitBarH = watchFoldDispH;
waitBarX = changeWFX + changeWFW + pad; waitBarY = watchFoldDispY;
this.GUI.handles.dw.waitBar = axes('Parent', this.GUI.handles.panels.DataWatcherPanel, 'Tag', 'DWWaitBar', ...
    'Position', [waitBarX, waitBarY, waitBarW, waitBarH], 'Color', 'black', 'XColor', 'black', 'YColor', 'black', ...
    'XGrid', 'off', 'YGrid', 'off', 'XTick', [], 'YTick', [], 'YLim', [0 1], 'XLim', [0 100]);
DWWaitBar(this, 0); % set to 0

%% -- #OCIACreateWindow: DataWatcher: update filters and watch types
DWUpdateFiltersAndWatchTypes(this)

end
