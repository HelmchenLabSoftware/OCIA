function [rmse_true,rmse_shuf,pVal] = ...
    treeBaggerClassifier(neuronData,stimData)
% neuronData ... trial x neuron cell array of calcium data
% each calcium timeseries must be column vector
% stimData ... trial x 1 cell array of stimulus data for each trial
% stim vector must be at frame rate and column vector

ntrees = 32; % number of trees in forest
bootSamples = 100; % number of bootstrap samples for comparing true and shuffled rmse
doPlot = 1; % plot classifier performance?

neurons = size(neuronData,2);
trials = size(neuronData,1);
% trials = 10; % only a subset to save time
% neurons = 5;

leaveOutTrials = 2; % how many trials to leave out
maxCrossVals = 100; % max. number of cross-validations

leaveOut = uniqueCombinations(1:trials,leaveOutTrials);
if size(leaveOut,1) > maxCrossVals
    fprintf('\nRandomly selecting %1.0f out of %1.0f cross-validations!',...
        maxCrossVals,size(leaveOut,1))
    idx = randperm(size(leaveOut,1));
    leaveOut = leaveOut(idx(1:maxCrossVals),:);
end

sgolayOrder = 1;
sgolaySpan = 5; % in frames
frameShift = [-20:2:20];
frameShift(frameShift==0) = [];

% options for treebagger
opts = statset('UseParallel','always');

rmse_true = zeros(trials,neurons);
rmse_shuf = zeros(trials,neurons);
pVal = zeros(1,neurons);
for n = 1:neurons
    fprintf('\nNeuron %1.0f\n',n)
    % classify by leaving out trials and use them for cross-validation
    for m = 1:size(leaveOut,1)
        trainCa = []; trainStim = [];
        testCa = []; testStim = [];
        for t = 1:trials
            currentCa = neuronData{t,n};
            currentStim = stimData{t};
            currentCa = sgolayfilt(currentCa,sgolayOrder,sgolaySpan);
            [currentCa,currentStim] = ...
                shiftFrames(currentCa,currentStim,frameShift);
            if isempty(find(leaveOut(m,:)==t,1))
                % training trial
                trainCa = [trainCa; currentCa];
                trainStim = [trainStim; currentStim];
            else
                % test trial
                testCa = [testCa; currentCa];
                testStim = [testStim; currentStim];
            end
        end
        % build tree with training data / true labels
        rtree = TreeBagger(ntrees,trainCa,trainStim,...
            'Method','regression','Options',opts);
        % predict with left out trial
        stimPredict = predict(rtree,testCa);
        % compute rmse with stim
        rmse_true(m,n) = mean(sqrt((stimPredict-testStim).^2));
        
        % build tree with training data / shuffled labels
        trainStim = trainStim(randperm(numel(trainStim)));
        rtree = TreeBagger(ntrees,trainCa,trainStim,...
            'Method','regression','Options',opts);
        % predict with left out trial
        stimPredict = predict(rtree,testCa);
        % compute rmse with stim
        rmse_shuf(m,n) = mean(sqrt((stimPredict-testStim).^2));
    end
    % statistical comparison of performance with true and shuffled labels
    pVal(n) = doStats(rmse_true(:,n),rmse_shuf(:,n),bootSamples);
end




if doPlot
    hErr = errorbar([1:neurons],mean(rmse_true),std(rmse_true),'r');
    removeErrorBarEnds(hErr); hold on
    hErr = errorbar([1:neurons],mean(rmse_shuf),std(rmse_shuf),'k');
    removeErrorBarEnds(hErr);
    set(gca,'xtick',[1:neurons],'xticklabel',[1:neurons])
    ylabel('RMSE'),xlabel('Neuron')
    legend({'true labels','shuffled labels'})
end

%% Function - shift frames to create additional variables
function [Xout,stim] = shiftFrames(X,stim,shift)
Xout = X;
for n = 1:numel(shift)
    Xnew = circshift(X,shift(n));
    Xout = [Xout Xnew];
end
if min(shift) < 0
    Xout(end+min(shift)+1,:) = [];
    stim(end+min(shift)+1,:) = [];
end
if max(shift) > 0
   Xout(1:max(shift),:) = [];
   stim(1:max(shift),:) = [];
end

%% Function - Statistical comparison of true and shuffled rmse
function p = doStats(a,b,samples)
% use a bootstrap approach to test if a-b < 0
% this is a one-tailed test
d = a-b;
% mean_boot = bootstrp(samples,@mean,d);
% sd_boot = bootstrp(samples,@std,d);
% p = 1 - normcdf(0,mean(mean_boot),mean(sd_boot));

% or a plain t-test
[~,p] = ttest(a,b,0.05,'left');


function out=uniqueCombinations(choicevec,choose)
% from mapping toolbox function COMBNTNS
choicevec = choicevec(:);       %  Enforce a column vector
choices=length(choicevec);
%  If the number of choices and the number to choose
%  are the same, choicevec is the only output.
if choices==choose(1)
	out=choicevec';
%  If being chosen one at a time, return each element of
%  choicevec as its own row
elseif choose(1)==1
	out=choicevec;
%  Otherwise, recur down to the level at which one such
%  condition is met, and pack up the output as you come out of
%  recursion.
else
	out = [];
	for i=1:choices-choose(1)+1
		tempout=uniqueCombinations(choicevec(i+1:choices),choose(1)-1);
		out=[out; choicevec(i)*ones(size(tempout,1),1)	tempout];
	end
end




