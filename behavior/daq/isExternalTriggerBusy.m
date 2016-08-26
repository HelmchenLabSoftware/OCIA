function isBusy = isExternalTriggerBusy

isBusy = 1;

% Create an analog input object using Board ID "Dev1".
ai = analoginput('nidaq','Dev1');
set(ai,'InputType','SingleEnded');

% Data will be acquired from hardware channel 0
addchannel(ai,0);
ai.Channel.InputRange = [-10 10];
ai.Channel.SensorRange = [-10 10];
ai.Channel.UnitsRange = [-10 10];
set(ai,'SampleRate',10000)
set(ai,'SamplesPerTrigger',100)

set(ai,'TriggerType','HwDigital');
set(ai,'HwDigitalTriggerSource','PFI0');

% % Review the basic configuration of the acquisition by typing
% % the name of the variable.
% ai
%
% % Use this command to see properties that can be configured
% set(ai)
% Use this comment to get a listing of all object properties and
% their current settings
% get(ai)
% Configure the analog input for single-ended or differential mode
% set(ai,'InputType','Differential');
% Set the sample rate and samples per trigger
% ai.SampleRate = 20000;
% ai.SamplesPerTrigger = 10000;

% Start the acquisition
try
    start(ai);
    % Clean up
    stop(ai);
    delete(ai);
    isBusy = 0;
catch
    isBusy = 1;
end