function this = OCIA_config_alexFibreTracking(this)
% OCIA_config_alexFibreTracking - "alexFibreTracking" OCIA configuration file
%
%       this = OCIA('alexFibreTracking')
%
% Configuration file for OCIA using the "alexFibreTracking" configuration. This function should not be called directly
%   but rather using the "this = OCIA('alexFibreTracking');" syntax to launch the software with this configuration.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

this.main.modes = { 'DataWatcher', 'dw'; 'JointTracker', 'jt' };

% get the default configuration
configHandle = str2func('OCIA_config_default');
this = configHandle(this);

this.data = struct();

this.main.startFunctionName = 'jointtracker';
this.dw.preProcessFunctionName = 'jointtracker';

% path of the raw data (usually stored on the server)
this.path.rawData = 'W:/Neurophysiology/RawData/Alexander_vanderBourg/Whisker Stimulation/fiberControlExperiments/';
% path of the local data
this.path.localData = 'D:/data/juvenileWhiskerStim/fiberImaging/';
% path where the OCIA related things should be saved (OCIA object itself, data, plots, etc.)
this.path.OCIASave = 'D:/data/juvenileWhiskerStim/fiberImaging/';

% initial position of the main window
this.GUI.pos = [345, 185, 1220, 805]; % default

% mini-hack: check computerID and eventually change things
[~, rawComputerID] = system('hostname');
if strcmp(genvarname(rawComputerID), 'OoPC');
    this.path.localData = 'D:/Users/BaL/PhD/RawData/Wolfgang/';
    this.path.OCIASave = 'D:/Users/BaL/PhD/Analysis/Wolfgang/';
    this.GUI.pos = [330, 185, 1220, 805];
elseif strcmp(genvarname(rawComputerID), 'Oo0x2Elocal');
    this.path.localData = '/Users/BaL/Documents/RawData/Wolfgang/';
    this.path.OCIASave = '/Users/BaL/Documents/Analysis/Wolfgang/';
    this.GUI.pos = [330, 185, 1220, 705];
elseif strcmp(genvarname(rawComputerID), 'HIFOWSH64-01');
    this.path.localData = 'D:/data/juvenileWhiskerStim/fiberImaging/';
    this.path.OCIASave = 'D:/data/juvenileWhiskerStim/fiberImaging/';
    this.GUI.pos = [330, 185, 1220, 705];
end;

this.GUI.dw.DWFilt = { 'axial', 'free' };
% this.GUI.dw.DWFilt = { '2013_09_10', '00_10_52' };
this.GUI.dw.DWWatchTypes = 'all';
this.GUI.dw.DWSkiptMeta = false;
this.GUI.dw.DWRawOrLocal = 'local';

%% -- properties: DataWatcher: WatchTypes
% defines the aspect of the filtering panel: cell array with nFilt lines and 
%   5 columns: { filter name, GUI type, GUI width and DataWatcher table's column column where to apply the filter, supports range }
this.GUI.dw.filtElems = { 
    'direction',      'dropdown',     1,    1,  false;
    'config',     'dropdown',    1,    2,  false;
};


% specifies which further processing step buttons are available as a cell array with 4 columns: { ID, label, tag, 
%   tooltip }
this.GUI.dw.processButtons = { ...
    'fiberMovies',  'Fiber TIIIIMMEEE !!!',       'DWFiberMovies',    'Track fiber movies of selected rows';
};

%% -- properties: DataWatcher : watch types
% file/folder types that can be processed and will appear in the DataWatcher's table with their regexp pattern, stored as a 
%   cell-array with 6 columns: { ID, display name, parent folder, visible in GUI, tooltip text, regular expression pattern }
this.dw.watchTypes = cell2table({
    'direction',          'Direction',          [],         true,   'Direction folder',               '^(axial)|(deflection)|(combined)';
    'config',       'Config',       'direction',      true,   'Config folder',            '^(free)|(glued)|(whisker)',;
    'fiber',       'Data Folder', 'config',   true,  'Data folder',              '^(?<direction>[ADC])(?<amplitude>[HL])(?<gluestate>G?)(?<viewangle>S?)(?<trial>\d+)';
}, 'VariableNames', { 'id', 'label', 'parent', 'visible', 'tooltip', 'pattern' });


%% -- properties: DataWatcher : watch type file patterns
% file patterns for files inside "watchType" folders (these are kind of "sub-watchTypes")
this.dw.watchTypeFilePatterns = struct();

%% -- properties: DataWatcher : data configuration
% defines which data "modules" should be appended to the software
this.main.dataModes = { };
% defines the data saving options for each "type" of saving as a cell-array with 3 columns: { ID, label, tooltip text }
this.main.dataConfig = { ...
    'GUI',      'GUI',              'Save / load the GUI (table, checkboxes'' values, etc.)';
    'raw',      'Raw data',         'Save / load the raw data';
    'preProc',  'Pre-proc. data',   'Save / load the pre-processed data';
};

% apply data configuration
configHandle = str2func('OCIA_modeConfig_data');
this = configHandle(this);

%% - properties: DataWatcher : filter IDs
% define the "IDs" field for each drop-down DataWatcher filter element
dropDownListFilterNames = this.GUI.dw.filtElems(strcmp(this.GUI.dw.filtElems(:, 2), 'dropdown'), 1);
for iName = 1 : numel(dropDownListFilterNames);
    filtName = dropDownListFilterNames{iName}; % get the filter name
    % create a list with only a dash element, which corresponds to no filtering
    this.dw.([filtName 'IDs']) = {'-'};
end;

%% - properties: JointTracker
% joints as a cell-array with one row per joint and 8 columns: 
%   { 1: name, 2: is virtual [0/1], 3: window size [pixels], 4: distance to previous and next joint [pixels], 
%       5: flexibility in the distances to the next/previous joint [1 - 3], 6: find joint method, 
%       7: and pre-processing settings, 8: joint size }
% The different methods to find the peaks are : { xcorr_ref, xcorr_gauss, xcorr_comb }




this.jt.jointConfig = {
    
    'longitudinal',  0,  [25, 25;   20, 20;   40, 60],   [NaN, 120],  1,      'xcorr_comb',   'smallMoveJoint',       [11 11];
    'crossing',      0,  [25, 25;   20, 20;   40, 60],   [NaN, 120],  1,      'xcorr_comb',   'smallMoveJoint',       [11 11];  %                          [120, 120],  0,      '',             '',                     [0 0];
    'transversal',   0,  [40, 40;   20, 20;   40, 60],   [120, NaN],  1,      'xcorr_comb',   'smallMoveJoint',       [11 11];
    
};

this.jt.nJoints = size(this.jt.jointConfig, 1);
% order in which joints should be processed
this.jt.jointProcessOrder = [1 2 3];


end
