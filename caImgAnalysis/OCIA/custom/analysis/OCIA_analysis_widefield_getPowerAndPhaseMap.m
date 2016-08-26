function [powerMap, phaseMap, pitchLims, recordDur, complexMap, hashStruct] = OCIA_analysis_widefield_getPowerAndPhaseMap(this, iFile)
% OCIA_analysis_widefield_getPowerAndPhaseMap - [no description]
%
%       [powerMap, phaseMap, pitchLims, recordDur, complexMap, hashStruct] = OCIA_analysis_widefield_getPowerAndPhaseMap(this, iFile)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% default output
[powerMap, phaseMap, pitchLims, recordDur, complexMap, hashStruct] = deal([]);

% get number of bins
nBins = this.an.wf.nBins;
if isempty(nBins) || any(nBins == 0); return; end;

%% get the data
% get information from selected file
[~, ~, ~, ~, framesDim, ~, ~, pitchLims, recordDur] = OCIA_analysis_widefield_getFileInfo(this, iFile, true);
% limit frame range
frameRange = this.an.wf.frameRange;
if frameRange(2) == -1; frameRange(2) = Inf; end;
frameRangeStart = max(1, frameRange(1));
frameRangeEnd = min(framesDim(3), frameRange(2));
framesDim(3) = frameRangeEnd - frameRangeStart + 1;
% get stimulation infos
stimFreq = this.an.wf.stimFreq;
stimFreqInterval = this.an.wf.stimFreqInterval;
% get the data in memory
hashStruct = OCIA_analysis_widefield_getHashStruct(this, iFile, 'WFPowerAndPhaseMaps', '(base|evoked)Frames|power|phase');
cachedData = ANGetCachedData(this, 'wf', hashStruct);

% if the data is not in cache yet, generate it
if isempty(cachedData);

    % use cropped dimensions if any
    nFrames = framesDim(3);
    W = iff(isempty(this.an.wf.cropRect), framesDim(2), this.an.wf.cropRect, [], 3);
    H = iff(isempty(this.an.wf.cropRect), framesDim(1), this.an.wf.cropRect, [], 4);
    
    % cehck if the data is in memory
    hashStructPowPha = OCIA_analysis_widefield_getHashStruct(this, iFile, 'WFPowerAndPhase', ...
        'stim|(base|evoked)Frames|power|phase');
    cachedData = ANGetCachedData(this, 'wf', hashStructPowPha);
    
    % use pixel by pixel mode if number of frames is too large for memory
    if isempty(cachedData) && H * W * nFrames >= this.an.wf.sizeLimitForPixByPixMode;
        ANShowHideMessage(this, 1, 'Switching to pixel-by-pixel mode to calculate maps ...');
        [powerMap, phaseMap, ~, complexMap, hashStruct] = OCIA_analysis_widefield_getPowerAndPhaseMap_pixByPixMode(this, iFile);
        return;
    end;
    
    % get power and phase vectors for all frequencies
    [~, ~, freqVect, complexVect] = OCIA_analysis_widefield_getPowerAndPhase(this, iFile);
    if isempty(freqVect); return; end;
    
    ANShowHideMessage(this, 1, 'Calculating maps ...');
    t0 = tic;

    %% create maps
    % get relevant stimulus frequency indexes
    [~, stimFreqIndexLeft] = min(abs(freqVect - stimFreq + stimFreqInterval));
    [~, stimFreqIndexRight] = min(abs(freqVect - stimFreq - stimFreqInterval));
    % extract complex field at those indexes
    complexMap = nanmean(complexVect(:, stimFreqIndexLeft : stimFreqIndexRight), 2);
    % reshape in form of a map
    complexMap = reshape(complexMap, fliplr(nBins));
    % create power and phase map
    for iChunk = 1 : size(complexMap, 3);
        complexMapLocal = complexMap(:, :, iChunk);
        phaseMapLocal = nan(size(complexMapLocal));
        powerMapLocal = nan(size(complexMapLocal));
        parfor iBin = 1 : numel(complexMapLocal);
            phaseMapLocal(iBin) = angle(complexMapLocal(iBin));
            powerMapLocal(iBin) = abs(complexMapLocal(iBin)) .^ 2;
        end;
        phaseMap(:, :, iChunk) = reshape(phaseMapLocal, nBins);
        powerMap(:, :, iChunk) = reshape(powerMapLocal, nBins);
    end;
    
    % rotate maps if needed
    if this.an.wf.imRotationAngle;
        powerMap = imrotate(powerMap, this.an.wf.imRotationAngle, 'bilinear', 'crop');
        phaseMap = imrotate(phaseMap, this.an.wf.imRotationAngle, 'bilinear', 'crop');
        complexMap = imrotate(complexMap, this.an.wf.imRotationAngle, 'bilinear', 'crop');
    end;
    
    ANShowHideMessage(this, 1, sprintf('Calculating maps done (%.2f sec).', toc(t0)));
    
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
