function convertAllRawDataForMouse(animalID, targetDays, targetSpots, targetRuns)

% % add folders to path
% folderList = {'Projects/2PIanalyzer','Projects/AuditoryLearning'};
% addFolders2Path(folderList, 1);
dbgLevel = 1;
convertAllTic = tic; % for performance timing purposes
%% Get days with spots
year = '2013'; % leave this as a string, not a number

rawDataRootPaths = struct( ...
    'HIFOWSH350x2D01', 'W:\Neurophysiology\RawData\Balazs_Laurenczy\', ...
    ...'HIFOWSH350x2D01',  'D:\Balazs\RawData\', ...
    'HIFOWSH640x2D03',  'C:\Users\laurenczy.HIFO\Documents\LocalData\RawData\', ...
    'OoPC',             'D:\Users\BaL\PhD\AuditoryLearningRaw\');
analysisRootPaths = struct( ...
    'HIFOWSH350x2D01',  'D:\Balazs\Analysis\', ...
    'HIFOWSH640x2D03',  'C:\Users\laurenczy.HIFO\Documents\LocalData\Analysis\', ...
    'OoPC',             'D:\Users\BaL\PhD\AuditoryLearningAnalysis\');
[~, computerName] = system('hostname');
rawDataRootPath = rawDataRootPaths.(genvarname(computerName));
analysisRootPath = analysisRootPaths.(genvarname(computerName));
% rawDataRootPath = 'W:\Neurophysiology\RawData\Balazs_Laurenczy\';
% rawDataRootPath = 'D:\Users\BaL\PhD\AuditoryLearningRaw\';
% analysisRootPath = 'W:\Neurophysiology\Projects\Auditory\Analysis\AuditoryLearning\';
% analysisRootPath = 'D:\Balazs\';
% analysisRootPath = 'C:\Users\laurenczy.HIFO\Documents\LocalData\';
% analysisRootPath = 'D:\Users\BaL\PhD\AuditoryLearningAnalysis\';
analysisRootPath = [analysisRootPath year '\' animalID '\'];
o('#convertAllRawDataForMouse(): animalID = %s.', animalID, 1, dbgLevel);
o('#convert...ForMouse(): rawDataRootPath = "%s".', rawDataRootPath, 3, dbgLevel);
o('#convert...ForMouse(): analysisRootPath = "%s".', analysisRootPath, 3, dbgLevel);
% get all days with at least 1 "spot**" folder inside for this mouse
daysWithSpot = getDaysWithSpot(year, rawDataRootPath, animalID, 0);
o('#convert...ForMouse(): Found %d day(s) with spot for animal %s.', ...
    numel(daysWithSpot), animalID, 2, dbgLevel);
% % restrict the running to specific day(s), spot(s), run(s). Can be set to 0 to run all or
% % can be set to single number: targetDays = 2; or to a list: targetSpots = [2 3 5];
% targetDays = 1;
% targetSpots = 0;
% targetRuns = 0;
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
    currentDate = day.date;
    
    o('#convert...ForMouse(): Processing day %s with %d spot(s).', currentDate, size(spotList, 1), 2, dbgLevel);
    %% Input files
    fullRawDataPath = [rawDataRootPath year filesep animalID filesep currentDate];
    stimFile = [fullRawDataPath filesep 'CaImgExp_' currentDate '.mat'];
    % perform analysis in different directory than the raw data directory
    analysisPath = [analysisRootPath currentDate];
    mkdir(analysisPath);
    cd(analysisPath);
    %% Parameters
    bgCorrect = {'percentile', 1, 0};
    delFrame = 1;
    % load CaImgExp
    CaImgExpMat = load(stimFile);
    % read the HelioScan notebook text file and generate and "experiment info" cell array where
    % each row is a different recording (reference image or movie)
    expInfo = prepare4dataImport(notebookFileName, spotList, {}, 0, 0, 0);
    nRuns = size(expInfo, 1);
    save('ExperimentInfo.mat', 'expInfo');
    o('  #convert...ForMouse(): %s: Experiment info generated and saved.', currentDate, 3, dbgLevel);
    
    % holder for all the ROIMaskStructures
    ROIMaskStructs = {};
    
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
            o('    #convert...ForMouse(): %s: skipping spot %d as it is empty.', currentDate, iSpot, 2, dbgLevel);
            continue;
        end;
        stims = spotInfo.stims;
        spotID = spotList{iSpot, 1}; % for example 'spot01'
        % try to create directory
        mkdir(analysisPath, spotID);
        currentAnalysisDir = sprintf('%s%s%s', analysisPath, filesep, spotID);
        save(sprintf('%s%sspotInfo.mat', currentAnalysisDir, filesep), 'spotInfo');
        o('    #convert...ForMouse(): %s - %s: Saved ''spotInfo''.', currentDate, spotID, 3, dbgLevel);
        
        % check for the presence of ROIMask folder to use as ROISet
        ROIMaskPath = fullfile(fullRawDataPath, 'ROIMasks');
        if exist(ROIMaskPath, 'dir');
            % get all ROIMasks structures, containing the ROIMasks and the validity for the different runs
            ROIMaskMatFiles = dir([ROIMaskPath '\*_ROIMask.mat']);
            for iMatFile = 1 : numel(ROIMaskMatFiles);
                 % load the mat file
                 ROIMaskStruct = load([ROIMaskPath '\' ROIMaskMatFiles(iMatFile).name]);
                 % extract the runID
                 ROIMaskStruct.runID = cell2mat(regexp(ROIMaskMatFiles(iMatFile).name, ...
                     '\d{4}_\d{2}_\d{2}__\d{2}_\d{2}_\d{2}h', 'match'));
                 % runsValidity empty means valid for all
                 if isempty(ROIMaskStruct.runsValidity);
                     ROIMaskStruct.runsValidity = expInfo(:, 3); % add all runIDs (date + time)
                 end;
                 % store the structure
                 ROIMaskStructs{end + 1} = ROIMaskStruct; %#ok<AGROW>
            end;
        end;
                
        % go through each movie to convert the raw data into mat-files
        for iRun = 1 : nRuns;
%         parfor iRun = 1 : nRuns;
            runTic = tic; % for performance timing purposes
            
            % only target run(s)
            if any(targetRuns) && ~any(targetRuns == iRun); continue; end;
            
            % process only the expInfo's spot corresponding to the current spot
            if ~strcmp(expInfo{iRun,1}, spotID); continue; end;
            
            % path if data are NOT already ordered in spot** folders
%             file = fullfile(fullRawDataPath, expInfo{row, 3}, [expInfo{row, 3} '__channel00.tif']);
            % path if data are already ordered in spot** folders
            filePath = fullfile(fullRawDataPath, spotID, expInfo{iRun, 3}, [expInfo{iRun, 3} '__channel00.tif']);
            
            % extract relevant informations from the expInfo table
            dataRecordingDateTime = expInfo{iRun, 3};
            expType = expInfo{iRun, 4};
            frame_rate = expInfo{iRun, 5};
            laser = expInfo{iRun, 6};
            zoom = expInfo{iRun, 7}; %#ok<PFBNS>
            o('      #convert...ForMouse(): %s - %s - %d/%d: converting raw data...', currentDate, spotID, ...
                iRun, nRuns, 3, dbgLevel);
            
            % group common inputs
            commonInputs = {'RawFiles', {filePath}, 'BgCorrect', bgCorrect, 'Type', expType, ...
                'SaveDir', currentAnalysisDir, 'frame_rate', frame_rate, 'zoom', zoom, ...
                'ColorVector', [1 2 0], 'laserPower', laser, 'spotID', spotID, 'animalID', animalID};
                
            % check for the presence of a ROIMask and a reference to use for this run
            % go through all ROIMask structures
            for iStruct = 1 : numel(ROIMaskStructs);
                ROIMaskStruct = ROIMaskStructs{iStruct};
                % if this structure is valid for this run, use it
                if ismember(dataRecordingDateTime, ROIMaskStruct.runsValidity);
                    ROIMask = ROIMaskStruct.ROIMask;
                    ROIs = ROIMaskStruct.ROIs;
                    ROISet = cell(size(ROIs, 1), 2);
                    ROISet(:, 1) = ROIs(:, 2);
                    ROISet(:, 2) = arrayfun(@(x)ROIMask == x, 1 : size(ROIs, 1), 'UniformOutput', false);
                    if any(~size(ROIMask));
                        warning('convertAllRawDataForMouse:EmptyMask', ...
                            '#convert...ForMouse(): %s - %s - %d/%d: ROIMask empty !', ...
                            currentDate, spotID, iRun, nRuns);
                    end;
                    commonInputs = [commonInputs, {'RoiSet', ROISet, 'RefImg', ROIMaskStruct.runID}];
                    o('      #convert...ForMouse(): %s - %s - %d/%d: found ROISet and ref: "%s", %d ROIs.', ...
                        currentDate, spotID, iRun, nRuns, ROIMaskStruct.runID, size(ROIs, 1), 4, dbgLevel);
                    break; % only search for one match of RoiSet
                end;
            end;
            
            try
                switch expType
                    case 'movie'
                        % figure out stimulus
                        stimIndex = compareTimes(dataRecordingDateTime, stims);
                        o('      #convert...ForMouse(): %s - %s - %d/%d: compared times, found stimulus index: %d.', ...
                            currentDate, spotID, iRun, nRuns,  stimIndex, 4, dbgLevel);
                        if ~any(cell2mat(strfind(commonInputs(cellfun(@ischar, commonInputs(:))), 'RoiSet')));
                            warning('convertAllRawDataForMouse:NoRoiSet', ...
                                '#convert...ForMouse(): %s - %s - %d/%d: No RoiSet found !', ...
                                currentDate, spotID, iRun, nRuns);
                        end;
                        ConvertRawData(commonInputs{:}, 'DelFrame', delFrame, 'stim', stims{stimIndex});
                    case 'frame' % no stims
                        ConvertRawData(commonInputs{:}, 'DelFrame', 0);
                end
            catch e;
                o('#convert...ForMouse(): %s - %s - %d/%d: ERROR: %s (%.2f seconds).', currentDate, spotID, ...
                    iRun, nRuns, e.message, toc(runTic), 3, dbgLevel);
            end;
            
            o('      #convert...ForMouse(): %s - %s - %d/%d: converted raw data (%.2f seconds).', currentDate, spotID, ...
                iRun, nRuns, toc(runTic), 3, dbgLevel);
        end
        o('    #convert...ForMouse(): %s - %s: converted raw data (%.2f seconds).', currentDate, spotID, ...
            toc(spotTic), 2, dbgLevel);
    end
    o('  #convert...ForMouse(): %s: converted raw data (%.2f seconds).', currentDate, ...
        toc(dayTic), 1, dbgLevel);
end;
o('#convertAllRawDataForMouse(): converted all raw data for "%s" (%.2f seconds).', ...
    animalID, toc(convertAllTic), 1, dbgLevel);
end
