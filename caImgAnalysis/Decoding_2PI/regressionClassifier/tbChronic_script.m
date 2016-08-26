function [mseTrue,mseShuf] = tbChronic_script(S1,S2)
% S1 ... session 1 data structure (train data)
% S2 ... session 2 data structure (test data)

% setup train data
dff = S1.dff;
trainData = cell(S1.trials,S1.neurons);
trainStim = cell(S1.trials,1);
for t = 1:S1.trials
    trainStim{t} = S1.stimA';
    for n = 1:S1.neurons
        trainData{t,n} = dff{t}(n,:)';
    end
end

% setup test data
dff = S2.dff;
testData = cell(S2.trials,S2.neurons);
testStim = cell(S2.trials,1);
for t = 1:S2.trials
    testStim{t} = S2.stimA';
    for n = 1:S2.neurons
        testData{t,n} = dff{t}(n,:)';
    end
end

% run classification
[mseTrue,mseShuf] = treeBaggerClassifierTrainTest(trainData,testData,trainStim,testStim);
% plot results
for n = 1:numel(mseTrue)
    finalmeanMSEtrue(1,n) = mean(mseTrue{n}(:,end));
    finalsdMSEtrue(1,n) = std(mseTrue{n}(:,end));
    finalmeanMSEshuf(1,n) = mean(mseShuf{n}(:,end));
    finalsdMSEshuf(1,n) = std(mseShuf{n}(:,end));
end

hErr = errorbar(1:numel(mseTrue),finalmeanMSEtrue,finalsdMSEtrue,'-rs'); hold on
removeErrorBarEnds(hErr);
hErr = errorbar(1:numel(mseTrue),finalmeanMSEshuf,finalsdMSEshuf,'-ko');
removeErrorBarEnds(hErr);