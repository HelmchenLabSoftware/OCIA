function plotROIResponseOverview(currentFolder, caTraces, stim, ....
        nStimsPerBlock, stimDur, frameRate, saveName, filt, stimSort, BSStat, ...
        stimIDs, multiCompStatsROI, multiCompTuningPairs, npilttest, showStimTuning, doSavePlot)
    % The following function generates an overview figure based on multiple
    % post-analysis figures on a "per ROI basis". The goal is to provide an
    % overview plot to evaluate and present single ROI responsiveness. The
    % function checks if the plotSet is already present, if not it re-runs
    % some of the plotting functionality provided by the post-analysis
    % pipeline
    %
    % Used plots:
    % *TraceSet: plot filtered traces for all conditions
    % *statMetric: plot evokedResp metric
    % *tuningStats: plot analyseTuning overview plots
    % *glmResProb: plot the GLM extracted response probability
    % *PSAvgSinglePlot: plot peristimulus averages?
    % *tuning prediction: subplot legend element with the predicted tuning
    % of the cell ->subfunction tailored to stimulus paradigm
    %
    % Parameters:
    %
    %
    %
    % Author: A. van der Bourg, 2014
    
    %% TODO
    % Check if plot folder exists, if not, re run analysis for these sets
    % Add Npilttest
    % Add trialavgplots
    
    
    %% Init variables
    nROIs = size(multiCompStatsROI, 1)-1;
    stimFrames = find(stim>0);
    stimIDIndexes = stim(stim > 0);
    stimIDCell = cell(1, numel(stimIDIndexes));
    for n = 1 : numel(stimIDIndexes);
        stimIDCell{n} = num2str(stimIDIndexes(n));
    end
    nStims = size(stimIDs,1);
    %Number of stim-presentations per condition
    stimPres = length(stimFrames) ./ length(stimIDs);
    %Number of blocks per stimulus
    numOfBlocks = stimPres / nStimsPerBlock;
    %Specify the length of each stimulation 'block' that should be plotted
    blockFrameSize = size(caTraces, 2)/(size(stimIDs,1)*numOfBlocks);
    %Define a time vector
    %NOTE: the first frame is removed, so we define the time -1 frame
    timeVect = (1/frameRate):(1/frameRate):((blockFrameSize/frameRate)); %-1/frameRate
    %Obtain the stimulus times for a block - take the first as the others
    %are the same
    blockStims = stim(1:blockFrameSize);
    blockStimTickIndices = blockStims >0;
    
    
    %% Obtain the custom response index
    ROIStimPreference = galvoTuningAnalysis(multiCompTuningPairs, multiCompStatsROI, stimSort);
    
    
    %% Execute roiOverviewPlotting on all ROIs
    %figHands = [];
    for iROI = 1:nROIs
        % Obtain all figure paths relative to post analysis root:
        % Note that we already have to cd into folder where ROIStats and figures are
        % saved
        % Add 0 string for ROI index <10
        %BSStats
        if iROI < 10
            bsFigName = sprintf('%s\\ROIBS\\%s_%s_BestStim_ROI_00%d_%s.fig'   , currentFolder, saveName, filt, iROI, BSStat);
        else
            bsFigName = sprintf('%s\\ROIBS\\%s_%s_BestStim_ROI_0%d_%s.fig'   , currentFolder, saveName, filt, iROI, BSStat);
        end
        %ROIStimulusTuning
        tuningFigName = sprintf('%s\\ROIStimulusTuning\\%s_StimulusTuning_ROI%d.fig', currentFolder, saveName, iROI);
        
        % Insert inter trial average plots
        overallValues = caTraces(:,:);
        overallyLims = [floor(min(overallValues(:))) ceil(max(overallValues(:)))];
        
        %reduce box size so it does not overlap with plot limits
        overallboxLims = [(floor(min(overallValues(:)))+2) (ceil(max(overallValues(:)))-2)];
        
        %First obtain the calcium trace for all stimuli for that ROI
        ROICaTrace = caTraces(iROI, :);
        
        subplotCounter = 1;
        %Then generate plots for each stimulus
        mainFigureHandle = figure;
        set(mainFigureHandle, 'Position', [100 100 700 900]);
        %axes;
        for iStim = 1:numel(stimIDs)
            subplot(4, nStims, subplotCounter);
            %Initialize the plot with the stimulus markers
            for j = timeVect(blockStimTickIndices)
                %for now tAdaptionStart is always 0
                tAdaptionStart = 0;
                stimTimes = [j (j+stimDur) tAdaptionStart];
                vfStimColour = 0.8 * [1 1 1];
                % A figure is created in this instance
                hPatchStim = fill(stimTimes([1 1 2 2 1]), overallboxLims([1 2 2 1 1]), vfStimColour);
                set(hPatchStim, 'LineStyle', 'none');
                hold on;
                plot(stimTimes([1 1]), overallboxLims([1 2]), 'k-', 'LineWidth', 0.5);
            end;
            hold on;
            sumBlockTraceFilt = zeros(1,blockFrameSize);
            for iBlock = 1:numOfBlocks
                %Obtain the block frames
                if iBlock == 1
                    %Get frames for the first block of the stim
                    blockFrames = 1:blockFrameSize;
                else
                    %Get frames for all following blocks of the stim
                    blockFrames = (1:blockFrameSize) +(iBlock-1)*blockFrameSize;
                end
                %Add the stimulus specific interval to the blocks
                blockFrames = blockFrames + (iStim-1)*numOfBlocks*blockFrameSize;
                
                %Extract blocks for each stimulus
                blockTraceFilt = ROICaTrace(blockFrames);
                plot(timeVect, blockTraceFilt,'Color', 0.5 * [1 1 1], 'LineWidth', 1);
                hold on;
                %sum for all traces for mean mean calculation
                sumBlockTraceFilt = sumBlockTraceFilt + blockTraceFilt;
            end
            % Create the mean trace and plot it on top
            meanBlockTrace = sumBlockTraceFilt ./ numOfBlocks;
            plot(timeVect, meanBlockTrace, 'Color', 1 * [1 0 0], 'LineWidth', 2);
            % set common Y and X limits for all plots
            set(gca, 'YLim', overallyLims, 'XLim', [timeVect(1) - 0.05 timeVect(end) + 0.05], 'FontSize', 6);
            title(stimIDs{iStim}, 'FontSize', 8);
            hold off;
            subplotCounter = subplotCounter + 1;
        end;
        
        % Open existing plots and add them to the overview plot
        % Open best stimulus plot
        bsFigHandle = openfig(bsFigName);
        %Get its handle
        bsAxis = gca;
        tuningHandle = openfig(tuningFigName);
        %tuningAxis = gca;
        figure(mainFigureHandle);
        hold on;
        bsSubPlot = subplot(4,1,2);
        title(sprintf('Response index: %s', BSStat));
        ylabel('Evoked response', 'FontSize', 8);
        
        tuningSubplot = subplot(4,1,3, 'Parent', mainFigureHandle);
        title('Extracted mean response');
        ylabel('Mean Evoked response', 'FontSize', 8);
        
        
 
        %% Copy first existing figure on first subplot 
        
        bsAxisCopy = findobj(bsFigHandle,'type', 'axes');
        bsAxisChildren = get(bsAxisCopy, 'children');
        copyobj(bsAxisChildren, bsSubPlot);
        set(bsSubPlot, 'XLim', [0.5, nStims + 0.5], 'XTick', 1 : nStims, 'XTickLabel', stimIDs);
        pause(0.01);
        
        tuningAxisCopy = findobj(tuningHandle, 'type', 'axes');
        tuningAxisChildren = get(tuningAxisCopy, 'children');
        copyobj(tuningAxisChildren, tuningSubplot);
        set(tuningSubplot, 'XLim', [0.5, nStims + 0.5], 'XTick', 1 : nStims, 'XTickLabel', stimIDs);

        suptitle(sprintf('Stimulus specificity: %s', ROIStimPreference{iROI,1}));
        if showStimTuning
            % Put stimulus information in subplot as text field
            hold on;
            textHandle = subplot(4,1,4);
            set(textHandle,'visible','off')
            %nPilString = sprintf('Neuropil significance level:%s', NpilTTest.pValMean{
            text(0.3, 0.5, sprintf('------------------------------------------\n\n*Extracted tuning:%s \n*P-value vs. neuropil:%0.7f', ROIStimPreference{iROI,1}, npilttest.pvalMean(iROI, 1)),  'Parent', textHandle);
        end;
        %set(mainAxisHandle, 'Position', [100 100 600 800]);
        if doSavePlot == 2
            saveNameOverviewFig = sprintf('%s_ROITuningOverview_ROI%s', saveName, num2str(iROI));
            saveFigToDir(mainFigureHandle, saveNameOverviewFig, 'ROITuningOverview', doSavePlot, 1, 1);
        end;
        %Close the subfigures
        close(bsFigHandle);
        close(tuningHandle);
        %hold off;
    end;
end