function [fig, plotHandles] = plotROICaTracesWithEvent(iRun, saveName, caTraces, events, stim, ROIs, ...
    frameRate, bpfilter, eventDetectMethod, doPlotEvents)

% created by B. Laurenczy - 2013

dbgLevel = 0;
% init the size of the data set
nROIs = size(caTraces, 1);
nFrames = size(caTraces, 2);
o('    #plotROICaTracesWithEvent: run %d "%s", %d ROI(s), %d frame(s) ...', ...
    iRun, saveName, nROIs, nFrames, 2, dbgLevel);

% init the title and the figure
titleStr = sprintf('%s Run %1.0f', saveName, iRun);
fig = figure('Name', titleStr, 'NumberTitle', 'off');
% init the time scale
time = (1 : nFrames) / frameRate;
% extract the stimuli times
stimTimes = time(stim > 0);
% extract the stimulus 'IDs' by converting the stim index into a string (the index of the stimuli)
stimIDIndexes = stim(stim > 0);
stimIDs = cell(1, numel(stimIDIndexes));
for n = 1 : numel(stimIDIndexes);
    stimIDs{n} = num2str(stimIDIndexes(n));
end

o('    #plo..Event: run %d, variables initialized.', iRun, 2, dbgLevel);
% init variables for plotting
ROIIDs = cell(nROIs, 1); % IDs (names) of the cells to be displayed near the trace
% meanYpos = nan(nROIs, 1);
currOffSet = 0; % offset between each ROI
normCaTraces = zeros(size(caTraces));
normFiltCaTraces = zeros(size(caTraces));
% go through each ROI to extract the ROI's ID and to normalize the data
iROI = 1;
for iROILoop = 1 : nROIs;
    ROICaTrace = caTraces(iROILoop, :);
    % if the ROI trace is not empty/null
    if nansum(ROICaTrace);
        % normalize by removing the minimum value and add the maximum so far
        commonOffset = - nanmin(ROICaTrace) + currOffSet;
        normCaTraces(iROI, :) = ROICaTrace + commonOffset;
        if ~isempty(bpfilter);
            normFiltCaTraces(iROI, :) = mpi_BandPassFilterTimeSeries(ROICaTrace, 1 / frameRate, ...
                bpfilter.low, bpfilter.high) + commonOffset;
        else
            normFiltCaTraces(iROI, :) = normCaTraces(iROI, :);
        end;
        
        if iROI > nROIs;
            ROIIDs{iROI} = 'NPil';
        else
            ROIIDs{iROI} = ROIs{iROILoop, 1};
        end;
        currOffSet = nanmax(normCaTraces(iROI, :));
        iROI = iROI + 1;
    else
        nROIs = nROIs - 1;
        normCaTraces(iROI, :) = [];
        ROIIDs(iROI) = [];
        o('      #plot..races: run %d, ROI %d is null (no value above 0).', iRun, iROILoop, 0, dbgLevel);
    end;
end;
o('    #plo..Event: run %d, caTraces normalized.', iRun, 2, dbgLevel);

% adjust the axes of the calcium traces
traceAxe = gca;
yLimits = [0 currOffSet];
xLimits = [min(time) 1.1 * max(time)];
set(traceAxe, 'ylim', yLimits, 'xlim', xLimits);
xlabel('Time [s]');
% create and adjust the axes of the labels (ROI labels and stim)
% ylabel(sprintf('%% %s', upper(roiStats.statsType)));
ylabel(sprintf('%% %s', 'dFF'));
labelAxe = axes('Position', get(gca, 'Position'), 'YAxisLocation', 'right', 'XAxisLocation', 'top');
set(labelAxe, 'ylim', yLimits, 'YTick', mean(normCaTraces, 2), 'YTickLabel', ROIIDs);
set(labelAxe, 'XTick', stimTimes, 'XTickLabel', stimIDs);
% set(traceAxe, 'ylim', yLimits, 'xlim', xLimits);
title(titleStr, 'Interpreter', 'none');
hold all;
o('    #plo..Event: run %d, axes initialized.', iRun, 2, dbgLevel);

% colors for the simuli
stimColors = jet(numel(unique(stimIDIndexes)));
% plot the stimuli in the appropriate colors
for n = 1 : numel(stim);
    if stim(n);
        plot([time(n) time(n)], yLimits, 'LineStyle', '--', 'Color', stimColors(stim(n), :));
    end;
end
o('    #plo..Event: run %d, stims plotted.', iRun, 2, dbgLevel);

% plotting loop
o('    #plo..Event: run %d, plotting calcium traces ...', iRun, 3, dbgLevel);
% colors for the ROIs
ROIColors = lines(nROIs);
plotHandles = zeros(nROIs, 1); % for legend handling
currOffSet = 0;
for iROI = 1 : nROIs;
    ROICaTrace = normFiltCaTraces(iROI, :);
    o('      #plo..Event: run %d - ROI %d, plotting calcium trace ...', iRun, iROI, 4, dbgLevel);
    % plot the 'raw' calcium trace
    plotHandles(iROI) = plot(time, normCaTraces(iROI, :), 'LineWidth', 1, 'Color', [.8 .8 .8]);
    plotHandles(iROI) = plot(time, ROICaTrace, 'LineWidth', 1.5, 'Color', ROIColors(iROI, :));
    % stop for some reason before displaying the last ROI (the neuropil?)
    if iROI == nROIs; break; end;
    % stop for some reason before displaying the last ROI (the neuropil?)
    if ~isempty(events) && doPlotEvents && size(events, 1) >= iROI;
        ROIEvent = events(iROI, :);
        o('      #plo..Event: run %d - ROI %d, plotting %d event(s) ("%s") ...', ...
            iRun, iROI, sum(ROIEvent), eventDetectMethod, 5, dbgLevel);
        if strcmpi(eventDetectMethod, 'peeling');
            for iTime = 1 : length(ROIEvent);
%                 if ROIEvent(iTime);
                for iEvent = 1 : ROIEvent(iTime);
%                     h_err = errorbar(time(iTime), min(ROICaTrace), 0, 3, 'Color', 'black');
%                     h_err = errorbar(time(iTime), min(ROICaTrace), 0, 3, 'Color', ROIColors(iROI, :));
%                     h_err = errorbar(time(iTime), ROICaTrace(time(iTime) * frameRate) + 0.5 .* std(ROICaTrace), ...
%                         0, 3, 'Color', ROIColors(iROI, :));
%                      scatter(time(iTime), ROICaTrace(time(iTime) * frameRate) + ...
%                         0.5 .* std(ROICaTrace), ROIEvent(iTime) * 10, 'bx');
%                     scatter(time(iTime), ROICaTrace(time(iTime) * frameRate) + ...
%                         (0.5 + iEvent * 0.1) .* std(ROICaTrace), 'bx');
%                     scatter(time(iTime), ROICaTrace(time(iTime) * frameRate) + ...
%                         (0.5 + iEvent * 0.1) .* std(ROICaTrace), 30, ROIColors(iROI, :), 'x');
                    scatter(time(iTime), ROICaTrace(time(iTime) * frameRate) + ...
                        (0.5 + iEvent * 0.1) .* std(ROICaTrace), 30, 'bx', 'LineWidth', 2);
%                     removeErrorBarEnds(h_err);
%                     set(h_err, 'LineWidth', 2);
                end;
            end;
        elseif strcmpi(eventDetectMethod, 'fast_oopsi');
            if nansum(ROIEvent);
                ROIEvent = ROIEvent .* 10;
                ROIEvent(~ROIEvent) = NaN;
                ROIEvent = ROIEvent + currOffSet;
                currOffSet = max(ROIEvent);
                plot(time, ROIEvent, 'LineWidth', 1.5, 'Color', [0.5 0.5 0.5]);
            end;
        end;
        o('      #plo..Event: run %d - ROI %d, plotting %d event(s) ("%s") done.', ...
            iRun, iROI, sum(ROIEvent), eventDetectMethod, 4, dbgLevel);
    end;
    o('      #plo..Event: run %d - ROI %d, plotting calcium trace done.', iRun, iROI, 3, dbgLevel);
end;
o('    #plo..Event: run %d, plotting calcium traces done.', iRun, 2, dbgLevel);

linkaxes([labelAxe, traceAxe], 'xy');
o('    #plo..Event: run %d, axes linked.', iRun, 2, dbgLevel);

o('    #plo..Event: run %d "%s", %d ROI(s), %d frame(s) done.', ...
    iRun, saveName, nROIs, nFrames, 1, dbgLevel);
hold off;

end