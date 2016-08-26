function [powVect, phaseVect, freqVect, complexVect, hashStruct] = OCIA_analysis_widefield_getPowerAndPhase(this, iFile)
% OCIA_analysis_widefield_getPowerAndPhase - [no description]
%
%       [powVect, phaseVect, freqVect, complexVect, hashStruct] = OCIA_analysis_widefield_getPowerAndPhase(this, iFile)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% default output
[powVect, phaseVect, freqVect, complexVect, hashStruct] = deal([]);

% abort if no bins
nBins = this.an.wf.nBins;
nTotBins = prod(nBins);
if isempty(nBins) || any(nBins == 0); return; end;

%% get the data
if ~isempty(this.an.wf.ROIMasks);
    nTotBins = size(this.an.wf.ROIMasks, 3);
    addParamsStruct = struct('ROIMasks', this.an.wf.ROIMasks);

else
    addParamsStruct = [];
    
end;

% get the data in memory
hashStruct = OCIA_analysis_widefield_getHashStruct(this, iFile, 'WFPowerAndPhase', 'stim|(base|evoked)Frames|power|phase', ...
    addParamsStruct);
cachedData = ANGetCachedData(this, 'wf', hashStruct);

% if the data is not in cache yet, generate it
if isempty(cachedData);

    % get pixel time course
    pixelTimeCourse = OCIA_analysis_widefield_getPixTimeCourse(this, iFile);
    if isempty(pixelTimeCourse); return; end;
    
    ANShowHideMessage(this, 1, 'Calculating FFTs ...');
    t0 = tic;

    % get analysable frequencies
    frameRate = hashStruct.frameRate;
    nFrames = size(pixelTimeCourse, 2);
    validFreqIndexes = 1 : floor(nFrames / 2);
    freqVect = (frameRate / 2) * linspace(0, 1, numel(validFreqIndexes));

    % extract the pixel time course for each bin
    powVect = nan(nTotBins, numel(validFreqIndexes));
    phaseVect = nan(nTotBins, numel(validFreqIndexes));
    complexVect = nan(nTotBins, numel(validFreqIndexes));
    parfor iBin = 1 : nTotBins;
        % get pixel time course trace
        trace = pixelTimeCourse(iBin, :);
        % do FFT
        FFTVectAll = fft(trace, nFrames) / nFrames;
        % exclude first point because it's messed up
        FFTVectAll(1) = 0;
        % get only the values for the valid frequencies
        FFTVectValid = FFTVectAll(validFreqIndexes);
        % calculate power and phase
        powVect(iBin, :) = abs(FFTVectValid) .^ 2;
        phaseVect(iBin, :) = angle(FFTVectValid);  
        complexVect(iBin, :) = FFTVectValid;  
        
    end;
    
    ANShowHideMessage(this, 1, sprintf('Calculating FFTs done (%.2f sec).', toc(t0)));
    
    % store the variables in the cached structure
    cachedData = struct('powVect', powVect, 'phaseVect', phaseVect, 'freqVect', freqVect, ...
        'complexVect', complexVect, 'dataType', 'WFPowerAndPhase', 'params', hashStruct);
    % store the data in memory
    ANStoreCachedData(this, 'wf', hashStruct, cachedData);
    
% if data was directly in memory, fetch it
else
    
    % fetch the data
    ANShowHideMessage(this, 1, 'Loading data from cache ...');
    powVect = cachedData.powVect;
    phaseVect = cachedData.phaseVect;
    freqVect = cachedData.freqVect;
    complexVect = cachedData.complexVect;

end;

end
