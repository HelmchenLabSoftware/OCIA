function [stimVect, minPeakHeight] = getStimVectFromTrace(trace, peakSTDThresh, minPeakHeight, ...
    interPeakDistThresh, minStartTime, peakStartThreshold, frameRate, doDbgPlot, dbgPlotTitle, traceName)

stimVect = zeros(size(trace));

% calculate threshold and find peaks
if isempty(minPeakHeight);
    minPeakHeight = nanmean(trace) + peakSTDThresh * nanstd(trace);
end;
minPeakDist = round(interPeakDistThresh * frameRate);
[peakValues, peakPositions] = findpeaks(trace, 'MinPeakHeight', minPeakHeight, 'MinPeakDistance', minPeakDist);

% exclude early peaks
minStartFrame = round(minStartTime * frameRate);
peakValues(peakPositions < minStartFrame) = [];
peakPositions(peakPositions < minStartFrame) = [];
peakOnsetThresholds = peakValues * peakStartThreshold;
peakOnsetFrames = zeros(1, numel(peakPositions)) - 1;

% find peak onset
for iPeak = 1 : numel(peakPositions);
    offset = 0;
    valueAtCurrPos = Inf;
    lastVal = valueAtCurrPos;
    while valueAtCurrPos > peakOnsetThresholds(iPeak) && peakPositions(iPeak) - offset > 0;
        valueAtCurrPos = trace(peakPositions(iPeak) - offset);
        if lastVal < valueAtCurrPos && valueAtCurrPos < nanmean(trace);
            break;
        end;
        lastVal = valueAtCurrPos;
        offset = offset + 1;
    end;
    if peakPositions(iPeak) - offset <= 0;
        continue;
    end;
    if iPeak <= 1 || ((peakPositions(iPeak) - offset) - peakOnsetFrames(iPeak - 1)) >= minPeakDist;
        stimVect(peakPositions(iPeak) - offset + 1) = 1;
        peakOnsetFrames(iPeak) = peakPositions(iPeak) - offset + 1;
    end;
end;

% plotting
if doDbgPlot && numel(peakPositions) > 0;
    figure('Position', [340 400 1280 670], 'NumberTitle', 'off', 'Name', 'Stim. vector debug plot');
    hWhisk = plot(trace, 'k');
    hold on;
    hPeaks = scatter(peakPositions, peakValues + 0.5, 'kx');
    meanPlusOneSTD = nanmean(trace) + nanstd(trace);
    meanH = line([0 numel(trace)], [nanmean(trace) nanmean(trace)], 'Color', 'green');
    meanOneSTDH = line([0 numel(trace)], [meanPlusOneSTD meanPlusOneSTD], 'Color', 'cyan');
    minPeakH = line([0 numel(trace)], [minPeakHeight minPeakHeight], 'Color', 'red', 'LineStyle', '--');
    line([peakPositions(1) peakPositions(1)], [0 peakValues(1)], 'Color', 'blue', 'LineStyle', '--');
    minPeakDistH = line([peakPositions(1) + minPeakDist peakPositions(1) + minPeakDist], ...
        [0 nanmean(peakValues)], 'Color', 'blue', 'LineStyle', '--');
    minStartFrameH = line([minStartFrame minStartFrame], [0 peakValues(1)], 'Color', 'cyan', 'LineStyle', ':');
    for iPeak = 1 : numel(peakOnsetThresholds);
        hPeakOnsetThresh = line([peakPositions(iPeak) - minPeakDist peakPositions(iPeak) + 2], ...
            [peakOnsetThresholds(iPeak) peakOnsetThresholds(iPeak)], ...
            'Color', 'red', 'LineStyle', ':');
    end;
    peakOnsetFrames(peakOnsetFrames < 0) = NaN;
    hPeaksOnset = scatter(peakOnsetFrames, peakOnsetThresholds, 20, 'rs');
    xlabel('Frames');
    ylabel('Amplitdue');
    title(dbgPlotTitle, 'Interpreter', 'none');
    legend([hWhisk, minStartFrameH, minPeakDistH, meanH, meanOneSTDH, minPeakH, hPeakOnsetThresh, ...
        hPeaks(1), hPeaksOnset(1)], ...
        { traceName, 'Min. start frame', 'Min. inter-peak distance', 'Mean', ...
        'Mean + 1 SD', 'Minimum height', 'Onset thresholds', 'Peaks', 'Onsets' });
end;

end