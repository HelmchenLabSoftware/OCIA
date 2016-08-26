function data = h5read_wrapper(filePath, datasetPath, h5readArgs)
% data = h5read_wrapper(fileName, datasetPath, h5readArgs)
% Wrapper for the h5read function that also handles cell-array, structures and struct-arrays.
% Recursively reads the data from the HDF5 file "fileName" from the dataset path "datasetPath".
% Arguments to the h5read function can be provided using the h5readArgs cell-array.

% get the data type of the data from the attribute
try
    dataType = h5readatt(filePath, datasetPath, 'DataType');
catch err;
   error('h5read_wrapper:DataTypeAttributeNotFound', ...
        'Could not find the attribute "DataType" at path "%s" in file "%s".', datasetPath, filePath);
end;

% process the different data types in different ways
switch dataType;
    
    % numeric
    case {'single', 'double', 'int8', 'uint8', 'int16', 'uint16', 'int32', 'uint32', 'int64', 'uint64'};
        
        % read out the data
        data = h5read(filePath, datasetPath, h5readArgs{:});
        
    % logical
    case 'logical';
        
        % read out the data
        data = h5read(filePath, datasetPath, h5readArgs{:});
        % convert to logical
        data = logical(data);
        
    % strings (char)
    case 'char';
        
        % read out the data
        data = h5read(filePath, datasetPath, h5readArgs{:});
        % convert to char
        data = char(data);
    
    % cell-arrays
    case 'cellArray';
        
        % cell arrays are processed in a separate function
        data = processCellArray(filePath, datasetPath, h5readArgs);
    
    % cell-arrays saved as matrix
    case 'cellArrayMat';
        
        % cell arrays are processed in a separate function
        data = processCellArrayMat(filePath, datasetPath, h5readArgs);
        
    % structures
    case 'struct';
        
        % structures are processed in a separate function
        data = processStruct(filePath, datasetPath, h5readArgs);
        
    % struct-arrays
    case 'structArray';
        
        % struct-arrays are processed in a separate function
        data = processStructArray(filePath, datasetPath, h5readArgs);
        
    % others: categorical (nominal/ordinal), tables and all kinds of weird stuff are not supported
    otherwise;
        
        warning('h5read_wrapper:DataTypeNotSupported', 'Data type "%s" is not supported.', dataType);
        
        % abort
        return;
    
end;

end

% separate function to process cell-arrays and load each cell's content separately
function data = processCellArray(fileName, datasetPath, h5readArgs)

% read the dimension of the data from the attribute as a "3x4x5" string
dim = str2dim(h5readatt(fileName, datasetPath, 'cellArray_Dim'));

% get the indexes of the non-empty cells
datasetPathNonEmptyCell = sprintf('%s/cellNonEmptyIndexes', datasetPath);
nonEmptyCells = h5read_wrapper(fileName, datasetPathNonEmptyCell, h5readArgs);

% initiate the cell-array
data = cell(dim);

% go through each non-empty cell and load it separately
for iCell = find(nonEmptyCells);
    
    % create the path using a simple "cell_[CELL_INDEX]" path
    datasetPathCell = sprintf('%s/cell_%d', datasetPath, iCell);
    % if the cell was empty, the data set was not created so skip it and leave it empty
    if ~h5exists(fileName, datasetPathCell); continue; end;
    % read the data set for the content of the cell, recursively
    data{iCell} = h5read_wrapper(fileName, datasetPathCell, h5readArgs);
    
end;

end

% separate function to process cell-arrays that are saved as matrix
function data = processCellArrayMat(fileName, datasetPath, h5readArgs)

% read the dimension of the data from the attribute as a "3x4x5" string
dim = str2dim(h5readatt(fileName, datasetPath, 'cellArrayMat_Dim'));

% extract the cell-array's values as a dataset of doubles
datasetPathCell = sprintf('%s/cellArrayMat_Val', datasetPath);
linDataMatDouble = h5read_wrapper(fileName, datasetPathCell, h5readArgs);

% extract the cell-array's dimensions
datasetPathCell = sprintf('%s/cellArrayMat_Dim', datasetPath);
matDim = h5read_wrapper(fileName, datasetPathCell, h5readArgs);

% extract the cell-array's data types
datasetPathCell = sprintf('%s/cellArrayMat_DataTypes', datasetPath);
dataTypes = h5read_wrapper(fileName, datasetPathCell, h5readArgs);

% calculate the number of values per cell by calculating the product of the dimensions
nValuesPerCell = arrayfun(@(x)prod(matDim(x, matDim(x, :) > 0)), 1 : size(matDim, 1));

% empty cells (dim = 0x0x0x...) must have a number of values of 0
nValuesPerCell(arrayfun(@(x)~any(matDim(x, :) > 0), 1 : size(matDim, 1))) = 0;

% convert back the matrix to a cell array
linDataCellDouble = mat2cell(linDataMatDouble, reshape(nValuesPerCell, numel(nValuesPerCell), 1));
nCells = size(linDataCellDouble, 1);

% create a linearized cell array with empty cells
linData = cell(nCells, 1);

% convert back the doubles into the appropriate data type and reshape the cells to their original dimensions:
% go cell by cell
for iCell = 1 : nCells;
    % if all dimensions are empty, the cell must remain empty
    if ~any(matDim(iCell, :)); continue; end;
    % cast the double into the right value
    cellValue = cast(linDataCellDouble{iCell}', strtrim(dataTypes(iCell, :)));
    % reshape the cell's content to the original dimension
    linData{iCell} = reshape(cellValue, matDim(iCell, matDim(iCell, :) > 0));
end;

% reshape the cell-array to have the original dimension
data = reshape(linData, dim);

end

% separate function to process struct-arrays and load each structure separately
function data = processStructArray(fileName, datasetPath, h5readArgs)

% read the dimension of the struct-array from the attribute as a "3x4x5" string
dim = str2dim(h5readatt(fileName, datasetPath, 'struct_Dim'));
% read the field names of the structure from the attribute as a comma-separated string
names = str2cell(h5readatt(fileName, datasetPath, 'FieldNames'));

% remove the empty cells
names(cellfun(@isempty, names)) = [];
    
% initate the struct-array using the cell2struct function. Each structure already contains the right field names
data = cell2struct(cell([numel(names), dim]), names, 1);

% go trough each structure an load it separately
for iStruct = 1 : numel(data);
    
    % create the path using a simple "struct_[STRUCT_INDEX]" path
    datasetPathStruct = sprintf('%s/struct_%d', datasetPath, iStruct);
    % if the structure was empty, the data set was not created so skip it and leave it empty
    if ~h5exists(fileName, datasetPathStruct); continue; end;
    % read the data set for a single structure, recursively
    data(iStruct) = h5read_wrapper(fileName, datasetPathStruct, h5readArgs);
end;

end

% separate function to process structures. Fields of the structure can be stored either as data 
%   sets or as attributes if they have "simple" values (single numbers, single logicals or string)
function data = processStruct(fileName, datasetPath, h5readArgs)

% read the data-set field names of the structure from the attribute as a comma-separated string
datasetNames = str2cell(h5readatt(fileName, datasetPath, 'FieldNames_DS'));
% read the attribute field names of the structure from the attribute as a comma-separated string
attNames = str2cell(h5readatt(fileName, datasetPath, 'FieldNames_Att'));

% remove the empty cells
attNames(cellfun(@isempty, attNames)) = [];
datasetNames(cellfun(@isempty, datasetNames)) = [];
    
% initate the structure
data = struct();

% go through each data-set stored field name
for iName = 1 : numel(datasetNames);
    
    % get the field name
    name = datasetNames{iName};
    % create the data set path using that name
    datasetPathStruct = sprintf('%s/%s', datasetPath, name);
    % read the data set to extract the value, recursively
    data.(name) = h5read_wrapper(fileName, datasetPathStruct, h5readArgs);
    
end;

% go through each attribute stored field name
for iName = 1 : numel(attNames);
    
    % get the field name
    name = attNames{iName};
    % load the value from the attribute
    dataVal = h5readatt(fileName, datasetPath, sprintf('%s_Value', name));
    % load the orginial data type from the attribute
    dataType = h5readatt(fileName, datasetPath, sprintf('%s_DataType', name));
    % load the orginial dimension from the attribute (to restore the orientation: 1xN or Nx1)
    dim = str2dim(h5readatt(fileName, datasetPath, sprintf('%s_Dim', name)));
    
    % nan-bug in reading dimension
    if any(isnan(dim));
        warning('h5read_wrapper:unreadableAttribute', ...
            'Cannot read attribute "%s" because dimension string is (partly) NaN', name);
        continue;
    end;
    
    % process the different data types differently
    switch dataType;
        
        % strings (char)
        case 'char';
            
            % store the value as a converted, reshaped char
            data.(name) = char(reshape(dataVal, dim));
        
        % logicals
        case 'logical';
            
            % store the value as a converted, reshaped logical
            data.(name) = logical(reshape(dataVal, dim));
        
        % numeric
        case {'single', 'double', 'int8', 'uint8', 'int16', 'uint16', 'int32', 'uint32', 'int64', 'uint64'};
            
            % store the value as a reshaped numeric
            data.(name) = reshape(dataVal, dim);
        
        % others: unknown, throw a warning
        otherwise
            
            warning('h5read_wrapper:processStruct:UnknownDataTypeValue', ...
                'Data type "%s" of field "%s" at data set path "%s" is not supported.', dataType, name, datasetPath);
            
    end;
    
end;

end
