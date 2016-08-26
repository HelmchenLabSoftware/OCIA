function [multiCompStatsROI, multiCompStatsPop] = multiStimComparison(anovaROIStats, anovaPopStats, tuningStruct, multiCompareThresh, saveName, BSStat, doSaveMultiCompROI, doSaveMultiCompPop)
    % Based on performed ANOVA tests, evaluate if a evoked stimulus
    % response is significantly different from the other sets or if for a
    % given ROI one stimulus parameter is significantly different from the
    % others a.k.a significance test for stimulus preference
    %
    % Usage: [multiCompStatsROI, multiCompStatsPop] = multiStimComparison(anovaROIStats, anovaPopStats, doSaveMultiCompROI, doSaveMultiCompPop)
    %
    % The output on multiCompStatsROI and multiCompStatsPop are four sub
    % elements: [stimComparison, meanValues, hValues, stimNames]
    %
    %Author: A. van der Bourg, 2014
    
    
    %% Initialize ROI variables
    nROIs = size(anovaROIStats, 1);
    multiCompStatsROI = cell(nROIs, 4);
    
    %% Initialize population variables
    multiCompStatsPop = cell(1,3);
    statTypes = unique(strrep(fieldnames(tuningStruct), 'Err', ''));
    iTargetStat = strcmp(statTypes, BSStat);
    
    %% Perform multcompare for single ROI and population Sets (based on metrics)
    for iROI = 1:nROIs
        if doSaveMultiCompROI
            % For now display a message to inform user of multicomparison
            % execution (because we do not save pngs -> no images shown
            if iROI == 1
                disp('Creating interactive multiple comparison figures...(no PNGs)');
            end;
            %[pval, table, stats]
            [multiCompStatsROI{iROI,1}, multiCompStatsROI{iROI,2}, multiCompStatsROI{iROI,3}, ~] = multcompare(anovaROIStats{iROI, 3}, 'alpha', multiCompareThresh);
            figHandle = gcf;
            makePrettyFigure(figHandle);
            set(gca, 'FontSize', 8);
            % Interactive plots will not be saved as png for now!
            saveFigToDir(figHandle, [saveName '_MultipleComparison_ROI' num2str(iROI)], 'MultiCompareROI', doSaveMultiCompROI, 0, 1);
            close all;
        else
        % The third element is the stats element of the Anova test
        [multiCompStatsROI{iROI,1}, multiCompStatsROI{iROI,2}, multiCompStatsROI{iROI,3}, ~] = multcompare(anovaROIStats{iROI, 3}, 'display', 'off', 'alpha', multiCompareThresh);
        end;
    end;
    
    %% Perform multcompare for population set based on statistical metrics defined by BSStat
    if doSaveMultiCompPop
        [multiCompStatsPop{1,1},multiCompStatsPop{1,2},multiCompStatsPop{1,3}]  = multcompare(anovaPopStats{1,3}, 'alpha', multiCompareThresh);
        figHandle = gcf;
        makePrettyFigure(figHandle);
        set(gca, 'FontSize', 8);
        % The third element is the stats element of the Anova test
        saveFigToDir(figHandle, [saveName '_MultipleComparison_' statTypes{iTargetStat}], 'MultiComparePop', doSaveMultiCompPop, 0, 1);
        close all;
        
    else
        [multiCompStatsPop{1,1},multiCompStatsPop{1,2},multiCompStatsPop{1,3}]  = multcompare(anovaPopStats{1,3}, 'display', 'off', 'alpha', multiCompareThresh);
    end;
       
end