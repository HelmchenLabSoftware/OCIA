% runOCIABatchSave_H6403b - [no description]
%
%       runOCIABatchSave_H6403b()
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)


diary(sprintf('E:/Analysis/1410_chronic/%s_batchSave.log', datestr(now, 'yyyymmdd_HHMMSS')));

allTic = tic;
o('#runOCIABatchSave: timestamp: %s', datestr(now), 0, 0);

% create and show animal IDs
animalIDs = arrayfun(@(iAnim) sprintf('mou_bl_141001_%02d', iAnim), 1 : 4, 'UniformOutput', false);
o('#runOCIABatchSave: animals:', 0, 0);
tprintf(numel(animalIDs{1}), [num2cell(1 : numel(animalIDs)); animalIDs ], 1, 0);

% create and show day IDs
dayIDs = arrayfun(@(day) sprintf('2014_10_%02d', day), [16, 21, 25, 27, 31], 'UniformOutput', false);
o('#runOCIABatchSave: days:', 0, 0);
tprintf(numel(dayIDs{1}), [num2cell(1 : numel(dayIDs)); dayIDs ], 1, 0);

% create and show spot IDs
spotIDs = arrayfun(@(iSpot) sprintf('spot%02d', iSpot), 1 : 3, 'UniformOutput', false);
o('#runOCIABatchSave: spots:', 0, 0);
tprintf(numel(spotIDs{1}), [num2cell(1 : numel(spotIDs)); spotIDs ], 1, 0);
    
%% process things
% create the tasks
tasks = { ...
    struct( 'HIFOWSH640x2D03b', struct('animals', 1 : numel(animalIDs), 'days',  1 : numel(dayIDs), 'spots', 1 : numel(spotIDs)) ), ...
};
    
% get the computer's ID
[~, rawComputerID] = system('hostname');
host = genvarname(rawComputerID); %#ok<DEPGENAM>
o('#runOCIABatchSave: host: %s', host, 0, 0);

nTasks = numel(tasks);
for iTask = 1 : nTasks;
    
    o('##runOCIABatchSave: T%02d/%02d ...', iTask, nTasks, 0, 0);
    if ~isfield(tasks{iTask}, host); continue; end;
    
    taskTic = tic;
    nAnimals = numel(tasks{iTask}.(host).animals);
    
    for iAnimal = 1 : nAnimals;
        animalTic = tic;
        animalID = animalIDs{tasks{iTask}.(host).animals(iAnimal)};
        o('###runOCIABatchSave: T%02d/%02d - %s (%02d/%02d) ...', iTask, nTasks, animalID, iAnimal, nAnimals, 0, 0);
        nDays = numel(tasks{iTask}.(host).days);

        for iDay = 1 : nDays;
            dayTic = tic;
            dayID = dayIDs{tasks{iTask}.(host).days(iDay)};
            o('####runOCIABatchSave: T%02d/%02d - %s (%02d/%02d) - %s (%02d/%02d) ...', iTask, nTasks, animalID, ...
                iAnimal, nAnimals, dayID, iDay, nDays, 0, 0);
            nSpots = numel(tasks{iTask}.(host).spots);

            for iSpot = 1 : nSpots;
                spotTic = tic;
                spotID = spotIDs{tasks{iTask}.(host).spots(iSpot)};
                o('#####runOCIABatchSave: T%02d/%02d - %s (%02d/%02d) - %s (%02d/%02d) - %s (%02d/%02d) ...', ...
                    iTask, nTasks, animalID, iAnimal, nAnimals, dayID, iDay, nDays, spotID, iSpot, nSpots, 0, 0);

                try
                    this = OCIA('batchSave_H6403b', { animalID, dayID, spotID, '', 'ROISet ~= \w+' });

                catch err;

                    o(['#####runOCIABatchSave: /!\\ ERROR at T%02d/%02d - %s (%02d/%02d) - %s (%02d/%02d) - ', ...
                        '%s (%02d/%02d) /!\\ <<<<<<<'], iTask, nTasks, animalID, iAnimal, nAnimals, dayID, ...
                        iDay, nDays, spotID, iSpot, nSpots, 0, 0);
                    o('#####runOCIABatchSave: %s (%s)\n%s', err.message, err.identifier, getStackText(err), 0, 0);

                end;
                
                if exist('this', 'var');
                    delete(this);
                end;
                
                o('#####runOCIABatchSave: T%02d/%02d - %s (%02d/%02d) - %s (%02d/%02d) - %s (%02d/%02d) done (%.0f seconds).', ...
                    iTask, nTasks, animalID, iAnimal, nAnimals, dayID, iDay, nDays, spotID, iSpot, nSpots, ...
                    toc(spotTic), 0, 0);

            end;
            o('####runOCIABatchSave: T%02d/%02d - %s (%02d/%02d) - %s (%02d/%02d) done (%.0f seconds).', iTask, nTasks, ...
                animalID, iAnimal, nAnimals, dayID, iDay, nDays, toc(dayTic), 0, 0);
        end;
        o('###runOCIABatchSave: T%02d/%02d - %s (%02d/%02d) done (%.0f seconds).', iTask, nTasks, animalID, iAnimal, ...
            nAnimals, toc(animalTic), 0, 0);
    end;
    o('##runOCIABatchSave: task %02d/%02d done (%.0f seconds).', iTask, nTasks, toc(taskTic), 0, 0);
end;

o('#runOCIABatchSave: done (%.0f seconds).', toc(allTic), 0, 0);

diary('off');