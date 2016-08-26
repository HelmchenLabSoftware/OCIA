function [CaImgExp, abort] = doBFTest(CaImgExp, attenuations)
    % doBFTest method for CaImgExperiment class.
    % Does best frequency test on the current spot with different SPLs (attenuation), random seed = -1
    % and 75 pulses (= 5 times all the 15 different frequencies)
    
    % REMARK: all the do**** and run**** functions are applied to the last added spot
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Originally created on               2013-03-20 %
    % Written by B. Laurenczy (blaurenczy@gmail.com) %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    autoMode = str2double(input('Use auto mode? ', 's'));
    if isnan(autoMode); autoMode = 1; end;
    
    dutyCycle = 1500;
    nTones = 30;
    if CaImgExp.debugMode; nTones = 20; end;
    roundTo = 5000;
    recDur = dutyCycle * nTones + 1000;
    recDur = recDur + roundTo - mod(recDur, roundTo); % recording duration rounded to 'roundTo' ms
    
    % loop through all the attenuations levels requested
    iRun = 1;
    while iRun <= size(attenuations, 2); % use while loop to be able to add more runs if required

        % initiate the file name and ask user to set it in Igor
        fileName = sprintf('sp%02dBF_%d', CaImgExp.nSpots, size(CaImgExp.spots{CaImgExp.nSpots}.stims, 2) + 1);
        if autoMode;
            fprintf('Stim name: %s, recording dur.: %d ms\n', fileName, recDur);
        else
         abort = CaImgExp.checkAbort(sprintf('Run name: %s, recording dur.: %d ms', fileName, recDur));
         if abort; return; end;
        end;

        % run the stimulation: SPL = attenuation, random seed = -1, 'nTones' pulses (or less if in debug mode)
        [CaImgExp, abort] = CaImgExp.runSingleStimulation('BF', attenuations(iRun), -1, nTones, ...
            'dutyCycle', dutyCycle, 'stimDur', 100);
        if abort;
            CaImgExp.saveAll('backup_abort'); % save a backup of the aborted experiment
            return;
        end;
        CaImgExp.saveAll(fileName); % save a backup
        CaImgExp.saveAll(); % save the experiment
        
        iRun = iRun + 1;
                
%         if iRun > size(attenuations, 2);
%             doAdditionalRun = '';
%             while ~strcmp(doAdditionalRun, '0') && ~strcmp(doAdditionalRun, '1');
%                 doAdditionalRun = input('Do additional run of BF test? 1/0: ', 's');
%             end;
%             if str2double(doAdditionalRun);
%                 iRun = size(attenuations, 2); % repeat last attenuation;
%             end;
%         end;
    end;
    
    
    % TODO: create a good live BF analysis of the spot...
    
%     if CaImgExp.checkAbort('Press [ENTER] when Igor has saved all files'); return; end;
% 
%     plotOrCopy = '';
%     while plotOrCopy ~= 1 || plotOrCopy ~= 2;
%         plotOrCopy = input('Press 1 for direct plotting or 2 for copying + remote analysis: ', 's');
%     end;
% 
%     % if plotting requested and not in debug mode
%     if plotOrCopy == 1 && ~CaImgExp.debugMode;
% 
%         % load the raw data
%         CaImgExp = CaImgExp.loadEphysData(CaImgExp.nSpots, 'BF', -1, 1, -1);
%         % plot each ephys and the analysis
%         CaImgExp.analyseEphys(CaImgExp.nSpots, 'BF', -1, 1, -1, 'doSaveEphysAPPlot', 1, ...
%             'doSaveFreqPlot',  1);
%         if abort; return; end;
% 
%     % if copying for remote analysis requested and not in debug mode
%     elseif plotOrCopy == 2 && ~CaImgExp.debugMode;
% 
%         % copy BFTest's files to analysis folder for analysis on another computer
%         destPath = sprintf(['W:/Neurophysiology/Projects/Auditory/Analysis/Balazs/' ...
%             'BFTestAnalysis/%s_ephys/'], CaImgExp.dateStr);
%         basePathBackup = CaImgExp.basePath;
%         mkdir(destPath);
%         fprintf('  - Copying BF raw data files from "%s" to "%s" with pattern "%s"...\n', ...
%             CaImgExp.basePath, destPath, sprintf('n%dBF_*', CaImgExp.nSpots));
%         copyfile(sprintf('%s/n%dBF_*', CaImgExp.basePath, CaImgExp.nSpots), destPath);
% 
%         % go to remote directory to make a copy of the CaImgExp object
%         cd(destPath);
%         CaImgExp.basePath = cd;
%         CaImgExp.saveAll('BFTest');
% 
%         % come back
%         cd(basePathBackup);
%         CaImgExp.basePath = basePathBackup;
% 
%     end;
% 
%     CaImgExp.saveAll('BFTestRequested');
%     CaImgExp.saveAll();

%     if CaImgExp.checkAbort('Press [ENTER] to proceed to BF analysis... '); return; end;
%     % ask the experiment to choose a best frequency
%     while ~(isnumeric(CaImgExp.spots{CaImgExp.nSpots}.BFreqIndex) && CaImgExp.spots{CaImgExp.nSpots}.BFreqIndex >= 1 && ...
%             CaImgExp.spots{CaImgExp.nSpots}.BFreqIndex <= 15);
%         CaImgExp.spots{CaImgExp.nSpots}.BFreqIndex = input('Enter the best frequency index (1-15): ');
%     end;
% 
%     CaImgExp.saveAll(sprintf('n%dBFChosen', CaImgExp.nSpots)); % save a backup
%     CaImgExp.saveAll(); % save the experiment
%     if abort; return; end;

end % doBFTest
