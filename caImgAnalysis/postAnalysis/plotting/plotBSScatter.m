function plotBSScatter(saveName, tuningStruct, stimIDs, BSStat, doSaveStimScatter, leastSquareTick)
    % Plot a scatter overview plot with all stimulus combinations. Might be
    % useful to see if there is population tuning towards a stimulus
    % parameter. The plot generates a subplot containing all combinations
    %
    % BSStat: the chosen statistical metric
    % tuningstruct: struture containing NxM stats where N is number of
    % stimuli, M is number of ROIs
    % We get n(n-1)/2 combinations
    %
    % Usage: plotBSScatter(saveName, tuningStruct, stimIDs, BSStat, doSaveStimScatter, leastSquareTick)
    %
    % Some code adapted from plotBSPref
    % Author: A. van der Bourg, 2014
    
    
    %% Init variables
    nStims = size(stimIDs, 1);
    statTypes = unique(strrep(fieldnames(tuningStruct), 'Err', ''));
    iTargetStat = strcmp(statTypes, BSStat);
    tuning = tuningStruct.(statTypes{iTargetStat});
    
    %% Plot all combinations appearing once (n*(n-1)/2)
    % Plot stim1 vs stim2 but not stim2 vs stim1
    xyLims = [floor(min(tuning(:)) * 1.1), ceil(max(tuning(:)) * 1.1)];
    subPlotIndex = numSubplots((nStims*(nStims-1))/2); %n*(n-1)/2 combos)
    subScatterIndex = 1;
    axeH = figure;
    % Dynamically change plot size (more conditions, more space)
    set(axeH, 'Position', [100 100 (subPlotIndex(2)*100+300) subPlotIndex(1)*100+300]);
    title('Stimulus Combination Scatter Plots');
    %Iterate over all stim combinations
    for xSetIndex = 1:(nStims-1)
        for ySetIndex = (xSetIndex+1):nStims
            subplot(subPlotIndex(1), subPlotIndex(2), subScatterIndex);
            hold on;
            xSet = tuning(xSetIndex, :);
            ySet = tuning(ySetIndex, :);
            scatter(xSet, ySet, 'r.');
            subScatterIndex = subScatterIndex +1;
        end;
    end;
    
    % We have to wait for the gui to plot all data so we get
    % non-overlapping labeling of the axis
    subScatterIndex = 1;
    pause(0.01);
    
    % Label the plot
    for xSetIndex = 1:(nStims-1)
        for ySetIndex = (xSetIndex+1):nStims
            hold on;
            xSet = tuning(xSetIndex, :);
            ySet = tuning(ySetIndex, :);
            subPlotHandle =subplot(subPlotIndex(1), subPlotIndex(2), subScatterIndex);
            %Add labels to the sub-scatter plot
            xlabel(subPlotHandle, stimIDs(xSetIndex), 'FontSize', 10);
            ylabel(subPlotHandle, stimIDs(ySetIndex), 'FontSize', 10);
            
            %Add a least square line
            if leastSquareTick
                lsline;
                %also obtain the poly-fit of the leas square line
                s = polyfit(xSet, ySet,1);
                title(sprintf('s= %.2f', s(1)), 'FontSize', 10);
            end;
            set(gca, 'FontSize', 5);
            subScatterIndex = subScatterIndex +1;
            %Globally set the sub-scatter limits
            set(subPlotHandle, 'YLimMode', 'manual', 'YLim', xyLims);
            set(subPlotHandle, 'XLimMode', 'manual', 'XLim', xyLims);
            hold off;
            
        end;
    end;
    suptitle('Population Stimulus Tuning Comparisons');
    if doSaveStimScatter == 2
        saveNameBSScatter = sprintf('%s_PopulationScatter', saveName);
        saveFigToDir(axeH, [saveNameBSScatter '_' BSStat], 'PopulationScatter', doSaveStimScatter, 1, 1);
    end;
    
end