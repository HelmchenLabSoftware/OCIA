function [trialsPSFramesMap, tPS, stimIDs, hashStruct] = OCIA_analysis_widefield_getTrialsMappingMultiFreq(this, iFile)
% OCIA_analysis_widefield_getTrialsMappingMultiFreq - [no description]
%
%       [trialsPSFramesMap, tPS, stimIDs, hashStruct] = OCIA_analysis_widefield_getTrialsMappingMultiFreq(this, iFile)
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

filePath = get(this, iFile, 'path');
if isempty(regexp(filePath, '\.h5$', 'once')) && ~isempty(regexp(filePath, 'exp\d+_\w+$', 'once'));
    [trialsPSFramesMap, tPS, stimIDs, hashStruct] = OCIA_analysis_widefield_getTrialsMappingMultiFreqFromLabview(this, iFile);
    return;
    
elseif isempty(regexp(filePath, '\.h5$', 'once')) && ~isempty(regexp(filePath, 'cond_\w+_average\.mat$', 'once'));
    [trialsPSFramesMap, tPS, stimIDs, hashStruct] = OCIA_analysis_widefield_getTrialsFromLabview(this, iFile);
    return;
    
elseif isempty(regexp(filePath, '\.h5$', 'once')) && ~isempty(regexp(filePath, 'stim_trial\d+\.mat$', 'once'));
    [trialsPSFramesMap, tPS, stimIDs, hashStruct] = OCIA_analysis_widefield_getTrialsFromLabview(this, iFile);
    return;
    
end;

%% get the data
% get information from selected file
[filePath, ~, framesDatasetPath, ~, framesDim, frameRate, ~, ~, ~, attribs] = OCIA_analysis_widefield_getFileInfo(this, iFile, true);
% get parameters
stimFreq = this.an.wf.stimFreq;
baseFrames = this.an.wf.baseFrames;
evokedFrames = this.an.wf.evokedFrames;

% if data was recorded on a trial base already, not need to do the spliting up in stim vect
if numel(framesDim) == 5;
    [trialsPSFramesMap, tPS, stimIDs, hashStruct] = OCIA_analysis_widefield_getTrialsMappingMultiFreqTrialBased(this, iFile);
    return;
end;

% limit frame range
frameRange = this.an.wf.frameRange;
if frameRange(2) == -1; frameRange(2) = Inf; end;
frameRange = [max(1, frameRange(1)), min(framesDim(3), frameRange(end))];
framesDim(3) = diff(frameRange) + 1;

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

    % calculate dimensions
    nMaxTrials = round(round(nFrames / frameRate) * stimFreq);
    nFramesTrial = round((1 / stimFreq) * frameRate);
    PSFrameIndexes = unique([baseFrames(1) : baseFrames(2), evokedFrames(1) : evokedFrames(2)]);
    nPSFrames = numel(PSFrameIndexes);
       
    % create time vector
    tPS = PSFrameIndexes / frameRate;

    % create stim vector
    stimVect = zeros(1, nFrames);
    stimVect(1 : nFramesTrial : (nMaxTrials * nFramesTrial - 1)) = 1;
    stimFrames = find(stimVect);
    uniqueFreqs = unique(attribs.fouBaseFreq);
    nStims = numel(uniqueFreqs);
    [~, stimSeq] = ismember(attribs.fouBaseFreq, uniqueFreqs);
    iStim = 1;
    for iStimFrame = 1 : numel(stimFrames);
        stimVect(stimFrames(iStimFrame)) = stimSeq(iStim);
        iStim = iStim + 1;
        if iStim > numel(stimSeq); iStim = 1; end;
    end;
    
    % create stimulus IDs
    stimIDs = regexp(regexprep(sprintf('%dkHz-', round(uniqueFreqs / 1000)), '-$', ''), '-', 'split');
    if numel(uniqueFreqs) == 3 && all(sort(uniqueFreqs) == [1 2 3])
        stimIDs = { 'auditory', 'visual', 'somatosensory' };
    end;
    
    % initiate trial array
    trialsPSFrames = nan(nTotBins, nMaxTrials, nStims, nPSFrames);
    
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
        chunkFrames = h5read(filePath, framesDatasetPath, [yChunkStart, xChunkStart, frameRange(1)], ...
            [chunkSizeH, chunkSizeW, nFrames]);
        
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
            frames = chunkFrames(yRange, xRange, :); %#ok<PFBNS>
            
            % get average of selected pixels
            trace = reshape(nanmean(nanmean(frames, 1), 2), 1, nFrames);
%             trace = repmat(nanmean(frames(:)), 1, nFrames); % for debug
            
            %{
            figure('Name', sprintf('MultiFreqMappingTrials - trace + stim - bin %d chunk %d', iBinLoop, iChunk));
            t = (1 : numel(trace)) / frameRate;
            plot(t, trace);
            hold on;
            cols = lines(nStims);
            for iStim = 1 : nStims;
                line(repmat(t(stimVect == iStim), 2, 1), repmat([min(trace(:)); max(trace(:))], 1, ...
                    sum(stimVect == iStim)), 'Color', cols(iStim, :), 'LineStyle', ':');
            end;
            hold off;
            %}
            
            % get the PS time course
            trialsPSFramesBin = extractPSTrace(permute(trace, [3, 1, 2]), stimVect, ...
                [baseFrames, evokedFrames], nMaxTrials, true);
            trialsPSFramesBin = permute(trialsPSFramesBin, [3, 2, 1, 4]);
            % exclude first trial
            trialsPSFramesBin(:, 1, :, :) = [];
            
            % remove nan frames
            isEmptyFrame = false(size(trialsPSFramesBin, 4), 1);
            for iFrame = 1 : size(trialsPSFramesBin, 4);
                trialNaNs = isnan(trialsPSFramesBin(:, :, :, iFrame));
                isEmptyFrame(iFrame) = all(trialNaNs(:));
            end;
            trialsPSFramesBin(:, :, :, isEmptyFrame) = [];
            
            % normalize with baseline
            baseline = nanmean(trialsPSFramesBin(:, :, :, tPS <= 0), 4);
            trialsPSFramesBin = 100 * (trialsPSFramesBin - repmat(baseline, 1, 1, 1, nPSFrames)) ...
                ./ repmat(baseline, 1, 1, 1, nPSFrames);
            
            %{
            figure('Name', sprintf('MultiFreqMappingTrials - PSTrials - bin %d chunk %d', iBinLoop, iChunk));
            t = (1 : numel(trace)) / frameRate;
            plot(t, trace);
            cols = lines(nStims);
            for iStim = 1 : nStims;
                subplot(2, 3, iStim);
                hold on;
                for iTrial = 1 : size(trialsBin, 2);
                    plot(tPS, squeeze(trialsBin(1, iTrial, iStim, :)), 'Color', cols(iStim, :), 'LineStyle', ':');
                end;
                plot(tPS, squeeze(nanmean(trialsBin(1, :, iStim, :), 2)), 'Color', cols(iStim, :), 'LineWidth', 2);
                hold off;
                subplot(2, 3, 6);
                hold on;
                plot(tPS, squeeze(nanmean(trialsBin(1, :, iStim, :), 2)), 'Color', cols(iStim, :), 'LineWidth', 2);
                hold off;
            end;
            %}
            
            % store
            trialsPSFramesLocal{iBinLoop} = trialsPSFramesBin;

        end; % bin loop end
        
        % copy back data
        for iBinLoop = 1 : numel(relevantBinIndexes);
            trialsPSFrames(relevantBinIndexes(iBinLoop), 1 : size(trialsPSFramesLocal{iBinLoop}, 2), :, :) = trialsPSFramesLocal{iBinLoop};
        end;
        
    end; % chunk loop end
        
    % turn into a map
    trialsPSFramesMap = nan([fliplr(nBins), nMaxTrials, nStims, nPSFrames]);
    for iBin = 1 : nTotBins;
        [iY, iX] = ind2sub(fliplr(nBins), iBin);
        trialsPSFramesMap(iY, iX, :, :, :) = trialsPSFrames(iBin, :, :, :);
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
