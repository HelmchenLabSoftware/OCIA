function [data, S, F, T, P] = daq_sessionInterfaceH30(dur, recordRate, condition, doPlot)

% s = daq.createSession('ni');
% s.Rate = 50;
% s.DurationInSeconds = 40;
% s.addAnalogInputChannel('Dev1','ai0', 'Voltage');
% s.Channels.InputType = 'SingleEnded';
% s.Channels.Range = [-10 10];

realTimePlot = 0;

% recordChanNames = {'shutter', 'breathing', 'microphone', 'laserPower', 'resXPos'};
% recordChanNames = {'lickSensor'};
% recordChanNames = {'lickSensor', 'microphone'};
recordChanNames = {'piezo', 'micr', 'yscan'};
% recordChanRanges = {1, 1, 1, 5, 5};
nChans = numel(recordChanNames);
recordChans = cell(nChans, 1);

daqreset;
fprintf('Connecting hardware...\n');
s = daq.createSession('ni');
s.Rate = recordRate;
% for iChan = 1 : nChans;
%     recordChans{iChan} = s.addAnalogInputChannel('ExtraChannels', iChan, 'Voltage');
% %     recordChans{iChan} = s.addAnalogInputChannel('BehaviorBox', iChan, 'Voltage');
%     recordChans{iChan}.Name = recordChanNames{iChan};
%     recordChans{iChan}.Range = repmat(recordChanRanges{iChan}, 1, 2) .* [-1 1];
%     recordChans{iChan}.InputType = 'SingleEnded';
% end;

% s.addAnalogInputChannel('BehaviorBox', 'ai0', 'Voltage'); % piezo
% s.addAnalogInputChannel('BehaviorBox', 'ai1', 'Voltage'); % micr
% s.addAnalogInputChannel('BehaviorBox', 'ai2', 'Voltage'); % yscan
% s.addAnalogInputChannel('ExtraChannels', 'ai0', 'Voltage'); % shutter
% s.addAnalogInputChannel('ExtraChannels', 'ai1', 'Voltage'); % laser power
% s.addAnalogInputChannel('ExtraChannels', 2, 'Voltage'); % motion
% s.addAnalogInputChannel('ExtraChannels', 'ai3', 'Voltage'); % microphone
% s.addAnalogInputChannel('ExtraChannels', 'ai4', 'Voltage'); % resonnance X position
% s.addAnalogInputChannel('ExtraChannels', 'ai5', 'Voltage');
% s.addAnalogInputChannel('ExtraChannels', 'ai6', 'Voltage');
% s.addAnalogInputChannel('ExtraChannels', 'ai7', 'Voltage');
s.addAnalogOutputChannel('ExtraChannels', 'ao0', 'Voltage'); % imaging TTL gate

% s.Channels.InputType = 'SingleEnded';
chanRange = [-10, 10];
% s.Channels.Range = chanRange;
fprintf('Hardware connected.\n');

% s2 = daq.createSession(config.hardware.adaptorID);
% s2.addDigitalChannel(config.hardware.digitalOut_Device, config.hardware.digitalOut_PortLine, 'OutputOnly');
% fprintf('And s2 ok. Ready to go.\n');

s.DurationInSeconds = dur;
data = [];

if realTimePlot;
%     'Position', [150, 300, 950, 350], 
    h = figure('Name', 'Recording', 'NumberTitle', 'off', 'WindowStyle', 'docked');
    plot(0, 0);
    hold on;
    ylim(chanRange);
    xlim([0, s.DurationInSeconds]);
end;

s.addlistener('DataAvailable', @collectAndPlotData);

% gongMat = load('gong.mat');
% m = load('C:\Users\laurenczy\Desktop\cloudOfTonesParameters.mat');
% cloudOfTones = MakeCloudOfTonesSound(m.freqs * 0.5, m.uniqueCloudCenterIndexes, m.cloudDispersion, m.stims, m.toneDur, ...
%     m.toneISI, m.stimDur, 1, m.sampFreq, 0, 0);

% s.startForeground();
s.startBackground();

% pause(1);
% sound(gongMat.y * 0.3);
% sound(repmat(cloudOfTones{2}, 1, 10), m.sampFreq);
% pause(0.5);
% sound(cloudOfTones{2}, m.sampFreq);
% pause(0.5);
% sound(cloudOfTones{3}, m.sampFreq);
% pause(0.5);
% sound(cloudOfTones{4}, m.sampFreq);
% pause(0.5);
% sound(cloudOfTones{5}, m.sampFreq);

s.wait();

function collectAndPlotData(~, event)
    currentData = event.Data;
    if isempty(data);
        currentData(fix(0.001 * recordRate) : end, :) = NaN;
    end;
    data = [data (currentData - bsxfun(@rdivide, currentData, mean(currentData)))'];
    if realTimePlot;
        figure(h);
        t = 1 : size(data, 2);
        plot(repmat(t ./ recordRate, 1, nChans), data(:, t)');
    end;
end

if realTimePlot;
    figure(h);
else
    h = figure('Name', 'Recording', 'NumberTitle', 'off', 'WindowStyle', 'docked');
end;

colors = lines(nChans);
% colors = jet(nChans);
t = 1 : size(data, 2);
for iChan = 1 : nChans;
    subplot(nChans, 1, iChan);
    dataForChan = data(iChan, :);
%     normData = linScale(dataForChan - nanmean(dataForChan), -1, 1);
    normData = dataForChan - nanmean(dataForChan);
%     normData = dataForChan;
    plot(t' ./ recordRate, normData', 'Color', colors(iChan, :));
%     minData = nanmin(normData);
%     maxData = nanmax(normData);
%     ylim([min(minData, -1) max(maxData, 1)]);
    ylabel(recordChanNames{iChan});
end;

N = 8;
% figure('Name', 'Spectrogram', 'NumberTitle', 'off', 'WindowStyle', 'docked');
% % spectrogram(data, 512, 480, 512, recordRate);
% spectrogram(data, 128 * N, 120 * N, 128 * N, recordRate);
% colorbar;

S = cell(nChans, 1);
F = cell(nChans, 1);
T = cell(nChans, 1);
P = cell(nChans, 1);

for iChan = 1 : nChans;
    
    [S{iChan}, F{iChan}, T{iChan}, P{iChan}] = spectrogram(data(iChan, :), 128 * N, 120 * N, 128 * N, recordRate);
    
    if ~doPlot; continue; end;

    %% plotting
    figure('Name', sprintf('Spectrogram_%s_%s', condition, recordChanNames{iChan}), ...
        'NumberTitle', 'off', 'WindowStyle', 'docked');
    realLogS = real(log(S{iChan}));

    subplot(2, 1, 1);
    imagesc(realLogS');
    nFreqs = size(realLogS, 1);
    nSamples = size(realLogS, 2);
    maxFreq = recordRate * 0.5;
    maxT = s.DurationInSeconds;
    freqIDs = (0 : 1000 : round(maxFreq / 1000) * 1000) / 1000;
    toShowFreqs = round(0 : nFreqs / (maxFreq / 1000) : nFreqs);
    t = 0 : 1 : s.DurationInSeconds;
    timeIndex = round(0 : nSamples / (maxT / 1) : nSamples);
    set(gca, 'XTick', toShowFreqs, 'XTickLabel', freqIDs, 'YTick', timeIndex, 'YTickLabel', t);
    xlabel('Frequencies [kHz]');
    ylabel('Time [s]');

    subplot(2, 1, 2);
    freqDist = nansum(realLogS, 2);
    secDeriv = diff(freqDist, 2);
    secDerivMinThresh = prctile(secDeriv, 2);
    peakInd = find(secDeriv < secDerivMinThresh);
    peakIndSingle = peakInd;
    peakIndSingle(diff(peakIndSingle) < 15) = [];
    plot(F{iChan}, freqDist);
    hold on;
    % scatter(F(peakIndSingle), freqDist(peakIndSingle) + 300, 'bx');
    for iPeak = 1 : numel(peakIndSingle);
        text(F{iChan}(peakIndSingle(iPeak)) + 100, freqDist(peakIndSingle(iPeak)) + 400, ...
            sprintf('%d Hz', round(F{iChan}(peakIndSingle(iPeak)))), 'FontSize', 8);
    end;

    suptitle(strrep(sprintf('%s_%s', condition, recordChanNames{iChan}), '_', '\_'));
end;

end
