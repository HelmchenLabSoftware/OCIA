function plotStimulusPreferenceHeatmap(saveName, tuningStruct, stimIDs, BSStat, doSaveStimPrefHeatmap)
    %For a given set of stimuli plot a heatmap representation in a matrix
    %array style (imagesc) based on slope of stimulus vs stimulus response metric(based on
    %BSStat ->mean, max, 3pp, etc)
    %
    %An nxm matrix with all possible stimulus combinations is created:
    %For n stimuli we get a (n(n-1)/2)x(n(n-1)/2) stimulus matrix
    %
    %Usage: plotStimulusPreferenceHeatmap(saveName, tuningStruct, stimIDs, BSStat, doSaveStimPrefHeatmap)
    %
    %Author: A. van der Bourg, 2014
    
    
    %% Init variables
    nStims = size(stimIDs, 1);
    statTypes = unique(strrep(fieldnames(tuningStruct), 'Err', ''));
    iTargetStat = strcmp(statTypes, BSStat);
    tuning = tuningStruct.(statTypes{iTargetStat});
    nROIs = size(tuning,2);
    tuningMatrix = ones(nStims, nStims);
    
    
    %Iterate over all ROIs and extract "slopes" for all stimulus
    %combinations
    for iROI = 1:nROIs
        %Iterate over all stim combinations
        figureHandle = figure;
        hold on;
        for xIndex = 1:(nStims-1)
            for yIndex = (xIndex+1):nStims
                hold on;
                xVal = tuning(xIndex, iROI);
                yVal = tuning(yIndex, iROI);
                tuningSlope = yVal /xVal;
                tuningMatrix(xIndex,yIndex) = tuningSlope;
                tuningMatrix(yIndex,xIndex) = tuningSlope;
            end;
        end;
        scaledTuningMatrix = linScale(tuningMatrix);
        imagesc(scaledTuningMatrix, [-1, 1]);
        %colormap('hot');
        set(gca, 'XTick', 1:size(stimIDs,1));
        set(gca, 'YTick', 1:size(stimIDs,1));
        set(gca, 'XTickLabel', stimIDs);
        set(gca, 'YTickLabel', stimIDs);
        xlabel(gca, 'Stimulus', 'FontSize', 10);
        ylabel(gca, 'Stimulus', 'FontSize', 10);
        hColBar = colorbar;
        set(get(hColBar,'YLabel'), 'String', 'Stimulus Preference Index');
        hold off;
        suptitle('ROI Stimulus Tuning Heatmap');
        if doSaveStimPrefHeatmap == 2
            saveNameStimPrefHeatmap = sprintf('%s_ROI_%s_Heatmap', saveName, num2str(iROI));
            saveFigToDir(figureHandle, [saveNameStimPrefHeatmap '_' BSStat], 'StimulusPreferenceHeatmap', doSaveStimPrefHeatmap, 1, 1);
        end;
    end;
    
end