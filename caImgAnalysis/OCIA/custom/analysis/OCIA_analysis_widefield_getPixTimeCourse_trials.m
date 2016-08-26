function [pixelTimeCourseTrials, t, attribs, hashStruct] = OCIA_analysis_widefield_getPixTimeCourse_trials(this, iRow)
% OCIA_analysis_widefield_getPixTimeCourse_trials - [no description]
%
%       [pixelTimeCourseTrials, t, attribs, hashStruct] = OCIA_analysis_widefield_getPixTimeCourse_trials(this, iRow)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% defines some parameters
nBins = this.an.wf.nBins;
baseFrames = this.an.wf.baseFrames;
evokedFrames = this.an.wf.evokedFrames;
stimFreq = this.an.wf.stimFreq;
% abort if no bins
if isempty(nBins) || nBins == 0; return; end;

%% get the data
% get information from selected file
[~, ~, ~, ~, datasetDim, frameRate, ~, ~, ~, attribs] = OCIA_analysis_widefield_getFileInfo(this, iRow, true);

% limit frame range
frameRange = this.an.wf.frameRange;
if frameRange(2) == -1; frameRange(2) = Inf; end;
frameRange = [max(1, frameRange(1)), min(datasetDim(3), frameRange(end))];
datasetDim(3) = diff(frameRange) + 1;

% get normal pixel time course
pixelTimeCourse = OCIA_analysis_widefield_getPixTimeCourse(this, iRow);
if isempty(pixelTimeCourse); pixelTimeCourseTrials = []; return; end;

% get the data in memory
hashStruct = OCIA_analysis_widefield_getHashStruct(this, iRow, 'WFPixelTimeCourseTrials', 'stimFreqInterval|phase|power');
cachedData = ANGetCachedData(this, 'wf', hashStruct);

% if the data is not in cache yet, generate it
if isempty(cachedData);
    
    ANShowHideMessage(this, 1, 'Extracting PS-frames ...');
    
    % calculate dimensions
    nFrames = datasetDim(3);
    nTrials = round(round(nFrames / frameRate) * stimFreq);
    nFramesTrial = round((1 / stimFreq) * frameRate);
        
    % create stim vector
    stimVect = zeros(1, nFrames);
    stimVect(1 : nFramesTrial : (nTrials * nFramesTrial - 1)) = 1;
    
    % get the PS time course
    pixelTimeCourseTrials = extractPSTrace(permute(pixelTimeCourse, [3, 1, 2]), stimVect, ...
        [baseFrames, evokedFrames], nTrials, true);
    pixelTimeCourseTrials = permute(pixelTimeCourseTrials, [3, 4, 2, 1]);
    nPSFrames = size(pixelTimeCourseTrials, 2);
    pixelTimeCourseTrials = reshape(pixelTimeCourseTrials, nBins * nBins, nPSFrames, nTrials);
    % exclude first trial
    pixelTimeCourseTrials(:, :, 1) = [];
    
    % create time vector
    t = (min([baseFrames, evokedFrames]) : max([baseFrames, evokedFrames])) / frameRate;
    
    % normalize with baseline
    baseline = nanmean(pixelTimeCourseTrials(:, t <= 0, :), 2);
    pixelTimeCourseTrials = pixelTimeCourseTrials - repmat(baseline, 1, nPSFrames, 1);
    
    % store the variables in the cached structure
    cachedData = struct('pixelTimeCourseTrials', pixelTimeCourseTrials, 't', t, ...
        'dataType', 'WFPixelTimeCourseTrials', 'params', hashStruct);
    % store the data in memory
    ANStoreCachedData(this, 'wf', hashStruct, cachedData);
    
% if data was directly in memory, fetch it
else
    
    % fetch the data
    ANShowHideMessage(this, 1, 'Loading data from cache ...');
    pixelTimeCourseTrials = cachedData.pixelTimeCourseTrials;
    t = cachedData.t;
    

end;

end
