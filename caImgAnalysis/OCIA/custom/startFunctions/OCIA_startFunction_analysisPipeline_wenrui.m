function OCIA_startFunction_analysisPipeline_wenrui(this)
% OCIA_startFunction_analysisPipeline_wenrui - [no description]
%
%       OCIA_startFunction_analysisPipeline_wenrui(this)
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

IDsTable = get(this, 'all', { 'animal', 'day', 'spot' }, DWFilterTable(this, 'rowType = Spot'));
nRows = size(IDsTable, 1);
o('#%s: found %02d rows to process...', mfilename, nRows, 0, 0);

% % exclude some rows
% IDsTable(strcmp(IDsTable(:, 1), 'Mouse 0') | strcmp(IDsTable(:, 1), 'Mouse 2'), :) = [];
% nRows = size(IDsTable, 1);

%% process all IDs triplets
% set the watch types
set(dwh.watchTypes.animal,      'Value', 1);
set(dwh.watchTypes.day,         'Value', 1);
set(dwh.watchTypes.spot,        'Value', 1);
set(dwh.watchTypes.img,         'Value', 1);
set(dwh.watchTypes.whisk,       'Value', 1);
set(dwh.watchTypes.roiset,      'Value', 1);

% return;

% % general variable for saving plots
% doSavePlots = 0;

shortAnimID = '';

% create a storage table to extract summarizing numbers
tableIDs = { 'animal', 'day', 'spot', 'depth', 'ROIID' };
ROITable = cell2table( {'', '', '', 0, '' }, 'VariableNames', tableIDs); 
ROITable(:, :) = [];

% check if the table does not already exist
if exist([this.path.OCIASave, 'ROITable.mat'], 'file');

    o('#%s: ROITable file exists ...', mfilename, 0, 0);
    load([this.path.OCIASave, 'ROITable.mat'], 'ROITable');

    alreadyProcessedRows = arrayfun(@(iRow) any(ismember(ROITable.animal, IDsTable{iRow, 1}) ...
        & ismember(ROITable.day, IDsTable{iRow, 2}) & ismember(ROITable.spot, IDsTable{iRow, 3})), 1 : nRows)';
    
    % exclude already processed rows
    IDsTable(alreadyProcessedRows, :) = [];
    nRows = size(IDsTable, 1);

    o('#%s: updated number of rows to process: %02d ...', mfilename, nRows, 0, 0);

end;

save([this.path.OCIASave, 'ROITable.mat'], 'ROITable');
% initialize the table's saving start point
iROIStart = size(ROITable, 1);

% go through every row
for iRow = 1 : nRows;

    try
    
    % make sure matlab pool is closed after every animal to avoid memory problems
    if ~isempty(shortAnimID) && ~strcmpi(shortAnimID, regexprep(IDsTable{iRow, 1}, ' ', ''));
        try
            delete(gcp);
        catch
            o('#%s: /!\\ ERROR deleting parallel pool...', mfilename(), 0, 0);
        end;
    end;
    
    % start parallel pool if not existing yet
    if isempty(gcp);
        parpool(feature('numCores'));
    end;
    
    %%  - load
    % extract IDs
    [animID, dayID, spotID] = IDsTable{iRow, :};
    shortAnimID = regexprep(animID, ' ', '');
    
    o('#%s: row %02d: %s, %s, %s ...', mfilename, nRows, animID, dayID, spotID, 0, 0);
    
    % only save plots for mouse 0
%     if strcmpi(shortAnimID, 'mouse0');
%         doSavePlots = 1;
%     else
        doSavePlots = 0;
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
    set(dwh.SLROptDataList, 'Value', 3);
    animalLoadPath = sprintf('%s%s/%s.h5', this.path.rawData, animID, shortAnimID);
    DWLoad(this, animalLoadPath);
        
    % selected fully loaded traces
    set(dwh.filt.dataLoadStatus, 'String', 'caTraces = full');
    DWFilterSelectTable(this, 'new');
    
    o('#%s: row %02d, %s, %s, %s: %02d selected table row ...', mfilename, nRows, animID, dayID, spotID, ...
        numel(this.dw.selectedTableRows), 0, 0);
    
    % abort if no rows
    if isempty(this.dw.selectedTableRows); continue; end;
        
    o('#%s: removing first frame(s) from all calcium traces data so that frame number is always 299.', ...
        mfilename, 0, 0);
    caData = getData(this, this.dw.selectedTableRows, 'caTraces', 'data');
    for iCaDataRow = 1 : numel(caData);
        caDataForRow = caData{iCaDataRow};
        if size(caDataForRow, 2) ~= 299;
            caData{iCaDataRow} = caDataForRow(:, 2 : end);
        end;
    end;
    setData(this, this.dw.selectedTableRows, 'caTraces', 'data', caData);
    
    % go to analysis mode
    OCIA_dataWatcherProcess_analyseRows(this);
    
    %% - analysis
    % get the DataWatcher's and the Analyser's GUI handle
    dwh = this.GUI.handles.dw;
    anh = this.GUI.handles.an;
    
    % select all rows
    ANFiltRows(this);
    
    %% -- analysis: init
    o('#%s: row %02d, %s, %s, %s: init ...', mfilename, nRows, animID, dayID, spotID, 0, 0);
    % select the calcium traces plot
    set(anh.plotList, 'Value', 1);
    % get the relevant ROI names
    setIfExists(this, 'selROINames', 'Value', 1);
    ANUpdatePlot(this, 'force'); anh = this.GUI.handles.an;
    uniqueROINames = get(anh.paramPanElems.selROINames, 'String');
    % other parameters
    setIfExists(this, 'sgFiltFrameSize', 'String', 5);
    iMask = 1; setIfExists(this, 'exclFrames', 'Value', iMask, iff(iMask == 1, 'show', 'mask'));
    setIfExists(this, 'PSPer', 'String', ...
        '{ all, [-3], [0], [0], [5]; early, [-2], [0], [0], [0.5]; late, [-2], [0], [0.5], [1]; crossCorr, [-3], [0], [0], [3] }', ...
        { 'all', -3, 0, 0, 5; 'early', -2, 0, 0, 0.5; 'late', -2, 0, 0.5, 1; 'crossCorr', -3, 0, 0, 3 });
    setIfExists(this, 'PSPerID', 'String', 'all');

    % get the save path
    currentDaySavePath = sprintf('%s%s_%s/fig/%s_%s_%s_', this.path.OCIASave, shortAnimID, spotID, ...
        shortAnimID, spotID, regexprep(dayID, '_', ''));

    %% -- analysis: caTraces plot
    o('#%s: row %02d, %s, %s, %s: caTraces plot ...', mfilename, nRows, animID, dayID, spotID, 0, 0);
    set(anh.plotList, 'Value', 1); % select the calcium traces plot
    setIfExists(this, 'selROINames', 'Value', 1 : numel(uniqueROINames)); % all ROIs
    setIfExists(this, 'noisyTrialsThresh', 'String', 'Inf'); % no trials/ROIs excluded
    setIfExists(this, 'selStimTypeGroups', 'Value', 1, []); % first stim selected (no stim)
    anh = plotAndSave(this, sprintf('%scaTracesOverview', currentDaySavePath), iMask, doSavePlots);
    
    % get ROIs valid for the current day
    ROIsForDay = get(anh.paramPanElems.selROINames, 'Value');
    ROINamesForDay = get(anh.paramPanElems.selROINames, 'String');
    nROIs = numel(ROIsForDay);

    %% -- analysis: caTraces heat map plot
    o('#%s: row %02d, %s, %s, %s: caTraces heat map plot ...', mfilename, nRows, animID, dayID, spotID, 0, 0);
    set(anh.plotList, 'Value', 2); % select the calcium traces heat map plot
    setIfExists(this, 'colormap', 'Value', 1, 'gray');
    anh = plotAndSave(this, sprintf('%scaTracesOverview_HeatMap', currentDaySavePath), iMask, doSavePlots);
    
    %% -- analysis: plots with different whisker traces types
    o('#%s: row %02d, %s, %s, %s: whisker trace types plots ...', mfilename, nRows, animID, dayID, spotID, 0, 0);
    % parameters for stim vector detection
    whiskTraceParams = {
        'all',          1000, 1, 1, 1;
        'envelope',     2, 0.3, 1.5, 0.1;
        'set point',    2, 0.3, 1.5, 0.1;
        'exploratory',  2, 0.3, 1.5, 0.1;
    };
    % get all the trace types
    whiskTraceTypes = { 'raw', 'envelope', 'amplitude', 'set point', 'exploratory', 'foveal' };
    
    % loop through all the trace types to process
    for iWhiskTraceType = 1 : size(whiskTraceParams, 1);
        
        % extract parameters
        [traceType, stimVectMinStartTime, stimVectPeakSTDThresh, stimVectInterPeakDistThresh, ...
            stimVectPeakStartThreshold] = whiskTraceParams{iWhiskTraceType, :};
        traceTypeDisplay = regexprep(traceType, ' ', '');
        
        o('#%s: row %02d, %s, %s, %s, %s (%02d/%02d): init ...', mfilename, nRows, animID, dayID, spotID, ...
            traceType,  iWhiskTraceType, size(whiskTraceParams, 1), 0, 0);
        ANClearData(this); % clear cache
        
        set(anh.plotList, 'Value', 3); % select the calcium traces with whisker traces plot
        setIfExists(this, 'sgFiltFrameSize', 'String', 5); % filtering on for display
        setIfExists(this, 'allStimIDs', 'String', '{ ., . }', { '.', '.' }); % remove stim name or this plot
        
        % set scaling
        if nROIs < 15;  setIfExists(this, 'traceScaling', 'String', 20, [], 'whisk');
        else            setIfExists(this, 'traceScaling', 'String', 40, [], 'whisk');
        end;
        
        if strcmp(traceType, 'all');
            setIfExists(this, 'selWhiskTraceType', 'Value', 1, 'raw', 'whisk');
            setIfExists(this, 'shownWhiskTraceType', 'Value', 1 : numel(whiskTraceTypes), whiskTraceTypes, 'whisk');
        else
            iTrace = find(strcmp(whiskTraceTypes, traceType));
            setIfExists(this, 'selWhiskTraceType', 'Value', iTrace, whiskTraceTypes{iTrace}, 'whisk');
            setIfExists(this, 'shownWhiskTraceType', 'Value', iTrace, whiskTraceTypes{iTrace}, 'whisk');
        end;
        
        % set stim vector detection parameters
        setIfExists(this, 'stimVectMinStartTime', 'String', stimVectMinStartTime, [], 'whisk');
        setIfExists(this, 'stimVectPeakSTDThresh', 'String', stimVectPeakSTDThresh, [], 'whisk');
        setIfExists(this, 'stimVectInterPeakDistThresh', 'String', stimVectInterPeakDistThresh, [], 'whisk');
        setIfExists(this, 'stimVectPeakStartThreshold', 'String', stimVectPeakStartThreshold, [], 'whisk');
                
        %% --- analysis: caTraces with whisker traces
        o('#%s: row %02d, %s, %s, %s, %s (%02d/%02d): caTraces with whisker traces ...', mfilename, nRows, ...
            animID, dayID, spotID, traceType, iWhiskTraceType, size(whiskTraceParams, 1), 0, 0);
        % save the plot
        anh = plotAndSave(this, sprintf('%scaTracesAndWhiskTraceOverview_%s', currentDaySavePath, ...
            traceTypeDisplay), iMask, doSavePlots);
        
        if strcmp(traceType, 'all'); continue; end;
        
        %% --- analysis: PS average analysis
        o('#%s: row %02d, %s, %s, %s, %s (%02d/%02d): PS average analysis ...', mfilename, nRows, ...
            animID, dayID, spotID, traceType, iWhiskTraceType, size(whiskTraceParams, 1), 0, 0);
        % store stimulus vector
        OCIA_analysis_storeStimVectorsFromWhiskTraces(this);
        ANClearData(this); % clear cache
        set(anh.plotList, 'Value', 10); % select the PS average heat map plot
        setIfExists(this, 'sgFiltFrameSize', 'String', 1); % filtering off for analysis
        % name the stimulus for this plot
        setIfExists(this, 'allStimIDs', 'String', sprintf('{ %s, . }', traceTypeDisplay), { traceTypeDisplay, '.' });
        % save the plot
        plotAndSave(this, sprintf('%sPSAvgHeatMap_%s', currentDaySavePath, traceTypeDisplay), iMask, doSavePlots);
        
        %% --- analysis: save statistic numbers 
        o('#%s: row %02d, %s, %s, %s, %s (%02d/%02d): save statistic numbers (1) ...', mfilename, nRows, ...
            animID, dayID, spotID, traceType, iWhiskTraceType, size(whiskTraceParams, 1), 0, 0); 
        setIfExists(this, 'respMethod', 'Value', 3, 'sum');
        setIfExists(this, 'PSPerID', 'Value', 2, 'early');
        ANUpdatePlot(this, 'force');
        lastData = this.an.img.dataHash.(this.an.img.dataHash.lastHashID);
        ROIResp = reshape(nanmean(lastData.ROIRespTrial, 2), 1, nROIs);
        for iROI = 1 : nROIs;
            ROITable(iROIStart + iROI, tableIDs) = cell2table({ animID, dayID, spotID, 0, ROINamesForDay{iROI} });
            ROITable{iROIStart + iROI, sprintf('evokedResp_sum_%s_earlyTimeWindow', traceTypeDisplay)} ...
                = ROIResp(iROI);
        end;
        
        % {
        
        o('#%s: row %02d, %s, %s, %s, %s (%02d/%02d): save statistic numbers (2) ...', mfilename, nRows, ...
            animID, dayID, spotID, traceType, iWhiskTraceType, size(whiskTraceParams, 1), 0, 0); 
        setIfExists(this, 'respMethod', 'Value', 3, 'sum');
        setIfExists(this, 'PSPerID', 'Value', 3, 'late');
        ANUpdatePlot(this, 'force');
        lastData = this.an.img.dataHash.(this.an.img.dataHash.lastHashID);
        ROIResp = reshape(nanmean(lastData.ROIRespTrial, 2), 1, nROIs);
        for iROI = 1 : nROIs;
            ROITable{iROIStart + iROI, sprintf('evokedResp_sum_%s_lateTimeWindow', traceTypeDisplay)} ...
                = ROIResp(iROI);
        end;
        
        o('#%s: row %02d, %s, %s, %s, %s (%02d/%02d): save statistic numbers (3) ...', mfilename, nRows, ...
            animID, dayID, spotID, traceType, iWhiskTraceType, size(whiskTraceParams, 1), 0, 0); 
        setIfExists(this, 'respMethod', 'Value', 5, 'maxAbs');
        setIfExists(this, 'PSPerID', 'Value', 2, 'early');
        ANUpdatePlot(this, 'force');
        lastData = this.an.img.dataHash.(this.an.img.dataHash.lastHashID);
        ROIResp = reshape(nanmean(lastData.ROIRespTrial, 2), 1, nROIs);
        for iROI = 1 : nROIs;
            ROITable{iROIStart + iROI, sprintf('evokedResp_max_%s_earlyTimeWindow', traceTypeDisplay)} ...
                = ROIResp(iROI);
        end;
        
        o('#%s: row %02d, %s, %s, %s, %s (%02d/%02d): save statistic numbers (4) ...', mfilename, nRows, ...
            animID, dayID, spotID, traceType, iWhiskTraceType, size(whiskTraceParams, 1), 0, 0); 
        setIfExists(this, 'respMethod', 'Value', 5, 'maxAbs');
        setIfExists(this, 'PSPerID', 'Value', 3, 'late');
        ANUpdatePlot(this, 'force'); anh = this.GUI.handles.an;
        lastData = this.an.img.dataHash.(this.an.img.dataHash.lastHashID);
        ROIResp = reshape(nanmean(lastData.ROIRespTrial, 2), 1, nROIs);
        for iROI = 1 : nROIs;
            ROITable{iROIStart + iROI, sprintf('evokedResp_max_%s_lateTimeWindow', traceTypeDisplay)} ...
                = ROIResp(iROI);
        end;
        
        %% --- analysis: cross correlation
        o('#%s: row %02d, %s, %s, %s, %s (%02d/%02d): cross correlation (1) ...', mfilename, nRows, ...
            animID, dayID, spotID, traceType, iWhiskTraceType, size(whiskTraceParams, 1), 0, 0); 
        ANClearData(this);
        set(anh.plotList, 'Value', 6); % select the cross correlation heat map plot
        setIfExists(this, 'PSPerID', 'Value', 4, 'crossCorr');
        % correlation with the trace itself
        setIfExists(this, 'selCCWhiskTraceType', 'Value', iTrace, whiskTraceTypes{iTrace}, 'whisk');
        plotAndSave(this, sprintf('%scrossCorr_%s_trace', currentDaySavePath, traceTypeDisplay), iMask, doSavePlots);
        lastData = this.an.whisk.dataHash.(this.an.whisk.dataHash.lastHashID);
        for iROI = 1 : nROIs;
            ROITable{iROIStart + iROI, sprintf('crossCorr_%sTrace_bestLagTime', traceTypeDisplay)} ...
                = lastData.tMaxCrossCorr(iROI);
            ROITable{iROIStart + iROI, sprintf('crossCorr_%sTrace_valueAtBestLagTime', traceTypeDisplay)} ...
                = lastData.maxCrossCorr(iROI);
            ROITable{iROIStart + iROI, sprintf('crossCorr_%sTrace_pValueAtBestLagTime', traceTypeDisplay)} ...
                = lastData.pVals(iROI);
            ROITable{iROIStart + iROI, sprintf('crossCorr_%sTrace_isCorrSignificant', traceTypeDisplay)} ...
                = lastData.isCorrSignif(iROI);
            ROITable{iROIStart + iROI, sprintf('crossCorr_%sTrace_corrDirection', traceTypeDisplay)} ...
                = lastData.corrDirection(iROI);
        end;
        
        % correlation with the stim vector for this trace
        o('#%s: row %02d, %s, %s, %s, %s (%02d/%02d): cross correlation (2) ...', mfilename, nRows, ...
            animID, dayID, spotID, traceType, iWhiskTraceType, size(whiskTraceParams, 1), 0, 0); 
        setIfExists(this, 'selCCWhiskTraceType', 'Value', numel(whiskTraceTypes) + 1, 'stim. vector', 'whisk');
        anh = plotAndSave(this, sprintf('%scrossCorr_%s_stimVect', currentDaySavePath, traceTypeDisplay), ...
            iMask, doSavePlots);
        lastData = this.an.whisk.dataHash.(this.an.whisk.dataHash.lastHashID);
        for iROI = 1 : nROIs;
            ROITable{iROIStart + iROI, sprintf('crossCorr_%sStimVect_bestLagTime', traceTypeDisplay)} ...
                = lastData.tMaxCrossCorr(iROI);
            ROITable{iROIStart + iROI, sprintf('crossCorr_%sStimVect_valueAtBestLagTime', traceTypeDisplay)} ...
                = lastData.maxCrossCorr(iROI);
            ROITable{iROIStart + iROI, sprintf('crossCorr_%sStimVect_pValueAtBestLagTime', traceTypeDisplay)} ...
                = lastData.pVals(iROI);
            ROITable{iROIStart + iROI, sprintf('crossCorr_%sStimVect_isCorrSignificant', traceTypeDisplay)} ...
                = lastData.isCorrSignif(iROI);
            ROITable{iROIStart + iROI, sprintf('crossCorr_%sStimVect_corrDirection', traceTypeDisplay)} ...
                = lastData.corrDirection(iROI);
        end;
        %}
        
        %{
        
        %% --- analysis: reverse event detection stim averaging
        if iWhiskTraceType == 2;
            
            ANClearData(this);
            DWFlushData(this, 'all', false, 'stim'); % clear stimulus vectors
            set(anh.plotList, 'Value', 4); % select the event detection stim generator plot
            setIfExists(this, 'PSPerID', 'Value', 1, 'all');
            plotAndSave(this, sprintf('%seventDetect_xall', currentDaySavePath), iMask, doSavePlots);
            
            % plot all ROI detections
            for iROI = 1 : nROIs;
                setIfExists(this, 'selROINames', 'Value', iROI); % select ROI
                plotAndSave(this, sprintf('%seventDetect_%s', currentDaySavePath, ROINamesForDay{iROI}), iMask, doSavePlots);
            end;
            
            % select all ROIs/stimulus again
            setIfExists(this, 'selROINames', 'Value', 1 : nROIs, ROINamesForDay);
            setIfExists(this, 'selStimIDs', 'Value', 1 : nROIs, ROINamesForDay);
            ANClearData(this);
            ANUpdatePlot(this, 'force'); anh = this.GUI.handles.an;
            
            % store stimulus vector
            OCIA_analysis_storeStimVectorsFromEventDetect(this);
            
            ANClearData(this);
            setIfExists(this, 'PSPerID', 'Value', 1, 'all');
            setIfExists(this, 'allStimIDs', 'String', [ '{ ' regexprep(sprintf('%s, ', ROINamesForDay{:}), ', $', '') ' }'], ROINamesForDay);
            % plot all ROI detections
            for iROI = 1 : nROIs;
                set(anh.plotList, 'Value', 7); % select the whisker PSAvg heat map plot
                setIfExists(this, 'selROINames', 'Value', iROI, ROINamesForDay(iROI)); % select ROI
                plotAndSave(this, sprintf('%sWhiskPSAvgBasic_%s', currentDaySavePath, ROINamesForDay{iROI}), iMask, doSavePlots);
                setIfExists(this, 'selROINames', 'Value', 1 : nROIs, ROINamesForDay); % select ROI
                setIfExists(this, 'allStimIDs', 'String', [ '{ ' regexprep(sprintf('%s, ', ROINamesForDay{:}), ', $', '') ' }'], ROINamesForDay);
                ANClearData(this);
                setIfExists(this, 'selStimIDs', 'Value', iROI, ROINamesForDay(iROI)); % select ROI
                set(anh.plotList, 'Value', 8); % select the whisker PSAvg heat map plot
                plotAndSave(this, sprintf('%sWhiskPSAvgHeatMap_%s', currentDaySavePath, ROINamesForDay{iROI}), iMask, doSavePlots);
            end;
            
            set(anh.plotList, 'Value', 7); % select the whisker PSAvg heat map plot
            ANUpdatePlot(this, 'force'); anh = this.GUI.handles.an;
            stimIDs = get(anh.paramPanElems.selStimIDs, 'String');
            
            % select all ROIs/stimulus again
            setIfExists(this, 'selROINames', 'Value', 1 : nROIs, ROINamesForDay);
            setIfExists(this, 'allStimIDs', 'String', [ '{ ' regexprep(sprintf('%s, ', stimIDs{:}), ', $', '') ' }'], stimIDs);
            setIfExists(this, 'selStimIDs', 'Value', 1 : numel(stimIDs), stimIDs');
            setIfExists(this, 'PSPerID', 'Value', 2, 'early');
            setIfExists(this, 'respMethod', 'Value', 3, 'sum');
            ANClearData(this);
            ANUpdatePlot(this, 'force');
            
            setIfExists(this, 'selStimIDs', 'Value', 1 : numel(stimIDs), stimIDs);
            ANUpdatePlot(this, 'force');
            
            lastData = this.an.img.dataHash.(this.an.img.dataHash.lastHashID);
            nTraceTypes = size(lastData.ROIRespTrial, 3);
            ROIResp = reshape(nanmean(lastData.ROIRespTrial, 2), size(lastData.ROIRespTrial, 1), nTraceTypes);
            iROILoop = 1;
            for iROI = 1 : nROIs;
                if ~ismember(ROINamesForDay{iROI}, lastData.params.selStimIDs); continue; end;
                for iTraceType2 = 1 : nTraceTypes
                    traceType2 = whiskTraceTypes{iTraceType2};
                    traceTypeDisplay2 = regexprep(traceType2, ' ', '');
                    if ismember(traceType2, whiskTraceParams(:, 1));
                        ROITable{iROIStart + iROI, sprintf('eventDetect_%s_sum_earlyTimeWindow', traceTypeDisplay2)} ...
                            = ROIResp(iROI, iTraceType2);
                    end;
                end;
                iROILoop = iROILoop + 1;
            end;
            
            setIfExists(this, 'PSPerID', 'Value', 3, 'late');
            setIfExists(this, 'respMethod', 'Value', 5, 'maxAbs');
            ANClearData(this);
            ANUpdatePlot(this, 'force'); anh = this.GUI.handles.an;
            lastData = this.an.img.dataHash.(this.an.img.dataHash.lastHashID);
            nTraceTypes = size(lastData.ROIRespTrial, 3);
            ROIResp = reshape(nanmean(lastData.ROIRespTrial, 2), size(lastData.ROIRespTrial, 1), nTraceTypes);
            iROILoop = 1;
            for iROI = 1 : nROIs;
                if ~ismember(ROINamesForDay{iROI}, lastData.params.selStimIDs); continue; end;
                for iTraceType2 = 1 : nTraceTypes
                    traceType2 = whiskTraceTypes{iTraceType2};
                    traceTypeDisplay2 = regexprep(traceType2, ' ', '');
                    if ismember(traceType2, whiskTraceParams(:, 1));
                        ROITable{iROIStart + iROI, sprintf('eventDetect_%s_max_lateTimeWindow', traceTypeDisplay2)} ...
                            = ROIResp(iROI, iTraceType2);
                    end;
                end;
                iROILoop = iROILoop + 1;
            end;
        end;
        
        %}
        
        %% ROITable backup
        o('#%s: row %02d, %s, %s, %s, %s (%02d/%02d): saving table ...', mfilename, nRows, ...
            animID, dayID, spotID, traceType, iWhiskTraceType, size(whiskTraceParams, 1), 0, 0); 
        % save the table
        copyfile([this.path.OCIASave, 'ROITable.mat'], [this.path.OCIASave, 'ROITable_save.mat']);
        save([this.path.OCIASave, 'ROITable.mat'], 'ROITable');
        
    end;
    
    % update the table's start point
    iROIStart = size(ROITable, 1);
    
    
    catch err;
        
        o('Aborted processing for %s_%s_%s ("%s"): %s%s', this.path.OCIASave, shortAnimID, spotID, ...
        shortAnimID, spotID, regexprep(dayID, '_', ''), err.identifier, err.message, getStackText(err), 0, 0);
        
    end;
    
end;
   
% save the table
save('ROITable.mat', 'ROITable');
        
warning('on', 'MATLAB:LargeImage');
warning('on', 'MATLAB:table:RowsAddedExistingVars');
warning('on', 'MATLAB:table:RowsAddedNewVars');

% add the depth information
ROIDepthCorrectionScript();

end
