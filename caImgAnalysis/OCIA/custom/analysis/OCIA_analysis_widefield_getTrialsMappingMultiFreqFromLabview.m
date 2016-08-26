function [trialsPSFramesMap, tPS, stimIDs, hashStruct] = OCIA_analysis_widefield_getTrialsMappingMultiFreqFromLabview(this, iFile)
% OCIA_analysis_widefield_getTrialsMappingMultiFreqFromLabview - [no description]
%
%       [trialsPSFramesMap, tPS, stimIDs, hashStruct] = OCIA_analysis_widefield_getTrialsMappingMultiFreqFromLabview(this, iFile)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the data in memory
hashStruct = OCIA_analysis_widefield_getHashStruct(this, iFile, 'WFMappingTrials', '_none_');
cachedData = ANGetCachedData(this, 'wf', hashStruct);

% if the data is not in cache yet, generate it
if isempty(cachedData);
    
    trialFiles = dir([hashStruct.fileID '/Matt_files/stim_trial*']);
    nTrials = numel(trialFiles);
    
    trialsPSFramesMap = nan(0, 0);
    
    % load all trials
    for iTrial = 1 : nTrials;
        trialData = load(sprintf('%s/Matt_files/stim_trial%d.mat', hashStruct.fileID, iTrial));
        if iTrial == 1;
            [pixY, pixX, nFrames] = size(trialData.tr);
            trialsPSFramesMap = nan(pixY, pixX, nTrials, 1, nFrames);
        end;
        trialsPSFramesMap(:, :, iTrial, 1, :) = 100 * (permute(trialData.tr, [2, 1, 3]) - 1);
        ANShowHideMessage(this, 1, sprintf('Loaded trial %d/%d from file ...', iTrial, nTrials));
    end;
    
    this.an.wf.nBins = [pixY, pixX];
    
    %% HARCODED STUFF
    frameRate = 20;
    tPS = (1 : size(trialsPSFramesMap, 5)) / frameRate - 0.5;
    stimIDs = { regexprep(hashStruct.fileID, '.+/exp\d+_(\w+)$', '$1') };
        
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
