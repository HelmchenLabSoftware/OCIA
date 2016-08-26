% analyse widefield imaging data

%% init

% tifFilesFolderPath = 'F:/RawData/1502_chronic/mou_bl_150217_05/2015_06_03/widefield/run001/';
% tifFilesFolderPath = 'F:/RawData/1502_chronic/mou_bl_150217_05/2015_06_09/widefield/run001/';
refFolderPath = 'C:/Users/BaL/Documents/RawData/1509_tonotopy/mou_bl_151007_01/2015_10_19/widefield_labview/ref/';
trialFilesFolderPath = 'C:/Users/BaL/Documents/RawData/1509_tonotopy/mou_bl_151007_01/2015_10_19/widefield_labview/6kHz_trigger/';

%% get reference
files = dir(refFolderPath);
files(1 : 2) = [];
% open the file, load the binary content and close it
fileID = fopen([refFolderPath, files(1).name]);
binData = fread(fileID, 'uint16=>double', 0, 'ieee-le.l64');
fclose(fileID);
% extract data dimension from header bits
nFrames = binData(19);
imgXYDim = [binData(83), binData(87)];
% exclude header bits
binData(1 : 116) = [];
% get the size of the imaging data and resize the read data into the appropriate format
nRealFrames = floor(numel(binData) / prod(imgXYDim));
nRealBytes = prod(imgXYDim) * nRealFrames;
refData = reshape(binData(1 : nRealBytes), imgXYDim(1), imgXYDim(2), nRealFrames);
refData = permute(refData, [2 1 3]); % rearrange order of image (transpose)
% crop image
refData = refData(251 : 400, 151 : 320, :);

%% extract trials
files = dir(trialFilesFolderPath);
files(1 : 2) = [];

nMaxTrials = 30;
nBaseFrames = 5;

% 4D matrix: trials x frames x X x Y
data = zeros(0, 0, 0, 0);

for iFile = 1 : numel(files);
    
    fileName = files(iFile).name;
    filePath = [trialFilesFolderPath, fileName];
    
    if isdir(filePath); continue; end;
    
    regexpHit = regexp(fileName, '^(?<day>\d{8})_(?<time>\d{6})_(?<iTrial>\d+)$', 'names');
    iTrial = str2double(regexpHit.iTrial);
    
    % for memory reasons, abort at trial "nMaxTrials"
    if iTrial > nMaxTrials; break; end;
    
    % open the file, load the binary content and close it
    fileID = fopen(filePath);
    binData = fread(fileID, 'uint16=>double', 0, 'ieee-le.l64');
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
    trialData = trialData(251 : 400, 151 : 320, :);
    
    % background subtract
    trialData = trialData - prctile(trialData(:), 0.5);
    trialData(trialData < 0) = 0;
    
    if ~exist('refImg', 'var');
        refImg = nanmean(trialData, 3);
        refImgSD = nanstd(trialData, [], 3);
    else
        refImg = (refImg + nanmean(trialData, 3)) / 2;
        refImgSD = (refImgSD + nanstd(trialData, [], 3)) / 2;
    end;
    
    % calculate DFF
    F0 = nanmean(trialData(:, :, 1 : nBaseFrames), 3);
    F0 = repmat(F0, 1, 1, nRealFrames);
    DFFData = 100 * (trialData - F0) ./ F0;
    
    data(iTrial, :, :, :) = DFFData;
    
    o('Loaded trial %02d.', iTrial, 0, 0);
    
end;

clear binData trialData DFFData F0 files;

% get size of dataset 
[nTrials, imDimY, imDimX, nFrames] = size(data);

%% create ROI

nROIs = 5 ^ 2;

% display image
% imagesc(refImgSD);
imagesc(refImg);
refImgCol = refImg;

ROIMasks = false(imDimY, imDimX, nROIs);

iROI = 1;
for iROIX = 1 : sqrt(nROIs);
    for iROIY = 1 : sqrt(nROIs);
        wROI = round(imDimX / sqrt(nROIs));
        hROI = round(imDimY / sqrt(nROIs));
        ROIMasks((iROIY - 1) * hROI + 1 : iROIY * hROI, ...
            (iROIX - 1) * wROI + 1 : iROIX * wROI, iROI) = true;
        refImgCol((iROIY - 1) * hROI + 1 : iROIY * hROI, ...
            (iROIX - 1) * wROI + 1 : iROIX * wROI) = iROI;
        iROI = iROI + 1;
    end;
end;


imagesc(refImgCol);

% % draw ROI
% hROI = imfreehand(gca);
% maskROI = hROI.createMask();
% delete(hROI);
close(gcf);

%% extract time-serie for each trial
traceData = zeros(nTrials, nROIs, nFrames);
for iTrial = 1 : nTrials;
    for iROI = 1 : nROIs;
        traceData(iTrial, iROI, :) = nanmean(GetRoiTimeseries( ...
            squeeze(data(iTrial, :, :, :)), squeeze(ROIMasks(:, :, iROI))));
        if any(abs(traceData(iTrial, iROI, :)) > 30);
            traceData(iTrial, iROI, :) = NaN;
        end;
    end;
end;

%% visualize data
figure('Name', 'DFF traces');
for iROI = 1 : nROIs;
    subplot(sqrt(nROIs), sqrt(nROIs), iROI);
    hold on;
    for iTrial = 1 : nTrials;
        plot(squeeze(traceData(iTrial, iROI, :)), 'Color', 0.7 * [1 1 1], 'LineStyle', ':');
    end;
    plot(nanmean(squeeze(traceData(:, iROI, :)), 1), 'r', 'LineWidth', 2);
    hold off;
end;


%%
%{
trialMeanData = squeeze(nanmean(data, 1));

refImg = squeeze(linScale(data(1, :, :, 1)));

F0 = nanmean(trialMeanData(:, :, :), 3);
DFFData = (trialMeanData - repmat(F0, 1, 1, 80)) ./ repmat(F0, 1, 1, 80);
%}