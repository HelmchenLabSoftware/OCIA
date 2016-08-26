function [trialMaps, hashStruct] = OCIA_analysis_widefield_getEvokedMapsTrials_standard(this, iRow)
% OCIA_analysis_widefield_getEvokedMapsTrials_standard - [no description]
%
%       [trialMaps, hashStruct] = OCIA_analysis_widefield_getEvokedMapsTrials_standard(this, iRow)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% defines some parameters
nBins = this.an.wf.nBins;
baseFrames = this.an.wf.baseFrames;
evokedFrames = this.an.wf.evokedFrames;

% abort if no bins
if isempty(nBins) || nBins == 0; return; end;

%% get the data
% get information from selected file
try
    [~, ~, ~, ~, ~, ~, ~, ~, iStim] = OCIA_analysis_widefield_getFileInfo_standard(this, iRow, true);
catch
    iStim = 1;
end;

% get the data in memory
hashStruct = OCIA_analysis_widefield_getHashStruct(this, iRow, 'WFEvokedMapsTrialsStd', [], ...
    struct('path', this.path.intrSave, 'iDWRows', iDWRows, 'iStim', iStim));
cachedData = ANGetCachedData(this, 'wf', hashStruct);

% if the data is not in cache yet, generate it
if isempty(cachedData);
    
    % get the time courses
    try
        [pixelTimeCourse, t] = OCIA_analysis_widefield_getPixTimeCourse_standard(this, iRow);
    catch
        [pixelTimeCourse, t] = OCIA_analysis_widefield_getPixTimeCourse_trials(this, iRow);
    end;
    nTrials = size(pixelTimeCourse, 3);
    if isempty(pixelTimeCourse); return; end;
    
    % get the evoked maps
    if all(baseFrames > 0);
        trialMaps = reshape(nanmean(pixelTimeCourse(:, evokedFrames, :), 2), [nBins, nBins, nTrials]);
    else
        trialMaps = reshape(nanmean(pixelTimeCourse(:, t > 0, :), 2), [nBins, nBins, nTrials]);
    end;
        
    % store the variables in the cached structure
    cachedData = struct('trialMaps', trialMaps, 'dataType', 'WFEvokedMapsTrialsStd', 'params', hashStruct);
    % store the data in memory
    ANStoreCachedData(this, 'wf', hashStruct, cachedData);
    
% if data was directly in memory, fetch it
else
    
    % fetch the data
    ANShowHideMessage(this, 1, 'Loading data from cache ...');
    trialMaps = cachedData.trialMaps;
    

end;

end
