% runOCIABatchSave_alex - [no description]
%
%       runOCIABatchSave_alex()
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)


allTic = tic; % for performance timing purposes
o('#runOCIABatchSave: timestamp: %s', datestr(now), 0, 0);
%
...%          1      2       3       4       5       6       7       8
ageIDs = {  'P10', 'P11' , 'P12' , 'P13' , 'P14' , 'P15' , 'P16' , 'P17' , ...
...%          9      10      11      12      13      14      15      16
            'P18' , 'P19' , 'P20' , 'P21' , 'P22' , 'P23' , 'P24' , 'P25', ...
...%         17      18      19
            'P26' , 'P27' , 'P28' }; ...

...%           1     2     3     4
animalIDs = { 'a1', 'a2', 'a3', 'a4'};

...%            1       2       3       4       5       6       7       8
regionIDs = { 'r1s1', 'r1s2', 'r1s3', 'r1s4', 'r1s5', 'r2s1', 'r2s2', 'r2s3', ...
...%            9       10      11      12      13      14       
              'r2s4', 'r3s1', 'r3s2', 'r3s3', 'r4s1', 'r4s2'};
%

% 
% ageIDs = {'P10', 'P11', 'P12', 'P13', 'P14', 'P15', 'P20'};
% animalIDs = {'a1', 'a2', 'a3', 'a4'};
% regionIDs = {'r1s1', 'r1s2', 'r2s3', 'r2s4', 'r3s1', 'r1s4'};

tasks = { ...
        struct( 'HIFOWSH640x2D01', struct('ages', 1, 'animals',  1, 'regions', 8, 'runs', 'all')), ...
    };
        

% get the computer's ID
[~, rawComputerID] = system('hostname');
host = genvarname(rawComputerID);

o('#runOCIABatchSave: host: %s', host, 0, 0);

diary('D:\data\juvenileWhiskerStim\juvenileWhiskerStim.log');

% matlabpool('open', feature('numCores'));

nTasks = numel(tasks);
for iTask = 1 : nTasks;
    
    o('##runOCIABatchSave: task %02d/%02d ...', iTask, nTasks, 0, 0);
    if ~isfield(tasks{iTask}, host); continue; end;
    
    taskTic = tic; % for performance timing purposes
    runs = tasks{iTask}.(host).runs;
    o('##runOCIABatchSave: T%02d - runs: "%s".', iTask, runs, 0, 0);
    nAges = numel(tasks{iTask}.(host).ages);
    
    for iAge = 1 : nAges;
        ageTic = tic; % for performance timing purposes
        ageID = ageIDs{tasks{iTask}.(host).ages(iAge)};
        o('###runOCIABatchSave: T%02d/%02d - %s (%02d/%02d) ...', iTask, nTasks, ageID, iAge, nAges, 0, 0);
        nAnimals = numel(tasks{iTask}.(host).animals);

        for iAnimal = 1 : nAnimals;
            animalTic = tic; % for performance timing purposes
            animalID = animalIDs{tasks{iTask}.(host).animals(iAnimal)};
            o('####runOCIABatchSave: T%02d/%02d - %s (%02d/%02d) - %s (%02d/%02d) ...', iTask, nTasks, ageID, ...
                iAge, nAges, animalID, iAnimal, nAnimals, 0, 0);
            nRegions = numel(tasks{iTask}.(host).regions);

            for iRegion = 1 : nRegions;
                regionTic = tic; % for performance timing purposes
                regionID = regionIDs{tasks{iTask}.(host).regions(iRegion)};
                o('#####runOCIABatchSave: T%02d/%02d - %s (%02d/%02d) - %s (%02d/%02d) - %s (%02d/%02d) ...', ...
                    iTask, nTasks, ageID, iAge, nAges, animalID, iAnimal, nAnimals, regionID, iRegion, nRegions, 0, 0);

                try
                    
                    if strcmp(runs, 'all'); runs = ''; end;
                    this = OCIA('alexBatch', { ageID, animalID, regionID, 'imgData', runs });

                catch err;

                    o(['#####runOCIABatchSave: /!\\ ERROR at T%02d/%02d - %s (%02d/%02d) - %s (%02d/%02d) - ', ...
                        '%s (%02d/%02d) - %s /!\\ <<<<<<<'], iTask, nTasks, ageID, iAge, nAges, animalID, ...
                        iAnimal, nAnimals, regionID, iRegion, nRegions, runs, 0, 0);
                    o('#####runOCIABatchSave: %s (%s)\n%s', err.message, err.identifier, getStackText(err), 0, 0);

                end;
                
                if exist('this', 'var');
                    delete(this);
                end;
                
                o('#####runOCIABatchSave: T%02d/%02d - %s (%02d/%02d) - %s (%02d/%02d) - %s (%02d/%02d) done (%.0f seconds).', ...
                    iTask, nTasks, ageID, iAge, nAges, animalID, iAnimal, nAnimals, regionID, iRegion, nRegions, ...
                    toc(regionTic), 0, 0);

            end;
            o('####runOCIABatchSave: T%02d/%02d - %s (%02d/%02d) - %s (%02d/%02d) done (%.0f seconds).', iTask, nTasks, ...
                ageID, iAge, nAges, animalID, iAnimal, nAnimals, toc(animalTic), 0, 0);
        end;
        o('###runOCIABatchSave: T%02d/%02d - %s (%02d/%02d) done (%.0f seconds).', iTask, nTasks, ageID, iAge, nAges, ...
            toc(ageTic), 0, 0);
    end;
    o('##runOCIABatchSave: task %02d/%02d done (%.0f seconds).', iTask, nTasks, toc(taskTic), 0, 0);
end;

diary('off');

o('#runOCIABatchSave: done (%.0f seconds).', toc(allTic), 0, 0);

% matlabpool('close');
% exit;

