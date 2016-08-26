function makeOmittedStimExperimentNoise(fCellArray,sf)
% fCellArray ... {[lower1 upper1],[lower2 upper2]}
% sf ... sampling frequency
% if f2 = 0, this will create an omitted stimulus paradigm

% this file written by Henry Luetcke (hluetck@gmail.com)

% some fixed parameters
dur = 0.2; % tone duration in s
runs = 10; % no. of runs
% (must be even, half the runs f1 is standard and f2 deviant, other half
% vv)
stims = 100; % no. of stims per run
percS1S2 = [90 10]; % percentages for standard (S1) and deviant (S2)

standardBetweenDeviant = 6; % this is the min. number of standard tones 
% between deviants (also the number of standards at start and end of 
% experiment) 

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
if ~fCellArray{2}
   runsVector = ones(size(runsVector));
end

stimVectorAll = cell(1,length(runsVector));
toneArrayAll = cell(1,length(runsVector));
% process each run
for currentRun = 1:length(runsVector)
    if runsVector(currentRun) == 1
        currentfCell = fCellArray;
    elseif runsVector(currentRun) == 2
        currentfCell = fliplr(fCellArray);
    end
    % make stim vector
    stimsS1 = stims*(percS1S2(1)/100);
    stimsS2 = stims*(percS1S2(2)/100);
    stimVector = [repmat(1,1,stimsS1),repmat(2,1,stimsS2)];
    
    while true
        stimVector = shuffleVector(stimVector);
        
        % min. number of standards at start and end
        if sum(unique(stimVector(1:standardBetweenDeviant))) > 1
            continue
        end
        if sum(unique(stimVector(end-standardBetweenDeviant+1:end))) > 1
            continue
        end
        
        accept = 1;
        for n = standardBetweenDeviant+1:length(stimVector)
            if stimVector(n) == 2
                if ~isempty(find(stimVector(n-standardBetweenDeviant:n-1)==2, 1))
                    accept = 0;
                end
            end
        end
        if accept
            break
        end
    end
    currentToneArray = MakeNoiseToneArray(currentfCell,stimVector,dur,sf);
%     SaveAndAssignInBase(stimVector,sprintf('stimVectorRun%02.0f',currentRun),...
%         'AssignOnly');
%     SaveAndAssignInBase(currentToneArray,sprintf('toneArrayRun%02.0f',currentRun),...
%         'AssignOnly');
    stimVectorAll{currentRun} = stimVector;
    toneArrayAll{currentRun} = currentToneArray;
end
saveName = ['expInfo' datestr(clock,30) '.mat'];
save(saveName,'stimVectorAll','toneArrayAll','fCellArray','sf');
evalStr = sprintf('load %s',saveName);
evalin('base',evalStr)

fprintf('\nFinished\n');


function sRand = shuffleVector(s)
k = randperm(length(s));
sRand = s;
for n = 1:length(k)
    sRand(n) = s(k(n));
end

