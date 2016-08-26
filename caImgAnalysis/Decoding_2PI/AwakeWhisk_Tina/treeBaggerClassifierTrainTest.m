function [mseTrue, mseShuf] = treeBaggerClassifierTrainTest(neuronTrain,neuronTest,stimTrain,stimTest)
% in this file, train and test data sets are explicitely specified (e.g. for chronic analysis across
% sessions)
% neuronTrain ... trial x neuron cell array of training calcium data
% neuronTest ... trial x neuron cell array of testing calcium data
% the number of neurons MUST be identical in train and test data
% stimTrain ... trial x 1 cell array of stimulus data for each trial (same number of trials as in
% neuronTrain)
% stimTest ... trial x 1 cell array of stimulus data for each trial (same number of trials as in
% neuronTest)

maxNeurons = inf; % save time during debug

% hold-out a certain fraction of data on multiple iterations
holdOutF = 0.2;

iter = 5; % number of iterations with different hold outs --> error bars on predictions

% options for treebagger
opts = statset('UseParallel','always');

ntrees = 30;
regressionMethod = 'bag'; % 'lsboost' or 'bag'

neurons = size(neuronTrain,2);

if size(neuronTest,2) ~= neurons
   error('Must have the same number of neurons in train and test data sets!') 
end

trialsTrain = size(neuronTrain,1);
trialsTest = size(neuronTest,1);

if maxNeurons < neurons
   neurons = maxNeurons;
end

% concatenate predictors and response data
% predictors X ... activity of different neurons (or same neuron at different lags)
% response data Y ... the parameter to be explained by the neural activity (e.g. whisk vector)
Xtrain = []; Xtest = [];
Ytrain = []; Ytest = [];
for n = 1:neurons
    vTrain = []; vTest = [];
    for t = 1:trialsTrain
        % TODO: perhaps high-pass filter of predictors and response data
        if n == 1
           Ytrain = [Ytrain; stimTrain{t}];
        end
        vTrain = [vTrain; neuronTrain{t,n}];
    end
    for t = 1:trialsTest
        if n == 1
           Ytest = [Ytest; stimTest{t}];
        end
        vTest = [vTest; neuronTest{t,n}];
    end
    Xtrain = [Xtrain, vTrain];
    Xtest = [Xtest, vTest];
end

warning('off','all')

%% Population prediction
[mseTruePop,mseShufPop] = doClassify(Xtrain,Xtest,Ytrain,Ytest,ntrees,regressionMethod,holdOutF,opts,iter);

% figure('Name','Population Prediction');
% hErr = errorbar(nanmean(lossTrue),std(lossTrue),'r');
% removeErrorBarEnds(hErr); hold on
% hErr = errorbar(nanmean(lossShuf),std(lossShuf),'k'); removeErrorBarEnds(hErr);
% xlabel('Number of trees'); ylabel('Test classification MSE +- SD');
% title(regressionMethod)
% legend({'True','Shuffled'})

% mseTrue = lossTrue(:,end); mseShuf = lossShuf(:,end);
% 
% dPrimePop = ((nanmean(mseShuf)-nanmean(mseTrue))) ./ ...
%         sqrt((nanvar(mseShuf)+nanvar(mseTrue))./2);

plotSingleNeuron = 0;
%% Single-neuron prediction
dPrimeSingleCell = zeros(1,neurons);
for n = 1:neurons
    currentXtrain = Xtrain(:,n); currentXtest = Xtest(:,n);
    [mseTrue{n},mseShuf{n}] = doClassify(currentXtrain,currentXtest,Ytrain,Ytest,ntrees,...
        regressionMethod,holdOutF,opts,iter);
%     mseTrue = lossTrue(:,end); mseShuf = lossShuf(:,end);
%     dPrimeSingleCell(n) = ((nanmean(mseShuf)-nanmean(mseTrue))) ./ ...
%         sqrt((nanvar(mseShuf)+nanvar(mseTrue))./2);
%     if plotSingleNeuron
%         figure('Name',sprintf('Prediction Neuron %1.0f',n));
%         hErr = errorbar(nanmean(lossTrue),std(lossTrue),'r');
%         removeErrorBarEnds(hErr); hold on
%         hErr = errorbar(nanmean(lossShuf),std(lossShuf),'k'); removeErrorBarEnds(hErr);
%         xlabel('Number of trees'); ylabel('Test classification MSE +- SD');
%         title(sprintf('Prediction Neuron %1.0f - %s',n,regressionMethod))
%         legend({'True','Shuffled'})
%     end
end
% dprime = [dPrimeSingleCell, dPrimePop];

mseTrue{n+1} = mseTruePop; mseShuf{n+1} = mseShufPop;

warning('on','all')

end


function [lossTrue,lossShuf] = doClassify(Xtrain,Xtest,Ytrain,Ytest,ntrees,method,holdOutF,opts,iter)

for i = 1:iter
    
    % shuffling
    YtrainShuff = Ytrain(randperm(numel(Ytrain)));
    YtestShuff = Ytest(randperm(numel(Ytest)));
    
    cvpartTrain = cvpartition(Ytrain,'holdout',holdOutF);
    cvpartTest = cvpartition(Ytest,'holdout',holdOutF);
    
    % select data used for training
    currentXtrain = Xtrain(training(cvpartTrain),:);
    currentYtrain = Ytrain(training(cvpartTrain),:);
    
    % testing is done on the larger fraction of cvpartTest holdouts, i.e. the training fraction
    currentXtest = Xtest(training(cvpartTest),:);
    currentYtest = Ytest(training(cvpartTest),:);
    
    % select shuffled data
    currentYtrainShuf = YtrainShuff(training(cvpartTrain),:);
    currentYtestShuf = YtestShuff(training(cvpartTest),:);
    
    switch method
        case 'bag'
            modelTrue = TreeBagger(ntrees,currentXtrain,currentYtrain,...
                'Method','regression','Options',opts);
            modelShuf = TreeBagger(ntrees,currentXtrain,currentYtrainShuf,...
                'Method','regression','Options',opts);
            lossTrue(i,:) = error(modelTrue,currentXtest,currentYtest,'mode','cumulative');
            lossShuf(i,:) = error(modelShuf,currentXtest,currentYtestShuf,'mode','cumulative');
        case 'lsboost'
            modelTrue = fitensemble(currentXtrain,currentYtrain,method,ntrees,'Tree',...
                'type','regression');
            modelShuf = fitensemble(currentXtrain,currentYtrainShuf,method,ntrees,'Tree',...
                'type','regression');
            lossTrue(i,:) = loss(modelTrue,currentXtest,currentYtest,'mode','cumulative');
            lossShuf(i,:) = loss(modelShuf,currentXtest,currentYtestShuf,'mode','cumulative');
    end
end
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
end

%% Function - Statistical comparison of true and shuffled rmse
function p = doStats(a,b)
% use a bootstrap approach to test if a-b < 0
% this is a one-tailed test
d = a-b;
% mean_boot = bootstrp(samples,@mean,d);
% sd_boot = bootstrp(samples,@std,d);
% p = 1 - normcdf(0,mean(mean_boot),mean(sd_boot));

% or a plain t-test
[~,p] = ttest(a,b,0.05,'left');
end

function out=uniqueCombinations(choicevec,choose)
% stolen from mapping toolbox function COMBNTNS
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
end



