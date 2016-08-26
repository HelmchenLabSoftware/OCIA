function plotROIResponse(currentFolder, tuningStruct, PSTime, PSROIStats, ROISet, ....
        saveName, BSStat, stimIDs, multiCompStatsROI, stimOnsetTick, stimTime, doSavePlot)
    %Overview plot to represent responsiveness overall and compared to
    %local neural network population
    %
    % Author: A. van der Bourg, 2014
    
    
    %% Init variables
    nROIs = size(multiCompStatsROI, 1)-1;
    nStims = size(PSROIStats, 2);
    nTrials = size(PSROIStats{1, 1}, 1);
    PSTimeStims = repmat(PSTime', 1, nTrials);
    statTypes = unique(strrep(fieldnames(tuningStruct), 'Err', ''));
    iTargetStat = strcmp(statTypes, BSStat);
    tuning = tuningStruct.(statTypes{iTargetStat});
    
    % Generate overview plot for each ROI
    for iROI = 1 : nROIs;
        
        %% Generate single ROI traces
        overallValues = cell2mat(PSROIStats(:,:));
        overallyLims = [floor(min(overallValues(:))) ceil(max(overallValues(:)))];
        overallboxLims = [(floor(min(overallValues(:)))+2) (ceil(max(overallValues(:)))-2)];
        xyLimsScatter = [floor(min(tuning(:)) * 1.1), ceil(max(tuning(:)) * 1.1)];
        
        subplotCounter = 1;
        mainFigureHandle = figure;
        set(mainFigureHandle, 'Position', [100 100 700 900]);
        hold on;
        
        for iStim = 1 : nStims;
            subplot(3, nStims, subplotCounter);
            % normalize the traces with their minimum
            caTraces = PSROIStats{iROI, iStim}';
            
            %Plot a stimulus tick and box before calcium traces (layer order)
            if stimOnsetTick
                tAdaptationStart = 0;
                vtStimTimes = [0 stimTime tAdaptationStart];
                vfColour = 0.8 * [1 1 1];
                hPatchStim = fill(vtStimTimes([1 1 2 2 1]), overallboxLims([1 2 2 1 1]), vfColour);
                set(hPatchStim, 'LineStyle', 'none');
                hold on;
                % - Mark the stimulus onset
                plot(vtStimTimes([1 1]), overallboxLims([1 2]), 'k-', 'LineWidth', 2);
            end;
            %         caTraces = caTraces - repmat(min(caTraces), nFrames, 1);
            % plot all trials
            plot(PSTimeStims, caTraces,'Color', 0.5 * [1 1 1], 'LineWidth', 0.5);
            hold on;
            
            %Plot a red average trace
            plot(PSTimeStims, nanmean(caTraces, 2), 'Color', 1 * [1 0 0], 'LineWidth', 2);
            
            % Common labeling for plots
            set(gca, 'YLim', overallyLims, 'XLim', [PSTime(1) - 0.05 PSTime(end) + 0.05], 'FontSize', 6);
            % only plot Y axis on left-most plots
            if iStim ~= 1; set(gca, 'YTick', []);
            else ylabel('Delta F/F'); end;
            % only plot X axis on bottom plots
            xlabel('Time [s]');
            
            hold off;
            subplotCounter = subplotCounter + 1;
        end;
        
        
        %% Obtain the mean response plot and insert it in overview plot
        tuningFigName = sprintf('%s\\ROIStimulusTuning\\%s_StimulusTuning_ROI%d.fig', currentFolder, saveName, iROI);
        tuningHandle = openfig(tuningFigName);
        figure(mainFigureHandle);
        hold on;
        tuningSubplot = subplot(3,1,2, 'Parent', mainFigureHandle);
        title('Evoked mean response');
        ylabel('Mean Evoked response', 'FontSize', 8);
        %Copy object
        tuningAxisCopy = findobj(tuningHandle, 'type', 'axes');
        tuningAxisChildren = get(tuningAxisCopy, 'children');
        copyobj(tuningAxisChildren, tuningSubplot);
        set(tuningSubplot, 'XLim', [0.5, nStims + 0.5], 'XTick', 1 : nStims, 'XTickLabel', stimIDs);
        
        %% Plot evoked scatter plot and label actual ROI
        subScatterIndex = 1;
        columnCount = (nStims*(nStims-1))/2;
        for xSetIndex = 1:(nStims-1)
            for ySetIndex = (xSetIndex+1):nStims
                subplot(3, columnCount, 2*columnCount + subScatterIndex);
                hold on;
                xSet = tuning(xSetIndex, :);
                ySet = tuning(ySetIndex, :);
                scatter(xSet, ySet, 'r.');
                % Label the actual ROI point differently
                scatter(xSet(iROI), ySet(iROI), 200, 'b.');
                subScatterIndex = subScatterIndex +1;
            end;
        end;
        %label the subscatter plots
        subScatterIndex = 1;
        for xSetIndex = 1:(nStims-1)
            for ySetIndex = (xSetIndex+1):nStims
                hold on;
                subPlotHandle =subplot(3, columnCount, 2*columnCount + subScatterIndex);
                %Add labels to the sub-scatter plot
                xlabel(subPlotHandle, stimIDs(xSetIndex), 'FontSize', 10);
                ylabel(subPlotHandle, stimIDs(ySetIndex), 'FontSize', 10);
                set(gca, 'FontSize', 5);
                subScatterIndex = subScatterIndex +1;
                %Globally set the sub-scatter limits
                set(subPlotHandle, 'YLimMode', 'manual', 'YLim', xyLimsScatter);
                set(subPlotHandle, 'XLimMode', 'manual', 'XLim', xyLimsScatter);
                hold off;
                
            end;
        end;
        if doSavePlot == 2
            saveNameOverviewFig = sprintf('%s_ROIResponseOverview_ROI%s', saveName, num2str(iROI));
            saveFigToDir(mainFigureHandle, saveNameOverviewFig, 'ROIResponseOverview', doSavePlot, 1, 1);
        end;
        %Close the subfigures for copyobjects
        close(tuningHandle);
        %hold off;
    end;
end