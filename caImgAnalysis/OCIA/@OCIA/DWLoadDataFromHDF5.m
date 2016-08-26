function DWLoadDataFromHDF5(this, loadPath)
% DWLoadDataFromHDF5 - [no description]
%
%       DWLoadDataFromHDF5(this, loadPath)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
    
showMessage(this, sprintf('Loading data from "%s" ...', loadPath), 'yellow');

% get the rows of the current selection
rows = this.dw.selectedTableRows;    
nRows = numel(rows); % get the number of rows

% init wait bar
DWWaitBar(this, 0);

loadDataTic = tic; % for performance timing purposes
% go through each row   
for iRow = 1 : nRows;

    iDWRow = rows(iRow); % get the DataWatcher's table index
    rowID = DWGetRowID(this, iDWRow); % get the row's ID
    
    % create the generic save text and show a message
    loadText = sprintf('Loading data for %s (%03d)', rowID, iDWRow);

    % save the data for this single row
    DWLoadDataFromHDF5SingleRow(this, iDWRow, rowID, loadText, loadPath);
    
    % update the wait bar making a short pause every now and then to update the GUI
    DWWaitBar(this, 100 * (iRow / nRows));
    if mod(iRow, nRows * 0.001); pause(0.0001); end;

end;

% update the table's display and set the selected rows back
DWDisplayTable(this);
DWSelTableRows(this, rows);

showMessage(this, sprintf('Loading data from "%s" done (%.3f sec).', loadPath, toc(loadDataTic)));
    
end
