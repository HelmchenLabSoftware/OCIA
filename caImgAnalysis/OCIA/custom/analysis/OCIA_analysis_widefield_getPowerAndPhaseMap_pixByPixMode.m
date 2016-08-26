function [powerMap, phaseMap, freqVect, complexMap, hashStruct] = OCIA_analysis_widefield_getPowerAndPhaseMap_pixByPixMode(this, iFile)
% OCIA_analysis_widefield_getPowerAndPhaseMap_pixByPixMode - [no description]
%
%       [powerMap, phaseMap, freqVect, complexMap, hashStruct] = OCIA_analysis_widefield_getPowerAndPhaseMap_pixByPixMode(this, iFile)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% default output
[powerMap, phaseMap, freqVect, complexMap, hashStruct] = deal([]);

% abort if no bins
nBins = this.an.wf.nBins;
nTotBins = prod(nBins);
if isempty(nBins) || any(nBins == 0); return; end;

%% get the data
% get information from selected file
[filePath, ~, framesDatasetPath, ~, framesDim, frameRate] = OCIA_analysis_widefield_getFileInfo(this, iFile, true);
% get stimulation infos
stimFreq = this.an.wf.stimFreq;
stimFreqInterval = this.an.wf.stimFreqInterval;
% limit frame range
frameRange = this.an.wf.frameRange;
if frameRange(2) == -1; frameRange(2) = Inf; end;
frameRangeStart = max(1, frameRange(1));
frameRangeEnd = min(framesDim(3), frameRange(2));
framesDim(3) = frameRangeEnd - frameRangeStart + 1;
nFrames = framesDim(3);
nFrameSteps = iff(numel(frameRange) >= 3, frameRange, 1, 3);
nFramesPerStep = min(framesDim(3), iff(numel(frameRange) >= 4, frameRange, framesDim(3), 4));
fStarts = round((0 : (nFrames - nFramesPerStep) / (nFrameSteps - 1) : (nFrames - nFramesPerStep))) + 1;
fStartsCorrs = fStarts - mod(fStarts - 1, frameRate / stimFreq);
if numel(fStartsCorrs) == 1 && isnan(fStartsCorrs);
    fStartsCorrs = 1;
end;
fEnds = fStartsCorrs + nFramesPerStep - 1;
fRanges = cell2mat(arrayfun(@(i)(fStartsCorrs(i) : fEnds(i)), 1 : numel(fStartsCorrs), 'UniformOutput', false)');
fRanges = unique(fRanges, 'rows', 'stable');
nFrameSteps = size(fRanges, 1);
this.an.wf.storeData.fRanges = fRanges;
% debug plot
if nFrameSteps > 1;
    figure('Name', 'Frame ranges');
    hold on;
    for i = 1 : nFrameSteps;
        scatter(fRanges(i, :), ones(nFramesPerStep, 1) * i);
    end;
    xlabel('Frames', 'FontSize', 29);
    ylabel('Chunk number', 'FontSize', 29);
    set(gca, 'XLim', [- nFrames * 0.05, nFrames * 1.05], 'YLim', [0.5, nFrameSteps + 0.5], 'FontSize', 25);
    hold off;
    makePrettyFigure(gcf);
end;
% baseline correction method
BLCorrMeth = this.an.wf.BLCorrMethod;
BLCorrParam = this.an.wf.BLCorrParam;
% window size for trace corrections with high-pass filter
windowSize = iff(strcmp(BLCorrMeth, 'slidingAvg'), round(frameRate ./ BLCorrParam), 0);
% use cropped dimensions if any
H = framesDim(1); W = framesDim(2);
X = iff(isempty(this.an.wf.cropRect), 1, this.an.wf.cropRect, [], 1);
Y = iff(isempty(this.an.wf.cropRect), 1, this.an.wf.cropRect, [], 2);
W = iff(isempty(this.an.wf.cropRect), W, this.an.wf.cropRect, [], 3);
H = iff(isempty(this.an.wf.cropRect), H, this.an.wf.cropRect, [], 4);

% get the data in memory
hashStruct = OCIA_analysis_widefield_getHashStruct(this, iFile, 'WFPowerAndPhaseMaps', '(base|evoked)Frames|power|phase');
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
    
    % get analysable frequencies
    validFreqIndexes = 1 : floor(nFrames / 2);
    freqVect = (frameRate / 2) * linspace(0, 1, numel(validFreqIndexes));
    
    % initialize maps
    powerMap = nan([fliplr(nBins), nFrameSteps]);
    phaseMap = nan([fliplr(nBins), nFrameSteps]);
    complexMap = nan([fliplr(nBins), nFrameSteps]);
    
    % get relevant stimulus frequency indexes
    [~, stimFreqIndexLeft] = min(abs(freqVect - stimFreq + stimFreqInterval));
    [~, stimFreqIndexRight] = min(abs(freqVect - stimFreq - stimFreqInterval));
    
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
        chunkFrames = h5read(filePath, framesDatasetPath, [yChunkStart, xChunkStart, frameRangeStart], ...
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
        
        % loop over the frame chunks
        for iFrameChunk = 1 : nFrameSteps;
        
            if nFrameSteps > 1;
                ANShowHideMessage(this, 1, sprintf('Calculating bins (chunk %d/%d - frame chunk %d/%d, %d -> %d) ...', ...
                    iChunk, nChunkW * nChunkH, iFrameChunk, nFrameSteps, fRanges(iFrameChunk, 1), fRanges(iFrameChunk, end)));
            end;
        
            % initialize local maps
            powerMapLocal = nan(numel(relevantBinIndexes), 1);
            phaseMapLocal = nan(numel(relevantBinIndexes), 1);
            complexMapLocal = nan(numel(relevantBinIndexes), 1);
            % actually loop over the relevant bins
            parfor iBinLoop = 1 : numel(relevantBinIndexes);

                % get bin's X and Y range
                [iY, iX] = ind2sub(fliplr(nBins), relevantBinIndexes(iBinLoop));
                xStart = (iX - 1) * binSizeW + X;
                yStart = (iY - 1) * binSizeH + Y;
                % load the pixels for the selected range
                xRange = (xStart : (xStart + binSizeW - 1)) - xChunkStart + 1;
                yRange = (yStart : (yStart + binSizeH - 1)) - yChunkStart + 1;
                frames = chunkFrames(yRange, xRange, fRanges(iFrameChunk, :)); %#ok<PFBNS>
                % get average of selected pixels
                trace = reshape(nanmean(nanmean(frames, 1), 2), 1, nFramesPerStep);

                switch BLCorrMeth;
                    case 'mean';
                        % correct the trace
                        trace = trace - nanmean(trace);
    %                     trace = (trace - nanmean(trace)) / nanmean(trace);

                    case 'slidingAvg';

                        % high-pass filter with a moving average filter
                        slidingAvg = zeros(size(trace));
                        for iFrame = 1 : nFrames;
                            frameStart = max(round(iFrame - 0.5 * windowSize), 1);
                            frameEnd = min(round(iFrame + 0.5 * windowSize), nFrames);
                            slidingAvg(iFrame) = nanmean(trace(frameStart : frameEnd));
                        end;
                        % correct the trace
                        trace = trace - slidingAvg;

                    case 'polynomial';
                        % fit a degree "BLCorrParam" polynomial
                        p = polyfit(1 : numel(trace), trace, BLCorrParam);
                        polyCorr = polyval(p, 1 : numel(trace));
                        % correct the trace
                        trace = trace - polyCorr;

                    case 'bpfilter';
                        trace = mpi_BandPassFilterTimeSeries(trace, 1 / frameRate, BLCorrParam(1), BLCorrParam(2));

                    otherwise;
                        % do nothing
                end;

                % do FFT
                FFTVectAll = fft(trace, nFrames) / nFrames;
                % exclude first point because it's messed up
                FFTVectAll(1) = 0;
                % get only the values for the valid frequencies
                FFTVectValid = FFTVectAll(validFreqIndexes);
                % calculate power and phase
                powVect = abs(FFTVectValid) .^ 2;
                phaseVect = angle(FFTVectValid);            

                % extract power and phase at those indexes
                powerMapLocal(iBinLoop) = nanmean(powVect(stimFreqIndexLeft : stimFreqIndexRight));
                phaseMapLocal(iBinLoop) = nanmean(phaseVect(stimFreqIndexLeft : stimFreqIndexRight));
                complexMapLocal(iBinLoop) = FFTVectValid(stimFreqIndexLeft : stimFreqIndexRight);

            end; % bin loop end

            % copy back data
            powerMap(relevantBinIndexes + (iFrameChunk - 1) * nTotBins) = powerMapLocal;
            phaseMap(relevantBinIndexes + (iFrameChunk - 1) * nTotBins) = phaseMapLocal;
            complexMap(relevantBinIndexes + (iFrameChunk - 1) * nTotBins) = complexMapLocal;
        end;
        
    end; % chunk loop end
    
    ANShowHideMessage(this, 1, sprintf(['Calculating bins done (%.2f sec). (%d bin(s), bin size = [%d, %d], ', ...
        'nChunks = [%d, %d], chunkSize = [%d, %d])'], toc(t0), nTotBins, binSizeW, binSizeH, ...
        nChunkW, nChunkH, chunkSizeW, chunkSizeH));
        
    % rotate maps if needed
    if this.an.wf.imRotationAngle;
        powerMap = imrotate(powerMap, this.an.wf.imRotationAngle, 'bilinear', 'crop');
        phaseMap = imrotate(phaseMap, this.an.wf.imRotationAngle, 'bilinear', 'crop');
        complexMap = imrotate(complexMap, this.an.wf.imRotationAngle, 'bilinear', 'crop');
    end;
        
    % store the variables in the cached structure
    cachedData = struct('powerMap', powerMap, 'phaseMap', phaseMap, 'freqVect', freqVect, ...
        'complexMap', complexMap, 'dataType', 'WFPowerAndPhaseMaps', 'params', hashStruct);
    % store the data in memory
    ANStoreCachedData(this, 'wf', hashStruct, cachedData);
    
% if data was directly in memory, fetch it
else
    
    % fetch the data
    ANShowHideMessage(this, 1, 'Loading data from cache ...');
    powerMap = cachedData.powerMap;
    phaseMap = cachedData.phaseMap;
    complexMap = cachedData.complexMap;

end;

end
