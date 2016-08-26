function [data, S, F, T, P] = daq_sessionInterfaceH45(dur, recordRate, condition, doPlot)

% s = daq.createSession('ni');
% s.Rate = 50;
% s.DurationInSeconds = 40;
% s.addAnalogInputChannel('Dev1','ai0', 'Voltage');
% s.Channels.InputType = 'SingleEnded';
% s.Channels.Range = [-10 10];

realTimePlot = 0;

recordChanNames = {'shutter'};
recordChanRanges = {1, 1, 1, 5, 5};
nChans = numel(recordChanNames);
recordChans = cell(nChans, 1);

daqreset;
fprintf('Connecting hardware...\n');
s = daq.createSession('nidaq');
s.Rate = recordRate;
for iChan = 1 : nChans;
    recordChans{iChan} = s.addAnalogInputChannel('ExtraChannels', iChan, 'Voltage');
    recordChans{iChan}.Name = recordChanNames{iChan};
    recordChans{iChan}.Range = repmat(recordChanRanges{iChan}, 1, 2) .* [-1 1];
    recordChans{iChan}.InputType = 'SingleEnded';
end;

% s.addAnalogInputChannel('ExtraChannels', 'ai0', 'Voltage'); % shutter
% s.addAnalogInputChannel('ExtraChannels', 'ai1', 'Voltage'); % laser power
% s.addAnalogInputChannel('ExtraChannels', 2, 'Voltage'); % motion
% s.addAnalogInputChannel('ExtraChannels', 'ai3', 'Voltage'); % microphone
% s.addAnalogInputChannel('ExtraChannels', 'ai4', 'Voltage'); % resonnance X position
% s.addAnalogInputChannel('ExtraChannels', 'ai5', 'Voltage');
% s.addAnalogInputChannel('ExtraChannels', 'ai6', 'Voltage');
% s.addAnalogInputChannel('ExtraChannels', 'ai7', 'Voltage');

% s.Channels.InputType = 'SingleEnded';
chanRange = [-5, 5];
% s.Channels.Range = chanRange;
fprintf('s1 ok.\n');

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

s.startForeground();

function collectAndPlotData(~, event)
    data = [data (event.Data - bsxfun(@rdivide, event.Data, mean(event.Data)))'];
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

colors = jet(nChans);
t = 1 : size(data, 2);
for iChan = 1 : nChans;
    subplot(nChans, 1, iChan);
    plot(t' ./ recordRate, data(iChan, t)', 'Color', colors(iChan, :));
    ylim([min(data(iChan, :)) max(data(iChan, :))]);
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
    freqDist = sum(realLogS, 2);
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
