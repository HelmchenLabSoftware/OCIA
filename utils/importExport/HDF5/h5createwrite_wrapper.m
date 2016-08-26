function h5createwrite_wrapper(fileName, datasetPath, data, h5createArgs, h5writeArgs)
% h5createwrite_wrapper(fileName, datasetPath, data, h5createArgs, h5writeArgs)
% Wrapper for the h5create and h5write functions that also handles cell-array, structures and struct-arrays.
% Recursively creates and/or writes the data as HDF5 into the file "fileName" under the dataset path "datasetPath".
% Arguments to the h5create and h5write functions can be provided using the h5createArgs and h5writeArgs cell-array.

% maximum limit for having a string structure value written out as an attribute
CHAR_ATT_LIMIT = 200;
% maximum limit for having a logical structure value written out as an attribute
LOGICAL_ATT_LIMIT = 10;
% maximum limit for having a numeric structure value written out as an attribute
NUMERIC_ATT_LIMIT = 10;
% maximum number of dimensions that a cell can have and still be converted as a matrix
CELL_MAX_DIM = 32;
% minimum number of characters required to know a datatype from the command "class"
DATA_TYPE_DESCR_LEN = 7;

% get the data type of the data and store it before eventual modifications
dataType = class(data);
originalDataType = dataType;

% process the different data types in different ways
switch dataType;
    
    % numeric
    case {'single', 'double', 'int8', 'uint8', 'int16', 'uint16', 'int32', 'uint32', 'int64', 'uint64'};
        
        % nothing to do, just store as numeric
        
    % logical and strings (char)
    case {'logical', 'char'};
        
        % logical and chars should be converted to 8-bit
        data = uint8(data);
        % get the new data type
        dataType = class(data);
    
    % cell-arrays
    case 'cell';
        
        % cell arrays are processed in a separate function
        processCellArray(fileName, datasetPath, data, h5createArgs, h5writeArgs, CELL_MAX_DIM, DATA_TYPE_DESCR_LEN);
        
        % stop here since function 
        return;
    
    %  structures and struct-arrays
    case 'struct';
        
        % if creation is required, create the group path first, so that attribute saving already have the path ready
        h5createIntermediateGroup(fileName, datasetPath);
            
        % structures and struct-arrays are processed in a separate function
        processStruct(fileName, datasetPath, data, h5createArgs, h5writeArgs, CHAR_ATT_LIMIT, LOGICAL_ATT_LIMIT, ...
            NUMERIC_ATT_LIMIT);
        
        return;
        
    % others: categorical (nominal/ordinal), tables and all kinds of weird stuff are not supported
    otherwise;
        
        warning('h5createwrite_wrapper:DataTypeNotSupported', 'Data type "%s" is not supported.', dataType);
        
        % abort
        return;
    
end;

% get the dimension of the data
dim = size(data);

% is data size is not empty, create the data set with the actual data type
if ~any(dim == 0);

    % if dataset already exists, delete it
    if h5exists(fileName, datasetPath); h5deleteGroup(fileName, datasetPath); end;
    h5create(fileName, datasetPath, dim, 'DataType', dataType, h5createArgs{:});
    
    % write the data into the data set with the actual data type
    h5write(fileName, datasetPath, data, h5writeArgs{:});

% is data size has an empty dimension, chunk size should be specified
else
    
    % if dataset already exists, delete it
    if h5exists(fileName, datasetPath); h5deleteGroup(fileName, datasetPath); end;
    
    % get the chunk size as the size divided by ten
    chunkSize = fix(dim / 10);
    % set the dimensions that are 0 to 1
    chunkSize(chunkSize == 0) = 1;
    % create the data set with an infinite size and data type 'double' since an empty array is a double
    h5create(fileName, datasetPath, inf(1 : ndims(dim)), 'ChunkSize', chunkSize, 'DataType', 'double', ...
        h5createArgs{:});
    % store the original dimension of the data into an attribute
    h5writeatt(fileName, datasetPath, 'DataDim', dim2str(dim));
    
%     % write an empty cell the data set with the actual data type
%     h5write(fileName, datasetPath, [], h5writeArgs{:});
    
end;

% store the orginal data type into an attribute
h5writeatt(fileName, datasetPath, 'DataType', originalDataType);

end

% separate function to process cell-arrays and save each cell's content separately
function processCellArray(fileName, datasetPath, data, h5createArgs, h5writeArgs, ...
    CELL_MAX_DIM, DATA_TYPE_DESCR_LEN)

% linearize the cell-array (e.g. turn a 3 x 4 x 5 cell-array into a 1 x (3*4*5) = 1 * 60 cell-array
linData = data(:);
% get the number of cells
nCells = size(linData, 1);
% get a logical mask of the non-empty cells
nonEmptyCells = ~cellfun(@isempty, linData);

% if the cell-array is empty, make sure the group is created anyway 
if ~any(~cellfun(@isempty, linData));
    h5createIntermediateGroup(fileName, datasetPath);
end;

% check whether the cell array can be converted to a matrix:
% check if the array only contains chars, logicals, numerics or empty cells
isCharNumLogicOnly = ~any(~cellfun(@(c) isempty(c) || ischar(c) || islogical(c) || isnumeric(c), linData));
% check if the array only contains empty cells
isOnlyEmpty = ~any(nonEmptyCells);
% check if the dimensions of the cells do not exceed CELL_MAX_DIM
maxDimExceeded = any(cellfun(@(c) ndims(c) > CELL_MAX_DIM, linData));

% if it is only data types that can be converted into a matrix and maximum number of dimensions is not exceeded and
%   the cell-array is not empty and has cells, convert the cell array to a matrix
if isCharNumLogicOnly && ~maxDimExceeded && nCells > 0 && ~isOnlyEmpty;
    
    % get the dimensions of the data as nCells x CELL_MAX_DIM matrix
    matDim = cell2mat(cellfun(@(x) [size(x) zeros(1, CELL_MAX_DIM - numel(size(x)))], linData, 'UniformOutput', false));

    % get only the relevant matrix of dimension, e.g. take out columns with only 0 zero dimension
    matDim(:, ~any(matDim)) = [];

    % get the data types as nCells x DATA_TYPE_DESCR_LEN char matrix
    dataTypes = cell2mat(cellfun(@(x) [class(x) repmat(' ', 1, DATA_TYPE_DESCR_LEN - numel(class(x)))], linData, ...
        'UniformOutput', false));
    
    % convert everything to linearized matrix of doubles with dimensions nTotalValues x 1
    linDataDouble = cell2mat(cellfun(@(c) double(reshape(c, numel(c), 1)), linData, 'UniformOutput', false));
    
    % save the cell-array's values as a dataset of doubles
    datasetPathCell = sprintf('%s/cellArrayMat_Val', datasetPath);
    h5createwrite_wrapper(fileName, datasetPathCell, linDataDouble, h5createArgs, h5writeArgs);
    
    % save the cell-array's dimensions
    datasetPathCell = sprintf('%s/cellArrayMat_Dim', datasetPath);
    h5createwrite_wrapper(fileName, datasetPathCell, matDim, h5createArgs, h5writeArgs);
    
    % save the cell-array's data types
    datasetPathCell = sprintf('%s/cellArrayMat_DataTypes', datasetPath);
    h5createwrite_wrapper(fileName, datasetPathCell, dataTypes, h5createArgs, h5writeArgs);
    
    % write some annotation for this data set: get the dimension first
    dim = size(data);
    % write in an attribute the data type as being a matrix-cell-array
    h5writeatt(fileName, datasetPath, 'DataType', 'cellArrayMat');
    % write in an attribute the dimension of the data as a "3x4x5" string
    h5writeatt(fileName, datasetPath, 'cellArrayMat_Dim', dim2str(dim));
  
% if the cell array contains other data types
else

    % if cell-array has not only empty cells
    if ~isOnlyEmpty;
        % go through each non-empty cell save it separately
        nonEmptyCellIndexes = find(nonEmptyCells);
        for iCellLoop = 1 : numel(nonEmptyCellIndexes);
            % get the cell index
            iCell = nonEmptyCellIndexes(iCellLoop);            
            % create the path using a simple "cell_[CELL_INDEX]" path
            datasetPathCell = sprintf('%s/cell_%d', datasetPath, iCell);
            % only save cell if it is not empty
            if ~isempty(linData{iCell});
                % create/write the data set for the content of the cell, recursively
                h5createwrite_wrapper(fileName, datasetPathCell, linData{iCell}, h5createArgs, h5writeArgs);
            end;

        end;
    end;

    % write some annotation for this data set: get the dimension first
    dim = size(data);
    % write in an attribute the data type as being a cell-array
    h5writeatt(fileName, datasetPath, 'DataType', 'cellArray');
    % write in an attribute the dimension of the data as a "3x4x5" string
    h5writeatt(fileName, datasetPath, 'cellArray_Dim', dim2str(dim));
    
    % write out in a dataset the indexes of the non empty cells:
    % create the path using "cellNonEmptyIndexes"
    datasetPathNonEmptyCell = sprintf('%s/cellNonEmptyIndexes', datasetPath);
    % create/write the data set for the nonEmptyCellIndexes
    h5createwrite_wrapper(fileName, datasetPathNonEmptyCell, nonEmptyCells, h5createArgs, h5writeArgs);
    
end

end

% separate function to process structures and struct-arrays. Fields of the structure can be save either
%   as data sets or as attributes if they have "simple" values (single number, single logicals or string)
function processStruct(fileName, datasetPath, data, h5createArgs, h5writeArgs, ...
    CHAR_ATT_LIMIT, LOGICAL_ATT_LIMIT, NUMERIC_ATT_LIMIT)

% CHAR_ATT_LIMIT: maximum limit for having a string structure value written out as an attribute
% LOGICAL_ATT_LIMIT: maximum limit for having a logical structure value written out as an attribute
% NUMERIC_ATT_LIMIT: maximum limit for having a numeric structure value written out as an attribute

% if we are dealing with a single structure (not struct-array)
if numel(data) == 1;
    
    % get the field names
    names = fieldnames(data);
    % create 2 cell array for the field names:
    datasetNames = cell(1, numel(names)); % field names with "complex" value saved as data set
    attNames = cell(1, numel(names)); % field names with "simple" value saved as attributes
    
    % go through each field name
    for iName = 1 : numel(names);
        
        % get the field name and the value
        name = names{iName};
        dataVal = data.(name);
        % get the data type and the dimension of the value
        dataType = class(dataVal);
        dim = size(dataVal);
        
        % SIMPLE STRING: if it is a char with no 3rd dimension and one of the dimension is 1 and the other
        %   does not exceed CHAR_ATT_LIMIT, save as attribute
        if ischar(dataVal) && numel(dim) <= 2 && any(dim == 1) && ~any(dim > CHAR_ATT_LIMIT);
            % store the field name as being saved as attribute
            attNames{iName} = name;
            % save the value as attribute
            h5writeatt(fileName, datasetPath, sprintf('%s_Value', name), dataVal);
            % save the orginial data type as attribute
            h5writeatt(fileName, datasetPath, sprintf('%s_DataType', name), dataType);
            % save the orginial dimension as attribute (needed to restore the orientation: 1xN or Nx1)
            h5writeatt(fileName, datasetPath, sprintf('%s_Dim', name), dim2str(dim));
            
        % SIMPLE LOGICAL: if it is a logical with no 3rd dimension and one of the dimension is 1 and the other
        %   does not exceed LOGICAL_ATT_LIMIT, convert to unsigned integer 8-bit and save as attribute
        elseif islogical(dataVal) && numel(dim) <= 2 && any(dim == 1) && ~any(dim > LOGICAL_ATT_LIMIT);
            % store the field name as being saved as attribute
            attNames{iName} = name;
            % save the value as uint8 converted attribute
            h5writeatt(fileName, datasetPath, sprintf('%s_Value', name), uint8(dataVal));
            % save the orginial data type as attribute
            h5writeatt(fileName, datasetPath, sprintf('%s_DataType', name), dataType);
            % save the orginial dimension as attribute (needed to restore the orientation: 1xN or Nx1)
            h5writeatt(fileName, datasetPath, sprintf('%s_Dim', name), dim2str(dim));
            
        % SIMPLE NUMERIC: if it is a numeric with no 3rd dimension and one of the dimension is 1 and the other
        %   does not exceed NUMERIC_ATT_LIMIT, save as attribute
        elseif isnumeric(dataVal) && numel(dim) <= 2 && any(dim == 1) && ~any(dim > NUMERIC_ATT_LIMIT);
            % store the field name as being saved as attribute
            attNames{iName} = name;
            % save the value as uint8 converted attribute
            h5writeatt(fileName, datasetPath, sprintf('%s_Value', name), dataVal);
            % save the orginial data type as attribute
            h5writeatt(fileName, datasetPath, sprintf('%s_DataType', name), dataType);
            % save the orginial dimension as attribute (needed to restore the orientation: 1xN or Nx1)
            h5writeatt(fileName, datasetPath, sprintf('%s_Dim', name), dim2str(dim));
            
        % COMPLEX DATA: if it cannot be saved as attribute, save it as data set using recursion
        else
            % create the data set path using that name
            datasetPathStruct = sprintf('%s/%s', datasetPath, name);
            % store the field name as being saved as data set
            datasetNames{iName} = name;
            % create/write the data set for the value of the field, recursively
            h5createwrite_wrapper(fileName, datasetPathStruct, dataVal, h5createArgs, h5writeArgs);
            
        end;
        
    end;

    % remove the empty cells
    attNames(cellfun(@isempty, attNames)) = [];
    datasetNames(cellfun(@isempty, datasetNames)) = [];
    
    datasetNamesString = cell2str(datasetNames);
    attNamesString = cell2str(attNames);
    
    % try to get already existing field names
    try
        prevFieldsDS = h5readatt(fileName, datasetPath, 'FieldNames_DS');
        prevFieldsAtt = h5readatt(fileName, datasetPath, 'FieldNames_Att');    
        datasetNamesString = regexprep(regexprep([prevFieldsDS, ',', datasetNamesString], ',$', ''), '^,', '');
        attNamesString = regexprep(regexprep([prevFieldsAtt, ',', attNamesString], ',$', ''), '^,', '');
    catch err;
        if ~strcmp(err.identifier, 'MATLAB:imagesci:hdf5lib:libraryError');
            rethrow(err);
        end;
    end;
    
    % remove redundant IDs
    datasetNamesAll = unique(regexp(datasetNamesString, ',', 'split'), 'stable');
    datasetNamesString = regexprep(sprintf('%s,', datasetNamesAll{:}), ',$', '');
    attNamesAll = unique(regexp(attNamesString, ',', 'split'), 'stable');
    attNamesString = regexprep(sprintf('%s,', attNamesAll{:}), ',$', '');
    
    % write the data type as attribute for this structure
    h5writeatt(fileName, datasetPath, 'DataType', 'struct');
    % write both the attribute-saved and the dataset-saved field names as comma-separated string attributes
    h5writeatt(fileName, datasetPath, 'FieldNames_DS', datasetNamesString);
    h5writeatt(fileName, datasetPath, 'FieldNames_Att', attNamesString);

% if we have 0 or more than an element, process as a struct-array
else
    
    % linearize the struct-array (e.g. turn a 3 x 4 x 5 cell-array into a 1 x (3*4*5) = 1 * 60 cell-array
    linData = data(:);
    
    % go trough each structure an save it separately
    for iStruct = 1 : numel(linData);
        % only save non-empty structures
        if any(~structfun(@isempty, linData(iStruct)))
            % create the path using a simple "struct_[STRUCT_INDEX]" path
            datasetPathStruct = sprintf('%s/struct_%d', datasetPath, iStruct);
            % create/write the data set for the single structure, recursively
            h5createwrite_wrapper(fileName, datasetPathStruct, linData(iStruct), h5createArgs, h5writeArgs);
        end;
    end;
    
    % write some annotation for this data set: get the dimension and the field names
    dim = size(data);
    
    % if the struct-array is empty, make sure the the group is created anyway
    if isempty(data);
        h5createIntermediateGroup(fileName, datasetPath);
    end;
    
    % get the field names of the structure(s)
    names = fieldnames(data);
        
    % write in an attribute the data type as being a struct-array
    h5writeatt(fileName, datasetPath, 'DataType', 'structArray');
    % write in an attribute the dimension of the data as a "3x4x5" string
    h5writeatt(fileName, datasetPath, 'struct_Dim', dim2str(dim));
    % write in an attribute the filed names as a comma-separated string
    h5writeatt(fileName, datasetPath, 'FieldNames', cell2str(names));
    
end;

end
