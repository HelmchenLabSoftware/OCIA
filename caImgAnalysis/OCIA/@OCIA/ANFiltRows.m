function ANFiltRows(this)
% ANFiltRows - [no description]
%
%       ANFiltRows(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the filtering string
filtTxt = get(this.GUI.handles.an.rowFilt, 'String');
% get the list of rows
rowList = get(this.GUI.handles.an.rowList, 'String');

% if no filtering text or 'all' string is specified, select all rows
if isempty(filtTxt) || strcmp(filtTxt, 'all'); 
    set(this.GUI.handles.an.rowList, 'Value', 1 : numel(rowList));
    showMessage(this, 'Selected all rows.');
    return;
end;

% otherwise use regular expression on the row list
matchRowIndexes = find(~cellfun(@isempty, regexp(rowList, filtTxt)));
% select the matching rows
set(this.GUI.handles.an.rowList, 'Value', matchRowIndexes);

showMessage(this, sprintf('Selected %d row(s).', numel(matchRowIndexes)));
    
end
