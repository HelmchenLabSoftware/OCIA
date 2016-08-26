function BEApplyConfig(this, ~, ~)
% BEApplyConfig - [no description]
%
%       BEApplyConfig(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

showMessage(this, 'Applying configuration ...');
toneConf = this.be.config.tone;
trainConf = this.be.config.training;

%% stimuli and trials
o('  #%s: setup stimuli and trials... ', mfilename(), 3, this.verb);
% set up stimulus vector
if isfield(toneConf, 'stimMatrix');
    
%     if conf.training.nTrials ~= size(toneConf.stimMatrix, 2);
%         showWarning(this, 'OCIA:Behavior:loadConfig:NumberOfTrialsMismatch', ...
%             sprintf('nTrials in the "training" (%d) ~= nTrials in "stimMatrix" (%d). Overwriting.', ...
%             conf.training.nTrials, size(toneConf.stimMatrix, 2)));
%         pause(1);
%         conf.training.nTrials = size(toneConf.stimMatrix, 2);
%     end;

    this.be.stimMatrixRandomIndex = randi(size(toneConf.stimMatrix, 1));
    stims = toneConf.stimMatrix(this.be.stimMatrixRandomIndex, :);
    if numel(stims) < trainConf.nTrials && 2 * numel(stims) == trainConf.nTrials;
        stims = repmat(stims, 1, 2);
    end;
    stims = stims(1 : trainConf.nTrials); % only take first nTrials, hoping that the block hashing is okay

else
    
    showWarning(this, 'OCIA:Behavior:ApplyConfig:NoStimMatrix', 'Behavior: no stimulus matrix found ! Aborting.');
    set(this.GUI.handles.be.loadConf, 'BackgroundColor', 'red', 'Value', 0);
    return;
    
%     stims = [];
%     for iFreq = 1 : numel(toneConf.freqs);
%         stimForFreq = repmat(iFreq, 1, round(toneConf.stimProba(iFreq) * trainConf.nTrials));
%         stims = [stims, stimForFreq]; %#ok<AGROW>
%     end
% 
%     % stim vector should not be randomly permuted
%     stims = stims(randperm(numel(stims)));
%     stims = stims(1 : trainConf.nTrials);

end;

%{
% set up spot sequence: get the number of spots
spotTable = get(this.GUI.handles.be.ETLTable, 'Data');
nSpots = size(spotTable, 1);

% by default, spotMatrix is empty so there is no spot switching
this.be.spotMatrix = [];

% if spots exist and a spot matrix exists
if nSpots > 0 && isfield(trainConf, 'spotMatrix');

    % if more spots exist that the number of elements in the spot matrix
    if nSpots > numel(trainConf.spotMatrix);
        showWarning(this, 'OCIA:Behavior:ApplyConfig:SpotMatrixTooSmall', 'Behavior: spot matrix too small ! Aborting.');
        set(this.GUI.handles.be.loadConf, 'BackgroundColor', 'red', 'Value', 0);
        return;
    end;
    
    % get the spot matrix for the correct number of spots
    this.be.spotMatrix = trainConf.spotMatrix{nSpots};
    
% some spots exist but no spot matrix
elseif nSpots > 0;    
    showWarning(this, 'OCIA:Behavior:ApplyConfig:NoSpotMatrix', 'Behavior: no spot matrix found ! Aborting.');
    set(this.GUI.handles.be.loadConf, 'BackgroundColor', 'red', 'Value', 0);
    return;
    
end;

%}

switch this.be.taskType;
    
    case 'oddDiscr';
        % set up oddball vector by altering stims with a certain probability
        odds = stims;
        oddPos = zeros(size(odds));
        uniqueStims = unique(stims);
        isOdd = rand(1, numel(stims)) < toneConf.oddProba;
        % last 2 tones can be odd
        uniqueOddPos = toneConf.nTones - 1 : toneConf.nTones;
        for iStim = 1 : numel(isOdd);
            if isOdd(iStim);
                otherStims = uniqueStims(uniqueStims ~= stims(iStim));
                otherStims = otherStims(randperm(numel(otherStims)));
                mixedOddPos = uniqueOddPos(randperm(numel(uniqueOddPos)));
                odds(iStim) = otherStims(1);
                oddPos(iStim) = mixedOddPos(1);
            end;
        end;
        
        % only one number of tones
        if numel(toneConf.nTones) == 1;
            nTones = toneConf.nTones;
            
        % multiple number of tones, with a nTonesMatrix to randomly choose
        elseif isfield(toneConf, 'nTonesMatrix');
            nTonesRand = randi(size(toneConf.nTonesMatrix, 1));
            nTones = toneConf.nTonesMatrix(nTonesRand, :);
            
        % multiple number of tones but no nTonesMatrix so just use the first number of tones
        else
            nTones = toneConf.nTones(1);
            
        end;

        % set up tone array
        this.be.toneArray = MakePureMultiToneOddballArray(toneConf.freqs, ...
            stims, odds, oddPos, nTones, toneConf.stimDur, toneConf.ISI, ...
            toneConf.samplingFreq);
    
    case 'freqDiscr';
        
        odds = zeros(size(stims));
        oddPos = zeros(size(stims));
        isOdd = zeros(size(stims));
        
        % only one number of tones
        if numel(toneConf.nTones) == 1;
            nTones = toneConf.nTones;
            
        % multiple number of tones, with a nTonesMatrix to randomly choose
        elseif isfield(toneConf, 'nTonesMatrix');
            nTonesRand = randi(size(toneConf.nTonesMatrix, 1));
            nTones = toneConf.nTonesMatrix(nTonesRand, :);
            
        % multiple number of tones but no nTonesMatrix so just use the first number of tones
        else
            nTones = toneConf.nTones(1);
            
        end;

        this.be.toneArray = MakePureToneArray(toneConf.freqs, ...
            stims, toneConf.stimDur, toneConf.samplingFreq);
        
        amplifFactor = 50;
        for iTone = 1 : numel(this.be.toneArray);
            this.be.toneArray{iTone} = this.be.toneArray{iTone} * amplifFactor;
        end;
    
    case 'cotOdd';
                
        % only one number of tones
        if numel(toneConf.nTones) == 1;
            nTones = toneConf.nTones;
        % multiple number of tones, with a nTonesMatrix to randomly choose
        elseif isfield(toneConf, 'nTonesMatrix');
            nTonesRand = randi(size(toneConf.nTonesMatrix, 1));
            nTones = toneConf.nTonesMatrix(nTonesRand, :);
        % multiple number of tones but no nTonesMatrix so just use the first number of tones
        else
            nTones = toneConf.nTones(1);
        end;
        
        % set up sound array with last tone as odd 
        odds = ones(size(stims));
        oddPos = nTones;
        isOdd = ones(size(stims));
        sampFreq = toneConf.samplingFreq;
        
        this.be.toneArray = cell(1, numel(stims));
        
        for iStim = 1 : numel(stims);
            
            freqList = toneConf.uniqueFreqs;
            
            if stims(iStim) == 1;
                cotStimVector = [ones(1, nTones(iStim) - 1) 2];
            else
                cotStimVector = [ones(1, nTones(iStim) - 1) * 2 1];
            end;
            
            % create cell array of cloud of tones
            cot = MakeCloudOfTonesSound(freqList, toneConf.freqIndexes, ...
                toneConf.cloudDispersion, cotStimVector, toneConf.toneDur, ...
                toneConf.toneISI, toneConf.stimDur, 0, sampFreq, 0, 0);
            
            cotAll = cell2mat(cot); % get cell array as a matrix
            cotDim = size(cotAll); % get dimension
            silenceDur = round(sampFreq * toneConf.ISI); % get silence duration
            cotAll = [zeros(cotDim(1), silenceDur) cotAll]; %#ok<AGROW> % insert silences
            cotAll = reshape(cotAll', 1, numel(cotAll)); % make linear
            cotAll = cotAll(silenceDur + 1 : end); % remove first silence
            this.be.toneArray{iStim} = cotAll; % store
            
        end;

    case 'cotDiscr';

        nTones = toneConf.nTones;
        odds = zeros(size(stims));
        oddPos = zeros(size(stims));
        isOdd = zeros(size(stims));
        
        atten = 0;
        this.be.toneArray = MakeCloudOfTonesSound(toneConf.uniqueFreqs, ...
            toneConf.freqIndexes, toneConf.cloudDispersion, stims, ...
            toneConf.toneDur, toneConf.toneISI, ...
            toneConf.stimDur, atten, toneConf.samplingFreq, 0, 0);
        
end;

this.be.nTones = nTones;
this.be.stims = stims;
this.be.odds = odds;
this.be.oddPos = oddPos;
this.be.isOdd = isOdd;

% set the reward duration to the one of the config file
BEChangeRewDur(this, trainConf.rewDur);

BEInitExp(this);

o('  #%s: setup stimuli and trials done. ', mfilename(), 3, this.verb);
showMessage(this, sprintf('Applying configuration done for mouse "%s".', this.be.animalID));

BEUpdateGUI(this);


end
