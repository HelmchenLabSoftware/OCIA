function status = waitForExternalTrigger_H30(timeout)
% input argument: timeout in seconds
% RETURNS:
%       - status = 0 if waiting timed out
%       - status = 1 if trigger was successfully received
%       - status = 2 if could not connect to the nidaq analog input (or other error)

% created on 2014-02-01 by Balazs Laurenczy (blaurenczy@gmail.com)

status = 0;
try
    s = daq.createSession('ni');
    s.Rate = 1000;
    s.addAnalogInputChannel('ScanOutputCard', 'ai0', 'Voltage');
    s.Channels.Range = [-1 1];
    s.Channels.InputType = 'SingleEnded';
    s.DurationInSeconds = timeout;
    s.NotifyWhenDataAvailableExceeds = 50;
    s.addlistener('DataAvailable', @checkTriggerInData);
catch err; %#ok<NASGU>
   warning('externalTrigger_nidaq:ConnectError', 'Could not connect to nidaq analog input!');
   status = 2;
   return;
end;
thresh = NaN;
status = 0;
function checkTriggerInData(~, event)
    if isnan(thresh);
        thresh = max(max(event.Data) * 5, 0.15);
%         o('Defined thresh: %6.4f, max(data): %6.4f.', thresh, max(event.Data), 0, 0);
    end;
%     o('Collected data, thresh: %6.4f, max(data): %6.4f.', thresh, max(event.Data), 0, 0);
    timePointAboveThresh = find(event.Data > thresh, 1);
    if ~isempty(timePointAboveThresh);
%         firstTimePointAboveThresh = timePointAboveThresh(1);
%         o('Found trigger, firstTimePointAboveThresh: %d/%d.', firstTimePointAboveThresh, numel(event.Data), 0, 0);
        status = 1;
        s.stop();
    end;
end

try
    s.startForeground();
catch err; %#ok<NASGU>
end;
end
