function [anovaROIStats, anovaPopulationStats] = analyseAnova(PSROIStats, tuningStruct, PSFrames, stimIDs, saveName, BSStat, meanExtractMethod, doSaveAnovaROIPlot, doSaveAnovaPopPlot)
    % Perform ANOVA analysis for each ROI by comparing 3 point normalized
    % mean responses for all trials or on the entire population based
    % on the chosen statistical metrics.
    %
    % Usage: [anovaROIStats, anovaPopulationStats] = analyseAnova(PSROIStats, tuningStruct, PSFrames, stimIDs, saveName, BSStat, doSaveAnovaROIPlot, doSaveAnovaPopPlot)
    % PSROIStats:  ROIStats.PS.(filt).raw
    % PSPopStats: ROIStats.stats.(filt).evokedResp
    % PSFrames: config base and evoked frames
    %
    % Output: anovaROIStats/anovaPopulationStats contains a nxm cell, where n is the roi index
    % and m is the stats element: the first element is the p value, the
    % second the results table and the third element the stats used for
    % multicompare
    %
    % Author: A. van der Bourg, 2014
    
    %% init ROI stats
    nROIs = size(PSROIStats, 1);
    nStims = size(PSROIStats, 2);
    nTrials = size(PSROIStats{1, 1}, 1);
    anovaData = cell(nROIs, nStims);
    mean3PPTrials = zeros(nTrials, 1);
    meanTrials = zeros(nTrials,1);
    anovaROIStats = cell(nROIs,3);
    
    %% init population stats
    statTypes = unique(strrep(fieldnames(tuningStruct), 'Err', ''));
    iTargetStat = strcmp(statTypes, BSStat);
    tuning = tuningStruct.(statTypes{iTargetStat});
    anovaPopulationStats = cell(1,3);
    
    switch meanExtractMethod
        case '3pp'
            %% Extract 3 point max values for each trial for a given ROI and condition and save it separately
            for iStim = 1 : nStims;
                for iROI = 1 : nROIs;
                    base = PSROIStats{iROI, iStim}(:, 1 : PSFrames.base);
                    evoked = PSROIStats{iROI, iStim}(:, (PSFrames.base + 1) : (PSFrames.base + PSFrames.evoked));
                    % Obtain the normalized 3 point mean of every trial
                    for iTrial = 1:nTrials
                        max3PPTrialBase = mean(cell2mat(arrayfun(@(i)maxnpp(base(i, :), 3), iTrial, 'UniformOutput', false)'), 2);
                        max3PPTrialEvoked = mean(cell2mat(arrayfun(@(i)maxnpp(evoked(i, :), 3), iTrial, 'UniformOutput', false)'), 2);
                        %remove base to "normalize"
                        mean3PPTrials (iTrial, 1) = max3PPTrialEvoked - max3PPTrialBase;
                        
                    end;
                    % Matrix containing all means for all trials for every ROI and
                    % stim
                    anovaData{iROI, iStim} = mean3PPTrials;
                end;
            end;
        case 'evokedMean'
            %% Extract response based on stats metric (e.g. mean) as an alternative to the 3pp approach
            for iStim = 1 : nStims;
                for iROI = 1 : nROIs;
                    base = PSROIStats{iROI, iStim}(:, 1 : PSFrames.base);
                    evoked = PSROIStats{iROI, iStim}(:, (PSFrames.base + 1) : (PSFrames.base + PSFrames.evoked));
                    for iTrial = 1:nTrials
                        meanTrialsBase = mean(cell2mat(arrayfun(@(i)base(i, :), iTrial, 'UniformOutput', false)'), 2);
                        meanTrialsEvoked = mean(cell2mat(arrayfun(@(i)evoked(i, :), iTrial, 'UniformOutput', false)'), 2);
                        %Normalize
                        meanTrials(iTrial, 1) = meanTrialsEvoked - meanTrialsBase;
                    end;
                    anovaData{iROI, iStim} = meanTrials;
                end;
            end;
    end;
    
    %% Perform the anova test on the extracted mean matrix and save a plot containing the p-value if requested
    for iROI = 1 : nROIs
        if doSaveAnovaROIPlot == 1 || doSaveAnovaROIPlot == 2
            %[pval, table, stats]
            [anovaROIStats{iROI, 1},anovaROIStats{iROI, 2}, anovaROIStats{iROI, 3}]  = anova1([anovaData{iROI, 1:nStims}], stimIDs');
            %Figure handle 1 is always the table, fig handle 2 of the bar
            %plot
            figHandle = 2;
            ylabel('Evoked response');
            % HACK: insert p-val in title of image
            strPVal = num2str(anovaROIStats{iROI, 1});
            title(['ANOVA: Roi ' num2str(iROI) '| p-val: ' strPVal], 'Interpreter', 'none');
            makePrettyFigure(figHandle);
            set(gca, 'FontSize', 8);
            if doSaveAnovaROIPlot == 2
                saveFigToDir(figHandle, [saveName '_ANOVA_ROI' num2str(iROI)], 'AnovaROI', doSaveAnovaROIPlot, 1, 1);
            end;
            close all;
        else
            [anovaROIStats{iROI, 1},anovaROIStats{iROI, 2}, anovaROIStats{iROI, 3}] = anova1([anovaData{iROI, 1:nStims}], stimIDs', 'off');
        end;
    end;
    
    %% Perform the anova test on the population level based on the chosen stat metrics
    if doSaveAnovaPopPlot == 1 || doSaveAnovaPopPlot == 2
        [anovaPopulationStats{1,1},anovaPopulationStats{1,2},anovaPopulationStats{1,3}]  = anova1(tuning', stimIDs');
        %Figure handle 1 is always the table, fig handle 2 of the bar
        %plot
        figHandle = 2;
        ylabel('Evoked response');
        % HACK: insert p-val in title of image
        title(['ANOVA on ' statTypes{iTargetStat} ' statistics | p-val: ' num2str(anovaPopulationStats{1,1})], 'Interpreter', 'none');
        makePrettyFigure(figHandle);
        set(gca, 'FontSize', 8);
        if doSaveAnovaPopPlot == 2
            saveFigToDir(figHandle, [saveName '_ANOVA_' statTypes{iTargetStat}], 'AnovaPopulation', doSaveAnovaPopPlot, 1, 1);
        end;
        close all;
        
    else
        [anovaPopulationStats{1,1},anovaPopulationStats{1,2},anovaPopulationStats{1,3}] = anova1(tuning', stimIDs', 'off');
    end;
    
end