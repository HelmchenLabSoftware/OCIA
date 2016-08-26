function [figHandle, tuningMatrix] = analyseRegionStimPreference(dimX, dimY, refImgPath, stimIDs, ROISet, saveName, tuningStruct, BSStat, pointSize, doPlot)
    %Function to plot tuning maps for a set of ROIs. ROIStimPreference with
    %text-strings has to be present as it is used with galvotuninganalysis
    %metrics.
    %
    %Usage: figHandle = plotRegionStimPreference(dimX, dimY, refImgPath, stimIDs, ROISet, saveName, tuningStruct, BSStat, pointSize)
    %
    %Some code adapted from doSaveMaps routine by Balazs
    %
    %Author: A. van der Bourg, 2014
    
    
    %% Init variables
    nStims = size(stimIDs, 1);
    statTypes = unique(strrep(fieldnames(tuningStruct), 'Err', ''));
    iTargetStat = strcmp(statTypes, BSStat);
    tuning = tuningStruct.(statTypes{iTargetStat});
    nROIs = size(tuning,2);
    ROILocs = ROISet(1 : (nROIs - 1), 2);
    %diffMatrix = zeros(1,size(tuning,2));
    %Check if reference image exists
    if ischar(refImgPath);
        imgMat = tiffread2_wrapper(refImgPath);
        refImg = imgMat.data;
    else
        warning('The specified path does not point towards an image');
        return;
    end;
    stimComb = nStims(nStims-1)/2;
    tuningMatrix = zeros(stimComb,nROIs);
    refImg = linScale(reshape(refImg, dimX, dimY, 2));
    %Gray ref Image with same dimensions to plot tuning circles
    grayRefImg = zeros(dimX, dimY, 2);
    grayRefImg(:) = 0.75; %standardized RGB gray value
    figHandle = [];
    %Go through all stimulus combinations and plot preference heatmap
    stimIndx = 1;
    for xIndex = 1:(nStims-1)
        for yIndex = (xIndex+1):nStims
            xVal = tuning(xIndex, :);
            yVal = tuning(yIndex, :);
            
            % Small negative values as a result of an inactive, sometimes
            % noisy cell can lead to false tuning properties. Therefore, we
            % assign the value of the compared tuningStat, so this tuning
            % candidate gets eliminated / does not show tuning properties.
            for i = 1:size(tuning,2)
                if xVal(i) < 0 && yVal(i) > 0
                    xVal(i) = yVal(i);
                elseif xVal(i) < 0 && yVal(i) < 0
                    xVal(i) = 1;
                    yVal(i) = 1;
                elseif xVal(i) > 0 && yVal(i) < 0
                    yVal(i) = xVal(i);
                end;
            end;
            
            
            % Express as normalized ratio of response metric
            scaledTuningSlopeMatrix = (xVal - yVal) ./ (xVal + yVal);
            tuningMatrix(stimIndx,:) = scaledTuningSlopeMatrix;
            
            if doPlot
                colorBarTitle = sprintf('Tuning index, %s vs. %s', stimIDs{xIndex, 1}, stimIDs{yIndex, 1});
                figHandle(end+1) = plotROILocHeatMapPoint(scaledTuningSlopeMatrix, [-1 1], grayRefImg, dimX, dimY, ROILocs, saveName, colorBarTitle, pointSize, 'cool'); %#ok<AGROW>
                figHandle(end+1) = plotROILocHeatMapPoint(scaledTuningSlopeMatrix, [-1 1], refImg, dimX, dimY, ROILocs, saveName, colorBarTitle, pointSize, 'cool'); %#ok<AGROW>
                title(sprintf('Tuning index, %s vs. %s', stimIDs{xIndex, 1}, stimIDs{yIndex, 1}));
                stimIndx = stimIndx+1;
                
                % Plot a histogram (stair plot) distribution plot of SI for
                % each region in 0.1 binning
                nBins = -1:0.1:1;
                [nB, xB] = hist(scaledTuningSlopeMatrix, nBins);
                
                %Make stair plot of SI
                figHandle(end+1) = figure;
                hold on;
                stairs(xB, nB, 'k')
                ylabel('Cell Number');
                xlabel('Selectivity index');
                hold off;
                
            else
                %Return an empty figHandle
                figHandle = [];
            end;
            
        end;
    end;            
end

%% Old ideas to calculate tuning stats
%{
           %{
            %Responses with abs diff < 100 are below the noise level and should
            %not be color coded, as we can not say anything about their
            %responsiveness. A sum of 100 equals 5% dFF per trial...which
            %is just above noise level/below 1AP!
            if strcmp('sum', (statTypes{iTargetStat}))
                for j = 1:size(tuning,2)
                    if xVal(j) < 100 %%|| abs(xVal(j)-yVal(j)) < 100
                        xVal(j) = 0;
                    end;
                    if yVal(j) < 100 %%|| abs(xVal(j)-yVal(j)) < 100
                        yVal(j) = 0;
                    end;
                end;
            end;
            %}

            %Express the ratio as a normalized ratio compared to the overall
            %response (bigger response ratios should be weighted more!)
            for i = 1:size(tuning, 2)
                xValNorm = tuning(xIndex,i)/(abs(sum(tuning(xIndex,:))-tuning(xIndex,i)));
                yValNorm = tuning(yIndex,i)/(abs(sum(tuning(yIndex,:))-tuning(yIndex,i)));
                tuningSlopeMatrix(1,i) = xValNorm ./ yValNorm;
            end;
            %Old alternative
            diffMatrix = xVal - yVal;
            absMaxValue = max(abs(tuningMatrix));
            scaledTuningSlopeMatrix = tuningMatrix / absMaxValue;
            
            % Express tuning as the normalized maximum difference
            %diffMatrix = xVal - yVal;
            %absMaxValue = max(abs(diffMatrix));
            %scaledTuningSlopeMatrix = diffMatrix / absMaxValue;
            
            %}