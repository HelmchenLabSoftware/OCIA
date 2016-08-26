function OCIA_startFunction_pooledAnalysis(this)
% OCIA_startFunction_pooledAnalysis - [no description]
%
%       OCIA_startFunction_pooledAnalysis(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% load the list of all animals and spots
OCIA_startFunction_loadAllAnimalsAndSpots(this);

%% get the paths
% respMethod = 'mean';
% fileNameMiddlePart = 'meanResp_targetDistrOnOff_';
% subFolderName = '20150209_onOffTargDistr_meanResp';

% respMethod = '3ppmax';
% fileNameMiddlePart = '3ppmaxResp_targetDistrOnOff_';
% subFolderName = '20150209_onOffTargDistr_3ppmaxResp';

% respMethod = 'mean';
% fileNameMiddlePart = 'meanResp_';
% subFolderName = '20150210_meanResp_targDistrRespNoResp_allOnOff';

respMethod = '3ppmax';
fileNameMiddlePart = '3ppmaxResp_';
subFolderName = '20150210_3ppmaxResp_targDistrRespNoResp_allOnOff';

mainSavePath = 'E:/Analysis/1410_chronic/20141213/';
dataTablePath = sprintf('%s%s/dataTable_%s.mat', mainSavePath, subFolderName, respMethod);

%% extract pooled data
% if data table is not created/stored yet, create it
if ~exist(dataTablePath, 'file');

    % get the IDs
    animalIDs = this.dw.animalIDs(2 : end); % do not include the first element that is a '-'.
    spotIDs = this.dw.spotIDs(2 : end); % do not include the first element that is a '-'.

    % storage for all the data
    dataTable = cell2table(cell(numel(animalIDs) * numel(spotIDs), 2), 'VariableNames', { 'shortAnimID', 'spotID' });
    iRow = 1;

    % turn new variable warning off
    warning('off', 'MATLAB:table:RowsAddedNewVars');

    % loop over animals
    for iAnimal = 1 : numel(animalIDs);        
        shortAnimID = regexprep(regexprep(animalIDs{iAnimal}, 'mou_bl_', ''), '_', '');
        % loop over spots
        for iSpot = 1 : numel(spotIDs);
            spotID = spotIDs{iSpot};
            
            %% load current animal-spot combination
            % get the data path
            dataPath = sprintf('%s%s/%s_%s/%s_%s_pooled_%soutput.mat', mainSavePath, subFolderName, ...
                shortAnimID, spotID, shortAnimID, spotID, fileNameMiddlePart);
            % if data does not exist, skip
            if ~exist(dataPath, 'file'); continue; end;

            % store variables in the data cell-array
            dataTable.shortAnimID{iRow} = shortAnimID;
            dataTable.spotID{iRow} = spotID;

            % load the file
            o('%s#: loading file %s - %s ...', mfilename(), shortAnimID, spotID, 0, this.verb);
            matStruct = load(dataPath);

            % load the data from the structure
            dataTable.PSCaTraceMeans{iRow} = matStruct.savedDataStruct.img.selectedPSCaTracesStats.PSCaTraceMeans;
            dataTable.PSCaTraceErrors{iRow} = matStruct.savedDataStruct.img.selectedPSCaTracesStats.PSCaTraceErrors;
%             dataTable.ROIRespTrial{iRow} = matStruct.savedDataStruct.img.selectedPSCaTracesStats.ROIRespsTrial;
            dataTable.ROIRespTrial{iRow} = matStruct.savedDataStruct.img.selectedPSCaTracesStats.ROIRespTrial;
            dataTable.ROIRespProb{iRow} = matStruct.savedDataStruct.img.selectedPSCaTracesStats.ROIRespProb;
            dataTable.ROIRespTime{iRow} = matStruct.savedDataStruct.img.selectedPSCaTracesStats.ROIRespTime;
%             dataTable.ROIRespTime{iRow} = matStruct.savedDataStruct.img.selectedPSCaTracesStats.ROIRespsTime;
            dataTable.t{iRow} = matStruct.savedDataStruct.img.selectedPSCaTracesStats.t;
            dataTable.NStims{iRow} = matStruct.savedDataStruct.img.selectedPSCaTracesStats.NStims;
            dataTable.ROINames{iRow} = matStruct.savedDataStruct.img.selectedPSCaTracesStats.ROINames;
            dataTable.ROIPhases{iRow} = matStruct.savedDataStruct.img.selectedPSCaTracesStats.ROIPhases;

            % update the row counter
            iRow = iRow + 1;
        end;
    end;

    % remove empty rows
    dataTable(cellfun(@isempty, dataTable.shortAnimID), :) = [];
    % exclude spot03
    dataTable(cellfun(@(spID) strcmp(spID, 'spot03'), dataTable.spotID), :) = [];
    % exclude animal 4
    dataTable(cellfun(@(anID) strcmp(anID, '14100104'), dataTable.shortAnimID), :) = [];
    % save the table
    save(dataTablePath, 'dataTable');

% load the data table
else
    
    % load file
    matStruct = load(dataTablePath);
    dataTable = matStruct.dataTable;
    
end;

%% group pooled data
nRows = size(dataTable, 1);
pooledData = table2struct(dataTable(1, :));
pooledData.shortAnimID = dataTable.shortAnimID;
pooledData.spotID = dataTable.spotID;
pooledData.ROINames = arrayfun(@(iROI)sprintf('A0%sS0%s%s', dataTable.shortAnimID{1}(end), ...
        dataTable.spotID{1}(end), dataTable.ROINames{1}{iROI}), 1 : numel(pooledData.ROINames), ...
        'UniformOutput', false)';
    
nTrialsEachRow = arrayfun(@(iRow)size(dataTable.ROIRespTrial{iRow}, 2), 1 : nRows);
nROIsEachRow = arrayfun(@(iRow)size(dataTable.ROIRespTrial{iRow}, 3), 1 : nRows);
nROIsTot = sum(nROIsEachRow);
nTrialsMax = max(nTrialsEachRow);
nStimTypes = size(dataTable.ROIRespTrial{1}, 1);
pooledData.ROIRespTrial = nan(nStimTypes, nTrialsMax, nROIsTot);
iROI = 1;
pooledData.ROIRespTrial(:, 1 : nTrialsEachRow(1), iROI : (iROI + nROIsEachRow(1) - 1)) = dataTable.ROIRespTrial{1};
iROI = iROI + nROIsEachRow(1);
    
for iRow = 2 : nRows;
    if size(dataTable.PSCaTraceMeans{iRow}, 1) ~= nStimTypes;
        dataTable.PSCaTraceMeans{iRow} = cat(1, dataTable.PSCaTraceMeans{iRow}(1 : 3, :, :), ...
            nan(1, nROIsEachRow(iRow), 157), dataTable.PSCaTraceMeans{iRow}(4 : 6, :, :), ...
            nan(1, nROIsEachRow(iRow), 157), dataTable.PSCaTraceMeans{iRow}(7 : 9, :, :), nan(1, nROIsEachRow(iRow), 157)); 
        
        dataTable.PSCaTraceErrors{iRow} = cat(1, dataTable.PSCaTraceErrors{iRow}(1 : 3, :, :), ...
            nan(1, nROIsEachRow(iRow), 157), dataTable.PSCaTraceErrors{iRow}(4 : 6, :, :), ...
            nan(1, nROIsEachRow(iRow), 157), dataTable.PSCaTraceErrors{iRow}(7 : 9, :, :), nan(1, nROIsEachRow(iRow), 157));
        
        dataTable.ROIRespTrial{iRow} = cat(1, dataTable.ROIRespTrial{iRow}(1 : 3, :, :), ...
            nan(1, nTrialsEachRow(iRow), nROIsEachRow(iRow)), dataTable.ROIRespTrial{iRow}(4 : 6, :, :), ...
            nan(1, nTrialsEachRow(iRow), nROIsEachRow(iRow)), dataTable.ROIRespTrial{iRow}(7 : 9, :, :), ...
            nan(1, nTrialsEachRow(iRow), nROIsEachRow(iRow)));
        
        dataTable.ROIRespTime{iRow} = cat(1, dataTable.ROIRespTime{iRow}(1 : 3, :), ...
            nan(1, nROIsEachRow(iRow)), dataTable.ROIRespTime{iRow}(4 : 6, :), ...
            nan(1, nROIsEachRow(iRow)), dataTable.ROIRespTime{iRow}(7 : 9, :), ...
            nan(1, nROIsEachRow(iRow)));
        
        dataTable.NStims{iRow} = cat(1, dataTable.NStims{iRow}(1 : 3, :), ...
            nan(1, nROIsEachRow(iRow)), dataTable.NStims{iRow}(4 : 6, :), ...
            nan(1, nROIsEachRow(iRow)), dataTable.NStims{iRow}(7 : 9, :), ...
            nan(1, nROIsEachRow(iRow)));
    end;
    pooledData.PSCaTraceMeans = cat(2, pooledData.PSCaTraceMeans, dataTable.PSCaTraceMeans{iRow});
    pooledData.PSCaTraceErrors = cat(2, pooledData.PSCaTraceErrors, dataTable.PSCaTraceErrors{iRow});
    pooledData.ROIRespTime = cat(2, pooledData.ROIRespTime, dataTable.ROIRespTime{iRow});
    pooledData.NStims = cat(2, pooledData.NStims, dataTable.NStims{iRow});
    newROINames = arrayfun(@(iROI)sprintf('A0%sS0%s%s', dataTable.shortAnimID{iRow}(end), ...
        dataTable.spotID{iRow}(end), dataTable.ROINames{iRow}{iROI}), 1 : numel(dataTable.ROINames{iRow}), ...
        'UniformOutput', false)';
    pooledData.ROINames = cat(1, pooledData.ROINames, newROINames);
    pooledData.ROIPhases = cat(2, pooledData.ROIPhases, dataTable.ROIPhases{iRow});
    pooledData.ROIRespTrial(:, 1 : nTrialsEachRow(iRow), iROI : (iROI + nROIsEachRow(iRow) - 1)) = dataTable.ROIRespTrial{iRow};
    iROI = iROI + nROIsEachRow(iRow);
end;


% get the non-responsive ROIs
nonRespROIResps = pooledData.ROIRespTrial < 0.2;
% remove them (by setting them to NaN)
pooledData.ROIRespTrial(nonRespROIResps) = NaN;

%% plot pooled data
OCIAChangeMode(this, 'Analyser');
ANShowHideMessage(this, 0, '');

% allStimIDs = { 'targ all', 'distr all', 'targ on', 'distr on', 'targ off', 'distr off' };
% allStimIDs = { 'targResp all', 'targNoResp all', 'distrResp all', 'distrNoResp all', ...
%     'targResp on', 'targNoResp on', 'distrResp on', 'distrNoResp on', ...
%     'targResp off', 'targNoResp off', 'distrResp off', 'distrNoResp off' };
allStimIDs = { 'hit all', 'miss all', 'falsAl all', 'corrRej all', ...
    'hit on', 'miss on', 'falseAlarm on', 'corrRej on', ...
    'hit off', 'miss off', 'falseAlarm off', 'corrRej off' };
ROIStatList = { 'responsiveness', 'response time', 'SI', 'd''' };
groupByList = { 'ROI', 'day', 'stimType', 'PSPer', 'stimTypePSPer', 'none' };
plotLims = [];
baseSavePath = sprintf('%s20150212_pooled_%sResp/pooled_%sResp_', mainSavePath, respMethod, respMethod);

%% ROIStat correlations/comparison
selStimIndexes = 1 : 4; % all analysis only
stimIDs = allStimIDs(selStimIndexes);

for iGroupBy1 = 1 : numel(groupByList) - 1; % there is no last option 'none' for grouping1
    for iGroupBy2 = 1 : numel(groupByList);
        if iGroupBy1 == 1 || iGroupBy2 == 1; continue; end; % exclude "ROI" grouping plots
        if iGroupBy1 == iGroupBy2; continue; end; % do not do same groupBy twice, 'none' groupBy will take care of this
        try

            % get the ROI statistics
            [ROIStat1, xLab] = OCIA_analysis_getROIStat('responsiveness', respMethod, pooledData, selStimIndexes, stimIDs);
            [ROIStat2, yLab] = OCIA_analysis_getROIStat('response time', respMethod, pooledData, selStimIndexes, stimIDs);
            % get the groupings
            [grouping1, groupLabels1] = OCIA_analysis_getGrouping(this, [], 1 : numel(selStimIndexes), stimIDs, ...
                groupByList{iGroupBy1}, pooledData.ROINames, pooledData.ROIPhases);
            [grouping2, groupLabels2] = OCIA_analysis_getGrouping(this, [], 1 : numel(selStimIndexes), stimIDs, ...
                groupByList{iGroupBy2}, pooledData.ROINames, pooledData.ROIPhases);
            % concatenate the grouping variables
            grouping = { grouping1,  grouping2 };
            groupLabels = { groupLabels1, groupLabels2 };
            
            % plot and save
            for iFit = [0 1];
                ANClearPlot(this);
                plotROIStatCompare(this.GUI.handles.an.axe, ROIStat1, ROIStat2, grouping, groupLabels, '', plotLims, xLab, yLab, iFit);
                savePath = sprintf('%sROIStatCorr_%s_%s_%s', baseSavePath, groupByList{iGroupBy1}, groupByList{iGroupBy2}, ...
                    iff(iFit == 1, 'fit', 'noFit'));
                ANSavePlot(this, savePath);
                ANSavePlot(this, [savePath, '.png']);
            end;
        catch
            o('!!!! Could not save "%sROIStatCorr_%s_%s"', baseSavePath, groupByList{iGroupBy1}, groupByList{iGroupBy2}, 0, 0);
        end;
    end;
end;

%% NvsNP1 responsiveness
selStimIndexes = 5 : 12; % on/off only
stimIDs = allStimIDs(selStimIndexes);

for iGroupBy1 = 1 : numel(groupByList) - 1; % there is no last option 'none' for grouping1
    for iGroupBy2 = 1 : numel(groupByList);
        if iGroupBy1 == 1 || iGroupBy2 == 1; continue; end; % exclude "ROI" grouping plots
        if iGroupBy1 == iGroupBy2; continue; end; % do not do same groupBy twice, 'none' groupBy will take care of this
        try

            % get the ROI statistics
            [ROIStat, yLab] = OCIA_analysis_getROIStat('responsiveness', respMethod, pooledData, selStimIndexes, stimIDs);            
            % get the groupings
            [groupingROI, groupLabelsROI] = OCIA_analysis_getGrouping(this, [], 1 : numel(selStimIndexes), stimIDs, 'ROI', pooledData.ROINames, pooledData.ROIPhases);
            [grouping1, groupLabels1] = OCIA_analysis_getGrouping(this, [], 1 : numel(selStimIndexes), stimIDs, ...
                groupByList{iGroupBy1}, pooledData.ROINames, pooledData.ROIPhases);
            [grouping2, groupLabels2] = OCIA_analysis_getGrouping(this, [], 1 : numel(selStimIndexes), stimIDs, ...
                groupByList{iGroupBy2}, pooledData.ROINames, pooledData.ROIPhases);
            % concatenate the grouping variables
            grouping = { grouping1, grouping2, groupingROI };
            groupLabels = { groupLabels1, groupLabels2, groupLabelsROI };
            
            % plot and save
            for iFit = [0 1];
                ANClearPlot(this);
                plotROIStatNvsNP1(this.GUI.handles.an.axe, ROIStat, grouping, groupLabels, '', plotLims, yLab, iFit);
                savePath = sprintf('%sNvsNP1RespAmpl_%s_%s_%s', baseSavePath, groupByList{iGroupBy1}, groupByList{iGroupBy2}, ...
                    iff(iFit == 1, 'fit', 'noFit'));
                ANSavePlot(this, savePath);
                ANSavePlot(this, [savePath, '.png']);
            end;
        catch
            o('!!!! Could not save "%sNvsNP1RespAmpl_%s_%s"', baseSavePath, groupByList{iGroupBy1}, groupByList{iGroupBy2}, 0, 0);
        end;
    end;
end;

%% NvsNP1
selStimIndexes = 1 : 4; % all only
stimIDs = allStimIDs(selStimIndexes);

for iGroupBy1 = 1 : numel(groupByList) - 1; % there is no last option 'none' for grouping1
    for iGroupBy2 = 1 : numel(groupByList);
        if iGroupBy1 == 1 || iGroupBy2 == 1; continue; end; % exclude "ROI" grouping plots
        if iGroupBy1 == iGroupBy2; continue; end; % do not do same groupBy twice, 'none' groupBy will take care of this
        try

            % get the ROI statistics
            [ROIStat, yLab] = OCIA_analysis_getROIStat('response time', respMethod, pooledData, selStimIndexes, stimIDs);            
            % get the groupings
            [groupingROI, groupLabelsROI] = OCIA_analysis_getGrouping(this, [], 1 : numel(selStimIndexes), stimIDs, 'ROI', pooledData.ROINames, pooledData.ROIPhases);
            [grouping1, groupLabels1] = OCIA_analysis_getGrouping(this, [], 1 : numel(selStimIndexes), stimIDs, ...
                groupByList{iGroupBy1}, pooledData.ROINames, pooledData.ROIPhases);
            [grouping2, groupLabels2] = OCIA_analysis_getGrouping(this, [], 1 : numel(selStimIndexes), stimIDs, ...
                groupByList{iGroupBy2}, pooledData.ROINames, pooledData.ROIPhases);
            % concatenate the grouping variables
            grouping = { grouping1, grouping2, groupingROI };
            groupLabels = { groupLabels1, groupLabels2, groupLabelsROI };
            
            % plot and save
            for iFit = [0 1];
                ANClearPlot(this);
                plotROIStatNvsNP1(this.GUI.handles.an.axe, ROIStat, grouping, groupLabels, '', plotLims, yLab, iFit);
                savePath = sprintf('%sNvsNP1RespTime_%s_%s_%s', baseSavePath, groupByList{iGroupBy1}, groupByList{iGroupBy2}, ...
                    iff(iFit == 1, 'fit', 'noFit'));
                ANSavePlot(this, savePath);
                ANSavePlot(this, [savePath, '.png']);
            end;
        catch
            o('!!!! Could not save "%sNvsNP1RespTime_%s_%s"', baseSavePath, groupByList{iGroupBy1}, groupByList{iGroupBy2}, 0, 0);
        end;
    end;
end;

%{
%% responsiveness
selStimIndexes = 5 : 12; % on/off only
stimIDs = allStimIDs(selStimIndexes);

for iGroupBy1 = 1 : numel(groupByList) - 1; % there is no last option 'none' for grouping1
    for iGroupBy2 = 1 : numel(groupByList);
        if iGroupBy1 == 1 || iGroupBy2 == 1; continue; end; % exclude "ROI" grouping plots
        if iGroupBy1 == iGroupBy2; continue; end; % do not do same groupBy twice, 'none' groupBy will take care of this
        try
            % gather data
            [ROIStat, yLab] = OCIA_analysis_getROIStat('responsiveness', respMethod, pooledData, selStimIndexes, stimIDs);
            [grouping, groupLabels] = OCIA_analysis_getGrouping(this, [], 1 : numel(selStimIndexes), stimIDs, ...
                groupByList{iGroupBy1}, pooledData.ROINames, pooledData.ROIPhases);
            [grouping2, groupLabels2] = OCIA_analysis_getGrouping(this, [], 1 : numel(selStimIndexes), stimIDs, ...
                groupByList{iGroupBy2}, pooledData.ROINames, pooledData.ROIPhases);
            grouping = { grouping, grouping2 }; groupLabels = { groupLabels, groupLabels2 }; %#ok<AGROW>
            
            % plot and save
            ANClearPlot(this);
            plotROIStatScatter(this.GUI.handles.an.axe, ROIStat, grouping, groupLabels, '', plotLims, yLab, '');
            savePath = sprintf('%sRespAmpl_distribution_%s_%s', baseSavePath, groupByList{iGroupBy1}, groupByList{iGroupBy2});
            ANSavePlot(this, savePath);
            ANSavePlot(this, [savePath, '.png']);
            
            % plot and save
            ANClearPlot(this);
            plotROIStatHist(this.GUI.handles.an.axe, ROIStat, grouping, groupLabels, '', plotLims, yLab, '');
            savePath = sprintf('%sRespAmpl_histogram_%s_%s', baseSavePath, groupByList{iGroupBy1}, groupByList{iGroupBy2});
            ANSavePlot(this, savePath);
            ANSavePlot(this, [savePath, '.png']);
            
            % plot and save
            ANClearPlot(this);
            plotROIStatCumDistr(this.GUI.handles.an.axe, ROIStat, grouping, groupLabels, '', plotLims, yLab, '', 'dotted95%CIStairs');
            savePath = sprintf('%sRespAmpl_cumDistr_%s_%s', baseSavePath, groupByList{iGroupBy1}, groupByList{iGroupBy2});
            ANSavePlot(this, savePath);
            ANSavePlot(this, [savePath, '.png']);
            
        catch
            o('!!!! Could not save "%sRespAmpl_..._%s_%s"', baseSavePath, groupByList{iGroupBy1}, groupByList{iGroupBy2}, 0, 0);
        end;
    end;
end;

%% response time
selStimIndexes = 1 : 4; % all only
stimIDs = allStimIDs(selStimIndexes);

for iGroupBy1 = 1 : numel(groupByList) - 1; % there is no last option 'none' for grouping1
    for iGroupBy2 = 1 : numel(groupByList);
        if iGroupBy1 == 1 || iGroupBy2 == 1; continue; end; % exclude "ROI" grouping plots
        if iGroupBy1 == 4 || iGroupBy2 == 4; continue; end; % exclude "PSPer" grouping plots
        if iGroupBy1 == 6 || iGroupBy2 == 6; continue; end; % exclude "stimTypePSPer" grouping plots
        if iGroupBy1 == iGroupBy2; continue; end; % do not do same groupBy twice, 'none' groupBy will take care of this
        try
            % gather data
            [ROIStat, yLab] = OCIA_analysis_getROIStat('response time', respMethod, pooledData, selStimIndexes, stimIDs);
            [grouping, groupLabels] = OCIA_analysis_getGrouping(this, [], 1 : numel(selStimIndexes), stimIDs, ...
                groupByList{iGroupBy1}, pooledData.ROINames, pooledData.ROIPhases);
            [grouping2, groupLabels2] = OCIA_analysis_getGrouping(this, [], 1 : numel(selStimIndexes), stimIDs, ...
                groupByList{iGroupBy2}, pooledData.ROINames, pooledData.ROIPhases);
            grouping = { grouping, grouping2 }; groupLabels = { groupLabels, groupLabels2 }; %#ok<AGROW>
            
            % plot and save
            ANClearPlot(this);
            plotROIStatScatter(this.GUI.handles.an.axe, ROIStat, grouping, groupLabels, '', plotLims, yLab, '');
            savePath = sprintf('%sRespTime_distribution_%s_%s', baseSavePath, groupByList{iGroupBy1}, groupByList{iGroupBy2});
            ANSavePlot(this, savePath);
            ANSavePlot(this, [savePath, '.png']);
            
            % plot and save
            ANClearPlot(this);
            plotROIStatHist(this.GUI.handles.an.axe, ROIStat, grouping, groupLabels, '', plotLims, yLab, '');
            savePath = sprintf('%sRespTime_histogram_%s_%s', baseSavePath, groupByList{iGroupBy1}, groupByList{iGroupBy2});
            ANSavePlot(this, savePath);
            ANSavePlot(this, [savePath, '.png']);
            
            % plot and save
            ANClearPlot(this);
            plotROIStatCumDistr(this.GUI.handles.an.axe, ROIStat, grouping, groupLabels, '', plotLims, yLab, '', 'dotted95%CIStairs');
            savePath = sprintf('%sRespTime_cumDistr_%s_%s', baseSavePath, groupByList{iGroupBy1}, groupByList{iGroupBy2});
            ANSavePlot(this, savePath);
            ANSavePlot(this, [savePath, '.png']);
            
        catch
            o('!!!! Could not save "%sRespTime_..._%s_%s_%s"', baseSavePath, groupByList{iGroupBy1}, groupByList{iGroupBy2}, 0, 0);
        end;
    end;
end;

%}

end
