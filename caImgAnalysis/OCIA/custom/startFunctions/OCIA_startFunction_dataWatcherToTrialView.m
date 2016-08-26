function OCIA_startFunction_dataWatcherToTrialView(this)
% OCIA_startFunction_dataWatcherToTrialView - [no description]
%
%       OCIA_startFunction_dataWatcherToTrialView(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% go to DataWatcher mode
OCIAChangeMode(this, 'DataWatcher');

% process the selected folder
DWProcessWatchFolder(this);

% show welcome message
showMessage(this, sprintf('Welcome to the OCIA v%s ! :-)', this.main.version));

% fetch session rows
[~, sessRowNums] = DWFilterTable(this, 'rowType = WFLV session');
% if there is at least one
if numel(sessRowNums) > 0;
    % select it and move to trial view mode
    DWSelTableRows(this, sessRowNums(1));
    OCIA_dataWatcherProcess_trialView(this);
end;
            
end
