function [trialsPSFramesMap, tPS, stimIDs, hashStruct] = OCIA_analysis_widefield_getTrialsFromLabview(this, iDWRow)
% OCIA_analysis_widefield_getTrialsFromLabview - [no description]
%
%       [trialsPSFramesMap, tPS, stimIDs, hashStruct] = OCIA_analysis_widefield_getTrialsFromLabview(this, iDWRow)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the data in memory
hashStruct = OCIA_analysis_widefield_getHashStruct(this, iDWRow, 'WFMappingTrials', '_none_');
cachedData = ANGetCachedData(this, 'wf', hashStruct);

% if the data is not in cache yet, generate it
if isempty(cachedData);
    
    stimIDs = {};
    
    DWLoadRow(this, iDWRow, 'partial');
    trialData = getData(this, iDWRow, 'wfTrIm', 'data');
    if isempty(trialData);
        trialData = getData(this, iDWRow, 'wfTrAvg', 'data');
        stimIDs = { sprintf('%s %s', get(this, iDWRow, 'runNum'), ...
            regexprep(get(this, iDWRow, 'dim'), '\d+x\d+x\d+ ', '')) };
    end;
    
    [pixY, pixX, nFrames] = size(trialData);
    trialsPSFramesMap = nan(pixY, pixX, 1, 1, nFrames);
    trialsPSFramesMap(:, :, 1, 1, :) = 100 * (permute(trialData, [2, 1, 3]) - 1);
    
    this.an.wf.nBins = [pixY, pixX];
    
    %% HARCODED STUFF
    if isempty(stimIDs); stimIDs = { 'none' }; end;
    frameRate = 20;
    tPS = (1 : size(trialsPSFramesMap, 5)) / frameRate;
        
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
