function OCIA_startFunction_loadDataAndOpenAnalyserFromGUI(this)
% OCIA_startFunction_loadDataAndOpenAnalyserFromGUI - [no description]
%
%       OCIA_startFunction_loadDataAndOpenAnalyserFromGUI(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% get all the imaging data
OCIAChangeMode(this, 'DataWatcher');

% get the DataWatcher's GUI handle
dwh = this.GUI.handles.dw;

% save options
this.dw.dataSaveOptionsConfig{'saveGUI',            'defaultOn'} = true;
this.dw.dataSaveOptionsConfig{'overwriteSaveFile',  'defaultOn'} = false;
this.dw.dataSaveOptionsConfig{'procBefSave',        'defaultOn'} = true;
this.dw.dataSaveOptionsConfig{'flushAfterSave',     'defaultOn'} = false;
this.dw.dataSaveOptionsConfig{'HDF5GZip',           'defaultOn'} = false;
this.dw.dataSaveOptionsConfig{'HDF5OverwriteData',  'defaultOn'} = true;
this.dw.dataSaveOptionsConfig{'procDataShowDebug',  'defaultOn'} = false;

% save options
set(dwh.procOptsList, 'Value', []);
set(dwh.SLROptDataList, 'Value', []);
set(dwh.SLROpts.saveGUI, 'Value', 1);

% store selection
animalID = this.dw.animalIDs{get(dwh.filt.animalID, 'Value')};
shortAnimalID = regexprep(animalID, 'mou_bl_', '');
dayID = this.dw.dayIDs{get(dwh.filt.dayID, 'Value')};
spotID = this.dw.spotIDs{get(dwh.filt.spotID, 'Value')};

% load GUI
% DWLoad(this, sprintf('%sGUI.mat', this.path.OCIASave));
DWLoad(this, sprintf('%s%s__GUI.mat', this.path.OCIASave, shortAnimalID));
allPaths = get(this, 'all', 'path');
newPaths = regexprep(allPaths, this.dw.watchFolder, this.path.localData);
set(this, 'all', 'path', newPaths);
this.dw.watchFolder = this.path.localData;
set(this.GUI.handles.dw.watchFoldDisp, 'String', sprintf('Watch folder: " %s "', this.dw.watchFolder));

% restore selection
set(dwh.filt.animalID, 'Value', find(strcmp(this.dw.animalIDs, animalID)));
set(dwh.filt.dayID, 'Value', find(strcmp(this.dw.dayIDs, dayID)));
set(dwh.filt.spotID, 'Value',find(strcmp(this.dw.spotIDs, spotID)));

% set the watch types
set(dwh.watchTypes.animal,      'Value', 1);
set(dwh.watchTypes.day,         'Value', 1);
set(dwh.watchTypes.spot,        'Value', 1);
set(dwh.watchTypes.img,         'Value', 1);
set(dwh.watchTypes.notebook,    'Value', 1);
set(dwh.watchTypes.behav,       'Value', 1);
set(dwh.watchTypes.roiset,      'Value', 1);
set(dwh.watchTypes.intrinsic,   'Value', 0);

% set the filters
set(dwh.filt.rowTypeID,         'Value', 1);
set(dwh.filt.dataLoadStatus,    'String', '');
set(dwh.filt.rowNum,            'String', '');
set(dwh.filt.runNum,            'String', '');
set(dwh.filt.all,               'String', 'runType = Trial');
pause(0.5); % wait to avoid Java exception
DWFilterSelectTable(this, 'new');

% select data type filters
set(dwh.SLROptDataList,         'Value', find(ismember(get(dwh.SLROptDataList, 'String'), ...
    { 'Calcium traces', 'Stimulus vectors', 'Exclusion masks' }))); 
% load the data from the right file
DWLoad(this, sprintf('%s1502_chronic.h5', this.path.OCIASave));

%% switch to analyser
% set the filters and select the rows
set(dwh.filt.dataLoadStatus,    'String', 'caTraces = full');
DWFilterSelectTable(this, 'new');
% go to analyser mode
OCIA_dataWatcherProcess_analyseRows(this);
    
end  
