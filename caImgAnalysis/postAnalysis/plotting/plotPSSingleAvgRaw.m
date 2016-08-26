function figHands = plotPSSingleAvgRaw(caTraces, stim, stimNames, ROISet, nStimsPerBlock, nROIPerFig, stimOnsetTick, stimTime, frameRate, plotLimits, saveName)
    %Alternative placeholder function for testing. Trying out alternative
    %way of plotting PSAverage, dependent on stim vector and defined plot
    %boundaries
    %
    %Author: A. van der Bourg, 2014
    
    
    
    %% Init variables
    psPlotLimits = [-20, 60]; %in frames
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
    nStims =numel(stimNames);
    
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
    figHands =[];
    
    for iROI = 1 : nROIs;
        if ~mod(iROI + nROIPerFig - 1, nROIPerFig);
            figHands(end + 1) = figure('Name', sprintf('%s_ROI%s-ROI%s', saveName, ROISet{iROI, 1}, ...
                ROISet{min(iROI + nROIPerFig - 1, nROIs), 1}), 'NumberTitle', 'off'); %#ok<AGROW>
            subplotCounter = 1;
        end;
        overallValues = caTraces(:,:);
        %if isempty(plotLimits)
            overallyLims = [floor(min(overallValues(:))) ceil(max(overallValues(:)))];
            %Reduce box size so it does not overlap with plot limits
            overallboxLims = [(floor(min(overallValues(:)))+2) (ceil(max(overallValues(:)))-2)];
        %else
         %   overallyLims = [plotLimits(1)-20, plotLimits(2)+20];
          %  overallboxLims = [plotLimits(1)+1, plotLimits(2)-1];
        %end;
        %Iterate through all stims
        for iStim = 1:nStims
            subplot(nROIPerFig, nStims, subplotCounter);
            PSLims = -psPlotLimits(1) + psPlotLimits(2)+1;
            meanStimTrace = zeros(1, PSLims);
            %Find frame indices for specified stim
            stimFrameIndices = find(stim==iStim);
            %Iterate through all blocks where the specified stimulus was
            %presented
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
            for iFrameIndex = stimFrameIndices
                blockTrace = caTraces(iROI, (iFrameIndex+psPlotLimits(1)):(iFrameIndex+psPlotLimits(2)));
                meanStimTrace = meanStimTrace + blockTrace;
                % plot all trials
                PSTime = psPlotLimits(1)/10:0.1:psPlotLimits(2)/10;
                plot(PSTime, blockTrace,'Color', 0.5 * [1 1 1], 'LineWidth', 0.5);
            end;
            meanStimTrace = meanStimTrace ./ stimPres;
            hold on;
            plot(PSTime, meanStimTrace, 'Color', 1 * [1 0 0], 'LineWidth', 2);
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
            if ~mod(iROI + nROIPerFig - 1, nROIPerFig); title(stimNames{iStim,1}, 'FontSize', 8); end
            
            hold off;
            subplotCounter = subplotCounter + 1;
        end;
    end;
    
    
    
    
    
    
    
    
end