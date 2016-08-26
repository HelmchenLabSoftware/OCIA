function status = waitForExternalTrigger_H30(timeout)
% input argument: timeout in seconds
% RETURNS:
%       - status = 0 if waiting timed out
%       - status = 1 if trigger was successfully received
%       - status = 2 if could not connect to the nidaq analog input

% this file written by Henry Luetcke (hluetck@gmail.com)
% modified on 2013-03-20 by Balazs Laurenczy (blaurenczy@gmail.com)
% modified more on 2013-12-19 by Balazs Laurenczy (blaurenczy@gmail.com)

status = 0;
% Create an analog input object using Board ID "Dev1".
try
    s = daq.createSession('ni');
    s.Rate = 2000000;
    s.addAnalogInputChannel('ExtraChannels', 'ai0', 'Voltage');
    s.Channels.Range = [-1 1];
    s.Channels.InputType = 'SingleEnded';
    s.DurationInSeconds = 3;
    lh = s.addlistener('DataAvailable', @checkTriggerInData);
catch err; %#ok<NASGU>
   warning('externalTrigger_nidaq:ConnectError', 'Could not connect to nidaq analog input!');
   status = 2;
   return;
end;
thresh = NaN;
function checkTriggerInData(~, event)
    if isnan(thresh);
        thresh = max(event.Data) * 5;
    end;
    o('Collected data, thresh: %6.4f, max(data): %6.4f.', thresh, max(event.Data), 0, 0);
    timePointAboveThresh = find(event.Data > thresh);
    if ~isempty(timePointAboveThresh);
        firstTimePointAboveThresh = timePointAboveThresh(1);
        o('Found trigger, firstTimePointAboveThresh: %d/%d.', firstTimePointAboveThresh, numel(event.Data), 0, 0);
    end;
end

% set(ai,'TriggerType','HwAnalog');
% set(s.Channels, 'TriggerType', 'HwDigital');
% set(s.Channels, 'TriggerCondition', 'PositiveEdge'); % for HelioScan
% set(s.Channels, 'HwDigitalTriggerSource', 'PFI0');
s.startForeground();
% % Wait up to timeout seconds for the acquisition to complete
% try
%     wait(ai, timeout);
%     data = getdata(ai);
%     status = 1;
% catch
%     status = 0;
% end
% 
% % Clean up
% stop(ai);
% delete(ai);
end
