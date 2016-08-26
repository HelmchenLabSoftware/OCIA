function [meanPerf,meanPerfShuf,roiLabel] = textureDisc_mvpaSingleSession(S)
% S is a data structure returned by importData_textureDisc

% this file written by Henry Luetcke (hluetck@gmail.com)

comparison = 'GoNogo'; % GoNogo, NogoTexture
leaveOut = 0.1; % fraction to leave out for testing classification
itersTrueLabels = 50;
itersFalseLabels = 50;
classifier = 'naiveBayes'; % libsvm, naiveBayes
dataField = 'dRR'; % 'dRR' or 'reducedGauss1'
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
% treat each Roi separately
for roi = 1:numel(roiLabel)
    roiID = roiLabel{roi};
%        if ~strcmp(roiID,'neuropil'), continue, end % only look at neuropil
%     data = S.(roiLabel{roi}).reduced;
    data = S.(roiLabel{roi}).(dataField);
    if ~isempty(classifyColumns)
        data = data(:,classifyColumns(1):classifyColumns(2));
    end
    % interpolate
    tOrig = 1:size(data,2);
    tInterp = linspace(1,size(data,2),10);
    dataInterp = interp1(tOrig,data',tInterp);
    data = dataInterp';
    
    % classification with true labels
    perf = doClassify(classifier,textureLabels,data,leaveOut,itersTrueLabels);
    meanPerf(roi) = mean(perf);
    sdPerf(roi) = std(perf);
    % with shuffled labels
    perfShuf = zeros(1,itersFalseLabels);
    if doParallel
        parfor n = 1:itersFalseLabels
            labelsShuff = textureLabels(randperm(numel(textureLabels)));
            perfShuf(n) = doClassify(classifier,labelsShuff,data,leaveOut,1);
        end
    else
        for n = 1:itersFalseLabels
            labelsShuff = textureLabels(randperm(numel(textureLabels)));
            perfShuf(n) = doClassify(classifier,labelsShuff,data,leaveOut,1);
        end
    end
    meanPerfShuf(roi) = mean(perfShuf);
    sdPerfShuf(roi) = std(perfShuf);
    % compare performance with true and shuffled labels
    [~,pvalPerf(roi)] = ttest2(perf,perfShuf);
end
pCrit = pCrit ./ numel(roiLabel); % correct for number of comparisons
maxVal = max([max(meanPerf+sdPerf) max(meanPerfShuf+sdPerfShuf)]);
% sort according to meanPerf
[meanPerf,idx] = sort(meanPerf,'descend');
sdPerf = sdPerf(idx);
meanPerfShuf = meanPerfShuf(idx);
sdPerfShuf = sdPerfShuf(idx);
roiLabel = roiLabel(idx);
pvalPerf = pvalPerf(idx);
% plotting
titleStr = sprintf('%s Session %1.0f - %s',animalID,sessionID,comparison);
hFig = figure('Name',titleStr,'NumberTitle','off');
shadedErrorBar(1:numel(meanPerf),meanPerfShuf,sdPerfShuf,'-k',1); hold on
shadedErrorBar(1:numel(meanPerf),meanPerf,sdPerf,'-r',1);
% plot(1:numel(meanPerf),meanPerfShuf+sdPerfShuf,'Color',[0.5 0.5 0.5]), hold on
% % plot(1:numel(meanPerf),meanPerfShuf-sdPerfShuf,'Color',[0.5 0.5 0.5])
% hErr= errorbar(1:numel(meanPerf),meanPerf,sdPerf,'Color','r');
% removeErrorBarEnds(hErr); hold on
% hErr= errorbar(1:numel(meanPerf),meanPerfShuf,sdPerfShuf,'Color','k');
% removeErrorBarEnds(hErr); hold on
roiLabel = strrep(roiLabel,'neuropil','npil');
title(titleStr)
for n = 1:numel(roiLabel)
    if pvalPerf(n) <= pCrit
        scatter(n,maxVal,'bx')
    end
end
set(gca,'xlim',[0.5 numel(meanPerf)+0.5],'xtick',[1:numel(meanPerf)],...
    'xticklabel',roiLabel)
pos = get(gca,'position');
pos(1) = 0.05; pos(3) = 0.9;
set(gca,'Position',pos);
ylabel('Performance +- SD'); makePrettyFigure(hFig); set(gca,'fontsize',9)

% function perf = doClassify(method,labels,data,leaveOut,iters)
% % remove data with NaN trials
% data(isnan(labels),:) = [];
% % remove NaN labels
% labels(isnan(labels)) = [];
% nanRows = find(isnan(sum(data,2)));
% data(nanRows,:) = []; labels(nanRows) = [];
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
%             [post,predicted,logp] = posterior(model,testData);
%             % we can also compute posterior probability for each class:
%             % post = posterior(model,testData);
%             perf(n) = (numel(find(predicted==testLabels))./numel(testLabels)).*100;
%         end
%     otherwise
%         error('Classifier %s not (yet) implemented')
% end










