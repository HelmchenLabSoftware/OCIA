function DWLoadRow(this, iDWRow, loadType)
% DWLoadRow - [no description]
%
%       DWLoadRow(this, iDWRow, loadType)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
% get the row's ID
rowID = DWGetRowID(this, iDWRow);

o('#DWLoadRow(): loading %s (%03d) (loadType: %s) ...', rowID, iDWRow, loadType , 4, this.verb);

% get the row type's ID: go through all watch types
rowTypeID = DWGetRowTypeID(this, iDWRow);
% if no row type ID, abort
if isempty(rowTypeID); return; end;

% call the custom load function
OCIAGetCallCustomFile(this, 'loadData', rowTypeID, 1, { this, iDWRow, loadType }, false);

% update the row's loading and processing status
DWGetUpdateDataLoadStatus(this, iDWRow);

end
