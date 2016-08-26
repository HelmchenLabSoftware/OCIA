function [trialsPSFramesMap, tPS, stimIDs, hashStruct] = OCIA_analysis_widefield_getTrialsMappingMultiFreqTrialBased(this, iFile)
% OCIA_analysis_widefield_getTrialsMappingMultiFreqTrialBased - [no description]
%
%       [trialsPSFramesMap, tPS, stimIDs, hashStruct] = OCIA_analysis_widefield_getTrialsMappingMultiFreqTrialBased(this, iFile)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% default output
[trialsPSFramesMap, tPS, stimIDs, hashStruct] = deal([]);

% get number of bins
nBins = this.an.wf.nBins;
nTotBins = prod(nBins);
% abort if no bins
if isempty(nBins) || any(nBins == 0); return; end;

%% get the data
% get information from selected file
[filePath, ~, framesDatasetPath, ~, framesDim, frameRate, ~, ~, ~, attribs] = OCIA_analysis_widefield_getFileInfo(this, iFile, true);

% check wheter to put all trials together or not
doAverageTrials = this.an.wf.frameRange(2) == -2;
doAlignTrialsForOnset = 1;
% limit trial number
trialRange = this.an.wf.frameRange;
if trialRange(2) < 0; trialRange(2) = Inf; end;
trialRange = [max(1, trialRange(1)), min(framesDim(4), trialRange(end))];
nTrials = diff(trialRange) + 1;

% use cropped dimensions if any
H = framesDim(1); W = framesDim(2); nFrames = framesDim(3);
X = iff(isempty(this.an.wf.cropRect), 1, this.an.wf.cropRect, [], 1);
Y = iff(isempty(this.an.wf.cropRect), 1, this.an.wf.cropRect, [], 2);
W = iff(isempty(this.an.wf.cropRect), W, this.an.wf.cropRect, [], 3);
H = iff(isempty(this.an.wf.cropRect), H, this.an.wf.cropRect, [], 4);

% get the data in memory
hashStruct = OCIA_analysis_widefield_getHashStruct(this, iFile, 'WFMappingTrials', 'phase|power|BLCorr|stimFreqInterval');
cachedData = ANGetCachedData(this, 'wf', hashStruct);

% if the data is not in cache yet, generate it
if isempty(cachedData);
    
    t0 = tic;

    % check if binning factor is a divider of the image size (same pixel number in each bin)
    if mod(H, nBins(2)) ~= 0 || mod(W, nBins(1)) ~= 0;
        msg = sprintf('Number of bins is not a perfect divider for image size (nBins = [%d, %d], imgSize = [%d %d]).', nBins, W, H);
        showWarning(this, sprintf('OCIA:%s:BadBinning', mfilename()), msg);
        ANShowHideMessage(this, 1, msg);
        return;
    end;
    
    % get bin size
    binSizeW = W / nBins(1); binSizeH = H / nBins(2);
    % get dataset size
    nStimTypes = framesDim(5);
       
    % create time vector
    tPS = ((1 : nFrames) / frameRate) - attribs.BLDur;
    
    % create stimulus IDs
    if ~isempty(attribs.stimIDs) && isnumeric(attribs.stimIDs{1});
        stimIDs = regexp(regexprep(sprintf('%dkHz-', round(cell2mat(attribs.stimIDs) / 1000)), '-$', ''), '-', 'split');
    else
        stimIDs = attribs.stimIDs;
    end;
    
    % initiate trial array
    trialsPSFrames = nan(nTotBins, nFrames, iff(doAverageTrials, 1, nTrials), nStimTypes);
    
    % number of chunks to divide the raw data into, which is limited by memory but still speeds
    %   up the processing since it avoids multiple read access to data
    nChunkW = this.an.wf.chunkSizeFactor(1);
    nChunkH = this.an.wf.chunkSizeFactor(2);
    chunkSizeW = round(W / nChunkW);
    chunkSizeH = round(H / nChunkH);
        
    % extract chunk by chunk
    for iChunk = 1 : (nChunkW * nChunkH);
        
        ANShowHideMessage(this, 1, sprintf(['Calculating bins (chunk %d/%d - init)... (%d bin(s), bin size = [%d, %d], ', ...
            'nChunks = [%d, %d], chunkSize = [%d, %d], nFrames = %d)'], iChunk, nChunkW * nChunkH, nTotBins, binSizeW, binSizeH, ...
            nChunkW, nChunkH, chunkSizeW, chunkSizeH, nFrames));
                
        % get bin's X and Y range
        [iChunkY, iChunkX] = ind2sub([nChunkH, nChunkW], iChunk);
        % load the pixels for the current chunk
        xChunkStart = ((iChunkX - 1) * chunkSizeW + X);
        yChunkStart = ((iChunkY - 1) * chunkSizeH + Y);
        xChunkEnd = xChunkStart + chunkSizeW - 1;
        yChunkEnd = yChunkStart + chunkSizeH - 1;
        chunkFrames = h5read(filePath, framesDatasetPath, [yChunkStart, xChunkStart, 1, trialRange(1), 1], ...
            [chunkSizeH, chunkSizeW, nFrames, nTrials, nStimTypes]);
        
        % put trials together if required
        if doAverageTrials;
            chunkFrames = nanmean(chunkFrames, 4);
        end;
        
        ANShowHideMessage(this, 1, sprintf(['Calculating bins (chunk %d/%d - loaded)... (%d bin(s), bin size = [%d, %d], ', ...
            'nChunks = [%d, %d], chunkSize = [%d, %d], nFrames = %d)'], iChunk, nChunkW * nChunkH, nTotBins, binSizeW, binSizeH, ...
            nChunkW, nChunkH, chunkSizeW, chunkSizeH, nFrames));
               
        % get relevant bin indexes
        isBinOutOfRange = false(1, nTotBins);
        parfor iBin = 1 : nTotBins;
            % get bin's X and Y range
            [iY, iX] = ind2sub(fliplr(nBins), iBin);
            xStart = (iX - 1) * binSizeW + X;
            yStart = (iY - 1) * binSizeH + Y;
            xEnd = xStart + binSizeW - 1;
            yEnd = yStart + binSizeH - 1;
            % tag bin as not relevant if not within range (not loaded in current chunk, will be added in the next chunk
            isBinOutOfRange(iBin) = xStart < xChunkStart || yStart < yChunkStart || xEnd > xChunkEnd || yEnd > yChunkEnd;
        end;
        relevantBinIndexes = find(~isBinOutOfRange);
        
        ANShowHideMessage(this, 1, sprintf(['Calculating bins (chunk %d/%d - screened (%d relevant bins))... (%d bin(s), bin size = [%d, %d], ', ...
            'nChunks = [%d, %d], chunkSize = [%d, %d], nFrames = %d)'], iChunk, nChunkW * nChunkH, numel(relevantBinIndexes), nTotBins, binSizeW, binSizeH, ...
            nChunkW, nChunkH, chunkSizeW, chunkSizeH, nFrames));
        
        % initialize local maps
        trialsPSFramesLocal = cell(numel(relevantBinIndexes), 1);
        % actually loop over the relevant bins
        parfor iBinLoop = 1 : numel(relevantBinIndexes);
        
            % get bin's X and Y range
            [iY, iX] = ind2sub(fliplr(nBins), relevantBinIndexes(iBinLoop));
            xStart = (iX - 1) * binSizeW + X;
            yStart = (iY - 1) * binSizeH + Y;
            
            % load the pixels for the selected range
            xRange = (xStart : (xStart + binSizeW - 1)) - xChunkStart + 1;
            yRange = (yStart : (yStart + binSizeH - 1)) - yChunkStart + 1;
            frames = chunkFrames(yRange, xRange, :, :, :); %#ok<PFBNS>
            
            % get average of selected pixels
            binPSFrames = reshape(nanmean(nanmean(frames, 1), 2), nFrames, size(frames, 4), nStimTypes);
            
            % normalize with baseline
            baseline = nanmean(binPSFrames(tPS <= 0, :, :), 1);
            binPSFrames = 100 * (binPSFrames - repmat(baseline, nFrames, 1, 1)) ...
                ./ repmat(baseline, nFrames, 1, 1);
            
            % store
            trialsPSFramesLocal{iBinLoop} = binPSFrames;

        end; % bin loop end
        
        % copy back data
        for iBinLoop = 1 : numel(relevantBinIndexes);
            trialsPSFrames(relevantBinIndexes(iBinLoop), 1 : size(trialsPSFramesLocal{iBinLoop}, 1), :, :) = trialsPSFramesLocal{iBinLoop};
        end;
        
        %% align trials
        if doAlignTrialsForOnset;
            trialsBinAvg = reshape(nanmean(trialsPSFrames, 1), [nFrames, iff(doAverageTrials, 1, nTrials), nStimTypes]);
            % correct for first 2 frames glitch
            trialsBinAvg(1 : 3, :, :) = repmat(nanmean(nanmean(trialsBinAvg(tPS < 0, :, :))), [3, size(trialsBinAvg, 2), 1]);
            
            yLims = [floor(min(trialsBinAvg(:))), ceil(max(trialsBinAvg(:)))];
            threshFactorStd = 1.5;
            threshFactorEv = 1.5;
            
            figure();
            N = ceil(sqrt(nStimTypes));
            stimCols = hsv(nStimTypes);
            xLims = [1.1 * (2 * tPS(1) - tPS(2)), 1.1 * (2 * tPS(end) - tPS(end - 1))];
            for iStim = 1 : nStimTypes;
                subplot(N, N, iStim);
                hold on;
                stdBaseAll = nanmean(std(trialsBinAvg(tPS < 0, :, iStim), 1));
                for iTrial = 1 : size(trialsBinAvg, 2);
                    timeSerie = trialsBinAvg(:, iTrial, iStim);
                    stdBase = std(timeSerie(tPS < 0));
                    meanEv = nanmean(timeSerie(tPS > 0));
                    meanBase = nanmean(timeSerie(tPS < 0));
                    if stdBase > (threshFactorStd * stdBaseAll);
                        plot(tPS, timeSerie, 'Color', 'black', 'LineStyle', ':');
                        trialsBinAvg(:, iTrial, iStim) = nan(nFrames, 1);
                    elseif meanEv < (threshFactorEv * meanBase);
                        plot(tPS, timeSerie, 'Color', 'black', 'LineStyle', '--');
                        trialsBinAvg(:, iTrial, iStim) = nan(nFrames, 1);
                    else
                        plot(tPS, timeSerie, 'Color', stimCols(iStim, :));
                    end;
                end;
                plot(tPS, nanmean(trialsBinAvg(:, :, iStim), 2), 'Color', stimCols(iStim, :), 'LineWidth', 3);
                hold off;
                xlim(xLims);
                ylim(yLims);
                title(stimIDs{iStim});
            end;
            
        end;
        
    end; % chunk loop end
        
    % turn into a map
    trialsPSFramesMap = nan([fliplr(nBins), size(trialsPSFrames, 3), nStimTypes, nFrames]);
    for iBin = 1 : nTotBins;
        [iY, iX] = ind2sub(fliplr(nBins), iBin);
        trialsPSFramesMap(iY, iX, :, :, :) = permute(trialsPSFrames(iBin, :, :, :), [1, 3, 4, 2]);
    end;
    trialsPSFramesMap = permute(trialsPSFramesMap, [2, 1, 3, 4, 5]);
        
    % remove empty trials
    isEmptyTrial = false(size(trialsPSFramesMap, 3), 1);
    for iTrial = 1 : size(trialsPSFramesMap, 3);
        trialNaNs = isnan(trialsPSFramesMap(:, :, iTrial, :, :));
        isEmptyTrial(iTrial) = all(trialNaNs(:));
    end;
    trialsPSFramesMap(:, :, isEmptyTrial, :, :) = [];
    
    ANShowHideMessage(this, 1, sprintf(['Calculating bins done (%.2f sec). (%d bin(s), bin size = [%d, %d], ', ...
        'nChunks = [%d, %d], chunkSize = [%d, %d])'], toc(t0), nTotBins, binSizeW, binSizeH, ...
        nChunkW, nChunkH, chunkSizeW, chunkSizeH));
        
    % store the variables in the cached structure
    cachedData = struct('trialsPSFramesMap', trialsPSFramesMap, 'tPS', tPS, 'stimIDs', { stimIDs }, 'dataType', 'WFMappingTrials', ...
        'params', hashStruct);
    % store the data in memory
    ANStoreCachedData(this, 'wf', hashStruct, cachedData);
    
% if data was directly in memory, fetch it
else
    
    % fetch the data
    ANShowHideMessage(this, 1, 'Loading data from cache ...');
    trialsPSFramesMap = cachedData.trialsPSFramesMap;
    tPS = cachedData.tPS;
    stimIDs = cachedData.stimIDs;

end;

end
