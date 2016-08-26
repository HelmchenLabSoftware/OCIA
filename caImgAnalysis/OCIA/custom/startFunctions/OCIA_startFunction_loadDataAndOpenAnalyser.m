function OCIA_startFunction_loadDataAndOpenAnalyser(this)
% OCIA_startFunction_loadDataAndOpenAnalyser - [no description]
%
%       OCIA_startFunction_loadDataAndOpenAnalyser(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% get all the imaging data
OCIAChangeMode(this, 'DataWatcher');

% get the DataWatcher's GUI handle
dwh = this.GUI.handles.dw;

baseAnimalIDs = unique({ '-', this.dw.animalIDs{get(dwh.filt.animalID, 'Value')} });
baseSpotIDs = unique({ '-', this.dw.spotIDs{get(dwh.filt.spotID, 'Value')} });
baseDayIDs = unique({ '-', this.dw.dayIDs{get(dwh.filt.dayID, 'Value')} });

% set the watch types
set(dwh.watchTypes.animal,      'Value', 1);
set(dwh.watchTypes.day,         'Value', 1);
set(dwh.watchTypes.spot,        'Value', 1);
set(dwh.watchTypes.img,         'Value', 1);
set(dwh.watchTypes.notebook,    'Value', 1);
set(dwh.watchTypes.behav,       'Value', 1);
set(dwh.watchTypes.roiset,      'Value', 1);
set(dwh.watchTypes.intrinsic,   'Value', 0);

% set the filters (using the last animal, day, spot)
set(dwh.filt.animalID,          'Value', numel(baseAnimalIDs), 'String', baseAnimalIDs);
set(dwh.filt.dayID,             'Value', numel(baseDayIDs), 'String', baseDayIDs);
set(dwh.filt.spotID,            'Value', numel(baseSpotIDs), 'String', baseSpotIDs);
set(dwh.filt.rowTypeID,         'Value', 1, 'String', { '-' });
set(dwh.filt.dataLoadStatus,    'Value', 0, 'String', '');
set(dwh.filt.rowNum,            'Value', 0, 'String', '');
set(dwh.filt.runNum,            'Value', 0, 'String', '');
set(dwh.filt.all,               'Value', 0, 'String', '');

% update the table
DWProcessWatchFolder(this);

% get the updated lists
animalIDs = this.dw.animalIDs(2 : end);
spotIDs = this.dw.spotIDs(2 : end); %#ok<NASGU>
dayIDs = this.dw.dayIDs(2 : end); %#ok<NASGU>

%% load data for all animals
for iAnim = 1 : numel(animalIDs);
    % skip irrelevant animal IDs
    if numel(baseAnimalIDs) ~= 1 && ~ismember(animalIDs{iAnim}, baseAnimalIDs); continue; end;
    % get the short animal ID from the full form
    shortAnimalID = regexprep(regexprep(animalIDs{iAnim }, 'mou_[bd]l_', ''), '_', '');
    % set the filters and select the rows
    set(dwh.filt.animalID,          'Value', iAnim + 1);
    set(dwh.filt.all,               'Value', 0, 'String', sprintf('runType = Trial AND day != 2014_10_25'));
    set(dwh.filt.dataLoadStatus,    'Value', 0, 'String', '');
    set(dwh.SLROptDataList,         'Value', find(ismember(get(dwh.SLROptDataList, 'String'), ...
        { 'Calcium traces', 'Stimulus vectors', 'Exclusion masks' })));
    DWFilterSelectTable(this, 'new');  
    % load the data from the right file
    DWLoad(this, sprintf('%s%s_%s.h5', this.path.OCIASave, shortAnimalID(1 : 6), shortAnimalID(7 : 8)));
end;

%% switch to analyser
% set the filters and select the rows
set(dwh.filt.animalID,          'Value', numel(baseAnimalIDs));
set(dwh.filt.all,               'Value', 0, 'String', 'runType = Trial');
set(dwh.filt.dataLoadStatus,    'Value', 0, 'String', 'caTraces = full');
DWFilterSelectTable(this, 'new');
% go to analyser mode
OCIA_dataWatcherProcess_analyseRows(this);
    
end  
