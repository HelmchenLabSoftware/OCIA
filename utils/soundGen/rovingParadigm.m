function stimOut = rovingParadigm(stim1,stim2)
% stim1 ... number of stimuli to generate
% stim2 ... number of unique stimuli

% this file written by Henry Luetcke (hluetck@gmail.com)

% probability of number of same stims (should sum to 1)
probSameStims = [ ...
    3 0.1; ...
    4 0.1; ...
    5 0.2; ...
    6 0.3; ...
    7 0.2; ...
    8 0.1 ...
    ];

stimTypeVector = 1:stim2;

sameStimVector = [];
for n = 1:size(probSameStims,1)
    val = probSameStims(n,1);
    count = probSameStims(n,2).*10;
    sameStimVector = [sameStimVector repmat(val,1,count)];
end

stimOut = zeros(1,stim1); pos = 1;

previousStim = 0;
while pos <= stim1
    % determine new stim
    while true
        idx = randperm(stim2);
        currentStim = idx(1);
        if currentStim ~= previousStim
            previousStim = currentStim;
            break
        end
    end
    idx = randperm(numel(sameStimVector));
    currentStimNo = sameStimVector(idx(1));
    stimOut(pos:pos+currentStimNo-1) = currentStim;
    pos = pos + currentStimNo;
end

if numel(stimOut) > stim1
   stimOut(stim1+1:end) = [];
end

% compute counts for each stimulus
for n = 1:stim2
    count = length(find(stimOut==n));
    fprintf('Stim %1.0f: %1.0f (%1.2f)\n',n,count,...
        count/numel(stimOut));
end




