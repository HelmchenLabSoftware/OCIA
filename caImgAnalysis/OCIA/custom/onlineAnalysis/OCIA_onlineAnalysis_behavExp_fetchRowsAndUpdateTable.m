function OCIA_onlineAnalysis_behavExp_fetchRowsAndUpdateTable(this, animID, dayID, pathName)
% OCIA_onlineAnalysis_behavExp_fetchRowsAndUpdateTable - [no description]
%
%       OCIA_onlineAnalysis_behavExp_fetchRowsAndUpdateTable(this, animID, dayID, pathName)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get handles and show message
DWH = this.GUI.handles.dw;
showMessage(this, sprintf('OnlineAnalysis: getting %s data of day "%s" and animal "%s" ...', ...
    pathName, dayID, animID), 'yellow');

% change to local data
this.dw.watchFolder = this.path.([pathName 'Data']);
set(DWH.watchFoldDisp, 'String', sprintf('Watch folder: " %s "', this.dw.watchFolder));

% set parameters of filtering
set(DWH.watchTypes.animal, 'Value', ~isempty(animID));
if ~isempty(animID); set(DWH.filt.animalID, 'Value', 2, 'String', { '-', animID });
else                set(DWH.filt.animalID, 'Value', 1, 'String', { '-' }); end;
set(DWH.filt.dayID, 'Value', 2, 'String', { '-', dayID });

% process the selected folder and extract the notebook informations
oldVerb = this.verb; this.verb = 0;
DWProcessWatchFolder(this);
this.verb = oldVerb;
pause(0.1);
    
end