function DWSaveGUIAsHDF5(this, savePath)
% DWSaveGUIAsHDF5 - [no description]
%
%       DWSaveGUIAsHDF5(this, savePath)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)
    
    showMessage(this, sprintf('Saving GUI to "%s" ...', savePath), 'yellow');
    saveGUITic = tic; % for performance timing purposes

    % save the data to set it back later and flush it for the saving
    dataBackup = get(this, 'data');
    DWFlushData(this, 'all', false);

    OCIASave = struct();
    % load the new structure by copying every field
    fieldsToSave = fields(this);
    for iField = 1 : numel(fieldsToSave);
        fieldName = fieldsToSave{iField};
        if strcmp(fieldName, 'GUI'); continue; end; % do not save GUI field in that way
        OCIASave.(fieldName) = this.(fieldName);
    end;
    
    % make sure the save button is not pressed down
    set(this.GUI.handles.dw.save, 'Value', 0);

    % save the state of the GUI
    OCIASave.GUI = DWSaveGUIState(this, this.GUI.handles);
    OCIASave.GUI.logBar__HANDLE.String = ''; % do not save the message of the log bar
    
    %{
    
    % capture errors
    try
        
        % save the fields one by one
        for iField = 1 : numel(fieldsToSave);
            % get the field name
            fieldName = fieldsToSave{iField};
            showMessage(this, sprintf('Saving GUI: "%s" ...', fieldName), 'yellow');
            % create the path
            datasetPath = sprintf('/GUI/%s', fieldsToSave{iField});
            % save the field
            h5createwrite_wrapper(savePath, datasetPath, OCIASave.(fieldName), {}, {});
            % update the wait bar
            DWWaitBar(this, 100 * iField / numel(fieldsToSave));
        end;
    
        % restore the data
        set(this, 'data', dataBackup);
        
    % catch errors but still restore the data
    catch err;
        
        % restore the data
        set(this, 'data', dataBackup);
        % rethrow the error
        rethrow(err);
        
    end;
    
    %}
    
    % get information about the saved file
    saveFile = dir(savePath);
    showMessage(this, sprintf('Saving GUI to "%s" done (%.3f sec, %.3f MB).', savePath, ...
        toc(saveGUITic), saveFile.bytes / (2^10 * 2^10)));
        
end
