function mtrainer()
% main function for mtrainer experiment suite
% all times are in s!

% written by Henry Luetcke (hluetck@gmail.com)
% 2013-05-07
% modified by Balazs Laurenczy (blaurenczy@gmail.com)
% 2013-05-15

doEmptyWater = 1;
automode = 1;
unsavedOut = struct();

mouseId = 'testing'; taskType = 'freqDiscrimination'; phase = 'D';
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
    stimForFreq = repmat(iFreq, 1, round(config.tone.stimProba(iFreq) * config.tone.nTrials));
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
s1.Rate = config.hardware.analogIn_SampleRate;
s1.addAnalogInputChannel(config.hardware.analogIn_Device, config.hardware.analogIn_Channel, 'Voltage');
s1.Channels(1).InputType = config.hardware.analogIn_InputType;
s1.Channels(1).Range = config.hardware.analogIn_Range;
fprintf('s1 ok.\n');

s2 = daq.createSession(config.hardware.adaptorID);
s2.addDigitalChannel(config.hardware.digitalOut_Device, config.hardware.digitalOut_PortLine, 'OutputOnly');
fprintf('And s2 ok. Ready to go.\n');

lickThresh = 0.18;
% lickThresh = NaN;

if isnan(lickThresh);
    % baseline measurement
    fprintf('Testing analog input for licking threshold (baseline)... ');
    recordDuration = 2;
    s1.DurationInSeconds = recordDuration;
    baseline = s1.startForeground; % this will block the command line
    meanData = mean(baseline);
    stdData = std(baseline);
    lickThresh = 2.5 * stdData;
    fprintf('done.\n')

    pause(1);

    % lick measurement
    fprintf('Testing analog input for licking threshold (licking)... ');
    s1.DurationInSeconds = recordDuration;
    lick = s1.startForeground; % this will block the command line
    fprintf('done.\n2SD: %1.2f, lick threshold: %1.2f\n', 2 * stdData, lickThresh);

    % plotting
    figure('Name', 'LickingThreshold', 'Position', [150, 300, 950, 350], 'NumberTitle', 'off', ...
        'MenuBar', 'none', 'ToolBar', 'none');
    plot((1:numel(baseline)) / 1000, baseline - meanData, 'b');
    hold on;
    plot((1:numel(lick)) / 1000, lick - meanData, 'r');
    line([0, recordDuration], [lickThresh, lickThresh], 'Color', 'green');
    line([0, recordDuration], [2 * stdData, 2 * stdData], 'Color', 'cyan');
    line([0, recordDuration], [- 2 * stdData, - 2 * stdData], 'Color', 'cyan');
    legend({'baseline', 'licking', 'lickTreshold', '\pm 2SD'});
else
    fprintf('Testing analog input for licking threshold... skipped.\nLick threshold: %1.2f\n', ...
        lickThresh);
end;

unsavedOut.lickThresh = lickThresh;

% digital out
fprintf('Testing reward system by opening for %.2fs after a delay of %.2fs... ', ...
    config.training.rewDur, config.training.rewDelay);
giveReward(s2, config.training.rewDur, config.training.rewDelay);
fprintf('done!\n')
if doEmptyWater;
    doEmptyWater = str2double(input('Empty water ? 1 = yes, 0 = no\n', 's')); %#ok<UNRCH>
    while doEmptyWater;
        fprintf('Emptying water... ');
        giveReward(s2, 0.03, 0);
    %         giveReward(s2, 3, 0);
        fprintf(' done.');
        doEmptyWater = str2double(input('Empty more ? 1 = yes, 0 = no\n', 's'));
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
    pause(5);
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
    
    totalTrialDur = config.training.trialDur + config.training.startDelay + ...
        config.training.rewCollTime;
    nTrials = numel(stims);
    % compute relative start times for each trial
    out.trialStarts_sched = 0 : totalTrialDur : (nTrials - 1) * totalTrialDur;
    out.trialStarts_obs = zeros(1, nTrials);
    out.trialEnds_obs = zeros(1, nTrials);
    out.respTimes = nan(1, nTrials);
    out.nInTriLick = zeros(1, nTrials);
    out.resps = nan(1, nTrials);
    out.respDelay = nan(1, nTrials);
    % for each trial: 1 = correct detect, 2 = correct reject, 3 = false alarm, 4 = miss, 5 = early
    out.respTypes = zeros(1, nTrials);
    out.expStartTime = tic;
    
    for iTrial = 1 : nTrials;
        out.iTrial = iTrial;
        % listen for response
        s1.startBackground;
        pause(0.01)
        interTrialLickCount = 0;
        %% Experiment - initial wait
        while toc(out.expStartTime) < out.trialStarts_sched(iTrial);
%             fprintf('CheckingA: s1.IsRunning? %d\n', s1.IsRunning);
            % check if no lick has been done
            if ~s1.IsRunning;
                remainingTime = out.trialStarts_sched(iTrial) - toc(out.expStartTime);
                addedDelay = 0;
                % delay the schedule if needed
                if (remainingTime < config.training.InTriLickTimerDur);
                    addedDelay = config.training.InTriLickTimerDur - remainingTime;
                    out.trialStarts_sched(iTrial:end) = out.trialStarts_sched(iTrial:end) + addedDelay;
                    % refresh the remaining time
                    remainingTime = out.trialStarts_sched(iTrial) - toc(out.expStartTime);
                end;
                if interTrialLickCount > 0;
                    fprintf('|%.1f', remainingTime);
                else
                    fprintf('    inter-trial licking, delaying for %.1fs: |%.1f', ...
                        addedDelay, remainingTime);
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
        end
        if interTrialLickCount;
            fprintf('|: %d inter-trial lick(s).\n', interTrialLickCount);
        end
        out.nInTriLick(iTrial) = interTrialLickCount;
        out.trialStarts_obs(iTrial) = toc(out.expStartTime);
        resp = 0;
        
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
            if iTrial < nTrials
                out.trialStarts_sched(iTrial+1:end) = ...
                    out.trialStarts_sched(iTrial+1:end) + config.training.timeoutPunish;
            end
            out.respTypes(iTrial) = 5;
            % analyse every 10 trials
            if ~rem(iTrial, 10) && iTrial ~= nTrials;
                mtrainerAnalyser_performance(out.respTypes, 0);
            end
            continue
        end
        breakOut = 0;
        %% Experiment - wait for response
        while toc(t_trialStart) < config.training.trialDur
            if s1.IsRunning
                % no response detected
            else
                % seconds since trial start
                respTime = toc(t_trialStart);
                out.respTimes(iTrial) = respTime;
                % response should be 'minRespTime' after the end of the tone!
                totToneDur = (config.tone.toneDur + config.tone.ISI) * config.tone.nTones - config.tone.ISI;
                limitRespTime = totToneDur + config.training.minRespTime;
                out.respDelay(iTrial) = limitRespTime - respTime;
                    % early response, count as kind of false alarm
                if respTime < limitRespTime;
%                     fprintf('early (lick sensor: min/mean/max: %.2f/%.2f/%.2f).\n', ...
%                         recordedValues);
                    fprintf('early (response time: %.4f, limit response time: %.4f, diff: %.5f).\n', ...
                        respTime, limitRespTime, limitRespTime - respTime);
                    if iTrial < nTrials
                        out.trialStarts_sched(iTrial+1:end) =  out.trialStarts_sched(iTrial+1:end) ...
                            + config.training.timeoutPunish;
                    end;
                    pause(config.training.timeoutPunish * 0.2);
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
            out.trialEnds_obs(iTrial) = toc(out.expStartTime);
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
            % wait so they can collect the reward
            pause(config.training.rewCollTime);
            if iTrial < nTrials;
                out.trialStarts_sched(iTrial+1:end) = ...
                    out.trialStarts_sched(iTrial+1:end) ...
                    + (config.training.rewDur + config.training.rewDelay);
            end;
        elseif resp == 1 && ~isTargetStim;
            % false alarm
%             fprintf('false alarm (lick sensor: min/mean/max: %.2f/%.2f/%.2f).\n', ...
%                 recordedValues);
            fprintf('false alarm (response time: %.4f, limit response time: %.4f, diff: %.5f).\n', ...
                respTime, limitRespTime, limitRespTime - respTime);
            out.respTypes(iTrial) = 3;
            if iTrial < nTrials;
                out.trialStarts_sched(iTrial+1:end) = ...
                    out.trialStarts_sched(iTrial+1:end) + config.training.timeoutPunish;
            end
        elseif resp == 0 && isTargetStim;
            fprintf('miss.\n');
            out.respTypes(iTrial) = 4;
            if iTrial < nTrials
                out.trialStarts_sched(iTrial+1:end) = ...
                    out.trialStarts_sched(iTrial+1:end) + config.training.timeoutPunish;
            end
         elseif resp == 0 && ~isTargetStim;
            fprintf('correct rejection.\n');
            out.respTypes(iTrial) = 2;
            
            % go to next trial
            
            % give reward and wait so they can collect it
%             giveReward(s2,config.training.rewDur,config.training.rewDelay);
%             pause(config.training.rewCollTime);
%             if iTrial < nTrials
%                 out.trialStarts_sched(iTrial+1:end) = out.trialStarts_sched(iTrial+1:end) + ...
%                     config.training.rewDur + config.training.rewDelay;
%             end

        end
        out.trialEnds_obs(iTrial) = toc(out.expStartTime);
        
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
