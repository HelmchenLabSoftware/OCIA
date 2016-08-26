% scropt to run multi-day analysis unattended for different animals / spots

% general config options
config.doSave = 1;
config.imgRate = 76.9; % in Hz
config.psTimes = [-0.5 2]; % in s
config.doCorr = 0; % run correlation analysis
config.doDecode = 0; % run decoding analysis
config.iters = 10; % for cross-validation of decoding

% animalIDs = {'14011002'};
% animalIDs = {'14010901', '14010902', '14011001', '14011002'};
animalIDs = {'14100101', '14100102', '14100103', '14100104'};
% animalStructs = cell(4, 1);
% nSpots = {1 : 2, 1 : 2, 1 : 2, 1 : 2};
nSpots = {1};

if ~exist('animalStructs', 'var') && ~exist('allMice.mat', 'file');
    for iAnimal = 1 : numel(animalIDs);
        animalID = sprintf('mou_bl_%s_%s',animalIDs{iAnimal}(1:6),animalIDs{iAnimal}(7:8));
        animalStructs.(animalID) = h5readAsStruct(sprintf('E:/Analysis/1410_chronic/%s_%s.h5', animalIDs{iAnimal}(1:6),animalIDs{iAnimal}(7:8)), '/');
        animalStructs.(animalID) = animalStructs.(animalID).(animalID);
    end;
    save('allMice.mat', 'animalStructs', '-v7.3');
elseif ~exist('animalStructs', 'var') && exist('allMice.mat', 'file');
    load('allMice.mat');
end;

% for iAnimal = 1 : numel(animalIDs);
for iAnimal = [1];
    
    animalID = sprintf('mou_bl_%s_%s',animalIDs{iAnimal}(1:6),animalIDs{iAnimal}(7:8));
%     animalStructs{iAnimal} = henry_analyzeHDF5_singleDay(animalIDs{iAnimal}, 0, 0); %#ok<SAGROW>
    spotList = arrayfun(@(iSpot) sprintf('spot%02d', iSpot), nSpots{iAnimal}, 'UniformOutput', false);
    
    for n = 1 : numel(spotList);
%         try
            config.spotID = spotList{n};
            o('#Started analysis for %s %s.', animalID, config.spotID, 0, 0)
            henry_analyzeHDF5_multiDay(animalStructs.(animalID), config);
            o('#Finished analysis for %s %s.', animalID, config.spotID, 0, 0)
%         catch err;
%             o('Error for %s %s: %s (%s)\n%s', animalID, spotList{n}, err.message, err.identifier, ...
%                 getStackText(err), 0, 0);
%         end;
    end
    
end;

save('allMiceStructs.mat', 'animalStructs', '-v7.3');

%{
%% S_14010901
S = 'S_14010901';
spotList = {'spot01', 'spot02', 'spot03'};
for n = 1:numel(spotList)
    config.spotID = spotList{n};
    fprintf('\n\nStarted analysis for %s %s\n',S, config.spotID)
    if exist(S, 'var'); analyzeHDF5_multiDay(eval(S),config);
    else analyzeHDF5_multiDay(S, config); end;
    fprintf('\nFinished analysis for %s %s\n',S, config.spotID)
end


%% S_14010902
S = 'S_14010902';
spotList = {'spot01', 'spot02'};
for n = 1:numel(spotList)
    config.spotID = spotList{n};
    fprintf('\n\nStarted analysis for %s %s\n',S, config.spotID)
    if exist(S, 'var'); analyzeHDF5_multiDay(eval(S),config);
    else analyzeHDF5_multiDay(S, config); end;
    fprintf('\nFinished analysis for %s %s\n',S, config.spotID)
end

%% S_14011001
S = 'S_14011001';
spotList = {'spot01', 'spot02'};
for n = 1:numel(spotList)
    config.spotID = spotList{n};
    fprintf('\n\nStarted analysis for %s %s\n',S, config.spotID)
    if exist(S, 'var'); analyzeHDF5_multiDay(eval(S),config);
    else analyzeHDF5_multiDay(S, config); end;
    fprintf('\nFinished analysis for %s %s\n',S, config.spotID)
end

%% S_14011002
S = 'S_14011002';
spotList = {'spot01', 'spot02'};
for n = 1:numel(spotList)
    config.spotID = spotList{n};
    fprintf('\n\nStarted analysis for %s %s\n',S, config.spotID)
    if exist(S, 'var'); analyzeHDF5_multiDay(eval(S),config);
    else analyzeHDF5_multiDay(S, config); end;
    fprintf('\nFinished analysis for %s %s\n',S, config.spotID)
end
%}