%% #OCIA:AN:OCIA_genStimVect_fromMicrAnalogIn
function [isValid, unvalidReason] = OCIA_genStimVect_noStim(this, iDWRow, varargin)

isValid = true; % by default, the row is valid
unvalidReason = ''; % by default no reason

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

% store the extracted items: stimulus vector
setData(this, iDWRow, 'stim', 'data', stimVect);
setData(this, iDWRow, 'stim', 'loadStatus', 'full');
setData(this, iDWRow, 'stim', 'stimTypes', '');

end
