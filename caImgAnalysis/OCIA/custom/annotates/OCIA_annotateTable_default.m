function OCIA_annotateTable_default(this)
% OCIA_annotateTable_default - [no description]
%
%       OCIA_annotateTable_default(this)
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

% if there is behavior data to process
if ismember('behav', this.main.dataModes) && size(DWFilterTable(this, 'rowType = Behavior data'), 1) > 0;            
    % match the behavior trial numbers to the imaging data
    DWMatchBehavTrialsToImagingData(this);    
end;

% check if the processing should be aborted
if DWCheckProcessAbort(this, [], []); return; end;
    
% match the ROISets to the data
DWMatchROISetsToData(this);

% make the table unique
DWMakeTableUnique(this);

DWDisplayTable(this); % display the table

end
