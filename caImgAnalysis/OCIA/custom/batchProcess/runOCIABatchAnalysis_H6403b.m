% runOCIABatchAnalysis_H6403b - [no description]
%
%       runOCIABatchAnalysis_H6403b()
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

diary(sprintf('E:/Analysis/1502_chronic/%s_batchAnalysis.log', datestr(now, 'yyyymmdd_HHMMSS')));

allTic = tic;
o('#%s: timestamp: %s', mfilename(), datestr(now), 0, 0);

% create and show animal IDs
% animalIDs = arrayfun(@(iAnim) sprintf('mou_bl_141001_%02d', iAnim), 1 : 3, 'UniformOutput', false);
animalIDs = arrayfun(@(iAnim) sprintf('mou_bl_150217_%02d', iAnim), [1 2 3 5 8], 'UniformOutput', false);
o('#%s: animals:', mfilename(), 0, 0);
tprintf(numel(animalIDs{1}), [num2cell(1 : numel(animalIDs)); animalIDs ], 1, 0);

% create and show spot IDs
spotIDs = arrayfun(@(iSpot) sprintf('spot%02d', iSpot), 1 : 3, 'UniformOutput', false);
o('#%s: spots:', mfilename(), 0, 0);
tprintf(numel(spotIDs{1}), [num2cell(1 : numel(spotIDs)); spotIDs ], 1, 0);
    
%% process things
% create the tasks
tasks = { ...
%     struct( 'HIFOWSH640x2D03b', struct('animals', 1 : numel(animalIDs), 'spots', 1 : numel(spotIDs)) ) ...
    struct( 'HIFOWSH640x2D03b', struct('animals', 1, 'spots', 1 : numel(spotIDs)) ) ...
};
    
% get the computer's ID
[~, rawComputerID] = system('hostname');
host = genvarname(rawComputerID); %#ok<DEPGENAM>
o('#%s: host: %s', mfilename(), host, 0, 0);

nTasks = numel(tasks);
for iTask = 1 : nTasks;
    
    o('##%s: T%02d/%02d ...', mfilename(), iTask, nTasks, 0, 0);
    if ~isfield(tasks{iTask}, host); continue; end;
    
    taskTic = tic;
    nAnimals = numel(tasks{iTask}.(host).animals);
    
    for iAnimal = 1 : nAnimals;
        animalTic = tic;
        animalID = animalIDs{tasks{iTask}.(host).animals(iAnimal)};
        o('###%s: T%02d/%02d - %s (%02d/%02d) ...', mfilename(), iTask, nTasks, animalID, iAnimal, nAnimals, 0, 0);
        nSpots = numel(tasks{iTask}.(host).spots);

        for iSpot = 1 : nSpots;
            spotTic = tic;
            spotID = spotIDs{tasks{iTask}.(host).spots(iSpot)};
            o('#####%s: T%02d/%02d - %s (%02d/%02d) - %s (%02d/%02d) ...', ...
                mfilename(), iTask, nTasks, animalID, iAnimal, nAnimals, spotID, iSpot, nSpots, 0, 0);

            try
                this = OCIA('batchAnalysis_H6403b', { animalID, '', spotID, '', '' });

            catch err;

                o('#####%s: /!\ ERROR at T%02d/%02d - %s (%02d/%02d) - %s (%02d/%02d) /!\ <<<<<<<', ...
                    mfilename(), iTask, nTasks, animalID, iAnimal, nAnimals, spotID, iSpot, nSpots, 0, 0);
                o('#####%s: %s (%s)\n%s', mfilename(), err.message, err.identifier, getStackText(err), 0, 0);

            end;

            if exist('this', 'var');
                delete(this);
            end;

            o('#####%s: T%02d/%02d - %s (%02d/%02d) - %s (%02d/%02d) done (%.0f seconds).', ...
                mfilename(), iTask, nTasks, animalID, iAnimal, nAnimals, spotID, iSpot, nSpots, ...
                toc(spotTic), 0, 0);
        end;
        o('###%s: T%02d/%02d - %s (%02d/%02d) done (%.0f seconds).', mfilename(), iTask, nTasks, animalID, iAnimal, ...
            nAnimals, toc(animalTic), 0, 0);
    end;
    o('##%s: task %02d/%02d done (%.0f seconds).', mfilename(), iTask, nTasks, toc(taskTic), 0, 0);
end;

totTime = toc(allTic);
totTimeParts = str2double(regexp(datestr(datenum(1900, 1, 1, 0, 0, totTime), 'dd_HH_MM_SS'), '_', 'split')) - [1 0 0 0];
o('#%s: done (%.0f seconds => %02dD&%02dH:%02dM:%02dS).', mfilename(), totTime, totTimeParts(:), 0, 0);

diary('off');