function PSData = PsPlotAnalysisCellArray(ROIStatsData, stimCell, psFrames)
% dataCell      ... cell array with roi time-series (nROIs x nReps), each cell is a matrix of 1 x nFrames
% stimCell      ... cell array of stim vectors (1 x nReps), each cell is a matrix of 1 x nFrames
% config        ... peri-stimulus config structure with the number of base and evoked frames
% PSData        ... cell array of stim-locked ROI time-series (nROIs x nStims)

% this file written by Henry Luetcke (hluetck@gmail.com)
% modified by Balazs


% get all different stims "indexes"
stimTypes = unique(cell2mat(stimCell));
% remove the 0 which is the "no stim" index
stimTypes(stimTypes == 0) = [];

nROIs = size(ROIStatsData, 1);
nReps = size(ROIStatsData, 2);
nStims = numel(stimTypes);
% nFrames = size(ROIStatsData{1, 1}, 2);

% create a cell array (nROIs x nStims), each cell is a matrix of nReps x nPeriStimFrames
PSData = cell(nROIs, nStims);
% go through each ROI and concatenate all repetitions
for iROI = 1 : nROIs;
    % collect relevant data, ignoring empty runs
    allTraces = []; allStims = [];
    % go trough each repetition
    for iRep = 1 : nReps;
        if ~isempty(ROIStatsData{iROI, iRep}); % ignore empty runs
            allTraces = [allTraces, ROIStatsData{iROI, iRep}]; %#ok<AGROW>
            allStims = [allStims, stimCell{iRep}]; %#ok<AGROW>
        end;
    end;
    % extract the peri-stimulus averages
    PSData(iROI, :) = doPsPlot(allTraces, allStims, stimTypes, psFrames.base, psFrames.evoked);
end

end

function psData = doPsPlot(data, stimVector, stimTypes, baseFrames, evokedFrames)
psData = cell(1,length(stimTypes));
for n = 1:numel(stimTypes)
    currentStim = stimTypes(n);
    currentStimNo = numel(find(stimVector==currentStim));
    if isempty(currentStimNo)
       psData{roi,n} = [];
       continue
    end
    for roi = 1:size(data,1)
        psData{roi,n} = zeros(currentStimNo,...
            baseFrames+evokedFrames);
    end
    currentStimNo = 0;
    for t = 1:numel(stimVector)
        if stimVector(t) == currentStim
            currentStimNo = currentStimNo + 1;
            nanPad = 0;
            startFrame = t - baseFrames;
            if startFrame < 1
                nanPad = startFrame-1;
                startFrame = 1;
            end
            stopFrame = t + evokedFrames-1;
            if stopFrame > numel(stimVector)
                nanPad = stopFrame - numel(stimVector);
                stopFrame = numel(stimVector);
            end
            for roi = 1:size(data,1)
                currentRoiTrace = data(roi,startFrame:stopFrame);
                if nanPad < 0
                    currentRoiTrace = [nan(1,abs(nanPad)) currentRoiTrace];
                elseif nanPad > 0
                    currentRoiTrace = [currentRoiTrace nan(1,nanPad)];
                end
                psData{roi,n}(currentStimNo,:) = currentRoiTrace;
            end
        end
    end
end
end

% stimTypes = unique(stimVector);  % all non-zero elements
% stimTypes(stimTypes==0) = [];
% PsPlotData = cell(size(data,1),length(stimTypes));
% for n = 1:numel(stimTypes)
%     currentStim = stimTypes(n);
%     currentStimNo = numel(find(stimVector==currentStim));
%     for roi = 1:size(data,1)
%         PsPlotData{roi,n} = zeros(currentStimNo,...
%             baseFrames+evokedFrames);
%     end
%     currentStimNo = 0;
%     for t = 1:numel(stimVector)
%         if stimVector(t) == currentStim
%             currentStimNo = currentStimNo + 1;
%             nanPad = 0;
%             startFrame = t - baseFrames;
%             if startFrame < 1
%                 nanPad = startFrame-1;
%                 startFrame = 1;
%             end
%             stopFrame = t + evokedFrames-1;
%             if stopFrame > numel(stimVector)
%                 nanPad = stopFrame - numel(stimVector);
%                 stopFrame = numel(stimVector);
%             end
%             for roi = 1:size(data,1)
%                 currentRoiTrace = data(roi,startFrame:stopFrame);
%                 if nanPad < 0
%                     currentRoiTrace = [nan(1,abs(nanPad)) currentRoiTrace];
%                 elseif nanPad > 0
%                     currentRoiTrace = [currentRoiTrace nan(1,nanPad)];
%                 end
%                 PsPlotData{roi,n}(currentStimNo,:) = currentRoiTrace;
%             end
%         end
%     end
% end