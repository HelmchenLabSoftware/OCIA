function [filePath, datasetPath, framesDatasetPath, refImg, framesDim, frameRate, chunkSize, pitchLims, recordDur, attribs] ...
    = OCIA_analysis_widefield_getFileInfo(this, iFile, noRefImg)
% OCIA_analysis_widefield_getFileInfo - [no description]
%
%       [filePath, datasetPath, framesDatasetPath, refImg, framesDim, frameRate, chunkSize, pitchLims, ...
%           recordDur, attribs] = OCIA_analysis_widefield_getFileInfo(this, iFile, noRefImg)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

ANShowHideMessage(this, 1, 'Getting dataset informations ...');

% get the data in memory
hashStruct = struct('path', this.path.intrSave, 'iFile', iFile, 'dataType', 'WFFileInfo');
cachedData = ANGetCachedData(this, 'wf', hashStruct);

% if the data is not in cache yet, generate it
if isempty(cachedData);
    
    % check where to get the path from
    if ~isempty(this.an.selectedTableRows) && ischar(get(this, this.an.selectedTableRows, 'path')) ...
            || iscell(get(this, this.an.selectedTableRows, 'path'));
        
        filePath = get(this, iFile, 'path');
        
    else
    
        % get files from directiory
        dataFiles = dir([this.path.intrSave '*.h5']);
        filePath = [this.path.intrSave, dataFiles(iFile).name];
        
    end;

    % extract the actual file information
    [filePath, datasetPath, framesDatasetPath, refImgDatasetPath, framesDim, frameRate, chunkSize, pitchLims, recordDur, attribs] ...
        = OCIA_analysis_widefield_extractFileInfo(this, filePath);
        
    % store the variables in the cached structure
    cachedData = struct('filePath', filePath, 'datasetPath', datasetPath, 'framesDatasetPath', framesDatasetPath, ...
        'refImgDatasetPath', refImgDatasetPath, 'framesDim', framesDim, 'frameRate', frameRate, 'chunkSize', chunkSize, ...
        'pitchLims', pitchLims, 'recordDur', recordDur, 'attribs', attribs, 'dataType', 'WFFileInfo', 'params', hashStruct);
    % store the data in memory
    ANStoreCachedData(this, 'wf', hashStruct, cachedData);
    
% if data was directly in memory, fetch it
else
    
    % fetch the data
    ANShowHideMessage(this, 1, 'Loading data from cache ...');
    filePath = cachedData.filePath;
    datasetPath = cachedData.datasetPath;
    refImgDatasetPath = cachedData.refImgDatasetPath;
    framesDatasetPath = cachedData.framesDatasetPath;
    framesDim = cachedData.framesDim;
    frameRate = cachedData.frameRate;
    chunkSize = cachedData.chunkSize;
    pitchLims = cachedData.pitchLims; 
    recordDur = cachedData.recordDur;
    attribs = cachedData.attribs;

end;

%% get reference image
try
    if exist('noRefImg', 'var') && noRefImg;
        refImg = [];
        
    elseif ~isempty(regexp(filePath, 'exp\d+_', 'once'));
        refFilePath = regexprep(filePath, 'exp\d+_\w+$', 'exp00_reference/Tiff_files/Trial1frame1');
        refImg = double(imresize(imread(refFilePath), 0.5));
        
    elseif ~isempty(regexp(filePath, 'stim_trial\d+\.mat', 'once'));
        refFilePath = regexprep(filePath, 'stim_trial\d+\.mat$', 'refImg.mat');
        refImgMat = load(refFilePath);
        refImg = refImgMat.refImg;
        
    elseif ~isempty(regexp(filePath, 'cond_\w+_average\.mat$', 'once'));
        refFilePath = regexprep(filePath, 'cond_\w+_average\.mat$', 'refImg.mat');
        refImgMat = load(refFilePath);
        refImg = refImgMat.refImg';
        
    else
        refImg = h5read(filePath, refImgDatasetPath);
        % rotate image if needed
        if this.an.wf.imRotationAngle;
            refImg = imrotate(refImg, this.an.wf.imRotationAngle, 'bilinear', 'crop');
        end;
        
    end;
catch err;
    refImg = [];
    showWarning(this, sprintf('OCIA:%s:RefImgNotFound', mfilename()), sprintf('Could not load reference image ("%s").', err.identifier));    
end;

end