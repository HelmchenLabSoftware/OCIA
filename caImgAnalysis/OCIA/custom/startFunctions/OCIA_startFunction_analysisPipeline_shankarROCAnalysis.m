function OCIA_startFunction_analysisPipeline_shankarROCAnalysis(this)
% OCIA_startFunction_analysisPipeline_shankarROCAnalysis - [no description]
%
%       OCIA_startFunction_analysisPipeline_shankarROCAnalysis(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% remove PNG saving warning
warning('off', 'MATLAB:LargeImage');
warning('off', 'MATLAB:table:RowsAddedExistingVars');
warning('off', 'MATLAB:table:RowsAddedNewVars');      

% shorten the name of functions
plotAndSave = @OCIA_analysis_updatePlotAndSave;
setIfExists = @OCIA_analysis_setIfExists;

%% get all the IDs triplets (animal, day, spot)
OCIAChangeMode(this, 'DataWatcher');

% get the DataWatcher's GUI handle
dwh = this.GUI.handles.dw;

% set the watch types
set(dwh.watchTypes.animal,      'Value', 1);
set(dwh.watchTypes.day,         'Value', 1);
set(dwh.watchTypes.spot,        'Value', 1);

% update the table
DWProcessWatchFolder(this);

IDsTable = get(this, 'all', { 'animal', 'day', 'spot' }, DWFilterTable(this, 'rowType = Region'));
nRows = size(IDsTable, 1);

% % exclude some rows
% IDsTable(strcmp(IDsTable(:, 1), 'Mouse 0') | strcmp(IDsTable(:, 1), 'Mouse 2'), :) = [];
% nRows = size(IDsTable, 1);

return;

%% process all IDs triplets
% set the watch types
set(dwh.watchTypes.animal,      'Value', 1);
set(dwh.watchTypes.day,         'Value', 1);
set(dwh.watchTypes.spot,        'Value', 1);
set(dwh.watchTypes.img,         'Value', 1);
set(dwh.watchTypes.behavtext,   'Value', 1);
set(dwh.watchTypes.notebook,    'Value', 1);
set(dwh.watchTypes.roiset,      'Value', 1);

shortAnimID = '';

% % create a storage table to extract summarizing numbers
% tableIDs = { 'animal', 'day', 'spot', 'depth', 'ROIID' };
% ROITable = cell2table( {'', '', '', 0, '' }, 'VariableNames', tableIDs); 
% ROITable(:, :) = [];
% save([this.path.OCIASave, 'ROITable.mat'], 'ROITable');
% % initialize the table's saving start point
% iROIStart = 0;

% go through every row
for iRow = 1 : nRows;

    try
    
%     % make sure matlab pool is closed after every animal to avoid memory problems
%     if ~isempty(shortAnimID) && ~strcmpi(shortAnimID, regexprep(IDsTable{iRow, 1}, ' ', ''));
%         try
%             delete(gcp);
%         catch
%             o('#%s: /!\\ ERROR deleting parallel pool...', mfilename(), 0, 0);
%         end;
%     end;
%     
%     % start parallel pool if not existing yet
%     if isempty(gcp);
%         parpool(feature('numCores'));
%     end;
    
    %%  - load
    % extract IDs
    [animID, dayID, spotID] = IDsTable{iRow, :};
    shortAnimID = regexprep(animID, ' ', '');
    
    % only save plots for mouse 0
%     if strcmpi(shortAnimID, 'mouse0');
        doSavePlots = 1;
%     else
%         doSavePlots = 0;
%     end;
    
    % set filters
    set(dwh.filt.animalID,  'String', { animID }, 'Value', 1);
    set(dwh.filt.dayID,     'String', { dayID }, 'Value', 1);
    set(dwh.filt.spotID,    'String', { spotID }, 'Value', 1);
    
    % update the table
    DWProcessWatchFolder(this);
    
    % filter for the imaging rows
    set(dwh.filt.rowTypeID, 'String', { 'Imaging data' }, 'Value', 1);
    set(dwh.filt.dataLoadStatus, 'String', '');
    DWFilterSelectTable(this, 'new');
    
    % load calcium data
    set(dwh.SLROptDataList, 'Value', [3 5]);
    animalLoadPath = sprintf('%s%s/%s/%s%snolick.h5', this.path.rawData, animID, dayID, animID, spotID);
    DWLoad(this, animalLoadPath);
        
    % selected fully loaded traces
    set(dwh.filt.dataLoadStatus, 'String', 'caTraces = full');
    DWFilterSelectTable(this, 'new');
    if isempty(this.dw.selectedTableRows); continue; end;
        
%     o(' - Removing first frame(s) from all calcium traces data so that frame number is always 299.', 0, 0);
%     caData = getData(this, this.dw.selectedTableRows, 'caTraces', 'data');
%     for iCaDataRow = 1 : numel(caData);
%         caDataForRow = caData{iCaDataRow};
%         if size(caDataForRow, 2) ~= 299;
%             caData{iCaDataRow} = caDataForRow(:, 2 : end);
%         end;
%     end;
%     setData(this, this.dw.selectedTableRows, 'caTraces', 'data', caData);
    
    % go to analysis mode
    OCIA_dataWatcherProcess_analyseRows(this);
    
    %% - analysis
    % get the DataWatcher's and the Analyser's GUI handle
    dwh = this.GUI.handles.dw;
    anh = this.GUI.handles.an;
    
    % select all rows
    ANFiltRows(this);
    
    %% -- analysis: init
    % select the calcium traces plot
    set(anh.plotList, 'Value', 1);
    % get the relevant ROI names
    setIfExists(this, 'selROINames', 'Value', 1);
    ANUpdatePlot(this, 'force'); anh = this.GUI.handles.an;
    uniqueROINames = get(anh.paramPanElems.selROINames, 'String');
    % other parameters
    setIfExists(this, 'sgFiltFrameSize', 'String', 5);
    iMask = 1; setIfExists(this, 'exclFrames', 'Value', iMask, iff(iMask == 1, 'show', 'mask'));
%     setIfExists(this, 'PSPer', 'String', ...
%         '{ all, [-3], [0], [0], [5]; early, [-2], [0], [0], [0.5]; late, [-2], [0], [0.5], [1]; crossCorr, [-3], [0], [0], [3] }', ...
%         { 'all', -3, 0, 0, 5; 'early', -2, 0, 0, 0.5; 'late', -2, 0, 0.5, 1; 'crossCorr', -3, 0, 0, 3 });
%     setIfExists(this, 'PSPerID', 'String', 'all');

    % get the save path
    currentDaySavePath = sprintf('%s%s_%s/fig/%s_%s_%s_', this.path.OCIASave, shortAnimID, spotID, ...
        shortAnimID, spotID, regexprep(dayID, '_', ''));

    %% -- analysis: caTraces plot
    set(anh.plotList, 'Value', 1); % select the calcium traces plot
    setIfExists(this, 'selROINames', 'Value', 1 : numel(uniqueROINames)); % all ROIs
    setIfExists(this, 'noisyTrialsThresh', 'String', 'Inf'); % no trials/ROIs excluded
    setIfExists(this, 'selStimTypeGroups', 'Value', 1, []);
    setIfExists(this, 'selStimIDs', 'Value', 1 : 3, []);
    anh = plotAndSave(this, sprintf('%scaTracesOverview', currentDaySavePath), iMask, doSavePlots);
    
    % get ROIs valid for the current day
    ROIsForDay = get(anh.paramPanElems.selROINames, 'Value');
    ROINamesForDay = get(anh.paramPanElems.selROINames, 'String');
    nROIs = numel(ROIsForDay);
    
    
        
%     %% ROITable backup
%     % save the table
%     copyfile([this.path.OCIASave, 'ROITable.mat'], [this.path.OCIASave, 'ROITable_save.mat']);
%     save([this.path.OCIASave, 'ROITable.mat'], 'ROITable');
            
%     % update the table's start point
%     iROIStart = size(ROITable, 1);
    
    
    catch err;
        
        o('Aborted processing for %s_%s_%s ("%s"): %s%s', this.path.OCIASave, shortAnimID, spotID, ...
            shortAnimID, spotID, regexprep(dayID, '_', ''), err.identifier, err.message, getStackText(err), 0, 0);
        
    end;
    
end;
%    
% % save the table
% save('ROITable.mat', 'ROITable');
        
warning('on', 'MATLAB:LargeImage');
warning('on', 'MATLAB:table:RowsAddedExistingVars');
warning('on', 'MATLAB:table:RowsAddedNewVars');

end
