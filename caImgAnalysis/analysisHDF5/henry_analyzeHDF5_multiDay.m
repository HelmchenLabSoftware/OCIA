function S = henry_analyzeHDF5_multiDay(id, config)
% id ... date string for the HDF5 file (e.g. 14011001) or Matlab structure from previous run

% ADD ANALYSIS OF DECODING WITH LABELING OF WHICH PHASE IT IS ('NAIVE', 'LEARNING', 'EXPERT')
% SEE IF TRAINING DATA SET ON EXPERT CAN ALSO PREDICT IN LEARNING

% TRY TO PREDICT DPRIME FROM ACTVITY

if ~isstruct(id)
    fileName = sprintf('%s.h5',id);
    animalID = sprintf('mou_bl_%s_%s',id(1:6),id(7:8));
    datasetID = ['/' animalID];
    % load HDF5 and convert to data structure
    S = loadDataFromHDF5(fileName,datasetID);
else
    S = id;
end
clear id;

fieldsSpots = fieldnames(S);
spotFound = 0;
for n = 1:numel(fieldsSpots) % loop over spots
    spotID = fieldsSpots{n};
    if ~strcmp(spotID,config.spotID)
        continue
    else
        spotFound = 1;
        currentSpot = S.(fieldsSpots{n});
        break
    end
end
if ~spotFound
    error('Did not find %s', config.spotID)
end

fieldsDays = fieldnames(currentSpot);
if numel(fieldsDays) < 2
    warning('Need at least 2 days for multi-day analysis. Skipping ...')
    S = [];
    return
end

if config.doCorr
    titleStr = sprintf('%s %s MultiDay Correlation',animalID,spotID);
    hCorr = figure('Name',titleStr,'NumberTitle','off');
end
if config.doDecode
    titleStr = sprintf('%s %s MultiDay Decode',animalID,spotID);
    hDecode = figure('Name',titleStr,'NumberTitle','off');
end
splot_pos = 1;
for n = 2:numel(fieldsDays)
    dateID1 = strrep(fieldsDays{n-1},'x','');
    dateID2 = strrep(fieldsDays{n},'x','');
    S_day1 = currentSpot.(fieldsDays{n-1});
    S_day2 = currentSpot.(fieldsDays{n});
    % match RoiSets
    roiID_day1 = S_day1.ROISets.(cell2mat(fieldnames(S_day1.ROISets))).ROISet(:,1);
    roiID_day2 = S_day2.ROISets(cell2mat(fieldnames(S_day1.ROISets))).ROISet(:,1);
    matchIx = zeros(1,2); pos = 1;
    for m1 = 1:numel(roiID_day1)
        if strcmpi(roiID_day1{m1},'npil')
            continue
        end
        for m2 = 1:numel(roiID_day2)
            if strcmpi(roiID_day1{m1},roiID_day2{m2})
                matchIx(pos,1:2) = [m1,m2]; pos = pos + 1;
            end
        end
    end
    roiID = roiID_day1(matchIx(:,1));
    fprintf('\n%s - %s: %1.0f matching Rois\n',dateID1,dateID2,pos-1)
    [caTracesMean_day1, caTracesTrials_day1, tPs] = doSingleDayAnalysis(S_day1,config);
    [caTracesMean_day2, caTracesTrials_day2] = doSingleDayAnalysis(S_day2,config);
    % Correlation analysis
    if config.doCorr
        [corrMatch, corrNonMatchDiffDay, corrNonMatchSameDay] = ...
            doMultiDayCorrelationAnalysis(caTracesMean_day1,caTracesMean_day2,matchIx);
        figure(hCorr)
        % plot target
        subplot(numel(fieldsDays)-1,2,splot_pos); splot_pos = splot_pos + 1;
        [f,x] = ecdf(corrNonMatchDiffDay{1});
        stairs(x,f,'k'), hold on
        [f,x] = ecdf(corrNonMatchSameDay{1});
        stairs(x,f,'b'), hold on
        [f,x] = ecdf(corrMatch{1});
        stairs(x,f,'r'), hold on
        legend({'NMatch Diff Day','NMatch Same Day','Match'},'location','northwest')
        xlabel('r'), ylabel('cumulative F')
        title(sprintf('%s - %s Target',dateID1,dateID2),'interpreter','none')
        % plot distractor
        subplot(numel(fieldsDays)-1,2,splot_pos); splot_pos = splot_pos + 1;
        [f,x] = ecdf(corrNonMatchDiffDay{2});
        stairs(x,f,'k'), hold on
        [f,x] = ecdf(corrNonMatchSameDay{2});
        stairs(x,f,'b'), hold on
        [f,x] = ecdf(corrMatch{2});
        stairs(x,f,'r'), hold on
        xlabel('r'), ylabel('cumulative F')
        title(sprintf('%s - %s Distractor',dateID1,dateID2),'interpreter','none')
    end
    % Decoding analysis
    if config.doDecode
        [perfTrue, perfShuf] = doMultiDayDecode(caTracesTrials_day1,...
            caTracesTrials_day2,matchIx,tPs,config);
        roiID{end+1} = 'Pop';
        figure(hDecode)
        subplot(numel(fieldsDays)-1,1,n-1)
        hErr = errorbar(1:numel(roiID),mean(perfShuf,1),std(perfShuf,1),'sk');
        removeErrorBarEnds(hErr); hold on
        hErr = errorbar(1:numel(roiID),mean(perfTrue,1),std(perfTrue,1),'or');
        removeErrorBarEnds(hErr);
        set(gca,'xlim',[0 numel(roiID)+1],'xtick',1:numel(roiID),'xticklabel',roiID)
        title(sprintf('%s - %s',dateID1,dateID2),'interpreter','none')
        ylabel('Perf. (%)')
        if n == numel(fieldsDays)
           xlabel('ROIs'), legend({'Shuf','True'})
        end
    end
end
if config.doCorr
    adjustSubplotAxes(hCorr,'x',[-1 1]);
end
if config.doDecode
    adjustSubplotAxes(hDecode,'y',[0 100]);
end
S.animalID = animalID;
if config.doSave
    SaveAndCloseFigures
end

end


%% Function - doMultiDayDecode
function [perfTrue, perfShuf] = ...
    doMultiDayDecode(trials_day1,trials_day2,matchIx,tPs,config)
% train classifier on data from day 1 and test on day 2

stimStartIx = find(tPs>=0,1,'first');
tPsStim = tPs(stimStartIx:end);
tPsStimI = tPsStim(1):0.1:tPsStim(end); % interpolation
iters = config.iters;
% single-cell analysis
perfTrue = zeros(iters,size(matchIx,1));
perfShuf = zeros(iters,size(matchIx,1));
for n1 = 1:size(matchIx,1)
    roi_day1_targ = squeeze(trials_day1{1}(matchIx(n1,1),:,:))';
    roi_day1_targ = roi_day1_targ(:,stimStartIx:end);
    roi_day1_dist = squeeze(trials_day1{2}(matchIx(n1,1),:,:))';
    roi_day1_dist = roi_day1_dist(:,stimStartIx:end);
    trainLabels = [ones(size(roi_day1_targ,1),1); repmat(2,size(roi_day1_dist,1),1)];
    trainData = [roi_day1_targ; roi_day1_dist];
    roi_day2_targ = squeeze(trials_day2{1}(matchIx(n1,2),:,:))';
    roi_day2_targ = roi_day2_targ(:,stimStartIx:end);
    roi_day2_dist = squeeze(trials_day2{2}(matchIx(n1,2),:,:))';
    roi_day2_dist = roi_day2_dist(:,stimStartIx:end);
    testLabels = [ones(size(roi_day2_targ,1),1); repmat(2,size(roi_day2_dist,1),1)];
    testData = [roi_day2_targ; roi_day2_dist];
    perfTrue(1:iters,n1) = doClassify(trainData,trainLabels,testData,testLabels,0.2,iters,0);
    perfShuf(1:iters,n1) = doClassify(trainData,trainLabels,testData,testLabels,0.2,iters,1);
    % interpolation to reduce dimensionality
    trainDataI = (interp1(tPsStim,trainData',tPsStimI))';
    testDataI = (interp1(tPsStim,testData',tPsStimI))';
    if n1 == 1
        trainDataPop = trainDataI;
        testDataPop = testDataI;
    else
        trainDataPop = [trainDataPop, trainDataI];
        testDataPop = [testDataPop, testDataI];
    end
end
% population analysis
% without dimensionality reduction
perfTruePop = doClassify(trainDataPop,trainLabels,testDataPop,testLabels,0.2,iters,0);
perfShufPop = doClassify(trainDataPop,trainLabels,testDataPop,testLabels,0.2,iters,1);

% dimensionality reduction (PCA)
% [pc,score,latent] = princomp([trainDataPop; testDataPop]);
% varExplained = cumsum(latent)./sum(latent);
% cutoff = find(varExplained>0.9,1,'first');
% trainData = score(1:numel(trainLabels),1:cutoff);
% testData = score(numel(trainLabels)+1:end,1:cutoff);
% perfTruePop = doClassify(trainData,trainLabels,testData,testLabels,0.2,iters,0);
% perfShufPop = doClassify(trainData,trainLabels,testData,testLabels,0.2,iters,1);

perfTrue = [perfTrue, perfTruePop'];
perfShuf = [perfShuf, perfShufPop'];

end


%% Function - doClassify
function perf = doClassify(trainData,trainLabels,testData,testLabels,holdOut,iters,shuffled)

% compute the max. number of unique hold-outs (should be > iters)
holdOutN = ceil(numel(trainLabels)*holdOut);
warning('off','MATLAB:nchoosek:LargeCoefficient')
maxHoldOuts = nchoosek(numel(trainLabels),holdOutN);
warning('on','MATLAB:nchoosek:LargeCoefficient')
if maxHoldOuts < iters
    warning('Max. number of unique hold-outs is %1.0f and iterations are %1.0f.',...
        maxHoldOuts,iters)
end
parfor n = 1:iters
    if shuffled
        trainLabels2 = trainLabels(randperm(numel(trainLabels)));
    else
        trainLabels2 = trainLabels;
    end
    c = cvpartition(trainLabels2,'holdout',holdOut);
    trainData2 = trainData(c.training,:); trainLabels2 = trainLabels2(c.training);
    model = NaiveBayes.fit(trainData2,trainLabels2);
    [~,predicted] = posterior(model,testData);
    perf(n) = (numel(find(predicted==testLabels))./numel(testLabels)).*100;
end

varargout{1} = perf;

end


%% Function - doMultiDayCorrelationAnalysis
function [corrMatch, corrNonMatchDiffDay, corrNonMatchSameDay] = ...
    doMultiDayCorrelationAnalysis(ca_day1,ca_day2,matchIx)
% approach: first correlate time series of different cells from different days to get 'null'
% distribution of correlations; then correlate for the same cells on different days and compare to
% 'null' distribution
corrMatch = cell(1,numel(ca_day1));
corrNonMatchDiffDay = cell(1,numel(ca_day1));
corrNonMatchSameDay = cell(1,numel(ca_day1));
for n1 = 1:size(matchIx,1)
    for t = 1:numel(ca_day1)
        % matching Rois
        roi_day1 = ca_day1{t}(matchIx(n1,1),:);
        roi_day2 = ca_day2{t}(matchIx(n1,2),:);
        corrMatch{t}(end+1) = corr(roi_day1',roi_day2');
        % non-matching Rois
        for n2 = 1:size(matchIx,1)
            if n1 == n2
                continue
            end
            roi_day2 = ca_day2{t}(matchIx(n2,2),:);
            corrNonMatchDiffDay{t}(end+1) = corr(roi_day1',roi_day2');
            roi2_day1 = ca_day1{t}(matchIx(n2,1),:);
            corrNonMatchSameDay{t}(end+1) = corr(roi_day1',roi2_day1');
        end
    end
end

end


%% Function - doSingleDayAnalysis
function [caTracesMean, caTracesTrialsOut, tPs] = doSingleDayAnalysis(S,config)
psTimesIx = round(config.psTimes.*config.imgRate);
stim = S.behav.stim;
trials = min(numel(stim), numel(S.caTraces));
% figure out target and non-target
targetNontarget = [];
for n = 1:numel(S.behav.target)
    if ~S.behav.target{n}
        continue
    end
    if stim{n} == 1
        targetNontarget = [1 2];
    else
        targetNontarget = [2 1];
    end
    break
end
fprintf('Target: stim %1.0f\n',targetNontarget(1))
fprintf('Non-Target: stim %1.0f\n',targetNontarget(2))

caTracesTrials = cell(1,2);
caTracesTrialsOut = cell(1,2);
for t = 1:trials
    caTraces = S.caTraces{t};
    imgDelay = S.behav.imgDelays{t};
    stimStartTime = S.behav.stimStartTime{t}-imgDelay;
    timeCa = (1:size(caTraces,2))./config.imgRate;
    stimStartIx = find(timeCa>=stimStartTime,1,'first');
    psStartIx = stimStartIx + psTimesIx(1);
    if psStartIx < 1
        error('psStart too early on trial %1.0f',t)
    end
    psStopIx = stimStartIx + psTimesIx(2);
    if psStopIx > size(caTraces,2)
%         warning('psStop too late on trial %1.0f. Skipping ...',t)
        continue
    end
    if t == 1
        tPs = ((psStartIx:psStopIx)-stimStartIx)./config.imgRate;
    end
    if isempty(caTracesTrials{stim{t}})
        caTracesTrials{stim{t}} = caTraces(:,psStartIx:psStopIx);
    else
        caTracesTrials{stim{t}} = cat(3, caTracesTrials{stim{t}}, caTraces(:,psStartIx:psStopIx));
    end
end

stimStartIx = find(tPs>=0,1,'first');
for n = 1:numel(caTracesTrials)
    data = nanmean(caTracesTrials{n},3);
    % baseline normalization / filter
    for m = 1:size(data,1)
        data(m,:) = data(m,:) - nanmean(data(m,1:stimStartIx));
        data(m,:) = sgolayfilt(data(m,:),3,11);
    end
    caTracesMean{1,targetNontarget(n)} = data;
    caTracesTrialsOut{1,targetNontarget(n)} = caTracesTrials{n};
end

end


%% Function - Save and close figures
function SaveAndCloseFigures
while numel(findobj) > 1
    set(findall(gcf,'Interpreter','Tex'),'Interpreter','None')
    makePrettyFigure(gcf);
    saveName = get(gcf,'Name');
    saveas(gcf,strrep(saveName,' ','-'))
    close(gcf)
end
end










