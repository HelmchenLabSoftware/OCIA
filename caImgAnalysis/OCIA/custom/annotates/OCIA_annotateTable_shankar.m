function OCIA_annotateTable_shankar(this)
% OCIA_annotateTable_shankar - [no description]
%
%       OCIA_annotateTable_shankar(this)
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
behavRows = DWFilterTable(this, 'rowType = Behavior data');
if ismember('behavtext', this.main.dataModes) && size(behavRows, 1) > 0;       
    DWMatchBehavTrialsToImagingDataShankar(this);    
end;

% check if the processing should be aborted
if DWCheckProcessAbort(this, [], []); return; end;
    
% match the ROISets to the data
DWMatchROISetsToData(this);
DWDisplayTable(this); % display the table

end
