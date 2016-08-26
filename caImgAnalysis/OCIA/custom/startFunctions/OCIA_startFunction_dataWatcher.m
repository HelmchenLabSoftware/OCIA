function OCIA_startFunction_dataWatcher(this)
% OCIA_startFunction_dataWatcher - [no description]
%
%       OCIA_startFunction_dataWatcher(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% go to DataWatcher mode
OCIAChangeMode(this, 'DataWatcher');

% process the selected folder and extract the notebook informations
DWProcessWatchFolder(this);

% show welcome message
showMessage(this, sprintf('Welcome to the OCIA v%s ! :-)', this.main.version));
            
end
