function DWLoadGUIFromHDF5(this, loadPath) 
% DWLoadGUIFromHDF5 - [no description]
%
%       DWLoadGUIFromHDF5(this, loadPath) 
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
    
    % load GUI
    showMessage(this, sprintf('Loading GUI from "%s" ...', loadPath), 'yellow');
    
    %% --- #load the OCIA object
    loadTic = tic; % for performance timing purposes
    
    % get the fields to load
    fieldsToLoad = fields(this);
    
    % load the fields one by one
    for iField = 1 : numel(fieldsToLoad);
        % get the field name
        fieldName = fieldsToLoad{iField};
        showMessage(this, sprintf('Loading GUI: "%s" ...', fieldName), 'yellow');
        % create the path
        datasetPath = sprintf('/GUI/%s', fieldName);
        
        % if the data set does not exist, skip this field
        if ~h5exists(loadPath, datasetPath); continue; end;
        
        try
            % load back the content of the current field
            fieldContent = h5read_wrapper(loadPath, datasetPath, {});
            % if current field is GUI, load back the GUI's state
            if strcmp(fieldName, 'GUI');
                DWLoadGUIState(this, fieldContent, {});
            % otherwise just copy back the field's content
            else
                this.(fieldName) = fieldContent;
            end;
        catch err; %#ok<NASGU>
            showWarning(this, 'OCIA:DWLoadGUIFromHDF5:GUIFieldLoadError', ...
                sprintf('Could not load GUI field %s from "%s".', fieldName, loadPath));
        end;
        
        % update the wait bar
        DWWaitBar(this, 100 * iField / numel(fieldsToLoad));
        pause(0.1);
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
