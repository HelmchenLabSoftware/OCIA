function BELoadConfig(this, ~, ~)
% BELoadConfig - [no description]
%
%       BELoadConfig(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

showMessage(this, 'Loading configuration ...');
set(this.GUI.handles.be.loadConf, 'BackgroundColor', 'yellow');
pause(0.01);

if isempty(this.GUI.be.selConfigRow); % attempt to fetch again the selected row
    jTable = getJTable(this, 'BEConfTable');
    this.GUI.be.selConfigRow = jTable.getSelectedRows() + 1;
    if isempty(this.GUI.be.selConfigRow);
        showWarning(this, 'OCIA:Behavior:loadConfig:NoMouseIdSelected', ...
            'Cannot load config because no mouse ID is selected.');
        set(this.GUI.handles.be.loadConf, 'BackgroundColor', 'red', 'Value', 0);
        return;
    end;
end;

configCell = this.be.configs.animals;
this.be.animalID = configCell{this.GUI.be.selConfigRow, 1};
this.be.taskType = configCell{this.GUI.be.selConfigRow, 2};
this.be.phase = configCell{this.GUI.be.selConfigRow, 3};

% if > 0, sets the number of seconds to wait before a new run of mtrainer
% this.be.automode = 5;
this.be.iTrial = 0;
this.be.config = this.be.configs.behavior.(this.be.taskType).(this.be.phase);
% create config parameter panel
this.GUI.be.paramPanConfig(:, :) = [];

toneConfFields = fieldnames(this.be.config.tone);
for iField = 1 : numel(toneConfFields);
    fieldName = toneConfFields{iField};
    paramConf = cell2table({ ...
...     categ           id          UIType  valueType       UISize  isLabAbove  label       tooltip
        'config.tone',  fieldName,  'text', { 'array' },    [1 0],  false,      fieldName,  '';
    }, 'VariableNames', this.GUI.be.paramPanConfig.Properties.VariableNames);
    % append the new configuration to the table and update the row names using the ids
    this.GUI.be.paramPanConfig = [this.GUI.be.paramPanConfig; paramConf];
    this.GUI.be.paramPanConfig.Properties.RowNames = this.GUI.be.paramPanConfig.id;
end;

trainConfFields = fieldnames(this.be.config.training);
for iField = 1 : numel(trainConfFields);
    fieldName = trainConfFields{iField};
    paramConf = cell2table({ ...
...     categ               id          UIType  valueType       UISize  isLabAbove  label       tooltip
        'config.training',  fieldName,  'text', { 'array' },    [1 0],  false,      fieldName,  '';
    }, 'VariableNames', this.GUI.be.paramPanConfig.Properties.VariableNames);
    % append the new configuration to the table and update the row names using the ids
    this.GUI.be.paramPanConfig = [this.GUI.be.paramPanConfig; paramConf];
    this.GUI.be.paramPanConfig.Properties.RowNames = this.GUI.be.paramPanConfig.id;
end;

OCIACreateParamPanelControls(this, 'be');

% if they are still valid, store the enable/disable state of the navigating buttons
if isfield(this.GUI.handles.be, 'prevParams') && ishandle(this.GUI.handles.be.prevParams);
    prevEnableState = get(this.GUI.handles.be.prevParams, 'Enable');
    nextEnableState = get(this.GUI.handles.be.nextParams, 'Enable');
end;
OCIAToggleGUIEnableState(this, 'Behavior', 1);

% if they are still valid, set back the enable/disable state of the navigating buttons
if isfield(this.GUI.handles.be, 'prevParams') && ishandle(this.GUI.handles.be.prevParams);
    set(this.GUI.handles.be.prevParams, 'Enable', prevEnableState);
    set(this.GUI.handles.be.nextParams, 'Enable', nextEnableState);
end;

this.be.configLoaded = true;
set(this.GUI.handles.be.loadConf, 'BackgroundColor', 'green', 'Value', 1);

BEApplyConfig(this);

end
