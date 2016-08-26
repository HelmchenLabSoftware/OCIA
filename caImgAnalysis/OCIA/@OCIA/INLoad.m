function INLoad(this, loadPath)
% INLoad - [no description]
%
%       INLoad(this, loadPath)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% if no load path specified, try to get one via the user interface
if isempty(loadPath);
    [loadName, loadPath] = uigetfile('*.*', 'Select a file to load', ...
        iff(exist(this.path.intrSave, 'dir'), this.path.intrSave, this.path.OCIASave));
    % if a path was specified, use that one
    if ischar(loadName);
        loadPath = [loadPath loadName];
    else % otherwise abort the loading
        return;
    end;
end;

% clean path
loadPath = regexprep(loadPath, '\\', '/');

% load the file
showMessage(this, sprintf('Intrinsic: loading intrinsic data from "%s" ...', loadPath));
intrSaveMat = load(loadPath);
intrSave = intrSaveMat.intrSave;

% reload fields that are present in the save file
params = fieldnames(intrSave);
for iParam = 1 : numel(params);
    this.in.(params{iParam}) = intrSave.(params{iParam});
end;

% if ROIPos is present, use it
if isfield(this.in, 'ROIPos') && ~isempty(this.in.ROIPos);
    INDrawROI(this, [], [], this.in.ROIPos);
    this.in = rmfield(this.in, 'ROIPos');
end;
if isfield(this.in, 'GUI');
    this.in = rmfield(this.in, 'GUI');
end;

%% load back the GUI state
% hide all parameter panels
for iExpMode = 1 : numel(this.in.expModes);
    set(this.GUI.handles.in.paramPans.(this.in.expModes{iExpMode}), 'Visible', 'off');
end;

% show the selected parameter panel
set(this.GUI.handles.in.paramPans.(this.in.expMode), 'Visible', 'on');

% set the right parameter panel as the current "paramPan"
this.GUI.handles.in.paramPan = this.GUI.handles.in.paramPans.(this.in.expMode);

% filter out the paramPanConfig for the current mode only
baseParamPanConfig = this.GUI.in.paramPanConfig;
filtParamPanConfig = baseParamPanConfig;
filtParamPanConfig(~ismember(filtParamPanConfig.categ, { this.in.expMode, 'common'}), :) = [];

% use the filtered param panel as config and create the UI controls
this.GUI.in.paramPanConfig = filtParamPanConfig;
OCIACreateParamPanelControls(this, 'in');

% set back the originial config to not lose it
this.GUI.in.paramPanConfig = baseParamPanConfig;

% if they are still valid, store the enable/disable state of the navigating buttons
if ishandle(this.GUI.handles.in.prevParams);
    prevEnableState = get(this.GUI.handles.in.prevParams, 'Enable');
    nextEnableState = get(this.GUI.handles.in.nextParams, 'Enable');
end;

% enable the GUI and show message
OCIAToggleGUIEnableState(this, 'Intrinsic', 1);

% if they are still valid, set back the enable/disable state of the navigating buttons
if ishandle(this.GUI.handles.in.prevParams);
    set(this.GUI.handles.in.prevParams, 'Enable', prevEnableState);
    set(this.GUI.handles.in.nextParams, 'Enable', nextEnableState);
end;

% disable run choser if not in use
if get(this.GUI.handles.in.standard.showAvg, 'Value');
    set(this.GUI.handles.in.standard.runChooser, 'Enable', 'off');
end;

INUpdateGUI(this);

showMessage(this, sprintf('Intrinsic: loading intrinsic data from "%s" done !', loadPath));


end
