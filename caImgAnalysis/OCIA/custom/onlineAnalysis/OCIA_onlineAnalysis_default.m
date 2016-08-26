function OCIA_onlineAnalysis_default(this)
% OCIA_onlineAnalysis_default - [no description]
%
%       OCIA_onlineAnalysis_default(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

    % go to DataWatcher mode
    OCIAChangeMode(this, 'DataWatcher');
    
    % process the selected folder and extract the notebook informations
    DWProcessWatchFolder(this);
    
end
