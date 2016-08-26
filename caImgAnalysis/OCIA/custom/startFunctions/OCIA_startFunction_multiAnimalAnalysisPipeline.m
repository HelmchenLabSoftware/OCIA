function OCIA_startFunction_multiAnimalAnalysisPipeline(this)
% OCIA_startFunction_multiAnimalAnalysisPipeline - [no description]
%
%       OCIA_startFunction_multiAnimalAnalysisPipeline(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% load the list of all animals and spots
% OCIA_startFunction_loadAllAnimalsAndSpots(this);

%% extract pooled data
% get the paths
% respMethod = '3ppmax';
% respMethodName = '3-points peak maximum evoked response';
% fileNameMiddlePart = '';
% subFolderName = '20150109_pooledData_3ppmax';
respMethod = 'mean';
respMethodName = 'mean evoked response';
fileNameMiddlePart = 'meanResp_';
mainSavePath = 'E:\Analysis\1410_chronic\20141213\';
% mainSavePath = this.path.OCIASave;
% subFolderName = '20150112_pooledData_mean';
subFolderName = '20150121_responseTiming';
dataTablePath = sprintf('%sdataTable_%s.mat', mainSavePath, respMethod);

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
            try
                dataTable.ROIRespTrial{iRow} = matStruct.savedDataStruct.img.selectedPSCaTracesStats.ROIRespTrial;
            catch
                dataTable.ROIRespTrial{iRow} = matStruct.savedDataStruct.img.selectedPSCaTracesStats.ROIRespsTrial;
            end;
            dataTable.ROIRespProb{iRow} = matStruct.savedDataStruct.img.selectedPSCaTracesStats.ROIRespProb;
            try
                dataTable.ROIRespTime{iRow} = matStruct.savedDataStruct.img.selectedPSCaTracesStats.ROIRespTime;
            catch
                dataTable.ROIRespTime{iRow} = matStruct.savedDataStruct.img.selectedPSCaTracesStats.ROIRespsTime;
            end;
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

%% process pooled data  
% general variables
groupCols = jet(4);
% groupCols(1 : 3, :) = jet(3);
% groupCols = [0.2 0.2 0.2; jet(3)];
groupCols(3, :) = [1 0.75 0];
markerStyles = { '+', 'o', '*', '.', 'x', 's', 'd', 'v', '^', '<', '>', 'o', 'h''' };
nBins = 20;
nRows = size(dataTable, 1);
allPhases = { 'baseline', 'naïve', 'expert', 'lateExpert' };
nGroups = numel(allPhases);
doSavePlotAllTraces = 0;
doSavePlotMeanErr = 0;
doSavePlotCumDistr = 1;
cumDistrPlotStyles = 'dotted95%CILine'; % 'singleStairs', 'dotted95%CIStairs', 'singleLine', 'dotted95%CILine', 'shaded95%CI'
doSavePlotNvsNP1 = 0;
NvsNP1GroupingModes = { 'spot', 'depth' };
% NvsNP1GroupingModes = { 'spot' };
NvsNP1Leg = false;
errMethod = 'SEM';
% errMethod = 'SD';
exclThresh = [-0.5 3.5];
SIRespThresh = 0.5;

% gather the pooled data for the different statistics
% statTypes = { 'mean' };
% statTypes = { 'dprime', 'dprimeTarg' };
statTypes = { 'mean', 'max' };
% statTypes = { 'max', 'SI', 'SITarg' };
% statTypes = { 'SI', 'SITarg' };
% statTypes = { 'mean', 'max', 'SI', 'SITarg', 'dprime', 'dprimeTarg'};
% statTypes = { 'respTimeDistr', 'respTimeTarg' };
for iStat = 1 : numel(statTypes);

    % store the different stats
    ROIStats = nan(nGroups, nBins, nRows);
    ROIStatsCumDistr = cell(nGroups, 2);
    ROIStatsPairs = cell(nGroups, nGroups);
    ROIStatsPairs(:) = { cell(0, 3) }; % init with 3 columns: ROIName, ROIStat in group 1, ROIStat in group 2
    
    % process each spot
    for iRow = 1 : nRows;

        % get the grouping from ROIs' phase
        grouping = cellfun(@(ROIPhase)find(strcmp(ROIPhase, allPhases)), dataTable.ROIPhases{iRow});
        
        % get the ROIs responsiveness and its size
        ROIRespTrial = dataTable.ROIRespTrial{iRow};
        ROIRespTime = dataTable.ROIRespTime{iRow};
        [nStimTypes, ~, nROIs] = size(ROIRespTrial);
        
        % remove the negative response trials
        if ~all(isnan(exclThresh));
            ROIRespTrial(ROIRespTrial < exclThresh(1)) = NaN;
            ROIRespTrial(ROIRespTrial > exclThresh(2)) = NaN;
        end;
        
        % average it for all trials
        ROIResps = reshape(nanmean(ROIRespTrial, 2), nStimTypes, nROIs);
        
        % get the appropriate statistic
        switch statTypes{iStat};
            case 'mean';
                % get the mean of the responsiveness
                ROIStat = mean(ROIResps, 1);
                xLab = sprintf('Responsiveness (%s - mean of the two stimuli)', respMethodName);
                plotLimits = exclThresh + [-0.1 0.1];
                saveName = sprintf('%s - mean of the two stimuli', respMethodName);
                
            case 'max';
                % get the maximum of the responsiveness
                ROIStat = max(ROIResps, [], 1);
                plotLimits = exclThresh + [-0.1 0.1];
                saveName = sprintf('%s - max of the two stimuli', respMethodName);
                xLab = sprintf('Responsiveness (%s - max of the two stimuli)', respMethodName);
                
            case 'SI';
                % calculate SI
                ROIResps(ROIResps < SIRespThresh) = NaN;
                ROIStat = (ROIResps(2, :) - ROIResps(1, :)) ./ (ROIResps(1, :) + ROIResps(2, :));
                plotLimits = [-1 1];
                xLab = 'selectivity index (-1 = low cloud, +1 = high cloud)';
                saveName = sprintf('%s - %s', respMethodName, xLab);
                
            case 'SITarg';
                % calculate SI
                ROIResps(ROIResps < SIRespThresh) = NaN;
                ROIStat = (ROIResps(2, :) - ROIResps(1, :)) ./ (ROIResps(1, :) + ROIResps(2, :));
                plotLimits = [-1 1];
                
                % make the plot be about target vs distractor
                animNum = str2double(dataTable.shortAnimID{iRow}(end));
                if animNum == 2 || animNum == 4;
                    ROIStat = ROIStat * -1;
                end;
                
                xLab = 'selectivity index (-1 = target, +1 = distractor)';
                saveName = sprintf('%s - %s', respMethodName, xLab);
                
            case 'dprime';
                % calculate dprime
                ROIRespTrial(ROIRespTrial < SIRespThresh) = NaN;
                ROIStat = squeeze((nanmean(ROIRespTrial(2, :, :), 2) - nanmean(ROIRespTrial(1, :, :), 2)) ...
                    ./ sqrt(0.5 * nanstd(ROIRespTrial(1, :, :), [], 2).^2 + 0.5 * nanstd(ROIRespTrial(2, :, :), [], 2).^2));
                
                plotLimits = [-4 4];
                xLab = 'sensitivity index (neg. = low cloud, pos. = high cloud)';
                saveName = sprintf('%s - d'' %s', respMethodName, xLab);
                
            case 'dprimeTarg';
                % calculate dprime
                ROIRespTrial(ROIRespTrial < SIRespThresh) = NaN;  
                
                % make the plot be about target vs distractor
                animNum = str2double(dataTable.shortAnimID{iRow}(end));
                if animNum == 2 || animNum == 4;
                    ROIStat = squeeze((nanmean(ROIRespTrial(1, :, :), 2) - nanmean(ROIRespTrial(2, :, :), 2)) ...
                        ./ sqrt(0.5 * nanstd(ROIRespTrial(1, :, :), [], 2).^2 + 0.5 * nanstd(ROIRespTrial(2, :, :), [], 2).^2));
                else
                    ROIStat = squeeze((nanmean(ROIRespTrial(2, :, :), 2) - nanmean(ROIRespTrial(1, :, :), 2)) ...
                        ./ sqrt(0.5 * nanstd(ROIRespTrial(1, :, :), [], 2).^2 + 0.5 * nanstd(ROIRespTrial(2, :, :), [], 2).^2));
                end;
                
                plotLimits = [-4 4];
                
                xLab = 'sensitivity index (neg. = target, pos. = distractor)';
                saveName = sprintf('%s - d'' %s', respMethodName, xLab);
                
            case 'respTimeTarg';
                ROIRespTime(ROIResps < SIRespThresh) = NaN;  
                
                % make the plot be about target vs distractor
                animNum = str2double(dataTable.shortAnimID{iRow}(end));
                if animNum == 2 || animNum == 4;
                    ROIStat = ROIRespTime(2, :);
                else
                    ROIStat = ROIRespTime(1, :);
                end;
                
                plotLimits = [-0.1 1];
                
                xLab = 'response time for target (seconds)';
                saveName = sprintf('%s - %s', respMethodName, xLab);
                
            case 'respTimeDistr';
                ROIRespTime(ROIResps < SIRespThresh) = NaN;  
                
                % make the plot be about target vs distractor
                animNum = str2double(dataTable.shortAnimID{iRow}(end));
                if animNum == 2 || animNum == 4;
                    ROIStat = ROIRespTime(1, :);
                else
                    ROIStat = ROIRespTime(2, :);
                end;
                
                plotLimits = [-0.1 1];
                
                xLab = 'response time for distractor (seconds)';
                saveName = sprintf('%s - %s', respMethodName, xLab);
                
        end;
        
        %% ROI Names
        % get the ROI names, clean them from the 'RSXX_' tag and get the unique list
        ROINames = dataTable.ROINames{iRow};
        cleanROINames = regexprep(ROINames, 'RS\d+_', '');
        uniqueROINames = unique(cleanROINames);

        %% get the data for each group
        % go through each group
        for iGroup = 1 : nGroups;
            % do the binning: get the ROIStats for the current group
            ROIStatForGroup = ROIStat(grouping == iGroup);
            % remove NaNs
            ROIStatForGroup(isnan(ROIStatForGroup)) = [];
            % remove infinits
            ROIStatForGroup(isinf(ROIStatForGroup)) = [];
            % calculate the number of ROIs for this group
            nROIsForGroup = numel(ROIStatForGroup);
            
            % define the range of the plotting limits
            plotLimRange = abs(diff(plotLimits));
            % make bin centers with the specified number of bins
            binCenters = plotLimits(1) : (plotLimRange / (nBins - 1)) : plotLimits(2);
            % get the counts for each bin
            [counts, xPos] = hist(ROIStatForGroup, binCenters);
            % store the counts as fraction of the total number of ROIs per group
            ROIStats(iGroup, :, iRow) = counts / nROIsForGroup;
            
            % store the ROIStats for this group in a single vector for the cumulative distributions
            ROIStatsCumDistr{iGroup, 1}((end + 1) : (end + nROIsForGroup)) = ROIStatForGroup;
            % store the row to which the stats belong to
            ROIStatsCumDistr{iGroup, 2}((end + 1) : (end + nROIsForGroup)) = ones(nROIsForGroup, 1) * iRow;
            
            % go through each ROI
            for iROI = 1 : numel(uniqueROINames);
                ROIName = uniqueROINames{iROI};
                % find the ROI in the group 1
                ROIGroup1Index = find(ismember(ROINames, sprintf('RS%02d_%s', iGroup, ROIName)));
                % if not present or NaN, continue
                if isempty(ROIGroup1Index) || isnan(ROIStat(ROIGroup1Index)) || isinf(ROIStat(ROIGroup1Index)); continue; end;
                % go through each group
                for iGroup2 = (iGroup + 1) : nGroups;
                    % find the ROI in the group 1
                    ROIGroup2Index = find(ismember(ROINames, sprintf('RS%02d_%s', iGroup2, ROIName)));
                    % if not present or NaN, continue
                    if isempty(ROIGroup2Index) || isnan(ROIStat(ROIGroup2Index)) || isinf(ROIStat(ROIGroup2Index)); continue; end;
                    % store ROI names and stats
                    ROIStatsPairs{iGroup, iGroup2}{end + 1, 1} = sprintf('%s_%s_%s', dataTable.shortAnimID{iRow}, ...
                        dataTable.spotID{iRow}, ROIName);
                    ROIStatsPairs{iGroup, iGroup2}{end, 2} = ROIStat(ROIGroup1Index);
                    ROIStatsPairs{iGroup, iGroup2}{end, 3} = ROIStat(ROIGroup2Index);                    
                end;
            end;            
        end;
        
    end;

    %% plot - all traces histogram
    if doSavePlotAllTraces > 0;
        % all curves
        hFig = figure('Name', sprintf('All curves - %s - exclThresh = [%.2f,%.2f]', saveName, exclThresh), ...
            'NumberTitle', 'off', 'Position', [370, 185, 1270 900]);
        hold('on');
        plotHandles = zeros(nGroups, nRows);
        xShiftBase = 0.01;
        for iGroup = 1 : nGroups;
            xShift = (iGroup - 1) * xShiftBase - nGroups * (xShiftBase / 2);
            plotHandles(iGroup, :) = plot(xPos + xShift, squeeze(ROIStats(iGroup, :, :)), 'LineWidth', 0.5, ...
                'Color', groupCols(iGroup, :), 'MarkerFaceColor', groupCols(iGroup, :));
        end;
        for iRow = 1 : nRows;
            set(plotHandles(:, iRow), 'Marker', markerStyles{iRow});
        end;
        legend(plotHandles(:, 1), allPhases, 'Location', 'North', 'Orientation', 'Horizontal', 'FontSize', 15);
        xlim(plotLimits .* 1.1);
        yLims = get(gca, 'YLim');
        set(gca, 'YLim', [-0.01 yLims(2)], 'FontSize', 15);
        ylabel('ROI Fraction');
        xlabel(xLab);
        title(saveName, 'FontSize', 15);
        hold('off');
        % save if required
        if doSavePlotAllTraces > 1;
            figSavePath = sprintf('%s%s_allCurves_%s', mainSavePath, respMethod, statTypes{iStat});
            saveas(hFig, figSavePath);
            set(hFig, 'Color', 'white');
            export_fig(figSavePath, '-png', '-r150', hFig);
            close(hFig);
        end;
    end;

    %% plot - mean +- error histogram
    if doSavePlotMeanErr > 0;
        % means +- error
        hFig = figure('Name', sprintf('Mean +- %s - %s - exclThresh = [%.2f,%.2f]', errMethod, saveName, exclThresh), ...
            'NumberTitle', 'off', 'Position', [370, 185, 1270 900]);
        hold('on');
        plotHandles = zeros(nGroups, 1);
        xShiftBase = 0.01;
        for iGroup = 1 : nGroups;
            xShift = (iGroup - 1) * xShiftBase - nGroups * (xShiftBase / 2);
            ROIStatsMean = nanmean(ROIStats(iGroup, :, :), 3);
            if strcmp(errMethod, 'SEM');
                ROIStatsErr = nansem(squeeze(ROIStats(iGroup, :, :)), 2);
            else
                ROIStatsErr = nanstd(ROIStats(iGroup, :, :), [], 3);
            end;
            plotHandles(iGroup) = errorbar(xPos + xShift, ROIStatsMean, ROIStatsErr, 'LineWidth', 2, ...
                'Color', groupCols(iGroup, :));
        end;
        legend(plotHandles(:, 1), allPhases, 'Location', 'North', 'Orientation', 'Horizontal', 'FontSize', 15);
        xlim(plotLimits .* 1.1);
        yLims = get(gca, 'YLim');
        set(gca, 'YLim', [-0.01 yLims(2)], 'FontSize', 15);
        xlabel(xLab);
        ylabel(sprintf('ROI Fraction \\pm %s', errMethod));
        title(saveName, 'FontSize', 15);
        hold('off');
        % save if required
        if doSavePlotMeanErr > 1;
            figSavePath = sprintf('%s%s_meanErr_%s', mainSavePath, respMethod, statTypes{iStat});
            saveas(hFig, figSavePath);
            set(hFig, 'Color', 'white');
            export_fig(figSavePath, '-png', '-r150', hFig);
            close(hFig);
        end;
    end;

    %% plot - cumulative distributions
    if doSavePlotCumDistr > 0;
        hFig = figure('Name', sprintf('Cumulative distribution - %s - exclThresh = [%.2f,%.2f]', saveName, exclThresh), ...
            'NumberTitle', 'off', 'Position', [370, 185, 1270 900]);
        hold('on');
        plotHandles = zeros(nGroups, 1);
        for iGroup = 1 : nGroups;
            [f, x, fLow, fUp] = ecdf(ROIStatsCumDistr{iGroup, 1});
            
            switch cumDistrPlotStyles;
                case 'singleStairs';
                    plotHandles(iGroup) = stairs(x, f, 'LineWidth', 2, 'Color', groupCols(iGroup, :));
                case 'dotted95%CIStairs';
                    plotHandles(iGroup) = stairs(x, f, 'LineWidth', 2, 'Color', groupCols(iGroup, :));
                    stairs(x, fLow, 'LineWidth', 0.5, 'LineStyle', ':', 'Color', groupCols(iGroup, :));
                    stairs(x, fUp, 'LineWidth', 0.5, 'LineStyle', ':', 'Color', groupCols(iGroup, :));
                case 'singleLine';
                    plotHandles(iGroup) = plot(x, f, 'LineWidth', 2, 'Color', groupCols(iGroup, :));
                case 'dotted95%CILine';
                    plotHandles(iGroup) = plot(x, f, 'LineWidth', 2, 'Color', groupCols(iGroup, :));
                    plot(x, fLow, 'LineWidth', 0.5, 'LineStyle', ':', 'Color', groupCols(iGroup, :));
                    plot(x, fUp, 'LineWidth', 0.5, 'LineStyle', ':', 'Color', groupCols(iGroup, :));
                case 'shaded95%CI';
                    hStruct = shadedErrorBar(x, f, fUp - fLow, { 'LineWidth', 2, 'Color', groupCols(iGroup, :) }, ...
                        1, hFig, gca);
                    plotHandles(iGroup) = hStruct.mainLine;
            end;
        end;
        legend(plotHandles, allPhases, 'Location', 'SouthEast', 'Orientation', 'Horizontal', 'FontSize', 15);
        xlim(plotLimits .* 1.1);
        set(gca, 'YLim', [-0.02 1.01], 'FontSize', 15);
        ylabel('ROI Fraction');
        xlabel(xLab);
        title(saveName, 'FontSize', 15);
        hold('off');
        
        ksTestResults = cell(nGroups, nGroups, 3);
        alphaTresh = 0.05 / (0.5 * nGroups * (nGroups - 1));
        outputTable = repmat({'-'}, nGroups + 1, nGroups + 1);
        for iGroup1 = 1 : nGroups;
            outputTable{iGroup1 + 1, 1} = allPhases{iGroup1};
            outputTable{1, 2} = allPhases{1};
            for iGroup2 = iGroup1 + 1 : nGroups;
                outputTable{1, iGroup2 + 1} = allPhases{iGroup2};
                [h, p, ks2stat] = kstest2(ROIStatsCumDistr{iGroup1, 1}, ROIStatsCumDistr{iGroup2, 1}, 'Alpha', alphaTresh);
                ksTestResults(iGroup1, iGroup2, 1 : 3) = { h, p, ks2stat };
                outputTable{iGroup1 + 1, iGroup2 + 1} = sprintf('%.6f', p);
            end;
        end;
        
        fprintf('Kolmogorov-Smirnov test for "%s"...\n', statTypes{iStat});
        tprintf(10, outputTable);
        fprintf('\n');
        
        % save if required
        if doSavePlotCumDistr > 1;
            figSavePath = sprintf('%s%s_cumDistr_%s', mainSavePath, respMethod, statTypes{iStat});
            saveas(hFig, figSavePath);
            set(hFig, 'Color', 'white');
            export_fig(figSavePath, '-png', '-r150', hFig);
            close(hFig);
        end;
    end;

    %% plot - NvsNP1
    if doSavePlotNvsNP1 > 0;
        % go through each group
        for iGroup = 1 : nGroups;
            group1Name = allPhases{iGroup};
            
            % go through each group
            for iGroup2 = (iGroup + 1) : nGroups;
                group2Name = allPhases{iGroup2};
                
                % go through each grouping mode
                for iGroupingMode = 1 : numel(NvsNP1GroupingModes);
                
                    currentPairs = cell2mat(ROIStatsPairs{iGroup, iGroup2}(:, 2 : 3));
                    hFig = figure('Name', sprintf('N vs N+1 - %s vs %s - %s - grouping by %s - N = %02d ROIs - exclThresh = [%.2f,%.2f]', ...
                        group1Name, group2Name, saveName, NvsNP1GroupingModes{iGroupingMode}, size(currentPairs, 1), exclThresh), 'NumberTitle', 'off', ...
                        'Position', [370, 185, 1270 900]);
                    hold('on');

                    % get the group tag for each ROI
                    ROIGroupTag = ROIStatsPairs{iGroup, iGroup2}(:, 1);
                    % get the unique animal and spot tags
                    uniqueAnimalSpotIDs = unique(regexprep(ROIGroupTag, '_(\d+|NPil)$', ''));
                    % get the grouping vector for each ROI
                    ROIGrouping = arrayfun(@(i)find(strcmp(regexprep(ROIGroupTag(i), '_(\d+|NPil)$', ''), ...
                        uniqueAnimalSpotIDs)), 1 : numel(ROIGroupTag));
                    
                    switch NvsNP1GroupingModes{iGroupingMode};

                        case 'spot';
                            % different random color for each group
                            groupColors = lines(numel(uniqueAnimalSpotIDs));
                            % use the IDs as group labels
                            groupLabels = uniqueAnimalSpotIDs;
                            
                        case 'depth';                            
                            % create the depth vector and sort it to get the indices
                            depths = [180, 210, 255, 190, 312, 195];
                            % remove depths that are not present in the data set
                            depths(~ismember(1 : numel(depths), unique(ROIGrouping))) = [];
                            [~, sortIndex] = sort(depths);
                            
                            % colors by depth using a colormap
                            groupColors = gray_reverse(1 + numel(depths));
                            % remove white because then one can see nothing god damn it matlab what are you doing
                            groupColors(1, :) = [];

                            % get the depth-sorted ROI grouping vector
                            ROIGrouping = sortIndex(ROIGrouping);
                            % use the IDs with the dpeth as group labels
                            groupLabels = arrayfun(@(i)sprintf('%s_%03dum', uniqueAnimalSpotIDs{i}, depths(i)), ...
                                1 : numel(depths), 'UniformOutput', false);
                            % sort them to match the ROI grouping vector
                            groupLabels = groupLabels(sortIndex);
                        
                    end;

                    % plot the scatter
                    plotHandles = gscatter(currentPairs(:, 1), currentPairs(:, 2), ROIGrouping, groupColors, [], 30);
                    xlabel(group1Name, 'FontSize', 25);
                    ylabel(group2Name, 'FontSize', 25);
                    % plot the 45° line
%                     plotRange = [min(currentPairs(:)) max(currentPairs(:))];
                    plotRange = plotLimits;
                    plot(plotRange, plotRange, ':k', 'LineWidth', 1);
                    
                    hLeg = legend(plotHandles, groupLabels, 'Location', 'SouthEast', 'Orientation', 'Vertical', ...
                        'Interpreter', 'none', 'FontSize', 13);
                    if ~NvsNP1Leg;
                        delete(hLeg);
                    end;

                    xlim(plotLimits .* 1.05);
                    ylim(plotLimits .* 1.05);
                    set(gca, 'FontSize', 15);
                    title(sprintf('%s vs %s - %s - grouping by %s - N = %02d ROIs', group1Name, group2Name, ...
                        saveName, NvsNP1GroupingModes{iGroupingMode}, size(currentPairs, 1)), 'FontSize', 15);
                    hold('off');

                    % save if required
                    if doSavePlotNvsNP1 > 1;
                        figSavePath = sprintf('%s%s_NvsNP1_%s_%sVS%s_groupBy%s', mainSavePath, respMethod, ...
                            statTypes{iStat}, group1Name, group2Name, NvsNP1GroupingModes{iGroupingMode});
                        saveas(hFig, figSavePath);
                        set(hFig, 'Color', 'white');
                        export_fig(figSavePath, '-png', '-r150', hFig);
                        close(hFig);
                    end;
                end;
            end;                 
        end;
        
    end;
    
end;

end
