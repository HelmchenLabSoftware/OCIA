function multiCompTuningPairs = analyseStimulusTuning(multiComparisonStats, stimIDs, multiCompareThresh, saveName, plotLimits, doSaveTuningPlot, doSavePairedTuningPlot)
    % By using the results obtained by multiStimComparison this function
    % plots the significance levels for different comparison metric (every
    % stimulus compared with all) in a pairwise overview bar plot
    %
    % There also exists significance if one stimulus parameter response is significantly
    % lower than all the others!
    %
    % A comparison is significant for the given threshold if the comparsion
    % intervals do not overlap = variance interval does not contain 0
    %
    % doSaveTuningPlot: Saves all bar plots and plots significances (also
    % generates plot if there is no significance
    %
    % doSavePairedTuningPlot: Only plots significant pairs in subplots
    %
    % Usage: analyseStimulusTuning(multiComparisonStats, stimIDs, multiCompareThresh, saveName, plotLimits, doSaveTuningPlot, doSavePairedTuningPlot)
    %
    %
    % Author: A. van der Bourg, 2014
    %
    
    % TODO:
    % * Add axe handle for Balazs
    
    
    %% Init variables
    nROIs = size(multiComparisonStats, 1);
    % ROI pairwise significance array
    multiCompTuningPairs = cell(nROIs,1);
    
    
    %% Find exclusively pairs for groups that are significant
    for iROI = 1: nROIs
        % Obtain the multiple comparison stats for a given ROI
        comparisonMatrix = multiComparisonStats{iROI, 1};
        significanceIndex = zeros(size(comparisonMatrix, 1), 1);
        % Find all significant pairs
        for iPair = 1: size(comparisonMatrix, 1)
            % Check if variance interval is between zero (if both negative
            % or if both positive it is significant, otherwise not)!
            if comparisonMatrix(iPair, 3) < 0
                if comparisonMatrix(iPair, 5) < 0
                    significanceIndex(iPair, 1) = 1;
                else
                    significanceIndex(iPair, 1) = 0;
                end;
            else if comparisonMatrix(iPair, 3) > 0
                    if comparisonMatrix(iPair, 5) > 0
                        significanceIndex(iPair, 1) = 1;
                    else
                        significanceIndex(iPair, 1) = 0;
                    end;
                end;
            end;
            % Store the significant pair information
            %multiCompTuningPairs{iROI, 1} = significanceIndex;
        end;
        
        
        %% Save significant pairs
        sigPairs = generateSigPairs(iROI, significanceIndex, multiComparisonStats);
        multiCompTuningPairs{iROI, 1} = sigPairs;
        
        %% Perform plotting for all conditions
        if doSaveTuningPlot == 1 || doSaveTuningPlot == 2
            %Make a bar plot
            figHandle = figure;
            meanResps = multiComparisonStats{iROI, 2}';
            errorHandles = meanResps(2,:);
            meanResps = meanResps(1,:);
            axeH = bar(meanResps, 'hist');
            ylabel('Mean Evoked Response');
            % Ignore too small plotlimits so star significance is
            % plotted correctly.
            if max(meanResps(:)) < plotLimits(2)
                ylim(plotLimits);
            end;
            set(gca, 'XTickLabel', stimIDs);
            set(axeH,'FaceColor',[1,1,1]*0.5,'LineWidth',1)
            hold on;
            errorHandle = errorbar(meanResps, errorHandles, '+');
            set(errorHandle,'color',[1,1,1]*0.52);
            %Add significance starts with sigstar function (sometimes
            %messy)
            if (length(significanceIndex(significanceIndex ==1))) >0
                hold on;
                sigPairs = generateSigPairs(iROI, significanceIndex, multiComparisonStats);
                sigVector = ones(1,size(sigPairs,2)) * multiCompareThresh;
                sigstar(sigPairs, sigVector);
                hold off;
            end;
            hold off;
            if doSaveTuningPlot == 2
                set(gca, 'FontSize', 8);
                %figHandle
                saveFigToDir(gcf, [saveName '_StimulusTuning_ROI' num2str(iROI)], 'ROIStimulusTuning', doSaveTuningPlot, 1, 1);
                close all;
            end;
            
        end;
        
        %% This plot only plots significant pairs as indicated in
        % significanceIndex and generateSigPairs
        if doSavePairedTuningPlot == 1 || doSavePairedTuningPlot == 2
            if (length(significanceIndex(significanceIndex ==1))) >0
                mainHandle = figure;
                % Pair matrix that is feeded to bar (Mx2 matrix)
                pairSet = zeros(length(significanceIndex(significanceIndex ==1)), 2);
                %Get pairs and error handles
                sigPairs = generateSigPairs(iROI, significanceIndex, multiComparisonStats);
                sigVector = ones(1,size(sigPairs,2)) * multiCompareThresh;
                %Obtain mean values
                meanResps = multiComparisonStats{iROI, 2}';
                errorHandles = meanResps(2,:);
                errorHandles = errorHandles(1, 1:2);
                %Can this be done in one step? Dunno...
                meanResps = meanResps(1,:);
                pairIndex = 1;
                for iPair = sigPairs
                    pairSet(pairIndex,1) = meanResps(1, iPair{1,1}(1));
                    pairSet(pairIndex, 2) = meanResps(1, iPair{1,1}(2));
                    pairIndex = pairIndex + 1;
                end;
                %Plot the significant pairs as subplots (only semi-elegant
                %solution for now to circumvent problems with paired
                %bar-plots
                [xIndex, yIndex] = findSubplotConfig(size(sigPairs,2));
                
                %Iterate through all subplots
                for pairIndex = 1:size(sigPairs, 2)
                    subplot(yIndex, xIndex, pairIndex);
                    %Hack for subplots
                    figHandle = gcf;
                    hold on;
                    barSet = [pairSet(pairIndex, 1), pairSet(pairIndex, 2)];
                    axeH = bar(barSet);
                    ylabel('Mean Evoked Response');
                    % Ignore too small plotlimits so star significance is
                    % plotted correctly.
                    if max(meanResps(:)) < plotLimits(2)
                        ylim(plotLimits);
                    end;
                    errorHandle = errorbar(barSet, errorHandles, '+');
                    set(errorHandle,'color',[1,1,1]*0.52);
                    sigstar([1,2], sigVector(1));
                    %Get pair and label x-axis
                    stimLabel = [stimIDs(sigPairs{1, pairIndex}(1)), stimIDs(sigPairs{1, pairIndex}(2))];
                    set(gca, 'XTick', [1,2]);
                    set(gca, 'XTickLabel', stimLabel);
                    set(axeH,'FaceColor',[1,1,1]*0.5,'LineWidth',1)
                    set(gca, 'FontSize', 8);
                    title('Significant Multiple Comparison Pairs');
                end;
                hold off;
                
                if doSavePairedTuningPlot == 2
                    saveFigToDir(mainHandle, [saveName '_PairedStimulusTuning_ROI' num2str(iROI)], 'ROIPairedStimulusTuning', doSavePairedTuningPlot, 1, 1);
                    close all;
                end;
                
            end;
        end;
        
    end;
end

function pairVectCell = generateSigPairs(roiIndex, significanceIndex, multiComparisonStats)
    % Function to generate a pair vector cell array that is needed to plot
    % all significant multi-comparisons using sigstar
    pairDims = size(significanceIndex, 1);
    pairVectCell = cell(1, length(significanceIndex(significanceIndex ==1)));
    %Go through all possibilties and get the significant paired elements
    pairVectIndex =1;
    for pairIndex = 1:pairDims
        if significanceIndex(pairIndex,1) == 1
            % We obtain the pairs by getting the paired numbers for the
            % given significanceIndex entry in multiComparisonStats
            pairVectCell{1, pairVectIndex} = [multiComparisonStats{roiIndex, 1}(pairIndex,1), multiComparisonStats{roiIndex, 1}(pairIndex,2)];
            pairVectIndex = pairVectIndex +1;
        end;
    end
end

function [xIndex, yIndex] = findSubplotConfig(significantPairs)
    % Function to evaluate which configuration is best to plot subplots
    
    % First check odd cases then even cases
    if mod(significantPairs,2) == 0
        % An even number with sqrt can configure sqrt(x)*sqrt(x)
        if mod(sqrt(significantPairs),2) ==0
            xIndex = sqrt(significantPairs);
            yIndex = sqrt(significantPairs);
        else
            xIndex = significantPairs / 2;
            yIndex = 2;
        end;
        % Odd cases
    else
        if sqrt(significantPairs)*sqrt(significantPairs) == significantPairs;
            xIndex = sqrt(significantPairs);
            yIndex = sqrt(significantPairs);
        else
            xIndex = round(significantPairs/2);
            yIndex = 2;
        end;
    end
end