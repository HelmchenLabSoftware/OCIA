function figHands = plotPSSingleAvg(PSROIStats, PSTime, ROISet, stimIDs, saveName, nROIPerFig, stimOnsetTick, stimTime, plotLimits, shadedBars)
    % Plot peri-stimulus averages with a tic and a background stimulus time box
    % Single trials are plotted as gray traces, averages as red
    %
    % Usage: plotPSSingleAvg(PSROIStats, PSTime, ROISet, stimIDs, saveName, nROIPerFig, stimOnsetTick, stimTime, plotLimits, shadedBars)
    % stimOnsetTick: black tick line for stimulus onset
    % stimTime: stimulation duration
    % shadedBars: use shadedErrorBarPlot instead of single traces and mean
    
    %Author: A. van der Bourg, 2014 
    %Adapted from plotPSStimAvg coded by B. Laurenczy
    
    
    % init the size of the data set
    nROIs = size(PSROIStats, 1);
    nStims = size(PSROIStats, 2);
    nTrials = size(PSROIStats{1, 1}, 1);
    PSTimeStims = repmat(PSTime', 1, nTrials);
    % PSTimeStims = PSTimeStims + repmat(xShift * (1 : nTrials), nFrames, 1) - xShift; % small shift for each trace
    %caTracesMean = PSROIStats.mean.allNorm;
     plotLimits(1) = plotLimits(1) -20;
     plotLimits(2) = plotLimits(2) +20;
    
    %% plot each group of ROIs in separate figures
    subplotCounter = 1;
    figHands = [];
    for iROI = 1 : nROIs;
        if ~mod(iROI + nROIPerFig - 1, nROIPerFig);
            figHands(end + 1) = figure('Name', sprintf('%s_ROI%s-ROI%s', saveName, ROISet{iROI, 1}, ...
                ROISet{min(iROI + nROIPerFig - 1, nROIs), 1}), 'NumberTitle', 'off'); %#ok<AGROW>
            subplotCounter = 1;
        end;
        
        % normalize limits for each ROI
        overallValues = cell2mat(PSROIStats(:,:));
        if isempty(plotLimits)
            overallyLims = [floor(min(overallValues(:))) ceil(max(overallValues(:)))];
            %Reduce box size so it does not overlap with plot limits
            overallboxLims = [(floor(min(overallValues(:)))+2) (ceil(max(overallValues(:)))-2)];
        else
            overallyLims = plotLimits;
            overallboxLims = [plotLimits(1)+1, plotLimits(2)-1];
        end;
       
        for iStim = 1 : nStims;
            subplot(nROIPerFig, nStims, subplotCounter);
            % normalize the traces with their minimum
            caTraces = PSROIStats{iROI, iStim}';
            %caTracesError = std(PSROIStats{iROI, iStim});
            
            %Plot a stimulus tick and box before calcium traces (layer order)
            if stimOnsetTick
                tAdaptationStart = 0;
                vtStimTimes = [0 stimTime tAdaptationStart];
                vfColour = 0.8 * [1 1 1];
                hPatchStim = fill(vtStimTimes([1 1 2 2 1]), overallboxLims([1 2 2 1 1]), vfColour);
                set(hPatchStim, 'LineStyle', 'none');
                hold on;
                % - Mark the stimulus onset
                %plot(vtStimTimes([1 1]), overallboxLims([1 2]), 'k-', 'LineWidth', 2);
            end;

            % IF shadedBars is selected no single trial traces are drawn,
            % but SD
            if shadedBars
                errHands = shadedErrorBar(PSTime, nanmean(caTraces, 2), nansem(caTraces,2),'r');
            else
                % plot all trials
                plotHands = plot(PSTimeStims, caTraces,'Color', 0.5 * [1 1 1], 'LineWidth', 0.5);
                hold on;
                %Plot a red average trace
                plot(PSTimeStims, nanmean(caTraces, 2), 'Color', 1 * [1 0 0], 'LineWidth', 2);
            end;
     
            % set common Y and X limits for all plots
            set(gca, 'YLim', overallyLims, 'XLim', [PSTime(1) - 0.05 PSTime(end) + 0.05], 'FontSize', 6);
            % only plot Y axis on left-most plots
            if iStim ~= 1; set(gca, 'YTick', []);
            else ylabel(sprintf('ROI%s', ROISet{iROI, 1})); end;
            % only plot X axis on bottom plots
            if mod(iROI + nROIPerFig, nROIPerFig); set(gca, 'XTick', []); %end;
            else
                xlabel('Time [s]');
            end
            % only plot title on top-most plots
            if ~mod(iROI + nROIPerFig - 1, nROIPerFig); title(stimIDs{iStim}, 'FontSize', 8); end
            
            hold off;
            subplotCounter = subplotCounter + 1;
        end;
        
        %if ~mod(iROI + nROIPerFig - 1, nROIPerFig);
        %    suptitle(sprintf('Evoked responses for each stimulus for ROIs %s-%s', ...
        %        ROISet{iROI, 1}, ROISet{min(iROI + nROIPerFig - 1, nROIs), 1}));
        %end;
    end;
end