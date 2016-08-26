function createNewConfig(configName, modesToAdd, dataModes)
% create a new configuration file for the OCIA

% get the OCIA folder
OCIASrcDir = regexprep(which('OCIA'), '\\', '/');
OCIASrcDir = regexprep(OCIASrcDir, '@OCIA/OCIA.m$', '');

% get the configuration directories
configDir = [OCIASrcDir 'custom/configs/'];
modeConfigDir = [OCIASrcDir 'custom/modes/'];
dataModeConfigDir = [OCIASrcDir 'custom/dataConfigs/'];

% gather the available modes and data modes
modeConfigFiles = dir([modeConfigDir 'OCIA_modeConfig_*.m']);
nModes = numel(modeConfigFiles);
dataModeConfigFiles = dir([dataModeConfigDir 'OCIA_dataConfig_*.m']);
nDataModes = numel(dataModeConfigFiles);
% extract the names
availableModes = arrayfun(@(i)regexprep(modeConfigFiles(i).name, '^OCIA_modeConfig_(\w+)\.m$', '$1'), ...
    1 : nModes, 'UniformOutput', false);
availableDataModes = arrayfun(@(i)regexprep(dataModeConfigFiles(i).name, '^OCIA_dataConfig_(\w+)\.m$', '$1'), ...
    1 : nDataModes, 'UniformOutput', false);

% if no modes or no data modes requested, add all of them
if isempty(modesToAdd); modesToAdd = availableModes; end;
if isempty(dataModes); dataModes = availableDataModes; end;

% open the new config file
newConfigFID = fopen(sprintf('%sOCIA_config_%s.m', configDir, configName), 'w');

% write the headers
fprintf(newConfigFID, ['function this = OCIA_config_%s(this)\n', ...
'%% initialize the requested mode\n', ...
'% defines which modes should be initiated for this instance of OCIA. Should be a N_MODES x 2 cell-array, first column\n', ...
'%   being the mode''s name (''DataWatcher'') and the second the short name (''dw''). This needs to be created before the\n', ...
'%   call to the ''OCIA_config_default'' because that function will actually initialize the different modes.\n', ...
'this.main.modes = { ...\n', ...
'        % mode name         short name\n', ...
'        ''DataWatcher'',      ''dw'';\n', ...
'        ''ROIDrawer'',        ''rd'';\n', ...
'        ''Analyser'',         ''an'';\n', ...
'        ''Behavior'',         ''be'';\n', ...
'        ''JointTracker'',     ''jt'';\n', ...
'    };\n', ...
'\n', ...
'% defines which data "modules" should be appended to the software. Should be a cell-array of strings with one element\n', ...
'%   per data mode. Also needs to be initialized before the call to ''OCIA_config_default''.\n', ...
'this.main.dataModes = { ''img''; ''behav''; ''whisk'' };\n', ...
'%% get the default configuration\n', ...
'configHandle = str2func(''OCIA_config_default'');\n', ...
'this = configHandle(this);\n\n', ...
'%% general parameters\n', ...
'this.main.startFunctionName = ''dataWatcher'';\n', ...
'this.GUI.noGUI = false;\n', ...
'this.GUI.dw.DWFilt = { };\n', ...
'this.GUI.dw.DWWatchTypes = { };\n', ...
'this.GUI.dw.DWSkiptMeta = false;\n', ...
'this.GUI.dw.DWRawOrLocal = ''local'';\n\n', ...
'%%%% - properties: GUI\n', ...
'%% initial position of the main window\n', ...
'this.GUI.pos = [10, 10, 1275, 1000]; \n\n', ...
'%%%% -- properties: general: paths to relevant locations (raw data, ect.)\n', ...
'%% path of the raw data (usually stored on the server)\n', ...
'this.path.rawData = '''';\n', ...
'%% path of the local data\n', ...
'this.path.localData = '''';\n', ...
'%% path where the OCIA related things should be saved (OCIA object itself, data, plots, etc.)\n', ...
'this.path.OCIASave = '''';\n'], configName);

% read in all the necessary mode config files
for iMode = 1 : numel(modesToAdd);
    
    % open the mode config file
    modeConfigFID = fopen(sprintf('%sOCIA_modeConfig_%s.m', modeConfigDir, modesToAdd{iMode}), 'r');
    
    % read first line
    line = fgetl(modeConfigFID);
    % read all lines until the end of the file
    while ~feof(modeConfigFID);
        
        % skip function begining lines
        if ~isempty(regexp(line, '^function', 'once'));
            fgetl(modeConfigFID); % skip next line
            line = fgetl(modeConfigFID); % read next line
            continue;
        end;
        
        % skip function end lines
        if ~isempty(regexp(line, '^end', 'once'));
            line = fgetl(modeConfigFID); % read next line
            continue;
        end;
        
        % skip mode definition parts
        if ~isempty(regexp(line, '^this\.(GUI\.|an\.)?\w+ = struct\(\);', 'once'));
            line = fgetl(modeConfigFID); % read next line
            continue;
        end;
        
        % copy the line to the config file
        fwrite(newConfigFID, regexprep(line, '\\', '\\\\'));
        fprintf(newConfigFID, '\n');
        
        % read next line
        line = fgetl(modeConfigFID);
        
    end;
    
    % close the mode config file
    fclose(modeConfigFID);

end;

% read in all the necessary data mode config files
for iMode = 1 : numel(dataModes);
    
    % open the data mode config file
    modeConfigFID = fopen(sprintf('%sOCIA_dataConfig_%s.m', dataModeConfigDir, dataModes{iMode}), 'r');
    
    % read first line
    line = fgetl(modeConfigFID);
    % read all lines until the end of the file
    while ~feof(modeConfigFID);
        
        % skip function begining lines
        if ~isempty(regexp(line, '^function', 'once'));
            fgetl(modeConfigFID); % skip next line
            line = fgetl(modeConfigFID); % read next line
            continue;
        end;
        
        % skip function end lines
        if ~isempty(regexp(line, '^end', 'once'));
            line = fgetl(modeConfigFID); % read next line
            continue;
        end;
        
        % skip data mode definition parts
        if ~isempty(regexp(line, '^this\.\w+ = struct\(\);', 'once'));
            line = fgetl(modeConfigFID); % read next line
            continue;
        end;
        
        % skip sub-mode definition parts
        if ~isempty(regexp(line, '^this\.an.\w+ = struct\(\);', 'once'));
            line = fgetl(modeConfigFID); % read next line
            continue;
        end;
        
        % skip data hash definition parts
        if ~isempty(regexp(line, '^this\.an.\w+\.dataHash = struct\(\);', 'once'));
            line = fgetl(modeConfigFID); % read next line
            continue;
        end;
        
        % skip irrelevant comments
        if ~isempty(regexp(line, ['^(% define the analysis parameters for this data type|% storage for the cached data', ...
                '|% defines the data storage options)'], 'once'));
            line = fgetl(modeConfigFID); % read next line
            continue;
        end;
        
        % skip data config definition
        if ~isempty(regexp(line, '^this.main.dataConfig', 'once'));
            line = fgetl(modeConfigFID); % read next line
            
            % read all lines until the end of the file
            while ~feof(modeConfigFID) && isempty(regexp(line, ...
                    '^\}, ''VariableNames'', this\.main\.dataConfig\.Properties\.VariableNames\)\];', 'once'));
                line = fgetl(modeConfigFID); % read next line
            end;
            
            line = fgetl(modeConfigFID); % read next line
            
            continue;
        end;
        
        % copy the line to the config file
        fwrite(newConfigFID, regexprep(line, '\\', '\\\\'));
        fprintf(newConfigFID, '\n');
        
        % read next line
        line = fgetl(modeConfigFID);
        
    end;
    
    % close the mode config file
    fclose(modeConfigFID);

end;

% write the last "end"
fprintf(newConfigFID, 'end\n');

% close the config file
fclose(newConfigFID);

end
