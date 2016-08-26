function [trialsMaps, stimIDs, tPS, hashStruct] = OCIA_analysis_widefield_getTrialMaps(this, iFile)
% OCIA_analysis_widefield_getTrialMaps - [no description]
%
%       [trialMaps, stimIDs, tPS, hashStruct] = OCIA_analysis_widefield_getTrialMaps(this, iFile)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% default output
[trialsMaps, stimIDs, tPS, hashStruct] = deal([]);

% get number of bins
nBins = this.an.wf.nBins;
% abort if no bins
if isempty(nBins) || any(nBins == 0); return; end;

%% get the data
[trialsPSFramesMap, tPS, stimIDs] = OCIA_analysis_widefield_getTrialsMappingMultiFreq(this, iFile);

% abort if no bins
nBins = this.an.wf.nBins;
if isempty(nBins) || any(nBins == 0); return; end;
% no plot if no data
if isempty(trialsPSFramesMap); return; end;

[~, ~, nTrials, nStims, nPSFrames] = size(trialsPSFramesMap);

%% make trial maps
% get the data in memory
hashStruct = OCIA_analysis_widefield_getHashStruct(this, iFile, 'WFMappingTrialsMapsFilt', ...
    'powerMapThresh|phaseShift|BLCorr|stimFreqInterval');
cachedData = ANGetCachedData(this, 'wf', hashStruct);

% if the data is not in cache yet, generate it
if isempty(cachedData);
    
    trialsMaps = nan([nBins, nTrials, nStims, nPSFrames]);
    filtSet = this.an.wf.powerMapFilt;
    parfor iStim = 1 : nStims;

        trialMap = reshape(trialsPSFramesMap(:, :, :, iStim, :), [nBins, nTrials, nPSFrames]);
        % get average of all trials
        for iTrial = 1 : nTrials;
            for iFrame = 1 : nPSFrames;
                frame = trialMap(:, :, iTrial, iFrame);
                % if gaussian filtering is requested, apply it
                if all(filtSet(1 : 3)) > 0; %#ok<PFBNS>
                     frame = imfilter(frame, fspecial('gaussian', filtSet(1 : 2), filtSet(3)));
                end;
                % if median filtering is requested, apply it
                if all(filtSet(4 : 5)) > 0;
                    frame = medfilt2(frame, filtSet(4 : 5));
                end;
                trialMap(:, :, iTrial, iFrame) = frame;
            end;
        end;
        % store
        trialsMaps(:, :, :, iStim, :) = trialMap;
    end;
    % store the variables in the cached structure
    cachedData = struct('trialMaps', trialsMaps, 'dataType', 'WFMappingTrialsMapsFilt', 'params', hashStruct);
    % store the data in memory
    ANStoreCachedData(this, 'wf', hashStruct, cachedData);
    
% if data was directly in memory, fetch it
else
    
    % fetch the data
    ANShowHideMessage(this, 1, 'Loading data from cache ...');
    trialsMaps = cachedData.trialMaps;

end;

end
