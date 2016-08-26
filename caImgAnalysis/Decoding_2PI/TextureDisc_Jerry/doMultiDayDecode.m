function [perf_true,perf_shuff] = doMultiDayDecode(data,texture,iters)
% run iterative decoding by training with one data set stored in data and
% testing with another data set
% each data set should have at least iters observations

% settings for NaiveBayes classifier
distrib = 'normal';

perf_true = []; perf_shuff = [];
for s1 = 1:numel(data)
    for s2 = 2:numel(data)
        if s2 > s1
            trainData = data{s1};trainLabels = texture{s1};
            trainData(isnan(trainLabels),:) = [];
            trainLabels(isnan(trainLabels),:) = [];
            nanRows = find(isnan(sum(trainData,2)));
            trainData(nanRows,:) = []; trainLabels(nanRows) = [];
            testData = data{s2}; testLabels = texture{s2};
            testData(isnan(testLabels),:) = [];
            testLabels(isnan(testLabels),:) = [];
            nanRows = find(isnan(sum(testData,2)));
            testData(nanRows,:) = []; testLabels(nanRows) = [];
            %             model = NaiveBayes.fit(trainData,trainLabels);
            %             predicted = predict(model,testData);
            %             % we can also compute posterior probability for each class:
            %             % post = posterior(model,testData);
            %             perf_true(pos) = (numel(find(predicted==testLabels))./numel(testLabels)).*100;
            perf1 = zeros(iters,1); perf2 = zeros(iters,1);
            % leave-1-out classification for true labels
            leave1out = randperm(numel(trainLabels));
            if numel(leave1out) > iters   
                leave1out = leave1out(1:iters);
            end
            parfor i = 1:iters
                % true labels
                trainLabels_true = trainLabels; trainData_true = trainData;
                trainLabels_true(leave1out(i)) = [];
                trainData_true(leave1out(i),:) = [];
                model = NaiveBayes.fit(trainData_true,trainLabels_true,...
                    'Distribution',distrib);
                predicted = predict(model,testData);
                % we can also compute posterior probability for each class:
                % post = posterior(model,testData);
                perf1(i) = (numel(find(predicted==testLabels))./numel(testLabels)).*100;
                
                % shuffled labels
                trainLabels_shuf = trainLabels(randperm(numel(trainLabels)));
                model = NaiveBayes.fit(trainData,trainLabels_shuf,...
                    'Distribution',distrib);
                predicted = predict(model,testData);
                % we can also compute posterior probability for each class:
                % post = posterior(model,testData);
                perf2(i) = (numel(find(predicted==testLabels))./numel(testLabels)).*100;
            end
            perf_true = [perf_true; perf1];
            perf_shuff = [perf_shuff; perf2];
        end
    end
end

