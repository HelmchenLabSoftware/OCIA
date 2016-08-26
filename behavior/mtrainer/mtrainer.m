function mtrainer()
% main function for mtrainer experiment suite
% all times are in s!

% written by Henry Luetcke (hluetck@gmail.com)
% 2013-05-07
% modified by Balazs Laurenczy (blaurenczy@gmail.com)
% 2013-05-15
% modified by Balazs Laurenczy (blaurenczy@gmail.com)
% 2013-08-08

doEmptyWater = 0;
% doEmptyWater = 1;

automode = 5; % if > 0, sets the number of seconds to wait before a new run of mtrainer

lickThresh = 0.13;
% lickThresh = NaN;

unsavedOut = struct();

% mouseId = 'testing'; taskType = 'freqDiscrimination'; phase = 'C';

% mouseId = '130801_01'; taskType = 'freqDiscrimination'; phase = 'F';
mouseId = '130801_03'; taskType = 'freqDiscrimination'; phase = 'F';

% mouseId = '130408_02'; taskType = 'freqDiscrimination'; phase = 'D';
% mouseId = '130416_01'; taskType = 'oddballDiscrimination'; phase = 'E';
% mouseId = '130425_01'; taskType = 'freqDiscrimination';  phase = 'B';
% mouseId = '130425_02'; taskType = 'oddballDiscrimination'; phase = 'C';
% mouseId = '130528_01'; taskType = 'oddballDiscrimination'; phase = 'B';
% mouseId = '130528_02'; taskType = 'oddballDiscrimination'; phase = 'B';

basePath = 'P:\matlab\daq\mtrainer\configs\';
configMat = load([basePath taskType filesep taskType '_phase' phase '.mat']);
config = configMat.config;

unsavedOut.mouseId = mouseId;
unsavedOut.taskType = taskType;
unsavedOut.phase = phase;
unsavedOut.basePath = basePath;
unsavedOut.config = config;

%% Setup - stimuli and trials
fprintf('Setup stimuli and trials... ');
% set up stimulus vector
stims = [];
for iFreq = 1 : numel(config.tone.freqs)
    stimForFreq = repmat(iFreq, 1, round(config.tone.stimProba(iFreq) * config.training.nTrials));
    stims = [stims, stimForFreq]; %#ok<AGROW>
end
stims = stims(randperm(numel(stims)));
clear stim;

% set up oddball vector by altering stims with a certain probability
odds = stims;
oddPos = zeros(size(odds));
uniqueStims = unique(stims);
isOdd = rand(1, numel(stims)) < config.tone.oddProba;
uniqueOddPos = config.tone.nTones - 1 : config.tone.nTones; % last 2 tones can be odd
for iStim = 1 : numel(isOdd);
    if isOdd(iStim);
        otherStims = uniqueStims(uniqueStims ~= stims(iStim));
        otherStims = otherStims(randperm(numel(otherStims)));
        mixedOddPos = uniqueOddPos(randperm(numel(uniqueOddPos)));
        odds(iStim) = otherStims(1);
        oddPos(iStim) = mixedOddPos(1);
    end;
end;

% set up tone array
toneArray = MakePureMultiToneOddballArray(config.tone.freqs, stims, odds, oddPos, ...
    config.tone.nTones, config.tone.toneDur, config.tone.ISI, config.tone.samplingFreq);

unsavedOut.stims = stims;
unsavedOut.odds = odds;
unsavedOut.oddPos = oddPos;
unsavedOut.isOdd = isOdd;

fprintf('done.\n');

%% Setup - hardware
% define globals
global recordedValues;

% analog input
daqreset;
fprintf('Connecting hardware...\n');
s1 = daq.createSession(config.hardware.adaptorID);
recordRate = config.hardware.analogIn_SampleRate;
% recordRate = 700;
s1.Rate = recordRate;
s1.addAnalogInputChannel(config.hardware.analogIn_Device, ...
    config.hardware.analogIn_Channel, 'Voltage');
s1.Channels(1).InputType = config.hardware.analogIn_InputType;
s1.Channels(1).Range = config.hardware.analogIn_Range;
fprintf('s1 ok.\n');

s2 = daq.createSession(config.hardware.adaptorID);
s2.addDigitalChannel(config.hardware.digitalOut_Device, config.hardware.digitalOut_PortLine, 'OutputOnly');
fprintf('And s2 ok. Ready to go.\n');

if isnan(lickThresh);
    % baseline measurement
    fprintf('Testing analog input for licking threshold (baseline)... ');
    recordDuration = 2;
    s1.DurationInSeconds = recordDuration;
    baseline = s1.startForeground; % this will block the command line
    meanData = mean(baseline);
    stdData = std(baseline);
    lickThresh = 2.8 * stdData;
    fprintf('done.\n')

    pause(1);

    % lick measurement
    fprintf('Testing analog input for licking threshold (licking)... ');
    s1.DurationInSeconds = recordDuration;
    lick = s1.startForeground; % this will block the command line
    fprintf('done.\n2SD: %1.2f, lick threshold: %1.2f\n', 2 * stdData, lickThresh);

    % plotting
    figure('Name', 'LickingThreshold', 'Position', [150, 300, 950, 350], 'NumberTitle', 'off' ...
... %         , 'MenuBar', 'none', 'ToolBar', 'none');
    );
    plot((1:numel(baseline)) / recordRate, baseline - meanData, 'b');
    hold on;
    plot((1:numel(lick)) / recordRate, lick - meanData, 'r');
    line([0, recordDuration], [lickThresh, lickThresh], 'Color', 'green');
    line([0, recordDuration], [2 * stdData, 2 * stdData], 'Color', 'cyan');
    line([0, recordDuration], [- 2 * stdData, - 2 * stdData], 'Color', 'cyan');
    legend({'baseline', 'licking', 'lickTreshold', '\pm 2SD'});
    title(sprintf('2SD: %1.2f, lick thresh %1.2f', 2 * stdData, lickThresh));
else
    fprintf('Testing analog input for licking threshold... skipped.\nLick threshold: %1.2f\n', ...
        lickThresh);
end;

unsavedOut.lickThresh = lickThresh;

% digital out
fprintf('Testing reward system by opening for %.2fs after a delay of %.2fs... ', ...
    config.training.rewDur, config.training.rewDelay);
giveReward(s2, config.training.rewDur * 3, config.training.rewDelay);
fprintf('done!\n')
if doEmptyWater > 0;
    doEmptyWater = str2double(input('Empty water ? >0 = yes, <0 = no\n', 's')); %#ok<UNRCH>
    while doEmptyWater > 0;
        fprintf('Emptying water... ');
        giveReward(s2, doEmptyWater, 0);
        fprintf(' done.');
        doEmptyWater = str2double(input('Empty more ? >0 = yes, <0 = no\n', 's'));
        if isnan(doEmptyWater); doEmptyWater = 0; end;
        if ~doEmptyWater; break; end;
    end;
end;

s1.IsNotifyWhenDataAvailableExceedsAuto = true;
lh = s1.addlistener('DataAvailable', @(src, event) recordAndStop(src, event, lickThresh));
s1.IsContinuous = true;
s1.prepare;

%% Setup - saving settings
recordedValues = 0;
saveTime = datestr(now, 'yyyy_mm_dd__HH_MM_SS');
saveFolder = sprintf('C:\\Users\\laurenczy\\mtrainerData\\%s\\', mouseId);
savePath = sprintf('%s%s__%s', saveFolder, mouseId, saveTime);
mkdir(saveFolder);
logfile = sprintf('%s_log.txt', savePath);
logDateFormat = 'yyyy-mm-dd HH:MM:SS.FFF';

% create an 'onCleanup' function to handle interruptions by CTRL+C
c = onCleanup(@()closeDiaryAndSaveOutput(savePath, lh, s1, s2));

fprintf('Finished setting up and hardware tests.\n');
fprintf('CHECK MOUSE ID!! currently: %s.\n', mouseId);
if automode;
    pause(automode);
else
    fprintf('Then press any key to start!'); %#ok<UNRCH>
    pause;
end;

unsavedOut.savePath = savePath;
unsavedOut.saveTime = saveTime;

diary(logfile);
%% Start experiment
fprintf('Experiment start: %s\n\n', datestr(now, logDateFormat));
try
    
    %% Experiment - initialize variables
    
    dbgLevel = 0;
    out = unsavedOut;

    o('config: %s phase %s (%dF%dT)', out.taskType, out.phase, numel(config.tone.freqs), ...
        config.tone.nTones, 0, dbgLevel);
    o('animal: %s', mouseId, 0, dbgLevel);
    o('savePath: %s', savePath, 0, dbgLevel);
    o('lickThresh: %1.2f, ISI: %1.2f', lickThresh, config.tone.ISI, 0, 0);
    o('rewardCollectionTime: %1.2f, InTriLickTimerDur: %1.2f', ...
        config.training.rewCollTime, ...
        config.training.InTriLickTimerDur, 0, dbgLevel);
    
    nTrials = config.training.nTrials;
    
%     totalTrialDur = config.training.trialDur + config.training.startDelay + ...
%         config.training.rewCollTime;
    % compute relative start times for each trial
%     out.trialStarts_sched = 0 : totalTrialDur : (nTrials - 1) * totalTrialDur;
%     out.trialStarts_obs = zeros(1, nTrials);
%     out.trialEnds_obs = zeros(1, nTrials);

    out.trialStartDelays = zeros(1, nTrials);
    out.trialStartTimes = zeros(1, nTrials);
    out.trialEndTimes = zeros(1, nTrials);
    out.respTimes = nan(1, nTrials);
    out.nInTriLick = nan(1, nTrials);
    out.resps = nan(1, nTrials);
    out.respDelays = nan(1, nTrials);
    % for each trial: 1 = correct detect, 2 = correct reject, 3 = false alarm, 4 = miss, 5 = early
    out.respTypes = nan(1, nTrials);
    out.expStartTime = tic;
    isPunish = 0;
    
    for iTrial = 1 : nTrials;
        out.iTrial = iTrial;
        % listen for response
        s1.startBackground;
        pause(0.01)
        interTrialLickCount = 0;
        out.trialStartTimes(iTrial) = tic;
        
        % introduce a random delay for starting the tone
        out.trialStartDelays(iTrial) = config.training.startDelay + ...
            (rand(1) - 0.5) * 2 * config.training.startDelayRand;
        
        % add punishement time-out if needed
        if isPunish;
            out.trialStartDelays(iTrial) = out.trialStartDelays(iTrial) + config.training.timeoutPunish;
        end;
        
        %% Experiment - initial wait
        while toc(uint64(out.trialStartTimes(iTrial))) < out.trialStartDelays(iTrial);
%             fprintf('CheckingA: s1.IsRunning? %d\n', s1.IsRunning);
            % check if no lick has been done
            if ~s1.IsRunning; % if not running anymore, it means a licking has been done
                remainingTime = out.trialStartDelays(iTrial) - toc(uint64(out.trialStartTimes(iTrial)));
                if interTrialLickCount > 0;
                    fprintf('|%.1f', remainingTime);
                else
                    fprintf('    inter-trial licking: |%.1f', remainingTime);
                end;
                
                % reset the starting delay to config.training.InTriLickTimerDur
                out.trialStartTimes(iTrial) = tic;
                if isPunish;
                    out.trialStartDelays(iTrial) = max(config.training.InTriLickTimerDur, remainingTime);
                else
                    out.trialStartDelays(iTrial) = config.training.InTriLickTimerDur;
                end;
                interTrialLickCount = interTrialLickCount + 1;
                pause(1);
                % restart the listening
                s1.startBackground;
                pause(0.1);
%             fprintf('CheckingB: s1.IsRunning? %d\n', s1.IsRunning);
            end
            % avoid full-speed looping
            pause(0.01);
        end;
        if interTrialLickCount;
            fprintf('|: %d inter-trial lick(s).\n', interTrialLickCount);
        end
        out.nInTriLick(iTrial) = interTrialLickCount;
        resp = 0;
        isPunish = 0;
        
        t_trialStart = tic;
        fprintf('Trial %03d/%03d - %s        ... ', iTrial, nTrials, datestr(now, logDateFormat));
        
        %% Experiment - play sound
        if s1.IsRunning
            soundToPlay = toneArray{iTrial};
            player = audioplayer(soundToPlay, config.tone.samplingFreq); %#ok<TNMLP>
            player.play;
        else
            fprintf('early (already licking, lick sensor: min/mean/max: %.2f/%.2f/%.2f).\n', ...
                recordedValues);
            
            isPunish = 1;
            
            out.respTypes(iTrial) = 5;
            % analyse every 10 trials
            if ~rem(iTrial, 10) && iTrial ~= nTrials;
                mtrainerAnalyser_performance(out.respTypes, 0);
            end;
            continue;
        end
        breakOut = 0;
        %% Experiment - wait for response
        while toc(t_trialStart) < config.training.trialDur;
            if s1.IsRunning
                % no response detected
            else
                % seconds since trial start
                respTime = toc(t_trialStart);
                out.respTimes(iTrial) = respTime;
                % response should be 'minRespTime' after the end of the tone!
                totToneDur = (config.tone.toneDur + config.tone.ISI) * config.tone.nTones - config.tone.ISI;
                limitRespTime = totToneDur + config.training.minRespTime;
%                 limitRespTime = config.training.minRespTime;
                out.respDelays(iTrial) = limitRespTime - respTime;
                % early response, count as kind of false alarm
                if respTime < limitRespTime;
%                     fprintf('early (lick sensor: min/mean/max: %.2f/%.2f/%.2f).\n', ...
%                         recordedValues);
                    fprintf('early (response time: %.4f, limit response time: %.4f, diff: %.5f).\n', ...
                        respTime, limitRespTime, limitRespTime - respTime);
                    
                    isPunish = 1;
                    out.respTypes(iTrial) = 5;
                    breakOut = 1;
                    break;
                else
%                     fprintf('Lick at %s\n', datestr(clock, logDateFormat))
                    resp = 1;
                end;
                break; % break out of while loop
            end;
            pause(0.02); % necessary to allow time for data collection
        end;
        if breakOut;
            out.trialEndTimes(iTrial) = toc(uint64(out.trialStartTimes(iTrial)));
            % analyse every 10 trials
            if ~rem(iTrial, 10) && iTrial ~= nTrials;
                mtrainerAnalyser_performance(out.respTypes, 0);
            end;
            continue;  % continue for loop
        end;
        if s1.IsRunning;
            s1.stop;
        end;
        %% Experiment - analyse response
        out.resps(iTrial) = resp;
        isOddTrial = stims(iTrial) ~= odds(iTrial);
        if config.tone.oddProba > 0; % oddball discrimination
            isTargetStim = isOddTrial && config.tone.goStim;
        else % frequency discrimination
            isTargetStim = stims(iTrial) == config.tone.goStim;
        end;
        if resp == 1 && isTargetStim;
            % correct response
%             fprintf('correct detection (lick sensor: min/mean/max: %.2f/%.2f/%.2f).\n', ...
%                 recordedValues);
            fprintf('correct detection (response time: %.4f, limit response time: %.4f, diff: %.5f).\n', ...
                respTime, limitRespTime, limitRespTime - respTime);
            out.respTypes(iTrial) = 1;
            % give reward
            giveReward(s2,config.training.rewDur,config.training.rewDelay);
            % wait to collect the reward
            pause(config.training.rewCollTime);
        elseif resp == 1 && ~isTargetStim;
            % false alarm
%             fprintf('false alarm (lick sensor: min/mean/max: %.2f/%.2f/%.2f).\n', ...
%                 recordedValues);
            fprintf('false alarm (response time: %.4f, limit response time: %.4f, diff: %.5f).\n', ...
                respTime, limitRespTime, limitRespTime - respTime);
            out.respTypes(iTrial) = 3;
            % punish time-out
            isPunish = 1;
        elseif resp == 0 && isTargetStim;
            fprintf('miss.\n');
            out.respTypes(iTrial) = 4;
            % punish time-out
            isPunish = 1;
         elseif resp == 0 && ~isTargetStim;
            fprintf('correct rejection.\n');
            out.respTypes(iTrial) = 2;
            % go to next trial
        end
        out.trialEndTimes(iTrial) = toc(uint64(out.trialStartTimes(iTrial)));
        
        % analyse every 10 trials
        if ~rem(iTrial, 10) && iTrial ~= nTrials;
            mtrainerAnalyser_performance(out.respTypes, 0);
        end
    end
    
    %% End experiment
    fprintf('\nExperiment end: %s\n', datestr(now, logDateFormat));
    out.expTotDurTime = toc(out.expStartTime);
    fprintf('Total time: %02.0f:%02.0f\n', out.expTotDurTime / 60, mod(out.expTotDurTime, 60));
    mtrainerAnalyser_performance(out.respTypes, 2, out.savePath, out.nInTriLick);

catch err
    fprintf('\n\nAn error occured. Last trial: %1.0f. Cleaning up ...\n\n', iTrial)
    rethrow(err);
end

%% Function - giveReward
function giveReward(s2, rewDur, rewDelay)
    
    t_rewardStart = tic;
    % wait until for start delay
    while toc(t_rewardStart) < rewDelay; end;
    t_rewardStart = tic;
    % open digital out
    s2.outputSingleScan(0);
    % wait until for open duration
    while toc(t_rewardStart) < rewDur; end;
    % close digital out
    s2.outputSingleScan(1);
end

function recordAndStop(src, event, lickThresh)
    recordedValues = stopWhenExceedThreshold(src, event, lickThresh);
end

function closeDiaryAndSaveOutput(savePath, lh, s1, s2)
    fprintf('\nClosing diary... ');
    diary off;
    fprintf('done.\n');
    
    if (exist('out', 'var'));
        matFileName = sprintf('%s_out.mat', savePath);
        fprintf('Saving output as %s... ', matFileName);
        save(matFileName, 'out');
        fprintf('done.\n');
    else
        fprintf('/!\\ Output not saved\n');
    end;
    
    fprintf('Closing channels... ');
    if exist('lh', 'var'); delete(lh); end;
    if exist('s1', 'var'); delete(s1); end;
    if exist('s2', 'var'); delete(s2); end;
    fprintf('done.\n');
end

end
