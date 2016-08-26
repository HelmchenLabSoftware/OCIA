function figHands = plotInterTrialHeatmap(caTraces, stim, stimNames, ROISet, nStimsPerBlock, stimDur, frameRate, plotLimits, saveName)
    %Function to plot inter trial-heatmaps for single sets and all stimuli
    %based on PSROIstats.raw
    %
    %Usage:
    
    % Author: A. van der Bourg, 2014
    
    
    %% Init variables
    nROIs = size(ROISet, 1);
    %plotLimits = [plotLimits(1)+10, plotLimits(2)];
    % extract the stimuli times
    stimFrames = find(stim>0);
    % extract the stimulus 'IDs' by converting the stim index into a string (the index of the stimuli)
    stimIDIndexes = stim(stim > 0);
    stimIDs = cell(1, numel(stimIDIndexes));
    for n = 1 : numel(stimIDIndexes);
        stimIDs{n} = num2str(stimIDIndexes(n));
    end;
    nStims =numel(unique(stimIDs));
    
    %OVERWRITING PLOTLIMITS FOR THESE PLOTS
    plotLimits = [0, 60];
    
    %Number of stim-presentations per condition
    stimPres = length(stimFrames) ./ nStims;
    %Number of blocks per stimulus
    numOfBlocks = stimPres / nStimsPerBlock;
    stimOrder = stimIDIndexes(1,1:nStimsPerBlock:end);
    
    %Specify the length of each stimulation 'block' that should be plotted
    blockFrameSize = size(caTraces, 2)/(nStims*numOfBlocks);
    
    %Define a time vector
    %NOTE: the first frame is removed, so we define the time -1 frame
    timeVect = (1/frameRate):(1/frameRate):((blockFrameSize/frameRate)); %-1/frameRate
    
    %Obtain the stimulus times for a block - take the first as the others
    %are the same
    blockStims = stim(1:blockFrameSize);
    blockStimTickIndices = blockStims >0;
    
    
    
    %% Plot heatmap for specified region and stimulus
    %Define overall limits
    overallValues = caTraces(:,:);
    overallyLims = [floor(min(overallValues(:))) ceil(max(overallValues(:)))];
    figHands = [];
    %One figure per stimulus
    for iStim = 1:nStims
        subplotCounter = 1;
        figHands(end+1) = figure('Name', sprintf('Inter-trial heatmap for stimulus: %s', stimOrder(1,iStim)));
        sumBlockTraceFilt = zeros(nROIs-1,blockFrameSize);
        %Stimulus order invariant loop method
        stimIndx = find(stimOrder==iStim);
        for indx = stimIndx
            if indx ==1
                blockFrames = 1:blockFrameSize;
            else
                blockStartIndex = (indx-1)*blockFrameSize+1;
                blockFrames = blockStartIndex:(blockStartIndex+blockFrameSize-1);
            end;
            
            subplot(2, numOfBlocks, subplotCounter);
            hold on;
            %Extract blocks for each stimulus
            blockTraceFilt = caTraces(1:end-1,blockFrames);
            %plot(timeVect, blockTraceFilt,'Color', 0.5 * [1 1 1], 'LineWidth', 2);
            imagesc(blockTraceFilt, plotLimits);
            %set axis limits
            set(gca, 'YLim', [1 nROIs-1], 'XLim', [1 size(blockTraceFilt, 2)]);
            set(gca, 'YTick', [], 'XTick', []);
            colormap(hot);
            title(sprintf('Run %s: %s', num2str(subplotCounter), stimNames{iStim, 1}));
            %sum for all traces for mean mean calculation
            sumBlockTraceFilt = sumBlockTraceFilt + blockTraceFilt;
            subplotCounter = subplotCounter+1;
        end;
        
        % Create a mean heatmap plot
        meanBlockTrace = sumBlockTraceFilt ./ numOfBlocks;
        hold off;
        subplot(2,1,2);
        hold on;
        imagesc(meanBlockTrace, plotLimits);
        %axis image;
        colormap(hot);
        set(gca, 'YLim', [1 nROIs-1], 'XLim', [0 size(blockTraceFilt, 2)]);
        ylabel('ROI');
        xlabel('Time (s)');
        set(gca, 'XTick', [0:100:size(blockTraceFilt, 2)], 'XTickLabel', [0:100:size(blockTraceFilt, 2)]./frameRate);
        title (sprintf('Average heatmap for %s', stimNames{iStim, 1}));
        colorbar('CLim', plotLimits);
        hColBar = colorbar;
        set(get(hColBar,'YLabel'), 'String', 'DFF [%]');
        set(hColBar, 'YLim', plotLimits);
        hold off;
    end;
    
    %% Now plot a PSPlot extracted from the caTraces
    psPlotLimits = [-40, 40]; %in frames
    %concatPSTrace = cell(nROIs-1, (-psPlotLimits(1)+psPlotLimits(2))*nStims);
    concatPSTrace = [];
    for iStim = 1:nStims
        meanStimTrace = zeros(nROIs-1, -psPlotLimits(1) + psPlotLimits(2)+1);
        meanNormalizedTrace = zeros(nROIs-1, -psPlotLimits(1) + psPlotLimits(2)+1);
        meanBaseTrace = zeros(nROIs-1, -psPlotLimits(1)+1);
        %Find frame indices for specified stim
        stimFrameIndices = find(stim==iStim);
        for iFrameIndex = stimFrameIndices
            blockTrace = caTraces(1:end-1, (iFrameIndex+psPlotLimits(1)):(iFrameIndex+psPlotLimits(2)));
            baseTrace = caTraces(1:end-1, (iFrameIndex+psPlotLimits(1)):iFrameIndex);
            meanStimTrace = meanStimTrace + blockTrace;
            %add a baseline trace which we can subtract so we have
            %evokedMean
            meanBaseTrace = meanBaseTrace + baseTrace;
        end;
        meanStimTrace = meanStimTrace ./ stimPres;
        meanBaseTrace = meanBaseTrace ./ stimPres;
        normMean = nanmean(meanBaseTrace,2);
        %Normalize the trace
        for i=1:size(meanStimTrace,2)
            meanNormalizedTrace(:,i) = meanStimTrace(:,i) - normMean;
        end;
        %Concatenate data for heatmap visualization
        concatPSTrace = [concatPSTrace meanNormalizedTrace]; %#ok<AGROW>
    end;
    
    %Visualize data
    figHands(end+1) = figure('Name', 'Average population heatmap');
    hold on;
    imagesc(concatPSTrace, plotLimits);
    colormap(hot);
    set(gca, 'YLim', [1 nROIs-1], 'XLim', [0 size(concatPSTrace,2)]);
    ylabel('ROI');
    %xlabel('Time (s)');
    %set(gca, 'XTick', [0:100:size(blockTraceFilt, 2)], 'XTickLabel', [0:100:size(blockTraceFilt, 2)]./frameRate);
    %title (sprintf('Average heatmap for %s', stimNames{iStim, 1}));
    
    yLimits = get(gca, 'xlim');
    
    % add line to separate stimuli
    for iStim = 1 : nStims - 1;
        line([iStim * (-psPlotLimits(1)+psPlotLimits(2)+1) iStim * (-psPlotLimits(1)+psPlotLimits(2)+1)], yLimits, 'LineWidth', 1.5, 'Color', 'white');
    end;
    
    title('Average heatmap for all stimuli');
    colorbar('CLim', plotLimits);
    hColBar = colorbar;
    set(get(hColBar,'YLabel'), 'String', 'DFF [%]');
    set(hColBar, 'YLim', plotLimits);
    hold off;
end