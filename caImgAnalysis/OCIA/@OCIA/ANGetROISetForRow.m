function [ROISets, runsValidities, iDWROISetRows, iDWRefRows, refImages] = ANGetROISetForRow(this, DWRows)
% ANGetROISetForRow - [no description]
%
%       [ROISets, runsValidities, iDWROISetRows, iDWRefRows, refImages] = ANGetROISetForRow(this, DWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

ROISets = []; % default is empty
runsValidities = []; % default is empty
iDWROISetRows = []; % default is empty
iDWRefRows = []; % default is empty
refImages = []; % default is empty
    
% get the ROISet IDs of the requested rows
ROISetIDs = get(this, DWRows, 'ROISet'); % get the ROISet ID
if ischar(ROISetIDs); ROISetIDs = { ROISetIDs }; end; % make sure we have a cell
if ~isempty(ROISetIDs);
    ROISetIDs = unique(ROISetIDs, 'stable'); % make sure we do not have duplicates
    ROISetIDs(cellfun(@isempty, ROISetIDs)) = []; % remove empty IDs
    nROISetIDs = numel(ROISetIDs); % count them
else
    nROISetIDs = 0;
end;

% if no ROISet information, return empty and show warning
if nROISetIDs == 0;
    if numel(DWRows) == 1;
        showWarning(this, 'OCIA:ANGetROISetForRow:NoROISet', sprintf('Cannot find a ROISet for %s (%03d)! Skipping.', ...
            DWGetRowID(this, DWRows(1)), DWRows(1)));
    else
        showWarning(this, 'OCIA:ANGetROISetForRow:NoROISet', ...
            sprintf('Cannot find a ROISet for rows from %s (%03d) to %s (%03d)! Skipping.', ...
            DWGetRowID(this, DWRows(1)), DWRows(1), DWGetRowID(this, DWRows(end)), DWRows(end)));
    end;
    return;
end;

% initialize the output variables for each ROISet ID
ROISets         = cell(1, nROISetIDs);
runsValidities  = cell(1, nROISetIDs);
iDWROISetRows   = cell(1, nROISetIDs);
iDWRefRows      = cell(1, nROISetIDs);
refImages       = cell(1, nROISetIDs);

% go through each new ROISet
iROISet = 0;
for iROISetLoop = 1 : nROISetIDs;
    
    iROISet = iROISet + 1;
    % get the current ID and the DataWatcher table's row associated to that id
    ROISetID = ROISetIDs{iROISet};    
    ROISetRow = DWFilterTable(this, sprintf('rowType = ROISet AND ROISet = %s', ROISetID));

    % if there are no rows with that ROISet id show a message and skip
    if isempty(ROISetRow);
        showWarning(this, 'OCIA:ANGetROISetForRow:UnknownROISetID', sprintf('Cannot find ROISet "%s". Skipping.', ROISetID));
        ROISets(iROISet) = [];
        runsValidities(iROISet) = [];
        iDWROISetRows(iROISet) = [];
        iDWRefRows(iROISet) = [];
        refImages(iROISet) = [];
        iROISet = iROISet - 1;
        continue;
    end;

    % get the row index of this ROISet
    iDWROISetRows{iROISet} = str2double(get(this, 1, 'rowNum', ROISetRow));
    % get the row index of the reference run of this ROISet (data row that has the same time)
    refRow = DWFilterTable(this, sprintf('rowID = %s AND rowType = Imaging data', ROISetID));
    % if reference row was found (not empty), get the row's index
    if ~isempty(refRow);
        iDWRefRows{iROISet} = str2double(get(this, 1, 'rowNum', refRow));        
    end;


    % get the ROISet
    DWLoadRow(this, iDWROISetRows{iROISet}, 'full');
    ROISetData = getData(this, iDWROISetRows{iROISet}, 'ROISets', 'data');
    ROISets{iROISet} = ROISetData.ROISet;
    % get the runs validity
    runsValidities{iROISet} = ROISetData.runsValidity;
    % get the reference image
    refImages{iROISet} = ROISetData.refImage;
    
end;

% do not output cell-arrays if only one ROISet was found
if iROISet == 1;
    ROISets = ROISets{1};
    runsValidities = runsValidities{1};
    iDWROISetRows = iDWROISetRows{1};
    iDWRefRows = iDWRefRows{1};
    refImages = refImages{1};
end;

end
