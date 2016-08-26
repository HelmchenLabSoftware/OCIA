function data = loadDataFromHDF5(filePath, datasetPath)
% data = loadDataFromHDF5(filePath, datasetPath)
% Wrapper for the h5readAsStruct function that reads out the content of the HDF5 file as a structure and reshapes it
% to a more usable format.
%
% Written on 2014-04-07 by B. Laurenczy (blaurenczy@gmail.com)

% read the HDF5 file's content into a structure
dataStruct = h5readAsStruct(filePath, datasetPath);

% reshape it to our need
data = reshapeData(dataStruct, filePath, datasetPath);

end

% reshape each field to our need
function dataStruct = reshapeData(dataStruct, filePath, structPath)

    % if not a structure, just return the data
    if ~isstruct(dataStruct);
        return;
    end;
    
    % get the fields
    fNames = fieldnames(dataStruct);
    
    % go through each field and process it
    for iFName = 1 : numel(fNames);
        fName = fNames{iFName}; % get the field name
        
        % different processing for different field names
        switch fName;
            
            % reshape the ROISet into the 2-column cell array with col. 1 being the names and col. 2 beign the masks
            % also add the reference image and the runs validities as columns in the cell array
            % final output in the ROISet field will be a cell array with one row for each ROISet and 
            % 4 columns : { ROISet, runsValidity, refImage, ROISet's runID }
            case 'ROISet';
                
                % read as h5read_wrapper would do
                ROISetStruct = processStruct(filePath, structPath, {});                
                dataStruct.ROISet = ROISetStruct.ROISet;
                dataStruct.runsValidity = ROISetStruct.runsValidity;
                dataStruct.refImage = ROISetStruct.refImage;
                
                %{
                
                ROISetStruct = dataStruct.ROISet;
                ROINamesRuns = fieldnames(ROISetStruct.ROINames);
                
                dataStruct.ROISet = cell(numel(ROINamesRuns), 4);
                
                for iRun = 1 : numel(ROINamesRuns);
                    
                    runID = ROINamesRuns{iRun};
                    ROINames = ROISetStruct.ROINames.(runID);
                    nROIs = size(ROINames, 1);
                    masks = ROISetStruct.masks.(runID);
                    runsValidity = ROISetStruct.runsValidity.(runID);
                    nRuns = size(runsValidity, 1);
                    
                    % cast matrix of logical into cell-array of logical
                    masks = arrayfun(@(iROI)masks(:, :, iROI), 1 : nROIs, 'UniformOutput', false)';
                    % cast matrix of doubles into a cell-array of strings ... in a single line! :D Take that clarity !
                    runsValidity = arrayfun(@(iRun)char(runsValidity(iRun, :)), 1 : nRuns, 'UniformOutput', false)';
                    % cast matrix of doubles into a cell-array of strings ... in a single line! :D Take that clarity !
                    ROINames = arrayfun(@(iROI)strtrim(char(ROINames(iROI, :))), 1 : nROIs, 'UniformOutput', false)';
                    
                    % create ROISet based on the reshaped data
                    dataStruct.ROISet{iRun, 1} = [ROINames, masks];
                    dataStruct.ROISet{iRun, 2} = runsValidity;
                    dataStruct.ROISet{iRun, 3} = ROISetStruct.refImage.(runID);
                    dataStruct.ROISet{iRun, 4} = runID;
                    
                end;
                
                %}
                
            % reshape the behavior data from one structure with many fields to a structure with cell-arrays as fields, 
            % with one cell-array per field and an additional field for the runIDs
            case 'behav';
                
                behavStruct = dataStruct.behav;
                behavStructArray = structfun(@(x)x, behavStruct, 'UniformOutput', false);
                dataStruct.runIDs = regexprep(fieldnames(behavStruct), '^x', '');
                behavFields = fieldnames(behavStructArray);
                dataStruct.behav = struct();
                c = struct2cell(behavStructArray);
                for iField = 1 : numel(behavFields);
                    dataStruct.behav.(behavFields{iField}) = c(iField, :);
                end;
                
            % reshape the structure as cell-arrays (runIDs should be the same as in the 'behav' field)
            case {'caTraces', 'stim', 'exclMask'};
                
                s = dataStruct.(fName);
                sFNames = fieldnames(s);
                c = cell(numel(sFNames), 1);
                for iRun = 1 : numel(sFNames);
                    c{iRun} = s.(sFNames{iRun});
                end;
                dataStruct.(fName) = c;
                
            % otherwise go recusrive
            otherwise
                
                structPath = sprintf('%s/%s', structPath, regexprep(fName, '^x', ''));
                dataStruct.(fName) = reshapeData(dataStruct.(fName), filePath, structPath);
                
        end;
        
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
