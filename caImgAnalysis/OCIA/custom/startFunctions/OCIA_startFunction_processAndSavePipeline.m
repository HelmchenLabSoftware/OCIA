function OCIA_startFunction_processAndSavePipeline(this)
% OCIA_startFunction_processAndSavePipeline - [no description]
%
%       OCIA_startFunction_processAndSavePipeline(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% init
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

% check if the table is empty
if size(this.dw.table, 1) < 2;
    showMessage(this, 'Table is empty. Aborting');
    return;
end;

% filter and select the table
DWFilterSelectTable(this, 'new');

%% extract short animal ID
selAnimalID = get(this.GUI.handles.dw.filt.animalID, 'Value');
if isempty(selAnimalID) || selAnimalID == 0;
    return;
end;
animalID = regexprep(this.dw.animalIDs{selAnimalID}, 'mou_[db]l_', '');

%% hack for changing the analysis conditions depending on the mouse type
% animal with ID bigger then
if strcmp(animalID(1 : 6), '150217') && str2double(animalID(end - 1 : end)) >= 5;
    this.an.img.chanVect = 2; % GCaMP6m, green channel => channel 2
elseif strcmp(animalID(1 : 6), '150217') && str2double(animalID(end - 1 : end)) <= 4;
    this.an.img.chanVect = [1 2]; % YCN140, green AND blue channel => channel 1 and 2
end;

%% process and save
try
    DWSave(this, sprintf('%s%s.h5', this.path.OCIASave, animalID));
catch err;

    showWarning(this, 'OCIA:OCIAStartFunction:saveError', sprintf('Error while saving: %s (%s)\n%s', ...
       err.message, err.identifier, getStackText(err)), 'red');
end;

end
