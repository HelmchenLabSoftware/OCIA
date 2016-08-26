function makeMMNexperiment_duration(durVector,f,sf)
% in1 ... duration vector
% in2 ... pure tone frequency (Hz)
% in3 ... sampling frequency

% this file written by Henry Luetcke (hluetck@gmail.com)

% some fixed parameters
duty = 0.5; % duty cycle in s
runs = 2; % no. of runs
% (must be even, half the runs f1 is standard and f2 deviant, other half
% vv)
stims = 100; % no. of stims per run
percS1S2 = [90 10]; % percentages for standard (S1) and deviant (S2)

% check parameters
if rem(runs,2)
    error('Number of runs must be even');
end
if sum(percS1S2) ~= 100
    error('Percentages of standard and deviants must sum to 100');
end
% --> must be integers wrt. stims/runs
for n = 1:length(percS1S2)
    if rem(stims*(percS1S2(n)/100),1)
        error('Number of standard and deviants must be integers');
    end
end

% runs vector with 1 (f1 f2) and 2 (f2 f1)
runsVector = [1 2];
runsVector = repmat(runsVector,1,runs/2);
runsVector = shuffleVector(runsVector);

stimVectorAll = cell(1,length(runsVector));
toneArrayAll = cell(1,length(runsVector));
% process each run
for currentRun = 1:length(runsVector)
%     if runsVector(currentRun) == 1
%         currentVector = durVector;
%     elseif runsVector(currentRun) == 2
%         currentVector = fliplr(durVector);
%     end
    % make stim vector
    stimsS1 = stims*(percS1S2(1)/100);
    stimsS2 = stims*(percS1S2(2)/100);
    stimVector = [repmat(1,1,stimsS1),repmat(2,1,stimsS2)];
    
    while true
        stimVector = shuffleVector(stimVector);
        % ensure first couple of stims are not 2
        nonDeviants = 6;
        if sum(unique(stimVector(1:nonDeviants))) > 1
            continue
        end
        % no adjacent deviants
        adjacentDeviant = 6;
        accept = 1;
        for n = adjacentDeviant+1:length(stimVector)
            if stimVector(n) == 2
                if ~isempty(find(stimVector(n-adjacentDeviant:n-1)==2, 1))
                    accept = 0;
                end
            end
        end
        if accept
            break
        end
    end
    % half of the deviants should be 3
    deviantsIdx = find(stimVector==2);
    if rem(numel(deviantsIdx),2)
       error('Number of deviants must be even.') 
    end
    deviantsIdx = shuffleArray(deviantsIdx);
    deviantsIdx = deviantsIdx(1:(numel(deviantsIdx)/2));
    stimVector(deviantsIdx) = 3;
    
    currentToneArray = MakePureToneArray_duration(durVector,stimVector,f,sf);
    SaveAndAssignInBase(stimVector,sprintf('stimVectorRun%02.0f',currentRun),...
        'AssignOnly');
    SaveAndAssignInBase(currentToneArray,sprintf('toneArrayRun%02.0f',currentRun),...
        'AssignOnly');
    stimVectorAll{currentRun} = stimVector;
    toneArrayAll{currentRun} = currentToneArray;
end
saveName = ['expInfo' datestr(clock,30) '.mat'];
% save(saveName,'stimVectorAll','toneArrayAll');

fprintf('\nFinished\n');


function sRand = shuffleVector(s)
k = randperm(length(s));
sRand = s;
for n = 1:length(k)
    sRand(n) = s(k(n));
end

