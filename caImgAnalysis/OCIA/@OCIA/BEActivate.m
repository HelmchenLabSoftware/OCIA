function BEActivate(this)
% BEActivate - [no description]
%
%       BEActivate(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
    
% if there is a GUI, add some GUI interaction callbacks
if isGUI(this);
    % get the java component of the the behavior's config table and enable multiple row selection
    jTable = getJTable(this, 'BEConfTable');
    jTable.setNonContiguousCellSelection(false);
    % add callback on selection
    set(handle(jTable, 'CallbackProperties'), 'MouseClickedCallback', @(h, e)BEConfTableRowChange(this, h, e));
    % add header
    jTable.getTableHeader().setToolTipText('TaskType "cot" = Cloud Of Tones');
    
%     % get the java component of the the behavior's ETL table and enable multiple row selection
%     jTable = getJTable(this, 'BEETLTable');
%     jTable.setNonContiguousCellSelection(false);
end;

% load the main configuration file
mainConfPath = this.path.behavConf;
if ~exist(mainConfPath, 'file');
    error('OCIA:BEActivate:ConfigsFileNotFound', ...
        'Cannot find the mainConf at "%s" (file not found).', mainConfPath);
end;

mainConfMat = load(mainConfPath);
this.be.configs = mainConfMat.configs;

[~, computerName] = system('hostname');
% roomMatch = regexp(computerName, '^HIFOWS(?<room>H\d+)\-\d+\s+$', 'names');
roomMatch = struct('room', 'H42');

if this.be.debugMode;
    warning('OCIA:BEActivate:debugMode', 'Debug mode is ON.');
    roomMatch = struct('room', 'H30');
    o('#%s: debug mode => room tag enforced to: "%s".', mfilename(), roomMatch.room, 1, this.verb);
end;

if isempty(roomMatch);
    error('OCIA:BEActivate:HardwareLoad:NoRoomTagFound', ...
        'Cannot load hardware because there''s no room tag in the computer''s name.');
elseif ~isfield(this.be.configs.hardware, roomMatch.room);
    error('OCIA:BEActivate:HardwareLoad:UnknownRoom', ...
        'Cannot load hardware because room "%s" is unknown.', roomMatch.room);
end;

% load configurations for the appropriate room
this.be.room = roomMatch.room;
this.be.hw.conf = this.be.configs.hardware.(this.be.room);

% reset variables
this.be.isRunning = false;
this.be.isPaused = false;
this.be.isToReset = false;
this.be.configLoaded = false;
this.be.iTrial = 0;

% if there is a GUI, fill-in the uitables
if isGUI(this);
    stateData = get(this.GUI.handles.be.expTable, 'Data');
    stateData(:, 1) = BEGetTrialInfo(this, 0);
    stateData(:, 2) = BEGetTrialInfo(this, 0);
    stateData(:, 3) = BEGetTrialInfo(this, 0);
    set(this.GUI.handles.be.expTable, 'Data', stateData);
    set(this.GUI.handles.be.confTable, 'Data', this.be.configs.animals);
end;

% update the display
BEUpdateGUI(this);

% clear previous timer
if ~isempty(this.GUI.be.updateTimer);
    try stop(this.GUI.be.updateTimer); catch; end;
    delete(this.GUI.be.updateTimer);
    this.GUI.be.updateTimer = [];
end;
% GUI update timer
this.GUI.be.updateTimer = timer('TimerFcn', @(h, e)BERun(this, h, e), 'Name', 'updateTimer', ...
...%     'ExecutionMode', 'fixedRate', 'Period', this.GUI.be.updateRate, ...
...%     'ExecutionMode', 'fixedDelay', 'Period', this.GUI.be.updateRate, ...
    'ExecutionMode', 'fixedSpacing', 'Period', this.GUI.be.updateRate, ...
    'StopFcn', @(~, ~)o('/!\ BehaviorUpdateTimer stopped.', 1, this.verb), ...
    'ErrorFcn', @(~, ~)o('/!\ BehaviorUpdateTimer stopped with error.', 1, this.verb));
start(this.GUI.be.updateTimer);

% clear previous timer
if ~isempty(this.GUI.be.vidTrigTimer);
    try stop(this.GUI.be.vidTrigTimer); catch; end;
    delete(this.GUI.be.vidTrigTimer);
    this.GUI.be.vidTrigTimer = [];
end;

% video triggering timer
this.GUI.be.vidTrigTimer = timer('Name', 'vidTrigTimer', ...
    'TimerFcn', @(h, e)serverSocketSendMessage(h.UserData, 22, 1, 0));

if exist(sprintf('%sOCIA_BE_lastTable.mat', this.path.OCIASave), 'file');
    lastTableMat = load(sprintf('%sOCIA_BE_lastTable.mat', this.path.OCIASave));
    tableData = lastTableMat.tableData;
    set(this.GUI.handles.be.ETLTable, 'Data', tableData);
end;

end
