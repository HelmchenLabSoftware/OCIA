function [stimTable, toneClean] = cleanUpBadSound(tone,f,doPlot)

base = [0.1 1]; % in s

% minimum length of segments, e.g. 0.05s
minSegmentLength = 0.05;
minSegmentLength = round(minSegmentLength*f);

% frequency analysis duration
freqDur = 0.05;
freqDur = round(freqDur*f);

tone = double(tone);
t = 1./f:1./f:length(tone)./f;

k = 0.2; % in s
k = round(k*f);

tone(tone<mean(tone)) = NaN;
tone = inpaint_nans(tone,4);
tone = tone - mean(tone);
tone = ScaleToMinMax(tone,-1,1);

% windowSize average filter to enhance tone episodes
windowSize = 200;
toneClean = filtfilt(ones(1,windowSize)/windowSize,1,tone);

baseStart = find(t>=base(1),1,'first');
baseStop = find(t>=base(2),1,'first');
baseTone = toneClean(baseStart:baseStop);
thresh = mean(baseTone)+(std(baseTone)*2);
toneClean(toneClean>=thresh) = 1;
toneClean(toneClean<thresh) = 0;

CC = bwconncomp(toneClean);
for n = 1:numel(CC.PixelIdxList)
    currentList = CC.PixelIdxList{n};
    if size(currentList,1) < minSegmentLength
        toneClean(currentList) = 0;
    end
end

% join segments closer than 2 min. length
CC = bwconncomp(toneClean);
for n = 2:numel(CC.PixelIdxList)
    currentList = CC.PixelIdxList{n};
    previousList = CC.PixelIdxList{n-1};
    if currentList(1) - previousList(length(previousList)) < minSegmentLength*2
        toneClean(previousList(1):currentList(1)) = 1;
    end
end

if doPlot
    plot(t,tone,'k'), hold on
    plot(t,toneClean,'r')
end

% main frequency in each segment
CC = bwconncomp(toneClean);
principalFreq = zeros(1,numel(CC.PixelIdxList));
stimOn = zeros(numel(CC.PixelIdxList),1);
stimOff = zeros(numel(CC.PixelIdxList),1);
stimTable = zeros(numel(CC.PixelIdxList),5);

for n = 1:numel(CC.PixelIdxList)
    currentList = CC.PixelIdxList{n};
    currentTone = tone(currentList);
    stimOn(n) = t(currentList(1));
    stimOff(n) = t(currentList(length(currentList)));
    timepoints = numel(currentTone);
    if numel(currentTone) > freqDur
        endTrim = round((numel(currentTone)-freqDur)/2);
        currentTone = currentTone(endTrim:length(currentTone)-endTrim);
    end
    currentT = 1/f:1/f:length(currentTone)/f;
    currentT = currentT(:);
    currentTone = currentTone(:);
    currentTone = currentTone - mean(currentTone);
    options = fitoptions('sin1');
    options.Lower = [max(currentTone)./10 2000*2*pi -Inf];
    options.Upper = [max(currentTone) 25000*2*pi Inf];
    [funFit,gof] = fit(currentT,currentTone,'sin1',options);
    dataFit = funFit.a1*sin(funFit.b1*currentT + funFit.c1);
    % plot the fit
    if doPlot
        figure('Name',sprintf('Segment %1.0f',n),'NumberTitle','off')
        plot(currentT,currentTone,'k'), hold on
        plot(currentT,dataFit,'r--');
        title(sprintf('F: %1.3f Gof: %1.3f',funFit.b1/(2*pi),gof.rsquare))
        fprintf('\nSegment %1.0f at %1.4f - %1.4f s\n',n,stimOn(n),stimOff(n));
        fprintf('Amplitude: %1.3f\n',funFit.a1);
        fprintf('Frequency: %1.3f\n',funFit.b1/(2*pi));
        fprintf('Phase: %1.3f\n',funFit.c1);
        fprintf('Gof: %1.3f\n',gof.rsquare);
    end
    
    stimTable(n,1) = stimOn(n);
    stimTable(n,2) = stimOff(n);
    stimTable(n,3) = funFit.a1;
    stimTable(n,4) = funFit.b1/(2*pi);
    stimTable(n,5) = gof.rsquare;
end


