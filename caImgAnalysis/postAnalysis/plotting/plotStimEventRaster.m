function fig = plotStimEventRaster(titleStr, PSEventsPerROI, stim, ...
    nBaseFrame, nEvokedFrame, frameRate)

% create the figure
fig = figure('Name', titleStr, 'NumberTitle', 'off');

% average the events grouping them by stimuli (putting ROIs and runs together)
meanOfEventsPerStim = zeros(size(PSEventsPerROI{1, 1}, 2), size(PSEventsPerROI, 2));
for iStim = 1 : size(PSEventsPerROI, 2);
    for iROI = 1 : size(PSEventsPerROI, 1);
        for iRun = 1 : size(PSEventsPerROI{iROI, iStim}, 2);
            meanOfEventsPerStim(:, iStim) = meanOfEventsPerStim(:, iStim) + ...
                mean(PSEventsPerROI{iROI, iStim}, 1)';
        end;
    end;
end;

% create the time axis, first for a single stimuli ...
t = (- nBaseFrame + 1 : nEvokedFrame) / frameRate;
t = repmat(t', 1, size(PSEventsPerROI, 2)); % ... then enhance for N stimuli

% plot the mean traces
plotHandles = plot(t, meanOfEventsPerStim);

% color each trace by a specific color
colors = jet(numel(plotHandles));
for iHand = 1 : numel(plotHandles);
    set(plotHandles(iHand), 'Color', colors(numel(plotHandles) - iHand + 1, :));
end;

% extract the stimulus'IDs' by converting the stim index into a string (the index of the stimuli)
stimIDIndexes = unique(stim(stim > 0));
stimIDs = cell(1, numel(stimIDIndexes));
for n = 1 : numel(stimIDIndexes);
    stimIDs{n} = num2str(stimIDIndexes(n));
end
% add the legends
legend(stimIDs);

% get the 'best' stimuli
stimMeans = mean(meanOfEventsPerStim(nBaseFrame : end, :));
bestStims = find(stimMeans > mean(stimMeans) + std(stimMeans));

% axis labels and title
ylabel('Number of events');
xlabel('Time [s]');
title(sprintf('Mean number of events per trial for each stimulus. Best stims are : %s', ...
    num2str(bestStims)));

end

