function [stimTable,h,toneClean] = ...
    AnalyzePureToneVector(tone,freq,doPlot,base)
% stimTable ... table with stim onTime, stim offTime, relative amplitude,
% frequency and Gof for each stimulus

% this file written by Henry Luetcke (hluetck@gmail.com)

if nargin < 4
    base = [0.1 0.6]; % baseline start / stop in s (exclude shutter noise)
end
% minimum length of segments, e.g. 0.05s
minSegmentLength = 0.05;
minSegmentLength = round(minSegmentLength*freq);
% frequency analysis duration, e.g. 0.1s
freqDur = 0.05;
freqDur = round(freqDur*freq);
if isstr(tone)
    tone = ReadEphys(tone,0);
end
time = 1/freq:1/freq:length(tone)/freq;
% filter between 0.5 kHz and 30 kHz
tone = mpi_BandPassFilterTimeSeries(tone,1/freq,500,30000);
tone = ScaleToMinMax(tone,-1,1);
% rectify and scale between 0 and 1
toneClean = ScaleToMinMax(abs(tone),0,1);
% windowSize average filter to enhance tone episodes
windowSize = 100;
toneClean = filtfilt(ones(1,windowSize)/windowSize,1,toneClean);
baseStart = find(time>=base(1));
baseStop = find(time>=base(2));
baseTone = toneClean(baseStart:baseStop);
thresh = mean(baseTone)+(std(baseTone)*1.5);
% toneClean(1:baseStop) = 0;
toneClean(toneClean<thresh) = 0;
toneClean(toneClean>=thresh) = 1;
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
    h = figure('Name','PureTone','NumberTitle','off','color','white');
    hold all
    plot(time,tone,'k')
    plot(time,toneClean,'r')
    set(gca,'xlim',[min(time) max(time)])
    legend({'raw','clean'});
else
    h = [];
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
    stimOn(n) = time(currentList(1));
    stimOff(n) = time(currentList(length(currentList)));
    timepoints = numel(currentTone);
    if numel(currentTone) > freqDur
        endTrim = round((numel(currentTone)-freqDur)/2);
        currentTone = currentTone(endTrim:length(currentTone)-endTrim);
    end
    currentT = 1/freq:1/freq:length(currentTone)/freq;
    currentT = currentT(:);
    currentTone = currentTone(:);
    options = fitoptions('sin1');
    options.Lower = [-Inf 2000*2*pi -Inf];
    options.Upper = [Inf 20000*2*pi Inf];
    [funFit,gof] = fit(currentT,currentTone,'sin1',options);
    dataFit = funFit.a1*sin(funFit.b1*currentT + funFit.c1);
    % plot the fit
    %     plot(time,data_fit,'r--');
    if doPlot
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





