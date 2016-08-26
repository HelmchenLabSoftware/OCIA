function [rmse_true,rmse_shuf] = regressionClassifier(S)
% S ... output of simulateSpikesCalcium

ntrees = 32; % number of trees in forest

% t = (1./S.dffRate:1./S.dffRate:S.tMax)';

stim = S.stimA';
neurons = size(S.spikes,2);
trials = numel(S.dff);

trials = 10; % only a subset to save time

% options for treebagger
opts = statset('UseParallel','always');

rmse_true = zeros(trials,neurons);
rmse_shuf = zeros(trials,neurons);
for n = 1:neurons
    fprintf('\nNeuron %1.0f\nModulation: %1.0f\n',n,S.stimModulation(n))
    % classify by leaving out 1 trial and use it for cross-validation
    for m = 1:trials
        fprintf('Trial %1.0f / %1.0f\n',m,trials)
        leaveOutDff = S.dff{m}(n,:)';
        trainDff = []; stimTrain = repmat(stim,trials-1,1);
        for trainTrial = 1:trials
            if trainTrial == m
                continue
            end
            trainDff = [trainDff; S.dff{trainTrial}(n,:)'];
        end
        % build tree with training data / true labels
        rtree = TreeBagger(ntrees,trainDff,stimTrain,...
            'Method','regression','Options',opts);
        % predict with left out trial
        stimPredict = predict(rtree,leaveOutDff);
        % compute rmse with stim
        rmse_true(m,n) = mean(sqrt((stimPredict-stim).^2));
        
        % build tree with training data / shuffled labels
        stimTrain = stimTrain(randperm(numel(stimTrain)));
        rtree = TreeBagger(ntrees,trainDff,stimTrain,...
            'Method','regression');
        % predict with left out trial
        stimPredict = predict(rtree,leaveOutDff);
        % compute rmse with stim
        rmse_shuf(m,n) = mean(sqrt((stimPredict-stim).^2));
    end
end

hErr = errorbar([1:neurons],mean(rmse_true),std(rmse_true),'r');
removeErrorBarEnds(hErr); hold on
hErr = errorbar([1:neurons],mean(rmse_shuf),std(rmse_shuf),'k');
removeErrorBarEnds(hErr);
set(gca,'xtick',[1:neurons],'xticklabel',S.stimModulation)
ylabel('RMSE'),xlabel('Stimulus modulation')
legend({'true labels','shuffled labels'})







