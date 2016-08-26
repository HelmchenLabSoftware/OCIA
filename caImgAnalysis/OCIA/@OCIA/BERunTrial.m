function BERunTrial(this)
% BERunTrial - [no description]
%
%       BERunTrial(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% /!\ NOTE: all times are in seconds (with decimals though) since trial start or trial init

% init some variables
trainConf = this.be.config.training;
toneConf = this.be.config.tone;
params = this.be.params;
BETimes = this.be.times;
iTrial = this.be.iTrial;
tPhase = this.be.trialPhase;
nTrials = this.be.config.training.nTrials;

% check if experiment is paused/stopped
if ~this.be.isRunning;
    return;
end;


%% PHASE SWITCH
% what we have to do depends on which phase of the trial we are
switch tPhase;
    
    %% initialize trial
    % this is not the start of the trial yet
    case 'init';
        
        % clear previous data
        BEClearData(this);
        
        % get init time
        BETimes.init(iTrial) = roundn(nowUNIXSec(), -3);
        o('Times:init: %.3f', BETimes.init(iTrial), 2, this.verb);                

        o('==================================================================', 1, this.verb);
        showMessage(this, sprintf('%s | Trial %03d/%03d - start ... ', datestr(now(), this.be.logDateFormat), ...
            iTrial, trainConf.nTrials), 'yellow');
        o('%s | start ...', datestr(now(), this.be.logDateFormat), 2, this.verb);   

        % move to next phase
        this.be.trialPhase = 'moveSpot';
        
    %% move spots
    case 'moveSpot';
        
        o('%s | moveSpot ...', datestr(now(), this.be.logDateFormat), 2, this.verb);   
        % if spot matrix is not empty, move spots
        if isfield(this.be, 'spotMatrix') && ~isempty(this.be.spotMatrix);
            
            % get the current spot for this trial
            currentSpot = this.be.spotMatrix(iTrial);
            
            % record time
            BETimes.ETLTrigStart(iTrial) = getTSinceInit();
            o('Times:ETLTrigStart: %.3f', BETimes.ETLTrigStart(iTrial), 3, this.verb);
                
            % select right spot and move there
            BEETLTableAction(this, [], [], 'select', currentSpot);
            BEETLTableAction(this, [], [], 'go');  
            
            % record time
            BETimes.ETLTrigEnd(iTrial) = getTSinceInit();
            o('Times:ETLTrigEnd: %.3f', BETimes.ETLTrigEnd(iTrial), 3, this.verb);
            
        end;
        
        % move to next phase
        this.be.trialPhase = 'vidRec';
        
    %% start video recording
    case 'vidRec';

        o('%s | vidRec ...', datestr(now(), this.be.logDateFormat), 2, this.verb);  
        % if video recording is enabled
        if isfield(this.GUI.handles.be, 'vidRecEnableOn') && get(this.GUI.handles.be.vidRecEnableOn, 'Value') ...
                && (~isempty(regexp(this.be.phase, '^(LWP|QW)', 'once')) && iTrial == 1);
            
            % triggering not done yet
            if isnan(BETimes.vidStartTCPTrig(iTrial));
            
                showMessage(this, sprintf('%s | Trial %03d/%03d - video start trigger ... ', ...
                    datestr(now(), this.be.logDateFormat), iTrial, trainConf.nTrials), 'yellow');

                % record trigger time
                BETimes.vidStartTCPTrig(iTrial) = getTSinceInit();
                o('Times:vidStartTCPTrig: %.3f', BETimes.vidStartTCPTrig(iTrial), 3, this.verb);

                % send trigger and message for the behavior movie recording on the remote computer using a timer
                dateString = datestr(now, 'yyyy_mm_dd');
                trialName = sprintf('%s_%s_trial%02d.avi', regexprep(dateString, '_', ''), ...
                    datestr(now, 'HHMMSS'), iTrial);
                set(this.GUI.be.vidTrigTimer, 'UserData', trialName);
                start(this.GUI.be.vidTrigTimer);
            
            % triggering done and wait time finished
            elseif getTSinceInit() > BETimes.vidStartTCPTrig(iTrial) + params.vidRecDelay(1);

                % move to next phase
                this.be.trialPhase = 'loadSound';
            
            % trigger sent but wait time not yet finished
            else
                
                o('#%s(): waiting for video start trigger ...', mfilename(), 3, this.verb);
                
            end;
            
        % no video triggering
        else
            
            % move to next phase
            this.be.trialPhase = 'loadSound';

        end;
        
    %% load sound
    case 'loadSound';

        o('%s | loadSound ...', datestr(now(), this.be.logDateFormat), 2, this.verb);  
        showMessage(this, sprintf('%s | Trial %03d/%03d - loading sound ... ', datestr(now(), this.be.logDateFormat), ...
            iTrial, trainConf.nTrials), 'yellow');
        
        % load sound into the TDT if required
        if this.be.useTDT;
            
            TDTLoadTic = tic;
            BETimes.soundLoadStart(iTrial) = getTSinceInit();
            % attenuation = randi(4, 1) - 1; % randomized 0 - 3 dB SPL attenuation
            attenuation = 0;
            this.be.TDTRP = playTDTSound(this.be.toneArray{iTrial}, attenuation, this.GUI.figH, 1);
            BETimes.soundLoadEnd(iTrial) = getTSinceInit();
            o('#%s(): TDT loaded, attenuation: %d dB SPL (%.3f)', mfilename(), attenuation, toc(TDTLoadTic), ...
                2, this.verb);
%             showMessage(this, sprintf('%s | Trial %03d/%03d - TDT loaded ... ', ...
%                 datestr(now(), this.be.logDateFormat), iTrial, trainConf.nTrials), 'yellow');
            
        % initialize a standard audio player
        else
            
            BETimes.soundLoadStart(iTrial) = getTSinceInit();
            this.be.audioplayer = audioplayer(this.be.toneArray{iTrial}, toneConf.samplingFreq);
            BETimes.soundLoadEnd(iTrial) = getTSinceInit();
            o('#%s(): normal audioplayer loaded', mfilename(), 2, this.verb);
            
        end;
        
        % move to next phase
        this.be.trialPhase = 'start';

    %% start the trial (random start delay)
    case 'start';        
        
        % random start delay waiting not started yet
        if isnan(BETimes.startDelay(iTrial));
            
            % calculate a random delay for starting the sounds
            randomStartDelay = trainConf.startDelay + (rand - 0.5) * 2 * trainConf.startDelayRand;
            BETimes.startDelay(iTrial) = randomStartDelay;
            o('Times:startDelay: %.3f', BETimes.startDelay(iTrial), 3, this.verb);
            showMessage(this, sprintf('%s | Trial %03d/%03d - start delay: %.3f sec. ', ...
                datestr(now(), this.be.logDateFormat), iTrial, trainConf.nTrials, BETimes.startDelay(iTrial)), ...
                'yellow');              
                
            % mark trial as started
            BETimes.start(iTrial) = BETimes.init(iTrial) + size(this.be.anInData.piezo, 1) / this.be.hw.anInSampRate;
            o('Times:start: %.3f', BETimes.start(iTrial), 2, this.verb);   

            % start the imaging before the random start delay
            BEImagingTTL(this, 1);
            BETimes.imgStart(iTrial) = getTSinceStart();
            o('Times:imgStart: %.3f', BETimes.imgStart(iTrial), 2, this.verb);
            
        % random start delay not finished and one second since imaging start
        elseif getTSinceStart() <= BETimes.startDelay(iTrial) && isnan(BETimes.trialStartCue(iTrial)) ...
                && getTSinceStart() > BETimes.imgStart(iTrial) + 1;
        
            BETimes.trialStartCue(iTrial) = getTSinceStart();
            % trial start cue
            o('#%s(): trial start cue at %.3f ...', mfilename(), getTSinceStart(), 2, this.verb);
            pulseParams = num2cell(trainConf.trialStartLightCueParams);
            BELightPulse(this, pulseParams{:});
            
        % random start delay waiting finished
        elseif getTSinceStart() > BETimes.startDelay(iTrial);
            
            % move to next phase
            this.be.trialPhase = 'playSound';

        % trigger sent but wait time not yet finished
        else
            
            o('#%s(): waiting for start delay ...', mfilename(), 3, this.verb);
            
        end;

    %% play sound
    case 'playSound';
    
        % play sound using TDT
        if this.be.useTDT;
            
            this.be.TDTRP.SoftTrg(1);
            BETimes.sound(iTrial) = getTSinceStart();
            o('Times:sound: %.3f', BETimes.sound(iTrial), 2, this.verb);
        
        % play sound without TDT
        else
            
            % play sound using standard audio player
            this.be.audioplayer.play();
            BETimes.sound(iTrial) = getTSinceStart();
            o('Times:sound: %.3f', BETimes.sound(iTrial), 2, this.verb);
            
        end;
        
        % move to next phase
        this.be.trialPhase = 'initWaitResp';
        
    %% initialize waiting response period
    case 'initWaitResp';
    
        % waiting starts now
        BETimes.respWaitStart(iTrial) = getTSinceStart();
        
        % random delay for the minimum response time (response window start)
        randomRespMinDelay = (rand - 0.5) * 2 * trainConf.minRespRand;
        o('randomRespMinDelay: %.3f', randomRespMinDelay, 3, this.verb);
        showMessage(this, sprintf('%s | Trial %03d/%03d - resp. window delay: %.3f sec (%.3f + %.3f).', ...
            datestr(now(), this.be.logDateFormat), iTrial, trainConf.nTrials, trainConf.minRespTime ...
            + randomRespMinDelay, trainConf.minRespTime, randomRespMinDelay), 'yellow');  
        
        % init the minimum (start) and maximum (end) times for the response window
        BETimes.respMin(iTrial) = BETimes.respWaitStart(iTrial) + trainConf.minRespTime + randomRespMinDelay;
        BETimes.respMax(iTrial) = BETimes.respWaitStart(iTrial) + trainConf.maxRespTime + randomRespMinDelay;
        
        % initialize the time for the light cue to start and stop
        BETimes.lightIn(iTrial) = BETimes.respWaitStart(iTrial) + trainConf.lightInTime + randomRespMinDelay;
        BETimes.lightOut(iTrial) = BETimes.lightIn(iTrial) + trainConf.lightDur;
        
        % print out all this stuff
        o('Times:respWaitStart: %.3f', BETimes.respWaitStart(iTrial), 2, this.verb);
        o('Times:respMin: %.3f', BETimes.respMin(iTrial), 2, this.verb);
        o('Times:lightIn: %.3f', BETimes.lightIn(iTrial), 3, this.verb);
        o('Times:lightOut: %.3f', BETimes.lightIn(iTrial), 3, this.verb);
        o('Times:respMax: %.3f', BETimes.respMax(iTrial), 3, this.verb);

        % display message appropriate message depending on whether the animal has actually to respond or not:
        %   presence of a GO stimulus means a response is expected
        if ~isempty(toneConf.goStim);
            
            showMessage(this, sprintf('%s | Trial %03d/%03d - waiting for response ... ', ...
                datestr(now(), this.be.logDateFormat), iTrial, trainConf.nTrials), 'yellow');
            
            % do not set a time to wait for the sound to finish
            BETimes.soundDur(iTrial) = 0;
            
        % no go stim means response is not expected
        else
            
            % calculate sound duration in seconds using number of samples and sampling frequency of the TDT
            soundDur = numel(this.be.toneArray{iTrial}) / toneConf.samplingFreq;
            
            showMessage(this, sprintf('%s | Trial %03d/%03d - playing sound (%.2f sec duration) ... ', ...
                datestr(now(), this.be.logDateFormat), iTrial, trainConf.nTrials, soundDur), 'yellow');
            
            % set a time to wait for the sound to finish
            BETimes.soundDur(iTrial) = soundDur;
            
        end;
        
        o('Times:soundDur: %.3f', BETimes.soundDur(iTrial), 3, this.verb);
        o('Times:sound+soundDur: %.3f', BETimes.sound(iTrial) + BETimes.soundDur(iTrial), 3, this.verb);
        
        % move to next phase
        this.be.trialPhase = 'waitResp';

        
    %% wait for response
    case 'waitResp';
        
        % if this is the first time we are waiting for response
        if isnan(BETimes.respWaitRealStart(iTrial));
        
            % real waiting starts now
            BETimes.respWaitRealStart(iTrial) = getTSinceStart();

            % init some variables for this trial
            this.be.lightCueGiven(iTrial) = 0;
            this.be.autoRewardGiven(iTrial) = 0;
            this.be.autoRewardModes{iTrial} = params.autoRewardMode;
            
            % check if auto-reward should be given because of misses
            if isfield(trainConf, 'NMissToGiveAutoRewardAfter') && ~isinf(trainConf.NMissToGiveAutoRewardAfter);
                lastHit = find(this.be.respTypes == 1, 1, 'last');
                if isempty(lastHit);
                    lastHit = 1;
                end;
                nMisses = numel(this.be.respTypes((lastHit + 1) : (iTrial - 1)) == 4);
                if nMisses >= trainConf.NMissToGiveAutoRewardAfter;
                    showMessage(this, sprintf(...
                        '%s | Trial %03d/%03d - auto-reward because of %d miss ...', ...
                        datestr(now(), this.be.logDateFormat), iTrial, trainConf.nTrials, nMisses), 'yellow');
                    this.be.autoRewardModes{iTrial} = 'EarlyOn';
                end;
            end;
            
            % determine whether earlies are allowed or not
            if trainConf.allowEarlyLicks >= 1;
                this.be.earlyAllowed(iTrial) = 1;
                showMessage(this, sprintf('%s | Trial %03d/%03d - earlies allowed by config.', ...
                    datestr(now(), this.be.logDateFormat), iTrial, trainConf.nTrials), 'yellow');

            elseif trainConf.allowEarlyLicks <= 0;
                this.be.earlyAllowed(iTrial) = 0;
                showMessage(this, sprintf('%s | Trial %03d/%03d - earlies *not* allowed by config.', ...
                    datestr(now(), this.be.logDateFormat), iTrial, trainConf.nTrials), 'yellow');

            % probabilistic
            else
                randNum = rand();
                this.be.earlyAllowed(iTrial) = randNum <= trainConf.allowEarlyLicks;
                showMessage(this, sprintf( ...
                    '%s | Trial %03d/%03d - earlies given by probability of %.2f: rand = %.2f => %sallowed.', ...
                    datestr(now(), this.be.logDateFormat), iTrial, trainConf.nTrials, ...
                    trainConf.allowEarlyLicks, randNum, iff(this.be.earlyAllowed(iTrial), '', '*not* ')), 'yellow');
            end;
            
        end;
        
        % if we are still within the waiting window
        if getTSinceStart() < (BETimes.respMax(iTrial) + BETimes.soundDur(iTrial));

            o('#%s: response waiting loop ... %.3f', mfilename(), getTSinceStart(), 4, this.verb);

            %%  - wait for response: light on
            % only give reward cue if there is a reward, if light cue has not yet been given and "lightIn" is passed
            if params.rewDur > 0 && isnan(BETimes.lightCueOn(iTrial)) && getTSinceStart() > BETimes.lightIn(iTrial);

                % if light is not yet on, turn it on
                if isnan(BETimes.lightCueOn(iTrial));
                    
                    BETimes.lightCueOn(iTrial) = getTSinceStart();
                    this.be.lightCueGiven(iTrial) = 1;
                    o('#%s(): light cue on (%.3f) ...', mfilename(), BETimes.lightCueOn(iTrial), 3, this.verb);
                    pulseParams = num2cell(trainConf.rewardPeriodLightCueParams);
                    BELightPulse(this, pulseParams{:});

                % light cue on but light must still be on
                else
                    
                    o('#%s(): lightCueOn: %d, tDiff: %.3f, timeSinceStart: %.3f ...', mfilename(), lightCueOn, ...
                        (BETimes.lightCueOn(iTrial) + lightOnDur) - getTSinceStart(), ...
                        getTSinceStart(), 2, this.verb);  
                    
                end;
                
            end;

            %%  - wait for response: light off
            % turn light off if needed
            if ~isnan(BETimes.lightCueOn(iTrial)) && isnan(BETimes.lightCueOff(iTrial)) && getTSinceStart() > BETimes.lightOut(iTrial);

                BELight(this, 0);
                BETimes.lightCueOff(iTrial) = getTSinceStart();
                o('#%s(): light cue off (%.3f) ...', mfilename(), BETimes.lightCueOff(iTrial), 3, this.verb);
                
            end;

            %%  - wait for response: 'EarlyOn' reward
            % in 'EarlyOn' mode, reward happens at some fraction of time of the response window
            respWindowDur = BETimes.respMax(iTrial) - BETimes.respMin(iTrial);
            EORespTime = BETimes.respMin(iTrial) + params.autoRewardEarlyOnTimeFraction * respWindowDur;
            isEarlyOn = strcmp(this.be.autoRewardModes{iTrial}, 'EarlyOn') && (isempty(toneConf.goStim) ...
                || ismember(this.be.stims(iTrial), toneConf.goStim));
            
            % if 'EarlyOn' mode is on and reward has not yet been given and 'EarlyOn' time is passed and trial is target
            if params.rewDur > 0 && isEarlyOn && ~this.be.autoRewardGiven(iTrial) && getTSinceStart() > EORespTime;
                
                this.be.autoRewardGiven(iTrial) = 1; 
                
                BETimes.rewTime(iTrial) = getTSinceStart();
                o('Times:rewTime: %.3f', BETimes.rewTime(iTrial), 3, this.verb);
                
                BEGiveReward(this);
                this.be.giveRewards(iTrial) = 1;
                showMessage(this, sprintf('%s | Trial %03d/%03d - ''EarlyOn'' reward !', ...
                    datestr(now(), this.be.logDateFormat), iTrial, trainConf.nTrials), 'yellow');
                
                % calc reward collection time
                BETimes.rewCollStart(iTrial) = BETimes.rewTime(iTrial);
                o('Times:rewCollStart: %.3f', BETimes.rewCollStart(iTrial), 3, this.verb);
                BETimes.rewCollEnd(iTrial) = BETimes.rewTime(iTrial) + trainConf.rewCollTime;
                o('Times:rewCollEnd: %.3f', BETimes.rewCollEnd(iTrial), 3, this.verb);
                
            end;
            
            %%  - wait for response: sound detection
            % only search for sound if not already found and if required
            if isnan(BETimes.realSound(iTrial)) && this.be.params.adjustForDelayWithSound;
                
                % get microphone data
                micr = linScale(abs(this.be.anInData.micr))';
                % get the number of samples
                nSamples = size(micr, 2);
                % get a range for the begining of the signal
                begRange = round(nSamples * 0.01 : nSamples * 0.1);
                % get thresholds factor
                soundThreshFactor = 30;
                % get a threshold for the sound onset
                soundYThresh = soundThreshFactor * std(micr(begRange));
                % get the samples that exceeds the threshold, adding the first sample to catch the
                %   start of the first sound
                upSamples = [0 find(micr > soundYThresh)];
                % get the derivative of the upSamples, drops in the sample indexes indicate interruption of upSamples,
                %   which means that there is a sound start
                upSamplesDiff = diff(upSamples);
                % use the ISI to find peaks. If no ISI, use 0.5 second
                ISI = 0.5;
                % difference between detected upSample derivative's peaks must be at least half of the ISI
                minISI = ISI * 0.5 * this.be.hw.anInSampRate;
                % get the index of the peaks where the derivative exceeds the ISI threshold and increment
                %   by one to get the sound start index
                soundStartIndex = upSamples(find(upSamplesDiff >= minISI) + 1);
                %{
                % debug plot
                plot((1 : nSamples) / this.be.hw.anInSampRate, micr, 'Color', 'green');
                xLims = get(gca, 'XLim');
                hold on;
                plot(xLims, repmat(soundYThresh, 1, 2), 'Color', 'red', 'LineStyle', ':');
                title(sprintf('soundYThresh: %.6f, soundStartIndex: %d\nsoundStartTime: %.2f', soundYThresh, ...
                    soundStartIndex, soundStartIndex / this.be.hw.anInSampRate));
                hold off;
                %}
                % if some start index found
                if ~isempty(soundStartIndex);
                    % only keep the first sound start
                    if numel(soundStartIndex > 1); soundStartIndex = soundStartIndex(1); end;
                    % get the sound start time
                    BETimes.realSound(iTrial) = (soundStartIndex / this.be.hw.anInSampRate) ...
                        - getTSinceInit() + getTSinceStart();
                    o('Times:realSound: %.3f sec ', BETimes.realSound(iTrial), 3, this.verb);
                    
                    % calculate delay with actual sound
                    manualOffset = 0.15;
                    BETimes.soundDelay(iTrial) = BETimes.realSound(iTrial) - BETimes.sound(iTrial) - manualOffset;
                    o('Times:soundDelay: %.3f sec ', BETimes.soundDelay(iTrial), 3, this.verb);
            
                    showMessage(this, sprintf('%s | Trial %03d/%03d - soundDelay: %.3f sec. ', ...
                        datestr(now(), this.be.logDateFormat), iTrial, trainConf.nTrials, ...
                        BETimes.soundDelay(iTrial)), 'yellow');
                    
                    % remove delay data
                    BEClearData(this, round(BETimes.soundDelay(iTrial) * this.be.hw.anInSampRate));
                end;
                
            end;
            
            %%  - wait for response: response detection
            % no response by default
            this.be.resps(iTrial) = 0;
            
            if ~isempty(toneConf.goStim);
                % get the number of samples that we have
                if isfield(this.be.anInData, 'piezo')
                    nSamples = size(this.be.procAnInData.piezo, 1);
                else
                    nSamples = 0;
                end;

                % calculate the number of samples between init and start
                nSamplesOffset = round((BETimes.start(iTrial) - BETimes.init(iTrial)) * this.be.hw.anInSampRate);
                % get the indexes of the samples that are within the response window
                startEarlyRespIndex = round((BETimes.respWaitStart(iTrial)) * this.be.hw.anInSampRate) + nSamplesOffset;
                startRespIndex = round(BETimes.respMin(iTrial) * this.be.hw.anInSampRate) + nSamplesOffset;
                endRespIndex = min(round(BETimes.respMax(iTrial) * this.be.hw.anInSampRate) + nSamplesOffset, nSamples);
                
                % only check for responses if we have enought samples
                if startEarlyRespIndex <= nSamples;

                    % earlies not allowed and detection *before* response time
                    if ~this.be.earlyAllowed(iTrial) && getTSinceStart() < BETimes.respMin(iTrial);

                        % get the piezo lick sensor data
                        piezoData = this.be.procAnInData.piezo;
                        % response is true if any value is above the threshold
                        this.be.resps(iTrial) = sum(piezoData(startEarlyRespIndex : end) > params.piezoThresh) >= 1;
                        % if lick detected, mark it as early
                        if this.be.resps(iTrial);
                            this.be.respTypes(iTrial) = 5;
                        end;
                        
                    % earlies allowed or not and detection is *after* response time
                    elseif getTSinceStart() >= BETimes.respMin(iTrial);

                        % get the piezo lick sensor data
                        piezoData = this.be.procAnInData.piezo;
                        % response is true if any value is above the threshold
                        this.be.resps(iTrial) = sum(piezoData(startRespIndex : endRespIndex) > params.piezoThresh) >= 1;
                        
                    % no response detected yet
                    else

                        this.be.resps(iTrial) = 0;

                    end;
                    
%                     % plot things for debug purposes
%                     if any(piezoData > params.piezoThresh);
%                         this.be.isRunning = 0;
%                         stop(this.GUI.be.updateTimer);
%                         figure();
%                         t = (1 : nSamples) / this.be.hw.anInSampRate;
%                         plot(t, linScale(piezoData));
%                         hold on;
%                         line([startEarlyRespIndex, startEarlyRespIndex] / this.be.hw.anInSampRate, [0 1], 'Color', 'r');
%                         line([startRespIndex, startRespIndex] / this.be.hw.anInSampRate, [0 1], 'Color', 'g');
%                         line([endRespIndex, endRespIndex] / this.be.hw.anInSampRate, [0 1], 'Color', 'm');
%                         o('plot done', 0, 0);
%                     end;

                % if not enought sample yet, no response can be detected
                else

                    this.be.resps(iTrial) = 0;

                end;
            
                % if there was a response within the response window
                if this.be.resps(iTrial);

                    % mark down response time and delay compared to response window start
                    BETimes.respTime(iTrial) = getTSinceStart(); % artifical delay correction
                    o('Times:resp: %.3f', BETimes.respTime(iTrial), 3, this.verb);  
                    this.be.respDelays(iTrial) = BETimes.respTime(iTrial) - BETimes.respMin(iTrial);
                    o('Times:respDelays: %.3f', this.be.respDelays(iTrial), 3, this.verb);

                    if this.be.respTypes(iTrial) == 5;
                        lickType = 'EARLY';
                        
                    % if not 'EarlyOn' mode or the auto-reward has not been given yet, it is a "true" lick
                    elseif ~isEarlyOn || ~this.be.autoRewardGiven(iTrial);
                        lickType = 'LICK';

                    % if in 'EarlyOn' mode and the auto-reward has been given, it is a "induced" (post-reward) lick
                    else
                        lickType = 'INDUCED LICK';

                    end;

                    % show the message with the lick type and the delay
                    showMessage(this, sprintf('%s | Trial %03d/%03d - %s! (%.3f sec)', datestr(now(), ...
                        this.be.logDateFormat), iTrial, nTrials, lickType, this.be.respDelays(iTrial)), 'yellow');  

                    % move to next phase
                    this.be.trialPhase = 'processDecision';

                end;
            end;

        % if we are not anymore in the waiting window
        else
            
            o('#%s(): end of response wait ... (%.3f)', mfilename(), getTSinceStart(), 3, this.verb);
            
            % move to next phase
            this.be.trialPhase = 'processDecision';
            
        end;

        
    %% process the decision
    case 'processDecision';

        % if it was turned on and not yet off, make sure light is off
        if ~isnan(BETimes.lightCueOn(iTrial)) && isnan(BETimes.lightCueOff(iTrial)) ...
                && getTSinceStart() > BETimes.lightOut(iTrial);
            BELight(this, 0);
            BETimes.lightCueOff(iTrial) = getTSinceStart();
            o('#%s(): light cue off (late) (%.3f) ...', mfilename(), BETimes.lightCueOff(iTrial), 2, this.verb);
        end;
        
        % if no response set yet, then set it to 0 (no response)
        if isnan(this.be.resps(iTrial)); this.be.resps(iTrial) = 0; end;

        % if goStim is empty, it means no behavior decision had to be made (no response)
        if ~isempty(toneConf.goStim);
            
            % get whether this is the target stimulus
            isTargetStim = ismember(this.be.stims(iTrial), toneConf.goStim);

            % only create a response type if it is not already set to "early"
            if this.be.respTypes(iTrial) == 5;
                
                % set outcome variables
                this.be.punishTimeOuts(iTrial) = 1;
                this.be.giveRewards(iTrial) = 0;

            % response and it was a target: hit (correct response) (respType = 1)
            elseif this.be.resps(iTrial) && isTargetStim;
                showMessage(this, sprintf('%s | Trial %03d/%03d - HIT! (%.3f sec)', datestr(now(), ...
                    this.be.logDateFormat), iTrial, nTrials, this.be.respDelays(iTrial)), 'green');
                
                % set outcome variables
                this.be.respTypes(iTrial) = 1;
                this.be.punishTimeOuts(iTrial) = 0;
                this.be.giveRewards(iTrial) = 1;

            % NO response and it was NOT a target: correct rejection (respType = 2)
             elseif ~this.be.resps(iTrial) && ~isTargetStim;
                showMessage(this, sprintf('%s | Trial %03d/%03d - CORRECT REJECT!', ...
                    datestr(now(), this.be.logDateFormat), iTrial, nTrials), 'green');
                
                % set outcome variables
                this.be.respTypes(iTrial) = 2;
                this.be.punishTimeOuts(iTrial) = 0;
                this.be.giveRewards(iTrial) = 0;
                
            % response and it was NOT a target: false alarm (respType = 3)
            elseif this.be.resps(iTrial) && ~isTargetStim;
                showMessage(this, sprintf('%s | Trial %03d/%03d - FALSE ALARM! (%.3f sec)', ...
                    datestr(now(), this.be.logDateFormat), iTrial, nTrials, ...
                    this.be.respDelays(iTrial)), 'red');
                
                % set outcome variables
                this.be.respTypes(iTrial) = 3;
                this.be.punishTimeOuts(iTrial) = 1;
                this.be.giveRewards(iTrial) = 0;
                
            % NO response and it was a target: miss (respType = 4)
            elseif ~this.be.resps(iTrial) && isTargetStim;
                showMessage(this, sprintf('%s | Trial %03d/%03d - MISS!', ...
                    datestr(now(), this.be.logDateFormat), iTrial, nTrials), 'red');
                
                % set outcome variables
                this.be.respTypes(iTrial) = 4;
                this.be.punishTimeOuts(iTrial) = 0;
                this.be.giveRewards(iTrial) = 0;
                
            end;

            % process the auto-reward modes for reward outcomes
            switch this.be.autoRewardModes{iTrial};
                % give reward only if target stim (or no targets) AND not early lick
                case 'EarlyOn';         this.be.giveRewards(iTrial) ...
                    = (isempty(toneConf.goStim) || ismember(this.be.stims(iTrial), toneConf.goStim)) ...
                    && this.be.respTypes(iTrial) ~= 5;
                
                % give reward only if target stim (or no targets)
                case 'On';              this.be.giveRewards(iTrial) ...
                    = (isempty(toneConf.goStim) || ismember(this.be.stims(iTrial), toneConf.goStim)) ...
                    && this.be.respTypes(iTrial) ~= 5;
                
                % never give reward
                case 'Off';             this.be.giveRewards(iTrial) = 0;
                    
                % do nothing, rewarding depends on mouse's response
                case 'Auto';
                otherwise;
                    showWarning(this, 'OCIA:RunTrial:UnknownAutoRewardMode', ...
                        sprintf('Unknown auto-reward mode: %s. Using default "auto" (reward: %d).', ...
                        this.be.autoRewardModes{iTrial}, this.be.giveReards(iTrial)));
            end;
            
            % move to next phase
            this.be.trialPhase = 'reward';
           
        % no behavior decision (no response), skip to final wait time
        else
            
            % move to next phase
            this.be.trialPhase = 'finalWait';
            
        end;
        
    %% reward
    case 'reward';

        if ~this.be.giveRewards(iTrial);
            
            % move to next phase
            this.be.trialPhase = 'finalWait';
        
        % if reward was not already given for this phase
        elseif isnan(BETimes.rewCollStart(iTrial)) && this.be.giveRewards(iTrial);
            
            % only give reward if deserved and if not already given by auto-reward
            if this.be.giveRewards(iTrial) && ~this.be.autoRewardGiven(iTrial) && isnan(BETimes.rewTime(iTrial));
                BETimes.rewTime(iTrial) = getTSinceStart();
                o('Times:rewTime: %.3f', BETimes.rewTime(iTrial), 3, this.verb);
                showMessage(this, sprintf('%s | Trial %03d/%03d - reward !', ...
                    datestr(now(), this.be.logDateFormat), iTrial, trainConf.nTrials), 'yellow');  
                BEGiveReward(this);
            end;
                
            % give time to collect it
            BETimes.rewCollStart(iTrial) = BETimes.rewTime(iTrial);
            o('Times:rewCollStart: %.3f', BETimes.rewCollStart(iTrial), 3, this.verb);
            BETimes.rewCollEnd(iTrial) = BETimes.rewTime(iTrial) + trainConf.rewCollTime;
            o('Times:rewCollEnd: %.3f', BETimes.rewCollEnd(iTrial), 3, this.verb);
                
            % prolongate light until the end of the collection period if needed
            BETimes.lightOut(iTrial) = max(BETimes.rewCollEnd(iTrial), BETimes.lightOut(iTrial));
            o('Times:lightOut: %.3f (prolongated (2))', BETimes.lightOut(iTrial), 3, this.verb);
            
           
        % if reward was already given for this phase and reward collection is done but spout is still in
        elseif ~isnan(BETimes.rewCollStart(iTrial)) && this.be.giveRewards(iTrial) ...
                && getTSinceStart() > BETimes.rewCollEnd(iTrial) && isnan(BETimes.spoutOut(iTrial));
            
            % calculate spout out time
            BETimes.spoutOut(iTrial) = getTSinceStart() + params.spoutDelay(2);
            
        % if reward was already given for this phase and reward collection is done and spout should be out
        elseif ~isnan(BETimes.rewCollStart(iTrial)) && this.be.giveRewards(iTrial) ...
                && getTSinceStart() > BETimes.rewCollEnd(iTrial) && ~isnan(BETimes.spoutOut(iTrial)) ;
                
            % remove spout
%             BESpoutPos(this, 0);

            % move to next phase
            this.be.trialPhase = 'finalWait';
            
        % spout time not yet defined means it is still reward collection
        elseif isnan(BETimes.spoutOut(iTrial));

            o('#%s(): waiting for reward collection ...', mfilename(), 3, this.verb); 
            
        % spout time defined means it is still spout delay wait
        else
            
            o('#%s(): waiting for spout delay ...', 3, this.verb);
            
        end;
        
        
        % if it was turned on and not yet off, make sure light is off
        if ~isnan(BETimes.lightCueOn(iTrial)) && isnan(BETimes.lightCueOff(iTrial)) ...
                && getTSinceStart() > BETimes.lightOut(iTrial);
            BELight(this, 0);
            BETimes.lightCueOff(iTrial) = getTSinceStart();
            o('#%s(): light cue off (late (2)) (%.3f) ...', mfilename(), BETimes.lightCueOff(iTrial), 2, this.verb);
        end;
        
    %% final end wait (punishment & others)
    case 'finalWait';

        
        % no punishmend time yet
        if isnan(BETimes.endPunish(iTrial));
            
            % if no punish setting is not set yet, set it to 0 (no punish)
            if isnan(this.be.punishTimeOuts(iTrial)); this.be.punishTimeOuts(iTrial) = 0; end;
            
            % calculate the punishment delay
            punishDelay = iff(this.be.punishTimeOuts(iTrial), trainConf.timeoutPunish, 0);
            
            % play punishment sound
            if punishDelay > 0;
                o('Playing punishment sound ...', 3, this.verb);
                nLoops = round(min(trainConf.endDelay + punishDelay, 3) / 0.5);
                this.be.TDTRP.Halt();
                this.be.TDTRP = playTDTSound(this.be.punishSound, 0, this.GUI.figH, nLoops);
                this.be.TDTRP.SoftTrg(1);
            end;

            % calculate the end of punishment time
            BETimes.endPunish(iTrial) = getTSinceStart() + trainConf.endDelay + punishDelay;
            o('Times:endPunish: %.3f', BETimes.endPunish(iTrial), 3, this.verb);

            % calculate the expected end of the imaging
            BETimes.imgStopExp(iTrial) = BETimes.endPunish(iTrial) - punishDelay - params.imgEndStopTime;
            o('Times:imgStopExp: %.3f', BETimes.imgStopExp(iTrial), 3, this.verb);
        
        end;
        
        % set a minimum trial duration
        minTrialDuration = 13;
        if (getTSinceStart() - BETimes.imgStopExp(iTrial)) < minTrialDuration;
            BETimes.imgStopExp(iTrial) = minTrialDuration;
        end;

        % if imaging still runing and time to stop it has passed
        if getTSinceStart() > BETimes.imgStopExp(iTrial);
            
            % stop imaging
            if isnan(BETimes.imgStopObs(iTrial));
                
                % stop imaging
                BEImagingTTL(this, 0);
                BETimes.imgStopObs(iTrial) = getTSinceStart();
                o('Times:imgStopObs: %.3f', BETimes.imgStopObs(iTrial), 3, this.verb);
                
            end;
            
            % if time to finish trial has passed
            if getTSinceStart() > BETimes.endPunish(iTrial);
                
                showMessage(this, sprintf('%s | Trial %03d/%03d - done. ', datestr(now(), this.be.logDateFormat), ...
                    iTrial, trainConf.nTrials), 'green');
            
                % move out from the trial running
                this.be.trialPhase = 'stopVidRec';
            
            % trial still runing but stop time is not yet arrived
            else

                o('#%s(): waiting for trial stop ...', mfilename(), 4, this.verb);

            end;
            
        % imaging is still runing but stop time is not yet arrived
        else
            
            o('#%s(): waiting for imaging stop ...', mfilename(), 4, this.verb);
            
        end;
        
        % if it was turned on and not yet off, make sure light is off
        if ~isnan(BETimes.lightCueOn(iTrial)) && isnan(BETimes.lightCueOff(iTrial)) ...
                && getTSinceStart() > BETimes.lightOut(iTrial);
            BELight(this, 0);
            BETimes.lightCueOff(iTrial) = getTSinceStart();
            o('#%s(): light cue off (late (3)) (%.3f) ...', mfilename(), BETimes.lightCueOff(iTrial), 2, this.verb);
        end;
        
    %% stop video recording
    case 'stopVidRec';

        % if video recording is enabled
        if isfield(this.GUI.handles.be, 'vidRecEnableOn') && get(this.GUI.handles.be.vidRecEnableOn, 'Value') ...
                && (~isempty(regexp(this.be.phase, '^(LWP|QW)', 'once')) && iTrial == trainConf.nTrials);
            
            % triggering not done yet
            if isnan(BETimes.vidEndTCPTrig(iTrial));
            
                showMessage(this, sprintf('%s | Trial %03d/%03d - video stop trigger ... ', ...
                    datestr(now(), this.be.logDateFormat), iTrial, trainConf.nTrials), 'yellow');

                % record trigger time
                BETimes.vidEndTCPTrig(iTrial) = getTSinceStart();
                o('Times:vidEndTCPTrig: %.3f', BETimes.vidEndTCPTrig(iTrial), 3, this.verb);
                
                % send trigger to stop the behavior movie recording using a timer
                set(this.GUI.be.vidTrigTimer, 'UserData', 'stop');
                start(this.GUI.be.vidTrigTimer);
            
            % triggering done and wait time finished
            elseif getTSinceStart() > BETimes.vidEndTCPTrig(iTrial) + params.vidRecDelay(2);

                % move to next phase
                this.be.trialPhase = 'finished';
            
            % trigger sent but wait time not yet finished
            else
                
                o('#%s(): waiting for video stop trigger ...', mfilename(), 3, this.verb);
                
            end;
            
        % no video triggering
        else
            
                % move to next phase
                this.be.trialPhase = 'finished';

        end;

    %% paused
    case 'paused';
    
        % do nothing
        
    %% unknown phase
    otherwise;
        
        showMessage(this, sprintf('%s | Trial %03d/%03d: unknown phase "%s" ... ', datestr(now(), ...
            this.be.logDateFormat), iTrial, trainConf.nTrials, this.be.trialPhase), 'yellow');

end;

% store back the times
this.be.times = BETimes;

function t = getTSinceStart()
    t = roundn(nowUNIXSec() - BETimes.start(iTrial), -3);
end

function t = getTSinceInit()
    t = roundn(nowUNIXSec() - BETimes.init(iTrial), -3);
end

end
