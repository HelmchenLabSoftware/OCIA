
% c

% TDTSF = 195312.5; % Hz
TDTSF = 97656.25; % Hz
rootPath = 'C:\TDT\Balazs_RPvdsEx_Circuits\';

%% create cloud
doPlot = 0;
freqList = 5000 * (2 .^ (((1 : 25) - 1) * (2 ^ -3))); % Hz
nFreqs = numel(freqList);
% stims = [1 1 1 2 1 1 1 1 1 2 1 1 1 2]; centers = [3 23]; cloudWidth = 2; % indexes
% stims = [1 2 1]; centers = [3 23]; cloudWidth = 2; % indexes
% cloudWidth = 2; centers = [1 + cloudWidth 8 13 17 nFreqs - cloudWidth]; stims = [1 2 3 4 5 1]; % indexes
% cloudWidth = 4; centers = [1 + cloudWidth round(nFreqs * 0.5) nFreqs - cloudWidth]; stims = [1 2 3]; % indexes
cloudWidth = 4; centers = (1 + cloudWidth) : (nFreqs - cloudWidth); stims = 1 : numel(centers); % indexes
totSoundDur = 0.21; dutyCycle = 0.8; toneDur = 0.03; toneISI = 0.01; % sec
cot = MakeCloudOfTonesSound(freqList, centers, cloudWidth, stims, toneDur, toneISI, totSoundDur, 0, TDTSF, doPlot, 0);
cotAll = cell2mat(cot);
cotAll = [zeros(size(cotAll, 1), round(TDTSF * (dutyCycle - totSoundDur))) cotAll];
cotAllLin = reshape(cotAll', 1, numel(cotAll));

%% activex
figure();
RP = actxcontrol('RPco.x', [1 1 1 1]);
if RP.ConnectRZ6('GB', 1) == 0; error('TDT:Connect', 'Could not connect!'); end;

RP.Halt; % Stops any processing chains running
RP.ClearCOF; % Clears all the buffers and circuits

RP.LoadCOFsf([rootPath 'PlayData.rcx'], 5); % 5 corresponds to 200 kHz (195312.5 Hz)

RP.SetTagVal('bufferSize', numel(cotAllLin));

RP.Run; % Start circuit

RP.SetTagVal('bufferSize', numel(cotAllLin));
RP.WriteTagV('data', 0, cotAllLin);

% figure(); plot(data); hold on; plot(cotAllLin, 'r');

o(' - bufferPos: %d, bufferSize: %d', RP.GetTagVal('bufferPos'), RP.GetTagVal('bufferSize'), 0, 0);

%% start
input('Start trigger: ');
RP.SoftTrg(1);

try
    while RP.GetTagVal('bufferPos');
        pause(0.5);
        o('  - bufferPos: %d, bufferSize: %d', RP.GetTagVal('bufferPos'), RP.GetTagVal('bufferSize'), 0, 0);
    end;
catch err;
end;

input('Done: ');

RP.Halt;

RP.release;
close all;
