%% #OCIA:AN:OCIA_genStimVect_fromInputArgument
function [isValid, unvalidReason] = OCIA_genStimVect_fromInputArgument(this, iDWRow, stimVectCellArray, ...
    stimTypesCellArray, nMaxStimTypesCellArray)

isValid = true; % by default, the row is valid
unvalidReason = ''; % by default no reason

o('#%s(): row num: %d ...', mfilename, iDWRow, 3, this.verb);

%% creating the stim vector
% start bit encoding with bit 1
iBit = 0;

% initiate final stim vector
finalStimVect = zeros(size(stimVectCellArray{1}));
finalStimTypes = '';

% encode each stimulus type one after the other
for iStimVect = 1 : numel(stimVectCellArray);
    
    currStimVect = stimVectCellArray{iStimVect};
    stimIndices = find(currStimVect > 0);
    stimValues = currStimVect(stimIndices);
    
    % calculate the number of bits to encode 
    nMaxStimTypes = nMaxStimTypesCellArray{iStimVect};
    nBitsToUseForStimTimes = max(ceil(log2(nMaxStimTypes)), 1);
    % assign bits to difference encodings
    iBitCurrStimVect = iBit + (1 : nBitsToUseForStimTimes);
    iBit = iBit + nBitsToUseForStimTimes;
    
    % encode the stimulus time: get the bit code for each stimulus time
    for iInd = 1 : numel(stimIndices);
        bitCode = bitget(stimValues(iInd), 1 : nBitsToUseForStimTimes);
        % encode the bitCode into the stimulus vector
        for iBitLoop = 1 : nBitsToUseForStimTimes;
            % annotate with the stimuli with the current bit iteratively
            finalStimVect(stimIndices(iInd)) = bitset(finalStimVect(stimIndices(iInd)), iBitCurrStimVect(iBitLoop), ...
                bitCode(iBitLoop));
        end;
    end;
    
    % encode the stimulus type
    for iBitLoop = 1 : nBitsToUseForStimTimes;
        finalStimTypes = sprintf('%s,%s', finalStimTypes, stimTypesCellArray{iStimVect});
    end;

    % store temporarly this empty stimulus vector (in case things get stuck later on)
    setData(this, iDWRow, 'stim', 'data', finalStimVect);
    setData(this, iDWRow, 'stim', 'loadStatus', 'partial');
    setData(this, iDWRow, 'stim', 'stimTypes', regexprep(finalStimTypes, '^,', ''));
    
end;

%% saving the stimulus vector    
% store the created stimulus vector and the different stimulus types encoding
setData(this, iDWRow, 'stim', 'data', finalStimVect);
setData(this, iDWRow, 'stim', 'loadStatus', 'full');
setData(this, iDWRow, 'stim', 'stimTypes', regexprep(finalStimTypes, '^,', ''));

end
