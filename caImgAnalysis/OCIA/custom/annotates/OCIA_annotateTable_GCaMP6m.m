function OCIA_annotateTable_GCaMP6m(this)
% OCIA_annotateTable_GCaMP6m - [no description]
%
%       OCIA_annotateTable_GCaMP6m(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% check if the processing should be aborted
if DWCheckProcessAbort(this, [], []); return; end;

% extract the notebook's informations
DWExtractNotebookInfo(this);
DWDisplayTable(this); % display the table
        
% check if the processing should be aborted
if DWCheckProcessAbort(this, [], []); return; end;

runTypes = get(this, 'all', 'runType');
imTypes = get(this, 'all', 'imType');

% change 'comment' to 'movie'
for iRow = 1 : numel(runTypes);
    if strcmp(runTypes{iRow}, 'comment') && strcmp(imTypes{iRow}, 'movie');
        set(this, iRow, 'runType', 'movie');
    end;
end;

% check if the processing should be aborted
if DWCheckProcessAbort(this, [], []); return; end;
    
% match the ROISets to the data
DWMatchROISetsToData(this);
DWDisplayTable(this); % display the table

end
