%% #OCIA:AN:OCIA_genStimVect_fromBehavTextFile
function [isValid, unvalidReason] = OCIA_genStimVect_fromBehavTextFile(this, iDWRow, varargin)

% get whether to do plots or not
if nargin > 2;      doDebugPlots = varargin{1}; 
else                doDebugPlots = 0;
end;

rowID = DWGetRowID(this, iDWRow); % get the row ID 
isValid = true; % by default, the row is valid
unvalidReason = ''; % by default no reason

o('#%s(): row num: %d ...', mfilename, iDWRow, 3, this.verb);

%% init the stim vector
% get the number of skipped frames
nSkippedFrames = this.an.skipFrame.nFramesBegin + this.an.skipFrame.nFramesEnd;
imgDim = str2dim(get(this, iDWRow, 'dim'));
% compensate for the skipped frames
if numel(imgDim) < 3;   nFramesImg = 0;
else                    nFramesImg = imgDim(3) - nSkippedFrames;
end;
% stimulus vector is all zeros except where there are stimulus starts (sound, lick, spout, etc.)
stimVect = zeros(1, nFramesImg);
% string storing the stimulus types for this row
stimTypes = '';
% start bit encoding with bit 1
iBit = 1;

% store temporarly this empty stimulus vector (in case things get stuck later on)
setData(this, iDWRow, 'stim', 'data', stimVect);
setData(this, iDWRow, 'stim', 'loadStatus', 'partial');
setData(this, iDWRow, 'stim', 'stimTypes', regexprep(stimTypes, '^,', ''));

% if no imaging frames, abort
if ~nFramesImg;
    isValid = false; % set the validity flag to false
    % store the reason why this row was not valid
    unvalidReason = sprintf('no imaging data for row %s %03d (frame number = 0)', rowID, iDWRow);
    return; % abort processing of this row
end;

% get the behavior for this row
behavData = getData(this, iDWRow, 'behavExtr', 'data');

% get all possible textures and sort them
runTypes = get(this, 'all', 'runType');
runTypes(cellfun(@isempty, runTypes)) = [];
textureIDs = unique(runTypes);
textureRoughness = str2double(regexprep(textureIDs, '^P', ''));
[~, sortIndex] = sort(textureRoughness);
textureIDs = textureIDs(sortIndex);

% get frame rate
frameRate = this.an.img.defaultFrameRate;

% get the texture index
textureIndex = find(strcmp(textureIDs, regexprep(behavData.stimulus, 'Texture \d ', '')));

% get the decision
if strcmp(behavData.decision , 'Go');
    decisionIndex = 1;
elseif strcmp(behavData.decision, 'No Response');
    decisionIndex = 2;
elseif strcmp(behavData.decision, 'Inappropriate Response');
    decisionIndex = 3;
elseif strcmp(behavData.decision, 'No Go');
    decisionIndex = 4;
end;

% get texture's stimulus time and frame number
stimStartTimeTexture = behavData.stimulus_time / 1000;
stimStartFrameTexture = round(stimStartTimeTexture * frameRate);
% adjust for skipped frames
stimStartFrameTexture = stimStartFrameTexture - this.an.skipFrame.nFramesBegin;

% get texture's stimulus time and frame number
stimStartTimeLicking = behavData.reward_time / 1000;
stimStartFrameLicking = round(stimStartTimeLicking * frameRate);
% adjust for skipped frames
stimStartFrameLicking = stimStartFrameLicking - this.an.skipFrame.nFramesBegin;

% if no frame found, abort
if isnan(stimStartFrameTexture);
    stimStartFrameTexture = [];
end;
% if no frame found, abort
if isnan(stimStartFrameLicking);
    stimStartFrameLicking = [];
end;

% calculate the number of bits required for encoding 8 states (8 textures)
nMaxStims = 8; nBitsToUse = ceil(log2(nMaxStims));
% get the bit code for each stimulus number
bitCode = zeros(nBitsToUse, 1);
bitCode(:, 1) = bitget(textureIndex, 1 : nBitsToUse);
% encode the bitCode into the stimulus vector
for iBitLoop = 1 : nBitsToUse;
    % annotate with the stimuli with the current bit iteratively
    stimVect(stimStartFrameTexture) = bitset(stimVect(stimStartFrameTexture), iBit, bitCode(iBitLoop, :));
    stimTypes = sprintf('%s,%s', stimTypes, 'text_textType');
    iBit = iBit + 1;
end;
% encode the bitCode into the stimulus vector
for iBitLoop = 1 : nBitsToUse;
    % annotate with the stimuli with the current bit iteratively
    stimVect(stimStartFrameLicking) = bitset(stimVect(stimStartFrameLicking), iBit, bitCode(iBitLoop, :));
    stimTypes = sprintf('%s,%s', stimTypes, 'lick_textType');
    iBit = iBit + 1;
end;


% calculate the number of bits required for encoding 8 states (8 outcomes)
nMaxStims = 8; nBitsToUse = ceil(log2(nMaxStims));
% get the bit code for each stimulus number
bitCode = zeros(nBitsToUse, 1);
bitCode(:, 1) = bitget(decisionIndex, 1 : nBitsToUse);
% encode the bitCode into the stimulus vector
for iBitLoop = 1 : nBitsToUse;
    % annotate with the stimuli with the current bit iteratively
    stimVect(stimStartFrameTexture) = bitset(stimVect(stimStartFrameTexture), iBit, bitCode(iBitLoop, :));
    stimTypes = sprintf('%s,%s', stimTypes, 'text_decision');
    iBit = iBit + 1;
end;
% encode the bitCode into the stimulus vector
for iBitLoop = 1 : nBitsToUse;
    % annotate with the stimuli with the current bit iteratively
    stimVect(stimStartFrameLicking) = bitset(stimVect(stimStartFrameLicking), iBit, bitCode(iBitLoop, :));
    stimTypes = sprintf('%s,%s', stimTypes, 'lick_decision');
    iBit = iBit + 1;
end;


%% saving the stimulus vector
% clean up the stimTypes string
stimTypes = regexprep(regexprep(stimTypes, '^,', ''), ',$', '');

% store the created stimulus vector and the different stimulus types encoding
setData(this, iDWRow, 'stim', 'data', stimVect);
setData(this, iDWRow, 'stim', 'loadStatus', 'full');
setData(this, iDWRow, 'stim', 'stimTypes', regexprep(stimTypes, '^,', ''));



end
