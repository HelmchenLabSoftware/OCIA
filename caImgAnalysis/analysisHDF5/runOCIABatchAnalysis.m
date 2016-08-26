function caTracesOut = runOCIABatchAnalysis(varargin)

allTic = tic; % for performance timing purposes
verb = 2;
caTracesOut = {};

%% initialize available days and spots

...%                   1                   2                    3                    4
animalsIDs = { 'mou_bl_140109_01', 'mou_bl_140109_02' , 'mou_bl_140110_01', 'mou_bl_140110_02' };

...%              1             2               3           4             5               6           7
dayIDs = {  '2014_02_03', '2014_02_04', '2014_02_06', '2014_02_07', '2014_02_08', '2014_02_09', '2014_02_10', ...
...%              8             9               10          11            12              13          14
            '2014_02_11', '2014_02_12', '2014_02_13', '2014_02_14', '2014_02_15', '2014_02_16', '2014_02_17', ...
...%              15            16              17          18            19              20          21
            '2014_02_18', '2014_02_19', '2014_02_20', '2014_02_21', '2014_02_22', '2014_02_23', '2014_02_24', ...
...%              22            23              24
            '2014_02_25', '2014_02_26', '2014_03_03' };

...%           1         2         3
spotIDs = { 'spot01', 'spot02', 'spot03' };

tasks = { ...
        struct( 'HIFOWSH640x2D03b', struct('animals', 1, 'days',  3, 'spots',  1     ,                   'runs', '')) ...
    };

%{
tasks = { ...
        struct( 'hifo02', struct('animals', 1, 'days',  3, 'spots',  1     ,                   'runs', '')), ...
        struct( 'hifo02', struct('animals', 1, 'days',  4, 'spots', [1 2  ],                   'runs', '')), ...
        struct( 'hifo02', struct('animals', 1, 'days',  7, 'spots',  1     , 'behavID', 'B01', 'runs', '')), ...
        struct( 'hifo02', struct('animals', 1, 'days',  7, 'spots',    2   , 'behavID', 'B02', 'runs', '')), ...
        struct( 'hifo02', struct('animals', 1, 'days',  7, 'spots',  1     , 'behavID', 'B03', 'runs', '')), ...
        struct( 'hifo02', struct('animals', 1, 'days',  7, 'spots',    2   , 'behavID', 'B04', 'runs', '')), ...
        struct( 'hifo02', struct('animals', 1, 'days',  8, 'spots',    2   , 'behavID', 'B02', 'runs', '')), ...
        struct( 'hifo02', struct('animals', 1, 'days',  8, 'spots',      3 , 'behavID', 'B03', 'runs', '')), ...
        struct( 'hifo02', struct('animals', 1, 'days',  8, 'spots',    2   , 'behavID', 'B05', 'runs', '')), ...
        struct( 'hifo02', struct('animals', 1, 'days',  8, 'spots',      3 ,'behavID','B0[67]','runs', '')), ...
        struct( 'hifo02', struct('animals', 1, 'days',  9, 'spots', [1 2 3],                   'runs', '')), ...
        struct( 'hifo02', struct('animals', 1, 'days', 10, 'spots', [1 2  ],                   'runs', '')), ...
        struct( 'hifo02', struct('animals', 1, 'days', 11, 'spots', [1 2 3],                   'runs', '')), ...
        struct( 'hifo02', struct('animals', 1, 'days', 13, 'spots', [1 2 3],                   'runs', '')), ...
        struct( 'hifo02', struct('animals', 1, 'days', 15, 'spots', [1 2 3],                   'runs', '')), ...
        struct( 'hifo02', struct('animals', 1, 'days', 16, 'spots', [1 2  ],                   'runs', '')), ...
        struct( 'hifo02', struct('animals', 1, 'days', 18, 'spots', [  2 3],                   'runs', '')), ...
        struct( 'hifo02', struct('animals', 1, 'days', 20, 'spots', [  2 3],                   'runs', '')), ...
        struct( 'hifo02', struct('animals', 1, 'days', 22, 'spots', [  2 3],                   'runs', '')), ...
        struct( 'hifo02', struct('animals', 2, 'days', 18, 'spots', [1 2  ],                   'runs', '')), ...
        struct( 'hifo01', struct('animals', 3, 'days', 20, 'spots', [1 2  ],                   'runs', '')), ...
        struct( 'hifo01', struct('animals', 4, 'days',  5, 'spots', [1 2  ],                   'runs', '')), ...
        struct( 'hifo01', struct('animals', 4, 'days',  7, 'spots', [1 2  ],                   'runs', '')), ...
        struct( 'hifo01', struct('animals', 4, 'days',  8, 'spots',    2   , 'behavID', 'B02', 'runs', '')), ...
        struct( 'hifo01', struct('animals', 4, 'days',  8, 'spots',    2   , 'behavID', 'B04', 'runs', '')), ...
        struct( 'hifo01', struct('animals', 4,'days',9:11, 'spots',    2   ,                   'runs', '')), ...
        struct( 'hifo01', struct('animals', 4, 'days', 13, 'spots',    2   ,                   'runs', '')), ...
        struct( 'hifo01', struct('animals', 4, 'days', 15, 'spots',    2   ,                   'runs', '')), ...
        struct( 'hifo01', struct('animals', 4, 'days', 16, 'spots', [1 2  ],                   'runs', '')), ...
        struct( 'hifo01', struct('animals', 4, 'days', 18, 'spots', [1 2  ],                   'runs', '')), ...
        struct( 'hifo01', struct('animals', 4, 'days', 20, 'spots', [1 2  ],                   'runs', '')), ...
        struct( 'hifo01', struct('animals', 4, 'days', 22, 'spots', [1 2  ],                   'runs', ''))  ...
    };
%}

%% initialize the configuration

masterConfig = getAnalyseROIStatsDefaultConfig();

masterConfig.axeH = [];
masterConfig.stimIDs = {'low', 'high'};

masterConfig.doSaveROICaTracesAllRunsPlot           = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSaveROICaTracesPlot                  = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSaveROICaTracesAsGroup               = 0;     % 0 = don't save as group, 1 = save as group
masterConfig.doSaveROICaTracesHeatMapAllRunsPlot    = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSaveROICaTracesHeatMapPlot           = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSaveROICaTracesHeatMapAsGroup        = 0;     % 0 = don't save as group, 1 = save as group
masterConfig.doSaveAnalyseNoiseLvl                  = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSaveROINPilPlot                      = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSaveCrossCorrPlot                    = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSaveInterROICorrPlot                 = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSaveInterTrialCorrPlot               = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSaveRespProbPlot                     = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSaveTTestPlot                        = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSaveTTestNPilPlot                    = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSaveGLMPlot                          = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSaveEvokedRespPlot                   = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSaveEvokedRespCorrPlot               = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSaveInterTrialVSEvokedRespCorrPlot   = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSavePSAvgPlot                        = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSaveInterTrialAvg                    = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSavePSSingleAvg                      = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSavePSPlot                           = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSavePSPlotROIHeatMap                 = 1;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSavePSPlotStimHeatMap                = 1;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSavePSPlotAllStimHeatMap             = 1;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSaveBSPlot                           = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSaveBSOvlPlot                        = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSaveBSPlotSorted                     = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSavePSPlotRuns                       = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSaveMaps                             = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSaveTuningPlot                       = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSavePairedTuningPlot                 = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSaveROIAnovaPlot                     = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSaveAnovaPopPlot                     = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSaveMultiCompROI                     = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSaveMultiCompPop                     = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSavePopulationScatter                = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doScatterTick                          = 0;     % 0 = don't plot, 1 = plot
masterConfig.doSavePlotROIResponseOverview          = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSavePlotROIResponsiveness            = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSaveStimulusPreferenceHeatmap        = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSaveWhiskerTuningHeatmap             = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
masterConfig.doSaveROITuningMaps                    = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save

masterConfig.PSFramesRespProb.base                  = 7;      % number of base frames
masterConfig.PSFramesRespProb.evoked                = 9;      % number of evoked frames
masterConfig.doPSAnalysis                           = 1;      % 0 = don't do the analysis, 1 = do the analysis
masterConfig.doInterTrialCorrAnalysis               = 0;      % 0 = don't do the analysis, 1 = do the analysis
masterConfig.doWholeRunCorrAnalysis                 = 0;      % 0 = don't do the analysis, 1 = do the analysis
masterConfig.doRespProbAnalysis                     = 0;      % 0 = don't do the analysis, 1 = do the analysis
masterConfig.respProbThresh                         = 4;      % responsiveness threshold
masterConfig.doTTestAnalysis                        = 0;      % 0 = don't do the analysis, 1 = do the analysis
masterConfig.doTTestNPil                            = 0;      % 0 = don't do the analysis, 1 = do the analysis
masterConfig.ttestThresh                            = 0.05;   % alpha significance threshold
masterConfig.doGLMAnalysis                          = 0;      % 0 = don't do the analysis, 1 = do the analysis
masterConfig.GLMThresh                              = 0.0001; % alpha significance threshold
masterConfig.doROIAnovaAnalysis                     = 0;      % 0 = don't do the analysis, 1 = do the analysis
masterConfig.anovaEvokedMethod                      = '3pp';  % 3pp or evokedMean; method to extract mean resp
masterConfig.doPopulationAnovaAnalysis              = 0;      % 0 = don't do the analysis, 1 = do the analysis
masterConfig.doROIMultiCompare                      = 0;      % 0 = don't do the analysis, 1 = do the analysis
masterConfig.doPopMultiCompare                      = 0;      % 0 = don't do the analysis, 1 = do the analysis
masterConfig.multiCompareThresh                     = 0.001;  % alpha significance threshold
masterConfig.showStimTuning                         = 0;      % 0 = don't do the analysis, 1 = do the analysis    
masterConfig.doAnalyseGalvoTuning                   = 0;      % 0 = don't do the analysis, 1 = do the analysis
masterConfig.doROINPilAnalysis                      = 0;      % 0 = don't do the analysis, 1 = do the analysis
masterConfig.doCrossCorrAnalysis                    = 0;      % 0 = don't do the analysis, 1 = do the analysis
       
nMaxSpots = 3; nMaxAnimals = 4; nMaxDays = 20;
nMaxUniqueROIs = 10E4; nMaxStoreFields = 20;
configStructs = cell(nMaxAnimals, nMaxDays, nMaxSpots);
caTracesStructs = cell(nMaxAnimals, nMaxDays, nMaxSpots);
caTracesGlobal = cell(nMaxUniqueROIs, nMaxStoreFields);
icaTracesGlobal = 1;

[~, rawComputerID] = system('hostname');
host = genvarname(rawComputerID);
analysisRootPaths = struct( ...
    'HIFOWSH640x2D03b', 'E:/Analysis/', ...
    'hifo01',           '/home/gc3-user/data/OCIA/', ...
    'hifo02',           '/home/gc3-user/data/OCIA/', ...
    'OoPC',             'D:/Users/BaL/PhD/AuditoryLearningAnalysis/');
analysisRootPath = analysisRootPaths.(host);

rawDataRootPaths = struct( ...
    'HIFOWSH640x2D03b', 'E:/Analysis/', ...
    'hifo01',           '/home/gc3-user/data/', ...
    'hifo02',           '/home/gc3-user/data/', ...
    'OoPC',             'D:/Users/BaL/PhD/AuditoryLearningRaw/');
rawDataRootPath = rawDataRootPaths.(host);

defaultFigurePositions = struct( ...
    'HIFOWSH640x2D03b', [10, 100, 1260, 840], ...
    'hifo01',           [10, 100, 1260, 840], ...
    'hifo02',           [10, 100, 1260, 840], ...
    'OoPC',             [25, 60, 1850, 930]);
defaultFigurePos = defaultFigurePositions.(host);
o('#runOCIABatchAnalysis: host: %s', host, 1, verb);

if matlabpool('size') < 1;
    matlabpool('open', feature('numCores'));
end;

%% do analysis
nTasks = numel(tasks);
for iTask = 1 : nTasks;
    
    o('##runOCIABatchAnalysis: task %02d/%02d ...', iTask, nTasks, 1, verb);
    if ~isfield(tasks{iTask}, host); continue; end;
    
    taskTic = tic; % for performance timing purposes
    runs = tasks{iTask}.(host).runs;
    o('##runOCIABatchAnalysis: T%02d - runs: "%s".', iTask, runs, 1, verb);
    nAnimals = numel(tasks{iTask}.(host).animals);
    
    for iAnim = 1 : nAnimals;
        animTic = tic; % for performance timing purposes
        animID = animalsIDs{tasks{iTask}.(host).animals(iAnim)};
        o('###runOCIABatchAnalysis: T%02d/%02d - %s (%02d/%02d) ...', iTask, nTasks, animID, iAnim, nAnimals, 1, verb);
        nDays = numel(tasks{iTask}.(host).days);

        for iDay = 1 : nDays;
            dayTic = tic; % for performance timing purposes
            dayID = dayIDs{tasks{iTask}.(host).days(iDay)};
            o('####runOCIABatchAnalysis: T%02d/%02d - %s (%02d/%02d) - %s (%02d/%02d) ...', iTask, nTasks, animID, ...
                iAnim, nAnimals, dayID, iDay, nDays, 1, verb);
            nSpots = numel(tasks{iTask}.(host).spots);

            for iSpot = 1 : nSpots;
                spotTic = tic; % for performance timing purposes
                spotID = spotIDs{tasks{iTask}.(host).spots(iSpot)};
                logTxt = sprintf(['#####runOCIABatchAnalysis: T%02d/%02d - %s (%02d/%02d) - %s (%02d/%02d) - ', ...
                    '%s (%02d/%02d)'], iTask, nTasks, animID, iAnim, nAnimals, dayID, iDay, nDays, ...
                    spotID, iSpot, nSpots);
                o('%s ...', logTxt, 1, verb);

                try

                    % do analysis
                    fileName = sprintf('%s%s.h5', analysisRootPath, regexprep(animID, '[^\d]', ''));
                    datasetPath = sprintf('/%s/%s/%s', animID, spotID, dayID);
                    o('%s: loading data from file "%s", dataset "%s" ...', logTxt, fileName, datasetPath, 1, verb);
                    data = loadDataFromHDF5(fileName, datasetPath);
                    
                    config = masterConfig;
                    config.saveName = regexprep(regexprep(datasetPath, '\/', '_'), '^_', '');

                    % get the ROISet of the first row
                    config.ROISet = data.ROISet{1, 1};
                    nROIs = size(config.ROISet, 1);
                    
                    % if no ROIs found, abort.
                    if ~nROIs;
                        o('>>>>> /!\\ ERROR in task %d, animal %s, day %s, spot %s, runs %s  /!\\ <<<<<<<', ...
                            iTask, animID, dayID, spotID, 1, verb);
                        o('Error while analysing: no ROISet found.', 1, verb);
                        continue;
                    end;

                    % set up the run names as the trials' names
                    config.runFileIDs = data.runIDs;
                    
                    % get the concatenated traces of the selected rows
                    caTraces = data.caTraces;
                    nRuns = size(caTraces, 1); % get the number of runs                    
                    % transform the data into a cell array of nROI x nRuns, with each cell containing the dFF/dRR trace
                    caTracesDataCell = cell(nROIs, nRuns);
                    for iRun = 1 : nRuns; % go through each run
                        for iROI = 1 : nROIs; % go through each ROI
                            caTracesDataCell{iROI, iRun} = caTraces{iRun}(iROI, :); % copy to the cell array
                        end;
                    end;
                    % load the traces in the configuration
                    config.ROIStatsData = caTracesDataCell;
                    
                    % set the stimulus vector in the configuration
                    config.stim = data.stim';

                    % do the calculation/processing and the plotting
                    caTracesOut = analyseROIStatsSingleDay(config);

                catch err;

                    o('>>>>> /!\ ERROR in task %d, animal %s, day %s, spot %s /!\ <<<<<<<', ...
                        iTask, animID, dayID, spotID, 1, verb);
                    o('Error while analysing: %s (%s)\n%s', err.message, err.identifier, getStackText(err), 1, verb);

                end;
                                
                o('#####runOCIABatchAnalysis: T%02d/%02d - %s (%02d/%02d) - %s (%02d/%02d) - %s (%02d/%02d) done (%.0f seconds).', ...
                    iTask, nTasks, animID, iAnim, nAnimals, dayID, iDay, nDays, spotID, iSpot, nSpots, ...
                    toc(spotTic), 1, verb);

            end;
            o('####runOCIABatchAnalysis: T%02d/%02d - %s (%02d/%02d) - %s (%02d/%02d) done (%.0f seconds).', iTask, nTasks, ...
                animID, iAnim, nAnimals, dayID, iDay, nDays, toc(dayTic), 1, verb);
        end;
        o('###runOCIABatchAnalysis: T%02d/%02d - %s (%02d/%02d) done (%.0f seconds).', iTask, nTasks, animID, iAnim, nAnimals, ...
            toc(animTic), 1, verb);
    end;
    o('##runOCIABatchAnalysis: task %02d/%02d done (%.0f seconds).', iTask, nTasks, toc(taskTic), 1, verb);
end;

o('#runOCIABatchAnalysis: done (%.0f seconds).', toc(allTic), 1, verb);

% matlabpool('close');

%{

%% Process each day with spots
for iDay = 1 : numel(daysWithSpot);
    
    % only target day(s)
    if any(masterConfig.targetDays) && ~any(masterConfig.targetDays == iDay); continue; end;
    dayTic = tic; % for performance timing purposes
    
    day = daysWithSpot(iDay);
    % list of spots with short name in notebook file
    spotList = day.spotList(:, 1);
    currentDate = day.day;
    
    o('  #analys...MultiDay(): processing day %d/%d: "%s", %d spot(s)...', iDay, numel(daysWithSpot), ...
        currentDate, numel(spotList), 2, verb);
    
    % perform analysis in different directory than the raw data directory
    analysisPath = [analysisPathExtended currentDate];
        
    %%  - Process each spot
    for iSpot = 1 : numel(spotList);
    
        % only target spot(s)    
        if any(masterConfig.targetSpots) && ~any(masterConfig.targetSpots == iSpot); continue; end;
        spotTic = tic; % for performance timing purposes
        spotNum = str2double(strrep(spotList{iSpot}, 'spot', ''));
        
        o('    #analys...MultiDay(): processing day %d/%d: "%s", spot %d/%d; "%s" ...', ...
            iDay, numel(daysWithSpot), currentDate, iSpot, numel(spotList), spotList{iSpot}, 2, verb);
    
        % prepare the path for the caTraces mat-file of this spot
        loadFileTic = tic; % for performance timing purposes
        spotPath = sprintf('%s%s%s', analysisPath, filesep, spotList{iSpot}, filesep);
        caTracesFileName = sprintf('%s_BF_%s_caTraces', currentDate, spotList{iSpot});
        ROIStatMatFilePath = sprintf('%s%s.mat', spotPath, caTracesFileName);
        
        % show warning if ROIStatas mat-file cannot be found
        if ~exist(ROIStatMatFilePath, 'file');
            warning('runOCIABatchAnalysis:caTracesFileNotFound', ...
                'Could not find caTraces file for day %d/%d: "%s", spot %d at "%s". Skipping.', ...
                iDay, numel(daysWithSpot), currentDate, iSpot, ROIStatMatFilePath);
            continue;
        end;
        
        % load the caTraces mat-file for this spot
        caTracesMatFile = load(ROIStatMatFilePath);
        config = caTracesMatFile.(['x' caTracesFileName]);
        o(['      #analys...MultiDay(): processing day %d/%d: "%s", spot %d/%d; "%s" ', ...
            'loading file done (%3.1f sec).'], iDay, numel(daysWithSpot), currentDate, iSpot, numel(spotList), ...
            spotList{iSpot}, toc(loadFileTic), 2, verb);
        
        % overwrite the fieldnames of the masterConfig for the plotting options
        fNames = fieldnames(masterConfig);
        for iField = 1 : numel(fNames);
            config.(fNames{iField}) = masterConfig.(fNames{iField});
        end;
    
        configStructs{iDay, spotNum} = config;
        % proceed to the analyscaTracesSingleDay (PScaTraces, BF, etc. calculations and plotting)
        analyseSingleDayTic = tic; % for performance timing purposes
        cd(spotPath);
        caTraces = analyseROIStatsSingleDay(config); % analyse stuff ! :D
        caTracesStructs{iDay, spotNum} = caTraces;
        ROISet = caTraces.ROISet;
        o(['      #analys...MultiDay(): processing day %d/%d: "%s", spot %d/%d; "%s" ', ...
            'analyseSingleDay done (%3.1f sec).'], iDay, numel(daysWithSpot), currentDate, iSpot, ...
            numel(spotList), spotList{iSpot}, toc(analyseSingleDayTic), 2, verb);
        
        if masterConfig.doMultiDayAnalysis;
            
            filt = 'sgfilt';

            % extract the depth from the CaImgExp mat-file
            fullRawDataPath = [rawDataRootPath year filesep animID filesep currentDate];
            stimFile = [fullRawDataPath filesep 'CaImgExp_' currentDate '.mat'];% load CaImgExp
            CaImgExpMat = load(stimFile); % load the CaImgExp mat-file
            iSpotInCaImgExp = str2double(strrep(spotList{iSpot}, 'spot', ''));
            spotStruct = CaImgExpMat.CaImgExp.spots{iSpotInCaImgExp};
            o(['      #analys...MultiDay(): processing day %d/%d: "%s", spot %d/%d; "%s" ', ...
                'depth loaded (%d um) (%3.1f sec).'], iDay, numel(daysWithSpot), currentDate, iSpot, ...
                numel(spotList), spotList{iSpot}, spotStruct.depth, toc(analyseSingleDayTic), 2, verb);

            % extract the number of ROIs (including neuropil) and create the range for this ROISet 
            %   in the global table 
            nROIs = size(ROISet, 1);
            caTracesGlobalRange = icaTracesGlobal : icaTracesGlobal + nROIs - 1;

            % extract all basic properties of the ROIs
            caTracesGlobal(caTracesGlobalRange, 1) = repmat({animID}, nROIs, 1);
            caTracesGlobal(caTracesGlobalRange, 2) = repmat({currentDate}, nROIs, 1);
            caTracesGlobal(caTracesGlobalRange, 3) = repmat(spotList(iSpot), nROIs, 1);
            caTracesGlobal(caTracesGlobalRange, 4) = repmat({spotStruct.depth}, nROIs, 1);
            caTracesGlobal(caTracesGlobalRange, 5) = ROISet(:, 1);  % ROIID
            caTracesGlobal(caTracesGlobalRange, 6) = repmat({'unknown'}, nROIs, 1);  % ROIType
            
            % add the raw caTraces for each ROI
            for iROI = 1 : nROIs;
                caTracesGlobal{caTracesGlobalRange(iROI), 7} = caTraces.PS.(filt).raw(iROI, :);
            end;
            
            % extract the noise properties of the ROIs
            caTracesGlobal(caTracesGlobalRange, 8) = num2cell(caTraces.stats.(filt).noiseLevels); % noise level
            
%             % allocate the structures to store responsiveness and tuning properties 
%             for iROI = 1 : nROIs;
%                 caTracesGlobal{caTracesGlobalRange(iROI), 9} = struct();
%                 caTracesGlobal{caTracesGlobalRange(iROI), 10} = struct();
%                 caTracesGlobal{caTracesGlobalRange(iROI), 11} = struct();
%                 caTracesGlobal{caTracesGlobalRange(iROI), 12} = struct();
%             end;
            
            % get the response "stat" types as unique fieldnames of the evokedResp structure
            respStats = unique(strrep(fieldnames(caTraces.stats.(filt).evokedResp), 'Err', ''));
            nStats = numel(respStats);
            UOF = {'UniformOutput', false};
            % get the evoked response for each ROI-stimulus-statType as 3D matrix
            evokedRespEachStats = reshape(cell2mat(cellfun(@(fName)caTraces.stats.(filt).evokedResp.(fName), ...
                respStats, UOF{:})), nStims, nStats, nROIs);
            % permute to have a nStats x nROIs x nStims matrix
            evokedRespEachStats = permute(evokedRespEachStats, [2 3 1]);
            % get the tuning properties for each ROI-statType as a nStats x nROIs matrix
            BFEachStats = cell2mat(cellfun(@(fName)caTraces.stats.(filt).tuning.(fName).BF, respStats, UOF{:}));
            maxRespAtBFEachStats = ...
                cell2mat(cellfun(@(fName)caTraces.stats.(filt).tuning.(fName).maxRespAtBF, respStats, UOF{:}));
            meanRespEachStats = ...
                cell2mat(cellfun(@(fName)caTraces.stats.(filt).tuning.(fName).meanResp, respStats, UOF{:}));
            tuningIndex = find(strcmp(respStats, masterConfig.tuningStat));
            
            % extract the evoked response for each "stat" type and the tuning properties for one stat type
            for iROI = 1 : nROIs;
                caTracesGlobal{caTracesGlobalRange(iROI), 9} = evokedRespEachStats(:, iROI, :);
                caTracesGlobal{caTracesGlobalRange(iROI), 10} = BFEachStats(tuningIndex, iROI);
                caTracesGlobal{caTracesGlobalRange(iROI), 11} = maxRespAtBFEachStats(tuningIndex, iROI);
                caTracesGlobal{caTracesGlobalRange(iROI), 12} = meanRespEachStats(tuningIndex, iROI);
            end;
            
            % increment the counter
            icaTracesGlobal = icaTracesGlobal + nROIs;
            
        end;
        o('    #analys...MultiDay(): processing day %d/%d: "%s", spot %d/%d; "%s" done (%3.1f sec).', iDay, ...
            numel(daysWithSpot), currentDate, iSpot, numel(spotList), spotList{iSpot}, toc(spotTic), 2, verb);
        
    end;
    o('  #analys...MultiDay(): processing day %d/%d: "%s", %d spot(s) done (%3.1f sec).', ...
        iDay, numel(daysWithSpot), currentDate, numel(spotList), toc(dayTic), 2, verb);
    
end;

if masterConfig.doMultiDayAnalysis;

    cd(analysisPathExtended);
    
    % remove useless pre-allocated empty cells
    caTracesGlobal(cellfun(@isempty, caTracesGlobal(:, 1)), :) = [];

    %% Create the ROIPresence plot
    ROIIDWithSpots = cell(size(caTracesGlobal, 1), 1);
    for iROI = 1 : size(ROIIDWithSpots, 1);
        ROIIDWithSpots{iROI} = sprintf('%s_%s', strrep(caTracesGlobal{iROI, 3}, 'spot', 'sp'), ...
            caTracesGlobal{iROI, 5});
    end;

    % define the unique variables and count them
    uniqueROIIds = unique(ROIIDWithSpots);
    uniqueDays = unique(caTracesGlobal(:, 2));
    uniqueSpots = unique(caTracesGlobal(:, 3));
    nROIs = size(uniqueROIIds, 1);
    nDays = size(uniqueDays, 1);
    nSpots = size(uniqueSpots, 1);

    % get the ROI presences and get their BF & peakEvokedResp
    ROIsPresence = zeros(nROIs, nDays);
    ROIsBF = zeros(nROIs, nDays);
    ROIsPeakEvokedResp = zeros(nROIs, nDays);
    ROIsDepth = zeros(nROIs, nDays);
    for iDay = 1 : nDays;
        for iROI = 1 : nROIs;
            ROIsPresence(iROI, iDay) = ~isempty(caTracesGlobal(strcmp(caTracesGlobal(:, 2), uniqueDays{iDay}) & ...
                strcmp(ROIIDWithSpots(:, 1), uniqueROIIds{iROI}), :));

            if ROIsPresence(iROI, iDay);
                ROIsBF(iROI, iDay) = caTracesGlobal{strcmp(caTracesGlobal(:, 2), uniqueDays{iDay}) & ...
                    strcmp(ROIIDWithSpots(:, 1), uniqueROIIds{iROI}), 10};
                ROIsPeakEvokedResp(iROI, iDay) = caTracesGlobal{...
                    strcmp(caTracesGlobal(:, 2), uniqueDays{iDay}) & ...
                    strcmp(ROIIDWithSpots(:, 1), uniqueROIIds{iROI}), 11};
                ROIsDepth(iROI, iDay) = caTracesGlobal{...
                    strcmp(caTracesGlobal(:, 2), uniqueDays{iDay}) & ...
                    strcmp(ROIIDWithSpots(:, 1), uniqueROIIds{iROI}), 4};
            else
                ROIsBF(iROI, iDay) = NaN;
                ROIsPeakEvokedResp(iROI, iDay) = NaN;
                ROIsDepth(iROI, iDay) = NaN;
            end;
        end;
    end;

    % get the middle index of the spots in the unique list to display the label
    spotIndexMiddles = zeros(1, nSpots);
    for iSpot = 1 : nSpots;
        spotIndexMiddles(iSpot) = mean(find(~cellfun(@isempty, strfind(uniqueROIIds, ...
            strrep(uniqueSpots{iSpot}, 'spot', 'sp')))));
    end;

    % plot the ROI Presence
    if masterConfig.doSaveROIPresencePlot;
        saveNameROIPres = sprintf('%s_ROIPresence', animID);
        figH = figure('Name', saveNameROIPres, 'NumberTitle', 'off');
        intensity = 0.4;
        colormap([intensity 0 0; 0 intensity 0; 0 intensity 0; 0 0 intensity]);
        ROIsPresence = ROIsPresence - 1;
        ROIsPresence(~cellfun(@isempty, strfind(uniqueROIIds, 'NPil')), :) = 1;
        imagesc(ROIsPresence, [-1 1]);
        set(gca, 'XTick', 1 : nDays, 'XTickLabel', uniqueDays, 'YTick', spotIndexMiddles, ...
            'YTickLabel', uniqueSpots, 'XLim', [0.5, nDays + 0.5], 'YLim', [0.5, nROIs + 0.5]);
        title(sprintf('ROI Presence for %s', animID), 'Interpreter', 'none');
        makePrettyFigure(figH);
        set(gca, 'FontSize', 8);
        saveFigToDir(figH, saveNameROIPres, 'multiDayAnalysis', ...
            masterConfig.doSaveROIPresencePlot, 1, 1);
    end;
    
    %% spots response probability
    spotRespProb = zeros(1, nSpots);
    spotRespProbErr = zeros(1, nSpots);
    respProbIndex = find(strcmp(respStats, 'respProb'));
    if respProbIndex;
        for iSpot = 1 : nSpots;
            spotRespProbAllROIsCell = caTracesGlobal(~cellfun(@isempty, strfind(ROIIDWithSpots, ...
                strrep(uniqueSpots{iSpot}, 'spot', 'sp'))), 9);
            spotRespProbAllROIs = cell2mat(cellfun(@(x)reshape(x(respProbIndex, 1, :), 1, nStims), ...
                spotRespProbAllROIsCell, UOF{:})); %#ok<FNDSB>
            spotRespProb(iSpot) = nanmean(spotRespProbAllROIs(:));
    %         spotRespProbErr(iSpot) = nansem(spotRespProbAllROIs(:));
            spotRespProbErr(iSpot) = nanstd(spotRespProbAllROIs(:));
        end;

        % plot if required
        if masterConfig.doSaveSpotRespProbPlot;
            saveNameRespProb = sprintf('%s_SpotsRespProb', animID);
            figRespProb = figure('Name', saveNameRespProb, 'NumberTitle', 'off');
            hold all;
            for iSpot = 1 : nSpots;
                errorbar(iSpot, spotRespProb(iSpot), spotRespProbErr(iSpot), '.');
            end;
            legend(arrayfun(@(iSpot)sprintf('%s (N=%d)', uniqueSpots{iSpot}, ...
                sum(~cellfun(@isempty, strfind(ROIIDWithSpots, strrep(uniqueSpots{iSpot}, 'spot', 'sp'))))), ...
                1 : nSpots, 'UniformOutput', false)');
            xlabel('Spots'); ylabel('Mean response probability of all ROIs for each spot');
            set(gca, 'XLim', [0.9, nSpots + 0.1], 'YLim', [0 1], 'YTick', (1 : 10) / 10, 'YTickLabel', (1 : 10) / 10, ...
                'XTick', 1 : nSpots, 'XTickLabel', uniqueSpots);
            title('Spots response probability accross all days');
            makePrettyFigure();
            saveFigToDir(figRespProb, saveNameRespProb, 'multiDayAnalysis', masterConfig.doSaveNvsNP1Plots, 1, 1);
        end;
    end;
    
    %% spots tuning
    spotTun = zeros(1, nSpots);
    spotTunErr = zeros(1, nSpots);
    for iSpot = 1 : nSpots;
        spotTunAllROIsCell = caTracesGlobal(~cellfun(@isempty, strfind(ROIIDWithSpots, ...
            strrep(uniqueSpots{iSpot}, 'spot', 'sp'))), 9);
        spotTunAllROIs = cell2mat(cellfun(@(x)reshape(x(tuningIndex, 1, :), 1, nStims), spotTunAllROIsCell, UOF{:}));
        spotTun(iSpot) = nanmean(spotTunAllROIs(:));
%         spotRespProbErr(iSpot) = nansem(spotRespProbAllROIs(:));
        spotTunErr(iSpot) = nanstd(spotTunAllROIs(:));
    end;
    
    % plot if required
    if masterConfig.doSaveSpotTunPlot;
        saveNameTun = sprintf('%s_SpotsTuning', animID);
        figTun = figure('Name', saveNameTun, 'NumberTitle', 'off');
        hold all;
        for iSpot = 1 : nSpots;
            errorbar(iSpot, spotTun(iSpot), spotTunErr(iSpot), '.');
        end;
        legend(arrayfun(@(iSpot)sprintf('%s (N=%d)', uniqueSpots{iSpot}, ...
            sum(~cellfun(@isempty, strfind(ROIIDWithSpots, strrep(uniqueSpots{iSpot}, 'spot', 'sp'))))), ...
            1 : nSpots, 'UniformOutput', false)');
        xlabel('Spots'); ylabel('Max tuning of all ROIs for each spot');
        set(gca, 'XLim', [0.9, nSpots + 0.1], 'XTick', 1 : nSpots, 'XTickLabel', uniqueSpots);
        title('Spots tuning accross all days');
        makePrettyFigure();
        saveFigToDir(figTun, saveNameTun, 'multiDayAnalysis', masterConfig.doSaveNvsNP1Plots, 1, 1);
    end;
    
    % plot if required
    if masterConfig.doSaveSpotDayTimeCoursePlot;
        
        for iSpot = 1 : nSpots;
            %% plot for current spot
            spotNum = str2double(strrep(uniqueSpots{iSpot}, 'spot', ''));
            saveNameSpotDayTC = sprintf('%s_%s_dayTimeCourse', animID, uniqueSpots{iSpot});
            figH = figure('Name', saveNameSpotDayTC, 'NumberTitle', 'off');
            
            % get the days where the spot is present
            daysForSpot = {};
            for iDay = 1 : nDays;
                if any(strcmp(caTracesGlobal(:, 2), uniqueDays{iDay}) & ...
                    strcmp(caTracesGlobal(:, 3), uniqueSpots{iSpot}));
                    daysForSpot{end + 1} = uniqueDays{iDay}; %#ok<AGROW>
                end;
            end;
            
            nDaysForSpot = numel(daysForSpot);
            for iDay = 1 : nDaysForSpot;
                
                subplot(3, nDaysForSpot, iDay);
                for iDayWS = 1 : numel(daysWithSpot);
                    if strcmp(daysWithSpot(iDayWS).day, daysForSpot{iDay});
                        dayNum = iDayWS;
                        break;
                    end;
                end;
%                 matFilePath = sprintf('./%s/%s/%s.mat', daysForSpot{iDay}, uniqueSpots{iSpot}, ...
%                     configStructs{dayNum, spotNum}.runFileIDs{2});
%                 matFileStruct = load(matFilePath);
%                 refImg = matFileStruct.(genvarname(configStructs{dayNum, spotNum}.runFileIDs{2})).refImg;
                
                refChannel = 2;
                expInfoFilePath = sprintf('./%s/ExperimentInfo.mat', daysForSpot{iDay});
                expInfoStruct = load(expInfoFilePath);
                expInfo = expInfoStruct.expInfo;
                refImagesFileName = expInfo(strcmp(uniqueSpots{iSpot}, expInfo(:, 1)) ...
                    & strcmp(expInfo(:, 2), 'Ref256x'), :);
                firstRefImageFileName = refImagesFileName{1, 3};
                
                matFilePath = sprintf('./%s/%s/%s.mat', daysForSpot{iDay}, uniqueSpots{iSpot}, ...
                    firstRefImageFileName);
                matFileStruct = load(matFilePath);
                refImg = matFileStruct.(genvarname(firstRefImageFileName)).img_data;

                imshow(imadjust(linScale(double(refImg{refChannel}))));
                title(sprintf('Day %d', iDay));
                set(gca, 'Visible', 'off');
                
                
                subplot(3, nDaysForSpot, [iDay + nDaysForSpot, iDay + 2 * nDaysForSpot]);
                evokedRespsAll = caTracesStructs{dayNum, spotNum}.PS.sgfilt.trial.mean.allNorm;
                nSpotROIs = size(evokedRespsAll, 2);
%                 selROIs = 1 : nSpotROIs;
                selROIs = unique(randi(nSpotROIs, min(round(nSpotROIs * 0.5), 7), 1));
%                 selROIs = [2 6 8 22 23 24]; 130711_01 - spot04
%                 selROIs = [1 : 4, 7, 15, 17]; 130711_01 - spot02
                caTracesStructs{dayNum, spotNum}.ROISet(selROIs, 1);
                nSelROIs = numel(selROIs);
%                 selStims = [2 5 8 9 13];
                selStims = 1 : nStims;
                nSelStims = numel(selStims);
                hold on;
                evokedRespsToDisplay = evokedRespsAll(:, selROIs, selStims);
                minData = min(evokedRespsToDisplay(:));
                maxData = max(evokedRespsToDisplay(:));
                yShift = abs(maxData) + abs(minData);
                for iSelROI = 1 : nSelROIs;
                    iROI = selROIs(iSelROI);
                    evokedResps = evokedRespsAll(:, iROI, selStims);
                    evokedResps = reshape(evokedResps, size(evokedResps, 1), nSelStims);
                    plot(evokedResps + yShift * (iSelROI) + minData);
                end;
%                 set(gca, 'Visible', 'off');
                ylim([-2, yShift * nSelROIs]);
                
            end;
            
%             tightfig();
            makePrettyFigure();
            saveFigToDir(figH, saveNameSpotDayTC, 'multiDayAnalysis', masterConfig.doSaveSpotDayTimeCoursePlot, 1, 1);
        end;
    end;

    %% do the N VS N+1 plots for each spot and pooled
    if masterConfig.doSaveNvsNP1Plots;
        
        groupMethods = {'ROIName', 'SpotName', 'Depth'};
        nGroups = numel(groupMethods);
        animalShortID = strrep(animID, 'mou_bl_', '');
        
        for iSpot = 1 : nSpots + 1;
            if iSpot == nSpots + 1;
                spotShortName = 'allSpots';
                ROIIndForSpot = true(nROIs, 1);
            else
                spotShortName = strrep(uniqueSpots{iSpot}, 'spot', 'sp');
                ROIIndForSpot = ~cellfun(@isempty, strfind(uniqueROIIds, spotShortName));
            end;
            
            ROIsBFForSpot = ROIsBF(ROIIndForSpot, :);
            ROIsPeakEvokedRespForSpot = ROIsPeakEvokedResp(ROIIndForSpot, :);
            uniqueROIIdsForSpot = uniqueROIIds(ROIIndForSpot);
            
            figH = figure('NumberTitle', 'off', 'Name', sprintf('%s_%s', animalShortID, spotShortName));
            for iGroup = 1 : nGroups;
                groupMeth = groupMethods{iGroup};
                switch groupMeth;
                    case 'ROIName';
                        % group by ROI name - one color per ROI
                        groupingIDs = uniqueROIIdsForSpot;
                    case 'SpotName';
                        % group by spot - one color per spot
                        groupingIDs = regexprep(uniqueROIIdsForSpot, '_(\d+|NPil)', '');
                    case 'Depth';
                        % group by depth - color depends on depth
                        ROIMeanDepth = nanmean(ROIsDepth(ROIIndForSpot, :), 2);
                        minDepth = min(ROIMeanDepth);
                        groupingIDs = round(ROIMeanDepth - minDepth);
                end;

                subplot(2, nGroups, iGroup);
                saveName = sprintf('%s_%s_NVSNP1_BF_%s', animalShortID, spotShortName, groupMeth);
                plotNVSNP1(ROIsBFForSpot / 1000, groupingIDs, 'Best Freq. [kHz]', saveName, 1, verb);

                subplot(2, nGroups, iGroup + nGroups);
                saveName = sprintf('%s_%s_NVSNP1_PeakResp_%s', animalShortID, spotShortName, groupMeth);
                plotNVSNP1(ROIsPeakEvokedRespForSpot, groupingIDs, ...
                    'Max Evoked Resp. [% dFF/dRR]', saveName, 1, verb);
            end;
            
            saveFigToDir(figH, sprintf('%s_%s_NVSNP1', animalShortID, spotShortName), 'multiDayAnalysis', ...
                masterConfig.doSaveNvsNP1Plots, 1, 1);
        end;
    end;

    
end;

%}

end

