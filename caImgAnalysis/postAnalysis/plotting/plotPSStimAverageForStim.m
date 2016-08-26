function figHand = plotPSStimAverageForStim(PSROIStats, PSTime, avgMode, IDs, saveName)


% init the size of the data set
nROIs = size(PSROIStats.mean.all, 2); % exclude the neuropil
nStims = size(PSROIStats.mean.all, 3);
nFrames = size(PSROIStats.mean.all, 1);

if strcmp(avgMode, 'ROI');
    avgDim = 2;
    avgSize = nStims;
    titlestr = 'Mean evoked response for each stimulus';
elseif strcmp(avgMode, 'stim');
    avgDim = 3;
    avgSize = nROIs;
    titlestr = 'Mean evoked response for each ROI';
end;

caTraces = PSROIStats.mean.all;
caTraces = PSROIStats.mean.all - repmat(min(caTraces), nFrames, 1);
caTraceErrors = PSROIStats.sem.all;

traceMeans = reshape(nanmean(caTraces, avgDim), nFrames, avgSize);
% meanTracesCorrected = meanTraces - repmat(mean(meanTraces(1 : nBaseFrames, :), 1), nFrames, 1);
traceMeans = traceMeans - repmat(min(traceMeans), nFrames, 1);

traceErrors = reshape(nanmean(caTraceErrors, avgDim), nFrames, avgSize);

xShift = 0.005;
PSTimeStims = repmat(PSTime', 1, avgSize);
PSTimeStims = PSTimeStims + repmat(xShift * (1 : avgSize), nFrames, 1) - xShift; % small shift for each trace

% create the figure
figHand = figure('Name', saveName, 'NumberTitle', 'off');

% plot the mean traces
% plotHandles = plot(PSTimeStims, meanTraces);
plotHands = errorbar(PSTimeStims, traceMeans, traceErrors);
hold on;

% if numel(plotLimits) == 2;
%     ylim(plotLimits);
% end;

% color each trace by a specific color
colors = jet(numel(plotHands));
for iHand = 1 : numel(plotHands);
    set(plotHands(iHand), 'Color', colors(numel(plotHands) - iHand + 1, :));
    removeErrorBarEnds(plotHands(iHand));
end;

% meanOfAllTraces = nanmean(traceMeans, 2);
% % meanOfAllTracesCorrected = meanOfAllTraces - mean(mean(meanTraces(1 : nBaseFrames, :), 2));
% plotHandles(iHand + 1) = plot(PSTime, meanOfAllTraces, 'Color', 'black', 'LineWidth', 3); %#ok<*NASGU>
% hold off;

% set(figHand, 'UserData', plotHandles);

% add the legends
legend(IDs, 'Location', 'EastOutside');

% % get the 'best' stimuli
% stimMeans = mean(meanTracesCorrected(nBaseFrames : end, :));
% bestStimsStr = sprintf('%s, ', IDs{stimMeans > mean(stimMeans) + std(stimMeans)});
% bestStimsStr = regexprep(bestStimsStr, ', $', '');

% axis labels and title
ylabel('dFF/dRR [%]');
xlabel('Time [s]');
% title(sprintf('Trace average for each stimulus. Best stims are : %s', bestStimsStr));
title(titlestr);

 makePrettyFigure(figHand);

end

