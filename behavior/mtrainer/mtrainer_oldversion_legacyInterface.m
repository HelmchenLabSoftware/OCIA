function mtrainer(varargin)
% main function for mtrainer experiment suite
% all times are in s!

% written by Henry Luetcke (hluetck@gmail.com)
% 2012-11-08

if ~nargin
    % gui select mat-file with config structure
    [FileName,PathName] = uigetfile('*.mat','Select configuration file');
    S = load(fullfile(PathName,FileName));
    fields = fieldnames(S);
    config = S.(fields{1});
else
    config = varargin{1};
end

try
    parseConfig(config);
catch
    rethrow(lasterror)
    error('Failed to parse config struture')
end

%% Setup stimuli and trials
% set up stimVector
stimVector = [];
for n = 1:length(config.tone.fVector)
    stim = repmat(n,1,round(config.tone.stimProbabilities(n)*config.tone.trials));
    stimVector = [stimVector, stim];
end
stimVector = stimVector(randperm(numel(stimVector)));

% set up tone array
toneArray = MakePureToneArray(config.tone.fVector,stimVector,...
    config.tone.toneDuration,config.tone.sf);

%% Start hardware
% analog input
daqreset
ai=analoginput(config.hardware.adaptorID,config.hardware.analogIn_Device);
addchannel(ai, config.hardware.analogIn_Channel);
set(ai,'InputType','SingleEnded')
% sample rate and recording duration
ai.SampleRate = config.hardware.aiSampleRate;

% digital IO
dio=digitalio(config.hardware.adaptorID,config.hardware.digitalIO_Device);
digitalOut = addline(dio,config.hardware.digitalOut_Channel,'out');

% hardware 'warm-up'
% analog in
ai.SamplesPerTrigger = 100;
start(ai);
% get data
data = getdata(ai);
figure, plot(data)
lickThresh = 10.*std(data) + max(data);
fprintf('Lick threshold: %1.2f\n',lickThresh)
stop(ai), clear data
% digital out
putvalue(digitalOut,1) % 1 is light off, 0 is light on (strangely enough)
for n = 1:10; putvalue(digitalOut,0), putvalue(digitalOut,1), pause(0.1); end

% some changes to ai
ai.SamplesPerTrigger = Inf;
% % timer function
% trial = 1; t_trialStart = clock;
% ai.TimerFcn = {@daqTimerFunction};
% ai.TimerPeriod = 0.01;
% set(ai, 'TriggerRepeat', Inf);

logfile = sprintf('mtrainerLogfile_%s.txt',datestr(clock,30));
diary(logfile)

disp('Finished set up and hardware tests. Press any key to start!')
pause

%% Start experiment
fprintf('Experiment start: %s\n\n',datestr(now,'dd-mm-yyyy HH:MM:SS.FFF'))
try
    totalTrialDur = config.training.trialDuration(1) + config.training.startDelay;
    samplesPerTrial = round((totalTrialDur-0.1).*ai.SampleRate); % a bit less to allow for processing time
    maxTrials = numel(stimVector);
    maxTrials = 50; % for testing
    responseCount = zeros(1,4); % correct detect, correct reject, false alarm, miss
    % compute relative start times for each trial
    trialStartVector_scheduled = [0:totalTrialDur:(maxTrials-1)*totalTrialDur];
    trialStartVector_observed = zeros(1,maxTrials);
    trialEndVector_observed = zeros(1,maxTrials);
    daqStartTime = cell(1,maxTrials);
    start(ai);
    t_expStart = tic;
    for trial = 1:maxTrials
        while toc(t_expStart) < trialStartVector_scheduled(trial)
            % do nothing
        end
        trialStartVector_observed(trial) = toc(t_expStart);
        t_trialStart = tic;
        fprintf('Trial %1.0f - %s\n',trial, datestr(now, 'HH:MM:SS.FFF'))
        
        % play tone
        sound(toneArray{trial},config.tone.sf)
        response = 0;
        % listen for response
        while toc(t_trialStart) < config.training.trialDuration(1)
            size = min([ai.SamplesAvailable 10]);
            data = peekdata(ai, size);
            if max(data) > 0.1 % lick detected
                fprintf('Lick at %s (max = %1.2f)\n',datestr(clock,'HH:MM:SS.FFF'),max(data))
                response = 1;
                if stimVector(trial) == config.tone.goStim
                    % correct response
                    fprintf('Correct detection\n')
                    responseCount(1) = responseCount(1) + 1;
                    % give reward
                    giveReward(digitalOut,config.training.rewardDuration,config.training.rewardDelay);
                    if trial < maxTrials
                        trialStartVector_scheduled(trial+1:end) = ...
                            trialStartVector_scheduled(trial+1:end) + (config.training.rewardDuration+config.training.rewardDelay);
                    end
                else
                    % false alarm
                    fprintf('False alarm\n')
                    responseCount(3) = responseCount(3) + 1;
                    if trial < maxTrials
                        trialStartVector_scheduled(trial+1:end) = ...
                            trialStartVector_scheduled(trial+1:end) + config.training.timeoutPunish;
                    end
                end
                break
            end
        end
        if ~response && stimVector(trial) == config.tone.goStim
            fprintf('Miss\n')
            responseCount(4) = responseCount(4) + 1;
            if trial < maxTrials
                trialStartVector_scheduled(trial+1:end) = ...
                    trialStartVector_scheduled(trial+1:end) + config.training.timeoutPunish;
            end
        elseif ~response && stimVector(trial) ~= config.tone.goStim
            fprintf('Correct rejection\n')
            responseCount(2) = responseCount(2) + 1;
            giveReward(digitalOut,config.training.rewardDuration,config.training.rewardDelay);
            if trial < maxTrials
                trialStartVector_scheduled(trial+1:end) = ...
                    trialStartVector_scheduled(trial+1:end) + (config.training.rewardDuration+config.training.rewardDelay);
            end
        end
        
        trialEndVector_observed(trial) = toc(t_expStart);
    end
    
    fprintf('\nExperiment end: %s\n\n',datestr(now,'dd-mm-yyyy HH:MM:SS.FFF'))
    
    [lickData,lickDataT,daqStartTime] = ...
        getdata(ai,ai.SamplesAcquired);
    stop(ai); delete(ai); delete(dio)
    
    save('out.mat','lickData','lickDataT','daqStartTime',...
        'trialStartVector_scheduled','trialStartVector_observed',...
        'trialEndVector_observed')
    figure('Name','Trial start difference')
    plot((trialStartVector_observed-trialStartVector_scheduled).*1000,'k')
    xlabel('Trial'), ylabel('actual - scheduled / ms')
    doPerformanceAnalysis(responseCount);
    diary off
catch
    disp('An error occured. Cleaning up ...')
    stop(ai), delete(ai), delete(dio), diary off
    rethrow(lasterror)
end


%% Function - giveReward
function giveReward(digitalOut,rewardDuration,rewardDelay)
t_rewardStart = tic;
while toc(t_rewardStart) < rewardDelay
    % do nothing
end
t_rewardStart = tic;
% open digital out
putvalue(digitalOut,0)
while toc(t_rewardStart) < rewardDuration
    % do nothing
end
putvalue(digitalOut,1)

%% Function - doPerformanceAnalysis
function doPerformanceAnalysis(responseCount)
% responseCount columns: correct detect, correct reject, false alarm, miss
trials = sum(responseCount);
T = responseCount(1)+responseCount(4); % targets
N = responseCount(2)+responseCount(3); % non-targets
fprintf('\n\nPerformance:\n')
fprintf('Trials: %1.0f\n',trials)
fprintf('Correct detections: %1.0f (%1.2f%%)\n',responseCount(1),responseCount(1)./T.*100)
fprintf('Correct rejections: %1.0f (%1.2f%%)\n',responseCount(2),responseCount(2)./N.*100)
fprintf('False alarms: %1.0f (%1.2f%%)\n',responseCount(3),responseCount(3)./N.*100)
fprintf('Miss: %1.0f (%1.2f%%)\n',responseCount(4),responseCount(4)./T.*100)
fprintf('Total correct: %1.0f (%1.2f%%)\n',sum(responseCount(1:2)),sum(responseCount(1:2))./trials.*100)
fprintf('Total errors: %1.0f (%1.2f%%)\n',sum(responseCount(3:4)),sum(responseCount(3:4))./trials.*100)
dPrim = dprime(responseCount(1)./trials,responseCount(3)./trials,T,N);
fprintf('d'':%1.3f\n',dPrim)


%% Function - parseConfig
function parseConfig(config)
% list of required hardware fields:
requiredFields = {...
    'adaptorID'
    'analogIn_Device'
    'analogIn_Channel'
    'aiSampleRate'
    'digitalIO_Device'
    'digitalOut_Channel'
    };
accessFields(config.hardware,requiredFields);

% list of required tone fields:
requiredFields = {...
    'sf'
    'fVector'
    'stimProbabilities'
    'trials'
    'goStim'
    'toneDuration'
    };
accessFields(config.tone,requiredFields);

% list of required training fields:
requiredFields = {...
    'responseTime'
    'trialDuration'
    'startDelay'
    'rewardDuration'
    'rewardDelay'
    'timeoutPunish'
    };
accessFields(config.training,requiredFields);

function accessFields(S,fields)
for n = 1:numel(fields)
    S.(fields{n});
end





