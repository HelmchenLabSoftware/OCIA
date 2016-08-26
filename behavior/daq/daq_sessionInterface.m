function daq_sessionInterface(config)

% s = daq.createSession('ni');
% s.Rate = 50;
% s.DurationInSeconds = 40;
% s.addAnalogInputChannel('Dev1','ai0', 'Voltage');
% s.Channels.InputType = 'SingleEnded';
% s.Channels.Range = [-10 10];

% daqreset;
fprintf('Connecting hardware...\n');
s = daq.createSession(config.hardware.adaptorID);
recordRate = config.hardware.analogIn_SampleRate;
recordRate = 1000;
s.Rate = recordRate;
s.addAnalogInputChannel(config.hardware.analogIn_Device, ...
    config.hardware.analogIn_Channel, 'Voltage');
s.Channels.InputType = config.hardware.analogIn_InputType;
s.Channels.Range = config.hardware.analogIn_Range;
fprintf('s1 ok.\n');

% s2 = daq.createSession(config.hardware.adaptorID);
% s2.addDigitalChannel(config.hardware.digitalOut_Device, config.hardware.digitalOut_PortLine, 'OutputOnly');
% fprintf('And s2 ok. Ready to go.\n');

s.DurationInSeconds = 10;

global data;
data = [];

global h;
% 'Position', [150, 300, 950, 350], 
h = figure('Name', 'ContinuousRecording', 'NumberTitle', 'off', ...
        'MenuBar', 'none', 'ToolBar', 'none', 'WindowStyle', 'docked');
plot(0, 0);
hold on;
xlim([-0.3, s.DurationInSeconds * s.Rate * 1.1]);
% ylim([-0.3 0.3]);

lh = s.addlistener('DataAvailable', @collectAndPlotData);

s.startForeground();

function collectAndPlotData(~, event)
%     fprintf('#collectData\n');
    data = [data (event.Data - mean(event.Data))'];
    t = 1 : numel(data(data ~= 0));
    plot(t, data(t));
end

end
