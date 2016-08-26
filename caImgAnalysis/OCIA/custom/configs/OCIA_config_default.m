function this = OCIA_config_default(this)
% #OCIA:CONFIG:OCIA_config_default - Calls the default configuration
%
%       this = OCIA_config_default(this)
%
% Initiates the current instance of the OCIA ('this') with the default configuration and returns it.

% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% define some path
currentDir = regexprep(pwd(), '\\', '/');
o('#%s(): currentDir: "%s" ...', mfilename, currentDir, 4, this.verb);

%% -- properties: paths to relevant locations (raw data, ect.)
this.path = struct();
% path of the raw data (usually stored on the server)
this.path.rawData = currentDir;
% path of the local data
this.path.localData = currentDir;
% path where the OCIA related things should be saved (OCIA object itself, data, plots, etc.)
this.path.OCIASave = currentDir;

%% - properties: main
% if the modes do not exist yet or are empty
if ~isfield(this.main, 'modes') || isempty(this.main.modes);    
    % create the modes cell-array with 2 columns: the mode's name and the 2-character short name
    this.main.modes = { ...
        % mode name         short name
        'DataWatcher',      'dw';
        'ROIDrawer',        'rd';
        'Analyser',         'an';
        'Behavior',         'be';
        'Intrinsic',        'in';
        'JointTracker',     'jt';
        'TrialView',        'tv';
    };
    warning('OCIA:NoModesSpecified', 'No modes specified in ''this.main.modes''. Added default list automatically.');
end;

% check if DataWatcher mode exists since it is obligatory
if ~any(strcmp(this.main.modes(:, 1), 'DataWatcher'));
    % add if it does not exist
    this.main.modes = [ {'DataWatcher', 'dw'}; this.main.modes ];
    warning('OCIA:DataWatcherNotIncluded', '"DataWatcher" mode is obligatory for OCIA to run properly. Added it automatically.');
end;

% if the data modes do not exist yet or are empty
if ~isfield(this.main, 'dataModes') || isempty(this.main.dataModes);
    % defines which data "modules" should be appended to the software. Should be a cell-array of strings with one element
    %   per data mode
    this.main.dataModes = { 'img'; 'behav'; };  
    warning('OCIA:NoDataModesSpecified', 'No data modes specified in ''this.main.dataModes''. Added default list automatically.');  
end;

% defines the data saving options for each "saving type" as a table with 5 columns:
%   { rowType, id, shortLabel, label, saveFormat }
this.main.dataConfig = cell2table(cell(0, 6), 'VariableNames', { 'rowType', 'id', 'shortLabel', 'label', 'saveFormat', 'defaultOn' });

%% - properties: GUI
% initial position of the main window
% this.GUI.pos = [345, 285, 1220, 805]; % left screen
this.GUI.pos = [181, 22, 1483, 979]; % presentation and figures
% this.GUI.pos = [120, -25, 1200, 700]; % presentation and figures
% this.GUI.pos = [1950, 175, 1220, 805]; % right screen
% option to hide or show any display/window/GUI
this.GUI.noGUI = false;
% properties of GUI elements to save
this.GUI.toSaveProps = { 'String', 'Value' };
% main window's handle (GUI figure)
this.GUI.figH = [];
% structure containing all GUI components' handle
this.GUI.handles = [];
% string to add to saved GUI handle properties in the GUIState structure to identify them as handle
this.GUI.saveHandleTag = '__HANDLE';

%% - mode configurations
% apply DataWatcher configuration
configHandle = str2func('OCIA_modeConfig_datawatcher');
this = configHandle(this);

% apply different modes' configuration
for iMode = 1 : size(this.main.modes, 1);
    
    % get the configuration function's name and check if it exists
    modeName = lower(this.main.modes{iMode, 1});
    
    % skip DataWatcher mode as it was already processed
    if strcmp(modeName, 'datawatcher'); continue; end;
    
    funcName = sprintf('OCIA_modeConfig_%s', modeName);
    if ~exist(funcName, 'file');
        showWarning(this, 'OCIA:ConfigFunctionNotFound', ...
            sprintf('Configuration function "%s" not found, skipping.', funcName));
        continue;
    end;
    
    % call the configuration function with an error catching block
    try
        OCIAConfigFun = str2func(funcName);
        newThis = OCIAConfigFun(this);
        if ~isempty(newThis); this = newThis; end;
    catch err;
        showWarning(this, 'OCIA:ConfigFunctionError', ...
            sprintf('Configuration function "%s" run into an error: %s (%s)\n%s.', ...
            funcName, err.message, err.identifier, getStackText(err)));
    end;
    
end;

%% data mode configurations
% apply different data modes' configuration
for iMode = 1 : numel(this.main.dataModes);
    % call the data save configuration function
    modeName = lower(this.main.dataModes{iMode});
    [~, newThis] = OCIAGetCallCustomFile(this, 'dataConfig', modeName, 1, { this }, 0);
    if ~isempty(newThis); this = newThis; end;
    
end;
if ~isempty(this.main.dataConfig);
    this.main.dataConfig.Properties.RowNames = this.main.dataConfig.id; % make the ID be the row names
end;

end
