function CaImgExp = runExperiment(CaImgExp, nRuns)
    % runExperiment method for the CaImgExperiment class. Runs the calcium imaging experiment.
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Originally created on           18 / 03 / 2012 %
    % Written by B. Laurenczy (blaurenczy@gmail.com) %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % display check list
    if CaImgExp.checkAbort(['Let''s go:\n' ...
            '  - Check if heating pad is OK ...\n' ...
            '  - Check if laser is OK (shutter, wavelength, etc.) ...\n' ...
            '  - Check if sound (TDT?) is on, with attenutation OK ...\n' ...
            '  - Check if heloscan trigger cable is plugged ...\n' ...
            '  - Check if mouse''s breathing (anesthesia) is OK ...\n']);
        return;
    end;


    %% BF test
    if CaImgExp.checkSkip('BFTest');
        % do the best frequency characterization test
%         attenuations = zeros(1, nRuns);
        attenuations = ones(1, nRuns) * 20;
    %     attenuations = repmat(attenuations, 2); % 10 repetitions
        CaImgExp = CaImgExp.doBFTest(attenuations);
    end;


    %% CaImg runs

%     if CaImgExp.checkSkip('Odd10%');
%         if CaImgExp.checkAbort('WARNING! Do not forget to change stimulus duration and set a BF!!'); return; end;
%         % run the oddball paradigm with 10% deviants
%         CaImgExp = doOddballParadigm(CaImgExp, 10, 4);
%         if CaImgExp.checkAbort('Press [ENTER] to go on to next paradigm.'); return; end;
%     end;
%     
%     if CaImgExp.checkSkip('OddTrial');
%         if CaImgExp.checkAbort('WARNING! Do not forget to change stimulus duration!!'); return; end;
%         % run the oddball trial paradigm with 10% deviants
%         CaImgExp = doOddballTrialParadigm(CaImgExp, 5);
%         if CaImgExp.checkAbort('Press [ENTER] to go on to next paradigm.'); return; end;
%     end;

    if CaImgExp.checkSkip('Omi10%');
        if CaImgExp.checkAbort('WARNING! Do not forget to change stimulus duration!!'); return; end;
        % run the omission paradigm with 10% omissions
        CaImgExp = doOmissionParadigm(CaImgExp, 10, 10);
        if CaImgExp.checkAbort('Press [ENTER] to go on to next paradigm.'); return; end;
    end;

%     % run the oddball paradigm with 50% deviants, this is the equiprobable control
%     [CaImgExp, abort] = doEquiProbControl(CaImgExp);
%     if CaImgExp.checkAbort('Press [ENTER] to go on to next paradigm.'); return; end;
%     
%     % run the oddball paradigm with 30% deviants
%     [CaImgExp, abort] = doOddballParadigm(CaImgExp, 30, 2);
%     if CaImgExp.checkAbort('Press [ENTER] to go on to next paradigm.'); return; end;
% 
%     % run the omission paradigm with 10% of deviant sound, this is the deviant alone control
%     [CaImgExp, abort] = doDevAloneControl(CaImgExp, 10);
%     if CaImgExp.checkAbort('Press [ENTER] to go on to next paradigm.'); return; end;
% 
%     % run the oddball paradigm with 30% deviants
%     [CaImgExp, abort] = doOddballParadigm(CaImgExp, 30, 2);
%     if CaImgExp.checkAbort('Press [ENTER] to go on to next paradigm.'); return; end;

%     % run the omission paradigm with 10% omissions
%     [CaImgExp, abort] = doOmissionParadigm(CaImgExp, 10, 10);
%     if CaImgExp.checkAbort('Press [ENTER] to go on to next paradigm.'); return; end;
% 
%     % run the omission paradigm with 30% omissions
%     [CaImgExp, abort] = doOmissionParadigm(CaImgExp, 30, 4);
%     if CaImgExp.checkAbort('Press [ENTER] to go on to next paradigm.'); return; end;

%     if CaImgExp.checkAbort('Press [ENTER] if you are happy !'); return; end;

end % runExperiment


%% doOddballTrialParadigm
% oddball trial paradigm, F1 or F2 randomly assigned to be standard
% nRunsPerFreq: number of runs to do for each frequency (F1 and F2)
function [CaImgExp, abort] = doOddballTrialParadigm(CaImgExp, nRunsPerFreq)

    % create a random sequences of 'swap' for alternating F1 and F2, each one 'nRunsPerFreq' times
    F1F2Sequence = [ones(nRunsPerFreq, 1); -1 * ones(nRunsPerFreq, 1)];
    % mix the sequence of F1 and F2
    F1F2Sequence = F1F2Sequence(randperm(size(F1F2Sequence, 1)));

    % check if the sequence is okay: nRunsPerFreq runs of each and no more '1' runs than -1
    if size(F1F2Sequence, 1) ~= nRunsPerFreq * 2 || sum(F1F2Sequence) ~= 0;
        warning('CaImgExperiment:doOddballTrialParadigm:BadF1F2MixSeq', ...
            'F1F2 mixing sequence not the right length or not equilibrated!');
        % save a backup of the aborted experiment
        CaImgExp.saveAll(sprintf('backup_n%dOddTrial_%d_abortedF1F2Seq', CaImgExp.nSpots, proba, ...
            size(CaImgExp.spots{CaImgExp.nSpots}.stims, 2)));
        abort = 1;
        return;
    end;

    fprintf('Sequence of stimulation will be the following:\n');
    disp(F1F2Sequence');
    
    % calculate recording duration
    dutyCycle = 500;
    nTones = 3 + randi(5); % random number of tones between 4 and 8
    roundTo = 1000;
    recDur = dutyCycle * nTones + 2000;
    recDur = recDur + roundTo - mod(recDur, roundTo); % recording duration rounded to 'roundTo' ms

    % loop through all 'swap' combinations and play the oddball paradigm
    for i = 1:size(F1F2Sequence, 1);

        % initiate the file name
        fileName = sprintf('sp%02dOddTrialF%d_%d', CaImgExp.nSpots, 1.5 - F1F2Sequence(i) / 2, ...
            size(CaImgExp.spots{CaImgExp.nSpots}.stims, 2) + 1);
        abort = CaImgExp.checkAbort(sprintf('Stim name: %s, recording dur.: %d ms', fileName, recDur));
        if abort; return; end;

        fprintf('Oddball trial, no %d of %d\n', i, size(F1F2Sequence, 1));

        % run the stimulation
        % parameters :  attenLevel, randomSeed = 1 (oddball at end), nStimuli, BFreqIndex, freqDev, swap,
        %               stimDur = 100ms, dutyCycle = 500ms, ephysRate = 20'000Hz;
%         [CaImgExp, abort] = CaImgExp.runSingleStimulation('ODD_TRIAL', 0, randi(3) - 1, nTones, ...
        [CaImgExp, abort] = CaImgExp.runSingleStimulation('ODD_TRIAL', 0, 1, nTones, ...
            CaImgExp.spots{CaImgExp.nSpots}.BFreqIndex, 0, 0.5, F1F2Sequence(i), 'useFMSweep', 5000);
        
        if abort;
            CaImgExp.saveAll('backup_abort'); % save a backup of the aborted experiment
            return;
        end;
        CaImgExp.saveAll(fileName); % save a backup
        CaImgExp.saveAll(); % save the experiment
    end;

end % doOddballTrialParadigm


%% doOddballParadigm
% [proba]% oddball paradigm, F1 or F2 randomly assigned to be standard
% nRunsPerFreq: number of runs to do for each frequency (F1 and F2)
function [CaImgExp, abort] = doOddballParadigm(CaImgExp, proba, nRunsPerFreq)

    % create a random sequences of 'swap' for alternating F1 and F2, each 'nRunsPerFreq' times
    F1F2Sequence = [ones(nRunsPerFreq, 1); -1 * ones(nRunsPerFreq, 1)];
    % mix the sequence of F1 and F2
    F1F2Sequence = F1F2Sequence(randperm(size(F1F2Sequence, 1)));

    % check if the sequence is okay: nRunsPerFreq runs of each and no more '1' runs than -1
    if size(F1F2Sequence, 1) ~= nRunsPerFreq * 2 || sum(F1F2Sequence) ~= 0;
        warning('CaImgExperiment:doOddballParadigm:BadF1F2MixSeq', ...
            'F1F2 mixing sequence not the right length or not equilibrated!');
        % save a backup of the aborted experiment
        CaImgExp.saveAll(sprintf('backup_n%dOdd%d_%d_abortedF1F2Seq', CaImgExp.nSpots, proba, ...
            size(CaImgExp.spots{CaImgExp.nSpots}.stims, 2)));
        abort = 1;
        return;
    end;

    fprintf('Sequence of stimulation will be the following:\n');
    disp(F1F2Sequence');
    
    autoMode = str2double(input('Use auto mode? ', 's'));
    
    % calculate recording duration
    dutyCycle = 1500;
    nTones = 50;
    if CaImgExp.debugMode; nTones = 20; end;
    roundTo = 2000;
    recDur = dutyCycle * nTones + 1000;
    recDur = recDur + roundTo - mod(recDur, roundTo); % recording duration rounded to 'roundTo' ms

    % loop through all 'swap' combinations and play the oddball paradigm
    for i = 1:size(F1F2Sequence, 1);

        % initiate the file name
        fileName = sprintf('sp%02dOdd%dF%d_%d', CaImgExp.nSpots, proba, 1.5 - F1F2Sequence(i) / 2, ...
            size(CaImgExp.spots{CaImgExp.nSpots}.stims, 2) + 1);
        if autoMode;
            fprintf('Stim name: %s, recording dur.: %d ms\n', fileName, recDur);
        else
            abort = CaImgExp.checkAbort(sprintf('Stim name: %s, recording dur.: %d ms', fileName, recDur));
            if abort; return; end;
        end;

        fprintf('Oddball %d%% no %d of %d\n', proba, i, size(F1F2Sequence, 1));

        % run the stimulation
        % parameters :  attenLevel, randomSeed (0-4), nStimuli, BFreqIndex, proba, freqDev, swap,
        %               stimDur = 100ms, dutyCycle = 500ms, ephysRate = 20'000Hz;
        
        [CaImgExp, abort] = CaImgExp.runSingleStimulation('SSA_DEV', 0, randi(5) - 1, nTones, ...
            CaImgExp.spots{CaImgExp.nSpots}.BFreqIndex, proba, 0.5, F1F2Sequence(i), ...
            'useFMSweep', 0, 'dutyCycle', dutyCycle); % pure tones
%             CaImgExp.spots{CaImgExp.nSpots}.BFreqIndex, proba, 0.5, F1F2Sequence(i), ...
%             'useFMSweep', 15000, 'dutyCycle', dutyCycle); % FMSweep
%             CaImgExp.spots{CaImgExp.nSpots}.BFreqIndex, proba, 0.5, F1F2Sequence(i), ...
%             'useBLN', 5000, 'dutyCycle', dutyCycle); % Band limited noise
        
        if abort;
            CaImgExp.saveAll('backup_abort'); % save a backup of the aborted experiment
            return;
        end;
        CaImgExp.saveAll(fileName); % save a backup
        CaImgExp.saveAll(); % save the experiment
    end;

end % doOddballParadigm


%% doEquiProbControl
function [CaImgExp, abort] = doEquiProbControl(CaImgExp)

    % initiate the file name
        fileName = sprintf('sp%02dOdd%dF1_%d', CaImgExp.nSpots, 50, ...
            size(CaImgExp.spots{CaImgExp.nSpots}.stims, 2) + 1);
    abort = CaImgExp.checkAbort(sprintf('Stim name: %s, sweep dur.: %d ms', fileName, 55000));
    if abort; return; end;

    % equiprob control, F1 is standard, 1 run
    % parameters :  attenLevel, randomSeed (0-4), nStimuli, BFreqIndex, proba, freqDev, swap,
    %               stimDur = 100ms, dutyCycle = 500ms, ephysRate = 20'000Hz;
    if CaImgExp.debugMode;
        [CaImgExp, abort] = CaImgExp.runSingleOddballParadigm(0, randi(5) - 1, 20, ...
            CaImgExp.spots{CaImgExp.nSpots}.BFreqIndex, 50, 0.5, 1);
    else
        [CaImgExp, abort] = CaImgExp.runSingleOddballParadigm(0, randi(5) - 1, 100, ...
            CaImgExp.spots{CaImgExp.nSpots}.BFreqIndex, 50, 0.5, 1);
    end;
    if abort;
        CaImgExp.saveAll('backup_abort'); % save a backup of the aborted experiment
        return;
    end;
    CaImgExp.saveAll(fileName); % save a backup
    CaImgExp.saveAll(); % save the experiment


    % initiate the file name
        fileName = sprintf('sp%02dOdd%dF2_%d', CaImgExp.nSpots, 50, ...
            size(CaImgExp.spots{CaImgExp.nSpots}.stims, 2) + 1);
    abort = CaImgExp.checkAbort(sprintf('Stim name: %s, sweep dur.: %d ms', fileName, 55000));
    if abort; return; end;

    % equiprob control, F2 is standard, 1 run
    % parameters :  attenLevel, randomSeed (0-4), nStimuli, BFreqIndex, proba, freqDev, swap,
    %               stimDur = 100ms, dutyCycle = 500ms, ephysRate = 20'000Hz;
    if CaImgExp.debugMode;
        [CaImgExp, abort] = CaImgExp.runSingleStimulation('SSA_DEV', 0, randi(5) - 1, 20, ...
            CaImgExp.spots{CaImgExp.nSpots}.BFreqIndex, 50, 0.5, -1);
    else
        [CaImgExp, abort] = CaImgExp.runSingleStimulation('SSA_DEV', 0, randi(5) - 1, 100, ...
            CaImgExp.spots{CaImgExp.nSpots}.BFreqIndex, 50, 0.5, -1);
    end;
    if abort;
        CaImgExp.saveAll('backup_abort'); % save a backup of the aborted experiment
        return;
    end;

    CaImgExp.saveAll(fileName); % save a backup
    CaImgExp.saveAll(); % save the experiment

end % doEquiProbControl


%% doDevAloneControl
function [CaImgExp, abort] = doDevAloneControl(CaImgExp, proba)

    BFreqIndex = CaImgExp.spots{CaImgExp.nSpots}.BFreqIndex;

    if BFreqIndex == 1 || BFreqIndex == 15;
        warning('CaImgExperiment:doDevAloneControl:BFOutOfRange', ...
            ['The deviant alone control will not be accurated as F1 or F2' ...
            ' cannot be played (out of range)']);
        % HACK the BF so that BF + 1 and BF -1 are in range
        if BFreqIndex == 1; BFreqIndex = 2;
        elseif BFreqIndex == 15; BFreqIndex = 14;
        end
    end

    % [100 - proba]% omission = proba% deviants alone, F1 or F2 as lonely deviant, 5 runs each
    % number of runs to do for each frequency (F1 and F2)
    nRunsPerFreq = 5;
    % create a random sequences of 'swap' for alternating F1 and F2, each 'nRunsPerFreq' times
    F1F2Sequence = [ones(nRunsPerFreq, 1); -1 * ones(nRunsPerFreq, 1)];
    % mix the sequence of F1 and F2
    F1F2Sequence = F1F2Sequence(randperm(size(F1F2Sequence, 1)));

    % check if the sequence is okay: nRunsPerFreq runs of each and no more '1' runs than -1
    if size(F1F2Sequence, 1) ~= nRunsPerFreq * 2 || sum(F1F2Sequence) ~= 0;
        warning('CaImgExperiment:doDevAloneControl:BadF1F2MixSeq', ...
            'F1F2 mixing sequence not the right length or not equilibrated!');
        % save a backup of the aborted experiment
        CaImgExp.saveAll(sprintf('backup_n%dDevAl%d_%d_abortedF1F2Seq', CaImgExp.nSpots, proba, ...
            size(CaImgExp.spots{CaImgExp.nSpots}.stims, 2)));
        abort = 1;
        return;
    end;

    fprintf('Sequence of stimulation will be the following:\n');
    disp(F1F2Sequence');

    % loop through all 'swap' combinations and play the oddball paradigm
    for i = 1:size(F1F2Sequence, 1);

        % initiate the file name
        fileName = sprintf('sp%02dDevAl%dF%d_%d', CaImgExp.nSpots, proba, 1.5 - F1F2Sequence(i) / 2, ...
            size(CaImgExp.spots{CaImgExp.nSpots}.stims, 2) + 1);
        abort = CaImgExp.checkAbort(sprintf('Stim name: %s, sweep dur.: %d ms', fileName, 55000));
        if abort; return; end;

        fprintf('DevAl %d%% no %d of %d\n', proba, i, size(F1F2Sequence, 1));

        % run the stimulation
        % parameters :  attenLevel, randomSeed (0-4), nStimuli, BFreqIndex, proba, freqDev, swap,
        %               stimDur = 100ms, dutyCycle = 500ms, ephysRate = 20'000Hz;
        if CaImgExp.debugMode;
            [CaImgExp, abort] = CaImgExp.runSingleStimulation('SSA_OMI', 10, randi(5) - 1, 20, ...
                BFreqIndex + F1F2Sequence(i), proba, 0.5, 1);
        else
            [CaImgExp, abort] = CaImgExp.runSingleStimulation('SSA_OMI', 10, randi(5) - 1, 100, ...
                BFreqIndex + F1F2Sequence(i), proba, 0.5, 1);
        end;
        if abort;
            CaImgExp.saveAll('backup_abort'); % save a backup of the aborted experiment
            return;
        end;

        CaImgExp.saveAll(fileName); % save a backup
        CaImgExp.saveAll(); % save the experiment
    end;

end % doDevAloneControl


%% doOmissionParadigm
function [CaImgExp, abort] = doOmissionParadigm(CaImgExp, proba, nRuns)

    BFreqIndex = CaImgExp.spots{CaImgExp.nSpots}.BFreqIndex;

    % [proba]% omission, best freq is standard, nRuns runs
    for i = 1:nRuns;

        % initiate the file name
        fileName = sprintf('sp%02dOmi%d_%d', CaImgExp.nSpots, proba, ...
            size(CaImgExp.spots{CaImgExp.nSpots}.stims, 2) + 1);
        abort = CaImgExp.checkAbort(sprintf('Stim name: %s, sweep dur.: %d ms', fileName, 55000));
        if abort; return; end;

        fprintf('Omi %d%% no %d of %d\n', proba, i, nRuns);

        % parameters :  attenLevel, randomSeed (0-4), nStimuli, BFreqIndex, proba, freqDev, swap,
        %               stimDur = 100ms, dutyCycle = 500ms, ephysRate = 20'000Hz;
        if CaImgExp.debugMode;
            [CaImgExp, abort] = CaImgExp.runSingleStimulation('SSA_OMI', 10, randi(5) - 1, 20, ...
                BFreqIndex, proba, 0.5, -1);
        else
            [CaImgExp, abort] = CaImgExp.runSingleStimulation('SSA_OMI', 10, randi(5) - 1, 100, ...
                BFreqIndex, proba, 0.5, -1);
        end;
        if abort;
            CaImgExp.saveAll('backup_abort'); % save a backup of the aborted experiment
            return;
        end;

        CaImgExp.saveAll(fileName); % save a backup
        CaImgExp.saveAll(); % save the experiment
    end;

end % doOmissionParadigm