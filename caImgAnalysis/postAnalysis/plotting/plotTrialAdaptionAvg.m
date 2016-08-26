function figHands = plotTrialAdaptionAvg(caTraces, stim, stimNames, ROISet, nROIPerFig, nStimsPerBlock, stimDur, frameRate, saveName)
    % Plot an inter-trial average with or without stimulus ticks.
    % A trial is defined as a stimulus presentation session containing
    % multiple or single stimuli, e.g. stimulus block containing 5 stimulus
    % presentations. This plot is only useful if you are interested to see
    % stimulus adaptation effects (for a single stimulus presented multiple times) or trial
    % selectivity (different stimuli).
    % NOTE: the stimulus presentations have to be ordered in blocks e.g. if
    % you presented a stimulus 4*5 times, the 4 blocks should be
    % concatenated in that fasion.
    %
    % Usage: figHands = plotInterTrialAvg(caTraces, stim, stimNames, ROISet, nROIPerFig, nStimsPerBlock, stimDur, frameRate, saveName)
    % nStimsPerBlock: number of stimuli per block
    % stim: cell stim vector
    % stimNames: cell matrix containing stim names
    % stimDur: stimulus presentation duration in seconds
    %
    % Author: A. van der Bourg, 2014
    % Adapted from Dylan Muir's PlotRegionResponses
    
    %dbgLevel = 0;
    % init the size of the inter-trial set
    nROIs = size(ROISet, 1);
    
    % extract the stimuli times
    %stimTimes = t(stim > 0);
    stimFrames = find(stim>0);
    % extract the stimulus 'IDs' by converting the stim index into a string (the index of the stimuli)
    stimIDIndexes = stim(stim > 0);
    stimIDs = cell(1, numel(stimIDIndexes));
    for n = 1 : numel(stimIDIndexes);
        stimIDs{n} = num2str(stimIDIndexes(n));
    end
    nStims = numel(stimNames);
    %Number of stim-presentations per condition
    stimPres = length(stimFrames) ./ length(stimNames);
    %Number of blocks per stimulus
    numOfBlocks = stimPres / nStimsPerBlock;
    stimOrder = stimIDIndexes(1,1:nStimsPerBlock:end);
    
    %Specify the length of each stimulation 'block' that should be plotted
    blockFrameSize = size(caTraces, 2)/(size(stimNames,1)*numOfBlocks);
    
    %Define a time vector
    %NOTE: the first frame is removed, so we define the time -1 frame
    timeVect = (1/frameRate):(1/frameRate):((blockFrameSize/frameRate)); %-1/frameRate
    
    %Obtain the stimulus times for a block - take the first as the others
    %are the same
    blockStims = stim(1:blockFrameSize);
    blockStimTickIndices = blockStims >0;
    
    %% Plot for each ROI and each stimulus the inter-trial traces
    subplotCounter = 1;
    figHands = [];
    for iROI = 1 : nROIs;
        %Decide how many ROIs are plotted per figure
        if ~mod(iROI + nROIPerFig - 1, nROIPerFig);
            figHands(end + 1) = figure('Name', sprintf('%s_ROI%s-ROI%s', saveName, ROISet{iROI, 1}, ...
                ROISet{min(iROI + nROIPerFig - 1, nROIs), 1}), 'NumberTitle', 'off'); %#ok<AGROW>
            subplotCounter = 1;
        end;
        
        %Define overall limits
        overallValues = caTraces(:,:);
        overallyLims = [floor(min(overallValues(:))) ceil(max(overallValues(:)))];
        %yLims = [floor(min(allValues(:))) ceil(max(allValues(:)))];
        
        %reduce box size so it does not overlap with plot limits
        overallboxLims = [(floor(min(overallValues(:)))+2) (ceil(max(overallValues(:)))-2)];
        
        %First obtain the calcium trace for all stimuli for that ROI
        ROICaTrace = caTraces(iROI, :);
        %Generate plots for each stimulus
        for iStim = 1:nStims
            subplot(nROIPerFig, numel(stimNames), subplotCounter);
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
            stimIndx = find(stimOrder==iStim);
            for indx = stimIndx
                if indx ==1
                    blockFrames = 1:blockFrameSize;
                else
                    blockStartIndex = (indx-1)*blockFrameSize+1;
                    blockFrames = blockStartIndex:(blockStartIndex+blockFrameSize-1);
                end;
                blockTraceFilt = ROICaTrace(blockFrames);
                
                plot(timeVect, blockTraceFilt,'Color', 0.5 * [1 1 1], 'LineWidth', 2);
                hold on;
                %sum for all traces for mean mean calculation
                sumBlockTraceFilt = sumBlockTraceFilt + blockTraceFilt;
            end;
            
            % Create the mean trace and plot it on top
            meanBlockTrace = sumBlockTraceFilt ./ numOfBlocks;
            plot(timeVect, meanBlockTrace, 'Color', 1 * [1 0 0], 'LineWidth', 3);
            % set common Y and X limits for all plots
            set(gca, 'YLim', overallyLims, 'XLim', [timeVect(1) - 0.05 timeVect(end) + 0.05], 'FontSize', 6);
            % only plot Y axis on left-most plots
            if iStim ~= 1; set(gca, 'YTick', []);
            else ylabel(sprintf('ROI%s', ROISet{iROI, 1})); end;
            % only plot X axis on bottom plots
            if mod(iROI + nROIPerFig, nROIPerFig); set(gca, 'XTick', []); end;
            %         else xlabel('Time [s]'); end
            % only plot title on top-most plots
            %TODO: add outside of loop
            if ~mod(iROI + nROIPerFig - 1, nROIPerFig); title(stimNames{iStim}, 'FontSize', 8); end
            
            hold off;
            subplotCounter = subplotCounter + 1;
        end;
        %if ~mod(iROI + nROIPerFig - 1, nROIPerFig);
         %   suptitle(sprintf('Inter trial average for each stimulus for ROIs %s-%s', ...
          %      ROISet{iROI, 1}, ROISet{min(iROI + nROIPerFig - 1, nROIs), 1}));
        %end;
    end;
end