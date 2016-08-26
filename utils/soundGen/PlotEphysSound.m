function PlotEphysSound(ephysFile, soundFile)%(ephys,ephysT,sound,soundT)

sf = 65000;

ephys = ReadIgorDatFile(ephysFile);
ephysT = 1/sf:1/sf:length(ephys)/sf;
sound = ReadIgorDatFile(soundFile);
soundT = 1/sf:1/sf:length(sound)/sf;

lfpDur = 0.1; % in s

% ephys = S.ephys;
% ephysT = S.ephysT;
% ephysRate = 1/(ephysT(2)-ephysT(1));
ephysRate = 20000;
lfpTimepoints = round(lfpDur * ephysRate);

% offset and scale sound
ephysRange = max(ephys) - min(ephys);
% soundT = S.soundT;
% soundRate = 1/(soundT(2)-soundT(1));
soundRate = sf;
soundPlot = ScaleToMinMax(sound,min(abs(ephys)),max(abs(ephys)));
soundPlot = soundPlot + (max(ephys) - min(soundPlot));

% plot
figure('Name','Sound Ephys','NumberTitle','off'), hold on
plot(ephysT,ephys,'k')
plot(soundT,soundPlot,'r')
set(gca,'xlim',[min([min(ephysT) min(soundT)]) max([max(ephysT) max(soundT)])])

[spkT,lfp] = cellAttachedPreproc(ephys,ephysRate,0);

lfpPlot = lfp - (max(lfp) - min(ephys));
plot(ephysT,lfpPlot,'b')

for n = 1:numel(spkT)
    plot([spkT(n) spkT(n)],[max(ephys)/4 max(ephys)/2],'r')
end

% analyze sound vector
stimTable = AnalyzePureToneVector(sound,soundRate,0);
labelOffset = max(soundPlot);
fVector = zeros(1,size(stimTable,1));
for n = 1:size(stimTable,1)
    tOn = stimTable(n,1);
    a = stimTable(n,3);
    f = round(stimTable(n,4)/1000);
    labelText = sprintf('%1.2f\n%1.1f',a,f);
    text(tOn,labelOffset,labelText,'FontSize',6)
    fVector(n) = f;
end

% analyze different frequencies
uniqueF = unique(fVector);
spikeCell = cell(1,numel(uniqueF));
lfpCell = cell(1,numel(uniqueF));
baseRate = [];
for n = 1:size(stimTable,1)
    % spikes
    f =  round(stimTable(n,4)/1000);
    idx = find(uniqueF==f);
    tOn = stimTable(n,1);
    tOff = stimTable(n,2);
    currentSpikes = 0;
    baseSpikes = 0;
    for m = 1:numel(spkT)
        if spkT(m) > tOn && spkT(m) < tOff
            currentSpikes = currentSpikes + 1;
        end
        if n > 1
            if spkT(m) > stimTable(n-1,2) && spkT(m) < tOn
                baseSpikes = baseSpikes + 1;
            end
        end
    end
    currentRate = currentSpikes / (tOff - tOn);
    if n > 1
        currentBaseRate = baseSpikes / (tOn - stimTable(n-1,2));
        baseRate = [baseRate currentBaseRate];
    end
    if isempty(spikeCell{idx})
        spikeCell{idx} = currentRate;
    else
        spikeCell{idx} = [spikeCell{idx} currentRate];
    end
    % lfp
    [val,i] = min(abs(tOn-ephysT));
    currentLfp = lfp(i:i+lfpTimepoints);
    if isempty(lfpCell{idx})
       lfpCell{idx} = currentLfp;
    else
        lfpCell{idx} = [lfpCell{idx};currentLfp];
    end
end

figure('Name','Spike rate','NumberTitle','off'), hold on
for n = 1:numel(spikeCell)
    currentF = uniqueF(n);
    for m = 1:numel(spikeCell{n})
        scatter(currentF,spikeCell{n}(m),'k*');
    end
    hErr = errorbar(currentF,mean(spikeCell{n}),std(spikeCell{n}),'ko');
    removeErrorBarEnds(hErr)
end
hErr = errorbar(0,mean(baseRate),std(baseRate),'ko');
removeErrorBarEnds(hErr)
set(gca,'xlim',[-0.5 max(uniqueF)+1])
xlabel('Frequency / kHz')
ylabel('Spike rate / Hz')

figure('Name','LFP','NumberTitle','off'), hold on
for n = 1:numel(lfpCell)
    currentF = uniqueF(n);
    subplot(1,numel(lfpCell),n), hold on
    currentMat = lfpCell{n};
    lfpT = 1/ephysRate:1/ephysRate:size(currentMat,2)/ephysRate;
    for m = 1:size(currentMat,1)
        plot(lfpT,currentMat(m,:),'Color',[0.5 0.5 0.5],'LineWidth',0.5)
    end
    plot(lfpT,mean(currentMat,1),'Color',[1 0 0],'LineWidth',1.5)
    set(gca,'xlim',[0 max(lfpT)])
    title(['LFP ' num2str(currentF) ' kHz'])
end
xlabel('Time /s')
tilefigs




