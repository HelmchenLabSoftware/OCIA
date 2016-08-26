%% #BEGetTrialInfo
function trialInfo = BEGetTrialInfo(this, iTrial)

% default is empty
freq = ''; spotIndex = ''; isTargetOrNTones = ''; resp = ''; respTime = ''; corr = ''; rew = '';

if iTrial > 0 && iTrial <= this.be.config.training.nTrials && isfield(this.be, 'stims');
    
    if isfield(this.be, 'spotMatrix') && ~isempty(this.be.spotMatrix);
        spotIndex = this.be.spotMatrix(iTrial);
    end;
    
    freq = round(this.be.config.tone.freqs(this.be.stims(iTrial)) / 1000);
    
    % no goStim = no behavior
    if ~isempty(this.be.config.tone.goStim);
        
        % oddball discrimination
        if isfield(this.be.config.tone, 'oddProba') && this.be.config.tone.oddProba > 0;
            
            isTargetOrNTones = double(this.be.stims(iTrial) ~= this.be.odds(iTrial) && this.be.config.tone.goStim);
            
        % frequency/cloud of tone discrimination
        else
            
            isTargetOrNTones = double(ismember(this.be.stims(iTrial), this.be.config.tone.goStim));
            
        end;
    
    elseif strcmp(this.be.taskType, 'cotOdd') && numel(this.be.nTones) > 1;
        
        % fill with number of tones
        isTargetOrNTones = this.be.nTones(iTrial);
        
    end;

    if ~isempty(this.be.config.tone.goStim) && isfield(this.be, 'resps') && ~isnan(this.be.resps(iTrial));
        resp = this.be.resps(iTrial);
        if ~isnan(this.be.respDelays(iTrial));
            respTime = sprintf('%.2f', this.be.respDelays(iTrial));
        else
            respTime = '   -  ';
        end;
        corr = double((isTargetOrNTones && resp) || (~isTargetOrNTones && ~resp));
        if corr; corr = ' T '; else corr = ' F '; end;
        if ~isnan(this.be.giveRewards(iTrial)) && this.be.giveRewards(iTrial);
            rew = ' T ';
        else
            rew = ' F';
        end;
        if this.be.resps(iTrial); resp = ' T '; else resp = ' F'; end;
        if this.be.autoRewardGiven(iTrial) && strcmp(corr, ' T '); corr = ' F*';  end;
    end;
    if isTargetOrNTones; isTargetOrNTones = ' T '; else isTargetOrNTones = ' F'; end;
    
% no trial number
else
    
    iTrial = '';
    
end;

trialInfo = {iTrial, spotIndex, freq, isTargetOrNTones, resp, respTime, corr, rew};

end

