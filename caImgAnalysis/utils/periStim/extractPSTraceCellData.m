function PSROIStats = extractPSTraceCellData(ROIStats, stimCell, psFrames)
% dataCell      ... cell array with roi time-series (nROIs x nReps), each cell is a matrix of 1 x nFrames
% stimCell      ... cell array of stim vectors (1 x nReps), each cell is a matrix of 1 x nFrames
% config        ... peri-stimulus config structure with the number of base and evoked frames
% PSData        ... cell array of stim-locked ROI time-series (nROIs x nStims)

% this file written by Henry Luetcke (hluetck@gmail.com)
% modified by Balazs Laurenczy


% get all different stims "indexes"
stimTypes = unique(cell2mat(stimCell));
% remove the 0 which is the "no stim" index
stimTypes(stimTypes == 0) = [];

nROIs = size(ROIStats, 1);
nReps = size(ROIStats, 2);
nStims = numel(stimTypes);
% nFrames = size(ROIStats{1, 1}, 2);

% create a cell array (nROIs x nStims), each cell is a matrix of nReps x nPeriStimFrames
PSROIStats = cell(nROIs, nStims);
% go through each ROI and concatenate all repetitions
parfor iROI = 1 : nROIs;
    % collect relevant data, ignoring empty runs
    allTraces = []; allStims = [];
    % go trough each repetition
    for iRep = 1 : nReps;
        if ~isempty(ROIStats{iROI, iRep}); % ignore empty runs
            allTraces = [allTraces, ROIStats{iROI, iRep}]; %#ok<AGROW>
            allStims = [allStims, stimCell{iRep}]; %#ok<AGROW>
        end;
    end;
    % extract the peri-stimulus averages
    PSROIStats(iROI, :) = extractPSTraceSingleTrace(allTraces, allStims, stimTypes, psFrames.base, psFrames.evoked);
end

end