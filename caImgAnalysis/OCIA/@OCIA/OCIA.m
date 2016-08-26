classdef OCIA < handle
% OCIA - Online Calcium Imaging Assistant
%
%       this = OCIA()
%       this = OCIA(configName)
%       this = OCIA(configName, DWFilt)
%
% Returns an OCIA object 'this', using the configuration file specified by 'configName' using the syntax
%   "OCIA_config_[configName].m". If no configuration is specified, "OCIA_config_default.m" is used. Starting filters
%   for the DataWatcher can be specified using the 'DWFilt', either as a string ('all', etc.) or cell-array of strings
%   ( {'animalID1', '2014_10_30', 'spot03', ... } ). The file 'OCIA_config_generic' contains all the parameters that
%   can be changed in a custom config file.

%       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       % Originally created on           08 / 10 / 2013 %
%       % Modified to v2.0 on             20 / 12 / 2013 %
%       % Modified to v3.0 on             21 / 02 / 2014 %
%       % Modified to v4.0 on             19 / 06 / 2014 %
%       % Modified to v5.0 on             15 / 09 / 2014 %
%       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)


%% TODO list
%{

- General
 -- add the possibility to have a type of folder in multiple locations (e.g. parent of imgData could be spot OR day)
 -- frame jitter, motion correction and motion detection should be independent of a ROISet
 -- OCIA_config_default should not initiate the default config itself but call an initiator function "this =
    initDefault(this)" or something otherwise the names are confusing
 -- add icons to buttons for easier recognition
 -- pre-processing GUI: uipanel with options for nFrameSkip(default=0)/fShift/fJitt/moCorr/moDet
    options as checkboxes, and a "pre-process rows" button (ANPreProcRows). DWLoad('prev') should do none
    of these corrections, except frameShift and frameSkip.
    Add a display fig checkbox linked to the doPlots of the pre-processing functions.
 -- save load modularity:
  --- make the GUI dynamic for the saving options, based on the data's field and configuration
  --- adapt the saving code so that it saves the right things at the right place
  --- fix the save/load/reset options
 -- check that flushdata works properly

- DataWatcher
 -- add a "delete rows" function (hides the unwanted rows from the DataWatcher), also useful for the imagingWatcher mode
 -- intrinsic imaging: access binary file content, show vessels tif files,
    eventually overlap them with expression image using stiching algorithm
 -- behavior movie: read the video with 'video2mat.m' and eventually match frames to trials
 -- small thumbnail of the currently selected row(s) also for other data types (behavior, intrinsic, behavMovie)
  --- requires frame grouping (à la imageJ ...)
 -- only load imaging data once from the DataWatcher's table and then re-use it for analysis and ROI drawing
 -- enable the "real" analysis pipeline support : load imaging data files (.bin)(HDF5?)
 -- implement GUI items/config file for analysis parameters
NO -- add a load metadata button to avoid re-processing all folders just for the metadata
NO -- make the loaded rows' background green to show the data is loaded
NO -- store where each behavior/data file was found and dont reload it if not necessary

- ImagingWatcher
 -- create a new imaging assistant mode or extend the data-watcher to help with online analysis of the imaging
  --- could be on a different computer/matlab session for lower CPU on imaging computer and
      eventually parallel computing for faster loading/processing
 -- features:
  --- loading last recorded data
  --- "quick" ROIDrawing (semi-auto)
  --- "quick" DRR extract
  --- bleaching quantifier
  --- previous days data and metadata (laser, depth, location, surface image, etc.)

- ROIDrawer
 -- modularity in ROISet saving location
 -- bug: remove old position callback in RDRenameROI
 -- channel selection for ROI drawing, gray scale image of one channel
 -- move all ROIs with small arrow GUI pushbuttons <- ^ ->
 -- implement an semi-automatic segmentation tool based on cell centers and ring/filled cell body detection
 -- cell identity labeling tool

- Analyser
 -- implement a feature of analysing whole day/whole mice with analysRow button and watchType of only day or only animal
 -- resizing of the whole panel bug, probably when saving (or plotting?) plots
 -- enable the "real" analysis pipeline support (load imaging data files (HDF5?))
 -- check for colorbar plot saving (resizing issue)
 -- check for time-consuming sem calculation problem
 -- add plots for several mice
 -- implement a bleaching quantifier over multiple runs
 -- fix the colorbar saving problem
 -- fix the colormap problem
 -- fix the analyser plotting ROISet mismatch/non-unique problem
 -- when loading data in 'full' mode that was already loaded in 'prev', skip re-loading of 'prev' frames

- Behavior
 -- check sound amplitude (SPL) *randomization*
 -- fix licking detection or switch to lick rate
 -- implement *alternative* detection system: lick rate
 -- introduce a configuration editor or GUI items for mainConf.mat elements
 -- save threshold and rewDur for each trial
 -- perf analysis: exclude first 3-10 trials + non-responsive regions
 -- auto-connect behavior box with COM port communication

- JointTracker
 -- add coordinates display on mouse move
 -- load X frames until memory is full and then just load frames on the fly while changing frames
 -- when doing the sliding average, remove the existing frames and store them in the temp and then put it back
 -- re-process on the fly the subsequent joints when placing a joint (when placing wrist, re-find the MCP)
 -- crop function
 -- image pre-processing not everywhere but defined by ROI
 -- iJoint and iJointType from selection listbox should not be single values but must be arrays (multiple joint
    manipulation)
 -- prediction reaffinement
  --- define an "area mask" for each joint (or each group of joints), using imfreehand, to constraint their position
  --- use angles and joint distances to constraint the position of the joints
  --- use field flow technique to predict where the joint will move
  --- use correlation dip to change bounding box size (with a minimal box size setting)
 -- improve debug plot display so that one can actually see what is going on (nJoints x nProcessSteps image with labeld axes)
 -- create a progress bar to show how far we are and how is each frame annotated (manual, semi-auto validated, semi-auto not yet checked, etc.)
 -- correlation frame-to-frame or frame-wise only on the bounding boxes
 -- base frames pre-processing for better computer and/or manual annotation
  --- subtract sliding window avg image
  --- flatfield
  --- contrast enhancement
 -- base frames pre-processing might also only be applied to parts of the frame (like the sliding average only on the
    lower part of the frame)
 -- post-hoc evaluation method to get which joints are misplaced, based on:
  --- interpolation of the data points from next and previous joint coordinate ('outlier' detection)
  --- skelton distances
  --- angle-change vs frame-to-frame correlation
 -- post-hoc refinement of the match using smaller bounding box
 -- computer vision algorithms / ideas
 
%}

%% properties
properties

    % verbosity: number telling how much output should be printed out. The higher the more verbose.
    verb = 2;
    % general parameters: version number, start function name, modes, etc.
    main = struct( ...
...     software version
        'version',                  '5.1.10', ...
...     start function name
        'startFunctionName',        'default', ...
...     "modules" of the software that need to be included in the current instance
        'modes',                    {{ ...
                                        % mode name         short name
                                        'DataWatcher',      'dw';
                                        'ROIDrawer',        'rd';
                                        'Analyser',         'an';
                                        'Behavior',         'be';
                                        'Intrinsic',        'in';
                                        'JointTracker',     'jt';
                                        'TrialView',        'tv';
                                    }}, ...
...     data types/modes that need to be included in the current instance
        'dataModes',                {{ 'img', 'behav' }}, ...
...     defines whether to show or hide the stack trace upon throwing a warning with the "#showWarning" method
        'showWarningStackTraces',   false ...
    );
    
    % paths used by the OCIA
    path = struct();
    
    % GUI related elements
    GUI = struct( 'noGUI', false );
    
    % - Data storage mode
    data = struct();
    
    % - DataWatcher mode
    dw = struct();
    % - ROIDrawer mode
    rd = struct();
    % - Analyser mode
    an = struct();
    % - Behavior mode
    be = struct();
    % - Intrinsic mode
    in = struct();
    % - JointTracker mode
    jt = struct();
    % - Discriminator mode
    di = struct();
    % - Discriminator mode
    tv = struct();

end

%% methods - public
methods

%% - #OCIA - constructor
function this = OCIA(varargin)
% OCIA - Constructor
%
%       this = OCIA()
%       this = OCIA(configName)
%       this = OCIA(configName, DWFilt)
%       this = OCIA(configName, DWFilt, startFunctionName)
%
% Returns an OCIA object 'this', using the configuration file specified by 'configName' using the syntax
%   "OCIA_config_[configName].m". If no configuration is specified, "OCIA_config_default" is used. Starting filters
%   for the DataWatcher can be specified using the 'DWFilt', either as a string ('all', etc.) or cell-array of strings
%   ( {'animalID1', '2014_10_30', 'spot03', ... } ). The file 'OCIA_config_generic' contains all the parameters that
%   can be changed in a custom config file. Optional 'startFunctionName' string can be provided.

% Order of function calls for the creation of the object:
%   - parsing inputs ('configName' and 'DWFilt')
%   - call of the config specified by 'configName' (or 'default' if none provided)
%       - first, the "modes" that need to be included in the OCIA should be selected in the "this.main.modes", as a
%           N_MODES x 2 cell-array of strings, with first column being the mode's name ('DataWatcher') and the second
%           column the short name ('dw'). This needs to be done before the call to the 'OCIA_config_default' because
%           that function initializes the different modes.
%       - the "data modes" that need to be included in the OCIA should also be selected in the "this.main.dataModes",
%           as a cell-array of strings before the call to the 'OCIA_config_default' for the same reasons as above.
%       - then, 'OCIA_config_default.m' is called. It initiates the OCIA object ('this') with default configuration
%           values to start OCIA:
%           - path (local, raw, ...)
%           - modes (in case not initiated or dataWatcher mode not included)
%           - GUI variables (window position, etc.)
%           - initiate the different modes using their custom configuration functions: 
%               'OCIA_modeConfig_[modeName].m'. These will initiate each mode with the default values for the
%               variables needed to run those modes. For example in DataWatcher mode, the table's display, etc.
%           - initiate the different data modes using their custom configuration functions:
%               'OCIA_dataConfig_[dataModeName].m'. These will initiate the 'this.main.dataConfig' cell-array which
%               describes what kind of data types need to be used/stored. These custom configuration function
%               can also eventually initiate some variables in the Analyser mode ('this.an.img' or 'this.an.be')
%               for the analysis of those data types (for example 'this.an.img.defaultFrameRate').
%   - initialization of the drop-down IDs of the DataWatcher to an empty dash ('-')
%   - Java path update for Java classes
%   - creation of the window
%       - creation of each panel using the custom 'OCIA_createWindow_[modeName].m' functions
%       - update of drop-down filters IDs based on the GUI values, which are initialized based on the 'DWFilt' input
%           ('OCIA_createWindow_dataWatcher.m' calls 'DWUpdateFiltersAndWatchTypes' to do this)
%   - window is made visible ('OCIA.show')
%   - custom start function is called 'OCIA_startFunction_[functionName].m' based on the config file's setting stored
%       under 'this.main.startFunctionName' 
    
    o('#%s(): constructor ...', mfilename, 4, this.verb);
    o('Launching OCIA v%s ...', this.main.version, 0, this.verb);
    
    %% -- #OCIA: parse inputs and load config file
    o('#%s(): parsing inputs ...', mfilename, 4, this.verb);
    % prepare the input parser object with the requested inputs
    IP = inputParser;
    addOptional(IP,         'configName',         'default',               @ischar);
    addOptional(IP,         'DWFilt',             'empty',                 @(x)isempty(x) || ischar(x) || iscell(x));
    addOptional(IP,         'startFunctionName',  'empty',                 @(x)ischar(x));
    parse(IP, varargin{:});
    
    % get the config function's name and call it
    configName = IP.Results.configName;
    o('#%s(): using config file "%s" ...', mfilename, configName, 4, this.verb);
    [~, thisNew] = OCIAGetCallCustomFile(this, 'config', configName, 1, { this }, 1);
    % abort if no "this" anymore
    if isempty(thisNew); return; end;
    % otherwise go on
    this = thisNew;
    
    % if DataWatcher filtering was provided as input, overwrite config's parameter with input parameter
    if ~strcmp(IP.Results.DWFilt, 'empty') && ~isempty(IP.Results.DWFilt);
        this.GUI.dw.DWFilt = IP.Results.DWFilt;
    end;
    o('#%s(): filtering elements: " %s" ...', mfilename, sprintf('%s - ', this.GUI.dw.DWFilt{:}), 4, this.verb);
    
    % if alternate start function name was provided
    if ~strcmp(IP.Results.startFunctionName, 'empty');
        this.main.startFunctionName = IP.Results.startFunctionName;
    end;
    o('#%s(): filtering elements: " %s" ...', mfilename, sprintf('%s - ', this.GUI.dw.DWFilt{:}), 4, this.verb);
    %% -- #OCIA: update the drop-down filters and table IDs
    % define the "IDs" field for each drop-down DataWatcher filter element
    dropDownFiltersIDs = this.GUI.dw.filtElems{strcmp(this.GUI.dw.filtElems.GUIType, 'dropdown'), 'id'};
    for iFilter = 1 : numel(dropDownFiltersIDs);
        % create a list with only a dash element, which corresponds to no filtering
        this.dw.([dropDownFiltersIDs{iFilter} 'IDs']) = {'-'};
    end;

    % fetch IDs
    this.dw.tableIDs = this.GUI.dw.tableDisplay.id;
    % init table to the right size
    this.dw.table = cell(300, numel(this.dw.tableIDs));
    
    % create order column if not yet present
    if ~ismember('order', this.GUI.dw.tableDisplay.Properties.VariableNames)
        this.GUI.dw.tableDisplay.order = (1 : size(this.GUI.dw.tableDisplay, 1))';
    end;
    
    %% -- #OCIA: turn warnings off
    warning('off', 'images:imshow:magnificationMustBeFitForDockedFigure');
    warning('off', 'MATLAB:hg:gltexture:TextureDataTooLargeForDevice');
    warning('off', 'YMA:FindJObj:invisibleHandle');
    warning('off', 'MATLAB:JavaEDTAutoDelegation');
    
    %% --#OCIA: clean up paths
    pathFields = fieldnames(this.path);
    for iField = 1 : numel(pathFields);
        fieldName = pathFields{iField};
        this.path.(fieldName) = regexprep([regexprep(this.path.(fieldName), '\\', '/'), '/'], '//$', '/');
        this.path.(fieldName) = regexprep(this.path.(fieldName), '(\.\w+)/', '$1');
    end;
    
    %% -- #OCIA: add java folders
    OCIAPath = regexprep(which('OCIA'), '\\', '/');
    OCIAPath = regexprep(OCIAPath, '/@OCIA/OCIA.m$', '');
    javaaddpath([OCIAPath '/java/ij.jar']);
    javaaddpath([OCIAPath '/java/TurboRegJava']);
    o('#%s(): added Java path at "%s" ...', mfilename, OCIAPath, 4, this.verb);
      
    %% -- #OCIA: create the window and show it
    o('Creating window ...', 0, this.verb);
    OCIACreateWindow(this); % create the GUI window
    pause(0.5);
    show(this); % make the GUI window visible

    %% -- #OCIA: process start function
    % process the start function
    showMessage(this, sprintf('Initializing using start function "%s" ...', this.main.startFunctionName), 'yellow');
    OCIAGetCallCustomFile(this, 'startFunction', this.main.startFunctionName, 1, { this }, 1); % use default if none provided

end


%% - #delete (destructor)
function delete(this)
    
    o('#delete()', 4, this.verb);
    
    delete(this.GUI.figH);
    
end

%% - GUI methods
%% -- #show
function show(this)
% show - Show the window
%
%       show(this)
%
% Makes the OCIA window visible. 
    
    % do nothing if there is no GUI
    if ~isGUI(this); return; end;
    
    o('#show()', 4, this.verb);
    
    showTic = tic; % for performance timing purposes
    set(this.GUI.figH, 'Visible', 'on');
    pause(0.1);
    o('#show(): done (%.4f sec)', toc(showTic), 4, this.verb);
        
end;

%% -- #hide
function hide(this)
% hide - Hides the window
%
%       hide(this)
%
% Makes the OCIA window invisible. 

    % do nothing if there is no GUI
    if ~isGUI(this); return; end;
    
    o('#hide()', 4, this.verb);
    
    set(this.GUI.figH, 'Visible', 'off');
    
end;

%% -- #printWindowPosition
function printWindowPosition(this)
% printWindowPosition - Prints out the window's position
%
%       printWindowPosition(this)
%
% Prints out the window's current position.

   showMessage(this, 'Printing current window''s position:');
   showMessage(this, sprintf('this.GUI.pos = [%s];', regexprep(sprintf('%.0f, ', get(this.GUI.figH, 'Position')), ', $', '')));
    
end;

%% -- #isGUI
function isGUIBool = isGUI(this)
% isGUI - GUI-mode check
%
%       isGUIBool = isGUI(this)
%
% Returns the logical 'isGUIBool' telling whether the current instance of the OCIA ('this') is running in a 
%   windowed mode or not.

    % if not in no-GUI mode and either in deployed mode or not in a matlab worker (parallel computing)
    isGUIBool = ~this.GUI.noGUI && (isdeployed || isempty(javachk('desktop')));
        
end;

%% -- #showMessage
function showMessage(this, messageTxt, bgColor)
% showMessage - Display a message
%
%       showMessage(this, messageTxt, bgColor)
%
% Displays the message 'messageTxt' (char) in the log bar and in the command window. If the variable 'bgColor' is
%   specified, the background of the log bar is set to the color specified either as a color string ("red", "blue",
%   etc.) or as an array of 3 values between 0.0 and 1.0 (RGB). Otherwise the default color (green) is used.

    % print out the message in the command window
    o(regexprep(messageTxt, '%', '%%'), 1, this.verb);
    
    % do nothing if there is no GUI
    if ~isGUI(this); return; end;
    
    % if variable color not specified or neither a string nor a 3-elements RGB array
    if ~exist('bgColor', 'var') || (~ischar(bgColor) && numel(bgColor) > 3);
        % use the default green color
        bgColor = 'green';
    end;
    
    % display the message and set the background
    set(this.GUI.handles.logBar, 'String', messageTxt, 'Background', bgColor);
    
end;

%% -- #showWarning
function showWarning(this, warnID, warningText, bgColor)
% showMessage - Display a warning
%
%       showWarning(this, warnID, warningText, bgColor)
%
% Displays the warning 'warningText' (char) with the ID 'warningID' (char) in the log bar and in the command window.
%   If the variable 'bgColor' is specified, the background of the log bar is set to the color specified either as a
%   color string ("red", "blue", etc.) or as an array of 3 values between 0.0 and 1.0 (RGB). Otherwise the default
%   color (yellow) is used.
    
    
    % if variable color not specified or neither a string nor a 3-elements RGB array
    if ~exist('bgColor', 'var') || (~ischar(bgColor) && numel(bgColor) > 3);
        % use the default green color
        bgColor = 'yellow';
    end;
    
    % show the warning but without the stack trace
    if ~this.main.showWarningStackTraces;
        warning off backtrace;
    end;
    warning(warnID, [strrep(warningText, '\', '\\') ' (' warnID ')']);
    if ~this.main.showWarningStackTraces;
        warning on backtrace;
    end;
    
    % do nothing if there is no GUI or if warning is disabled
    warnState = warning('query', warnID);
    if ~isfield(this.GUI, 'noGUI') || ~isfield(this.GUI, 'figH') || ~isfield(this.GUI, 'handles') ...
            || ~isfield(this.GUI.handles, 'logBar') || ~isGUI(this) || strcmp(warnState.state, 'off'); return; end;
    
    % split the warning text at end-of-line characters
    warningTextSplit = regexp(warningText, '\n', 'split');
    % only display the first line of the warning text and set the background
    set(this.GUI.handles.logBar, 'String', warningTextSplit{1}, 'Background', bgColor);    
    
end;

%% -- #getJTable
function jTable = getJTable(this, hTable)
% getJTable - Get a Java table
%
%       jTable = getJTable(this, hTable)
%
% Returns the Java object 'jTable' associated with the uitable specified by 'hTable'. 'hTable' can be either a
%   string ('DWTable', etc.) or as a uitable handle.

    jTable = []; % return empty in case there is a problem
    tableName = '';
    
    % if handle is actually a string, get the appropriate uitable handle first
    if ischar(hTable);
        
        % store the table's name
        tableName = hTable;
        
        % check if the table was not already stored in memory
        if isfield(this.GUI, 'jTables') && isfield(this.GUI.jTables, tableName);
            jTable = this.GUI.jTables.(tableName);
            return;
        end;
        
        % get the appropriate handle for the table
        switch tableName;
            case 'DWTable';
                hTable = this.GUI.handles.dw.table;
            case 'BEConfTable';
                hTable = this.GUI.handles.be.confTable;
            case 'BEETLTable';
                hTable = this.GUI.handles.be.ETLTable;
            case 'BEExpTable';
                hTable = this.GUI.handles.be.expTable;
            otherwise;
                showWarning(this, 'OCIA:getJTable:UnknownTable', sprintf('Cannot find JTable for "%s".', hTable));
                return;
        end;
    end;
    
    % sometimes the Java-object fetching fails on first attempt, so try a second time
    try
        % get the actual java table underlying the requested uitable
        jTable = findjobj(hTable); jTable = jTable.getComponents();
        jTable = jTable(1); jTable = jTable.getComponents();
        jTable = jTable(1);
        
    % try a second time
    catch e; %#ok<NASGU>
        pause(0.5);
        % get the actual java table underlying the requested uitable
        jTable = findjobj(hTable); jTable = jTable.getComponents();
        jTable = jTable(1); jTable = jTable.getComponents();
        jTable = jTable(1);
    end;
    
    % if the table was acced by a name, store the jtable
    if ~isempty(tableName);
        this.GUI.jTables.(tableName) = jTable;
    end;
end;


%% -- #getData
function data = getData(this, varargin)
% getData - Get data or load status from the DataWatcher's table
%
%       data = getData(this, rows, dataType)
%       data = getData(this, rows, dataType, subFieldName)
%
% Returns the requested data type from the DataWatcher's table data. "rows" should be a double or an array of double and
%   "columns" a string or a cell-array of string, "dataType" a string. "subFieldName" should be a string that specifies
%   which sub-field ('data', 'loadStatus', 'procState') should be returned.

% by default or in case of error, return nothing
data = [];

% all columns for specified row(s)
if numel(varargin) == 2 && (isnumeric(varargin{1}) || (ischar(varargin{1}) && strcmp(varargin{1}, 'all'))) ...
        && ischar(varargin{2});
    rows = varargin{1};
    dataType = varargin{2};
    subFieldName = [];
    
% specified rows and specified column(s)
elseif numel(varargin) == 3 && (isnumeric(varargin{1}) || (ischar(varargin{1}) && strcmp(varargin{1}, 'all'))) ...
        && ischar(varargin{2}) && ischar(varargin{3});
    rows = varargin{1};
    dataType = varargin{2};
    subFieldName = varargin{3};
    
% otherwise: bad input arguments
else
    rows = [];
    dataType = [];
    subFieldName = [];
end;

% if all rows are required to be selected using the 'all' command
if ischar(rows) && strcmp(rows, 'all');
    rows = 1 : size(this.dw.table, 1);
end;

% if the parameters where not all provided or could not be figured out, abort with warning
if isempty(rows) || isempty(dataType);
    showWarning(this, 'OCIA:getData:BadInputArguments', 'Bad input arguments for function getData, please read the help.');   
    return;
end;

% get the data structure
dataStruct = getR(this, rows, 'data');

% if no data structure found, return nothing
if isempty(dataStruct);
    return;
end;

% allocate the data as a cell array
data = cell(size(dataStruct));
% go through each fetched sub-structure
for iStruct = 1 : numel(dataStruct); 
    % if the dataType exists
    if isfield(dataStruct{iStruct}, dataType);
        % if no sub-field name provided, return the data structures themselves
        if isempty(subFieldName);
            data{iStruct} = dataStruct{iStruct}.(dataType);
        % if the sub-field name is required and exists, return it
        elseif isfield(dataStruct{iStruct}.(dataType), subFieldName);
            data{iStruct} = dataStruct{iStruct}.(dataType).(subFieldName);
        end;
    end;    
end;

% do not return a single empty cell, return an empty array instead
if iscell(data) && numel(data) == 1;
    data = data{1};
end;

end


%% -- #setData
function data = setData(this, varargin)
% getData - Get data or load status from the DataWatcher's table
%
%       setData(this, rows, dataType, data)
%       setData(this, rows, dataType, subFieldName, data)
%
% Stores the specified data in the DataWatcher's table specified data type. "rows" should be a double or an array of double and
%   "columns" a string or a cell-array of string, "dataType" a string. "subFieldName" should be a string that specifies
%   which sub-field ('data', 'loadStatus', 'procState') should be returned. "data" is the data to store, can be a cell
%   array.

% all columns for specified row(s)
if numel(varargin) == 3 && (isnumeric(varargin{1}) || (ischar(varargin{1}) && strcmp(varargin{1}, 'all'))) ...
        && ischar(varargin{2});
    rows = varargin{1};
    dataType = varargin{2};
    subFieldName = [];
    data = varargin{3};
    
% specified rows and specified column(s)
elseif numel(varargin) == 4 && (isnumeric(varargin{1}) || (ischar(varargin{1}) && strcmp(varargin{1}, 'all'))) ...
        && ischar(varargin{2}) && ischar(varargin{3});
    rows = varargin{1};
    dataType = varargin{2};
    subFieldName = varargin{3};
    data = varargin{4};
    
% otherwise: bad input arguments
else
    rows = [];
    dataType = [];
    subFieldName = [];
    data = [];
end;

% if all rows are required to be selected using the 'all' command
if ischar(rows) && strcmp(rows, 'all');
    rows = 1 : size(tableToUse, 1);
end;

% if the parameters where not all provided or could not be figured out, abort with warning
if isempty(rows) || isempty(dataType);
    showWarning(this, 'OCIA:setData:BadInputArguments', 'Bad input arguments for function setData, please read the help.');   
    return;
end;

% make sure the data's format is a cell-array
if ~iscell(data) || numel(rows) == 1;
    data = { data };
end;

% if the number of rows is too big, abort with warning
if numel(rows) ~= numel(data);
    showWarning(this, 'OCIA:setData:NumberOfRowsMismatch', ...
        sprintf('Number of rows specified (%02d) is not equal to the size of the input data (%02d).', ...
            numel(rows), numel(data)));   
    return;
end;

% go through each row
for iRow = 1 : numel(rows); 
    % get the data for this row
    dataStruct = get(this, rows(iRow), 'data');
    % if the dataType exists
    if isfield(dataStruct, dataType);
        % if no sub-field name provided, store the whole data data type
        if isempty(subFieldName);
            dataStruct.(dataType) = data{iRow};
        % otherwise just set the field
        else
            dataStruct.(dataType).(subFieldName) = data{iRow};
        end;
    end; 
    % set the data for this row
    set(this, rows(iRow), 'data', dataStruct);   
end;

end


%% -- #get
function values = get(this, varargin)
% get - Get values from table
%
%       values = get(this, rows)
%       values = get(this, columns)
%       values = get(this, rows, columns)
%       values = get(this, rows, columns, tableToUse)
%       values = get(this, rows, columns, tableToUse, tableIDs)
%
% Returns the requested rows/columns from the DataWatcher's table. "rows" should be a double or an array of double and
%   "columns" a string or a cell-array of string. Optionnally, an alternative table "tableToUse" can be provided with
%   its own columns names "tableIDs".

% get the raw values
values = getR(this, varargin{:});

% do some post-process tasks if there are some cells
if ~isempty(values);
    
    % filter for the delete tag
    charCells = cellfun(@ischar, values);
    values(charCells) = regexprep(values(charCells), ['^' this.GUI.dw.deleteTag], '');
    values(charCells) = regexprep(values(charCells), '^<html>(<[^>]+>)?(<[^>]+>)?([^<]+)(<[^>]+>)*', '$3');

    % do not return a single cell, return the value it contains instead
    if iscell(values) && numel(values) == 1;
        values = values{1};
    end;

end;

end

%% -- #getR
function values = getR(this, varargin)
% getR - Get raw values from table (no post-processing)
%
%       values = getR(this, rows)
%       values = getR(this, columns)
%       values = getR(this, rows, columns)
%       values = getR(this, rows, columns, tableToUse)
%       values = getR(this, rows, columns, tableToUse, tableIDs)
%
% Returns the requested rows/columns from the DataWatcher's table without any further modification (delete tag removal).
%   "rows" should be a double or an array of double and "columns" a string or a cell-array of string. Optionnally, 
%   an alternative table "tableToUse" can be provided with its own columns names "tableIDs".

% get the default table and its IDs
tableToUse = this.dw.table;
tIDs = this.dw.tableIDs;

% by default or in case of error, return nothing
values = [];

% all columns for specified row(s)
if numel(varargin) == 1 && (isnumeric(varargin{1}) || (ischar(varargin{1}) && strcmp(varargin{1}, 'all')));
    rows = varargin{1};
    columns = tIDs;
    
% all rows for specified column(s)
elseif numel(varargin) == 1 && (ischar(varargin{1}) || iscell(varargin{1}));
    rows = 'all';
    columns = varargin{1};
    
% specified rows and specified column(s)
elseif numel(varargin) == 2 && (isnumeric(varargin{1}) || (ischar(varargin{1}) && strcmp(varargin{1}, 'all'))) ...
        && (ischar(varargin{2}) || iscell(varargin{2}));
    rows = varargin{1};
    columns = varargin{2};
    
% specified rows and specified column(s) with a custom table
elseif numel(varargin) == 3 && (isnumeric(varargin{1}) || (ischar(varargin{1}) && strcmp(varargin{1}, 'all'))) ...
        && (ischar(varargin{2}) || iscell(varargin{2})) ...
        && iscell(varargin{3});
    rows = varargin{1};
    columns = varargin{2};
    tableToUse = varargin{3};
    
% specified rows and specified column(s) with a custom table and table IDs
elseif numel(varargin) == 4 && (isnumeric(varargin{1}) || (ischar(varargin{1}) && strcmp(varargin{1}, 'all'))) ...
        && (ischar(varargin{2}) || iscell(varargin{2})) ...
        && iscell(varargin{3}) && iscell(varargin{4});
    rows = varargin{1};
    columns = varargin{2};
    tableToUse = varargin{3};
    tIDs = varargin{4};
    
% otherwise: bad input arguments
else
    rows = [];
    columns = [];  
end;

% if all rows are required to be selected using the 'all' command
if ischar(rows) && strcmp(rows, 'all');
    rows = 1 : size(tableToUse, 1);
end;

% make sure the column name(s)'format is a cell-array
if ischar(columns) && ~isempty(columns);
    columns = { columns };
end;

% if no rows selected, abort
if isempty(rows);
    return;
end;

% if the parameters where not all provided or could not be figured out, abort with warning
if isempty(columns) || isempty(tableToUse) || isempty(tIDs);
    showWarning(this, 'OCIA:getR:BadInputArguments', 'Bad input arguments for function get, please read the help.');   
    return;
end;

% if the number of rows is too big, abort with warning
if numel(rows) > size(tableToUse, 1);
    showWarning(this, 'OCIA:getR:NumberOfRowsExceeded', ...
        sprintf('Number of rows specified (%02d) exceeds table''s dimensions (%02d).', numel(rows), size(tableToUse, 1)));   
    return;
end;

% if all is good, then fetch the values:
% get the indexes of the columns that are in the IDs, in the same order as requested
[~, b] = ismember(columns(ismember(columns, tIDs)), tIDs);
% fetch the values
values = tableToUse(rows, b);

% post-process the column names
for iCol = 1 : numel(columns);
    switch columns{iCol};
        case 'rowID';
            rowID = DWGetRowID(this, rows);
            if ~iscell(rowID); rowID = { rowID }; end;
            values(:, iCol) = rowID;
        case 'rowTypeID';
            rowTypeID = DWGetRowTypeID(this, rows);
            if ~iscell(rowTypeID); rowTypeID = { rowTypeID }; end;
            values(:, iCol) = rowTypeID;
        otherwise;
            % do nothing
    end;
end;

end

%% -- #set
function varargout = set(this, varargin)
% set - set values in table
%
%      set(this, rows, values)
%      set(this, columns, values)
%      set(this, rows, columns, values)
%      tableToUse = set(this, rows, columns, values, tableToUse)
%      tableToUse = set(this, rows, columns, values, tableToUse, tableIDs)
%
% Stores the specified values in the rows/columns from the DataWatcher's table. "rows" should be a double or an 
%   array of double and "columns" a string or a cell-array of string. Optionnally, an alternative table "tableToUse" 
%   can be provided with its own columns names "tableIDs", in which case the new table is returned.

% by default, no output
varargout = {};

% get the default table and its IDs
tableToUse = this.dw.table;
tIDs = this.dw.tableIDs;
% set the flag specifying if the table used was from input, by default "false"
tableFromInput = false;

% all columns for specified row(s)
if numel(varargin) == 2 && (isnumeric(varargin{1}) || (ischar(varargin{1}) && strcmp(varargin{1}, 'all')));
    rows = varargin{1};
    columns = tIDs;
    values = varargin{2};
    
% all rows for specified column(s)
elseif numel(varargin) == 2 && (ischar(varargin{1}) || iscell(varargin{1}));
    rows = 'all';
    columns = varargin{1};
    values = varargin{2};
    
% specified rows and specified column(s)
elseif numel(varargin) == 3 && (isnumeric(varargin{1}) || (ischar(varargin{1}) && strcmp(varargin{1}, 'all'))) ...
        && (ischar(varargin{2}) || iscell(varargin{2}));
    rows = varargin{1};
    columns = varargin{2};
    values = varargin{3};
    
% specified rows and specified column(s) with a custom table
elseif numel(varargin) == 4 && (isnumeric(varargin{1}) || (ischar(varargin{1}) && strcmp(varargin{1}, 'all'))) ...
        && (ischar(varargin{2}) || iscell(varargin{2})) ...
        && iscell(varargin{4});
    rows = varargin{1};
    columns = varargin{2};
    values = varargin{3};
    tableToUse = varargin{4};
    % set the flag specifying that the table used was from input
    tableFromInput = true;
    
% specified rows and specified column(s) with a custom table and table IDs
elseif numel(varargin) == 5 && (isnumeric(varargin{1}) || (ischar(varargin{1}) && strcmp(varargin{1}, 'all'))) ...
        && (ischar(varargin{2}) || iscell(varargin{2})) ...
        && iscell(varargin{4}) && iscell(varargin{5});
    rows = varargin{1};
    columns = varargin{2};
    values = varargin{3};
    tableToUse = varargin{4};
    tIDs = varargin{5};
    % set the flag specifying that the table used was from input
    tableFromInput = true;
    
% otherwise: bad input arguments
else
    columns = []; 
end;

% if all rows are required to be selected using the 'all' command
if ischar(rows) && strcmp(rows, 'all');
    rows = 1 : size(tableToUse, 1);
end;

% make sure the column name(s)'format is a cell-array
if ischar(columns) && ~isempty(columns);
    columns = { columns };
end;

% if the parameters where not all provided or could not be figured out, abort with warning
if isempty(rows) || isempty(columns) || isempty(tableToUse) || isempty(tIDs);
    showWarning(this, 'OCIA:set:BadInputArguments', 'Bad input arguments for function set, please read the help.');   
    return;
end;

% if the number of rows is too big, abort with warning
if numel(rows) > size(tableToUse, 1);
    showWarning(this, 'OCIA:set:NumberOfRowsExceeded', ...
        sprintf('Number of rows specified (%02d) exceeds table''s dimensions (%02d).', numel(rows), size(tableToUse, 1)));   
    return;
end;

% make sure the values' format is a cell-array
if ~iscell(values);
    values = { values };
end;

% if the size of the values does not match exactly the size of what needs to be replaced, try to extend the values
tableToReplace = tableToUse(rows, ismember(tIDs, columns));
if ~all(size(values) == size(tableToReplace));
    
    % if inputs are just transposed, transposed them back
    if all(size(values') == size(tableToReplace));
        values = values';
    
    % if the values are a vector and can be expanded on one dimension to fit the right size
    elseif size(values, 1) == 1 && size(values, 2) == size(tableToReplace, 2);
        values = repmat(values, size(tableToReplace, 1), 1);
    % if the values are a vector and can be expanded on one dimension to fit the right size
    elseif size(values, 1) == 1 && size(values, 2) == size(tableToReplace, 1);
        values = repmat(values', 1, size(tableToReplace, 2));
    % if the values are a vector and can be expanded on one dimension to fit the right size
    elseif size(values, 2) == 1 && size(values, 1) == size(tableToReplace, 1);
        values = repmat(values, 1, size(tableToReplace, 1));
    % if the values are a vector and can be expanded on one dimension to fit the right size
    elseif size(values, 2) == 1 && size(values, 1) == size(tableToReplace, 2);
        values = repmat(values', size(tableToReplace, 1), 1);
    % if the values are a vector and can be expanded on one dimension to fit the right size
    elseif size(values, 2) == 1 && size(values, 1) == 1;
        values = repmat(values', size(tableToReplace, 1), size(tableToReplace, 2));
    % if nothing can be done, abort
    else
        showWarning(this, 'OCIA:set:BadSizeInputValues', ...
            sprintf('Input values have bad size: provided size: %d x %d, required size: %d x %d.', ...
                size(values), size(tableToReplace))); 
        return;
    end;
end;

% set the values
tableToUse(rows, ismember(tIDs, columns)) = values;

% if the table comes from input arguments, return it
if tableFromInput;
    varargout = { tableToUse };
% otherwise, update the data watcher table
else
    this.dw.table = tableToUse;
end;

end

%% - #event handlers
%% -- #keyPressed
function keyPressed(this, ~, e)
    
% get the current mode
currentMode = this.main.modes{get(this.GUI.handles.changeMode, 'Value'), 1};
% get whether a mode change was requested
isChangeMode = 0;
% if ismember('shift', e.Modifier);
%     switch e.Key;
%         case {'1', '2', '3', '4', '5', '6', '7', '8', '9'};
%             if str2double(e.Key) <= size(this.main.modes, 1);
%                 OCIAChangeMode(this, this.main.modes{str2double(e.Key), 1});
%             end;
%             isChangeMode = 1;
%     end;
% end;

if ~isChangeMode;
    switch currentMode
        
        %% --- #keyPressed : ROIDrawer
        case 'TrialView';
            % get current object
            currObj = get(this.GUI.figH, 'CurrentObject');
            
            % check for key presses not while inside a text uicontrol element
            if ~isa(currObj, 'matlab.ui.control.UIControl') || ~ismember(get(currObj, 'Style'), { 'edit' });
                switch e.Key;

                    % print help for shortcuts
                    case 'h';
                        msgCellArray = { ...
                            'This is the \bfhelp\rm for the \bfshortcuts\rm of the TrialView mode of OCIA.', ...
                            'Following shortcuts can be used:', ...
                            '\bf               [H]                       \rmdisplay this help', ...
                            '\bf               [up/down arrows]          \rmmove up/down in the file selection', ...
                            '\bf               [left/right arrows]       \rmmove 1 frame  backward or forward', ...
                            '\bf   [SHIFT]  +  [left/right arrows]       \rmmove 3 frames backward or forward', ...
                            '\bf               [space]                   \rmadd a movement point', ...
                            '\bf               [R]                       \rmreset GUI', ...
                            '\bf    [CTRL]  +  [R]                       \rmreset movement points for current trial', ...
                            '\bf   [SHIFT]  +  [R]                       \rmreset movement points for all trials', ...
                            '\bf               [L]                       \rmload current row/trial', ...
                            '\bf    [CTRL]  +  [L]                       \rmload parameters and move vectors', ...
                            '\bf   [SHIFT]  +  [L]                       \rmload ROIs', ...
                            '\bf    [CTRL]  +  [S]                       \rmsave parameters and move vectors', ...
                            '\bf   [SHIFT]  +  [S]                       \rmsave ROIs', ...
                        }';
                        % display a message box
                        h = msgbox( msgCellArray, 'Shortcut help for TrialView mode');
                        
                        % make sure the box is big enough
                        boxPos = get(h, 'Position');
                        set(h, 'Position', boxPos + [-200, -75, 400, 150]);
                        % make font bigger
                        hChild = get(h, 'Children');
                        set(hChild(2), 'Units', 'Normalized', 'Position', [0, 0, 1, 1]);
                        hText = get(hChild(2), 'Children');
                        set(hText, 'FontSize', 12, 'Units', 'Normalized', 'Position', [0.01, 0.98, 0], ...
                            'FontName', 'Courier', 'VerticalAlignment', 'top', 'String', msgCellArray, ...
                            'Interpreter', 'tex');

                    % left/right arrow keys => move by one frame back or forward
                    case { 'leftarrow', 'rightarrow' };
                        % adjust frame
                        this.tv.iFrame = this.tv.iFrame + iff(ismember('shift', e.Modifier), 3, 1) ...
                            * iff(strcmp(e.Key, 'leftarrow'), -1, 1);
                        % keep frame between boundaries
                        this.tv.iFrame = min(max(round(this.tv.iFrame), 1), this.tv.params.WFDataSize(3));
                        % update GUI
                        OCIA_trialview_changeFrame(this);

                    % up/down arrow keys => move within the file selection list
                    case { 'uparrow', 'downarrow' };
                        if isfield(this.GUI.handles.tv, 'paramPanElems') ...
                                && isfield(this.GUI.handles.tv.paramPanElems, 'fileList');
                            % get selected element and size
                            selElemIndex = get(this.GUI.handles.tv.paramPanElems.fileList, 'Value');
                            nElems = numel(get(this.GUI.handles.tv.paramPanElems.fileList, 'String'));
                            % adjust selection
                            selElemIndex = selElemIndex + iff(strcmp(e.Key, 'uparrow'), -1, 1);
                            % keep index between boundaries
                            selElemIndex = min(max(selElemIndex, 1), nElems);
                            % update GUI
                            set(this.GUI.handles.tv.paramPanElems.fileList, 'Value', selElemIndex);
                            % make sure parameters are updated
                            TVUpdateParams(this);
                        end;
                        
                    % add a movement point
                    case 'space';
                        OCIA_trialview_addMovePoint(this);
                        
                    % resets
                    case 'r';
                        % reset GUI
                        if isempty(e.Modifier);
                            OCIA_startFunction_trialView(this);
                            
                        % reset move points
                        elseif ~isempty(e.Modifier) && all(strcmp(e.Modifier, 'control'));
                            OCIA_trialview_resetMovePoints(this);
                            
                        % reset all move points
                        elseif ~isempty(e.Modifier) && all(strcmp(e.Modifier, 'shift'));
                            OCIA_trialview_resetMovePoints(this, 'all');
                            
                        end;
                        
                    % load
                    case 'l';
                        % load row
                        if isempty(e.Modifier);
                            OCIA_trialview_loadWideFieldData(this);
                            
                        % load params
                        elseif ~isempty(e.Modifier) && all(strcmp(e.Modifier, 'control'));
                            OCIA_trialview_loadParams(this);
                            
                        % load ROIs
                        elseif ~isempty(e.Modifier) && all(strcmp(e.Modifier, 'shift'));
                            OCIA_trialview_loadROIs(this);
                            
                        end;
                        
                    % save
                    case 's';
                        
                        % save params
                        if all(strcmp(e.Modifier, 'control'));
                            OCIA_trialview_saveParams(this);
                            
                        % save ROIs
                        elseif all(strcmp(e.Modifier, 'shift'));
                            OCIA_trialview_saveROIs(this);
                            
                        end;

                end; % switch end
            end; % end of check for key presses not while inside a text uicontrol element
        
        %% --- #keyPressed : ROIDrawer
        case 'ROIDrawer';
            switch e.Key;
                
                % arrow keys
                case { 'uparrow', 'downarrow', 'leftarrow', 'rightarrow' };
                    
                    % move ROIs
                    if ~ismember('control', e.Modifier) && ~ismember('shift', e.Modifier) ...
                            && ~ismember('alt', e.Modifier);
                        RDMoveROIs(this, strrep(e.Key, 'arrow', ''), this.rd.moveROIsStep);
                        
                    % rotate ROIs
                    elseif ismember('control', e.Modifier) && strcmp(e.Key, 'leftarrow');
                        RDRotateROIs(this, - this.rd.rotateROIsStep);
                        
                    % rotate ROIs
                    elseif ismember('control', e.Modifier) && strcmp(e.Key, 'rightarrow');
                        RDRotateROIs(this, this.rd.rotateROIsStep);
                        
                    % scale ROIs
                    elseif ismember('shift', e.Modifier) && strcmp(e.Key, 'leftarrow');
                        RDScaleROIs(this, this.rd.scaleROIsStep, 0);
                        
                    % scale ROIs
                    elseif ismember('shift', e.Modifier) && strcmp(e.Key, 'rightarrow');
                        RDScaleROIs(this, - this.rd.scaleROIsStep, 0);
                        
                    % scale ROIs
                    elseif ismember('shift', e.Modifier) && strcmp(e.Key, 'uparrow');
                        RDScaleROIs(this, 0, this.rd.scaleROIsStep);
                        
                    % scale ROIs
                    elseif ismember('shift', e.Modifier) && strcmp(e.Key, 'downarrow');
                        RDScaleROIs(this, 0, - this.rd.scaleROIsStep);
                    
                    % change ROI
                    elseif ismember('alt', e.Modifier) && strcmp(e.Key, 'downarrow');
                        currROI = get(this.GUI.handles.rd.selROIsList, 'Value');
                        if isempty(currROI); currROI = 1; end;
                        if currROI(1) < numel(get(this.GUI.handles.rd.selROIsList, 'String'));
                            set(this.GUI.handles.rd.selROIsList, 'Value', currROI(1) + 1);
                        end;
                        RDSelROI(this);
                       
                    % change ROI 
                    elseif ismember('alt', e.Modifier) && strcmp(e.Key, 'uparrow');
                        currROI = get(this.GUI.handles.rd.selROIsList, 'Value');
                        if isempty(currROI);
                            currROI = numel(get(this.GUI.handles.rd.selROIsList, 'String'));
                        end;
                        if currROI(1) > 1;
                            set(this.GUI.handles.rd.selROIsList, 'Value', currROI(1) - 1);
                        end;
                        RDSelROI(this);
                    end;
                    
                % toggle zoom
                case 'z';
                    RDActivateZoom(this, ~get(this.GUI.handles.rd.zTool, 'Value'));
                    
                % new ROI
                case 'n';
                    RDDrawNewROI(this, [], []);
                    
                    
                % compare ROISets
                case 'c';
                    
                    % invert target and reference
                    if ismember('control', e.Modifier);
                        selRef = get(this.GUI.handles.rd.refROISetASetter, 'Value');
                        selTarg = get(this.GUI.handles.rd.refROISetBSetter, 'Value');
                        set(this.GUI.handles.rd.refROISetASetter, 'Value', selTarg(1));
                        set(this.GUI.handles.rd.refROISetBSetter, 'Value', selRef(1));
                        RDCompareROIs(this, 'IDs');
                    
                    % ?
                    elseif ismember('alt', e.Modifier);
                        compareState = get(this.GUI.handles.rd.refROISet, 'Value');
                        set(this.GUI.handles.rd.refROISet, 'Value', ~compareState);
                        RDCompareROIs(this, 'IDs');
                        
                    % ?
                    else
                        RDCompareROIs(this, 'IDs');
                    end;
                    
                case 'l';
                    % load ROIs
                    if ismember('control', e.Modifier);
                        RDSaveROIs(this);
                        
                    % select last ROIs
                    else
                        set(this.GUI.handles.rd.selROIsList, 'Value',  numel(get(this.GUI.handles.rd.selROIsList, 'String')));
                        RDSelROI(this);
                    end;
                      
                case 'r';
                    % reload ROIs  
                    if ismember('shift', e.Modifier);
                        
                        spotIDs = get(this, 'all', 'spot');
                        spotIDs(cellfun(@isempty, spotIDs)) = [];
                        uniqueSpotIDs = unique([ '-'; spotIDs]);
                        
                        selectedSpotIDs = get(this, this.dw.selectedTableRows, 'spot');
                        selectedSpotIDs(cellfun(@isempty, selectedSpotIDs)) = [];
                        uniqueSelectedSpotIDs = unique(selectedSpotIDs);
                        
                        selRef = get(this.GUI.handles.rd.refROISetASetter, 'Value');
                        selTarg = get(this.GUI.handles.rd.refROISetBSetter, 'Value');
                        DWProcessWatchFolder(this);
                        DWExtractNotebookInfo(this);
                        pause(0.01);
                        set(this.GUI.handles.dw.filt.spotID, 'String', uniqueSpotIDs, ...
                            'Value', find(strcmp(uniqueSelectedSpotIDs{1}, uniqueSpotIDs)));
                        DWFilterSelectTable(this, 'new');
                        pause(0.01);
                        OCIA_dataWatcherProcess_drawROIs(this);
                        set(this.GUI.handles.rd.tableList, 'Value', 1 : numel(this.rd.selectedTableRows));
                        RDChangeRow(this, this.GUI.handles.rd.tableList);
                        set(this.GUI.handles.rd.refROISetASetter, 'Value', selRef);
                        set(this.GUI.handles.rd.refROISetBSetter, 'Value', selTarg);
                        set(this.GUI.handles.rd.refROISet, 'Value', 1);
                        RDCompareROIs(this);
                        RDLoadROIs(this);
                        
                    % rename ROIs
                    elseif ismember('control', e.Modifier);
                        RDRenameROI(this);
                        
                        
                    % rename ROIs box
                    else
                        set(this.GUI.handles.rd.ROIName, 'String', '');
                        uicontrol(this.GUI.handles.rd.ROIName);
                    end;
                
                case 'space';

                % delete selected ROIs
                case { 'd', 'delete' };
                    RDDeleteROI(this);
                % toggle ROI display
                case 'i';
                    RDShowHideROIs(this, 'IDs');
                    
                % toggle ROI display
                case 'o';
                   RDShowHideROIs(this, 'ROIs');
                
                case 's';
                    % save ROIs
                    if ismember('control', e.Modifier);
                        RDSaveROIs(this);
                    
                    % select ROIs box
                    else
                        set(this.GUI.handles.rd.selROISetter, 'String', '');
                        uicontrol(this.GUI.handles.rd.selROISetter);
                    end;
                       
                case 'a';
                    % select all ROIs 
                    if ismember('control', e.Modifier);
                        set(this.GUI.handles.rd.selROIsList, 'Value', ...
                            1 : numel(get(this.GUI.handles.rd.selROIsList, 'String')));
                        RDSelROI(this);
                    
                    % image adjustement
                    else
                        set(this.GUI.handles.rd.imAdj, 'Value', ~get(this.GUI.handles.rd.imAdj, 'Value'));
                        RDUpdateImage(this, this.GUI.handles.rd.imAdj);
                    end;
                    
                % pseudo flat field
                case 'p';
                    set(this.GUI.handles.rd.pseudFF, 'Value', ~get(this.GUI.handles.rd.pseudFF, 'Value'));
                    RDUpdateImage(this, this.GUI.handles.rd.pseudFF);
                    
                    
                otherwise;
%                     showWarning(this, 'OCIA:keyPressed:UnknownKey', sprintf('Unknown key (%s) pressed.', e.Key));
            end;
            
        %% --- #keyPressed : Analyser
        case 'Analyser';
            switch e.Key;
                case {'leftarrow', 'rightarrow'};
                    if ismember('control', e.Modifier);
                        ANSelPlot(this, strrep(e.Key, 'arrow', ''));
                    end;
                case {'uparrow', 'downarrow'};
                    if ismember('control', e.Modifier);
                        ANSelRuns(this, strrep(e.Key, 'arrow', ''));
                    end;
                case 'z';
                    if ismember('control', e.Modifier);
                        ANActivateZoom(this, ~get(this.GUI.handles.an.zTool, 'Value'));
                    end;
                case 'd';
                    if ismember('control', e.Modifier);
                        ANActivateDataCursor(this, ~get(this.GUI.handles.an.cTool, 'Value'));
                    end;
                case 's';
                    % save plot
                    if ismember('control', e.Modifier);
                        ANSavePlot(this, []);
                    end;
                otherwise;
%                         showWarning(this, 'OCIA:keyPressed:UnknownKey', sprintf('Unknown key (%s) pressed.', e.Key));
            end;
            
        %% --- #keyPressed : JointTracker
        case 'JointTracker';
            switch e.Key;
                case 'c';
                    JTSwapCursor(this);
                case 'a';
                    if ismember('shift', e.Modifier);
                        set(this.GUI.handles.jt.frameSetter, 'Value', 1);
                    else
                        set(this.GUI.handles.jt.frameSetter, 'Value', max(this.GUI.jt.iFrame - 1, 1));
                    end;
                case 'd';
                    if ismember('shift', e.Modifier);
                        if get(this.GUI.handles.jt.autoTrack, 'Value');
                            JTProcess(this, 'all');
                        else
                            set(this.GUI.handles.jt.frameSetter, 'Value', this.jt.nFrames);
                        end;
                    else
                        set(this.GUI.handles.jt.frameSetter, 'Value', min(this.GUI.jt.iFrame + 1, this.jt.nFrames));
                    end;
                case {'w', 's'};
                    addValue = 1; if strcmp(e.Key, 's'); addValue = -1; end;
                    newValue = min(max(this.GUI.jt.iJointType + addValue, 1), this.jt.nJointTypes);
                    if newValue ~= get(this.GUI.handles.jt.jointTypeSelSetter, 'Value');
                        set(this.GUI.handles.jt.jointTypeSelSetter, 'Value', newValue);
                        JTChangeJointOrJointType(this, this.GUI.handles.jt.jointTypeSelSetter);
                    end;
                case 'f';
                    set(this.GUI.handles.jt.autoTrack, 'Value', ~get(this.GUI.handles.jt.autoTrack, 'Value'));
                    JTProcess(this, 'autoTrackChanged');
                case {'m', 'v'};
                    set(this.GUI.handles.jt.manuTrack, 'Value', ~get(this.GUI.handles.jt.manuTrack, 'Value'));
                    JTManualTrackStart(this);
                case 'space';
                    set(this.GUI.handles.jt.viewOpts.preProc, 'Value', ...
                        ~get(this.GUI.handles.jt.viewOpts.preProc, 'Value'));
                    JTUpdateGUI(this, this.GUI.handles.jt.viewOpts.preProc);
                otherwise;
%                         showWarning(this, 'OCIA:keyPressed:UnknownKey', sprintf('Unknown key (%s) pressed.', e.Key));
            end;
            
        %% --- #keyPressed : Discriminator
        case 'Discriminator';
            switch e.Key;
                
                % adjust response rate threshold
                case 'leftarrow';
                    this.di.respRateThresh = max(min(this.di.respRateThresh - 0.5, 9.5), 1);
                    showMessage(this, sprintf('Reponse threshold: %.1f.', this.di.respRateThresh), 'yellow');
                
                % adjust response rate threshold   
                case 'rightarrow';
                    this.di.respRateThresh = max(min(this.di.respRateThresh + 0.5, 9.5), 1);
                    showMessage(this, sprintf('Reponse threshold: %.1f.', this.di.respRateThresh), 'yellow');
                    
                % zoom level of activity
                case 'uparrow';
                    this.GUI.di.zoomLevel = max(min(this.GUI.di.zoomLevel + this.GUI.di.zoomLevel * 0.1, 10), 1);
                    showMessage(this, sprintf('Zoom level: %.1f.', this.GUI.di.zoomLevel), 'yellow');
                    
                % zoom level of activity
                case 'downarrow';
                    this.GUI.di.zoomLevel = max(min(this.GUI.di.zoomLevel - this.GUI.di.zoomLevel * 0.1, 10), 1);
                    showMessage(this, sprintf('Zoom level: %.1f.', this.GUI.di.zoomLevel), 'yellow');
                    
                % start/stop camera
                case 'c';
                    DIStartStopCamera(this, 'toggle');
                    showMessage(this, sprintf('Camera running: %s', get(this.GUI.di.camHandle, 'Running')), 'yellow');
                    
                % start/stop activity
                case 'a';
                    this.GUI.di.activityRunning = ~this.GUI.di.activityRunning;
                    if this.GUI.di.activityRunning;
                        this.GUI.di.actiMovieIndex = this.GUI.di.actiMovieIndex + 1;
                        if this.GUI.di.actiMovieIndex > numel(this.GUI.di.actiMovies); this.GUI.di.actiMovieIndex = 1; end;
                    end;
                    showMessage(this, sprintf('Activity movie: %s', iff(this.GUI.di.activityRunning, 'on', 'off')), 'yellow');
                   
                % lock mouse
                case 'l';
                    this.di.lockMouse = ~this.di.lockMouse;
                    showMessage(this, sprintf('Locking mouse: %s', iff(this.di.lockMouse, 'on', 'off')), 'yellow');
                    
                % trial phases:
                % reset
                case '0';
                    this.di.iTrial = 0;
                    this.di.iStimMat = randi(10);
                    this.di.targetStim = randi(2);
                    showMessage(this, sprintf('Reset trials, iTrial: %d, iStimMat: %d, target stimulus: %d.', ...
                        this.di.iTrial, this.di.iStimMat, this.di.targetStim), 'yellow');
                % new trial
                case '1';
                    set(this.GUI.handles.di.messBox, 'String', 'Trial start ...', 'Background', 'yellow');
                    set(this.GUI.handles.di.messBoxBack, 'Background', 'yellow');
                    this.di.iTrial = this.di.iTrial + 1;
                    showMessage(this, sprintf('Current trial: %d.', this.di.iTrial), 'yellow');
                % present stimulus
                case '2';
                    set(this.GUI.handles.di.messBox, 'String', 'Stimulus ...', 'Background', 'yellow');
                    set(this.GUI.handles.di.messBoxBack, 'Background', 'yellow');
                    stimNum = this.di.stimMatrix(this.di.iTrial, this.di.iStimMat);
                    isTarget = stimNum == this.di.targetStim;
                    showMessage(this, sprintf('Stimulus index for trial %d: %d, target: %d.', this.di.iTrial, stimNum, isTarget), 'yellow');
                % get decision
                case '3';
                    this.di.waitingForResp = true;
                    this.di.waitingStartTime = nowUNIX;
                    this.di.resp = false;
                    set(this.GUI.handles.di.messBox, 'String', 'Decision ...', 'Background', 'yellow');
                    set(this.GUI.handles.di.messBoxBack, 'Background', 'yellow');
                    stimNum = this.di.stimMatrix(this.di.iTrial, this.di.iStimMat);
                    isTarget = stimNum == this.di.targetStim;
                    showMessage(this, sprintf('Trial %d: stimulus %d, target: %d - waiting for decision ...', this.di.iTrial, stimNum, isTarget), 'yellow');
                % reward
                case '4';
                    this.di.waitingForResp = false;
                    set(this.GUI.handles.di.messBox, 'String', 'Reward !', 'Background', 'green');
                    set(this.GUI.handles.di.messBoxBack, 'Background', 'green');
                    showMessage(this, 'Reward', 'yellow');
                % punishment
                case '5';
                    this.di.waitingForResp = false;
                    set(this.GUI.handles.di.messBox, 'String', 'Punishment !', 'Background', 'red');
                    set(this.GUI.handles.di.messBoxBack, 'Background', 'red');
                    showMessage(this, 'Punishment', 'yellow');
                    
            end;
    end;
end;

end;

%% -- #mouseDown
function mouseDown(this, ~, ~)

    currentMode = this.main.modes{get(this.GUI.handles.changeMode, 'Value'), 1};
    
    switch currentMode;
        
        case 'TrialView';
            
            % get selection type (mouse button)
            selType = get(this.GUI.figH, 'SelectionType');
            % get clicked object
            clickedObj = get(this.GUI.figH, 'CurrentObject');
            if isa(clickedObj, 'matlab.graphics.axis.Axes') || ...
                        (~isa(get(clickedObj, 'Parent'), 'matlab.graphics.primitive.Group') ...
                        && (isa(clickedObj, 'matlab.graphics.chart.primitive.Line') ...
                        || isa(clickedObj, 'matlab.graphics.primitive.Patch') ...
                        || isa(clickedObj, 'matlab.graphics.primitive.Text')));
                    
                    % left click
                    if strcmp(selType, 'normal');
                        this.GUI.tv.mouseDownOnAxe = true;
                    end;
                        
            end;
        
        case 'JointTracker';
            
            % make sure the click is within the axe image and not during a ROI drawing
            pos = get(this.GUI.handles.jt.axe, 'CurrentPoint');
            pos = pos(1, 1 : 2);
            XLim = get(this.GUI.handles.jt.axe, 'XLim');
            YLim = get(this.GUI.handles.jt.axe, 'YLim');
            if this.GUI.jt.selectingROI || any(pos < 0) || pos(1) > XLim(2) || pos(2) > YLim(2);
                return;
            end;
            
            if isempty(this.GUI.jt.placeJointIndex) && isempty(this.GUI.jt.moveJointIndex);
                selectionType = get(this.GUI.figH, 'SelectionType');
                JTJointClickStart(this, strcmp(selectionType, 'extend'));
            end;
    end;

end;

%% -- #mouseUp
function mouseUp(this, h, e)

    currentMode = this.main.modes{get(this.GUI.handles.changeMode, 'Value'), 1};
    
    switch currentMode;
        
        case 'TrialView';
            
            % get selection type (mouse button)
            selType = get(this.GUI.figH, 'SelectionType');
            % get clicked object
            clickedObj = get(this.GUI.figH, 'CurrentObject');
            if isa(clickedObj, 'matlab.graphics.axis.Axes') || ...
                    (~isa(get(clickedObj, 'Parent'), 'matlab.graphics.primitive.Group') ...
                    && (isa(clickedObj, 'matlab.graphics.chart.primitive.Line') ...
                    || isa(clickedObj, 'matlab.graphics.primitive.Patch') ...
                    || isa(clickedObj, 'matlab.graphics.primitive.Text')));
                
                % left click
                if strcmp(selType, 'normal');
                    this.GUI.tv.mouseDownOnAxe = false;
                    
                % right click
                elseif strcmp(selType, 'alt');
                    OCIA_trialview_addMovePoint(this);

                end;
                
            elseif isa(clickedObj, 'matlab.graphics.primitive.Image') && clickedObj == this.GUI.handles.tv.wf.img ...
                    && ~this.GUI.tv.mouseDownOnWFImg;
                OCIA_trialview_drawROI(this);
                
            elseif isa(clickedObj, 'matlab.graphics.primitive.Image') && clickedObj == this.GUI.handles.tv.behav.img ...
                    && ~this.GUI.tv.mouseDownOnWFImg;
                OCIA_trialview_drawROI(this, this.GUI.handles.tv.behav.axe);
                
            end;
        
        case 'ROIDrawer';
            
            RDUpdateGUI(this, h, e);
        
        case 'Behavior';
            
            BEChangePiezoThresh(this, 'mouseAdjust', []);
            
        case 'JointTracker';
            
            % make sure the click is within the axe image and not during a ROI drawing
            pos = get(this.GUI.handles.jt.axe, 'CurrentPoint');
            pos = pos(1, 1 : 2);
            XLim = get(this.GUI.handles.jt.axe, 'XLim');
            YLim = get(this.GUI.handles.jt.axe, 'YLim');
            if this.GUI.jt.selectingROI || any(pos < 0) || pos(1) > XLim(2) || pos(2) > YLim(2);
                return;
            end;
            
            % process the click event
            JTImClick(this, h, e);
            
            % reset the joint tracking/moving settings
            this.GUI.jt.placeJointIndex = [];
            this.GUI.jt.moveJointIndex = [];
            this.GUI.jt.startFrame = [];
            this.GUI.jt.endFrame = [];
            this.GUI.jt.startTime = [];

            % remove manual tracking
            set(this.GUI.handles.jt.manuTrack, 'Value', 0);
        
        case 'Discriminator';
            
            this.di.nResps = this.di.nResps + 0.75;
    end;

end;

%% -- #mouseMoved
function mouseMoved(this, ~, e)

    currentMode = this.main.modes{get(this.GUI.handles.changeMode, 'Value'), 1};
    
    switch currentMode;
        
        case 'TrialView';
            
            if this.GUI.tv.mouseDownOnAxe;
                % get clicked object
                clickedObj = get(this.GUI.figH, 'CurrentObject');
                if isa(clickedObj, 'matlab.graphics.axis.Axes') || ...
                        (~isa(get(clickedObj, 'Parent'), 'matlab.graphics.primitive.Group') ...
                        && (isa(clickedObj, 'matlab.graphics.chart.primitive.Line') ...
                        || isa(clickedObj, 'matlab.graphics.primitive.Patch') ...
                        || isa(clickedObj, 'matlab.graphics.primitive.Text')));
                    OCIA_trialview_changeFrame(this, clickedObj, e);
                end;
            end;
            
    end;

end;

%% -- #windowResized
function windowResized(this, ~, ~)
    
    % if no GUI, skip the resizing
    if ~isGUI(this); return; end;

    % store old position
    oldPos = this.GUI.pos;    
    % update to new position
    this.GUI.pos = get(this.GUI.figH, 'Position');    
    % calculate ratios
    widthRatio = oldPos(3) / this.GUI.pos(3);
%     heightRatio = oldPos(4) / this.GUI.pos(4);
    
    % update the font size and the columns widths of the DataWatcher's table
    columnWidths = get(this.GUI.handles.dw.table, 'ColumnWidth');
    columnWidths = num2cell(cellfun(@(w)round(w / widthRatio), columnWidths));
    set(this.GUI.handles.dw.table, 'ColumnWidth', columnWidths, 'FontSize', max(min(this.GUI.pos(3) / 170, 22), 8));
    
end;





end  % end methods


end
