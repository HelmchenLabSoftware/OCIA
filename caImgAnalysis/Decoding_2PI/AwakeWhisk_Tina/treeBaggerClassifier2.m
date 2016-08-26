function varargout = treeBaggerClassifier2(neuronData,stimData)
% neuronData ... trial x neuron cell array of calcium data
% each calcium timeseries must be column vector
% stimData ... trial x 1 cell array of stimulus data for each trial
% stim vector must be at frame rate and column vector

f = 7.81;

maxTrials = Inf; % only a subset to save time
maxNeurons = Inf;

% hold-out a certain fraction of data for testing
holdOutF = 0.2; % e.g. 80% used for training

% iter = 10; % number of iterations with different hold outs --> error bars on predictions

% options for treebagger
opts = statset('UseParallel','always');

ntrees = 30;
regressionMethod = 'bag'; % 'lsboost' or 'bag'

neurons = size(neuronData,2);
trials = size(neuronData,1);

if maxNeurons < neurons
   neurons = maxNeurons;
end

if maxTrials < trials
   trials = maxTrials;
end

% concatenate predictors and response data
% predictors X ... activity of different neurons (or same neuron at different lags)
% response data Y ... the parameter to be explained by the neural activity (e.g. whisk vector)
X = []; Y = [];
for n = 1:neurons
    v = [];
    for t = 1:trials
        % TODO: perhaps high-pass filter of predictors and response data
        if n == 1
            Y = [Y; preprocVector(stimData{t})];
        end
        v = [v; preprocVector(neuronData{t,n})];
    end
    X = [X, v];
end

warning('off','all')

%% Population prediction
[lossTrue,lossShuf,modelTrue,modelShuf] = doClassify(X,Y,ntrees,regressionMethod,holdOutF,opts);

% predicted responses
Ypredict = oobPredict(modelTrue);

% plot predictions on trial 1 (really should not be included in training)
neuronData_trial1 = cell2mat(neuronData(1,:));
for n = 1:size(neuronData_trial1,2)
    neuronData_trial1(:,n) = preprocVector(neuronData_trial1(:,n));
end
stimData_trial1 = preprocVector(stimData{1});
stimData_predict_true = predict(modelTrue,neuronData_trial1);
stimData_predict_shuf = predict(modelShuf,neuronData_trial1);
t = (1:numel(stimData_trial1))./f;
figure
plot(t,stimData_trial1,'k'), hold on
plot(t,stimData_predict_true,'r')
legend({'Whisk','Predicted'})
xlabel('Time / s')

warning('on','all')

varargout{1} = lossTrue(end);
varargout{2} = lossShuf(end);


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
% 
% plotSingleNeuron = 0;
% %% Single-neuron prediction
% dPrimeSingleCell = zeros(1,size(X,2));
% for n = 1:size(X,2)
%     [lossTrue,lossShuf] = doClassify(X(:,n),Y,ntrees,regressionMethod,holdOutF,opts,iter);
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
% end
% dprime = [dPrimeSingleCell, dPrimePop];



end

function v = preprocVector(v)

% high-pass filter
% p = polyfit([1:numel(v)]',v,2);
% v = v - polyval(p,[1:numel(v)]');

% low-pass filter
v = sgolayfilt(v,2,5);

v = ScaleToMinMax(v,0,1);


end

function [lossTrue,lossShuf,modelTrue,modelShuf] = doClassify(X,Y,ntrees,regressionMethod,holdOutF,opts)

% cvpart = cvpartition(Y,'holdout',holdOutF);
% Xtrain = X(training(cvpart),:);
% Ytrain = Y(training(cvpart),:);
% Xtest = X(test(cvpart),:);
% Ytest = Y(test(cvpart),:);
% 
Yshuff = Y(randperm(numel(Y)));
% YtrainShuff = Yshuff(training(cvpart),:);
% YtestShuff = Yshuff(test(cvpart),:);

% treebagger needs no hold-out (get errors from out-of-bag classifications)
modelTrue = TreeBagger(ntrees,X,Y,...
    'Method','regression','Options',opts,'minleaf',1,'oobpred','on');
modelShuf = TreeBagger(ntrees,X,Yshuff,...
    'Method','regression','Options',opts,'minleaf',1,'oobpred','on');
lossTrue = error(modelTrue,X,Y,'mode','cumulative');
lossShuf = error(modelShuf,X,Y,'mode','cumulative');

% switch regressionMethod
%     case 'bag'
%         modelTrue = TreeBagger(ntrees,Xtrain,Ytrain,...
%             'Method','regression','Options',opts,'minleaf',1,'oobpred','on');
%         modelShuf = TreeBagger(ntrees,Xtrain,YtrainShuff,...
%             'Method','regression','Options',opts,'minleaf',1,'oobpred','on');
%         lossTrue = error(modelTrue,Xtest,Ytest,'mode','cumulative');
%         lossShuf = error(modelShuf,Xtest,YtestShuff,'mode','cumulative');
%     case 'lsboost'
%         modelTrue = fitensemble(Xtrain,Ytrain,regressionMethod,ntrees,'Tree',...
%             'type','regression');
%         modelShuf = fitensemble(Xtrain,YtrainShuff,regressionMethod,ntrees,'Tree',...
%             'type','regression');
%         lossTrue = loss(modelTrue,Xtest,Ytest,'mode','cumulative');
%         lossShuf = loss(modelShuf,Xtest,YtestShuff,'mode','cumulative');
% end

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



