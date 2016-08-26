function configCell = roiStatsSingleDay(spotList, doAddRois, config)
roiStatsSingleDayTic = tic; % for performance timing purposes

% add folders to path
folderList = {'Projects/2PIanalyzer','Projects/CalciumSim',...
    'Projects/EventDetect'};
addFolders2Path(folderList,1);

dbgLevel = 1;
o('#roiStatsSingleDay(): %d spot(s) to process, doAddRois = %d ...', ...
    size(spotList, 1), doAddRois, 1, dbgLevel);

% loads expInfo cell array
expInfoMat = load('ExperimentInfo.mat');
expInfo = expInfoMat.expInfo;

% build saveName from current directory name (usually the date) and spot name
[~, baseName, ~] = fileparts(pwd);
% baseName = ['ROIStats_' baseName];

startDir = pwd;
    
% second loop to handles movies
o('#roiStatsSingleDay(): searching for movies (BF vs Odd10)...', 2, dbgLevel);
expList_bfSpotId = cell(size(expInfo,1), 1); % store BF experiment info
expList_bfMatFileName = cell(size(expInfo,1), 1); % store BF experiment info
expList_odd10SpotId = cell(size(expInfo,1), 1); % store Odd10 experiment info
expList_odd10MatFileName = cell(size(expInfo,1), 1); % store Odd10 experiment info

for iSpot = 1:numel(spotList);
    
    % only target spot(s)    
    if any(config.targetSpots) && ~any(config.targetSpots == iSpot); continue; end;
    
    o('  #roiStatsSingleDay(): spot %d/%d ...', iSpot, numel(spotList), 2, dbgLevel);
    % go through each row (= each recording)
    for iRun = 1 : size(expInfo, 1);

        % only target run(s)    
        if any(config.targetRuns) && ~any(config.targetRuns == iRun); continue; end; %%#ok<PFBNS>
    
        % process only spots corresponding to the current spot
        if ~strcmp(spotList{iSpot}, expInfo{iRun, 1}); continue; end; %%#ok<PFBNS>
        
        o('    #roiStatsSingleDay(): spot %d/%d - row %d/%d ...', ...
            iSpot, numel(spotList), iRun, size(expInfo, 1), 3, dbgLevel);
        
        % check the image type, must be a movie
        if strcmp(expInfo{iRun, 4}, 'movie');
            % check the image name and classify according to either BF or Odd10
            if ~isempty(strfind(expInfo{iRun, 2}, 'BF_'));
                o('      #roiStatsSingleDay(): found BF movie: "%s".', expInfo{iRun, 3}, 4, dbgLevel);
                expList_bfSpotId{iRun} = spotList{iSpot};
                expList_bfMatFileName{iRun} = expInfo{iRun, 3};
            elseif ~isempty(strfind(expInfo{iRun,2},'Odd10_'));
                o('      #roiStatsSingleDay(): found Odd10 movie: "%s".', expInfo{iRun, 3}, 4, dbgLevel);
                expList_odd10SpotId{iRun} = spotList{iSpot};
                expList_odd10MatFileName{iRun} = expInfo{iRun, 3};
            else
                continue;
            end;
        end;
    end;
end;
o('#roiStatsSingleDay(): movies classified.', 2, dbgLevel);

o('#roiStatsSingleDay(): Getting ROI stats for all spots...', 1, dbgLevel);
configCell = cell(2, numel(spotList));
for iSpot = 1 : numel(spotList);
    spotTic = tic; % for performance timing purposes
    
    % only target spot(s)    
    if any(config.targetSpots) && ~any(config.targetSpots == iSpot); continue; end;
    
    o('  #roiStatsSingleDay(): processing spot %d/%d ("%s") at %s...', ...
        iSpot, numel(spotList), spotList{iSpot}, datestr(clock,21), 2, dbgLevel);
    
    % BF
    config.matFiles = cell(1,1);
    nMatFilesFound = 0;
    config.saveName = [baseName '_BF_' spotList{iSpot}];
    fullPath = sprintf('%s%s%s', startDir, filesep, spotList{iSpot});
    
    % search for get the mat files from the BF runs
    for iRun = 1 : size(expList_bfSpotId,1)
        % only target run(s)    
        if any(config.targetRuns) && ~any(config.targetRuns == iRun); continue; end;
        
        if isempty(expList_bfSpotId{iRun}); continue; end;
        if strcmp(expList_bfSpotId{iRun}, spotList{iSpot});
            o('    #roiStatsSingleDay(): spot %d/%d - BF row %d/%d ...', ...
                iSpot, numel(spotList), iRun, size(expInfo, 1), 3, dbgLevel);
            nMatFilesFound = nMatFilesFound + 1;
            config.matFiles{nMatFilesFound} = expList_bfMatFileName{iRun};
        end;
    end;
    
    ticStimConv = tic;
    o('  #roiStatsSingleDay(): stim conversion and ref image adding for %d mat files ...', ...
        nMatFilesFound, 2, dbgLevel);
    parfor iMatFile = 1 : nMatFilesFound;
        doStimConversAndAddRefImage(sprintf('%s%s%s.mat', fullPath, filesep, ...
            config.matFiles{iMatFile}), 'bf', fullPath, dbgLevel); %#ok<PFBNS>
    end;
    o('  #roiStatsSingleDay(): stim conversion and ref image adding for %d mat files done (%3.1f sec)', ...
        nMatFilesFound, toc(ticStimConv), 2, dbgLevel);
    
    if nMatFilesFound > 0;
        o('  #roiStatsSingleDay(): Getting ROI stats for BF stims (%d movies)...', ...
            nMatFilesFound, 2, dbgLevel);
        cd(fullPath);
        configCell{1,iSpot} = GetRoiStats(config);
        cd(startDir);
    end;
    
%     % Odd10
%     config.matFiles = cell(1,1);
%     nMatFilesFound = 0;
%     config.saveName = [baseName '_Odd10_' spotList{iSpot}];
%     for iRun = 1:size(expList_odd10SpotId,1)
%         if isempty(expList_odd10SpotId{iRun}); continue; end;
%         if strcmp(expList_odd10SpotId{iRun},spotList{iSpot});
%             o('    #roiStatsSingleDay(): spot %d/%d - Odd10 row %d/%d ...', ...
%                 iSpot, numel(spotList), iRun, size(expInfo, 1), 3, dbgLevel);
%             nMatFilesFound = nMatFilesFound + 1;
%             config.matFiles{nMatFilesFound} = expList_odd10MatFileName{iRun};
%             doStimConversion(sprintf('%s%s%s.mat',fullPath,filesep,...
%                 config.matFiles{nMatFilesFound}),'odd10');
%         end;
%     end;
%     if nMatFilesFound > 0;
%         o('  #roiStatsSingleDay(): Getting ROI stats for Odd10 stims (%d movies)...', ...
%             nMatFilesFound, 2, dbgLevel);
%         cd(fullPath);
%         configCell{2,iSpot} = GetRoiStats(config); % warning: can contain a parfor
%         cd(startDir);
%     end;
    
    o('  #roiStatsSingleDay(): finished spot %d/%d ("%s") at %s (%.2f seconds).', ...
        iSpot, numel(spotList), spotList{iSpot}, datestr(clock,21), toc(spotTic), 2, dbgLevel);
end;

o('  #roiStatsSingleDay(): finished getting ROI stats of %d spot(s) at %s (%.2f seconds).', ...
    numel(spotList), datestr(clock, 21), toc(roiStatsSingleDayTic), 2, dbgLevel);
    
end

function doStimConversAndAddRefImage(matfile, stimType, fullPath, dbgLevel)

o('    #doStimConversAndAddRefImage(): stim conversion and ref image adding for %s, stimType: %s ...', ...
        matfile, stimType, 3, dbgLevel);
TDTRate = 97656.25;

matSaveName = matfile;
if ~exist(matfile, 'file')
       warning('doStimConversion:FileNotFound', 'Could not find mat-file "%s", skipping it.', matfile);
    return;
end;
vars = whos('-file', matfile);
matFileStruct = load(matfile, vars(1).name);
matFileStruct = matFileStruct.(vars(1).name);

% add refImage as image if it's only a string
if isfield(matFileStruct.hdr, 'refImg') && ischar(matFileStruct.hdr.refImg);
    o('      #doStimConversAndAddRefImage(): %s: found ref image: %s ...', ...
            matfile, matFileStruct.hdr.refImg, 3, dbgLevel);
    refImgMatFilePath = sprintf('%s%s%s.mat', fullPath, filesep, matFileStruct.hdr.refImg);
    refImgVars = whos('-file', refImgMatFilePath);
    refImgStruct = load(refImgMatFilePath, refImgVars(1).name);
    refImgData = refImgStruct.(refImgVars(1).name).img_data;
    matFileStruct.refImg = cell(1, numel(refImgData));
    for iChan = 1 : numel(refImgData);
        matFileStruct.refImg{iChan} = mean(refImgData{iChan}, 3);
    end;
    o('      #doStimConversAndAddRefImage(): %s: ref image added as image.', matfile, 3, dbgLevel);
end;

stim = matFileStruct.stim;
if isnumeric(stim) % already converted
    o('      #doStimConversAndAddRefImage(): %s: stim is already a numeric.', matfile, 3, dbgLevel);
   return ;
end

frame_rate = matFileStruct.hdr.frame_rate;
delFrame = matFileStruct.proc.DelFrame;

stimID = stim.freqIdSeries;
timepoints = stim.timePoints;
timepoints = timepoints ./ TDTRate;
% convert to frame and offset by delFrame
timepoints = round(timepoints .* frame_rate) - delFrame;
stimVector = zeros(1,size(matFileStruct.img_data{1},3));
switch lower(stimType)
    case 'odd10'
        stimID(stimID==1) = 2;
        stimID(stimID==-1) = 1;
end
stimVector(timepoints) = stimID;
matFileStruct.proc.stim = matFileStruct.stim;
matFileStruct.stim = stimVector;
o('      #doStimConversAndAddRefImage(): %s: created new stim vector (%d frame(s) long).', ...
    matfile, numel(matFileStruct.stim), 3, dbgLevel);

SaveAndAssignInBase(matFileStruct, matSaveName, 'SaveOnly');
end

