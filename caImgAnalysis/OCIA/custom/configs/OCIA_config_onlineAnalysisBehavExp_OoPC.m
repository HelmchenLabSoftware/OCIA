function this = OCIA_config_onlineAnalysisBehavExp_OoPC(this)
% OCIA_config_onlineAnalysisBehavExp_OoPC - "onlineAnalysisBehavExp_OoPC" OCIA configuration file
%
%       this = OCIA('onlineAnalysisBehavExp_OoPC')
%
% Configuration file for OCIA using the "onlineAnalysisBehavExp_OoPC" configuration. This function should not be called directly
%   but rather using the "this = OCIA('onlineAnalysisBehavExp_OoPC');" syntax to launch the software with this configuration.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% initialize the requested modes
this.main.modes = { ...
        % mode name         short name
        'DataWatcher',      'dw';
        'ROIDrawer',        'rd';
        'Analyser',         'an';
    };
this.main.dataModes = { 'img'; 'behav'; };

% get the default configuration
configHandle = str2func('OCIA_config_default');
this = configHandle(this);

%% - input parameters
this.main.startFunctionName = 'default';

this.GUI.noGUI = false;
this.GUI.dw.DWFilt = { 'mou_bl_000000_01' };
% this.GUI.dw.DWWatchTypes = { };
this.GUI.dw.DWWatchTypes = 'all';
% this.GUI.dw.DWWatchTypes = { 'animal', 'day' };
% this.GUI.dw.DWWatchTypes = { 'animal', 'day', 'behav' };
% this.GUI.dw.DWWatchTypes = { 'animal', 'day', 'spot', 'img', 'notebook', 'roiset' };
% this.GUI.dw.DWWatchTypes = 'all';
this.GUI.dw.DWSkiptMeta = false;
this.GUI.dw.DWKeepTable = false;
this.GUI.dw.DWRawOrLocal = 'local';

%% - properties: GUI
% initial position of the main window
this.GUI.pos = [11, 254, 1900, 797]; % fullscreen
% this.GUI.pos = [7, 310, 870, 486];

%% - properties: general
% verbosity, number telling how much debugging output should be printed out. The higher the more verbose.
this.verb = 2;

%% -- properties: general: paths to relevant locations (raw data, ect.)
% path of the raw data (usually stored on the server)
this.path.rawData = 'D:/Users/BaL/PhD/RawData/1502_chronic/';
% path of the local data
this.path.localData = 'D:/Users/BaL/PhD/RawData/1502_chronic/';
% path where the OCIA related things should be saved (OCIA object itself, data, plots, etc.)
this.path.OCIASave = 'D:/Users/BaL/PhD/Analysis/1502_chronic/';

%% -- properties: specifics

this.dw.onlineAnalysisRefDay = '2015_03_05';
this.dw.onlineAnalysisCurrDay = '2015_03_06';
% this.dw.onlineAnalysisCurrDay = datestr(now, 'yyyy_mm_dd');
this.dw.onlineAnalysisPrevDay = datestr(unix2dn(dn2unix(datenum(this.dw.onlineAnalysisCurrDay, 'yyyy_mm_dd')) ...
    - 24 * 60 * 60 * 1000), 'yyyy_mm_dd');

% additional remote folder's path where the online analysis data will be
this.path.remoteData = 'D:/Users/BaL/PhD/RawData/1502_chronic/onlineAnalysisFolder/';

% name of the function that does the online analysis
this.dw.onlineAnalysisFunctionName = 'behavExp';

% list of buttons that are available to further process the data, as a table array with 4 columns: { ID, label, tag, 
%   tooltip }
this.GUI.dw.processButtons = cell2table({ ...
...     id              label               	tag                 tooltip
        'drawROIs',     'Draw ROIs',            'DWDrawROIs',       'Draw Regions Of Interest for selected rows';
        'processRows',  'Process',              'DWProc',           'Process selected rows with the processing steps from the list';
        'onlineAnalysis', 'Online analysis',    'DWOnlineAnalysis', 'Update the table constantly in a loop and do some processing with the rows';
        'onlineAnalysisSetRef', 'OA - set ref.', 'DWOnlineAnalysisSetRef', 'Set selected rows as reference.';
        'onlineAnalysisProcRows', 'OA - proc.', 'DWOnlineAnalysisProc', 'Process selected rows.';
}, 'VariableNames', { 'id', 'label', 'tag', 'tooltip' });
this.GUI.dw.processButtons.Properties.RowNames = this.GUI.dw.processButtons.id; % make the ID be the row names

% display settings for each column of the DataWatcher's table
this.GUI.dw.tableDisplay = cell2table({ ...
...     id              label               width   visible     description
        'rowNum',       'Row',              0.022,  true,       'Row number'; ...
        'loc',          'Location',         0.025,  true,       'Location (online/local)'; ...
        'animal',       'Animal',           0.080,  true,       'Animal ID'; ...
        'day',          'Day',              0.054,  true,       'Day'; ...
        'spot',         'Spot',             0.031,  true,       'Spot ID'; ...
        'time',         'Time',             0.048,  true,       'Time'; ...
        'rowType',      'Row type',         0.058,  true,       'Row type or data type (imaging, behavior, ROISet, etc.)'; ...
        'runType',      'Run type',         0.040,  true,       'Run type (which stimulus was used, etc.)'; ...
        'runNum',       'Run number',       0.020,  true,       'Run number (or trial number)'; ...
        'behav',        'Behavior ID',      0.050,  true,       'Behavior''s ID'; ...
        'ROISet',       'ROISet ID',        0.050,  true,       'ROISet''s ID'; ...
        'dim',          'Dimension',        0.058,  true,       'Dimension of the data'; ...
        'data',         'Data',             0.100,  true,       'Data associated with this row'; ...
        'imType',       'Image type',       0.033,  false,      'Image type (movie, frame, stack, etc.)'; ...
        'laserInt',     'Laser intensity',  0.020,  true,       'Laser intensity in percent'; ...
        'zoom',         'Zoom factor',      0.013,  true,       'Zoom factor'; ...
        'isRef',        'Reference',        0.020,  true,       'Reference row tag'; ...
        'corrToRef',    'Corr.',            0.070,  true,       'X/Y/Z shift compared to reference'; ...
        'shift',        'Shift',            0.042,  true,       'X/Y/Z shift compared to reference'; ...
        'bleachRef',    'Bleach Ref.',      0.050,  true,       'Bleaching compared to reference'; ...
        'bleachInner',  'Bleach In.',       0.055,  true,       'Bleaching over the course of the movie'; ...
        'frameRate',    'Frame rate',       0.020,  false,      'Imaging frame rate'; ...
        'zStep',        'Z-step',           0.015,  false,      'Z-step for the stacks'; ...
        'comments',     'Comments',         0.100,  true,       'Comments'; ...
        'path',         'Path',             0.500,  false,      'Full path to the folder/file/data'; ...
        'rowID',        'RowID',            0.085,  false,      'Row ID'; ...
...        
    }, 'VariableNames', { 'id', 'label', 'width', 'visible', 'description' });
this.GUI.dw.tableDisplay.Properties.RowNames = this.GUI.dw.tableDisplay.id; % make the ID be the row names

end
