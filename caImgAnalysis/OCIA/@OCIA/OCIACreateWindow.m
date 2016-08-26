function OCIACreateWindow(this)
% OCIACreateWindow - Creates the window (figure)
%
%       OCIACreateWindow(this)
%
% Creates the window (or figure) for the OCIA, adding one panel for each mode (specified in this.main.modes). Calls
%   the mode-specific window creating functions for each mode using the syntax "OCIA_createWindow_[modeName].m".

% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% - #OCIACreateWindow: init
createWindowTic = tic; % for performance timing purposes
o('#%s(): creating window ...', mfilename, 3, this.verb);

pad = 0.005; % padding between objects in the window

BGWhite = {'Background', 'white'}; %#ok<*CCAT>
NormUnits = {'Units', 'normalized'};

%% - #OCIACreateWindow: main window
this.GUI.figH = figure('MenuBar', 'none', 'Toolbar', 'none', ...
    'Name', sprintf('OCIA v%s - Online Calcium Imaging Assistant ... and more !', this.main.version), 'Resize', 'on', ...
    'NumberTitle', 'off', 'Color', 'white', 'Units', 'pixels', 'CloseRequestFcn', @(h, e)OCIACloseGUI(this, h, e), ...
    'WindowKeyPressFcn', @(h, e)keyPressed(this, h, e), 'WindowButtonMotionFcn', @(h, e)mouseMoved(this, h, e), ...
    'WindowButtonDownFcn', @(h, e)mouseDown(this, h, e), 'WindowButtonUpFcn', @(h, e)mouseUp(this, h, e), ...
    'ResizeFcn', @(h, e) windowResized(this, h, e), 'Visible', 'off', 'Position', this.GUI.pos, ...
    'HandleVisibility', 'off');

%% - #OCIACreateWindow: change mode pop-up list
commons = {'Parent', this.GUI.figH, BGWhite{:}, NormUnits{:}};
% changeModeW = 0.125; changeModeH = 0.0275; changeModeX = 1 - pad - changeModeW; changeModeY = 1 - pad - changeModeH;
changeModeW = 0.15; changeModeH = 0.04; changeModeX = 1 - pad - changeModeW; changeModeY = 1 - pad - changeModeH;
this.GUI.handles.changeMode = uicontrol(commons{:}, 'Callback', @(h, e)OCIAChangeMode(this, h, e), ...
    'String', this.main.modes(:, 1), 'Style', 'popupmenu', 'Tag', 'changeMode', ...
    'Position', [changeModeX, changeModeY, changeModeW, changeModeH], 'FontSize', 10);

%% - #OCIACreateWindow: log display (message/warning/error)
% logH = changeModeH; logW = 0.7; logX = changeModeX - pad - logW; logY = 1 - pad - logH;
logH = changeModeH; logW = 0.82; logX = changeModeX - pad - logW; logY = 1 - pad - logH;
this.GUI.handles.logBar = uicontrol(commons{:}, 'Style', 'edit', 'String', '', 'Tag', 'LogBar', ...
    'Enable', 'inactive', 'HorizontalAlignment', 'left', 'Position', [logX, logY, logW, logH]);

%% - #OCIACreateWindow: 'mode' panels
alignOffset = 0.01;
commons = {BGWhite{:}, NormUnits{:}, 'Visible', 'off', 'Position', ...
    [pad, pad, 1 - 2 * pad, changeModeY - 2 * pad + alignOffset]};
for iMode = 1 : size(this.main.modes, 1);
    this.GUI.handles.panels.([this.main.modes{iMode, 1} 'Panel']) = uipanel('Parent', this.GUI.figH, ...
        'Title', this.main.modes{iMode, 1}, 'Tag', [this.main.modes{iMode, 1} 'Panel'], commons{:});
end;

%% - #OCIACreateWindow: mode specific window creation functions
for iMode = 1 : size(this.main.modes, 1);
    % call the window creation function for this mode
    modeName = lower(this.main.modes{iMode});
    o('  #%s(): creating window for "%s" ...', mfilename, modeName, 4, this.verb);
    OCIAGetCallCustomFile(this, 'createWindow', modeName, 1, { this, pad }, 0);
end;

%% - #OCIACreateWindow: set up icon
if isGUI(this);
    iconPath = strrep(which(mfilename()), '@OCIA\OCIACreateWindow.m', 'icons\menuIcons\icon.png');
    if exist(iconPath, 'file');
        warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
        jFrame = get(this.GUI.figH, 'javaframe');
        jFrame.setFigureIcon(javax.swing.ImageIcon(iconPath));
        warning('on','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
    end;
end;

o('#%s(): window created (%.4f sec).', mfilename, toc(createWindowTic), 3, this.verb);

end
