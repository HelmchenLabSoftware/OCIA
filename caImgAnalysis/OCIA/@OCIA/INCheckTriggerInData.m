function INCheckTriggerInData(this, ~, event, callBack, callBackParams)
% INCheckTriggerInData - [no description]
%
%       INCheckTriggerInData(this, h, event, callBack)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if this.in.TTLOutStr.isWorking || isempty(event) || isempty(event.Data); return; end;

absData = abs(event.Data);
absData = absData - mean(absData);
% thresh = max(3 * std(absData), 0.1);
thresh = 0.5;
timePointAboveThresh = find(absData > thresh);
% plot(absData, 'Color', 'blue');
% if ~isempty(timePointAboveThresh);
%     if numel(timePointAboveThresh) > 0;
%         plot(absData, 'Color', 'green');
%     else
%         plot(absData, 'Color', 'red');
%     end;
%     title(sprintf('nPoints:%d', numel(timePointAboveThresh)));
% end;

if ~isempty(timePointAboveThresh) && numel(timePointAboveThresh) > 0;
    if isfield(this.in.TTLOutStr, 'trigTime') ...
            && nowUNIXSec() - this.in.TTLOutStr.trigTime < this.in.trial.trialDur * 0.95;
        o('Early trigger ignored', 0, 0);
        return;
    end;
    
%     o('Found trigger', 0, 0);
    start(timer('Name', 'triggerTime', 'TimerFcn', @(h, e)callBack(callBackParams{:})));
end;
    
end
