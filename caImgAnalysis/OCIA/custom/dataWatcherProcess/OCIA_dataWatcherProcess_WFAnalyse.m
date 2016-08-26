function OCIA_dataWatcherProcess_WFAnalyse(this, ~, ~)
% OCIA_dataWatcherProcess_WFAnalyse - [no description]
%
%       OCIA_dataWatcherProcess_WFAnalyse(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% store the selected rows so that even changing the selection in the DataWatcher mode does not affect the Analyser
this.an.selectedTableRows = this.dw.selectedTableRows;

% get the rows to process
toProcessRows = this.an.selectedTableRows;
nTotRows = numel(toProcessRows); % get the number of rows

% if no row selected, abort with a warning
if nTotRows == 0;
    showWarning(this, 'OCIA:OCIA_dataWatcherProcess_analyseRows:NoRows', 'No rows selected.');
    return;
end;

% jump to analyser mode in a different way
rowTypes = unique(get(this, this.dw.selectedTableRows, 'rowType'));
if numel(rowTypes) == 1 && strcmp(rowTypes{1}, 'WF trial');
    OCIA_dataWatcherProcess_analyseRows(this);
    return;
end;

% jump to analyser mode
INAnalyse(this, regexprep(get(this, this.dw.selectedTableRows, 'path'), '^.+/([^/]+)$', '$1'));

end
