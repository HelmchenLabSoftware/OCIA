function stimVector = MakeStimVector(stimNo,probs)
% in1 ... total no. of stimuli
% in2 ... vector with probability for each stimulus type (must sum to 1)
% out1 ... stimVector

% this file written by Henry Luetcke (hluetck@gmail.com)

if sum(probs) ~= 1
   error('Stimulus probabilities must sum to 1');
end

stimTypes = numel(probs);

forceEqualStimNo = 1;
% equal number of stims of each type (only applies if all probabilities are
% equal and may cause endless loops)
for n = 2:length(probs)
    if probs(n) ~= probs(n-1)
       forceEqualStimNo = 0;
    end
end

stimVector = [];

stimTypeCount = zeros(1,stimTypes);
for n = 1:stimTypes
    stimTypeCount(n) = stimNo*probs(n);
    stimVector = [stimVector repmat(n,1,stimTypeCount(n))];
end

% permute stimVector
randOrder = randperm(numel(stimVector));

stimVectorRand = zeros(1,numel(stimVector));
for n = 1:length(stimVector)
   stimVectorRand(n) = stimVector(randOrder(n));
end

stimVector = stimVectorRand;