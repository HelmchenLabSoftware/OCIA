function DWLoadGUIFromMAT(this, loadPath) 
% DWLoadGUIFromMAT - [no description]
%
%       DWLoadGUIFromMAT(this, loadPath) 
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
    
% load GUI
showMessage(this, sprintf('Loading GUI from "%s" ...', loadPath), 'yellow');

% check if the file exists
if ~exist(loadPath, 'file');
    showWarning(this, 'OCIA:DWLoadGUIFromMAT:FileNotFound', sprintf('Cannot find file "%s" for loading. Aborting.', loadPath));
    return;
end;

%% --- #load the OCIA object
loadTic = tic; % for performance timing purposes

% reload the structure from the mat file
MATStruct = load(loadPath, 'OCIASave');
OCIASave = MATStruct.OCIASave;

% get the fields to load
fieldsToLoad = fields(OCIASave);

% load the fields one by one
for iField = 1 : numel(fieldsToLoad);
    % get the field name
    fieldName = fieldsToLoad{iField};
    % load back the content of the current field
    fieldContent = OCIASave.(fieldName);
    % if current field is GUI, load back the GUI's state
    if strcmp(fieldName, 'GUI');
        DWLoadGUIState(this, fieldContent, {});
        
    % otherwise just copy back the field's content
    elseif strcmp(fieldName, 'dw');
        this.(fieldName) = fieldContent;
        
%     % otherwise just copy back the field's content
%     else
%         this.(fieldName) = fieldContent;
    end;        
end;

% update the GUI but first save the selected DataWatcher table's rows
selectedTableRows = this.dw.selectedTableRows;
DWDisplayTable(this);

% disable temporarly preview
isPreview = this.GUI.dw.showThumbnailPreview;
this.GUI.dw.showThumbnailPreview = false;

% set back row selection
DWSelTableRows(this, selectedTableRows);

% restore preview state
this.GUI.dw.showThumbnailPreview = isPreview;

% display message
showMessage(this, sprintf('Loading GUI from "%s" done (%.3f sec).', loadPath, toc(loadTic)));
    
end
