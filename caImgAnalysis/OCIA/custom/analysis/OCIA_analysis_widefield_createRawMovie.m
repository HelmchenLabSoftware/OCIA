function [allFrames, hashStruct] = OCIA_analysis_widefield_createRawMovie(this)
% OCIA_analysis_widefield_getMovie - [no description]
%
%       [allFrames, hashStruct] = OCIA_analysis_widefield_createRawMovie(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% default output
[allFrames, hashStruct] = deal([]);

% get number of bins
nBins = this.an.wf.nBins;
nTotBins = prod(nBins);
% abort if no bins
if isempty(nBins) || any(nBins == 0); return; end;

iFile = get(this.GUI.handles.an.rowList, 'Value');
iFile = iFile(1);

ANClearPlot(this);
    
%% get the data
% get information from selected file
[filePath, ~, framesDatasetPath, ~, framesDim, frameRate] = OCIA_analysis_widefield_getFileInfo(this, iFile, true);
% baseline correction method
BLCorrMethod = this.an.wf.BLCorrMethod;
BLCorrParam = this.an.wf.BLCorrParam;
% window size for trace corrections with high-pass filter
windowSize = iff(strcmp(BLCorrMethod, 'slidingAvg'), round(frameRate ./ BLCorrParam), 0);

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
% 
% % create time vector
% t = (1 : nFrames) / frameRate;

t0 = tic;
    
% get bin size
binSizeW = W / nBins(1); binSizeH = H / nBins(2);

% extract the pixel time course for each bin
pixelTimeCourse = nan(nTotBins, nFrames);

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
    pixelTimeCourseLocal = nan(numel(relevantBinIndexes), nFrames);
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

        switch BLCorrMethod;
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

        % store
        pixelTimeCourseLocal(iBinLoop, :) = trace;

    end; % bin loop end

    % copy back data
    pixelTimeCourse(relevantBinIndexes, :) = pixelTimeCourseLocal;

end; % chunk loop end

ANShowHideMessage(this, 1, sprintf(['Calculating bins done (%.2f sec). (%d bin(s), bin size = [%d, %d], ', ...
    'nChunks = [%d, %d], chunkSize = [%d, %d])'], toc(t0), nTotBins, binSizeW, binSizeH, ...
    nChunkW, nChunkH, chunkSizeW, chunkSizeH));

% get frames
allFrames = linScale(reshape(pixelTimeCourse, [nBins, nFrames]));

ANShowHideMessage(this, 1, 'Extracted frames ...');

% get file path
filePath = regexprep(filePath, '\.h5', '');

% bin size string
filePath = sprintf('%s_%dx%d', filePath, nBins);
    
% add base line correction string
if strcmp(this.an.wf.BLCorrMethod, 'bpfilter');
    BLCorrStr = sprintf('%.3f,%.3f', this.an.wf.BLCorrParam);
    BLCorrStr = regexprep(regexprep(BLCorrStr, '\.', 'p'), ',', 'to');
    BLCorrStr = regexprep(BLCorrStr, '0+to', 'to');
    BLCorrStr = regexprep(BLCorrStr, '0+$', '');
    BLCorrStr = regexprep(BLCorrStr, 'p$', '');
    BLCorrStr = sprintf('_%sBPFilter', BLCorrStr);

elseif strcmp(this.an.wf.BLCorrMethod, 'polynomial');
    BLCorrStr = sprintf('_degree%dPolyBLCorr', this.an.wf.BLCorrParam);

else
    BLCorrStr = sprintf('_%sBLCorr', this.an.wf.BLCorrMethod);

end;
filePath = sprintf('%s%s', filePath, BLCorrStr);

% change to newAnalysis folder
filePath = regexprep(filePath, '^(.+)/([^/]+)$', '$1/newAnalysis/$2');

ANShowHideMessage(this, 1, 'Writing video ...');

% write to video
vwh = VideoWriter([filePath, '_movie.avi']);
set(vwh, 'FrameRate', frameRate);
open(vwh);
for iFrame = 1 : nFrames;
    writeVideo(vwh, allFrames(:, :, iFrame));
end;
close(vwh);

ANShowHideMessage(this, 1, 'Writing video done');

end
