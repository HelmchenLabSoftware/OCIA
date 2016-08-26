function [stimMatrix, consistent] = genStimMatrix(stimTypes, stimSize, blockSize, maxConsec, nSeqs, seqStartStimType, varargin)

%% init
if numel(varargin);
    doPlot = varargin{1};
else
    doPlot = 0;
end;

% tells whether the generated stim matrix is consistent
consistent = 1;

% get the number of different stimulus types
nStimTypes = numel(stimTypes);

% check whether the distribution will be equilibrated
if mod(stimSize, nStimTypes) || mod(blockSize, nStimTypes) || mod(stimSize, blockSize);
    error('genStimMatrix:distributionNotEqual', ['Distribution will not be equilibrated because ', ...
        'stimSize in nStimTypes: mod(%d, %d) = %d or blockSize in stimTypes: mod(%d, %d) = %d or ', ...
        'stimSize in blockSize: mod(%d, %d) = %d.'], stimSize, nStimTypes, mod(stimSize, nStimTypes), ...
        blockSize, nStimTypes, mod(blockSize, nStimTypes), stimSize, blockSize, mod(stimSize, blockSize));
end;

%% build possibilities
% get the base stimulus for a single block
blockBase = sort(repmat(1 : nStimTypes, 1, blockSize / nStimTypes));

% get all the possible combination for a single block
uniqueBlocks = unique(perms(blockBase), 'rows');
nUniqueBlocks = size(uniqueBlocks, 1); % get the number of unique blocks

%% refine
% make sure to have one value of maximum consecutive per unique stimulus type
if numel(maxConsec) == 1;
    maxConsec = repmat(maxConsec, nStimTypes, 1);
% if numbers do not match, abort
elseif numel(maxConsec) ~= nStimTypes;
    error('genStimMatrix:BadMaxConsecSize', ['Number of maxConsec elements (%d) should be equal to the number of ', ...
        'stimulus types (%d).'], numel(maxConsec), nStimTypes);
end;
% exclude block with too many repetitions: turn blocks into strings
uniqueBlocksString = arrayfun(@(i)strrep(num2str(uniqueBlocks(i, :)), ' ', ''), 1 : nUniqueBlocks, ...
    'UniformOutput', false);
% get the blocks with more than "maxConsecutive" repetitions
repetBlocks = false(nUniqueBlocks, 1);
for iStimType = 1 : nStimTypes;
    % get the match pattern as '1{4,10}' for "stimType" = 1, "maxConsecutive" = 3 and "blockSize" = 10
    regexpRepetMatch = sprintf('%d{%d,%d}', iStimType, maxConsec(iStimType) + 1, blockSize);
    % get blocks that have more than "maxConsecutive" repetitions
    repetBlocksForStimType = regexp(uniqueBlocksString, regexpRepetMatch, 'once');
    % mark blocks that have more than "maxConsecutive" repetitions
    repetBlocks(~cell2mat(cellfun(@isempty, repetBlocksForStimType, 'UniformOutput', false))) = true;
end;

% exclude blocks that have more than "maxConsecutive" repetitions
uniqueBlocks(repetBlocks, :) = [];
nUniqueBlocks = size(uniqueBlocks, 1); % update the number of unique blocks

% generate the random block index matrix
nBlocksPerStim = stimSize / blockSize;
randBlockIndexes = randi(nUniqueBlocks, [nSeqs, nBlocksPerStim]);

% check whether no sequence is similar
nUniqueRandBlockIndexes = size(unique(randBlockIndexes, 'rows'), 1);
if nUniqueRandBlockIndexes ~= nSeqs;
    warning('genStimMatrix:sequencesDuplicated', 'Some sequences are similar !');
    consistent = 0;
end;

% generate the stim matrix with the stim type indexes
stimMatrixIndex = nan(nSeqs, stimSize);
for iSequence = 1 : nSeqs;
    % should be true to validated a sequence
    sequenceIsValid = false;
    % loop until all sequences are valid
    while ~sequenceIsValid;
        % should remain true to exit the loop
        sequenceIsValid = true;
        % get the selected blocks
        blocks = uniqueBlocks(randBlockIndexes(iSequence, :), :)';
        % store them linearized
        stimMatrixIndex(iSequence, :) = blocks(:);

        % if the first number is not the requested one, change the first block and loop again
        if ~isempty(seqStartStimType) && stimMatrixIndex(iSequence, 1) ~= find(stimTypes == seqStartStimType);
            sequenceIsValid = false; % tag as non-valid
            randBlockIndexes(iSequence, 1) = randi(nUniqueBlocks, 1); % replace first block
            continue;
        end;
        
        uniqueSequenceString = strrep(num2str(stimMatrixIndex(iSequence, :)), ' ', '');
        % get if the sequence has more than "maxConsecutive" repetitions
        for iStimType = 1 : nStimTypes;
            % get the match pattern as '1{4,50}' for example with "stimType" = 1, "maxConsecutive" = 3 and "stimSize" = 50
            regexpRepetMatch = sprintf('%d{%d,%d}', iStimType, maxConsec(iStimType) + 1, stimSize);
            % get blocks that have more than "maxConsecutive" repetitions
            repetMatches = regexp(uniqueSequenceString, regexpRepetMatch, 'once');
            if ~isempty(repetMatches);
                sequenceIsValid = false; % tag as non-valid
                repetMatches = repetMatches(1); % only get one bad block at once
                badBlockIndex = ceil(repetMatches / blockSize); % get the bad block's index
                randBlockIndexes(iSequence, badBlockIndex) = randi(nUniqueBlocks, 1); % replace the bad block            
                break;
            end;
        end;
        
    end;
        
end;

% replace the stim type indexes by the actual stim types
stimMatrix = nan(nSeqs, stimSize);
for iStimType = 1 : nStimTypes;
    stimMatrix(stimMatrixIndex == iStimType) = stimTypes(iStimType);
end;

%% check
% check consistency of unique blocks
badUniqueBlockSums = sum(uniqueBlocks, 2) ~= mean(1 : numel(stimTypes)) * blockSize;
if any(badUniqueBlockSums);
    warning('genStimMatrix:stimMatrixNotConsistent:uniqueBlockSums', ...
        'Unique blocks not consistent with block sums! Bad blocks:%s.', sprintf(' %d', find(badUniqueBlockSums)));
    consistent = 0;
end;

% check consistency for rows by summing each row
badRowSums = sum(stimMatrixIndex, 2) ~= mean(1 : numel(stimTypes)) * stimSize;
if any(badRowSums);
    warning('genStimMatrix:stimMatrixNotConsistent:rowSum', ...
        'Stim matrix is not consistent with row sums! Bad rows:%s.', sprintf(' %d', find(badRowSums)));
    consistent = 0;
end;

% check consistency for blocks
blockSums = nan(nSeqs, nBlocksPerStim);
for iSequence = 1 : nSeqs;
    % get the sums of the blocks
    blockSums(iSequence, :) = sum(reshape(stimMatrixIndex(iSequence, :), blockSize, nBlocksPerStim));
    badBlockSums = blockSums(iSequence, :) ~= mean(1 : numel(stimTypes)) * blockSize;
    if any(badBlockSums);
        warning('genStimMatrix:stimMatrixNotConsistent:blockSum', ...
            'Stim matrix is not consistent with block sums! Bad blocks in row %d:%s.', ...
            iSequence, sprintf(' %d', find(badBlockSums)));
        consistent = 0;
    end;
end;

%% plot
% do some checking plots
if doPlot;

    figure('Name', 'StimMatrix consistency');
    
    % sequence display
    subplot(2, 2, [1 2]);
    imagesc(stimMatrix);
    colorbar;
    
    % row sums
    subplot(2, 2, 3);
    hist(stimMatrix');
    title('Row sums');
    xlabel('stimTypes');
    ylabel('row sum');

    % block sums
    subplot(2, 2, 4);
    imagesc(blockSums);
    set(gca, 'XTick', 1 : nBlocksPerStim, 'YTick', 1 : nSeqs);
    hold on;
    line([0.5 nBlocksPerStim + 0.5], [1 1] - 0.5, 'Color', 'black');
    for iSequence = 1 : nSeqs;
        line([0.5 nBlocksPerStim + 0.5], [iSequence iSequence] + 0.5, 'Color', 'black');
    end;
    line([1 1] + 0.5, [0.5 nSeqs + 0.5], 'Color', 'black');
    for iBlock = 1 : nBlocksPerStim;
        line([iBlock iBlock] + 0.5, [0.5 nSeqs + 0.5], 'Color', 'black');
    end;
    title('Block sums');
    colorbar;
    colormap('jet');
    xlabel('blocks');
    ylabel('sequences');
end;

end
