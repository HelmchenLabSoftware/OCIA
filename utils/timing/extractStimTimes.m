function stimVect = extractStimTimes(rawTrace, stimFreqs, inputFrameRate, doPlots)

dbgLvl = 3;

o('#extractStimTimes', 1, dbgLvl);

if size(rawTrace, 2) > 1 && size(rawTrace, 3) > 1;
    nFrames = size(rawTrace, 3);
    totDur = nFrames / inputFrameRate;
    trace = img2vector(rawTrace, inputFrameRate, 0);
    frameRate = numel(trace) / totDur;
    o('#extractStimTimes: img2vector done.', 2, dbgLvl);
else
    frameRate = inputFrameRate;
    trace = rawTrace;
    o('#extractStimTimes: trace is already a trace.', 2, dbgLvl);
end;

nPoints = numel(trace);
traceNorm = trace - mean(trace);
t = 1 / frameRate : 1 / frameRate : (nPoints / frameRate);
o('#extractStimTimes: created time axis.', 2, dbgLvl);

expectedStimTimes = 1 + (0 : 29) * 1.5;

nFreqs = numel(stimFreqs);
freqRange = 1000;
normTraces = zeros(nFreqs, nPoints);
upTimes = zeros(nFreqs, nPoints);
% stimVectsForEachFreq = zeros(nFreqs, nPoints - 1);
cutOffs = zeros(nFreqs, 1);
for iFreq = 1 : nFreqs;
    currFreq = stimFreqs(iFreq);
    normTraces(iFreq, :) = mpi_BandPassFilterTimeSeries( ...
        traceNorm, 1 / frameRate, currFreq - freqRange, currFreq + freqRange);
    largeCutOff = 3 * std(normTraces(iFreq, :));
    minMaxedTrace = abs(normTraces(iFreq, :));
    minMaxedTrace(minMaxedTrace > largeCutOff) = largeCutOff;
    cutOffs(iFreq) = 3 * std(minMaxedTrace);
    renormedTrace = abs(normTraces(iFreq, :));
%     renormedTrace(renormedTrace > cutOffs(iFreq)) = cutOffs(iFreq);
%     renormedTrace(renormedTrace < cutOffs(iFreq)) = 0;
    normTraces(iFreq, :) = renormedTrace;
    
    upTimes(iFreq, :) = abs(normTraces(iFreq, :)) > cutOffs(iFreq);
    
%     stimVectsForEachFreq(iFreq, :) = diff(stimSpanForEachFreq(iFreq, :));
    o('#extractStimTimes: filtered for %3.1f Hz.', currFreq, 3, dbgLvl);
end;
o('#extractStimTimes: filtered for all frequency bands.', 2, dbgLvl);

if doPlots > 0;
    
    figure('Name', 'extractStimTimes plot');
    
    subplot(3, 1, 1);
    plot(t, traceNorm);
    hold on;
    ylims = get(gca, 'YLim');
    for iStim = 1 : 30; line([expectedStimTimes(iStim) expectedStimTimes(iStim)], ylims, 'Color', 'red'); end;
    
    subplot(3, 1, 2);
    hold all;
    for iFreq = 1 : nFreqs;
        hPlot = plot(t, normTraces(iFreq, :) + iFreq * 100);
        meanVal = mean(normTraces(iFreq, :) + iFreq * 100);
        line([0, t(end)], [meanVal + cutOffs(iFreq, :) meanVal + cutOffs(iFreq, :)], 'Color', get(hPlot, 'Color'));
        line([0, t(end)], [meanVal - cutOffs(iFreq, :) meanVal - cutOffs(iFreq, :)], 'Color', get(hPlot, 'Color'));
    end;
    ylims = get(gca, 'YLim');
    for iStim = 1 : 30; line([expectedStimTimes(iStim) expectedStimTimes(iStim)], ylims, 'Color', 'red'); end;
end;

stimVect = 0;

end
