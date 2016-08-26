function [averageMaps, stimIDs, tPS, subRange, hashStruct] = OCIA_analysis_widefield_getAverageMaps(this, iFile)
% OCIA_analysis_widefield_getAverageMaps - [no description]
%
%       [averageMaps, stimIDs, tPS, subRange, hashStruct] = OCIA_analysis_widefield_getAverageMaps(this, iFile)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% default output
[averageMaps, stimIDs, tPS, subRange, hashStruct] = deal([]);

% get number of bins
nBins = this.an.wf.nBins;
% abort if no bins
if isempty(nBins) || any(nBins == 0); return; end;

subRange = this.an.wf.subRange;
if ~isempty(subRange);
    if numel(subRange) == 1;
        subRange = [subRange, subRange];
    end;
end;

%% make average maps
% get the data in memory
hashStruct = OCIA_analysis_widefield_getHashStruct(this, iFile, 'WFMappingTrialsAverage', ...
    'powerMapThresh|phaseShift|BLCorr|stimFreqInterval', struct('subRange', subRange));
cachedData = ANGetCachedData(this, 'wf', hashStruct);

% if the data is not in cache yet, generate it
if isempty(cachedData);

    %% get the data
    [trialsPSFramesMap, tPS, stimIDs] = OCIA_analysis_widefield_getTrialsMappingMultiFreq(this, iFile);

    % abort if no bins
    nBins = this.an.wf.nBins;
    if isempty(nBins) || any(nBins == 0); return; end;
    % no plot if no data
    if isempty(trialsPSFramesMap); return; end;

    % only use evoked frames
    evokedMap = trialsPSFramesMap(:, :, :, :, tPS > 0);
    
    % restrain selection to evoked frames
    if ~isempty(subRange);
        evokedMap = evokedMap(:, :, :, :, subRange(1) : subRange(2));
    end;
    [~, ~, ~, nStims, nPSFrames] = size(evokedMap);
    
    averageMaps = nan([nBins, nStims, nPSFrames]);
    filtSet = this.an.wf.powerMapFilt;
    parfor iStim = 1 : nStims;

        % get average of all trials
        averageMap = reshape(nanmean(evokedMap(:, :, :, iStim, :), 3), [nBins, nPSFrames]); %#ok<*PFBNS>
        % if gaussian filtering is requested, apply it
        if all(filtSet(1 : 3)) > 0;
            averageMap = imfilter(averageMap, fspecial('gaussian', filtSet(1 : 2), filtSet(3)));
        end;
        % if median filtering is requested, apply it
        if all(filtSet(4 : 5)) > 0;
            for iFrame = 1 : nPSFrames;
                averageMap(:, :, iFrame) = medfilt2(averageMap(:, :, iFrame), filtSet(4 : 5));
            end;
        end;
        % store
        averageMaps(:, :, iStim, :) = averageMap;
    end;
    % store the variables in the cached structure
    cachedData = struct('averageMaps', averageMaps, 'stimIDs', { stimIDs }, ...
        'tPS', tPS, 'dataType', 'WFMappingTrialsAverage', 'params', hashStruct);
    % store the data in memory
    ANStoreCachedData(this, 'wf', hashStruct, cachedData);
    
% if data was directly in memory, fetch it
else
    
    % fetch the data
    ANShowHideMessage(this, 1, 'Loading data from cache ...');
    averageMaps = cachedData.averageMaps;
    stimIDs = cachedData.stimIDs;
    if ~isfield(cachedData, 'tPS');
        tPS = (1 : size(averageMaps, 4)) / 20 - 0.5;
    else
        tPS = cachedData.tPS;
    end;

end;

end
