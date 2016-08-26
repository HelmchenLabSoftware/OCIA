function OCIA_annotateTable_alex(this)
% OCIA_annotateTable_alex - [no description]
%
%       OCIA_annotateTable_alex(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% extract the notebook's informations
DWExtractNotebookInfo(this);

% get the different run types from the table
runTypes = unique(this.dw.table(~cellfun(@isempty, this.dw.table(:, 8)), 8));

% use these run types as stimulus IDs: store them and set them in the GUI's drop-down list
this.dw.stimtypeIDs = ['-'; runTypes];
set(this.GUI.handles.dw.filt.stimtypeID, 'String', this.dw.stimtypeIDs);

% match the ROISets to the data
DWMatchROISetsToData(this);

DWDisplayTable(this); % display the table's display
    
end
