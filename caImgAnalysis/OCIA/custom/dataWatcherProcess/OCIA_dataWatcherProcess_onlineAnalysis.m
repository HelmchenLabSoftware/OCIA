function OCIA_dataWatcherProcess_onlineAnalysis(this, h, ~)
% OCIA_dataWatcherProcess_onlineAnalysis - [no description]
%
%       OCIA_dataWatcherProcess_onlineAnalysis(this, h, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

localVerb = 2;

% check if the online analysis button is actually a toggle button
set(this.GUI.handles.dw.onlineAnalysis, 'Style', 'togglebutton', 'BackgroundColor', 'yellow');
pause(0.01);
isActivateRequest = get(this.GUI.handles.dw.onlineAnalysis, 'Value');

% abort command
if ischar(h) && strcmp(h, 'abort');
    isActivateRequest = false;
end;

% check if the timer is running
isOnlineAnalysisOnGoing = false;
if ~isempty(this.GUI.dw.onlineAnalysisTimer) && strcmp(this.GUI.dw.onlineAnalysisTimer.Running, 'on');
    isOnlineAnalysisOnGoing = true;
end;

% re-activation of online analysis
if isOnlineAnalysisOnGoing && isActivateRequest;
    o('#%s(): request for re-activating online analysis, skipping.', mfilename(), localVerb, this.verb);
    
% re-de-activation of online analysis
elseif ~isOnlineAnalysisOnGoing && ~isActivateRequest;
    o('#%s(): request for re-de-activating online analysis, skipping.', mfilename(), localVerb, this.verb);    
    
% activation of online analysis
elseif ~isOnlineAnalysisOnGoing && isActivateRequest;
    o('#%s(): activating online analysis ...', mfilename(), localVerb, this.verb);
    
    % stop previous eventual timer
    stopOATimer(this);
    % get online analysis function
    onlineAnalysisFcn = OCIAGetCallCustomFile(this, 'onlineAnalysis', this.dw.onlineAnalysisFunctionName, 0, { this }, 1);
    % create timer
    this.GUI.dw.onlineAnalysisTimer = timer('BusyMode', 'drop', 'ExecutionMode', 'fixedSpacing', ...
        'Name', 'onlineAnalysisTimer', 'Tag', 'DWOnlineAnalysisTimer', 'Period', this.GUI.dw.onlineAnalysisUpdatePeriod, ...
        'TimerFcn', @(~, ~)onlineAnalysisFcn(this), 'ErrorFcn', @(~, ~)OCIA_dataWatcherProcess_onlineAnalysis(this, 'abort'), ...
        'StartDelay', 0.2);
    % start timer
    start(this.GUI.dw.onlineAnalysisTimer);
    % show message
    showMessage(this, 'Started online analysis.');
    
% de-activation of online analysis
elseif isOnlineAnalysisOnGoing && ~isActivateRequest;
    o('#%s(): de-activating online analysis ...', mfilename(), localVerb, this.verb);    
    stopOATimer(this);
    % show message
    showMessage(this, 'Stopped online analysis.');
    
end;

% update GUI
set(this.GUI.handles.dw.onlineAnalysis, 'BackgroundColor', iff(isActivateRequest, 'green', 'red'), ...
    'Value', isActivateRequest);

o('#%s(): done.', mfilename(), localVerb, this.verb);

end

function stopOATimer(this)

     % if there is a timer, stop it and delete it
    if ~isempty(this.GUI.dw.onlineAnalysisTimer);
        stop(this.GUI.dw.onlineAnalysisTimer);
        delete(this.GUI.dw.onlineAnalysisTimer);
        this.GUI.dw.onlineAnalysisTimer = [];
    end;
end
