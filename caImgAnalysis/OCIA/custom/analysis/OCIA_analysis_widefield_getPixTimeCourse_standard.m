function [pixelTimeCourse, t, hashStruct] = OCIA_analysis_widefield_getPixTimeCourse_standard(this, iRow)
% OCIA_analysis_widefield_getPixTimeCourse - [no description]
%
%       [pixelTimeCourse, t, hashStruct] = OCIA_analysis_widefield_getPixTimeCourse(this, iRow)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% defines some parameters
nBins = this.an.wf.nBins;
baseFrames = this.an.wf.baseFrames;
cropRect = this.an.wf.cropRect;
% abort if no bins
if isempty(nBins) || nBins == 0; return; end;

%% get the data
% get information from selected file
[filePath, ~, dataDatasetPath, ~, datasetDim, frameRate, chunkSize, ~, iStim] ...
    = OCIA_analysis_widefield_getFileInfo_standard(this, iRow, true);

% limit frame range
frameRange = this.an.wf.frameRange;
if frameRange(2) == -1; frameRange(2) = Inf; end;
frameRange = [max(1, frameRange(1)), min(datasetDim(3), frameRange(end))];
datasetDim(3) = diff(frameRange) + 1;

% use cropped dimensions if any
H = datasetDim(1); W = datasetDim(2); nFrames = framesDim(3); nTrials = datasetDim(4);
X = iff(isempty(cropRect), 1, cropRect, [], 1);
Y = iff(isempty(cropRect), 1, cropRect, [], 2);
W = iff(isempty(cropRect), W, cropRect, [], 3);
H = iff(isempty(cropRect), H, cropRect, [], 4);

% create time vector
t = (1 : nFrames) / frameRate;

% get the data in memory
hashStruct = OCIA_analysis_widefield_getHashStruct(this, iRow, 'WFPixelTimeCourseStd', 'stim|evokedFrames|phase|power', ...
    struct('iStim', iStim));
cachedData = ANGetCachedData(this, 'wf', hashStruct);

% if the data is not in cache yet, generate it
if isempty(cachedData);
    
    t0 = tic;

    % check if binning factor is a divider of the image size (same pixel number in each bin)
    if mod(H, nBins) ~= 0 || mod(W, nBins) ~= 0;
        msg = sprintf('Number of bins is not a perfect divider for image size (nBins = %d, imgSize = [%d %d]).', nBins, W, H);
        showWarning(this, sprintf('OCIA:%s:BadBinning', mfilename()), msg);
        ANShowHideMessage(this, 1, msg);
        return;
    end;
    
    % get bin size
    binSizeW = W / nBins; binSizeH = H / nBins;

    % extract the pixel time course for each bin
    pixelTimeCourse = nan(nBins * nBins, nFrames, nTrials);
    
    % number of chunks to divide the raw data into, which is limited by memory but still speeds
    %   up the processing since it avoids multiple read access to data
    nMaxChunkW = W / chunkSize(1);
    nMaxChunkH = H / chunkSize(2);
    chunkSizeFactor = this.an.wf.chunkSizeFactor;
    nChunkW = min(max(ceil(nMaxChunkW / chunkSizeFactor(1)), 1), nBins);
    nChunkH = min(max(ceil(nMaxChunkH / chunkSizeFactor(2)), 1), nBins);
    chunkSizeW = W / nChunkW;
    chunkSizeH = H / nChunkH;
    
    % extract trial by trial
    for iTrial = 1 : nTrials;
        
        % extract chunk by chunk
        for iChunk = 1 : (nChunkW * nChunkH);

            ANShowHideMessage(this, 1, sprintf(['Calculating bins trial %02d/%02d (chunk %d/%d)... (%d bin(s), ', ...
                'bin size = [%d, %d], nChunks = [%d, %d], chunkSize = [%d, %d])'], iTrial, nTrials, iChunk, ...
                nChunkW * nChunkH, nBins * nBins, binSizeW, binSizeH, nChunkW, nChunkH, chunkSizeW, chunkSizeH));

            % get bin's X and Y range
            [iChunkY, iChunkX] = ind2sub([nChunkH, nChunkW], iChunk);
            % get the chunk's range
            xChunkStart = ((iChunkX - 1) * chunkSizeW + X);
            yChunkStart = ((iChunkY - 1) * chunkSizeH + Y);
            xChunkEnd = xChunkStart + chunkSizeW - 1;
            yChunkEnd = yChunkStart + chunkSizeH - 1;
            % load the pixels for the current chunk
            chunkFrames = h5read(filePath, dataDatasetPath, [yChunkStart, xChunkStart, frameRange(1), iTrial, iStim], ...
                [chunkSizeH, chunkSizeW, nFrames, 1, 1]);
        
            % rotate frames if needed
            if this.an.wf.imRotationAngle;
                chunkFrames = imrotate(chunkFrames, this.an.wf.imRotationAngle, 'bilinear', 'crop');
            end;

            parfor iBin = 1 : nBins * nBins;
                % get bin's X and Y range
                [iY, iX] = ind2sub([nBins, nBins], iBin);
                xStart = (iX - 1) * binSizeW + X;
                yStart = (iY - 1) * binSizeH + Y;
                xEnd = xStart + binSizeW - 1;
                yEnd = yStart + binSizeH - 1;
                % skip bin if not within range (not loaded in current chunk, will be added in the next chunk
                if xStart < xChunkStart || yStart < yChunkStart || xEnd > xChunkEnd || yEnd > yChunkEnd; continue; end;
                % load the pixels for the selected range
                xRange = (xStart : (xStart + binSizeW - 1)) - xChunkStart + 1;
                yRange = (yStart : (yStart + binSizeH - 1)) - yChunkStart + 1;
                frames = chunkFrames(yRange, xRange, :); %#ok<PFBNS>
                % get average of selected pixels
                trace = reshape(nanmean(nanmean(frames, 1), 2), 1, nFrames);
                % normalize with baseline
                F0 = nanmean(trace(baseFrames));
                trace = 100 * (trace - F0) / F0;
                % store
                pixelTimeCourse(iBin, :, iTrial) = trace;

            end; % bin loop end
        end; % chunk loop end
    end; % trial loop end
    
    ANShowHideMessage(this, 1, sprintf(['Calculating bins done (%.2f sec). (%d bin(s), bin size = [%d, %d], ', ...
        'nChunks = [%d, %d], chunkSize = [%d, %d])'], toc(t0), nBins, binSizeW, binSizeH, ...
        nChunkW, nChunkH, chunkSizeW, chunkSizeH));
        
    % store the variables in the cached structure
    cachedData = struct('pixelTimeCourse', pixelTimeCourse, 'dataType', 'WFPixelTimeCourseStd', ...
        'params', hashStruct);
    % store the data in memory
    ANStoreCachedData(this, 'wf', hashStruct, cachedData);
    
% if data was directly in memory, fetch it
else
    
    % fetch the data
    ANShowHideMessage(this, 1, 'Loading data from cache ...');
    pixelTimeCourse = cachedData.pixelTimeCourse;
    

end;

end
