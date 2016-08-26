function [CaImgExp, abort] = runSingleStimulation(CaImgExp, type, varargin)
    % runSingleStimulation method for CaImgExperiment objects
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Originally created on               2013-03-20 %
    % Written by B. Laurenczy (blaurenczy@gmail.com) %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % compute the new number of stimulations as the previous number of BF stimulations + 1
    nStimulations = size(CaImgExp.spots{CaImgExp.nSpots}.stims, 2) + 1;
    fprintf('  - Spot no %d, stimulation no %d...\n', CaImgExp.nSpots, nStimulations);

    if CaImgExp.debugMode;
        % store the BFTest's stimulation parameters in a new column of the spot's 
        % stimulations cell array
        [CaImgExp.spots{CaImgExp.nSpots}.stims{nStimulations}, abort] = ...
            PlayStimulationSequence(type, varargin{:}, 'v', 2, 'useExtTrig', 0, ...
            'd', CaImgExp.debugMode, 'noTDT', CaImgExp.noTDT);
    else
        % store the BFTest's stimulation parameters in a new column of the spot's 
        % stimulations cell array. Send trigger with 60 sec timeout.
        [CaImgExp.spots{CaImgExp.nSpots}.stims{nStimulations}, abort] = ...
...%             PlayStimulationSequence(type, varargin{:}, 'v', 1, 'useExtTrig', 60, ...
            PlayStimulationSequence(type, varargin{:}, 'v', 1, 'useExtTrig', 0, ...
            'd', CaImgExp.debugMode, 'noTDT', CaImgExp.noTDT);
    end;
    
    % add the stim time for retrieving the HelioScan recorded file
    CaImgExp.spots{CaImgExp.nSpots}.stims{nStimulations}.stimTime = ...
        [datestr(now, 'yyyy_mm_dd__hh_MM_ss') 'h'];

end % runSingleStimulation
