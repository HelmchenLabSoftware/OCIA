function varargout = GetRoiStats(config)
% get ROI timecourses from images, with support for muliple ROIs and runs
% returns structure data, info and stimulus fields
% data field contains a cell array with ROI timecourses for different cells
% in rows and different runs in columns:
% [cell1_run1] [cell1_run2] ... [cell1_runN]
% [cell2_run1] [cell2_run2] ... [cell2_runN]
%     ...           ...              ...
% [cellN_run1] [cellN_run2] ... [cellN_runN]
% assume raw data structure specified as mat-files wih fields:
% img_data ... cell array for image data (each channel in one cell)
% roi ... imageJ roi set
% stim ... stimulus vector (at frame rate, i.e. 1 value per frame)
% hdr ... header information
% proc ... preprocessing information (e.g. how many frames have been deleted)

% this file written by Henry Luetcke (hluetck@gmail.com)

dbgLevel = 1;

%% GetRoiStats - Inititialization
% parse the configuration structure
config = ParseConfig(config);
o('#GetRoiStats(): %d file(s) to process...', numel(config.matFiles), 1, dbgLevel);

% init some parameters
[config, matFiles] = initParams(config, dbgLevel);
o('#GetRoiStats(): parameters initialized.', 2, dbgLevel);

% init some more parameters
nRuns = config.nRuns;
ROISet = [];
imgDims = cell(nRuns, 1);
config.runFileIDs = cell(nRuns, 1);
matFileStructs = cell(1, nRuns);

%% GetRoiStats - Create common ROISet
o('#GetRoiStats(): processing %d runs...', config.nRuns, 2, dbgLevel);
for iRun = 1 : nRuns;
    
    o('  #GetRoiStats(): processing run %d/%d (%s) ...', iRun, nRuns, matFiles{iRun}, 2, dbgLevel);
    
    % make sure the mat file exists
    if ~exist(matFiles{iRun}, 'file');
        warning('GetRoiStats:FileNotFound', 'Could not find mat-file "%s", skipping run %d.', ...
            matFiles{iRun}, iRun);
        continue;
    end;
    
    
    %% GetRoiStats --- Initialize run
    % load the mat-file for this run and store it (avoids reloading it in the next for-loop)
    % also assign a "fileID" name for that run (date + time withouth '.mat')
    fileID = strrep(matFiles{iRun}, '.mat', '');
    matFileWrapper = load(matFiles{iRun});
    matFileStruct = matFileWrapper.(genvarname(fileID));
    matFileStruct.hdr.fileID = fileID;
    config.runFileIDs{iRun} = fileID;
    matFileStructs{iRun} = matFileStruct;
    
    %% GetRoiStats --- Extract ROIs, calculate mean point and merge
    % load ROIs as a cell-array with ROI IDs and their masks
    localROISet = matFileStruct.roi;
    % process each ROI for mean (middle) point calculation
    for iLocalROI = 1 : size(localROISet, 1);
        ROIMask = localROISet{iLocalROI, 2};
        if isa(ROIMask, 'uint32');
            ROIMask = bwunpack(ROIMask);
        end;
        % calculate mean (middle) point's coordinate
        [ROIYCoords, ROIXCoords] = find(ROIMask == 1);
        localROISet{iLocalROI, 3} = [mean(ROIYCoords), mean(ROIXCoords)];
    end;
    
    % if no general ROISet is available, use the first one encountered
    if isempty(ROISet);
        ROISet = localROISet;
    % otherwise merge the ROISets
    else
        % search through each local ROISet if it exists in the global ROISet
        for iLocalROI = 1 : size(localROISet, 1);
            localROIID = localROISet{iLocalROI, 1};
            
            % if local (new) ROI doesn't exist in the global ROISet
            if ~ismember(localROIID, ROISet(:, 1));
                % add it to the global ROISet
                ROISet(end + 1, 1 : 3) = localROISet(iLocalROI, :); %#ok<AGROW>
            end;
        end;
    end;
    
end;

% add the neuropil as an ROI
[ROISet, ~] = addNPilROIToROISet(ROISet, 0.15);
% store the merged ROIs (with neuropil)
config.ROISet = ROISet;

%% GetRoiStats - Process runs
ROIStatsData = cell(size(ROISet, 1), nRuns);
o('#GetRoiStats(): processing %d runs...', config.nRuns, 2, dbgLevel);
for iRun = 1 : nRuns;
    
    % retrieve the stored matFileStruct
    matFileStruct = matFileStructs{iRun};
    fileID = config.runFileIDs{iRun};
    
    o('  #GetRoiStats(): processing run %d/%d (%s)...', iRun, nRuns, fileID, 2, dbgLevel);
    
    % initialize containers for the imaging data (recorded movies)
    currImgData = cell(1, length(config.channelVector));
    currMeanImgData = cell(1, length(config.channelVector));
    imgDims{iRun} = config.img_dims;
    
    o('    #GetRoiStats(): run %d/%d: ROIs extracted.', iRun, nRuns, 4, dbgLevel);
    
    %% GetRoiStats --- Image registration + channel switching
    % check size of movie and ROISet, must be same
    if any(size(ROISet{1, 2}) ~= matFileStruct.hdr.size(1:2));
        o('    #GetRoiStats(): run %d/%d: image registration required... (size of ROI != movie).', ...
            iRun, nRuns, 4, dbgLevel);
        matFileStruct = doImageReg(matFileStruct, config);
        imgDims{iRun} = [size(matFileStruct.img_data{1}, 1) size(matFileStruct.img_data{1}, 2)];
    end;
    o('    #GetRoiStats(): run %d/%d: image registration done.', iRun, nRuns, 3, dbgLevel);
    
    %% GetRoiStats --- Image averaging
    % image data is already arranged here as specified in channelVector. CH1 and CH2 are always
    % ordered in the same way from here to the end :
    % DFF is calculated on channel 1, DRR is ch1 / ch2
    for iChan = 1 : numel(matFileStruct.img_data)
        % make sure we have double data type (might be stored as int16 / int8)
        currImgData{iChan} = double(matFileStruct.img_data{iChan});
        % also store a mean image for display of Rois
        currMeanImgData{iChan} = mean(currImgData{iChan}, 3);
    end;
    
    %% GetRoiStats --- PseudoFlatField correct image
    if config.doFlatfield;
        % correct the image's intensity using the "PseudoFlatfieldCorrect" (gaussian filtering)
        currSegmImg = PseudoFlatfieldCorrect(currMeanImgData{1});
        currSegmImg(currSegmImg < 0) = 0;
    else
        currSegmImg = currMeanImgData{1};
    end;
    
    o('    #GetRoiStats(): run %d/%d: Pseudo-flat field correction done.', ...
        iRun, nRuns, 3, dbgLevel);
    
    
    
    %% GetRoiStats --- Check ROI presence in current run
    % reload the ROIs
    localROISet = matFileStruct.roi;
    % check the presence of each global ROI in the local ROISet
    ROISet(:, 4) = cellfun(@(ROIID){ismember(ROIID, localROISet(:, 1))}, ROISet(:, 1));
    
    %% GetRoiStats --- Plot ROIs on RGB image
    if config.doSaveROIRGBPlot;
        
        o('    #GetRoiStats(): run %d/%d: Plotting ROIs on RGB ...', iRun, nRuns, 3, dbgLevel);
        ROIRGBHand = doROIRGBPlot(imgDims{iRun}, localROISet, currSegmImg, currMeanImgData, fileID, 0.7);
        
        if config.doSaveROIRGBPlot > 1;
            if exist('ROIRGB', 'dir') ~= 7; mkdir('ROIRGB'); end;
            saveas(ROIRGBHand, sprintf('ROIRGB/%s__ROIRGB', fileID));
            saveas(ROIRGBHand, sprintf('ROIRGB/%s__ROIRGB.png', fileID));
            close(ROIRGBHand);
        end;
    end;
    
    nFrames = size(currImgData{1}, 3);
    o('    #GetRoiStats(): run %d/%d: %d frame(s).', iRun, nRuns, nFrames, 3, dbgLevel);
    
    %% GetRoiStats --- ROI and neuropil analysis
    o('    #GetRoiStats(): run %d/%d: ROI analysis...', iRun, nRuns, 3, dbgLevel);
    
    % go through each ROI (and neuropil) and extract the ROIStats from them
    for iROI = 1 : size(ROISet, 1);
        
        % if ROI was not present in this run and is not the neuropil, don't process it
        if ~strcmp('NPil', ROISet{iROI, 1}) && ~ROISet{iROI, 4}; continue; end;
        
        ROIMask = ROISet{iROI, 2};
        
        % for neuropil, use the ROIMask from the localROISet
        if strcmp('NPil', ROISet{iROI, 1});
            [localROISetWithNPil, ~] = addNPilROIToROISet(localROISet, 0.15);
            ROIMask = localROISetWithNPil{strcmp('NPil', localROISetWithNPil(:, 1)), 2};
        end;
            
        doSaveF0ExtractPlot = config.doSaveF0AndExtractPlot;
        if iROI ~= 1 && rand(1) > 0.05; % draw the plot with 5% chance
            doSaveF0ExtractPlot = 0;
        end;
        
        % store roi data
        ROIStatsData{iROI, iRun} = extractROIStats(currImgData, ROIMask, ...
            config.statsType, config.LowPass, config.HiPass, config.f0, ...
            sprintf('%s_F0AndExtract_run%d_ROI%d', config.saveName, iRun, iROI), ...
            doSaveF0ExtractPlot);
        
    end;
    
    clear ROIYCoords ROIXCoords fileID;
    
end

%% GetRoiStats - End of runs processing
% copy stuff in the config, assuming things were similar over all runs...
config.img_dims = imgDims(1);
config.ROISet = ROISet;
config.ROIStatsData = ROIStatsData;

% config.freqIDs = 1.0e+03 * [5, 9, 13, 17, 21, 25, 29, 33, 37, 41];
% config.freqIDs = 4000 * (2 .^ (((1 : 15) - 1) * 0.25));
% config.plotLimits = [-1 5];

%% GetRoiStats - Config saving
saveName = sprintf('%s_ROIStats', config.saveName);
o('    #GetRoiStats(): saving ROIStats under "%s"...', saveName, 3, dbgLevel);
SaveAndAssignInBase(config, saveName);
o('    #GetRoiStats(): ROIStats saving done.', 2, dbgLevel);
    
if nargout;
    varargout{1} = config;
end;

end


%% Function - doImageReg
function matFileStruct = doImageReg(matFileStruct, config)
% Perform non-linear registration of movie to hign resolution image
% Note that at this stage, the channel order should NOT yet be adjusted
% according to config.ChannelVector
% Registration performs the following steps:
% 1. Identify reference image channel and average multiple frames (if any)
% 2. Resize all movie channels to the xy-dims of the reference image -->
% this is the minimum processing that needs to be done, so that image
% dimensions are consistent for downstream analysis; if the reference image
% is for example the average of each movie, then registration could stop
% at this point
% 3. Average all frames of movie in registration channel
% 4. Register movie average to reference image using non-linear image
% registration tool MIRT
% 5. Check quality of the registration
% 6. Apply transformation matrix to all frames of all channels and write
% the result back into S.img_data

dbgLevel = 3;

if config.reg.doRegistration;
    o('      #GetRoiStats.doImageReg(): doing image up-sampling AND registration ...', 2, dbgLevel);
else
    o('      #GetRoiStats.doImageReg(): doing image up-sampling only (no registration) ...', 2, dbgLevel);
end;

% get the reference image using the channels specified in the config
refImg = getRefOrRegImage(matFileStruct.hdr.fileID, 'Reference', ...
    matFileStruct.refImg, config, config.reg.doSaveRefImagePlot, dbgLevel);
refDims = size(refImg);
nChan = numel(matFileStruct.img_data);
nFrames = size(matFileStruct.img_data{1}, 3);

% if no matlab pool open or in a worker, use standard for loop, other use parfor
useParfor = matlabpool('size') && isempty(javachk('desktop'));

% upsample movie to refImg
upSampleTic = tic; % for performance timing purposes
for iChan = 1 : nChan;
    o('          #Get...ImageReg(): up-sampling channel %d/%d (useParfor = %d) ...', ...
        iChan, nChan, useParfor, 2, dbgLevel);
    origCh = matFileStruct.img_data{iChan};
    upSampImg = zeros(refDims(1), refDims(2), nFrames);
    if useParfor;
        parfor iFrame = 1 : nFrames;
            upSampImg(:, :, iFrame) = imresize(origCh(:, :, iFrame), refDims);
        end;
    else
        for iFrame = 1 : nFrames;
            upSampImg(:, :, iFrame) = imresize(origCh(:, :, iFrame), refDims);
        end;
    end;
    matFileStruct.img_data{iChan} = upSampImg;
end;
o('        #Get...ImageReg(): up-sampling done (%.2f seconds).', toc(upSampleTic), 1, dbgLevel);

if ~config.reg.doRegistration; return; end;

o('        #Get...ImageReg(): registration required: doRegistration = %d.', ...
    config.reg.doRegistration, 2, dbgLevel);

% get the registration image using the registration channel(s) specified in the config
regImg = getRefOrRegImage(matFileStruct.hdr.fileID, 'Registration', ...
    matFileStruct.img_data, config, config.reg.doSaveRegImagePlot, dbgLevel);

if ~isfield(matFileStruct, 'tform') || isempty(matFileStruct.tform);
    
    o('        #Get...ImageReg(): transform matrix (tform) not present. ', 2, dbgLevel);
    o('        #Get...ImageReg(): running registration to create it ... ', 2, dbgLevel);
    tFormCreateTic = tic; % for performance timing purposes
    config.reg.main.single = config.reg.doSaveRegProgressPlot;
    config.reg.main.saveName = sprintf('%s__RegMesh', matFileStruct.hdr.fileID);
    % run registration
    [tform, newImg] = registerImages_MIRT(refImg, regImg, config.reg);
    
    % display overlay
    if config.reg.doSaveRegOverlayPlot;
        hReg = figure('Name', sprintf('Image Registration Overlay for %s', matFileStruct.hdr.fileID), ...
            'NumberTitle', 'off');
        subplot(1, 2, 1);
        imshowpair(refImg, edge(regImg,'canny'), 'method', 'blend');
        title('Reference - Input overlay');
        subplot(1, 2, 2);
        imshowpair(refImg, edge(newImg,'canny'), 'method', 'blend');
        title('Reference - Registered overlay');
        % save if required
        if config.reg.doSaveRegOverlayPlot > 1;
            if exist('RegOverlay', 'dir') ~= 7; mkdir('RegOverlay'); end;
            saveas(hReg, sprintf('RegOverLay/%s__ImgRegOvl', matFileStruct.hdr.fileID));
            saveas(hReg, sprintf('RegOverLay/%s__ImgRegOvl.png', matFileStruct.hdr.fileID));
            close(hReg);
        end;
    end;
    
    matFileStruct.tform = tform;
    
    % save tform into original mat-file (image data already resized)
    S2 = load(matFileStruct.hdr.fileID);
    data2 = S2.(genvarname(matFileStruct.hdr.fileID));
    data2.tform = tform;
    SaveAndAssignInBase(data2,matFileStruct.hdr.fileID,'SaveOnly')
    clear data2 S2;
    o('        #Get...ImageReg(): transform matrix (tform) created (%.2f seconds).', ...
        toc(tFormCreateTic), 2, dbgLevel);
else
    o('        #Get...ImageReg(): transform matrix (tform) already present.', 2, dbgLevel);
    tform = matFileStruct.tform;
end;

% apply transformation only on channels required by the channelVector
tFormApplyTic = tic; % for performance timing purposes
oriImg_data = matFileStruct.img_data;
nChanForApply = numel(config.channelVector);
matFileStruct.img_data = {}; % clear the previous data
for iChan = 1 : nChanForApply;
        
    tFormApplyChanTic = tic; % for performance timing purposes
    o('          #Get...ImageReg(): Applying transformation to channel %d (useParfor = %d) ...', ...
        config.channelVector(iChan), useParfor, 2, dbgLevel);
    origCh = oriImg_data{config.channelVector(iChan)};
    newCh = zeros(size(oriImg_data{config.channelVector(iChan)}));
    if useParfor;
        parfor iFrame = 1 : nFrames;
            [~ ,newCh(:, :, iFrame)] = registerImages_MIRT(tform, origCh(:, :, iFrame), config.reg); %#ok<PFBNS>
        end;
    else
        for iFrame = 1 : nFrames;
            [~, newCh(:, :, iFrame)] = registerImages_MIRT(tform, origCh(:, :, iFrame), config.reg);
        end;
    end;
    o('          #Get...ImageReg(): Applied transf. to chan. %d on %d frame(s) (%.2f seconds).', ...
        config.channelVector(iChan), nFrames, toc(tFormApplyChanTic), 2, dbgLevel);
    matFileStruct.img_data{iChan} = newCh;
end;
o('        #Get...ImageReg(): Applied transf. to %d channel(s) on %d frame(s) (%.2f seconds).', ...
    nChanForApply, nFrames, toc(tFormApplyTic), 1, dbgLevel);

% plot the applied transformations
if config.reg.doSaveRegComparisonPlot;
    figHand = figure('NumberTitle', 'off', 'Name', ...
        sprintf('Registration comparison for %s', matFileStruct.hdr.fileID));
    
    subplot(nChanForApply + 1, 2, 1);
    imshow(linScale(regImg), []);
    title('Registration image');
    subplot(nChanForApply + 1, 2, 2);
    imshow(linScale(refImg), []);
    title('Reference image');
    for iChan = 1 : nChanForApply;
        % plot the mean image before
        subplot(nChanForApply + 1, 2, iChan * 2 + 1);
        imshow(linScale(mean(oriImg_data{iChan}, 3)), []);
        title(sprintf('Channel %d before transformation', config.channelVector(iChan)));
        subplot(nChanForApply + 1, 2, iChan * 2 + 2);
        imshow(linScale(mean(matFileStruct.img_data{iChan}, 3)), []);
        title(sprintf('Channel %d after transformation', config.channelVector(iChan)));
    end;
    suptitle(sprintf('Registration comparison of %s', strrep(matFileStruct.hdr.fileID, '_', '\_')));
    
    % save if required
    if config.reg.doSaveRegComparisonPlot > 1;
        if exist('RegComparison', 'dir') ~= 7; mkdir('RegComparison'); end;
        saveas(figHand, sprintf('RegComparison/%s__RegComp', matFileStruct.hdr.fileID));
        saveas(figHand, sprintf('RegComparison/%s__RegComp.png', matFileStruct.hdr.fileID));
        close(figHand);
    end;
end;

for iChan = 1 : nChanForApply;
    o('        #Get...ImageReg(): Channels numbering change : chan %d / %d is now chan %d / %d.', ...
        config.channelVector(iChan), nChan, iChan, nChanForApply, 1, dbgLevel);
end;

end

%% Function - ParseConfig
function config = ParseConfig(config)
% check for missing fields in config structure and add them with default values

if ~isfield(config, 'matFiles')
    matFiles = sort(uigetfile('*.mat', 'Select Mat Files', 'MultiSelect', 'on'));
    config.matFiles = strrep(matFiles, '.mat', '');
else
    matFiles = config.matFiles;
end

if ~isfield(config,'saveName')
    config.saveName = [matFiles{1} '__ROIStats'];
end

if ~isfield(config,'statsType')
    config.statsType = 'dff';
end

% BL - 2013-06-27 : added this field because it was missing
if ~isfield(config,'roi')
    config.roi = struct;
end

% channels for stats calculation
% DFF is calculated on the channel specified by config.channelVector(1)
% DRR is calculated on the channels specified by config.channelVector(1)
% and config.channelVector(2)
if ~isfield(config,'channelVector')
    config.channelVector = [1 2];
end

if strcmpi(config.statsType,'drr') && numel(config.channelVector) < 2
    error('config.channelVector must specify at least 2 channels for DRR stats!');
end

% if ~isfield(config,'npilCorrect')
%     config.npilCorrect = 0.2;
% end
% if ~isfield(config,'recycleNpilMovie')
%     config.recycleNpilMovie = 0;
% end

if ~isfield(config,'doFlatfield')
    config.doFlatfield = 0;
end

if ~isfield(config,'doOgbSRsegmentation')
    config.doOgbSRsegmentation = 0;
end
if config.doOgbSRsegmentation
    if ~isfield(config,'OgbChannel')
        config.OgbChannel = 1;
    end
    if ~isfield(config,'SrChannel')
        config.SrChannel = 2;
    end
end
if ~isfield(config,'segOptions')
    config.segOptions = struct;
end

if ~isfield(config,'psFrames')
    config.psFrames = struct;
    config.psFrames.base = 5;
    config.psFrames.evoked = 15;
end

% low-pass filter
if ~isfield(config,'LowPass')
    config.LowPass.method = 'none';
    config.LowPass.params = [0.5 1];
end
% LowPass.method may take the following values:
% 'none' ... no low-pass filtering is applied
% 'sg' ... savitzky-golay filter, as implemented in ML
% LowPass.params is a vector with filter parameters, depending on the
% specific filter (all cutoffs should be defined in s)
% for SG, params are [lpFilterCutoff filterOrder]


% high-pass filter
if ~isfield(config,'HiPass')
    config.HiPass.method = 'polyFit';
    config.HiPass.polyOrder = 2;
end

% f0 calculation
if ~isfield(config,'f0')
    config.f0.method = 'median';
end
% specifies how f0 should be calculated
% method can be 'median', 'polyfit', 'percentile'
% for polyfit and percentile methods, specify the fit degree or percentile
% cutoff as params; e.g. for quadratic fit:
% config.f0.method = 'polyfit'
% config.f0.params = 2

% registration options
if ~isfield(config,'reg')
    config.reg.regChannel = 1; % which channel to perform registration on
    config.reg.doRegistration = 1; % if set to 0, channels will only be resized to reference image
else
    if ~isfield(config.reg,'regChannel')
        config.reg.regChannel = 1;
    end
    if ~isfield(config.reg,'doRegistration')
        config.reg.doRegistration = 1;
    end
end

% adding some more missing fields

if ~isfield(config,'doSaveROIRGBPlot')
    config.doSaveROIRGBPlot = 1;
end


end

%% Function - initParams
function [config, matFiles] = initParams(config, dbgLevel)

% this is a list of mat-files containing the raw data
% data will be concatenated so should be from one imaging area and always contain the same number of Rois
matFiles = config.matFiles;
for iFile = 1 : numel(matFiles);
    if isempty(strfind(matFiles{iFile}, '.mat'));
        matFiles{iFile} = [matFiles{iFile} '.mat'];
    end;
end;

% load the first mat-file and extract some general parameters
matFileWrapper = load(matFiles{1});
matFileStruct = matFileWrapper.(genvarname(strrep(matFiles{1},'.mat','')));

config.img_dims = matFileStruct.hdr.size(1 : 2); % x and y dimensions of the image
config.ROISet = matFileStruct.roi; % the ROI set
config.nRuns = numel(matFiles); % number of runs

% low-pass filter parameters
switch config.LowPass.method;
    case 'sg';
        lpFiltCutoff = config.LowPass.params(1);
        lpFiltCutoff = round(lpFiltCutoff .* matFileStruct.hdr.rate);
        if ~rem(lpFiltCutoff, 2);
            lpFiltCutoff = lpFiltCutoff + 1;
        end;
        config.LowPass.lpFiltCutoff = lpFiltCutoff;
        config.LowPass.sgolayOrder = config.LowPass.params(2); % filter order
        clear lpFiltCutoff
        o('  #GetRoiStats(): low-pass filtering parameters set with sgolay filter.', 3, dbgLevel);
    otherwise;
        o('  #GetRoiStats(): no low-pass filtering.', 4, dbgLevel);
end

% pre-allocate cell arrays, each cell will contain the imaging data for
% that ROI during that run. Also pre-allocate for the neuropil
config.ROIStatsData = cell(size(config.ROISet, 1) + 1, config.nRuns);

% initialize parameters for each run
for iRun = 1 : config.nRuns;
    
    % make sure the mat-file for that run exists
    if ~exist(matFiles{iRun}, 'file');
        warning('GetRoiStats:FileNotFound', 'Could not find mat-file "%s", skipping it.',  matFiles{iRun});
        continue;
    end;
    
    % open the mat-file and extract the structure
    matFileWrapper = load(matFiles{iRun});
    matFileStruct = matFileWrapper.(genvarname(strrep(matFiles{iRun},'.mat','')));
    
    nFrames = matFileStruct.hdr.size(3);
    % elongate the stim vector if needed, print an error if it's too short
    if numel(matFileStruct.stim) < nFrames;
        matFileStruct.stim(end + 1 : nFrames) = 0;
    elseif numel(matFileStruct.stim) > nFrames;
        error('GetRoiStats:StimVectorTooLong', 'Stim vector is longer than time-series for "%s".', ...
            matFiles{iRun});
    end;
    
    config.stim{iRun} = matFileStruct.stim; % stim vector for each run
    config.frameRate{iRun} = matFileStruct.hdr.frame_rate; % support different frame rates per run
end;

end

%% Function - CalculateF0
% fit a quadratic function to the timeseries and use it as F0
% works best for long timeseries with sparse activity
% function f0_mat = CalculateF0(roi_mat, f)
function f0_mat = CalculateF0(roi_mat, S)
switch lower(S.method)
    case 'median'
        f0_mat = median(roi_mat);
    case 'polyfit'
        t = 1:length(roi_mat);
        p = polyfit(t',roi_mat',S.params(1));
        f0_mat = p(1).*t.^2 + p(2).*t + p(3);
    case 'percentile'
        f0_mat = prctile(roi_mat,S.params(1));
    otherwise
        error('F0 method %s is not supported',S.method)
end
end

%% Function - doLowPassFilter
function v = doLowPassFilter(v, S)
switch S.method
    case 'sg'
        v = sgolayfilt(v,S.sgolayOrder,S.lpFiltCutoff);
end
end

%% Function - doHiPassFilter
function v = doHiPassFilter(v, S)
switch S.method
    case 'polyFit'
        p = polyfit(1:numel(v),v,S.polyOrder);
        f = polyval(p,1:numel(v));
        v = v - f;
end
end

%% Function - ResampleStimVector
function stimVectorFrameRate = ResampleStimVector(stim,stimRate,nFrames,frameRate) %#ok<DEFNU>
stimVectorFrameRate = zeros(1,nFrames);
for n = 1:nFrames
    startT = (n-1)/frameRate; stopT = n/frameRate;
    startStim = round(startT*stimRate);
    if startStim == 0
        startStim = 1;
    end
    stopStim = round(stopT*stimRate);
    if startStim > length(stim) || stopStim > length(stim)
        stimVectorFrameRate(n) = 0;
    else
        stimVectorFrameRate(n) = round(mean(stim(startStim:stopStim)));
    end
end

end

%% Function - getRefOrRegImage
function img = getRefOrRegImage(fileID, imgType, baseImgs, config, doSavePlot, dbgLevel)

if doSavePlot;
    % display the reference image
    figHand = figure('NumberTitle', 'off', 'Name', sprintf('%s Image for %s', imgType, fileID));
end;

% using only 1 registration channel
if numel(config.reg.regChannel) == 1;
    o('          #Get...ImageReg(): Generating "%s" frame based on the channel %d.', ...
        imgType, config.reg.regChannel, 3, dbgLevel);
    img = baseImgs{config.reg.regChannel};

    % flatten (average) the image;
    if size(img, 3) > 1; img = mean(img, 3); end;
    
    if doSavePlot;
        % plot the reference image
        imshow(img, []);
        title(sprintf('%s image: channel %d of %s', imgType, config.reg.regChannel, ...
            strrep(fileID, '_', '\_')));
    end;
    
% if two channels are specified, do oregistration on the difference between the two (regChan1 - regChan2)
elseif numel(config.reg.regChannel) == 2;
    o('          #Get...ImageReg(): Generating "%s" frame based on the channels %d and %d.', ...
        imgType, config.reg.regChannel, 3, dbgLevel);
    regChan1RefImg = linScale(baseImgs{config.reg.regChannel(1)});
    regChan2RefImg = linScale(baseImgs{config.reg.regChannel(2)});
    
    % flatten (average) the image;
    if size(regChan1RefImg, 3) > 1; regChan1RefImg = mean(regChan1RefImg, 3); end;
    if size(regChan2RefImg, 3) > 1; regChan2RefImg = mean(regChan2RefImg, 3); end;
    
    img = regChan1RefImg - regChan2RefImg;
    if config.reg.multiRegChannelForbidNegatives;
        img(img < 0) = 0; % make sure there's no negative
    end;
    img = linScale(img);
    
    if doSavePlot;
        % plot the reference image
        subplot(1, 3, 1); imshow(regChan1RefImg, []);
        title(sprintf('Channel %d', config.reg.regChannel(1)));
        subplot(1, 3, 2); imshow(regChan2RefImg, []);
        title(sprintf('Channel %d', config.reg.regChannel(2)));
        subplot(1, 3, 3); imshow(img, []);
        title(sprintf('%s image: channel %d - %d', imgType, config.reg.regChannel));
        suptitle(sprintf('%s image of %s', imgType, strrep(fileID, '_', '\_')));
    end;
    
end;

% save if required
if doSavePlot > 1;
    if exist(imgType, 'dir') ~= 7; mkdir(imgType); end;
    saveas(figHand, sprintf('%s/%s__%sImg', imgType, fileID, imgType(1:3)));
    saveas(figHand, sprintf('%s/%s__%sImg.png', imgType, fileID, imgType(1:3)));
    close(figHand);
end;

end

%% Function - doNeuropilInterpolation
function currentNpilData = doNeuropilInterpolation(config, currentImgData) %#ok<DEFNU>

npilFile = [saveNameBase '__NpilMovies.mat'];
currentNpilData = cell(1,length(config.channelVector));
currentNpilDataSave = cell(1,length(config.channelVector));
if config.recycleNpilMovie;
    try
        a = load(npilFile);
        currentNpilData = a.(genvarname(strrep(npilFile,'.mat','')));
    catch e; %#ok<NASGU>
        for n = 1:length(config.channelVector)
            currentNpilData{n} = NeuropilInterpolation(...
                currentImgData{n},roiSetActiveModel,4,1);
            if bitDepth == 8
                currentNpilDataSave{n} = uint8(currentNpilData{n});
            else
                currentNpilDataSave{n} = uint16(currentNpilData{n});
            end
        end
        SaveAndAssignInBase(currentNpilDataSave,npilFile,'SaveOnly')
        clear currentNpilDataSave
    end
else
    for n = 1:length(config.channelVector)
        currentNpilData{n} = NeuropilInterpolation(...
            currentImgData{n},roiSetActiveModel,4,1);
        if bitDepth == 8
            currentNpilDataSave{n} = uint8(currentNpilData{n});
        else
            currentNpilDataSave{n} = uint16(currentNpilData{n});
        end
    end
    SaveAndAssignInBase(currentNpilDataSave,npilFile,'SaveOnly')
    clear currentNpilDataSave
end

end

%% Function - extractROIStats
function ROIStatsFiltNorm = extractROIStats(imgData, ROIMask, ...
    statsType, LowPassFilterConfig, HiPassFilterConfig, f0config, saveName, ...
    doSavePlot)

ROIImgData = cell(1, numel(imgData));

% pull out timeseries from masked pixels and average for each relevant channels
for iChan = 1 : numel(imgData);
    ROIImgData{iChan} = mean(GetRoiTimeseries(imgData{iChan}, ROIMask), 1);
end

switch lower(statsType)
    case 'dff'
        ROIStatsRaw = ROIImgData{1};
    case 'drr'
        ROIStatsRaw = ROIImgData{1} ./ ROIImgData{2};
end

meanOfRawTrace = mean(ROIStatsRaw);

% high-pass filter calcium traces
ROIStatsFilt = doHiPassFilter(ROIStatsRaw, HiPassFilterConfig);

% low-pass filter calcium traces
ROIStatsFilt = doLowPassFilter(ROIStatsFilt, LowPassFilterConfig);

ROIStatsFiltAdj = ROIStatsFilt + meanOfRawTrace;

% calculate F0
F0 = CalculateF0(ROIStatsFiltAdj, f0config);

% calculate normalized fluorescence change
ROIStatsFiltNorm = ((ROIStatsFiltAdj - F0) ./ F0) .* 100;
ROIStatsFiltNorm(isinf(ROIStatsFiltNorm)) = 0;
ROIStatsFiltNorm(isnan(ROIStatsFiltNorm)) = 0;

% plotting for debugging only
if doSavePlot;
    figF0AndExtract = figure('NumberTitle', 'off', 'Name', ...
        sprintf('%s_extractROIStats', saveName));
    
    nSubPlots = 4;
    subplot(nSubPlots, 1, 1);
    plot(ROIStatsRaw, 'r');
    line([0, numel(ROIStatsRaw)], [meanOfRawTrace, meanOfRawTrace], 'Color', 'black');
    legend({'Raw', 'mean'});
    title(sprintf('Raw trace with mean ( = %d)', round(meanOfRawTrace)));
    
    subplot(nSubPlots, 1, 2);
    plot(ROIStatsFilt, 'k');
    legend({'Filtered'});
    title('Raw trace filtered');
    
    subplot(nSubPlots, 1, 3);
    plot(ROIStatsFiltAdj, 'g');
    if numel(F0) == 1;
        line([0, numel(ROIStatsFiltAdj)], [F0, F0], 'Color', 'black');
    else
        hold on;
        plot(F0, 'k');
    end;
    legend({'Adjusted', 'F0'});
    title('Raw trace filtered and adjusted (with mean) and F0');
    
    subplot(nSubPlots, 1, 4);
    plot(ROIStatsFiltNorm, 'b');
    legend({'Filtered'});
    title('DFF/DRR trace');
    
    if doSavePlot > 1;
        if exist('F0AndExtractPlots', 'dir') ~= 7; mkdir('F0AndExtractPlots'); end;
        saveNameF0AndExtract = ['F0AndExtractPlots/' saveName];
        saveas(figF0AndExtract, saveNameF0AndExtract);
        saveas(figF0AndExtract, [saveNameF0AndExtract '.png']);
        close(figF0AndExtract);
    end;
end;

end

% e.o.f.




