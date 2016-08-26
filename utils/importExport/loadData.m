function [data, metadata] = loadData(varargin)
% loadData  Loads imaging data/meta-data from a folder.
%
% Usage:
% [data, metadata] = loadData(varargin)
%
% PARAMETERS (stars '*' indicate REQUIRED parameters):
% dataPath*         path to the folder where the data is stored
% skipMeta          determines whether to skip reading/processing the meta-data for this data path
% imgXYDim          X-Y dimensions of the imaging data's frames. If empty, this will be filled in when reading the
%                       metadata (e.g. xml header file)
% nMaxFrameLoad     maximum number of frames to load. If -1, all frames are loaded.
% zeroToNaN         tells whether to change 0-value pixels to NaN when loading images.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Originally created on           14 / 03 / 2013 %
% Written by B. Laurenczy (blaurenczy@gmail.com) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% # - loadData: parse inputs
% prepare the input parser object with the requested inputs
IP = inputParser;
% path to the folder where the data is stored
addRequired(IP, 'dataPath',                 @(p) ischar(p) && exist(p, 'dir'));
% determines whether to skip reading/processing the meta-data for this data path
addOptional(IP, 'skipMeta',         false,  @islogical);
% X-Y dimensions of the imaging data's frames. If empty, this will be filled in when 
%   reading the metadata (e.g. xml header file)
addOptional(IP, 'imgXYDim',         [],     @(x) isnumeric(x) && numel(x) > 1);
% maximum number of frames to load. If -1, all frames are loaded.
addOptional(IP, 'nMaxFrameLoad',    -1,     @isnumeric);
% tells whether to change 0-value pixels to NaN when loading images
addOptional(IP, 'zeroToNaN',        false,   @islogical);

% parse the inputs
parse(IP, varargin{:});

% copy out the variables
dataPath = IP.Results.dataPath;
skipMeta = IP.Results.skipMeta;
nMaxFrameLoad = IP.Results.nMaxFrameLoad;
imgXYDim = IP.Results.imgXYDim;
zeroToNaN = IP.Results.zeroToNaN;

files = dir(dataPath); % get the content of the folder
files(arrayfun(@(x)~isempty(regexp(x.name, '^\.+$', 'once')), files)) = []; % remove '.' and '..'
nFiles = numel(files);

% store the data and the meta-data into cell arrays
data = cell(nFiles, 1);
metadata = cell(nFiles, 1);

%% # - loadData: process files
% go through each file and load the content of it
iData = 1;
iMetaData = 1;
for iFile = 1 : nFiles;
    fileName = files(iFile).name; % get the name of the file
    fullFileName = fullfile(dataPath, fileName); % get the full file name (full path)
    dataExt = cell2mat(regexp(fileName, '\w+$', 'match')); % get the extension of the file
    
    % figure the data type out from the folder's content and the data file's extension
    switch dataExt;
        
        %% # -- loadData: process files: xml meta-data from imaging
        case 'xml';
            
            % skip reading the meta file if not requested so
            if skipMeta; continue; end;
            
            % create a default metadata structure
            metadata{iMetaData} = struct('dimTag', [], 'laserInt', [], 'zoom', [], 'frameRate', [], 'zStep', []);
            
            % check if the file is empty
            fileInfo = dir(fullFileName);
            % skip reading the file if it is empty
            if fileInfo.bytes == 0; continue; end;
            
            % catch XML read errors
            try
                DOMnode = xmlread(fullFileName);
            catch xmlReadErr;
                warning('loadData:XMLReadError', 'Problem reading XML from file "%s" (error ID = %s): %s', ...
                    fullFileName, xmlReadErr.identifier, xmlReadErr.message);
                continue;
            end;
            
            if isempty(imgXYDim); % only override if empty
                imgXYDim = [str2double(DOMnode.getElementsByTagName('ResolutionX').item(0).getTextContent()), ...
                    str2double(DOMnode.getElementsByTagName('ResolutionY').item(0).getTextContent())];
            end;

            % use dimensions from the xml file
            metadata{iMetaData}.dimTag = sprintf('%dx%dx%d', imgXYDim, floor(files(1).bytes / (prod(imgXYDim) * 2)));
            metadata{iMetaData}.laserInt = sprintf('%.1f', ...
                str2double(DOMnode.getElementsByTagName('Intensity').item(0).getTextContent()));
            metadata{iMetaData}.zoom = char(DOMnode.getElementsByTagName('Zoom').item(1).getTextContent());
            metadata{iMetaData}.frameRate = sprintf('%.2f', ...
                str2double(DOMnode.getElementsByTagName('FrameScanRate').item(0).getTextContent()));
            metadata{iMetaData}.zStep = char(DOMnode.getElementsByTagName('StepSize').item(0).getTextContent());
            
            % update the counter
            iMetaData = iMetaData + 1;

        %% # -- loadData: process files: tif-images either from imaging data or from intrinsic imaging
        case 'tif';

            % read the image from the tif file
            if nMaxFrameLoad > 0; % if a frame limit exists, use it and do not read everything
                imgStruct = tiffread2_wrapper(fullFileName, 1, nMaxFrameLoad);
            elseif nMaxFrameLoad == -1; % if set to -1, load all
                imgStruct = tiffread2_wrapper(fullFileName);
            else % otherwise skip data loading
                continue;
            end;
            
            % convert zeros to NaN if required
            if zeroToNaN;
                imgStruct.data(imgStruct.data == 0) = NaN;
            end;
            
            data{iData, 1} = imgStruct.data; % store the data
            metadata{iMetaData, 1} = imgStruct.header; % store the meta-data
            iData = iData + 1;
            iMetaData = iMetaData + 1;

        %% # -- loadData: process files: binary files from imaging data
        case 'bin';

            % open the file and load the binary content
            fileID = fopen(fullFileName);
            % if a frame limit exists, do not read everything
            if nMaxFrameLoad > 0;
                binData = fread(fileID, prod(imgXYDim) * nMaxFrameLoad, 'uint16=>double', 0, 'ieee-be.l64');
            elseif nMaxFrameLoad == -1; % if set to -1, load all
                binData = fread(fileID, 'uint16=>double', 0, 'ieee-be.l64');
            else % otherwise skip data loading
                fclose(fileID);
                continue;
            end;
            
            % close the file
            fclose(fileID);
            
            % get the size of the imaging data and resize the read data into the appropriate format
            nFrames = floor(numel(binData) / prod(imgXYDim));
            nRealBytes = prod(imgXYDim) * nFrames;
            data{iData} = reshape(binData(1 : nRealBytes), imgXYDim(1), imgXYDim(2), nFrames);
            data{iData} = permute(data{iData}, [2 1 3]); % rearrange order of image (transpose)
            
            % convert zeros to NaN if required
            if zeroToNaN;
                data{iData}(data{iData} == 0) = NaN;
            end;
            
            iData = iData + 1;

        %% # -- loadData: process files: png-images either from intrinsic imaging
        case 'png';

            data{iData, 1} = imread(fullFileName);

        %% # -- loadData: process files: mat-file data, either behavior data or ROISet
        case 'mat';
            
            data{iData, 1} = load(fullFileName);

        %% # -- loadData: process files: video file
        case 'wmv';


        %% # -- loadData: process files: no extension
        otherwise

            %% # --- loadData: process files: unknown
            
    end;
        
end;

%% # - loadData: clean up empty elements
data(cellfun(@isempty, data)) = [];
metadata(cellfun(@isempty, metadata)) = [];

end
