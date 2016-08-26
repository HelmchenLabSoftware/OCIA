function RP = playTDTSound(y, attenuation, fig, nLoops)
% Runs a Tucker Davis circuit to play a sound.

% limit attenuation's value to 0dB <= attenuation <= 100dB
if ~isnumeric(attenuation) || isempty(attenuation) || attenuation < 0;
    attenuation = 0;
elseif attenuation > 100;
    attenuation = 100;
end;

% specify the path of the data-playing circuit
circuitPath = 'C:\TDT\Balazs_RPvdsEx_Circuits\PlayDataWithLoopOption.rcx';
% circuitPath = 'C:\TDT\Balazs_RPvdsEx_Circuits\PlayDataWithLoopOption_test.rcx';

% create the ActiveX control
if ~exist('fig', 'var') || isempty(fig);
    fig = gcf;
end;
RP = actxcontrol('RPco.x', [0 0 0 0], fig);
if RP.ConnectRZ6('GB', 1) == 0;
    error('TDT:Connect', 'Could not connect!');
end;

fprintf('#%s: stopping previous RP ...\n', mfilename());

RP.Halt(); % stop any processing chains running
RP.ClearCOF(); % clear all the buffers and circuits

fprintf('#%s: LoadCOFsf ...\n', mfilename());

% RP.LoadCOFsf(circuitPath, 4); % 4 corresponds to 100 kHz (97656.25 Hz)
RP.LoadCOFsf(circuitPath, 5); % 5 corresponds to 200 kHz (195312.5 Hz

fprintf('#%s: set tag vals ...\n', mfilename());

% set tags and load data
RP.SetTagVal('attenuation', attenuation);
RP.SetTagVal('nLoops', nLoops);
RP.SetTagVal('bufferSize', numel(y));
RP.WriteTagV('data', 0, y);

fprintf('#%s: run ...\n', mfilename());

RP.Run(); % start circuit

fprintf('#%s: set tag vals 2 ...\n', mfilename());

% set tags and load data
RP.SetTagVal('attenuation', attenuation);
RP.SetTagVal('nLoops', nLoops);
RP.SetTagVal('bufferSize', numel(y));
RP.WriteTagV('data', 0, y);

end