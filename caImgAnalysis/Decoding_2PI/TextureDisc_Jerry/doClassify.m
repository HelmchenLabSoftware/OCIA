function perf = doClassify(method,labels,data,leaveOut,iters)
% remove data with NaN trials
data(isnan(labels),:) = [];
% remove NaN labels
labels(isnan(labels)) = [];
nanRows = find(isnan(sum(data,2)));
data(nanRows,:) = []; labels(nanRows) = [];
switch lower(method)
    case 'libsvm'
        % use libsvm package
        % http://www.csie.ntu.edu.tw/~cjlin/libsvm/
        perf = zeros(1,iters);
        leaveOut = round(numel(labels).*leaveOut);
        for n = 1:iters
            leaveOutIdx = randperm(numel(labels));
            leaveOutIdx = leaveOutIdx(1:leaveOut);
            testLabels = labels(leaveOutIdx);
            testData = data(leaveOutIdx,:);
            trainLabels = labels; trainLabels(leaveOutIdx) = [];
            trainData = data; trainData(leaveOutIdx,:) = [];
            model = svmtrain(trainLabels,trainData);
            [~,accuracy] = svmpredict(testLabels,testData,model);
            perf(n) = accuracy(1);
        end
    case 'naivebayes'
        perf = zeros(1,iters);
        leaveOut = round(numel(labels).*leaveOut);
        for n = 1:iters
            leaveOutIdx = randperm(numel(labels));
            leaveOutIdx = leaveOutIdx(1:leaveOut);
            testLabels = labels(leaveOutIdx);
            testData = data(leaveOutIdx,:);
            trainLabels = labels; trainLabels(leaveOutIdx) = [];
            trainData = data; trainData(leaveOutIdx,:) = [];
            model = NaiveBayes.fit(trainData,trainLabels,...
                'Distribution','normal');
            [post,predicted,logp] = posterior(model,testData);
            % we can also compute posterior probability for each class:
            % post = posterior(model,testData);
            perf(n) = (numel(find(predicted==testLabels))./numel(testLabels)).*100;
        end
    otherwise
        error('Classifier %s not (yet) implemented')
end
