function figHands = plotSpontVsEvoked(caTraces, noiseLevels, tuningStruct, BSStat, stim, stimNames, plotLimits, saveName)
    % Specific function to create spontaneous vs evoked plots for whisker
    % stim paradigm.
    %
    % Usage:
    %
    % Author: A. van der Bourg, 2014
    

    
    %% Init variables
    respSorting = 'lookupTable';
    maxResp = 10;
    nLevel = 10;
    %plotLimits = [plotLimits(1)+10, plotLimits(2)];
    % extract the stimuli times
    stimFrames = find(stim>0);
    % extract the stimulus 'IDs' by converting the stim index into a string (the index of the stimuli)
    stimIDIndexes = stim(stim > 0);
    stimIDs = cell(1, numel(stimIDIndexes));
    for n = 1 : numel(stimIDIndexes);
        stimIDs{n} = num2str(stimIDIndexes(n));
    end;
    presStims = unique(stimIDIndexes);
    nStims = size(presStims, 2);
    %obtain specified tuning for "most active set"
    statTypes = unique(strrep(fieldnames(tuningStruct), 'Err', ''));
    iTargetStat = strcmp(statTypes, BSStat);
    tuning = tuningStruct.(statTypes{iTargetStat});
    
    figHands = [];
    
    %% lookupList for single runs
    %P13A2
    %lookupTable = [1;16;24];
    %P10A1 R1S1
    %lookupTable = [2; 7; 29];
    %P23A1 R1S1
    lookupTable = [1; 6; 8];
    
    %% hard coded init variables
    blockSize = 579;
    preStimFrames = 80;
    traceDist = 100;
    gBoxLims = 4* traceDist+50;
    
    %% Plot most active set of 3 based on sorting method
    candidateList = [];
    switch respSorting
        case 'maxResp'
            for i = 1:size(nStims)
                for k = 1:3
                    [~, indx] = max(tuning(i, :));
                    %set found max to zero so we can find next max
                    tuning(i,indx) = 0;
                    candidateList(end+1) = indx;
                end;
            end;
            
        case 'minNoise'
            for k = 1:3
                [~, indx] = min(noiseLevels);
                %set found max to zero so we can find next max
                noiseLevels(indx,1) = NaN;
                candidateList(end+1) = indx;
            end;
        case 'minNoiseMaxResp'
            highRespROIs = [];
            lowNoiseROIs = find(noiseLevels<nLevel);
            for iROI = 1:size(tuning,2)
                roiResps = find(tuning(:, iROI)>=maxResp);
                if ~isempty(roiResps)
                    highRespROIs(end+1) = iROI; %#ok<AGROW>
                end;
            end;
            if isempty(highRespROIs)
                highRespROIs = lowNoiseROIs;
            elseif isempty(lowNoiseROIs)
                lowNoiseROIs = highRespROIs;
            end;
            candidateList = intersect(lowNoiseROIs, highRespROIs);
        case 'lookupTable'
            candidateList = lookupTable;
    end;
    
    %% Plot the calcium traces for the set. Plot gray stim bars for evoked examples
    [~, spontIndx] = find(stimIDIndexes==7);
    if spontIndx(1) == 1
        spontBlockIndx = 1;
    else
        spontBlockIndx= stimFrames(spontIndx(1))-preStimFrames;
    end;
    spontTraces = caTraces(:,spontBlockIndx:(spontBlockIndx+blockSize-1));
    
    %Iterate through pair of three configuration
    if mod(size(candidateList,1),3) == 0
        iterSize = size(candidateList,2);
    else
        iterSize = (size(candidateList,1) - mod(size(candidateList,1),3));
    end;
    for cIndx = 1:3:iterSize
        figHands(end+1) = figure;
        set(figHands(end), 'Position', [100 100 300 300])
        %Plot for all candidates
        %First plot NPil
        plot(spontTraces(end,:), 'Color', 'black');
        hold on;
        plot(spontTraces(candidateList(cIndx),:)+traceDist);
        plot(spontTraces(candidateList(cIndx+1),:)+2*traceDist);
        plot(spontTraces(candidateList(cIndx+2),:)+3*traceDist);
        hold off;
        set(gca, 'YLim', [-10, gBoxLims], 'XLim', [0 blockSize]);
        title(sprintf('Stim %s, ROIs:%s, %s, %s', stimNames{7,1}, num2str(candidateList(cIndx)), num2str(candidateList(cIndx+1)), num2str(candidateList(cIndx+2))));
    end;
    
    
    
    %% Evoked stim plots
    for k = presStims
        if k == 7
            continue;
        end;
        [~, stimIndx] = find(stimIDIndexes==k);
        for cIndx = 1:3:iterSize
            figHands(end+1) = figure; %#ok<AGROW>
            % Plot grey stim tick bars
            for t = [79, 179, 279, 379, 479]
                vtStimTimes = [t t+20 t];
                vfColour = 0.8 * [1 1 1];
                overallboxLims = [-10, gBoxLims];
                hPatchStim = fill(vtStimTimes([1 1 2 2 1]), overallboxLims([1 2 2 1 1]), vfColour);
                set(hPatchStim, 'LineStyle', 'none');
                hold on;
            end;
            if stimIndx(1) == 1
                blockIndx = 1;
            else
                blockIndx= stimFrames(stimIndx(1))-preStimFrames;
            end;
            evokedTrace = caTraces(:, blockIndx:(blockIndx+blockSize-1));
            plot(evokedTrace(end,:), 'Color', 'black');
            hold on;
            plot(evokedTrace(candidateList(cIndx),:)+traceDist);
            plot(evokedTrace(candidateList(cIndx+1),:)+2*traceDist);
            plot(evokedTrace(candidateList(cIndx+2),:)+3*traceDist);
            hold off;
            %axis off;
            % set common Y and X limits for all plots
            set(gca, 'YLim', [-10, gBoxLims], 'XLim', [0 blockSize]);
            set(figHands(end), 'Position', [100 100 300 300])
            title(sprintf('Stim %s', stimNames{k,1}, num2str(candidateList(cIndx)), num2str(candidateList(cIndx+1)), num2str(candidateList(cIndx+2))));
        end;
        
    end;
    
    %% Heatmap of spont. activity
    figHands(end+1) = figure('name', 'Spontaneous heatmap plot');
    imagesc(spontTraces(:,1:blockSize));
    colormap(hot);
    %set(gca, 'YLim', [1 size(spontTraces,2)-1], 'XLim', [0 size(spontTraces,1)]);
    %ylabel('ROI');
    caxis(plotLimits);
    axis off;
    set(figHands(end), 'Position', [300 300 730 400]);
    colorbar('CLim', plotLimits);
    hColBar = colorbar;
    set(get(hColBar,'YLabel'), 'String', 'DFF [%]');
    set(hColBar, 'YLim', plotLimits);
    
    
    
    %% Surface plot of spont. activity of all neurons
    xDims = size(caTraces, 1);
    
    X = ones(xDims, blockSize);
    Y = ones(xDims, blockSize);
    Z = zeros(xDims, blockSize);
    
    %Create xyz axis
    for i = 1:xDims
        X(i, :) = 1:blockSize;
        Y(i,:) = Y(i,:)*i;
        Z(i,:) = spontTraces(i, 1:blockSize);
    end;
    figHands(end+1) = figure('name', 'Spontaneous surface plot');
    surf(X,Y,Z, 'EdgeColor', 'none');
    colormap hot;
    alpha(.8);
    view([22 58]);
    %colorbar('CLim', plotLimits);
    hColBar = colorbar;
    set(get(hColBar,'YLabel'), 'String', 'DFF [%]');
    %set(hColBar, 'YLim', plotLimits);
    set(hColBar, 'YTick', plotLimits(1) : 10 : plotLimits(2), 'YTickLabel', plotLimits(1) : 10 : plotLimits(2));
    %Re-configure the color axis settings
    caxis(plotLimits);
    axis off;
    set(figHands(end), 'Position', [300 300 730 400]);
    
end