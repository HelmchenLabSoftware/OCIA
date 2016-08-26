function perfOut = textureDisc_popDecodeSingleSession(S)
% S is a data structure returned by importData_textureDisc

% this file written by Henry Luetcke (hluetck@gmail.com)

comparison = 'NogoTexture'; % GoNogo, NogoTexture
leaveOut = 0.1; % fraction to leave out for testing classification
itersTrueLabels = 50;
itersFalseLabels = 50;
classifier = 'naiveBayes'; % libsvm, naiveBayes
dataField = 'reducedGauss1'; % 'dRR' or 'reducedGauss1'

classifyColumns = []; % columns for classification (empty for all)

doParallel = 0;
if matlabpool('size')
   doParallel = 1;
end

pCrit = 0.05; % will be corrected for multiple comparisons

animalID = S.info.animal;
sessionID = S.info.session;
rate = S.info.sample_rate;

roiLabel = S.info.roiLabel;

textureLabels = S.info.trialVectors.texture;
switch lower(comparison)
    case 'gonogo'
        textureLabels(textureLabels>1) = 2; % corresponds to Go / Nogo?
    case 'nogotexture'
        % change all 1s to NaN
        textureLabels(textureLabels==1) = NaN;
        textureLabels = textureLabels - 1;
    otherwise
        error('Comparison %s not implemented (yet)',comparison)
end

% roi labels without session ID
roiLabel = sort(strrep(roiLabel,sprintf('%s-%1.0f-',animalID,sessionID),''));
meanPerf = zeros(1,numel(roiLabel));
sdPerf = zeros(1,numel(roiLabel));
meanPerfShuf = zeros(1,numel(roiLabel));
sdPerfShuf = zeros(1,numel(roiLabel));
pvalPerf = zeros(1,numel(roiLabel));
% collect roi data
popData = {}; popDataN = {}; popDataS = {}; popDataM = {};
for roi = 1:numel(roiLabel)
    roiID = roiLabel{roi};
    if strcmp(roiID,'neuropil'), continue, end % exclude neuropil
    data = S.(roiLabel{roi}).(dataField);
    if ~isempty(classifyColumns)
        data = data(:,classifyColumns(1):classifyColumns(2));
    end
    if any(isnan(data(:)))
        continue
    end
    popData{1,length(popData)+1} = data;
    if strcmp(roiID(1:2),'SM')
        continue
    elseif strcmp(roiID(1),'S')
        popDataS{1,length(popDataS)+1} = data;
    elseif strcmp(roiID(1),'M')
        popDataM{1,length(popDataM)+1} = data;
    elseif strcmp(roiID(1),'N')
        popDataN{1,length(popDataN)+1} = data;
    end
end
popData = cell2mat(popData);
popDataS = cell2mat(popDataS);
popDataM = cell2mat(popDataM);
popDataN = cell2mat(popDataN);


% classification with true labels
perf = doClassify(classifier,textureLabels,popData,leaveOut,itersTrueLabels);
meanPerf = mean(perf); sdPerf = std(perf);
perfS = doClassify(classifier,textureLabels,popDataS,leaveOut,itersTrueLabels);
meanPerfS = mean(perfS); sdPerfS = std(perfS);
perfM = doClassify(classifier,textureLabels,popDataM,leaveOut,itersTrueLabels);
meanPerfM = mean(perfM); sdPerfM = std(perfM);
perfN = doClassify(classifier,textureLabels,popDataN,leaveOut,itersTrueLabels);
meanPerfN = mean(perfN); sdPerfN = std(perfN);
% with shuffled labels
perfShuf = zeros(1,itersFalseLabels);
if doParallel
    parfor n = 1:itersFalseLabels
        labelsShuff = textureLabels(randperm(numel(textureLabels)));
        perfShuf(n) = doClassify(classifier,labelsShuff,popData,leaveOut,1);
        perfShufS(n) = doClassify(classifier,labelsShuff,popDataS,leaveOut,1);
        perfShufM(n) = doClassify(classifier,labelsShuff,popDataM,leaveOut,1);
        perfShufN(n) = doClassify(classifier,labelsShuff,popDataN,leaveOut,1);
    end
else
    for n = 1:itersFalseLabels
        labelsShuff = textureLabels(randperm(numel(textureLabels)));
        perfShuf(n) = doClassify(classifier,labelsShuff,popData,leaveOut,1);
        perfShufS(n) = doClassify(classifier,labelsShuff,popDataS,leaveOut,1);
        perfShufM(n) = doClassify(classifier,labelsShuff,popDataM,leaveOut,1);
        perfShufN(n) = doClassify(classifier,labelsShuff,popDataN,leaveOut,1);
    end
end
meanPerfShuf = mean(perfShuf); sdPerfShuf = std(perfShuf);
meanPerfShufS = mean(perfShufS); sdPerfShufS = std(perfShufS);
meanPerfShufM = mean(perfShufM); sdPerfShufM = std(perfShufM);
meanPerfShufN = mean(perfShufN); sdPerfShufN = std(perfShufN);
titleStr = sprintf('%s %02.0f %s',animalID,sessionID,comparison);
hFig = figure('Name',titleStr,'NumberTitle','off');
hErr = errorbar([1 2 3 4],[meanPerf meanPerfS meanPerfM meanPerfN],...
    [sdPerf sdPerfS sdPerfM sdPerfN]); set(hErr,'Marker','s','LineStyle','none');
removeErrorBarEnds(hErr);
hold all
hErr = errorbar([1 2 3 4],[meanPerfShuf meanPerfShufS meanPerfShufM meanPerfShufN],...
    [sdPerfShuf sdPerfShufS sdPerfShufM sdPerfShufN]);
set(hErr,'Marker','o','LineStyle','none'); removeErrorBarEnds(hErr);
set(gca,'xlim',[0.5 4.5],'xtick',[1 2 3 4],'xticklabel',{'All','S','M','N'})
ylabel('% correct +- SD'), legend({'True' 'Shuff'}), title(titleStr)
makePrettyFigure(hFig);
saveas(hFig,strrep(titleStr,' ','_'))


% output
perfOut = [meanPerf meanPerfS meanPerfM meanPerfN];


% function perf = doClassify(method,labels,data,leaveOut,iters)
% % remove data with NaN trials
% data(isnan(labels),:) = [];
% % remove NaN labels
% labels(isnan(labels)) = [];
% switch lower(method)
%     case 'libsvm'
%         % use libsvm package
%         % http://www.csie.ntu.edu.tw/~cjlin/libsvm/
%         perf = zeros(1,iters);
%         leaveOut = round(numel(labels).*leaveOut);
%         for n = 1:iters
%             leaveOutIdx = randperm(numel(labels));
%             leaveOutIdx = leaveOutIdx(1:leaveOut);
%             testLabels = labels(leaveOutIdx);
%             testData = data(leaveOutIdx,:);
%             trainLabels = labels; trainLabels(leaveOutIdx) = [];
%             trainData = data; trainData(leaveOutIdx,:) = [];
%             model = svmtrain(trainLabels,trainData);
%             [~,accuracy] = svmpredict(testLabels,testData,model);
%             perf(n) = accuracy(1);
%         end
%     case 'naivebayes'
%         perf = zeros(1,iters);
%         leaveOut = round(numel(labels).*leaveOut);
%         for n = 1:iters
%             leaveOutIdx = randperm(numel(labels));
%             leaveOutIdx = leaveOutIdx(1:leaveOut);
%             testLabels = labels(leaveOutIdx);
%             testData = data(leaveOutIdx,:);
%             trainLabels = labels; trainLabels(leaveOutIdx) = [];
%             trainData = data; trainData(leaveOutIdx,:) = [];
%             model = NaiveBayes.fit(trainData,trainLabels,...
%                 'Distribution','normal');
%             predicted = predict(model,testData);
%             % we can also compute posterior probability for each class:
%             % post = posterior(model,testData);
%             perf(n) = (numel(find(predicted==testLabels))./numel(testLabels)).*100;
%         end
%     otherwise
%         error('Classifier %s not (yet) implemented')
% end










