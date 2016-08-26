function DWSaveDataAsHDF5SingleRow(this, iDWRow, rowID, saveText, savePath)
% saves the data to the HDF5 file

% get the path parts for this run
pathParts = get(this, iDWRow, this.dw.HDF5.savePathConfig);
% fill-in the empty parts
emptyIndexes = find(cellfun(@isempty, pathParts));
if ~isempty(emptyIndexes);
    for iEmpty = 1 : numel(emptyIndexes);
        pathParts{emptyIndexes(iEmpty)} = sprintf('unknown_%s', this.dw.HDF5.savePathConfig{emptyIndexes(iEmpty)});
    end;
end;
% create the data set's path
dataSetRoot = sprintf(repmat('/%s', 1, numel(pathParts)), pathParts{:});
% get the dataset's path with a replaceable item tag '_DATA:TYPE_'
datasetPath = sprintf('%s/_DATA:TYPE_/%s', dataSetRoot, rowID);

nDataTypes = size(this.main.dataConfig, 1);
toSaveDataTypeIndexes = get(this.GUI.handles.dw.SLROptDataList, 'Value');
toSaveDataTypeIDs = this.main.dataConfig.id(toSaveDataTypeIndexes);

% go through each data type and save it
for iType = 1 : nDataTypes;
    
    % get the ID and label for this type
    id = this.main.dataConfig.id{iType};
    label = this.main.dataConfig.label{iType};
    
    % if the current data type is not to be saved, skip it
    if ~ismember(id, toSaveDataTypeIDs); continue; end;
    
    % get all the data for this row
    dataForRow = get(this, iDWRow, 'data');
    
    % if the current data type is not found in the current row's data, skip it
    if ~isfield(dataForRow, id); continue; end;
    
    showMessage(this, sprintf('%s - %s ("%s") ...', saveText, label, id), 'yellow');
    
    % get the data from the current type and its loading status
    data = dataForRow.(id).data;
    loadStatus = dataForRow.(id).loadStatus;
    % get the processing state if it exists, otherwise leave empty
    procState = [];
    if isfield(dataForRow.(id), 'procState');
        procState = dataForRow.(id).procState;
        % make sure procState is not a cell, but a string of form: "cell1,cell2,cell3"
        if iscell(procState);
            procState = regexprep(sprintf('%s,', procState{:}), ',$', '');
        end;
    end;
    % get the stimulus type if it exists, otherwise leave empty
    stimTypes = [];
    if isfield(dataForRow.(id), 'stimTypes');
        stimTypes = dataForRow.(id).stimTypes;
    end;
    
    try % catch errors
        
        % create the dataset path where to save the current data type
        datasetPathData = strrep(datasetPath, '_DATA:TYPE_', id);
        % if overwriting is required and data exists, delete the dataset/group
        if get(this.GUI.handles.dw.SLROpts.HDF5OverwriteData, 'Value') && h5exists(savePath, datasetPathData);
            showMessage(this, sprintf('%s - %s ("%s"): overwriting ...', saveText, label, id), 'yellow');
            h5deleteGroup(savePath, datasetPathData);

        % if no overwriting required but dataset/group exists, show a warning
        elseif h5exists(savePath, datasetPathData);
            saveTextWarning = saveText; saveTextWarning(1) = lower(saveTextWarning(1));
            showWarning(this, 'OCIA:DWSaveDataAsHDF5SingleRow:DataAlreadyExist', ...
                sprintf('Skipping the %s - %s ("%s"): data already exists and overwriting is off.', saveTextWarning, label, id));
            continue;
        end;

        % save the data
        h5createwrite_wrapper(savePath, datasetPathData, data, {}, {});  
        % save the data's load status
        h5writeatt(savePath, datasetPathData, 'loadStatus', loadStatus);
        % save the data's processing state if its not empty
        if ~isempty(procState);
            h5writeatt(savePath, datasetPathData, 'procState', procState);
        end;
        % save the data's stimulus type string if its not empty
        if ~isempty(stimTypes);
            h5writeatt(savePath, datasetPathData, 'stimTypes', stimTypes);
        end;

        o('%s - %s => saved to "%s"', saveText, id, datasetPathData, 3, this.verb);
            
    % if an error occured, pursue the saving but display an error message
    catch err;
        saveTextError = saveText; saveTextError(1) = lower(saveTextError(1));
        showWarning(this, 'OCIA:DWSaveDataAsHDF5SingleRow:saveError', ...
            sprintf('Error while %s - %s ("%s"): %s (%s)\n%s', saveTextError, label, id, ...
            err.message, err.identifier, getStackText(err)), 'red');
        pause(0.5);
        continue;
    end;
    
end;

end