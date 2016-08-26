
% load previous config
load('C:\Users\laurenczy\Documents\LabVIEW Data\mainConf.mat');

%% basic stuff
% TDTSampFreq = 97656.25; % 100kHz
TDTSampFreq = 195312.5; % 200kHz
standardSampFreq = 44100;

COTUniqueFreqs_4To21kHz_25freqs = 4000 * (2 .^ (((1 : 25) - 1) * (0.1))); % used for chronic_1402
COTUniqueFreqs_4To32kHz_25freqs = 4000 * (2 .^ (((1 : 25) - 1) * (2 ^ -3))); % use for chronic_1406-1410
COTUniqueFreqs_5To40kHz_24freqs = 5000 * (2 .^ (((1 : 24) - 1) * (2 ^ -3))); % alternative
COTUniqueFreqs_5To20kHz_33freqs = 5000 * (2 .^ (((1 : 33) - 1) * (2 ^ -4))); % alternative
COTUniqueFreqs_4To16kHz_33freqs = 4000 * (2 .^ (((1 : 33) - 1) * (2 ^ -4))); % use for chronic_1502
% pureToneFreqs = [8000 16000]; % use for 151007_02
pureToneFreqs = [4000 28000]; % use for 160105 batch
% pureToneFreqs = [4000 6000]; % use for testing

%% stim matrices
o('Generating stim matrices ...', 0, 0);

% 60 trials, 1 or 2 as start
stimTypes = [1 2]; stimSize = 60; blockSize = 10; maxConsec = 3; nSeqs = 10; seqStart = 1; plotMatrix = 0;
try
    stimMatrix_60stim_10block_3max_10seq_1start ...
        = configs.behavior.tables.stimMatrix_60stim_10block_3max_10seq_1start; % 1 as start
    stimMatrix_60stim_10block_3max_10seq_2start ...
        = configs.behavior.tables.stimMatrix_60stim_10block_3max_10seq_2start; % 2 as start
catch e;
end; 
if ~exist('stimMatrix_60stim_10block_3max_10seq_1start', 'var');
    stimMatrix_60stim_10block_3max_10seq_1start = genStimMatrix(stimTypes, stimSize, blockSize, maxConsec, nSeqs, ...
        seqStart, plotMatrix);
    % store
    configs.behavior.tables.stimMatrix_60stim_10block_3max_10seq_1start = stimMatrix_60stim_10block_3max_10seq_1start;
    
    stimMatrix_60stim_10block_3max_10seq_2start = stimMatrix_60stim_10block_3max_10seq_1start;
    stimMatrix_60stim_10block_3max_10seq_2start(stimMatrix_60stim_10block_3max_10seq_2start == 1) = 3;
    stimMatrix_60stim_10block_3max_10seq_2start(stimMatrix_60stim_10block_3max_10seq_2start == 2) = 1;
    stimMatrix_60stim_10block_3max_10seq_2start(stimMatrix_60stim_10block_3max_10seq_2start == 3) = 2;
    % store
    configs.behavior.tables.stimMatrix_60stim_10block_3max_10seq_2start = stimMatrix_60stim_10block_3max_10seq_2start;
end;

% 60 trials, 1 or 2 as start, biaised probabilities
stimTypes = [1 2 3 4 5]; stimSize = 60; blockSize = 10; maxConsec = [repmat(stimSize, 1, 4), 1]; nSeqs = 10; seqStart = 5; plotMatrix = 0;
try
    stimMatrix_60stim_10block_3max_10seq_2start_80p1_20p2 ...
        = configs.behavior.tables.stimMatrix_60stim_10block_3max_10seq_2start_80p1_20p2; % 2 as start
    stimMatrix_60stim_10block_3max_10seq_1start_80p2_20p1 ...
        = configs.behavior.tables.stimMatrix_60stim_10block_3max_10seq_1start_80p2_20p1; % 1 as start
catch e;
end; 
if ~exist('stimMatrix_60stim_10block_3max_10seq_2start_80p1_20p2', 'var');
    stimMatrix_60stim_10block_3max_10seq_2start_80p1_20p2 = genStimMatrix(stimTypes, stimSize, blockSize, maxConsec, nSeqs, ...
        seqStart, plotMatrix);
    stimMatrix_60stim_10block_3max_10seq_2start_80p1_20p2(stimMatrix_60stim_10block_3max_10seq_2start_80p1_20p2 < 5) = 1;
    stimMatrix_60stim_10block_3max_10seq_2start_80p1_20p2(stimMatrix_60stim_10block_3max_10seq_2start_80p1_20p2 >= 5) = 2;
    % store
    configs.behavior.tables.stimMatrix_60stim_10block_3max_10seq_2start_80p1_20p2 = stimMatrix_60stim_10block_3max_10seq_2start_80p1_20p2;
    
    stimMatrix_60stim_10block_3max_10seq_1start_80p2_20p1 = stimMatrix_60stim_10block_3max_10seq_2start_80p1_20p2;
    stimMatrix_60stim_10block_3max_10seq_1start_80p2_20p1(stimMatrix_60stim_10block_3max_10seq_1start_80p2_20p1 == 1) = 3;
    stimMatrix_60stim_10block_3max_10seq_1start_80p2_20p1(stimMatrix_60stim_10block_3max_10seq_1start_80p2_20p1 == 2) = 1;
    stimMatrix_60stim_10block_3max_10seq_1start_80p2_20p1(stimMatrix_60stim_10block_3max_10seq_1start_80p2_20p1 == 3) = 2;
    % store
    configs.behavior.tables.stimMatrix_60stim_10block_3max_10seq_1start_80p2_20p1 = stimMatrix_60stim_10block_3max_10seq_1start_80p2_20p1;
end;
% 60 trials, 1 or 2 as start, biaised probabilities
stimTypes = [1 2 3 4 5]; stimSize = 60; blockSize = 10; maxConsec = [repmat(stimSize, 1, 4), 1]; ...
    nSeqs = 10; seqStart = 1; plotMatrix = 0;
try
    stimMatrix_60stim_10block_3max_10seq_1start_80p1_20p2 ...
        = configs.behavior.tables.stimMatrix_60stim_10block_3max_10seq_1start_80p1_20p2; % 1 as start
    stimMatrix_60stim_10block_3max_10seq_2start_80p2_20p1 ...
        = configs.behavior.tables.stimMatrix_60stim_10block_3max_10seq_2start_80p2_20p1; % 2 as start
catch e;
end; 
if ~exist('stimMatrix_60stim_10block_3max_10seq_1start_80p1_20p2', 'var');
    stimMatrix_60stim_10block_3max_10seq_1start_80p1_20p2 = genStimMatrix(stimTypes, stimSize, blockSize, maxConsec, nSeqs, ...
        seqStart, plotMatrix);
    stimMatrix_60stim_10block_3max_10seq_1start_80p1_20p2(stimMatrix_60stim_10block_3max_10seq_1start_80p1_20p2 < 5) = 1;
    stimMatrix_60stim_10block_3max_10seq_1start_80p1_20p2(stimMatrix_60stim_10block_3max_10seq_1start_80p1_20p2 >= 5) = 2;
    % store
    configs.behavior.tables.stimMatrix_60stim_10block_3max_10seq_1start_80p1_20p2 = stimMatrix_60stim_10block_3max_10seq_1start_80p1_20p2;
    
    stimMatrix_60stim_10block_3max_10seq_2start_80p2_20p1 = stimMatrix_60stim_10block_3max_10seq_1start_80p1_20p2;
    stimMatrix_60stim_10block_3max_10seq_2start_80p2_20p1(stimMatrix_60stim_10block_3max_10seq_2start_80p2_20p1 == 1) = 3;
    stimMatrix_60stim_10block_3max_10seq_2start_80p2_20p1(stimMatrix_60stim_10block_3max_10seq_2start_80p2_20p1 == 2) = 1;
    stimMatrix_60stim_10block_3max_10seq_2start_80p2_20p1(stimMatrix_60stim_10block_3max_10seq_2start_80p2_20p1 == 3) = 2;
    % store
    configs.behavior.tables.stimMatrix_60stim_10block_3max_10seq_2start_80p2_20p1 = stimMatrix_60stim_10block_3max_10seq_2start_80p2_20p1;
end;

% 60 trials, 1 or 2 as start, biaised probabilities
stimTypes = [1 2 3 4]; stimSize = 96; blockSize = 8; maxConsec = [repmat(stimSize, 1, 3), 1]; nSeqs = 10; seqStart = 4; plotMatrix = 0;
try
    stimMatrix_60stim_10block_3max_10seq_2start_75p1_25p2 ...
        = configs.behavior.tables.stimMatrix_60stim_10block_3max_10seq_2start_75p1_25p2; % 1 as start
    stimMatrix_60stim_10block_3max_10seq_1start_75p2_25p1 ...
        = configs.behavior.tables.stimMatrix_60stim_10block_3max_10seq_1start_75p2_25p1; % 2 as start
catch e;
end; 
if ~exist('stimMatrix_60stim_10block_3max_10seq_2start_75p1_25p2', 'var');
    stimMatrix_60stim_10block_3max_10seq_2start_75p1_25p2 = genStimMatrix(stimTypes, stimSize, blockSize, maxConsec, nSeqs, ...
        seqStart, plotMatrix);
    stimMatrix_60stim_10block_3max_10seq_2start_75p1_25p2(stimMatrix_60stim_10block_3max_10seq_2start_75p1_25p2 < 4) = 1;
    stimMatrix_60stim_10block_3max_10seq_2start_75p1_25p2(stimMatrix_60stim_10block_3max_10seq_2start_75p1_25p2 >= 4) = 2;
    % store
    configs.behavior.tables.stimMatrix_60stim_10block_3max_10seq_2start_75p1_25p2 = stimMatrix_60stim_10block_3max_10seq_2start_75p1_25p2;
    
    stimMatrix_60stim_10block_3max_10seq_1start_75p2_25p1 = stimMatrix_60stim_10block_3max_10seq_2start_75p1_25p2;
    stimMatrix_60stim_10block_3max_10seq_1start_75p2_25p1(stimMatrix_60stim_10block_3max_10seq_1start_75p2_25p1 == 1) = 3;
    stimMatrix_60stim_10block_3max_10seq_1start_75p2_25p1(stimMatrix_60stim_10block_3max_10seq_1start_75p2_25p1 == 2) = 1;
    stimMatrix_60stim_10block_3max_10seq_1start_75p2_25p1(stimMatrix_60stim_10block_3max_10seq_1start_75p2_25p1 == 3) = 2;
    % store
    configs.behavior.tables.stimMatrix_60stim_10block_3max_10seq_1start_75p2_25p1 = stimMatrix_60stim_10block_3max_10seq_1start_75p2_25p1;
end;
o('Generating stim/nTones matrices 1 / 6 done.', 0, 0);

% 60 trials, 1 or 2 as start, biaised probabilities
stimTypes = [1 2 3]; stimSize = 72; blockSize = 6; maxConsec = [repmat(stimSize, 1, 2), 1]; nSeqs = 10; seqStart = 3; plotMatrix = 1;
try
    stimMatrix_72stim_10block_3max_10seq_2start_66p1_33p2 ...
        = configs.behavior.tables.stimMatrix_72stim_10block_3max_10seq_2start_66p1_33p2; % 2 as start
    stimMatrix_72stim_10block_3max_10seq_1start_66p2_33p1 ...
        = configs.behavior.tables.stimMatrix_72stim_10block_3max_10seq_1start_66p2_33p1; % 1 as start
catch e;
end; 
if ~exist('stimMatrix_72stim_10block_3max_10seq_2start_66p1_33p2', 'var');
    stimMatrix_72stim_10block_3max_10seq_2start_66p1_33p2 = genStimMatrix(stimTypes, stimSize, blockSize, maxConsec, nSeqs, ...
        seqStart, plotMatrix);
    stimMatrix_72stim_10block_3max_10seq_2start_66p1_33p2(stimMatrix_72stim_10block_3max_10seq_2start_66p1_33p2 < 3) = 1;
    stimMatrix_72stim_10block_3max_10seq_2start_66p1_33p2(stimMatrix_72stim_10block_3max_10seq_2start_66p1_33p2 >= 3) = 2;
    % store
    configs.behavior.tables.stimMatrix_72stim_10block_3max_10seq_2start_66p1_33p2 = stimMatrix_72stim_10block_3max_10seq_2start_66p1_33p2;
    
    stimMatrix_72stim_10block_3max_10seq_1start_66p2_33p1 = stimMatrix_72stim_10block_3max_10seq_2start_66p1_33p2;
    stimMatrix_72stim_10block_3max_10seq_1start_66p2_33p1(stimMatrix_72stim_10block_3max_10seq_1start_66p2_33p1 == 1) = 3;
    stimMatrix_72stim_10block_3max_10seq_1start_66p2_33p1(stimMatrix_72stim_10block_3max_10seq_1start_66p2_33p1 == 2) = 1;
    stimMatrix_72stim_10block_3max_10seq_1start_66p2_33p1(stimMatrix_72stim_10block_3max_10seq_1start_66p2_33p1 == 3) = 2;
    % store
    configs.behavior.tables.stimMatrix_72stim_10block_3max_10seq_1start_66p2_33p1 = stimMatrix_72stim_10block_3max_10seq_1start_66p2_33p1;
end;
o('Generating stim/nTones matrices 2 / 6 done.', 0, 0);

% 72 trials, 1 or 2 as start, biaised probabilities
stimTypes = [1 2 3]; stimSize = 72; blockSize = 6; maxConsec = [repmat(stimSize, 1, 2), 1];
nSeqs = 10; seqStart = 1; plotMatrix = 1;
try
    stimMatrix_72stim_10block_3max_10seq_1start_66p1_33p2 ...
        = configs.behavior.tables.stimMatrix_72stim_10block_3max_10seq_1start_66p1_33p2; % 1 as start
    stimMatrix_72stim_10block_3max_10seq_2start_66p2_33p1 ...
        = configs.behavior.tables.stimMatrix_72stim_10block_3max_10seq_2start_66p2_33p1; % 2 as start
catch e;
end; 
if ~exist('stimMatrix_72stim_10block_3max_10seq_1start_66p1_33p2', 'var');
    stimMatrix_72stim_10block_3max_10seq_1start_66p1_33p2 = genStimMatrix(stimTypes, stimSize, blockSize, maxConsec, nSeqs, ...
        seqStart, plotMatrix);
    stimMatrix_72stim_10block_3max_10seq_1start_66p1_33p2(stimMatrix_72stim_10block_3max_10seq_1start_66p1_33p2 < 3) = 1;
    stimMatrix_72stim_10block_3max_10seq_1start_66p1_33p2(stimMatrix_72stim_10block_3max_10seq_1start_66p1_33p2 >= 3) = 2;
    % store
    configs.behavior.tables.stimMatrix_72stim_10block_3max_10seq_1start_66p1_33p2 = stimMatrix_72stim_10block_3max_10seq_1start_66p1_33p2;
    
    stimMatrix_72stim_10block_3max_10seq_2start_66p2_33p1 = stimMatrix_72stim_10block_3max_10seq_2start_66p1_33p2;
    stimMatrix_72stim_10block_3max_10seq_2start_66p2_33p1(stimMatrix_72stim_10block_3max_10seq_2start_66p2_33p1 == 1) = 3;
    stimMatrix_72stim_10block_3max_10seq_2start_66p2_33p1(stimMatrix_72stim_10block_3max_10seq_2start_66p2_33p1 == 2) = 1;
    stimMatrix_72stim_10block_3max_10seq_2start_66p2_33p1(stimMatrix_72stim_10block_3max_10seq_2start_66p2_33p1 == 3) = 2;
    % store
    configs.behavior.tables.stimMatrix_72stim_10block_3max_10seq_2start_66p2_33p1 = stimMatrix_72stim_10block_3max_10seq_2start_66p2_33p1;
end;

o('Generating stim/nTones matrices 4 / 6 done.', 0, 0);

% 30 trials, 1 or 2 as start
stimSize = 30; plotMatrix = 0;
try
    stimMatrix_30stim_10block_3max_10seq_2start ...
        = configs.behavior.tables.stimMatrix_30stim_10block_3max_10seq_1start; % 1 as start
    stimMatrix_30stim_10block_3max_10seq_2start ...
        = configs.behavior.tables.stimMatrix_30stim_10block_3max_10seq_2start; % 2 as start
catch e;
end;
if ~exist('stimMatrix_30stim_10block_3max_10seq_1start', 'var');
    stimMatrix_30stim_10block_3max_10seq_1start = genStimMatrix(stimTypes, stimSize, blockSize, maxConsec, nSeqs, ...
        seqStart, plotMatrix);
    % store
    configs.behavior.tables.stimMatrix_30stim_10block_3max_10seq_1start = stimMatrix_30stim_10block_3max_10seq_1start;
    
    stimMatrix_30stim_10block_3max_10seq_2start = stimMatrix_30stim_10block_3max_10seq_1start;
    stimMatrix_30stim_10block_3max_10seq_2start(stimMatrix_30stim_10block_3max_10seq_2start == 1) = 3;
    stimMatrix_30stim_10block_3max_10seq_2start(stimMatrix_30stim_10block_3max_10seq_2start == 2) = 1;
    stimMatrix_30stim_10block_3max_10seq_2start(stimMatrix_30stim_10block_3max_10seq_2start == 3) = 2;
    % store
    configs.behavior.tables.stimMatrix_30stim_10block_3max_10seq_2start = stimMatrix_30stim_10block_3max_10seq_2start;
end;
o('Generating stim/nTones matrices 5 / 6 done.', 0, 0);

% % spot matrix with 3 spots, 60 trials, 1 or 2 as start
% stimTypes = [1 2 3]; stimSize = 60; blockSize = 3; maxConsec = 1; nSeqs = 1; seqStart = 1; plotMatrix = 0;
% spotMatrix_1spot_60stim_3block_1max_1seq = ones(nSeqs, stimSize);
% % store
% configs.behavior.tables.spotMatrix_1spot_60stim_3block_1max_1seq = spotMatrix_1spot_60stim_3block_1max_1seq;
% try
%     spotMatrix_3spot_60stim_3block_1max_1seq ...
%         = configs.behavior.tables.spotMatrix_3spot_60stim_3block_1max_1seq; % 1 as start
% catch e;
% end; 
% if ~exist('spotMatrix_3spot_60stim_3block_1max_1seq', 'var');
%     spotMatrix_3spot_60stim_3block_1max_1seq = genStimMatrix(stimTypes, stimSize, blockSize, maxConsec, nSeqs, ...
%         seqStart, plotMatrix);
%     % store
%     configs.behavior.tables.spotMatrix_3spot_60stim_3block_1max_1seq = spotMatrix_3spot_60stim_3block_1max_1seq;
% end;
% % spot matrix with 2 spots, 60 trials, 1 or 2 as start
% stimTypes = [1 2]; stimSize = 60; blockSize = 2; maxConsec = 1; nSeqs = 1;
% try
%     spotMatrix_2spot_60stim_2block_1max_1seq ...
%         = configs.behavior.tables.spotMatrix_2spot_60stim_2block_1max_1seq; % 1 as start
% catch e;
% end; 
% if ~exist('spotMatrix_2spot_60stim_2block_1max_1seq', 'var');
%     spotMatrix_2spot_60stim_2block_1max_1seq = repmat(stimTypes, nSeqs, stimSize / numel(stimTypes));
%     % store
%     configs.behavior.tables.spotMatrix_2spot_60stim_2block_1max_1seq = spotMatrix_2spot_60stim_2block_1max_1seq;
% end;
% o('Generating stim/nTones matrices 4 / 6 done.', 0, 0);

% 30 trials, only 1s or 2s
stimSize = 30;
stimMatrix_30stim_10block_1sOnly = ones(nSeqs, stimSize);
stimMatrix_30stim_10block_2sOnly = 2 * ones(nSeqs, stimSize);
% 50 trials, 1 as start
stimSize = 50;
stimMatrix_50stim_10block_1sOnly = ones(nSeqs, stimSize);
stimMatrix_50stim_10block_2sOnly = 2 * ones(nSeqs, stimSize);
% 60 trials, 1 as start
stimSize = 60;
stimMatrix_60stim_10block_1sOnly = ones(nSeqs, stimSize);
stimMatrix_60stim_10block_2sOnly = 2 * ones(nSeqs, stimSize);
o('Generating stim/nTones matrices 6 / 6 done.', 0, 0);

% stimTypes = 6 : 10; stimSize = 50; seqStart = []; plotMatrix = 0;
% try
%     nTones_50stim_10block_3max_10seq = configs.behavior.tables.nTones_50stim_10block_3max_10seq;
% catch e;
% end;
% if ~exist('nTones_50stim_10block_3max_10seq', 'var');
%     nTones_50stim_10block_3max_10seq = genStimMatrix(stimTypes, stimSize, blockSize, maxConsec, nSeqs, seqStart, ...
%         plotMatrix);
% end;
% o('Generating stim/nTones matrices 6 / 6 done.', 0, 0);

%% - configs: animals
configs.animals = { ...
    '160105_03',      'freqDiscr',     'EC1';   ...
};

%% - configs: behavior: cloud of tones discrimination base config
% - configs: behavior: cloud of tones discrimination QW (quiet wakefulness)
s.tone.samplingFreq = TDTSampFreq;
s.tone.toneDur = 1;
s.tone.toneISI = 0;
s.tone.stimDur = 0.5; % half second long sound
s.tone.uniqueFreqs = pureToneFreqs;
s.tone.freqIndexes = [1 2];
s.tone.freqs = s.tone.uniqueFreqs(s.tone.freqIndexes);
s.tone.goStim = []; % no go stim
s.tone.stimProba = [];
s.tone.nTones = 1;
s.tone.ISI = 0;
s.tone.stimProba = [];
s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_1start;
s.training.nTrials = 30;
s.training.allowEarlyLicks = 1;
s.training.spotMatrix = {};
s.training.startDelay = 4;
s.training.startDelayRand = 0;
s.training.minRespTime = 0;
s.training.lightInTime = 0;
s.training.maxRespTime = 0;
s.training.minRespRand = 0;
s.training.rewCollTime = 0;
s.training.rewDur = 0;
s.training.timeoutPunish = 0;
s.training.endDelay = 6;
s.training.trialStartLightCueParams = [ 0.5, 0, 1 ];
s.training.rewardPeriodLightCueParams = [ 0.15, 0.1, 3 ];
sBase = s;
configs.behavior.freqDiscr.QW = s;
% longer en delay
s.training.endDelay = 8;
configs.behavior.freqDiscr.QWL = s;

%% - configs: behavior: light-water pairing
s.tone.stimMatrix = stimMatrix_60stim_10block_1sOnly;
s.tone.stimDur = 0; % no sound
s.training.rewDur = 0.02;
s.training.rewCollTime = 0.5;
s.tone.goStim = 1;
s.training.startDelay = 1;
s.training.startDelayRand = 1;
s.training.nTrials = 30;
s.training.minRespTime = 0.5;
s.training.minRespRand = 0;
s.training.lightInTime = s.training.minRespTime;
s.training.lightDur = 0.1;
respTime = 1.5; s.training.maxRespTime = s.training.minRespTime + respTime;
s.training.endDelay = 1;
configs.behavior.freqDiscr.LWPA = s;

s.training.startDelay = 2;
s.training.startDelayRand = 1;
configs.behavior.freqDiscr.LWPB = s;

s.training.startDelay = 3;
s.training.startDelayRand = 1;
s.training.endDelay = 1;
configs.behavior.freqDiscr.LWPC = s;

%% - configs: behavior: discrimination A (learn to lick)
s.tone.stimDur = 0.5; % half second sound
s.training.startDelay = 3;
s.training.startDelayRand = 0;
s.training.nTrials = 30;
s.training.minRespTime = 0.5;
s.training.minRespRand = 0;
s.training.lightInTime = s.training.minRespTime;
s.training.lightDur = 0.1;
respTime = 2; s.training.maxRespTime = s.training.minRespTime + respTime;
s.training.rewCollTime = 2;
s.training.rewDur = 0.02;
s.training.timeoutPunish = 0;
    % -- 3-sec end delay version
    s.training.endDelay = 3;
        % --- low cloud version
        s.tone.goStim = 1; % low cloud is the target
        s.tone.stimMatrix = stimMatrix_60stim_10block_1sOnly;
        configs.behavior.freqDiscr.AA1 = s;
        % --- high cloud version
        s.tone.stimMatrix = stimMatrix_60stim_10block_2sOnly;
        s.tone.goStim = 2; % high cloud is the target
        configs.behavior.freqDiscr.AA2 = s;
    % -- 60 trials version
    s.training.nTrials = 60;
        % --- low cloud version
        s.tone.goStim = 1; % low cloud is the target
        s.tone.stimMatrix = stimMatrix_60stim_10block_1sOnly;
        configs.behavior.freqDiscr.AB1 = s;
        % --- high cloud version
        s.tone.stimMatrix = stimMatrix_60stim_10block_2sOnly;
        s.tone.goStim = 2; % high cloud is the target
        configs.behavior.freqDiscr.AB2 = s;

%% - configs: behavior: discrimination C (discrimination)
s.tone.stimDur = 2;
s.training.allowEarlyLicks = 1;
s.training.NMissToGiveAutoRewardAfter = Inf;
s.training.startDelay = 3;
s.training.startDelayRand = 0;
s.training.nTrials = 120;
s.training.minRespTime = 2.15;
s.training.minRespRand = 0;
s.training.lightInTime = s.training.minRespTime;
s.training.lightDur = 0.1;
respTime = 2; s.training.maxRespTime = s.training.minRespTime + respTime;
s.training.rewCollTime = 2;
s.training.rewDur = 0.02;
s.training.timeoutPunish = 2;
    % --- low tone version
    s.tone.goStim = 1; % low tone is the target
    s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_1start;
    configs.behavior.freqDiscr.CA1 = s;
    % --- high tone version
    s.tone.goStim = 2; % high tone is the target
    s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_2start;
    configs.behavior.freqDiscr.CA2 = s;
        
    % --- low tone version with high go probability
    s.training.allowEarlyLicks = 0.9;
    s.training.minRespTime = 2.20;
    s.training.lightInTime = s.training.minRespTime;
    respTime = 2; s.training.maxRespTime = s.training.minRespTime + respTime;
    s.tone.goStim = 1; % low tone is the target
    s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_1start_80p1_20p2;
    configs.behavior.freqDiscr.CB1 = s;
    % --- high tone version
    s.tone.goStim = 2; % high tone is the target
    s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_2start_80p2_20p1;
    configs.behavior.freqDiscr.CB2 = s;
        
    % --- low tone version with high go probability
    s.training.nTrials = 72;
    s.training.allowEarlyLicks = 0.7;
    s.tone.goStim = 1; % low tone is the target
    s.tone.stimMatrix = stimMatrix_72stim_10block_3max_10seq_1start_66p1_33p2;
    configs.behavior.freqDiscr.CC1 = s;
    % --- high tone version
    s.tone.goStim = 2; % high tone is the target
    s.tone.stimMatrix = stimMatrix_72stim_10block_3max_10seq_2start_66p2_33p1;
    configs.behavior.freqDiscr.CC2 = s;
        
    % --- low tone version with high go probability
    s.training.nTrials = 60;
    s.training.allowEarlyLicks = 0.4;
    % --- low tone version
    s.tone.goStim = 1; % low tone is the target
    s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_1start_80p1_20p2;
    configs.behavior.freqDiscr.CD1 = s;
    % --- high tone version
    s.tone.goStim = 2; % high tone is the target
    s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_2start_80p2_20p1;
    configs.behavior.freqDiscr.CD2 = s;
        
    % --- low tone version with high go probability
    s.training.minRespTime = 2.40;
    s.training.lightInTime = s.training.minRespTime;
    respTime = 2; s.training.maxRespTime = s.training.minRespTime + respTime;
    s.training.NMissToGiveAutoRewardAfter = 1;
    s.training.nTrials = 60;
    s.training.allowEarlyLicks = 0;
    % --- low tone version
    s.tone.goStim = 1; % low tone is the target
    s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_1start_80p1_20p2;
    configs.behavior.freqDiscr.CE1 = s;
    % --- high tone version
    s.tone.goStim = 2; % high tone is the target
    s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_2start_80p2_20p1;
    configs.behavior.freqDiscr.CE2 = s;
        
    % --- low tone version with high go probability
    s.training.minRespTime = 2.50;
    s.training.lightInTime = s.training.minRespTime;
    respTime = 2; s.training.maxRespTime = s.training.minRespTime + respTime;
    s.training.NMissToGiveAutoRewardAfter = 2;
    % --- low tone version
    s.tone.goStim = 1; % low tone is the target
    s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_1start_80p1_20p2;
    configs.behavior.freqDiscr.CF1 = s;
    % --- high tone version
    s.tone.goStim = 2; % high tone is the target
    s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_2start_80p2_20p1;
    configs.behavior.freqDiscr.CF2 = s;
        
    % --- low tone version with high go probability
    s.training.minRespTime = 2.60;
    s.training.lightInTime = s.training.minRespTime;
    respTime = 2; s.training.maxRespTime = s.training.minRespTime + respTime;
    s.training.NMissToGiveAutoRewardAfter = 3;
    % --- low tone version
    s.tone.goStim = 1; % low tone is the target
    s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_1start_80p1_20p2;
    configs.behavior.freqDiscr.CG1 = s;
    % --- high tone version
    s.tone.goStim = 2; % high tone is the target
    s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_2start_80p2_20p1;
    configs.behavior.freqDiscr.CG2 = s;
              
%% - configs: behavior: discrimination with delay D (discrimination)
s.tone.stimDur = 2;
s.training.allowEarlyLicks = 0;
s.training.NMissToGiveAutoRewardAfter = Inf;
s.training.minRespTime = 2.6;
s.training.minRespRand = 0;
s.training.lightInTime = s.training.minRespTime;
s.training.lightDur = 0.1;
respTime = 2; s.training.maxRespTime = s.training.minRespTime + respTime;
s.training.rewCollTime = 2;
s.training.rewDur = 0.02;
s.training.timeoutPunish = 2;
s.training.nTrials = 60;
    % --- low tone version
    s.tone.goStim = 1; % low tone is the target
    s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_1start_80p1_20p2;
    configs.behavior.freqDiscr.DA1 = s;
    % --- high tone version
    s.tone.goStim = 2; % high tone is the target
    s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_2start_80p2_20p1;
    configs.behavior.freqDiscr.DA2 = s;
    
s.training.minRespTime = 2.7;
s.training.lightInTime = s.training.minRespTime;
respTime = 2; s.training.maxRespTime = s.training.minRespTime + respTime;
    % --- low tone version
    s.tone.goStim = 1; % low tone is the target
    s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_1start_80p1_20p2;
    configs.behavior.freqDiscr.DB1 = s;
    % --- high tone version
    s.tone.goStim = 2; % high tone is the target
    s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_2start_80p2_20p1;
    configs.behavior.freqDiscr.DB2 = s;
    
s.training.minRespTime = 2.8;
s.training.lightInTime = s.training.minRespTime;
respTime = 2; s.training.maxRespTime = s.training.minRespTime + respTime;
    % --- low tone version
    s.tone.goStim = 1; % low tone is the target
    s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_1start_80p1_20p2;
    configs.behavior.freqDiscr.DC1 = s;
    % --- high tone version
    s.tone.goStim = 2; % high tone is the target
    s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_2start_80p2_20p1;
    configs.behavior.freqDiscr.DC2 = s;
    
s.training.minRespTime = 2.9;
s.training.lightInTime = s.training.minRespTime;
respTime = 2; s.training.maxRespTime = s.training.minRespTime + respTime;
    % --- low tone version
    s.tone.goStim = 1; % low tone is the target
    s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_1start_80p1_20p2;
    configs.behavior.freqDiscr.DD1 = s;
    % --- high tone version
    s.tone.goStim = 2; % high tone is the target
    s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_2start_80p2_20p1;
    configs.behavior.freqDiscr.DD2 = s;
    
s.training.minRespTime = 3.0;
s.training.lightInTime = s.training.minRespTime;
respTime = 2; s.training.maxRespTime = s.training.minRespTime + respTime;
    % --- low tone version
    s.tone.goStim = 1; % low tone is the target
    s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_1start_80p1_20p2;
    configs.behavior.freqDiscr.DE1 = s;
    % --- high tone version
    s.tone.goStim = 2; % high tone is the target
    s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_2start_80p2_20p1;
    configs.behavior.freqDiscr.DE2 = s;
    
s.training.minRespTime = 3.2;
s.training.lightInTime = s.training.minRespTime;
respTime = 2; s.training.maxRespTime = s.training.minRespTime + respTime;
    % --- low tone version
    s.tone.goStim = 1; % low tone is the target
    s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_1start_80p1_20p2;
    configs.behavior.freqDiscr.DF1 = s;
    % --- high tone version
    s.tone.goStim = 2; % high tone is the target
    s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_2start_80p2_20p1;
    configs.behavior.freqDiscr.DF2 = s;
    
s.training.minRespTime = 3.5;
s.training.lightInTime = s.training.minRespTime;
respTime = 2; s.training.maxRespTime = s.training.minRespTime + respTime;
    % --- low tone version
    s.tone.goStim = 1; % low tone is the target
    s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_1start_80p1_20p2;
    configs.behavior.freqDiscr.DG1 = s;
    % --- high tone version
    s.tone.goStim = 2; % high tone is the target
    s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_2start_80p2_20p1;
    configs.behavior.freqDiscr.DG2 = s;
    
s.training.minRespTime = 4;
s.training.lightInTime = s.training.minRespTime;
respTime = 2; s.training.maxRespTime = s.training.minRespTime + respTime;
    % --- low tone version
    s.tone.goStim = 1; % low tone is the target
    s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_1start_80p1_20p2;
    configs.behavior.freqDiscr.DH1 = s;
    % --- high tone version
    s.tone.goStim = 2; % high tone is the target
    s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_2start_80p2_20p1;
    configs.behavior.freqDiscr.DH2 = s;

%% - configs: behavior: discrimination with delay E (discrimination)
s.training.endDelay = 6;
s.tone.stimDur = 2;
s.training.allowEarlyLicks = 1;
s.training.NMissToGiveAutoRewardAfter = Inf;
s.training.minRespTime = 2.5;
s.training.minRespRand = 0;
s.training.lightInTime = s.training.minRespTime;
s.training.lightDur = 0.1;
respTime = 2; s.training.maxRespTime = s.training.minRespTime + respTime;
s.training.rewCollTime = 2;
s.training.rewDur = 0.15;
s.training.timeoutPunish = 2;
s.training.nTrials = 120;
    % --- low tone version
    s.tone.goStim = 1; % low tone is the target
    s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_1start;
    configs.behavior.freqDiscr.EA1 = s;
    % --- high tone version
    s.tone.goStim = 2; % high tone is the target
    s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_2start;
    configs.behavior.freqDiscr.EA2 = s;
    
s.training.allowEarlyLicks = 0;
s.training.minRespTime = 3.0;
s.training.lightInTime = s.training.minRespTime;
respTime = 2; s.training.maxRespTime = s.training.minRespTime + respTime;
    % --- low tone version
    s.tone.goStim = 1; % low tone is the target
    s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_1start;
    configs.behavior.freqDiscr.EB1 = s;
    % --- high tone version
    s.tone.goStim = 2; % high tone is the target
    s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_2start;
    configs.behavior.freqDiscr.EB2 = s;
    
% s.training.minRespTime = 4.0;
s.training.minRespTime = 4.5;
s.training.lightInTime = s.training.minRespTime;
respTime = 2; s.training.maxRespTime = s.training.minRespTime + respTime;
    % --- low tone version
    s.tone.goStim = 1; % low tone is the target
    s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_1start;
    configs.behavior.freqDiscr.EC1 = s;
    % --- high tone version
    s.tone.goStim = 2; % high tone is the target
    s.tone.stimMatrix = stimMatrix_60stim_10block_3max_10seq_2start;
    configs.behavior.freqDiscr.EC2 = s;
    
%% - configs: hardware

configs.hardware.H42 = struct();

configs.hardware.H42.adaptorID = 'ni';

configs.hardware.H42.analogIn.piezo.deviceName = 'BehaviorBox';
configs.hardware.H42.analogIn.piezo.channel = 'ai0';
configs.hardware.H42.analogIn.piezo.range = [-1 1];
configs.hardware.H42.analogIn.piezo.inputType = 'SingleEnded';

configs.hardware.H42.analogIn.micr.deviceName = 'BehaviorBox';
configs.hardware.H42.analogIn.micr.channel = 'ai1';
configs.hardware.H42.analogIn.micr.range = [-10 10];
configs.hardware.H42.analogIn.micr.inputType = 'SingleEnded';

configs.hardware.H42.analogIn.trig.channel = 'ai2';
configs.hardware.H42.analogIn.trig.deviceName = 'BehaviorBox';
configs.hardware.H42.analogIn.trig.range = [-10 10];
configs.hardware.H42.analogIn.trig.inputType = 'SingleEnded';

% configs.hardware.H42.analogIn.yscan.channel = 'ai2';
% configs.hardware.H42.analogIn.yscan.deviceName = 'BehaviorBox';
% configs.hardware.H42.analogIn.yscan.range = [-10 10];
% configs.hardware.H42.analogIn.yscan.inputType = 'SingleEnded';

% configs.hardware.H42.analogIn.motion.deviceName = 'ExtraChannels';
% configs.hardware.H42.analogIn.motion.channel = 'ai0';
% configs.hardware.H42.analogIn.motion.range = [-10 10];
% configs.hardware.H42.analogIn.motion.inputType = 'SingleEnded';

configs.hardware.H42.digitalOut.valve.deviceName = 'BehaviorBox';
configs.hardware.H42.digitalOut.valve.portLine = 'Port0/Line0';
configs.hardware.H42.digitalOut.valve.defaultState = 1;

% configs.hardware.H42.digitalOut.airPuff.deviceName = 'BehaviorBox';
% configs.hardware.H42.digitalOut.airPuff.portLine = 'Port0/Line1';
% configs.hardware.H42.digitalOut.airPuff.defaultState = 1;

% configs.hardware.H42.analogOut.spoutPos.deviceName = 'BehaviorBox';
% configs.hardware.H42.analogOut.spoutPos.range = [0 5];
% configs.hardware.H42.analogOut.spoutPos.channel = 'ao0';

% configs.hardware.H42.analogOut.ETL.deviceName = 'BehaviorBox';
% configs.hardware.H42.analogOut.ETL.range = [0 5];
% configs.hardware.H42.analogOut.ETL.channel = 'ao0';

configs.hardware.H42.analogOut.imagTTL.deviceName = 'BehaviorBox';
configs.hardware.H42.analogOut.imagTTL.range = [0 5];
configs.hardware.H42.analogOut.imagTTL.channel = 'ao1';

configs.hardware.H42.analogOut.light.deviceName = 'BehaviorBox';
configs.hardware.H42.analogOut.light.channel = 'ao0';
configs.hardware.H42.analogOut.light.range = [0 5];


% save configs
save('C:\Users\laurenczy\Documents\matlab\caImgAnalysis\OCIA\misc\behavior\mainConf.mat', ...
    'configs');
save('C:\Users\laurenczy\Documents\LabVIEW Data\mainConf.mat', 'configs');

vars = who; vars(cellfun(@(cont)strcmp(cont, 'this') || strcmp(cont, 'vars'), vars)) = []; clear(vars{:}); clear vars;
