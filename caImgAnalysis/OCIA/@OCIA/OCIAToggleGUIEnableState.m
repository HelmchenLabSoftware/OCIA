function OCIAToggleGUIEnableState(this, panelName, state)
% OCIAToggleGUIEnableState - [no description]
%
%       OCIAToggleGUIEnableState(this, panelName, state)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if ischar(state);
    state = iff(strcmp(state, 'on'), 1, 0);
end;

shortPanelName = this.main.modes{strcmp(panelName, this.main.modes(:, 1)), 2};

% get all child elements
childElems = get(this.GUI.handles.panels.([panelName 'Panel']), 'Children');
% get which one of them are input elements
inputElems = ismember(get(childElems, 'Type'), { 'uicontrol', 'uitable'});
UIPanelElems = childElems(ismember(get(childElems, 'Type'), { 'uipanel' }));

% enable the panel's GUI  
if state;
    
    % enable all GUI elements of the panel
    set(childElems(inputElems), 'Enable', 'on');
    
    % change the state of the sub-panel child elements
    for iChild = 1 : numel(UIPanelElems);
        subPanChildElems = get(UIPanelElems(iChild), 'Children');
        subPanInputElems = strcmp('uicontrol', get(subPanChildElems, 'Type'));
        set(subPanChildElems(subPanInputElems), 'Enable', 'on');
    end;
    
    if isfield(this.GUI.handles.(shortPanelName), 'paramPan');
        % enable all GUI elements of the panel's parameter panel
        childElems = get(this.GUI.handles.(shortPanelName).paramPan, 'Children');
        paramInputElems = strcmp('uicontrol', get(childElems, 'Type'));
        set(childElems(paramInputElems), 'Enable', 'on');
    end;
  
% disable the panel's GUI  
else
    
    % disable all GUI elements of the panel
    set(childElems(inputElems), 'Enable', 'off');
    
    % change the state of the sub-panel child elements
    for iChild = 1 : numel(UIPanelElems);
        subPanChildElems = get(UIPanelElems(iChild), 'Children');
        subPanInputElems = strcmp('uicontrol', get(subPanChildElems, 'Type'));
        set(subPanChildElems(subPanInputElems), 'Enable', 'off');
    end;

    if isfield(this.GUI.handles.(shortPanelName), 'paramPan');
        % disable all GUI elements of the panel's parameter panel
        childElems = get(this.GUI.handles.(shortPanelName).paramPan, 'Children');
        paramInputElems = strcmp('uicontrol', get(childElems, 'Type'));
        set(childElems(paramInputElems), 'Enable', 'off');
        if isfield(this.GUI.handles.(shortPanelName), 'message');
            % do not disable the message display element
            set(this.GUI.handles.(shortPanelName).message, 'Enable', 'on');
        end;
    end;
    
end;

end