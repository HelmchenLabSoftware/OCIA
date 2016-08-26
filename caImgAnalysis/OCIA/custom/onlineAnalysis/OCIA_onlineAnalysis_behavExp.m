function OCIA_onlineAnalysis_behavExp(this)
% OCIA_onlineAnalysis_behavExp - [no description]
%
%       OCIA_onlineAnalysis_behavExp(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% capture errors
try   

%% init
totalTic = tic;
o('#%s(): start ...', mfilename(), 1, this.verb);

% get the days to use
refDay = this.dw.onlineAnalysisRefDay;
currDay = this.dw.onlineAnalysisCurrDay;
prevDay = this.dw.onlineAnalysisPrevDay;
currAnimal = this.GUI.dw.DWFilt{1};

% go to DataWatcher mode
OCIAChangeMode(this, 'DataWatcher');

% set all watch types to "selected"
watchTypeNames = fieldnames(this.GUI.handles.dw.watchTypes);
arrayfun(@(i)set(this.GUI.handles.dw.watchTypes.(watchTypeNames{i}), 'Value', 1), 1 : numel(watchTypeNames));
% remove the processing row limit
this.an.img.funcMovieNFramesLimit = 1;

%% get local data for reference day (only once)
% get any row of the previous day
refDayRows = DWFilterTable(this, sprintf('day = %s', refDay));

% if no previous day rows found, get them
if isempty(refDayRows);
    % fetch rows and update table
    set(this.GUI.handles.dw.keepTable, 'Value', 0);
    OCIA_onlineAnalysis_behavExp_fetchRowsAndUpdateTable(this, currAnimal, refDay, 'local');
    set(this.GUI.handles.dw.keepTable, 'Value', 1);
    
else
    set(this.GUI.handles.dw.keepTable, 'Value', 0);
end;

%% get local data for previous day (only once)
% get any row of the previous day
prevDayRows = DWFilterTable(this, sprintf('day = %s', prevDay));

% if no previous day rows found, get them
if isempty(prevDayRows);
    % fetch rows and update table
    OCIA_onlineAnalysis_behavExp_fetchRowsAndUpdateTable(this, currAnimal, prevDay, 'local');
end;

%% get local data for current day
% fetch rows and update table
set(this.GUI.handles.dw.keepTable, 'Value', 1);
OCIA_onlineAnalysis_behavExp_fetchRowsAndUpdateTable(this, currAnimal, currDay, 'local');

% mark rows as local rows
set(this, 'all', 'loc', 'local');
DWUpdateColumnsDisplay(this, 1 : size(this.dw.table, 1), 'loc', false);

% get the path to the local folder where this day should be
animPath = sprintf('%s%s/', this.path.localData, currAnimal);
dayPath = sprintf('%s%s/', animPath, currDay);

% create the folder if it does not exist
if exist(dayPath, 'dir') ~= 7; mkdir(dayPath); end;

% get any empty day or animal row
emptyDayRowIndex = str2double(get(this, 'all', 'rowNum', DWFilterTable(this, 'rowType ~= (Day|Animal)')));
% if any, remove them and display the table to update the row list
if ~any(isnan(emptyDayRowIndex));
    this.dw.table(emptyDayRowIndex, :) = [];
    DWDisplayTable(this);
end;

%% get remote data for current day
% fetch rows and update table
OCIA_onlineAnalysis_behavExp_fetchRowsAndUpdateTable(this, [], currDay, 'remote');
% get the non-local rows (new rows)
nonLocalRows = DWFilterTable(this, 'loc != local');
% abort if no new data
if isempty(nonLocalRows);
    showWarning(this, sprintf('OCIA:%s:NoNewData', mfilename()), 'OnlineAnalysis: no new data in remote folder.');
    return;
end;
% mark new rows as remote rows
set(this, str2double(get(this, 'all', 'rowNum', nonLocalRows)), 'loc', 'remote');
DWUpdateColumnsDisplay(this, 1 : size(this.dw.table, 1), 'loc', false);

%% fetch remote imaging data and copy it locally to the correct spot
OCIA_onlineAnalysis_behavExp_getRemoteImgDataToSpots(this, currAnimal, currDay);

%% fetch remote imaging data with no spot and copy it locally
OCIA_onlineAnalysis_behavExp_getRemoteNoSpotImgData(this, currAnimal, currDay);

%% fetch remote behavior data folders
OCIA_onlineAnalysis_behavExp_getRemoteBehavData(this, currAnimal, currDay);

%% fetch remote notebooks
OCIA_onlineAnalysis_behavExp_getRemoteNotebooks(this, currAnimal, currDay);

%% show state of the found rows
showMessage(this, 'OnlineAnalysis: showing all rows ...', 'yellow');
DWDisplayTable(this);
drawnow();
pause(1);

%% get (updated) local data
% get the remote rows and remove them
remoteRowIndexes = str2double(get(this, 'all', 'rowNum', DWFilterTable(this, 'loc = remote')));
this.dw.table(remoteRowIndexes, :) = [];

% clear the location of the table rows
set(this, 'all', 'loc', '');
DWDisplayTable(this);

% fetch rows and update table
OCIA_onlineAnalysis_behavExp_fetchRowsAndUpdateTable(this, currAnimal, currDay, 'local');

% get any empty day row
emptyDayRowIndex = str2double(get(this, 'all', 'rowNum', ...
    DWFilterTable(this, sprintf('day = %s AND rowType = Day', currDay))));
% if any, remove them and display the table to update the row list
if ~isnan(emptyDayRowIndex);
    this.dw.table(emptyDayRowIndex, :) = [];
    DWDisplayTable(this);
end;


% mark rows as local rows
set(this, 'all', 'loc', 'local');
DWUpdateColumnsDisplay(this, 1 : size(this.dw.table, 1), 'loc', false);

%% final update of the table
DWMakeTableUnique(this, { 'isRef', 'data', 'behav', 'runType', 'runNum', 'comments' });
% reset trial and redo-matching
trialRows = DWFilterTable(this, 'runType = Trial');
trialRowIndexes = str2double(get(this, 'all', 'rowNum', trialRows));
if ~any(isnan(trialRowIndexes));
    set(this, trialRowIndexes, 'runType', '');
    DWMatchBehavTrialsToImagingData(this);
end;
DWDisplayTable(this);


%% error catch
catch err;
    
    % disable the online analysis
    OCIA_dataWatcherProcess_onlineAnalysis(this, 'abort');
    showWarning(this, sprintf('OCIA:%s:UnknownError', mfilename()), sprintf( ...
        'An error occured during the online analysis: %s (%s)\n%s', err.message, err.identifier, getStackText(err)), ...
        'red');
    
end;

o('#%s(): done (%03.1f sec).', mfilename(), toc(totalTic), 1, this.verb);
    
end
