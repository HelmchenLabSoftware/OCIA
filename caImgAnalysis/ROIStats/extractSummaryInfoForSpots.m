function extractSummaryInfoForSpots(animalID)

dbgLevel = 4;
extractAllTic = tic; % for performance timing purposes
%% Get days with spots
year = '2013'; % leave this as a string, not a number
rawDataRootPath = 'W:\Neurophysiology\RawData\Balazs_Laurenczy\';
analysisRootPath = 'W:\Neurophysiology\Projects\Auditory\Analysis\AuditoryLearning\';
% analysisRootPath = 'D:\Balazs\';
% analysisRootPath = 'C:\Users\laurenczy.HIFO\Documents\LocalData\';
analysisRootPath = [analysisRootPath year '\' animalID '\'];
o('#extractSummaryInfoForSpots(): animalID = %s.', animalID, 1, dbgLevel);
o('#extract...ForSpots(): rawDataRootPath = "%s".', rawDataRootPath, 3, dbgLevel);
o('#extract...ForSpots(): analysisRootPath = "%s".', analysisRootPath, 3, dbgLevel);
% get all days with at least 1 "spot**" folder inside for this mouse
daysWithSpot = getDaysWithSpot(year, rawDataRootPath, animalID, 0);
o('#extract...ForSpots(): Found %d day(s) with spot for animal %s.', ...
    numel(daysWithSpot), animalID, 2, dbgLevel);
% restrict the running to specific day(s), spot(s), run(s). Can be set to 0 to run all or
% can be set to single number: targetDays = 2; or to a list: targetSpots = [2 3 5];
targetDays = 0;
targetSpots = 0;
nChans = 3;
colorVector = [1 2 0];
%% Process each day
for iDay = 1 : numel(daysWithSpot);
    dayTic = tic; % for performance timing purposes
    
    % only target day(s)
    if any(targetDays) && ~any(targetDays == iDay); continue; end;
    
    %% Experiment info
    day = daysWithSpot(iDay);
    notebookFileName = day.notebookFileName;
    % list of spots with short name in notebook file
    spotList = day.spotList;
    currentDate = day.day;
    
    o('#extract...ForSpots(): Processing day %s with %d spot(s).', currentDate, size(spotList, 1), 2, dbgLevel);
    %% Input files
    fullRawDataPath = [rawDataRootPath year filesep animalID filesep currentDate];
    stimFile = [fullRawDataPath filesep 'CaImgExp_' currentDate '.mat'];
    % perform analysis in different directory than the raw data directory
    analysisPath = [analysisRootPath currentDate];
    % load CaImgExp
    CaImgExpMat = load(stimFile);
    
    allZipFiles = [];
    % fetch all zip files
    for iSpot = 1 : size(spotList, 1);
        % only target spot(s)
        if any(targetSpots) && ~any(targetSpots == iSpot); continue; end;
        analysisSpotPath = [analysisPath, filesep, spotList{iSpot, 1}, filesep];
        
        allZipFiles = [allZipFiles dir([analysisSpotPath '*.zip'])]; %#ok<*AGROW>
    end;
    
    refNamesWithRoiSet = cell(numel(allZipFiles), 1);
    for iStruct = 1 : numel(allZipFiles);
        refNamesWithRoiSet{iStruct} = regexprep(allZipFiles(iStruct).name, '__RoiSet.zip', '');
    end;
    
    % read the HelioScan notebook text file and generate and "experiment info" cell array where
    % each row is a different recording (reference image or movie)
    expInfo = prepare4dataImport(notebookFileName, spotList, refNamesWithRoiSet, 1, 1, 1);
    o('  #extract...ForSpots(): %s: Experiment info generated.', currentDate, 3, dbgLevel);
    
    % import each spot
    for iSpot = 1 : size(spotList, 1);
        spotTic = tic; % for performance timing purposes
        
        % only target spot(s)
        if any(targetSpots) && ~any(targetSpots == iSpot); continue; end;
        
        % load stims
        iSpotInCaImgExp = str2double(strrep(spotList{iSpot, 2}, 'sp', ''));
        spotInfo = CaImgExpMat.CaImgExp.spots{iSpotInCaImgExp};
        % skip if that spot was not created on that day
        if isempty(spotInfo);
            o('    #extract...ForSpots(): %s: skipping spot %d as it is empty.', currentDate, iSpot, 2, dbgLevel);
            continue;
        end;
        spotID = spotList{iSpot, 1}; % for example 'spot01'
        
        analysisSpotPath = [analysisPath, filesep, spotID];
        rawSpotPath = [fullRawDataPath, filesep, spotList{iSpot, 1}, filesep];
        
        allRefs = expInfo(strcmp(expInfo(:, 1), spotID) & ~cellfun(@isempty, strfind(expInfo(:, 2), 'Ref256x')), :);
        refsWithROIs = expInfo(strcmp(expInfo(:, 1), spotID) & ~cellfun(@isempty, strfind(expInfo(:, 2), 'Ref256x')) & ...
            cell2mat(expInfo(:, 8)), :);
        
        % read the data from all channels
        for iRef = 1 : size(allRefs, 1);
            refName = allRefs{iRef, 3};
            refFullFileName = sprintf('%s%s%s%s__channel__CHANNUM__.tif', ...
                    rawSpotPath, refName, filesep, refName);
            RGBImage = getMergedImage(refFullFileName, nChans, colorVector);
            rawDataMousePath = [rawDataRootPath year filesep animalID filesep];
            zoomedOutStr = '';
            if allRefs{iRef, 9}; zoomedOutStr = 'zoomOut_'; end;
            saveName = sprintf('%s%s_%s_%s%dum_%04.1fLI_z%03.1f_RGBRef', rawDataMousePath, spotID, day.day, ...
                zoomedOutStr, spotInfo.depth, allRefs{iRef, 6}, allRefs{iRef, 7});
            saveName = strrep(saveName, '.', 'p');
%             size(RGBImage.data);
            write_to_tif(RGBImage, saveName);
        end;
        
%         % read the data from all channels
%         for iRef = 1 : size(refsWithROIs, 1);
%             refName = refsWithROIs{iRef, 3};
%             refFullFileName = sprintf('%s%s%s%s__channel__CHANNUM__.tif', ...
%                     rawSpotPath, refName, filesep, refName);
%             RGBImage = getMergedImage(refFullFileName, nChans, colorVector);
%             img = RGBImage.data;
%             
%             ROISetFileName = '';
%             for iStruct = 1 : numel(allZipFiles);
%                 if strfind(allZipFiles(iStruct).name, refName);
%                     ROISetFileName = allZipFiles(iStruct).name;
%                     break;
%                 end;
%             end;
%             
%             imgDims = [size(img, 1) size(img, 2)];
%             ROISetFullFileName = sprintf('%s%s%s', analysisSpotPath, filesep, ROISetFileName);
%             ROISet = ij_roiDecoder(ROISetFullFileName, imgDims);
%             
%             figHand = doROIRGBPlot(imgDims, ROISet, img, {img(:, :, 2)}, refsWithROIs{iRef, 3}, 0.8);
%             title(refsWithROIs{iRef, 3}, 'Interpreter', 'none');
%             rawDataMousePath = [rawDataRootPath year filesep animalID filesep];
%             saveName = sprintf('%s%s_%s_RGBRef_withROI.png', rawDataMousePath, spotID, day.day);
%             saveas(figHand, saveName);
%             close(figHand);
%         end;
        
        % get the surface stack and do the sum of the frames
        surfStack = expInfo(strcmp(expInfo(:, 1), spotID) & ~cellfun(@isempty, strfind(expInfo(:, 2), 'surface')) & ...
            ~cellfun(@isempty, strfind(expInfo(:, 4), '3D stack')), :);
        if ~isempty(surfStack);
            surfStackName = surfStack{1, 3};
            surfStackFullFileName = sprintf('%s%s%s%s__channel__CHANNUM__.tif', ...
                    rawSpotPath, surfStackName, filesep, surfStackName);
            RGBImage = getMergedImage(surfStackFullFileName, nChans, colorVector);
            RGBImage.data = sum(RGBImage.data, 3) ./ size(RGBImage.data, 3);
            RGBImage.data = linScale(PseudoFlatfieldCorrect(RGBImage.data), 0, 2 ^ 16);
            saveName = sprintf('%s%s_%s_surface', rawDataMousePath, spotID, day.day);
            write_to_tif(RGBImage, saveName);
        end;
        
        
        o('    #extract...ForSpots(): %s - %s: written out all references (%.2f seconds).', currentDate, spotID, ...
            toc(spotTic), 2, dbgLevel);
    end
    o('  #extract...ForSpots(): %s: extracted data (%.2f seconds).', currentDate, ...
        toc(dayTic), 1, dbgLevel);
end;
o('#extractSummaryInfoForSpots(): extracted all data for "%s" (%.2f seconds).', ...
    animalID, toc(extractAllTic), 1, dbgLevel);
end

function RGBImage = getMergedImage(refFullFileName, nChans, colorVector)

refImg = cell(nChans, 1);
for iChan = 0 : nChans - 1;
    fileName = strrep(refFullFileName, '__CHANNUM__', sprintf('%02d', iChan));
    if ~exist(fileName, 'file');
        refImg{iChan + 1} = zeros(256, 256);
    else
        tiffStruct = tiffread2_wrapper(fileName);
        refImg{iChan + 1} = tiffStruct.data;
    end;
end;
% merge the channels
RGBImage    = struct();
red         = zeros(size(refImg{1}));
green       = zeros(size(refImg{1}));
blue        = zeros(size(refImg{1}));
if colorVector(1); red = linScale(refImg{colorVector(1)}); end;
if colorVector(2); green = linScale(refImg{colorVector(2)}); end;
if colorVector(3); blue = linScale(refImg{colorVector(3)}); end
RGBImage.data = cat(3, red, green, blue);
end
