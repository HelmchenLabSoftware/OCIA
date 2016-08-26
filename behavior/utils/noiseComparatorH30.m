function noiseComparatorH30()

dur = 3; % in sec
recordRate = 20000; % Hz
condition = 'MircAtMouseEar_Zoom8VSZoom2';

o('Before...', 0, 0);
[~, S1, F1, ~, ~] = daq_sessionInterfaceH30(dur, recordRate, [condition '_Before'], 1);
o('Before done.', 0, 0);
o('After...', 0, 0);
input('Hit enter to start after');
[~, S2, ~, ~, ~] = daq_sessionInterfaceH30(dur, recordRate, [condition '_After'], 1);
o('After done.', 0, 0);

%% plotting
realLogS1 = real(log(S1));
realLogS2 = real(log(S2));
figure('Name', 'SpectrogramDiffS2-S1', 'NumberTitle', 'off', 'WindowStyle', 'docked');

realLogS = realLogS2 - realLogS1;
subplot(2, 1, 1);
imagesc(realLogS');
nFreqs = size(realLogS, 1);
nSamples = size(realLogS, 2);
maxFreq = recordRate * 0.5;
maxT = dur;
freqIDs = (0 : 1000 : round(maxFreq / 1000) * 1000) / 1000;
toShowFreqs = round(0 : nFreqs / (maxFreq / 1000) : nFreqs);
t = 0 : 1 : dur;
timeIndex = round(0 : nSamples / (maxT / 1) : nSamples);
set(gca, 'XTick', toShowFreqs, 'XTickLabel', freqIDs, 'YTick', timeIndex, 'YTickLabel', t);
xlabel('Frequencies [kHz]');
ylabel('Time [s]');

subplot(2, 1, 2);
freqDist = sum(realLogS, 2);
secDeriv = diff(freqDist, 2);
secDerivMinThresh = prctile(secDeriv, 2);
peakInd = find(secDeriv < secDerivMinThresh);
peakIndSingle = peakInd;
peakIndSingle(diff(peakIndSingle) < 15) = [];
plot(F1, freqDist);
set(gca, 'XTick', toShowFreqs * 1000, 'XTickLabel', freqIDs);
xlabel('Frequencies [kHz]');
ylabel('Intensity [?]');
hold on;
for iPeak = 1 : numel(peakIndSingle);
    text(F1(peakIndSingle(iPeak)) + 100, freqDist(peakIndSingle(iPeak)) + 400, sprintf('%d Hz', round(F1(peakIndSingle(iPeak)))), 'FontSize', 8);
end;



suptitle(strrep(condition, '_', '\_'));

end
