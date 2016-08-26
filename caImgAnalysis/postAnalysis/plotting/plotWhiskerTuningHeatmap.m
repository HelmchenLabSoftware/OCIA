function plotWhiskerTuningHeatmap(saveName, tuningStruct, stimIDs, BSStat, doSaveStimPrefHeatmap, plotLimits)
    % Visualize the evoked response stat based on a chosen BSStat in a matrix
    % format with color coding for all presented stimuli. An
    % alternative way to visualize the tuning properties has been
    % implemented in StimulusPreferenceHeatmap where the slope of the
    % scatter distribution is visualized. In this plot
    %
    % Usage:
    %
    % Author: A. van der Bourg, 2014
    
    %% Init variables
    nStims = size(stimIDs, 1);
    statTypes = unique(strrep(fieldnames(tuningStruct), 'Err', ''));
    iTargetStat = strcmp(statTypes, BSStat);
    tuning = tuningStruct.(statTypes{iTargetStat});
    nROIs = size(tuning,2);
    if isempty(plotLimits)
        maxVal = max(max(tuning));
    else
        maxVal = plotLimits(2);
    end;
    
    % Obtain which sorting case we use:
    if size(stimIDs, 1) == 6
        % tuning order: long. H, long. L, tH, tL, cH, cL
        % trans. L
        sortMethod = 1;
    elseif size(stimIDs,1) ==3
        sortMethod = 2;
    elseif size(stimIDs,1) ==2
        sortMethod = 3;
    end;
    
    for iROI = 1:nROIs
        %Iterate over all stim combinations
        respVect = tuning(:,iROI);
        switch sortMethod
            % Sorting for all stimulus cases
            case 1
                %x-axis: transversal: none, low, high
                %y-axis: longitudinal: none, low, high
                respMatrix = zeros(3,3);
                %longit. L
                respMatrix(3,2) = respVect(2,1);
                %longit. H
                respMatrix(3,3) = respVect(1,1);
                %transv. L
                respMatrix(2,1) = respVect(4,1);
                %transv. H
                respMatrix(1,1) = respVect(3,1);
                %comb. L
                respMatrix(2,2) = respVect(6,1);
                %comb. H
                respMatrix(1,3) = respVect(5,1);
                
                %plot figure
                figureHandle = figure;
                imagesc(respMatrix, [0, maxVal]);
                %Provide figure labelling
                set(gca, 'XTick', 1:3);
                set(gca, 'YTick', 1:3);
                set(gca, 'XTickLabel', {'none'; 'low ampl.'; 'high ampl.'});
                set(gca, 'YTickLabel', {'high ampl.'; 'low ampl.'; 'none' });
                xlabel(gca, 'Longitudinal', 'FontSize', 15);
                ylabel(gca, 'Transversal', 'FontSize', 15);
                hColBar = colorbar;
                set(get(hColBar,'YLabel'), 'String', 'Stimulus Preference Index');
                hold off;
                
                % Case direction
            case 2
                respMatrix = zeros(2,2);
                % Same distribution as in case 1 order
                %Longitudinal
                respMatrix(2,2) = respVect(2,1);
                %Combined
                respMatrix(1,2) = respVect(3,1);
                %transversal
                respMatrix(1,1) = respVect(1,1);
                
                %plot figure
                figureHandle = figure;
                imagesc(respMatrix, [0, maxVal]);
                %Provide figure labelling
                %Provide figure labelling
                set(gca, 'XTick', 1:2);
                set(gca, 'YTick', 1:2);
                set(gca, 'XTickLabel', {'none'; 'longit.'});
                set(gca, 'YTickLabel', {'transv.'; 'none' });
                xlabel(gca, 'Longitudinal', 'FontSize', 15);
                ylabel(gca, 'Transversal', 'FontSize', 15);
                hColBar = colorbar;
                set(get(hColBar,'YLabel'), 'String', 'Stimulus Preference Index');
                hold off;
                
                
                % Case amplitude
            case 3
                % Low Amplitude
                respMatrix = zeros(2,2);
                respMatrix(2,2) = respVect(2,1);
                respMatrix(1,1) = respVect(1,1);
                
                %plot figure
                figureHandle = figure;
                imagesc(respMatrix, [0, maxVal]);
                
                set(gca, 'XTick', 1:2);
                set(gca, 'YTick', 1:2);
                set(gca, 'XTickLabel', {'none'; 'low ampl.'});
                set(gca, 'YTickLabel', {'high ampl.'; 'none' });
                xlabel(gca, 'Low Amplitude', 'FontSize', 15);
                ylabel(gca, 'High Amplitude', 'FontSize', 15);
                hColBar = colorbar;
                set(get(hColBar,'YLabel'), 'String', 'Stimulus Preference Index');
                hold off;
        end;
        
        % Save plot
         suptitle('ROI Stimulus Tuning Heatmap');
        if doSaveStimPrefHeatmap == 2
            saveNameStimPrefHeatmap = sprintf('%s_ROI_%s_PrefStim', saveName, num2str(iROI));
            saveFigToDir(figureHandle, [saveNameStimPrefHeatmap '_' BSStat], 'WhiskerTuningHeatmap', doSaveStimPrefHeatmap, 1, 1);
        end;
    end;
    
    
end