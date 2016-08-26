% convert binary DCIMG files to HDF5 for widefield

%% init paths
% rootPath = 'F:/RawData/1509_tonotopy/mou_bl_151007_01/2015_10_19/widefield_labview/';
rootPath = 'F:/RawData/1509_tonotopy/mou_bl_151007_02/2015_10_21/widefield_labview/';
% rootPath = 'C:/Users/BaL/Documents/RawData/1509_tonotopy/mou_bl_151007_01/2015_10_19/widefield_labview/';
dataName = '20151021_170400_6freqs_200frames_50trials_50Hz_256x256';

dataFolderNames = { '4kHz', '8kHz', '16kHz', '32kHz', '64kHz', '96kHz', 'ref' };
dataFilesFolderPath = cellfun(@(folderName) sprintf('%s%s/', rootPath, folderName), dataFolderNames, 'UniformOutput', false);
h5FilePath = [rootPath dataName '.h5'];

datasetPathRoot = '/mou_bl_151007_02/2015_10_21/20151021_170400/';
datasetPathData = [datasetPathRoot 'data'];
datasetPathRef = [datasetPathRoot 'ref'];

% X * Y * nFrames * nTrials * nFreqs
datasetSize = [200 200 200 50 6];
frameRate = 50;

% define a cropping rectangle
cropRect = [140 190 200 200];

% create dataset
h5create(h5FilePath, datasetPathData, datasetSize, 'ChunkSize', [16 16 10 1 1], 'Deflate', 1, 'DataType', 'uint16');
stimIDs = regexprep(dataFolderNames, '_trigger', '');
stimIDs(strcmp(stimIDs, 'ref')) = [];
stimIDsString = regexprep(sprintf('%s,', stimIDs{:}), ',$', '');
h5writeatt(h5FilePath, datasetPathRoot, 'stimIDs', stimIDsString);
h5writeatt(h5FilePath, datasetPathRoot, 'frameRate', frameRate);

%% extract trials
for iFolder = 1 : numel(dataFilesFolderPath);
    
    folderPath = dataFilesFolderPath{iFolder};
    files = dir(folderPath);
    files(1 : 2) = [];

    for iFile = 1 : numel(files);

        % get file name and trial number
        fileName = files(iFile).name;
        filePath = [folderPath, fileName];
        if isdir(filePath); continue; end;
        regexpHit = regexp(fileName, '^(?<day>\d{8})_(?<time>\d{6})_(?<iTrial>\d+)$', 'names');
        if isempty(regexpHit); continue; end;
        iTrial = str2double(regexpHit.iTrial);

        % open the file, load the binary content and close it
        fileID = fopen(filePath);
        binData = fread(fileID, 'uint16=>uint16', 0, 'ieee-le.l64');
        fclose(fileID);
        % extract data dimension from header bits
        nFrames = binData(19);
        imgXYDim = [binData(83), binData(87)];
        % exclude header bits
        binData(1 : 116) = [];

        % get the size of the imaging data and resize the read data into the appropriate format
        nRealFrames = floor(numel(binData) / prod(imgXYDim));
        if nFrames ~= nRealFrames;
            o('Aborted trial %02d: frame number mismatch: expected = %02d, found = %02d', iTrial, nFrames, nRealFrames, 0, 0);
            continue;
        end;
        nRealBytes = prod(imgXYDim) * nRealFrames;
        trialData = reshape(binData(1 : nRealBytes), imgXYDim(1), imgXYDim(2), nRealFrames);
        trialData = permute(trialData, [2 1 3]); % rearrange order of image (transpose)

        % crop image
        trialData = trialData(cropRect(2) + (0 : cropRect(4) - 1), cropRect(1) + (0 : cropRect(3) - 1), :);

        % reference image
        if ~isempty(regexp(folderPath, '/ref/$', 'once'));
            % create dataset
            h5create(h5FilePath, datasetPathRef, datasetSize(1 : 2), 'ChunkSize', [16 16], 'Deflate', 1, 'DataType', 'uint16');
            h5write(h5FilePath, datasetPathRef, uint16(nanmean(trialData, 3)));
         
        % normal trial
        else        
            % store
            h5write(h5FilePath, datasetPathData, trialData, [1 1 1 iTrial iFolder], [datasetSize(1 : 3) 1 1]);
            
        end;

        o('#%s: Loaded %s - trial %02d.', mfilename(), dataFolderNames{iFolder}, iTrial, 0, 0);

    end;
end;