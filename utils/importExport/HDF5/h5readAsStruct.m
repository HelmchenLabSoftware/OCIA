function data = h5readAsStruct(filePath, datasetPath, varargin)
% data = h5readAsStruct(fileName, datasetPath, h5readArgs)
% Wrapper for the h5read function that reads out the content of the HDF5 file as a structure.
% Recursively reads the data from the HDF5 file "fileName" from the dataset path "datasetPath".
% Arguments to the h5read function can be provided using the h5readArgs cell-array.

% check if file exists
if ~exist(filePath, 'file');
    error('h5readAsStruct:FileNotFound', 'Could not find the file "%s".', filePath);
end;

% remove trailing / if it is not the only character
if ~strcmp(datasetPath, '/');
    datasetPath = regexprep(datasetPath, '/$', '');
end;

% check if dataset path exists and if so, extract content
try
    cont = h5info(filePath, datasetPath);
catch err;
    error('h5readAsStruct:DatasetNotFound', 'Could not find the dataset "%s" in file "%s".', datasetPath, filePath);
end;

% remove trailing / if it is the only character
if strcmp(datasetPath, '/');
    datasetPath = regexprep(datasetPath, '/$', '');
end;

nGroups = numel(cont.Groups);
nDatasets = numel(cont.Datasets);
nAttr = numel(cont.Attributes);

% data is a structure
data = struct();

% check for "h5wrapper"-written data
if nAttr > 0;
    dataType = h5readatt(filePath, datasetPath, 'DataType');
    if ~isempty(dataType);
        data = h5read_wrapper(filePath, datasetPath, {});
    end;
    return;
end;

% extract groups as sub-structures, by going recursive
for iGroup = 1 : nGroups;
    groupDatasetPath = regexprep(cont.Groups(iGroup).Name, '/+', '/');
    fieldName = matlab.lang.makeValidName(regexprep(groupDatasetPath, [datasetPath '/'], ''));
    data.(fieldName) = h5readAsStruct(filePath, groupDatasetPath, varargin{:});
end;

% extract attributes as sub-structures
for iAttr = 1 : nAttr;
    fieldName = matlab.lang.makeValidName(cont.Attributes(iAttr).Name);
    data.(fieldName) = h5readatt(filePath, cont.Name, cont.Attributes(iAttr).Name);
end;

% extract datasets as sub-structures
for iDS = 1 : nDatasets;
    subDatasetPath = regexprep(sprintf('%s/%s', cont.Name, cont.Datasets(iDS).Name), '/+', '/');
    fieldName = matlab.lang.makeValidName(regexprep(subDatasetPath, [datasetPath '/'], ''));
    data.(fieldName) = h5read(filePath, subDatasetPath, varargin{:});
end;

end
