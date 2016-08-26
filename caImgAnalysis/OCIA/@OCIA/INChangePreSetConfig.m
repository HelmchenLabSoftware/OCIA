function INChangePreSetConfig(this, ~, ~)
% INChangePreSetConfig - [no description]
%
%       INChangePreSetConfig(this, h, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the currently selected configuration
configLabels = get(this.GUI.handles.in.cfg, 'String');
selectedIndex = get(this.GUI.handles.in.cfg, 'Value');
selectedLabel = configLabels{selectedIndex};
configNames = fieldnames(this.in.configs);
unsortedConfigNames = regexprep(regexprep(regexprep(configNames, 'x\d+_', ''), '_', ' '), '0p', '0.');
configName = configNames{strcmp(selectedLabel, unsortedConfigNames)};
curCfg = this.in.configs.(configName);

% update the experiment mode
this.in.expMode = curCfg.expMode;

% update the save name
if isfield(curCfg, [this.in.expMode '_saveName']);
    this.in.([this.in.expMode '_saveName']) = curCfg.([this.in.expMode '_saveName']);
else
    showWarning(this, 'OCIA:INChangePreSetConfig:SaveNameFieldNotFound', 'Intrinsic: "save_name" field not found.');
end;

% go through all main fields
mainFields = [ 'common', this.in.expModes ];
for iMainField = 1 : numel(mainFields);
    mainField = mainFields{iMainField};
    % if main field is not in config, skip
    if ~isfield(curCfg, mainField); continue; end;
    % get the sub-fields of the main field and update each existing value
    fNames = fieldnames(curCfg.(mainField));
    for iField = 1 : numel(fNames);
        this.in.(mainField).(fNames{iField}) = curCfg.(mainField).(fNames{iField});
    end;
end;

% update the experiment mode and the parameter pannel
INChangeExpMode(this, this.in.expMode);

if strcmp(this.in.expMode, 'fourier') && strcmp(this.in.common.stimMode, 'trigIn') && this.in.expRunning;
    this.in.expRunning = false;
    showMessage(this, 'Intrinsic: parameters updated => running interrupted.');
end;
if strcmp(this.in.expMode, 'trial') && strcmp(this.in.common.stimMode, 'trigIn') && this.in.expRunning;
    this.in.expRunning = false;
    showMessage(this, 'Intrinsic: parameters updated => running interrupted.');
end;

end

