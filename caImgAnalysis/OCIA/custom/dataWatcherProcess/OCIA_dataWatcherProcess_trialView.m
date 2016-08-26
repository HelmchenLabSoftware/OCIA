function OCIA_dataWatcherProcess_trialView(this, ~, ~)
% OCIA_dataWatcherProcess_trialView - [no description]
%
%       OCIA_dataWatcherProcess_trialView(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% store the selected rows so that even changing the selection in the DataWatcher mode does not affect the Analyser
this.an.selectedTableRows = this.dw.selectedTableRows;

% get the rows to process and count them
toProcessRows = this.an.selectedTableRows;
nTotRows = numel(toProcessRows);

% if no row selected, abort with a warning
if nTotRows == 0;
    showWarning(this, sprintf('OCIA:%s:NoRows', mfilename()), 'No rows selected.');
    return;
    
% if more than one row is selected, show warning and get only first one
elseif nTotRows > 1;
    showWarning(this, sprintf('OCIA:%s:TooManyRows', mfilename()), 'Only one session can be analysed at a time.');
    this.an.selectedTableRows = this.an.selectedTableRows(1);
    this.dw.selectedTableRows = this.dw.selectedTableRows(1);
    
end;

% get selected row and check if its a session
selRow = this.dw.selectedTableRows;
if ~strcmp(get(this, selRow, 'rowType'), 'WFLV session');
    showWarning(this, sprintf('OCIA:%s:NotASession', mfilename()), 'Only sessions can be viewed in TrialView.');
    return;
    
end;

% relocate all directory paths
fullPathToData = [get(this, selRow, 'path'), 'Matt_files/'];
this.tv.params.WFDataPath = fullPathToData;
% this.tv.params.saveLoadPath = regexprep(fullPathToData, '^(.+/)\w+/Matt_files/$', '$1');
this.tv.params.saveLoadPath = fullPathToData;
this.tv.params.behavDataPath = fullPathToData;
% reset all file paths
this.tv.params.behavFilePath = '';
this.tv.params.behavMoviePath = '';
this.tv.params.lickFilePath = '';
this.tv.params.whiskFilePath = '';
this.tv.params.WFFilePath = '';

% launch TrialView mode
OCIA_startFunction_trialView(this);

end
