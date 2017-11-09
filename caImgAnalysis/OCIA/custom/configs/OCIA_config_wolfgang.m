function this = OCIA_config_wolfgang(this)
% OCIA_config_wolfgang - "wolfgang" OCIA configuration file
%
%       this = OCIA('wolfgang')
%
% Configuration file for OCIA using the "wolfgang" configuration. This function should not be called directly
%   but rather using the "this = OCIA('wolfgang');" syntax to launch the software with this configuration.
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)


%%


% CA DATA: fix bug and test batch processing
% try to automatically find the flyback point using correlation between

% TODO: batch cropping
% - reset joints button in red
% - better error message for when nothing happens
% - define an additional parameter saying if a virtual joint should be tracked / matched with gaussian template
% - optimize interface / mechanic for auto tracking all joints and just correct the ones that failed
% - try to detect the edges of the arm and apply some exponential and check for a contrast change => help removing bad
% wrist joint tracking (add weighting option)
% - example output file to produce this


%%

% configure modes
this.main.modes = { 'DataWatcher', 'dw'; 'JointTracker', 'jt' };

% defines which data "modules" should be appended to the software. Should be a cell-array of strings with one element
%   per data mode. Also needs to be initialized before the call to 'OCIA_config_default'.
this.main.dataModes = { 'img' };

% get the default configuration
configHandle = str2func('OCIA_config_default');
this = configHandle(this);

%% - properties: JointTracker
% joints as a cell-array with one row per joint and 11 columns: 
%   { 1: name, 2: is virtual [0/1], 3: bounding box size [pixels], 4: distance to previous and next joint [pixels], 
%       5: flexibility in the distances to the next/previous joint [1 - 3], 6: find joint method, 
%       7: and pre-processing settings, 8: joint size, 9: weighting factor for joint distance,
%       10: weighting factor for gauss template, 11: weighting factor for angle }
% The different methods to find the peaks are : { xcorr_ref, xcorr_gauss, xcorr_comb }
this.jt.jointConfig = {
... % name      Virt.      bounding box                        dist. flex.  ignore          ignore             joint size   dist importance   gaussian weight   lastnumber:ignore       
    'scapula',  0,  [16, 24;   20, 30;   40, 60],   [NaN, 62],  1,      'xcorr_comb',   'smallMoveJoint',       [11 11],        1,              0.5, 0;
    'shoulder', 0,  [19, 20;   24, 25;   48, 50],   [62, 85],   1.5,    'xcorr_comb',   'smallMoveJoint',       [11 11],        1,              0.5, 0;
    'elbow',    1,  [],                             [85, 60],   0,      '',             '',                     [0 0],          0,              1.0, 0;
    'wrist',    0,  [50, 40;   90, 70;   150, 140], [60, 24],   1.2,    'xcorr_comb',   'bigMoveWristJoint',    [9 7],          0.5,            1.0, 0;
    'MCP',      1,  [50, 34;   80, 60;   130, 120], [24, 29],   1.2,    'xcorr_comb',   'bigMoveJoint',         [7 5],          0.5,            2.0, 0;
    'finger',   0,  [50, 34;   80, 60;   130, 120], [29, NaN],  1.3,    'xcorr_comb',   'bigMoveJoint',         [7 7],          0.5,            2.0, 0;
    
};
this.jt.nJoints = size(this.jt.jointConfig, 1);
% order in which joints should be processed
this.jt.jointProcessOrder = [2 1 4 5 6 3];

%% display settings for each column of the DataWatcher's table
this.GUI.dw.tableDisplay = cell2table({ ...
...     id              label               order   width   visible     description
        'rowNum',       'Row',              01,     0.130,  true,       'Row number'; ...
        'day',          'Day',              02,     0.160,  true,       'Day'; ...
        'rowType',      'Row type',         03,     0.075,  true,       'Row type or data type'; ...
        'time',         'Time',             04,     0.085,  true,       'Time'; ...
        'runNum',       'Run number',       05,     0.140,  true,       'Run number (or trial number)'; ...
        'dim',          'Dimension',        06,     0.210,  true,       'Dimension of the data'; ...
        'data',         'Data',             07,     0.260,  true,       'Data associated with this row'; ...
        'frameRate',    'Frame rate',       08,     0.130,  true,       'Imaging frame rate in Hz'; ...
        'comments',     'Comments',         09,     0.210,  true,       'Comments'; ...
        'path',         'Path',             10,     0.500,  false,      'Full path to the folder/file/data'; ...
        'rowID',        'RowID',            11,     0.085,  false,      'Row ID'; ...
...        
    }, 'VariableNames', { 'id', 'label', 'order', 'width', 'visible', 'description' });
this.GUI.dw.tableDisplay.Properties.RowNames = this.GUI.dw.tableDisplay.id; % make the ID be the row names
% store the table IDs for easier referencing
this.dw.tableIDs = this.GUI.dw.tableDisplay.id;
% cell-array holding the current data set (from the watch folder's content), displayed in a big table
this.dw.table = cell(300, numel(this.dw.tableIDs));
% defines the maximum number of frames to load for the preview loading type
this.dw.previewNMaxFrameToLoad = 3;
% tells with which "path" configuration to save the HDF5 data
this.dw.HDF5.savePathConfig = { 'animal', 'day' };
% list of buttons that are available to further process the data, as a table array with 4 columns:
%   { ID, label, tag, tooltip }
this.GUI.dw.processButtons = cell2table({ ...
...     id              label               	tag                 tooltip
        'trackMovies',  'trackMovies',          'DWTrackMovies',    'Track joints for selected row', ...
}, 'VariableNames', { 'id', 'label', 'tag', 'tooltip' });
this.GUI.dw.processButtons.Properties.RowNames = this.GUI.dw.processButtons.id; % make the ID be the row names

% path of the raw data (usually stored on the server)
this.path.rawData = '/data/JointTracker/';
% this.path.rawData = 'W:/RawData/';
% path of the local data
this.path.localData = '/data/JointTracker/';
% this.path.localData = 'F:/RawData/Wolfgang/';
% path where the OCIA related things should be saved (OCIA object itself, data, plots, etc.)
this.path.OCIASave = '/data/JointTracker/';
% this.path.OCIASave = 'E:/Analysis/Wolfgang/';

%% - properties: GUI
[~, computerName] = system('hostname');
computerName = matlab.lang.makeValidName(computerName);
computerName = regexprep(computerName, '_local$', '');
computerName = regexprep(computerName, '^vpn_global_dhcp.+', 'OoSIS');
computerName = regexprep(computerName, 'id_als_docking_\d+_ethz_ch', 'OoSIS');

% computer-dependent settings
% switch computerName;
%     case 'OoSIS';
        
        % window position
%         this.GUI.pos = [1950, 175, 1220, 805];
        this.GUI.pos = [5, 5, 1230, 845];
        
        % debug plot windows
        this.GUI.jt.debugFigPos = [1465, 395, 880, 675];

        % start function to run after window is created
        this.main.startFunctionName = 'jointtracker';
        
        % movie path
        this.jt.frameRate = 100;
%         this.path.moviePath = '/data/JointTracker/2017.02.10_12_08_31_Exc.avi';
%         this.path.moviePath = '/data/JointTracker/2017.02.10_12_08_31_Exc_cropped.avi';
%         this.path.moviePath = '/data/JointTracker/2017.02.10_13_32_55_Exc.avi';
        this.path.moviePath = '/data/JointTracker/2017.02.10_13_32_55_Exc_cropped.avi';
        
        % cropping options
%         this.jt.doCroppingStep = 1;
%         this.jt.cropRect = [];

%         this.jt.doCroppingStep = 1;
%         this.jt.cropRect = [295, 222, 665, 395]; % 2017.02.10_12_08_31
%         this.jt.cropRect = [274, 211, 649, 454]; % 2017.02.10_13_32_55

        this.jt.doCroppingStep = 0;
        this.jt.cropRect = [];
        
%         this.jt.timeCrop = [];
        this.jt.timeCrop = [400, 700];
        
        %% filters
%         this.GUI.dw.DWWatchTypes = { 'animal', 'day' };
% %         this.GUI.dw.DWWatchTypes = { };
%         
% %         this.GUI.dw.DWFilt = { };
% %         this.GUI.dw.DWFilt = { '-', '2015_12_10' };
%         this.GUI.dw.DWFilt = { 'mou_bl_160105_03', '2016_03_18' };
%         this.GUI.dw.DWFilt = { '-', '-' };
        
% end;


end
