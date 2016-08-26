function ROIStatsDataGlobal = analyseROIStatsHDF5()

%% init
verb = 2;
o('#analyseROIStatsHDF5: timestamp: %s', datestr(now), 1, verb);

...%                   1                   2                    3                    4
animalIDs = { 'mou_bl_140109_01', 'mou_bl_140109_02' , 'mou_bl_140110_01', 'mou_bl_140110_02' };

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

hostName = 'HIFOWSH640x2D03b';
% hostName = 'HIFOWSH300x2D03';
% hostName = 'OoPC';

tasks = { ...
        struct( hostName, struct('animals', 1, 'days',  3, 'spots',  1     ,                   'runs', '')) ...
    };

%{
tasks = { ...
        struct( hostName, struct('animals', 1, 'days',  3, 'spots',  1     ,                   'runs', '')), ...
        struct( hostName, struct('animals', 1, 'days',  4, 'spots', [1 2  ],                   'runs', '')), ...
        struct( hostName, struct('animals', 1, 'days',  7, 'spots',  1     , 'behavID', 'B01', 'runs', '')), ...
        struct( hostName, struct('animals', 1, 'days',  7, 'spots',    2   , 'behavID', 'B02', 'runs', '')), ...
        struct( hostName, struct('animals', 1, 'days',  7, 'spots',  1     , 'behavID', 'B03', 'runs', '')), ...
        struct( hostName, struct('animals', 1, 'days',  7, 'spots',    2   , 'behavID', 'B04', 'runs', '')), ...
        struct( hostName, struct('animals', 1, 'days',  8, 'spots',    2   , 'behavID', 'B02', 'runs', '')), ...
        struct( hostName, struct('animals', 1, 'days',  8, 'spots',      3 , 'behavID', 'B03', 'runs', '')), ...
        struct( hostName, struct('animals', 1, 'days',  8, 'spots',    2   , 'behavID', 'B05', 'runs', '')), ...
        struct( hostName, struct('animals', 1, 'days',  8, 'spots',      3 ,'behavID','B0[67]','runs', '')), ...
        struct( hostName, struct('animals', 1, 'days',  9, 'spots', [1 2 3],                   'runs', '')), ...
        struct( hostName, struct('animals', 1, 'days', 10, 'spots', [1 2  ],                   'runs', '')), ...
        struct( hostName, struct('animals', 1, 'days', 11, 'spots', [1 2 3],                   'runs', '')), ...
        struct( hostName, struct('animals', 1, 'days', 13, 'spots', [1 2 3],                   'runs', '')), ...
        struct( hostName, struct('animals', 1, 'days', 15, 'spots', [1 2 3],                   'runs', '')), ...
        struct( hostName, struct('animals', 1, 'days', 16, 'spots', [1 2  ],                   'runs', '')), ...
        struct( hostName, struct('animals', 1, 'days', 18, 'spots', [  2 3],                   'runs', '')), ...
        struct( hostName, struct('animals', 1, 'days', 20, 'spots', [  2 3],                   'runs', '')), ...
        struct( hostName, struct('animals', 1, 'days', 22, 'spots', [  2 3],                   'runs', '')), ...
        struct( hostName, struct('animals', 2, 'days', 18, 'spots', [1 2  ],                   'runs', '')), ...
        struct( hostName, struct('animals', 3, 'days', 20, 'spots', [1 2  ],                   'runs', '')), ...
        struct( hostName, struct('animals', 4, 'days',  5, 'spots', [1 2  ],                   'runs', '')), ...
        struct( hostName, struct('animals', 4, 'days',  7, 'spots', [1 2  ],                   'runs', '')), ...
        struct( hostName, struct('animals', 4, 'days',  8, 'spots',    2   , 'behavID', 'B02', 'runs', '')), ...
        struct( hostName, struct('animals', 4, 'days',  8, 'spots',    2   , 'behavID', 'B04', 'runs', '')), ...
        struct( hostName, struct('animals', 4,'days',9:11, 'spots',    2   ,                   'runs', '')), ...
        struct( hostName, struct('animals', 4, 'days', 13, 'spots',    2   ,                   'runs', '')), ...
        struct( hostName, struct('animals', 4, 'days', 15, 'spots',    2   ,                   'runs', '')), ...
        struct( hostName, struct('animals', 4, 'days', 16, 'spots', [1 2  ],                   'runs', '')), ...
        struct( hostName, struct('animals', 4, 'days', 18, 'spots', [1 2  ],                   'runs', '')), ...
        struct( hostName, struct('animals', 4, 'days', 20, 'spots', [1 2  ],                   'runs', '')), ...
        struct( hostName, struct('animals', 4, 'days', 22, 'spots', [1 2  ],                   'runs', ''))  ...
    };
%}

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


o('#analyseROIStatsHDF5: host: %s', host, 1, verb);

%% run

% cell array with one row per animal-spot-day combination and 5 columns: [animal, spot, day, raw data, ROIStats]
ROIStatsDataGlobal = cell(300, 5);
iRow = 1;

% matlabpool('open', feature('numCores'));

o('#analyseROIStatsHDF5: loading & pre-processing ...', 1, verb);
loadPreProcTic = tic; % for performance timing purposes
nTasks = numel(tasks);
for iTask = 1 : nTasks;
    
    o('##analyseROIStatsHDF5: T%02d/%02d ...', iTask, nTasks, 1, verb);
    if ~isfield(tasks{iTask}, host); continue; end;
    taskTic = tic; % for performance timing purposes
    nAnimals = numel(tasks{iTask}.(host).animals);
    
    for iAnimal = 1 : nAnimals;
        animalTic = tic; % for performance timing purposes
        animalID = animalIDs{tasks{iTask}.(host).animals(iAnimal)};
        o('###analyseROIStatsHDF5: T%02d/%02d - %s (%02d/%02d) ...', iTask, nTasks, animalID, iAnimal, nAnimals, 1, verb);
        nSpots = numel(tasks{iTask}.(host).spots);

        for iSpot = 1 : nSpots;
            spotTic = tic; % for performance timing purposes
            animSpotDayID = spotIDs{tasks{iTask}.(host).spots(iSpot)};
            o('####analyseROIStatsHDF5: T%02d/%02d - %s (%02d/%02d) - %s (%02d/%02d) ...', ...
                iTask, nTasks, animalID, iAnimal, nAnimals, animSpotDayID, iSpot, nSpots, 1, verb);
            nDays = numel(tasks{iTask}.(host).days);


            for iDay = 1 : nDays;
                dayTic = tic; % for performance timing purposes
                dayID = dayIDs{tasks{iTask}.(host).days(iDay)};
                o('#####analyseROIStatsHDF5: T%02d/%02d - %s (%02d/%02d) - %s (%02d/%02d) - %s (%02d/%02d) ...', ...
                    iTask, nTasks, animalID, iAnimal, nAnimals, animSpotDayID, iSpot, nSpots, dayID, iDay, nDays, 1, verb);
            
                
                filePath = sprintf('%s/%s.h5', analysisRootPath, regexprep(animalID, '(mou_bl_|_)', ''));
                datasetPath = sprintf('/%s/%s/%s', animalID, animSpotDayID, dayID);
                
                try

                    [data, ROIStatsData] = analyseROIStatsHDF5Single(filePath, datasetPath, config);
                    ROIStatsDataGlobal(iRow, :) = {animalID, animSpotDayID, dayID, data, ROIStatsData};
                    iRow = iRow + 1;

                catch err;

                    o(['#####analyseROIStatsHDF5: /!\\ ERROR at T%02d/%02d - %s (%02d/%02d) - %s (%02d/%02d) - ', ...
                        '%s (%02d/%02d) /!\\ <<<<<<<'], iTask, nTasks, animalID, iAnimal, nAnimals, ...
                        animSpotDayID, iSpot, nSpots, dayID, iDay, nDays, 1, verb);
                    o('#####analyseROIStatsHDF5: %s (%s)\n%s', err.message, err.identifier, getStackText(err), 1, verb);

                end;
                                
                o(['#####analyseROIStatsHDF5: T%02d/%02d - %s (%02d/%02d) - %s (%02d/%02d) - %s (%02d/%02d) ', ...
                    'done (%.0f seconds).'], iTask, nTasks, animalID, iAnimal, nAnimals, animSpotDayID, iSpot, nSpots, ...
                    dayID, iDay, nDays, toc(spotTic), 1, verb);

            end;
            o('####analyseROIStatsHDF5: T%02d/%02d - %s (%02d/%02d) - %s (%02d/%02d) done (%.0f seconds).', ...
                iTask, nTasks, animalID, iAnimal, nAnimals, animSpotDayID, iSpot, nSpots, toc(dayTic), 1, verb);
        end;
        o('###analyseROIStatsHDF5: T%02d/%02d - %s (%02d/%02d) done (%.0f seconds).', iTask, nTasks, animalID, ...
            iAnimal, nAnimals, toc(animalTic), 1, verb);
    end;
    o('##analyseROIStatsHDF5: task %02d/%02d done (%.0f seconds).', iTask, nTasks, toc(taskTic), 1, verb);
end;

% remove empty cells
ROIStatsDataGlobal(arrayfun(@(i)~any(~cellfun(@isempty, ROIStatsDataGlobal(i, :))), ...
    1 : size(ROIStatsDataGlobal, 1)), :) = [];

o('#analyseROIStatsHDF5: loading & pre-processing done (%.0f seconds).', toc(loadPreProcTic), 1, verb);

%% saving

save(sprintf('%s/ROIStatsDataGlobal.mat', analysisRootPath), 'ROIStatsDataGlobal', '-v7.3');

%% analyse

% load the dPrime values
dPrimes = {'2014_02_10',-0.450,NaN,NaN,0;'2014_02_11',0.760,NaN,NaN,-0.270;'2014_02_12',1.75,NaN,NaN,0.170;...
    '2014_02_13',2.12,NaN,NaN,0.660;'2014_02_14',2.07,-0.500,-0.920,0.770;'2014_02_15',2.81,0.860,0.140,1.02;...
    '2014_02_16',2.76,1.83,1.20,1.76;'2014_02_17',2.66,2.87,1.18,2.54;'2014_02_18',1.98,2.64,2.40,3.11;...
    '2014_02_19',1.63,2.21,1.98,3.36;'2014_02_20',1.46,2.03,2.56,3.95;'2014_02_21',1.75,1.61,2.28,4.36;...
    '2014_02_22',1.81,1.53,2.27,4.29;'2014_02_23',2.12,1.36,2.63,3.83;'2014_02_24',1.97,NaN,2.04,3.47;...
    '2014_02_25',2.83,NaN,2.35,3.48;};

learnGroups = {'2014_02_10',1,NaN,NaN,1;'2014_02_11',1,NaN,NaN,1;'2014_02_12',2,NaN,NaN,1;'2014_02_13',2,NaN,NaN,1;...
    '2014_02_14',2,1,1,1;'2014_02_15',2,1,1,1;'2014_02_16',2,1,1,1;'2014_02_17',2,2,1,2;'2014_02_18',2,2,2,2;...
    '2014_02_19',3,2,2,2;'2014_02_20',3,2,2,2;'2014_02_21',3,3,2,2;'2014_02_22',3,3,2,3;'2014_02_23',3,3,3,3;...
    '2014_02_24',3,NaN,3,3;'2014_02_25',3,NaN,3,3;};

excludeROIs = cell(size(ROIStatsDataGlobal, 1), 1);
% excludeROIs = {[44 46],[],73,[9,13,37,55],[15,33],14,[6,10,35],[8,10,11,16,17,18,23,31,37],[3,42,82,86],...
%     [7,10,14,50,52],[1,4,5,6,8,10,11,15,16,18,20,25,30,35,40,41,42],[3,9,64,72,86],[],[],[6,32],6,...
%     [9,14,18],8,[9,36],9};

% init
UF = {'UniformOutput', false};
config = getAnalyseROIStatsDefaultConfig();
nPSFrames = config.PSFrames.base + config.PSFrames.evoked;
t = ((1 : (nPSFrames)) - config.PSFrames.base) / config.frameRate;
stimDur = 0.2;
stimFrames = config.PSFrames.base : config.PSFrames.base + stimDur * config.frameRate;

% ROIStatsDataGlobal = ROIStatsDataGlobalSave; % RESTORE
% ROIStatsDataGlobalSave = ROIStatsDataGlobal; % SAVE
for iRow = 1 : size(ROIStatsDataGlobal, 1);
    
    % raw data
    ROIStatsDataGlobal{iRow, 4}.ROISet{1, 1}(excludeROIs{iRow}, :) = [];
    for iRun = 1 : size(ROIStatsDataGlobal{iRow, 4}.caTraces);
        ROIStatsDataGlobal{iRow, 4}.caTraces{iRun}(excludeROIs{iRow}, :) = [];
    end;
    
    % processed data
    ROIStatsDataGlobal{iRow, 5}.ROISet(excludeROIs{iRow}, :) = [];
    ROIStatsDataGlobal{iRow, 5}.runs.unfilt(excludeROIs{iRow}, :) = [];
    ROIStatsDataGlobal{iRow, 5}.runs.sgfilt(excludeROIs{iRow}, :) = [];
    ROIStatsDataGlobal{iRow, 5}.PS.unfilt.raw(excludeROIs{iRow}, :) = [];
    ROIStatsDataGlobal{iRow, 5}.PS.unfilt.norm(excludeROIs{iRow}, :) = [];
    ROIStatsDataGlobal{iRow, 5}.PS.sgfilt.raw(excludeROIs{iRow}, :) = [];
    ROIStatsDataGlobal{iRow, 5}.PS.sgfilt.norm(excludeROIs{iRow}, :) = [];
    ROIStatsDataGlobal{iRow, 5}.stats.sgfilt.crossCorrResp(excludeROIs{iRow}, :) = [];
end;

excludeSpots = [13 14];
ROIStatsDataGlobal(excludeSpots, :) = [];

% get number of spots and neurons
nSpots = size(ROIStatsDataGlobal, 1);
nNeurons = cell2mat(cellfun(@(x)size(x.ROISet, 1), ROIStatsDataGlobal(:, 5), UF{:}));
nTotNeurons = sum(nNeurons);

% define learn groups
learnGroupLabels = {'Naive', 'Early Expert', 'Late Expert'};
learnGroupNames = regexprep(learnGroupLabels, '[\. _]', '');
nLearnGroups = numel(learnGroupLabels);

% 4 columns: unique animal-spot ID, dayID (day number), dPrime, learnGroup
spotIDs = cell(nSpots, 4);
dayOffset = find(strcmp(dPrimes{1, 1}, dayIDs)) - 1;
for iSpot = 1 : nSpots;
    
    % get the unique animal-spot ID
    animalID = ROIStatsDataGlobal{iSpot, 1};
    animSpotDayID = ROIStatsDataGlobal{iSpot, 2};
    dayID = ROIStatsDataGlobal{iSpot, 3};
    spotIDs{iSpot, 1} = sprintf('%s_%s', regexprep(animalID, '(mou_bl_|_)', ''), regexprep(animSpotDayID, 'spot', 'sp'));
  
    % get the dayID
    for iDaySpot = 1 : nSpots;
        % get the unique animal-spot ID
        animSpotID = regexprep(regexprep(cell2mat(ROIStatsDataGlobal(iDaySpot, 1 : 2)), ...
            '(mou_bl_|_)', ''), 'spot', '_sp');
        if strcmpi(animSpotID, spotIDs{iSpot, 1});
            if strcmpi(ROIStatsDataGlobal{iDaySpot, 3}, dayID)
                spotIDs{iSpot, 2} = find(strcmp(dayID, dayIDs));
                break;
            end;
        end;
    end;
    
    % get the dPrime
    
    spotIDs{iSpot, 3} = dPrimes{find(strcmp(dayID, dayIDs)) - dayOffset, 1 + find(strcmp(animalID, animalIDs))};
    % get the learn-group ID
    spotIDs{iSpot, 4} = learnGroups{find(strcmp(dayID, dayIDs)) - dayOffset, 1 + find(strcmp(animalID, animalIDs))};
    
end;
uniqueSpotIDs = unique(spotIDs(:, 1));
nUniqueSpots = numel(uniqueSpotIDs);

o('#analyseROIStatsHDF5: analysing %d spots (%d unique, %d neurons) ...', nSpots, nUniqueSpots, nTotNeurons, 1, verb);

% dayGroups = cell2mat(spotInfo(:, 2))';
% spotGroups = {[1 2 5], [NaN 3 6], [NaN 4 7], [NaN NaN 8], [NaN NaN 9], [NaN NaN 10], [NaN NaN 11], [NaN 12 14], ...
%     [NaN 13 15]};

spotGroups = cell(nUniqueSpots, 1);
maxNDaysPerGroup = 10;
for iSpot = 1 : nUniqueSpots;
    
    animSpotDayID = uniqueSpotIDs{iSpot};
    spotGroups{iSpot} = nan(nLearnGroups, maxNDaysPerGroup);
    for iLearnGroup = 1 : nLearnGroups;
        spotsForLearnGroup = find(strcmp(spotIDs(:, 1), animSpotDayID) & cell2mat(spotIDs(:, 4)) == iLearnGroup);
        if ~isempty(spotsForLearnGroup);
            spotGroups{iSpot}(iLearnGroup, 1 : numel(spotsForLearnGroup)) = spotsForLearnGroup;
        end;
    end;
    
    
end;

% get all the cross-correlation values for each spot
crossCorrs = cellfun(@(x)x.stats.sgfilt.crossCorrResp, ROIStatsDataGlobal(:, 5), UF{:});
% get which stimulus is the target stimulus
targets = nan(1, nSpots);
for iSpot = 1 : nSpots;
    [~, targetIndex] = find(cell2mat(ROIStatsDataGlobal{iSpot, 4}.behav.target), 1);
    targets(iSpot) = ROIStatsDataGlobal{iSpot, 4}.behav.stim{targetIndex};
end;
% get a "swapped" version of the cross correlations
crossCorrsSwapped = cellfun(@(x)x(:, [2, 1]), crossCorrs, UF{:});
% create a cell array with always the target stimulus in first position
crossCorrsTarg = crossCorrs;
crossCorrsTarg(targets == 2) = crossCorrsSwapped(targets == 2);

doSavePlots = 0;

%% responsive fraction
yLims = [-0.05 1.05];
% yLims = [-0.05 0.75];
for iGroup = 1 : nLearnGroups;
    %% responsive fraction single group
    groupMask = cell2mat(spotIDs(:, 4)) == iGroup;
    
    set(0, 'DefaultFigurePosition', [150, 350, 625, 550]);
    figure('Name', sprintf('respNeurFracCrossCorr_%s', learnGroupNames{iGroup}), 'NumberTitle', 'off');
    respFracMean = cell2mat(cellfun(@(x)sum(~isnan(x))/size(x, 1), crossCorrsTarg(groupMask), UF{:}));

    col = [1 0 0; 0 0 0];
    b = 0.7;
    colLight = [1 b b; b b b];

    % barpplot  
    if size(respFracMean, 1) == 1;
        barH = bar(respFracMean);
        childH = get(barH, 'Children');
        for iChild = 1 : numel(childH);
            set(childH(iChild), 'FaceColor', col(iChild, :));
        end;

    % boxplot
    else
        h = notBoxPlot(respFracMean, [], 0.2, 'sdline');
        set(gca, 'YLim', yLims);
        for iStim = 1 : 2;
        %     set(h(iStim).data, 'MarkerFaceColor', col(iStim, :), 'MarkerEdgeColor', [0 0 0]);
            set(h(iStim).data, 'Marker', 'x', 'MarkerSize', 5, ...
                'MarkerFaceColor', col(iStim, :), 'MarkerEdgeColor', col(iStim, :));
            set(h(iStim).mu, 'Color', col(iStim, :));
            set(h(iStim).semPtch, 'FaceColor', colLight(iStim, :));
            set(h(iStim).sd, 'Color', col(iStim, :));
        end;

    end;

    set(gca, 'XTickLabel', {'Target', 'Distractor'});
    ylabel('Fraction of responsive neurons');

    title(sprintf(['Fraction of responsive neurons for the %s group\n{\\fontsize{10}N = %d imaging regions ', ...
        '(%d neurons)}'], learnGroupLabels{iGroup}, size(crossCorrs(groupMask), 1), sum(nNeurons(groupMask))));
    makePrettyFigure(gcf);
    saveFigToDir(gcf, get(gcf, 'Name'), sprintf('%s/Plots/RespFrac', analysisRootPath), doSavePlots, 1, 1);
end;

%% responsive fraction grouped 
yLims = [-0.05 1.05];
% yLims = [-0.05 0.75];
set(0, 'DefaultFigurePosition', [150, 350, 625, 550]);
figure('Name', 'respNeurFracCrossCorrGrouped', 'NumberTitle', 'off');
hold on;
xPos = nan(nLearnGroups * 2, 1);
meanXPos = nan(nLearnGroups, 1);
for iGroup = 1 : nLearnGroups;
    
    groupMask = cell2mat(spotIDs(:, 4)) == iGroup;
    respFracMean = cell2mat(cellfun(@(x)sum(~isnan(x))/size(x, 1), crossCorrsTarg(groupMask), UF{:}));
    col = [1 0 0; 0 0 0];
    b = 0.7;
    colLight = [1 b b; b b b];
    
    xPos((iGroup - 1) * 2 + 1 : (iGroup - 1) * 2 + 2) = [0.25 0.75] + (iGroup - 1) * 1.5;
    meanXPos(iGroup) = nanmean(xPos((iGroup - 1) * 2 + 1 : (iGroup - 1) * 2 + 2));
    h = notBoxPlot(respFracMean, xPos((iGroup - 1) * 2 + 1 : (iGroup - 1) * 2 + 2), 0.3, 'sdline');
    for iStim = 1 : 2;
        set(h(iStim).data, 'Marker', 'x', 'MarkerSize', 5, ...
            'MarkerFaceColor', col(iStim, :), 'MarkerEdgeColor', col(iStim, :));
        set(h(iStim).mu, 'Color', col(iStim, :));
        set(h(iStim).semPtch, 'FaceColor', colLight(iStim, :));
        set(h(iStim).sd, 'Color', col(iStim, :));
    end;
end;
%{
%% significance test
respFracGroupPVals = nan(nLearnGroups * (nLearnGroups - 1) / 2, 2);
iCount = 1;
for iGroupRef = 1 : nLearnGroups;
    groupRefMask = cell2mat(spotInfo(:, 4)) == iGroupRef;
    respFracMeanRef = cell2mat(cellfun(@(x)sum(~isnan(x))/size(x, 1), crossCorrsTarg(groupRefMask), UF{:}));
    for iGroup = iGroupRef + 1 : nLearnGroups;
        groupMask = cell2mat(spotInfo(:, 4)) == iGroup;
        respFracMean = cell2mat(cellfun(@(x)sum(~isnan(x))/size(x, 1), crossCorrsTarg(groupMask), UF{:}));
        o('Testing %s (%d) against %s (%d): ', learnGroupLabels{iGroupRef}, iGroupRef, ...
            learnGroupLabels{iGroup}, iGroup, 1, verb);
        respFracGroupPVals(iCount, 1) = ttest2(respFracMeanRef(:, 1), respFracMean(:, 1));
        respFracGroupPVals(iCount, 2) = ttest2(respFracMeanRef(:, 2), respFracMean(:, 2));
        iCount = iCount + 1;
    end;
end;

%% finish plotting
%}
set(gca, 'YLim', yLims, 'XLim', [-0.5 4.5]);
set(gca, 'XTick', meanXPos, 'XTickLabel', learnGroupLabels);
set(gca, 'YTick', 0 : 0.2 : 1, 'YTickLabel', 0 : 0.2 : 1);
% set(gca, 'XTick', xPos, 'XTickLabel', repmat({'Targ.', 'Dist.'}, 1, nLearnGroups));
% ylabel('Fraction of responsive neurons');
makePrettyFigure(gcf);
title(sprintf('Fraction of responsive neurons for all groups\n{\\fontsize{14}N = %d imaging regions (%d neurons)}', ...
    nUniqueSpots, nTotNeurons), 'FontSize', 19);
ylabel('Fraction of responsive neurons', 'FontSize', 17);
set(gca, 'FontSize', 17);
saveFigToDir(gcf, get(gcf, 'Name'), sprintf('%s/Plots/RespFracGrouped', analysisRootPath), doSavePlots, 1, 1);

%% respFrac timeCourse
set(0, 'DefaultFigurePosition', [150, 350, 625, 550]);
figure('Name', 'timeCourse', 'NumberTitle', 'off');
hold on;
markers = {'+', 'o', '*', 'x', 's', 'd', '^', 'v', '>', '<', 'pentagram', 'hexagram'};
for iGroup = 1 : numel(spotGroups);
    
    spotGroup = spotGroups{iGroup};
    respFracMean = nan(size(spotGroup, 1), 2);
    respFracErr = nan(size(spotGroup, 1), 2);
    for iLearnGroup = 1 : nLearnGroups;
        spotsForGroup = spotGroup(iLearnGroup, ~isnan(spotGroup(iLearnGroup, :)));
        if ~isempty(spotsForGroup);
            crossCorrTargForSpots = crossCorrsTarg(spotsForGroup);
            respFracMat = cell2mat(cellfun(@(crossCorrTarg)sum(~isnan(crossCorrTarg)) / size(crossCorrTarg, 1), ...
                crossCorrTargForSpots, UF{:}));
            if size(respFracMat, 1) > 1;
                respFracMean(iLearnGroup, :) = nanmean(respFracMat);
%                 respFracErr(iLearnGroup, :) = nanstd(respFracMat);
                respFracErr(iLearnGroup, :) = nansem(respFracMat);
            else
                respFracMean(iLearnGroup, :) = respFracMat;
                respFracErr(iLearnGroup, :) = [0 0];
            end;
        end;
    end;

    col = [1 0 0; 0 0 0];
    for iStim = 1 : 2;
        xWithJitter = (1 : nLearnGroups) + rand(1, nLearnGroups) * 0.2;
        plot(xWithJitter, respFracMean(:, iStim), 'Color', col(iStim, :), 'Marker', markers{iGroup}, ...
            'MarkerSize', 8, 'MarkerFaceColor', col(iStim, :));
%         errorbar(xWithJitter, respFracMean(:, iStim), respFracErr(:, iStim), 'Color', col(iStim, :));
    end;
    
end;
    

set(gca, 'XTick', 1 : numel(learnGroupLabels), 'XTickLabel', learnGroupLabels);
ylim([-0.02 1.02]); xlim([0.5 3.5]);
makePrettyFigure(gcf);
legend({'Target', 'Distractor'}, 'FontSize', 17);
ylabel('Fraction of responsive neurons', 'FontSize', 17);
set(gca, 'FontSize', 17);
title(sprintf('Fraction of responsive neurons for all groups\n{\\fontsize{14}N = %d imaging regions}', ...
    numel(spotGroups)), 'FontSize', 19);
saveFigToDir(gcf, get(gcf, 'Name'), sprintf('%s/Plots/timeCourse', analysisRootPath), doSavePlots, 1, 1);

%% decoding analysis from Henry - init
cTrue = [1 0 0];
cTrueLight = [1 0.8 0.8];
cShuff = zeros(1, 3);
cShuffLight = ones(1, 3) * 0.8;

%% decoding analysis from Henry
peakDecodings = nan(nSpots, 2);
for iSpot = 1 : nSpots;
    %% decoding analysis single spot
%     data = ROIStatsDataGlobal{iSpot, 4};
%     animalID = ROIStatsDataGlobal{iSpot, 2};
%     spotID = ROIStatsDataGlobal{iSpot, 2};
%     dayID = ['x' ROIStatsDataGlobal{iSpot, 3}];
%     inputStruct = struct('animalID', animalID, spotID, struct(dayID, data));
%     decodingOut = analyzeHDF5(inputStruct);
%     s = decodingOut.(spotID).(dayID);
%     s.tPs = s.tPs - 0.5;
%     ROIStatsDataGlobal{iSpot, 5}.stats.sgfilt.decoding = ...
%         struct('tPs', s.tPs, 'perfTrue', s.perfTrue, 'perfShuf', s.perfShuf, 'trialCount', s.trialCount);
    s = ROIStatsDataGlobal{iSpot, 5}.stats.sgfilt.decoding;
    [~, stimFrameDS] = min(abs(s.tPs));
    stimFrameDS = stimFrameDS + 1;
    evokedDur = 1;
    [~, stimFrameEndDS] = min(abs(s.tPs - evokedDur));
    evokedFramesDS = stimFrameDS : stimFrameEndDS;
    peakDecodings(iSpot, 1) = nanmean(maxnpp(nanmean(s.perfTrue(:, evokedFramesDS)), 3));
    peakDecodings(iSpot, 2) = nanmean(maxnpp(nanmean(s.perfShuf(:, evokedFramesDS)), 3));
    
    %% plot NaiveBayes performance
    %%{
    animSpotDayID = regexprep(regexprep(sprintf('%s:%s:%s', ROIStatsDataGlobal{iSpot, 1:3}), '(_|mou_bl_)', ''), ...
        ':', '_');
    figure('Name', sprintf('decoding_%s', animSpotDayID), 'NumberTitle', 'off');
    hold on;
%     hShuff = shadedErrorBar(s.tPs, nanmean(s.perfShuf), nansem(s.perfShuf), [], 1);
    hTrue = shadedErrorBar(s.tPs, nanmean(s.perfTrue), nanstd(s.perfTrue), [], 0);
    set(hTrue.mainLine, 'Color', cTrue);
    set(hTrue.patch, 'FaceColor', cTrueLight);
    set(hTrue.edge, 'Color', cTrue);
%     set(hShuff.mainLine, 'Color', cShuff);
%     set(hShuff.patch, 'FaceColor', cShuffLight);
%     set(hShuff.edge, 'Color', cShuff);
    xLims = [min(s.tPs) - 0.05 max(s.tPs) + 0.05];
    chanceLevelH = plot(xLims, repmat(50, 2, 1), 'k--');
    hold off;
    makePrettyFigure(gcf);
    xlim(xLims);
    ylim([15 109]);
    set(gca, 'XTick', [0 1.5], 'XTickLabel', [0 1.5], 'YTick', [50 75 100], 'YTickLabel', [50 75 100]);
%     legend([hTrue.mainLine, hShuff.mainLine], {'True', 'Shuffled'});
    xlabel('Time (s)', 'FontSize', 25);
    ylabel('Classification Perf. \pm SD (%)', 'FontSize', 25);
    set(gca, 'FontSize', 25);
%     set(hShuff.mainLine, 'LineWidth', 2);
    set(hTrue.mainLine, 'LineWidth', 3);
    set(hTrue.edge, 'LineWidth', 1);
    saveFigToDir(gcf, get(gcf, 'Name'), sprintf('%s/Plots/decoding', analysisRootPath), doSavePlots, 1, 1);
    %}
    
end;

%% decoding grouped
yLims = [41 109];
% yLims = [-0.05 0.75];
xLims = [-0.5 4.5];
set(0, 'DefaultFigurePosition', [150, 350, 625, 550]);
figure('Name', 'decodingGrouped', 'NumberTitle', 'off');
hold on;
chanceLevelH = plot(xLims, repmat(50, 2, 1), 'k--');
% xPos = nan(nLearnGroups * 2, 1);
xPos = nan(nLearnGroups, 1);
for iGroup = 1 : nLearnGroups;
    
    groupMask = cell2mat(spotIDs(:, 4)) == iGroup;
    col = [1 0 0; 0 0 0];
    b = 0.7;
    colLight = [1 b b; b b b];
    
    xPos(iGroup) = 0.5 + (iGroup - 1) * 1.5;
    h = notBoxPlot(peakDecodings(groupMask, 1), xPos(iGroup), 0.3, 'sdline');
    set(h.data, 'Marker', 'x', 'MarkerSize', 5, ...
        'MarkerFaceColor', col(1, :), 'MarkerEdgeColor', col(1, :));
    set(h.mu, 'Color', col(1, :));
    set(h.semPtch, 'FaceColor', colLight(1, :));
    set(h.sd, 'Color', col(1, :));
end;

set(gca, 'YLim', yLims, 'XLim', xLims);
set(gca, 'XLim', [-0.5 4.5]);
set(gca, 'XTick', xPos, 'XTickLabel', learnGroupLabels);
makePrettyFigure(gcf);
ylabel('Peak decoding (%)', 'FontSize', 19);
legend(chanceLevelH, {'Chance level'}, 'FontSize', 19);
% set(gca, 'XTick', xPos, 'XTickLabel', repmat({'Targ.', 'Dist.'}, 1, nLearnGroups));
% ylabel('Fraction of responsive neurons');

title(sprintf('Peak decoding for all groups\n{\\fontsize{14}N = %d imaging regions (%d neurons)}', ...
    nUniqueSpots, nTotNeurons), 'FontSize', 19);
saveFigToDir(gcf, get(gcf, 'Name'), sprintf('%s/Plots/DecodingGrouped', analysisRootPath), doSavePlots, 1, 1);

%% decoding timeCourse
set(0, 'DefaultFigurePosition', [150, 350, 625, 550]);
figure('Name', 'timeCourseDecoding', 'NumberTitle', 'off');
hold on;
markers = {'+', 'o', '*', 'x', 's', 'd', '^', 'v', '>', '<', 'pentagram', 'hexagram'};
for iGroup = 1 : numel(spotGroups);
    
    spotGroup = spotGroups{iGroup};
%     peakDecodMean = nan(size(spotGroup, 1), 2);
%     peakDecodErr = nan(size(spotGroup, 1), 2);
    peakDecodMean = nan(size(spotGroup, 1), 1);
    peakDecodErr = nan(size(spotGroup, 1), 1);
    for iLearnGroup = 1 : nLearnGroups;
        spotsForGroup = spotGroup(iLearnGroup, ~isnan(spotGroup(iLearnGroup, :)));
        if ~isempty(spotsForGroup);
%             peakDecodeForSpots = peakDecodings(spotsForGroup, :);
            peakDecodeForSpots = peakDecodings(spotsForGroup, 1);
            if size(peakDecodeForSpots, 1) > 1;
                peakDecodMean(iLearnGroup, :) = nanmean(peakDecodeForSpots);
%                 peakDecodErr(iLearnGroup, :) = nanstd(peakDecodeForSpots);
                peakDecodErr(iLearnGroup, :) = nansem(peakDecodeForSpots);
            else
                peakDecodMean(iLearnGroup, :) = peakDecodeForSpots;
                peakDecodErr(iLearnGroup, :) = 0;
            end;
        end;
    end;

    col = [1 0 0; 0 0 0];
%     for iStim = 1 : 2;
      iStim = 1;
        xWithJitter = (1 : nLearnGroups) + rand(1, nLearnGroups) * 0.2;
        plot(xWithJitter, peakDecodMean, 'Color', col(iStim, :), 'Marker', markers{iGroup}, ...
            'MarkerSize', 8, 'MarkerFaceColor', col(iStim, :));
%         errorbar(xWithJitter, peakDecodMean(:, iStim), peakDecodErr(:, iStim), 'Color', col(iStim, :));
%     end;
    
end;
   
chanceLevelH = plot([0.5 3.5], repmat(50, 2, 1), 'k--');
makePrettyFigure(gcf);
set(gca, 'XTick', 1 : numel(learnGroupLabels), 'XTickLabel', learnGroupLabels);
% ylim([40 100]); xlim([0.5 3.5]);
ylim(yLims); xlim([0.5 3.5]);
% legend({'True', 'Shuffled'});
ylabel('Peak decoding (%)', 'FontSize', 19);

title(sprintf('Peak decoding for all groups\n{\\fontsize{14}N = %d imaging regions}', ...
    numel(spotGroups)), 'FontSize', 19);
saveFigToDir(gcf, get(gcf, 'Name'), sprintf('%s/Plots/timeCourseDecode', analysisRootPath), doSavePlots, 1, 1);


%% ROI resp
set(0, 'DefaultFigurePosition', [150, 250, 900, 650]);
bestROIMethod = 1; % 1 = max evoked resp, 2 = max cross corr
targStim = {[1 2], [2 1]};
targStimTxt = {'Target', 'Distractor'};
signifLevel = 0.001;
col = [1 0 0; 0 0 0];
b = 0.8;
colLight = [1 b b; b b b];

% ROIsToPlot = {[],[],[],26,[19 43],[],[],[],[],[],[],46,[],[],[],[],[],[]};
ROIsToPlot = cell(nSpots, 2);

for iSpot = 1 : nSpots;
% for iSpot = 1 : nSpots;
    %% all ROI resp for one spot
    animSpotDayID = sprintf('%s_%s', spotIDs{iSpot, 1}, regexprep(dayIDs{spotIDs{iSpot, 2}}, '_', ''));
    
    % if no predifined ROIs to plot
    if ~any(any(~cellfun(@isempty, ROIsToPlot)));
        % get the "nROIsToPlot" best ROI to plot for each stimulus
        nROIsToPlot = 3;
        nROIs = size(crossCorrs{iSpot}, 1);
        ROIsToPlot = cell(nSpots, 2);
        for iStim = 1 : 2;
            if bestROIMethod == 1;
                traceMeans = nan(nPSFrames, nROIs, 2);
                for iROI = 1 : nROIs;
                    traceMeans(:, iROI, iStim) = nanmean(ROIStatsDataGlobal{iSpot, 5}.PS.sgfilt.raw{iROI, iStim});
                end;

                traceMax = squeeze(max(traceMeans(stimFrames, 1 : nROIs - 1, iStim), [], 1));
                [~, ROISorInd] = sort(-traceMax);
                ROIsToPlot{iSpot, iStim} = [ROISorInd(1 : min(nROIsToPlot, nROIs)), nROIs];
            elseif bestROIMethod == 2;
                % get the ROIs with the bigger cross corr.
                [~, ROIsToPlot{iSpot, iStim}] = maxnpp(crossCorrs{iSpot}(:, iStim), nROIsToPlot, 'ascend');
                ROIsToPlot{iSpot, iStim} = ROIsToPlot{iSpot, iStim}';
                % remove the NaN ROIs
    %             ROIsToPlot{iStim}(isnan(crossCorrs{iSpot}(ROIsToPlot{iStim}, iStim))) = [];
            end;
        end;
    
        % plot the best ROIs for both stim and the neuropil
        ROIsToPlotBothStim = unique([ROIsToPlot{iSpot, 1}, ROIsToPlot{iSpot, 2}, nROIs]);
        
    else
        if isempty(ROIsToPlot{iSpot}); continue; end;
        % plot the requested ROIs and the neuropil
        ROIsToPlotBothStim = unique([ROIsToPlot{iSpot}, nROIs]);
    end;
    
%     for iROI = 1 : size(crossCorrs{iSpot}, 1);
    for iROILoop = 1 : numel(ROIsToPlotBothStim);
%     for iROI = size(crossCorrs{iSpot}, 1);
    %% single ROI resp for one spot
        iROI = ROIsToPlotBothStim(iROILoop);
%         if any(~isnan(crossCorrs{iSpot}(iROI, :)));
        ROIID = regexprep(sprintf('ROI%s', ROIStatsDataGlobal{iSpot, 4}.ROISet{1}{iROI, 1}), 'ROINPil', 'NPil');
%         if ismember(ROIID, {'ROI049', 'ROI053', 'ROI074', 'NPil'});
        if 1;
            figure('Name', sprintf('PSAvg_%s_%s', animSpotDayID, ROIID), 'NumberTitle', 'off');
            hold(gca, 'on');
            legText = cell(2, 1);
            h = struct('mainLine', 0, 'patch', 0, 'edge', 0);
            h(2) = struct('mainLine', 0, 'patch', 0, 'edge', 0);
            for iStimLoop = 1 : 2;
                iStim = targStim{targets(iSpot)}(iStimLoop);
                traces = ROIStatsDataGlobal{iSpot, 5}.PS.sgfilt.norm{iROI, iStim};
                filtTraces = sgolayfilt(traces, 1, 5);
                traceAvg = nanmean(filtTraces);
                traceError = nansem(traces);
                h(iStim) = shadedErrorBar(t, traceAvg, traceError, [], 1); % transparency on
                set(h(iStim).mainLine, 'Color', col(iStimLoop, :), 'LineWidth', 2);
                set(h(iStim).patch, 'FaceColor', colLight(iStimLoop, :));
                set(h(iStim).edge, 'Color', col(iStimLoop, :));
                if ~isnan(crossCorrs{iSpot}(iROI, iStim));
                    hSigStar = sigstar({[0 stimDur]}, signifLevel);
                    set(hSigStar, 'Color', col(iStimLoop, :));
                    
%                     scatter(tStar, yStar, 40, col(iStimLoop, :), '*');
                    legText{iStim} = sprintf('%s (p < 0.001)', targStimTxt{iStim});
                else
                    legText{iStim} = sprintf('%s (n.s.)', targStimTxt{iStim});
                end;
            end;
            xlabel('Time (s)');
            ylabel('dRR \pm SEM (%)');
            title(sprintf('%s_%s', animSpotDayID, ROIID), 'Interpreter', 'none');
            legend([h(targStim{targets(iSpot)}(1)).mainLine, h(targStim{targets(iSpot)}(2)).mainLine], legText);
            makePrettyFigure(gcf);
            for iStimLoop = 1 : 2;
                set(h(iStimLoop).mainLine, 'LineWidth', 2);
                set(h(iStimLoop).edge, 'LineWidth', 1);
            end;
            saveFigToDir(gcf, get(gcf, 'Name'), sprintf('%s/Plots/PSAvg/%s', analysisRootPath, ...
                learnGroupNames{spotIDs{iSpot, 4}}), doSavePlots, 1, 1);
        end;
    end;
end;

%% ROI PSAvg heat map
set(0, 'DefaultFigurePosition', [150, 250, 900, 650]);
targStim = {[1 2], [2 1]};
doSort = 1;
doSigStar = 0;
doExclusionSorting = 0;
if doExclusionSorting;
    excludeROIs = cell(1, nSpots); %#ok<UNRCH>
end;
for iSpot = 1 : nSpots;
    %% single spot ROI PSAvg heat map
    animSpotDayID = regexprep(regexprep(sprintf('%s:%s:%s', ROIStatsDataGlobal{iSpot, 1:3}), '(_|mou_bl_)', ''), ':', '_');
    ROISet = ROIStatsDataGlobal{iSpot, 4}.ROISet{1};
    nROIs = size(ROISet, 1);
    traceMeans = nan(nPSFrames, nROIs, 2);
    for iStimLoop = 1 : 2;
        iStim = targStim{targets(iSpot)}(iStimLoop);
        for iROI = 1 : nROIs;
            traceMeans(:, iROI, iStimLoop) = nanmean(ROIStatsDataGlobal{iSpot, 5}.PS.sgfilt.raw{iROI, iStim});
        end;
    end;
    
    ROISorInd = fliplr(1 : nROIs - 1); %#ok<NASGU>
    if doSort;
        traceMax = squeeze(max(max(traceMeans(stimFrames, 1 : nROIs - 1, 1), [], 1), [], 3));
        [~, ROISorInd] = sort(traceMax);
    end;
    ROISorInd = [nROIs ROISorInd]; %#ok<AGROW>
    traceMeansSorted = traceMeans(:, ROISorInd, :);
    
    figH = plotPSAllStimROIHeatMapSubPlot(sprintf('PSAvgHeatMap_%s', animSpotDayID), traceMeansSorted, ...
        config.PSFrames.base, {'Target', 'Distractor'}, [1 20]); %#ok<NASGU>
    
    if doSigStar;
        colStar = [0 0 1; 0 0 1]; %#ok<UNRCH>
        childH = get(figH, 'Children');
        childHStim = childH([5 4]);
        for iStimLoop = 1 : 2;
            iStim = targStim{targets(iSpot)}(iStimLoop);
            axes(childHStim(iStimLoop)); %%#ok<LAXES>
            hold on;
            for iROI = 1 : nROIs;
                iROISorted = ROISorInd(iROI);
                if any(~isnan(crossCorrs{iSpot}(iROISorted, iStim)));
                    text(0, (nROIs - iROI) + 1 + 0.25, '*', 'FontSize', 150 / nROIs + 11, ...
                        'Color', colStar((iROI == 1) + 1, :));
                end;
            end;
            hold off;
        end;
    end;
    
    if doExclusionSorting;
        toExlcudeROIs = input('ROIs to exclude: '); %#ok<UNRCH>
        exlcudeROIs{iSpot} = toExlcudeROIs;
    end;
    
    saveFigToDir(gcf, get(gcf, 'Name'), sprintf('%s/Plots/PSAvgHeatMap/%s', analysisRootPath, ...
        learnGroupNames{spotIDs{iSpot, 4}}), doSavePlots, 1, 1);
    
end;

