function PsPlotData = PsPlotAnalysis(data,stimVector,config)

% this file written by Henry Luetcke (hluetck@gmail.com)

% o('/!\\ WARNING - overriding of config.base and config.evoked.', 0, 0);
% config.base = 5;
% config.evoked = 10;

stimTypes = unique(stimVector);  % all non-zero elements
stimTypes(stimTypes==0) = [];
PsPlotData = cell(size(data,1),length(stimTypes));
for n = 1:numel(stimTypes)
    currentStim = stimTypes(n);
    currentStimNo = numel(find(stimVector==currentStim));
    for roi = 1:size(data,1)
        PsPlotData{roi,n} = zeros(currentStimNo,...
            config.base+config.evoked);
    end
    currentStimNo = 0;
    for t = 1:numel(stimVector)
        if stimVector(t) == currentStim
            currentStimNo = currentStimNo + 1;
            nanPad = 0;
            startFrame = t - config.base;
            if startFrame < 1
                nanPad = startFrame-1;
                startFrame = 1;
            end
            stopFrame = t + config.evoked-1;
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
                PsPlotData{roi,n}(currentStimNo,:) = currentRoiTrace;
            end
        end
    end
end