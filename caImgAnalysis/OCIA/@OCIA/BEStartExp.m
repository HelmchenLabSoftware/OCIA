function BEStartExp(this, ~, ~)
% BEStartExp - [no description]
%
%       BEStartExp(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if this.be.isRunning;
    showWarning(this, 'OCIA:Behavior:CannotStartAlreadyRunning', ...
        'Cannot start because experiment is already running.');
    set(this.GUI.handles.be.pauseExp, 'BackgroundColor', 'red', 'Value', 0);
    set(this.GUI.handles.be.startExp, 'BackgroundColor', 'red', 'Value', 0);
    return;
end;

% if experiment was previously aborted, re-initialize it
if this.be.isToReset;
    showMessage(this, 'Re-initializing experiment ...', 'yellow');
    BEInitExp(this);
end;

if ~this.be.configLoaded;
    showWarning(this, 'OCIA:Behavior:InitExp:configNotLoaded', ...
        'Cannot initialize experiment because config is not loaded.');
    set(this.GUI.handles.be.pauseExp, 'BackgroundColor', 'red', 'Value', 0);
    set(this.GUI.handles.be.startExp, 'BackgroundColor', 'red', 'Value', 0);
    return;
end;
if isempty(this.be.animalID);
    showWarning(this, 'OCIA:Behavior:InitExp:NoMouseId', ...
        'Cannot initialize experiment because there is no animalID.');
    set(this.GUI.handles.be.pauseExp, 'BackgroundColor', 'red', 'Value', 0);
    set(this.GUI.handles.be.startExp, 'BackgroundColor', 'red', 'Value', 0);
    return;
end;
if ~this.be.hw.connected;
    showWarning(this, 'OCIA:Behavior:InitExp:HardwareDisconnected', ...
        'Cannot initialize experiment because hardware is disconnected.');
    set(this.GUI.handles.be.pauseExp, 'BackgroundColor', 'red', 'Value', 0);
    set(this.GUI.handles.be.startExp, 'BackgroundColor', 'red', 'Value', 0);
    return;
end;

% check which row is selected
jTable = getJTable(this, 'BEConfTable');
this.GUI.be.selConfigRow = jTable.getSelectedRows() + 1;
if isempty(this.GUI.be.selConfigRow);
    showWarning(this, 'OCIA:Behavior:startExp:NoMouseIdSelected', ...
        'Cannot load config because no mouse ID is selected.');
    set(this.GUI.handles.be.loadConf, 'BackgroundColor', 'red', 'Value', 0);
    return;
end;
configCell = this.be.configs.animals;
animalID = configCell{this.GUI.be.selConfigRow, 1};
taskType = configCell{this.GUI.be.selConfigRow, 2};
phase = configCell{this.GUI.be.selConfigRow, 3};

if ~strcmp(animalID, this.be.animalID) || ~strcmp(taskType, this.be.taskType) || ~strcmp(phase, this.be.phase);
    showWarning(this, 'OCIA:Behavior:startExp:RowSelectionIncomplete', ...
        'Cannot start experiment because row selection is weird.');
    set(this.GUI.handles.be.loadConf, 'BackgroundColor', 'red', 'Value', 0);
    return;
end;

% make sure config is loaded
BELoadConfig(this);

this.be.iTrial = 1;
this.be.isRunning = true;
this.be.expStartTime = [];
this.be.GUI.loopBehavTimer = [];

set(this.GUI.handles.be.pauseExp, 'BackgroundColor', 'red', 'Value', 0);
set(this.GUI.handles.be.startExp, 'BackgroundColor', 'green', 'Value', 1);

end

