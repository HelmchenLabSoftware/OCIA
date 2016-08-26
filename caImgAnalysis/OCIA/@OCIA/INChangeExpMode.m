function INChangeExpMode(this, h, ~)
% INChangeExpMode - [no description]
%
%       INChangeExpMode(this, h, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if this.GUI.handles.in.expMode ~= h; % if change was requested by a input value
    this.in.expMode = h;
    o('#%s(): h: %d, expMode: %d.', mfilename, h, this.in.expMode, 4, this.verb);
    % change the GUI value to the right one
    set(this.GUI.handles.in.expMode, 'Value', find(strcmp(this.in.expMode, get(this.GUI.handles.in.expMode, 'String'))));
    
else % if change was requested by the callback
    o('#%s(): h: %d, value: %d.', mfilename, h, get(h, 'Value'), 4, this.verb);
    expModes = get(this.GUI.handles.in.expMode, 'String');
    this.in.expMode = expModes{get(h, 'Value')};
    
end;

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
showMessage(this, sprintf('Intrinsic: experiment mode changed to "%s".', this.in.expMode));

% if they are still valid, set back the enable/disable state of the navigating buttons
if ishandle(this.GUI.handles.in.prevParams);
    set(this.GUI.handles.in.prevParams, 'Enable', prevEnableState);
    set(this.GUI.handles.in.nextParams, 'Enable', nextEnableState);
end;

% enable the other elements that are not part of the parameter pannel
for iExpMode = 1 : numel(this.in.expModes);
    elems = fieldnames(this.GUI.handles.in.(this.in.expModes{iExpMode}));
    for iElem = 1 : numel(elems);
        set(this.GUI.handles.in.(this.in.expModes{iExpMode}).(elems{iElem}), 'Visible',...
            iff(strcmp(this.in.expMode, this.in.expModes{iExpMode}), 'on', 'off'));
    end;
end;

% disable run choser if not in use
if get(this.GUI.handles.in.standard.showAvg, 'Value');
    set(this.GUI.handles.in.standard.runChooser, 'Enable', 'off');
    set(this.GUI.handles.in.standard.inclRun, 'Enable', 'off');
end;


end

