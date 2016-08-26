function OCIA_dataWatcherProcess_onlineAnalysisSetRef(this, ~, ~)
% OCIA_dataWatcherProcess_onlineAnalysisSetRef - [no description]
%
%       OCIA_dataWatcherProcess_onlineAnalysisSetRef(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% get the selected rows
selRows = this.dw.selectedTableRows;

% abort if no rows
if isempty(selRows); return; end;

% go through all rows of the table
for iRow = 1 : size(this.dw.table, 1);
    
    % skip non-imaging data
    isImagingData = strcmp(get(this, iRow, 'rowType'), 'Imaging data');
    if ~isImagingData; continue; end;
    
    % get whether this row is a reference or not
    isRef = strcmp(get(this, iRow, 'isRef'), 'REF');
    
    % if row is part of the selected rows => toggle mode
    if ismember(iRow, selRows);
        % row is not ref, change it to ref
        if ~isRef;
            set(this, iRow, 'isRef', 'REF');
            
        % row is ref, change it to not ref
        elseif isRef;
            set(this, iRow, 'isRef', 'nop');
            
        end;
        
    % row is not ref, mark it as not ref
    elseif ~isRef;
        set(this, iRow, 'isRef', 'nop');
        
    % row is ref, mark it as ref
    elseif isRef;
        set(this, iRow, 'isRef', 'REF');
    end;
end;

DWUpdateColumnsDisplay(this, 1 : size(this.dw.table, 1), 'isRef', false);

end
