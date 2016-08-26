function OCIA_startFunction_dataWatcherLoadAnalyse(this)
% OCIA_startFunction_dataWatcherLoadAnalyse - [no description]
%
%       OCIA_startFunction_dataWatcherLoadAnalyse(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% go to DataWatcher mode
OCIAChangeMode(this, 'DataWatcher');

% create the string showing the selected watch types
if ischar(this.GUI.dw.DWWatchTypes);
    DWWatchTypesStr = this.GUI.dw.DWWatchTypes;
elseif iscell(this.GUI.dw.DWWatchTypes);
    DWWatchTypesStr = ['|', sprintf('%s|', this.GUI.dw.DWWatchTypes{:})];
else
    DWWatchTypesStr = '?';
end;

% create the string showing the selected filters
DWFiltStr = ['|', sprintf('%s|', this.GUI.dw.DWFilt{:})];
% create the string showing the processing options
selectedProcOptionsIDs = this.an.procOptions.id(this.an.procOptions.defaultOn);
ANProcOptions = ['|', sprintf('%s|', selectedProcOptionsIDs{:})];
% create the string showing the processing options
selectedDataSaveOptionsIDs = this.dw.dataSaveOptionsConfig.id(this.dw.dataSaveOptionsConfig.defaultOn);
DWSaveOptions = ['|', sprintf('%s|', selectedDataSaveOptionsIDs{:})];
% create the string showing the processing options
selectedDataToSaveIDs = this.main.dataConfig.id(find(this.main.dataConfig.defaultOn)); %#ok<FNDSB>
DWDataToSave = ['|', sprintf('%s|', selectedDataToSaveIDs{:})];
% get this start function's name
startFunctionName = regexprep(mfilename(), 'OCIA_startFunction_', '');

% show the selected options
showMessage(this, sprintf(['Processing options: start function: %s, noGUI: %s, skipMeta: %s, filters: %s, ', ...
    'watchTypes: %s, procOptions: %s, saveOptions: %s, dataToSave: %s, rawOrLocal: %s.'], ...
    startFunctionName, iff(this.GUI.noGUI, 'true', 'false'), iff(this.GUI.dw.DWSkiptMeta, 'true', 'false'), ...
    DWFiltStr, DWWatchTypesStr, ANProcOptions, DWSaveOptions, DWDataToSave, this.GUI.dw.DWRawOrLocal));


%% process table and filter-select the rows
% process the selected folder
DWProcessWatchFolder(this);
pause(0.5);

% check if the table is empty
if size(this.dw.table, 1) < 2;
    showMessage(this, 'Table is empty. Aborting');
    return;
end;


% filter and select the table
DWFilterSelectTable(this, 'new');

%% load the data
animalID = regexprep(get(this, this.dw.selectedTableRows(1), 'animal'), 'mou_[bd]l_', '');
loadPath = sprintf('%s%s.h5', this.path.OCIASave, animalID);
DWLoad(this, loadPath);

% filter the table for available data only
set(this.GUI.handles.dw.filt.dataLoadStatus, 'String', 'caTraces = full');
DWFilterSelectTable(this, 'new');

%% analyse the data
OCIA_dataWatcherProcess_analyseRows(this);
    
end
