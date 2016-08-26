function DWLoadDataFromHDF5SingleRow(this, iDWRow, rowID, loadText, loadPath)
% loads the data from the HDF5 file

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
toLoadDataTypeIndexes = get(this.GUI.handles.dw.SLROptDataList, 'Value');
toLoadDataTypeIDs = this.main.dataConfig.id(toLoadDataTypeIndexes);

% go through each data type and load it
for iType = 1 : nDataTypes;
    
    % get the ID and label for this type
    id = this.main.dataConfig.id{iType};
    label = this.main.dataConfig.label{iType};
    
    % if the current data type is not to be saved, skip it
    if ~ismember(id, toLoadDataTypeIDs); continue; end;
    
    % get all the data for this row
    dataForRow = get(this, iDWRow, 'data');
    
    % if the current data type is not found in the current row's data, skip it
    if ~isfield(dataForRow, id); continue; end;
    
    showMessage(this, sprintf('%s - %s ("%s") ...', loadText, label, id), 'yellow');
    
    try % catch errors
        
        % create the dataset path where to save the current data type
        datasetPathData = strrep(datasetPath, '_DATA:TYPE_', id);
        
        % if data does not exist, skip it
        if ~h5exists(loadPath, datasetPathData); continue; end;
        
        % check for the existence of the 'DataType' attribute
        try
            h5readatt(loadPath, datasetPathData, 'DataType');
            h5readatt(loadPath, datasetPathData, 'loadStatus');
        % if the attribute was not found, try to create it
        catch
            if ismember(id, { 'rawImg', 'procImg', 'rawChan', 'stim', 'exclMask', 'caTraces', 'whisk' });
                h5writeatt(loadPath, datasetPathData, 'DataType', 'double');
                h5writeatt(loadPath, datasetPathData, 'loadStatus', 'full');
            end;
        end;

        % load the data
        data = h5read_wrapper(loadPath, datasetPathData, {});
        % load the data's load status
        loadStatus = h5readatt(loadPath, datasetPathData, 'loadStatus');
        
        % store in the table
        setData(this, iDWRow, id, 'data', data);
        setData(this, iDWRow, id, 'loadStatus', loadStatus);
        
        % try to load the data's processing state
        try
            procState = h5readatt(loadPath, datasetPathData, 'procState');
            setData(this, iDWRow, id, 'procState', regexp(procState, ',', 'split'));
        catch err; %#ok<NASGU>
        end;
        
        % try to load the data's stimulus types
        try
            stimTypes = h5readatt(loadPath, datasetPathData, 'stimTypes');
            setData(this, iDWRow, id, 'stimTypes', stimTypes);
        catch err; %#ok<NASGU>
        end;
        
        o('%s - %s <= loaded from "%s"', loadText, id, datasetPathData, 3, this.verb);
            
    % if an error occured, pursue the saving but display an error message
    catch err;
        loadTextError = loadText; loadTextError(1) = lower(loadTextError(1));
        showWarning(this, 'OCIA:DWLoadDataFromHDF5SingleRow:saveError', ...
            sprintf('Error while %s - %s ("%s"): %s (%s)\n%s', loadTextError, label, id, ...
            err.message, err.identifier, getStackText(err)), 'red');
        pause(0.5);
        continue;
    end;
    
end;

end