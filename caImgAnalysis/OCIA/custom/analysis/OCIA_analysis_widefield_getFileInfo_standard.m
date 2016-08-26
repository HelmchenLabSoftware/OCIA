function [filePath, datasetPath, dataDatasetPath, refImg, datasetDim, frameRate, chunkSize, stimIDs, iStim] ...
    = OCIA_analysis_widefield_getFileInfo_standard(this, iRow, noRefImg)
% OCIA_analysis_widefield_getFileInfo_standard - [no description]
%
%       [filePath, datasetPath, framesDatasetPath, refImg, datasetDim, frameRate, chunkSize, stimIDs, iStim] = OCIA_analysis_widefield_getFileInfo_standard(this, iRow, noRefImg)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

ANShowHideMessage(this, 1, 'Getting dataset informations ...');

% no rows created yet, row number is actually file number
if isempty(this.an.selectedTableRows);
    iFile = iRow;
    iStim = [];
    
else
    rowLabels = get(this.GUI.handles.an.rowList, 'String');
    % find file number
    fileIDs = regexprep(rowLabels, '^\w+ - (?<fileID>\w+) - .+$', '$1');
    uniqueFileIDs = unique(fileIDs, 'stable');
    iFile = find(strcmp(fileIDs{iRow}, uniqueFileIDs));
    % find stim number
    stimIDs = regexprep(rowLabels, '^\w+ - \w+ - (?<stimID>\w+)$', '$1');
    uniqueStimIDs = unique(stimIDs, 'stable');
    iStim = find(strcmp(stimIDs{iRow}, uniqueStimIDs));
    
end;

% get the data in memory
hashStruct = struct('path', this.path.intrSave, 'iFile', iFile, 'dataType', 'WFFileInfoStd');
cachedData = ANGetCachedData(this, 'wf', hashStruct);

% if the data is not in cache yet, generate it
if isempty(cachedData);
    
    % get files from directiory
    dataFiles = dir([this.path.intrSave '*.h5']);
    filePath = [this.path.intrSave, dataFiles(iFile).name];

    %% get the dataset path
    datasetPath = '/';
    % animalID
    dataStruct = h5info(filePath, datasetPath);
    datasetPath = dataStruct.Groups(1).Name;
    % dayID
    dataStruct = h5info(filePath, datasetPath);
    datasetPath = dataStruct.Groups(1).Name;
    % dataset ID
    dataStruct = h5info(filePath, datasetPath);
    datasetPath = dataStruct.Groups(1).Name;
    % get the datasets
    refDatasetPath = [datasetPath, '/ref'];
    dataDatasetPath = [datasetPath, '/data'];

    %% dataset infos
    dataStruct = h5info(filePath, dataDatasetPath);
    datasetDim = dataStruct.Dataspace.Size;
    chunkSize = dataStruct.ChunkSize;
    
    stimIDs = regexp(h5readatt(filePath, datasetPath, 'stimIDs'), ',', 'split');
    frameRate = h5readatt(filePath, datasetPath, 'frameRate');
        
    % store the variables in the cached structure
    cachedData = struct('filePath', filePath, 'datasetPath', datasetPath, 'dataDatasetPath', dataDatasetPath, ...
        'refDatasetPath', refDatasetPath, 'datasetDim', datasetDim, 'frameRate', frameRate, 'chunkSize', chunkSize, ...
        'stimIDs', { stimIDs }, 'dataType', 'WFFileInfoStd', 'params', hashStruct);
    % store the data in memory
    ANStoreCachedData(this, 'wf', hashStruct, cachedData);
    
% if data was directly in memory, fetch it
else
    
    % fetch the data
    ANShowHideMessage(this, 1, 'Loading data from cache ...');
    filePath = cachedData.filePath;
    datasetPath = cachedData.datasetPath;
    refDatasetPath = cachedData.refDatasetPath;
    dataDatasetPath = cachedData.dataDatasetPath;
    frameRate = cachedData.frameRate;
    chunkSize = cachedData.chunkSize;
    datasetDim = cachedData.datasetDim;
    stimIDs = cachedData.stimIDs;

end;

%% get reference image
try
    if ~exist('noRefImg', 'var') || ~noRefImg;
        refImg = h5read(filePath, refDatasetPath);
        % rotate image if needed
        if this.an.wf.imRotationAngle;
            refImg = imrotate(refImg, this.an.wf.imRotationAngle, 'bilinear', 'crop');
        end;
    else
        refImg = [];
    end;
catch err;
    refImg = [];
    showWarning(this, sprintf('OCIA:%s:RefImgNotFound', mfilename()), sprintf('Could not load reference image ("%s").', err.identifier));    
end;

end