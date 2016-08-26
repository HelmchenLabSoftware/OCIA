function S = analyzeHDF5(id)
% id ... date string for the HDF5 file (e.g. 14011001) or Matlab structure from previous run

doSave = 1;

if ~isstruct(id)
    fileName = sprintf('%s.h5',id);
    animalID = sprintf('mou_bl_%s_%s',id(1:6),id(7:8));
    datasetID = ['/' animalID];
    % load HDF5 and convert to data structure
    S = loadDataFromHDF5(fileName,datasetID);
else
    S = id;
    animalID = S.animalID;
    S = rmfield(S,'animalID');
end
clear id

fieldsSpots = fieldnames(S);
for n = 1:numel(fieldsSpots) % loop over spots
    spotID = fieldsSpots{n};
    currentSpot = S.(fieldsSpots{n});
    fieldsDays = fieldnames(currentSpot);
    
    for m = 1:numel(fieldsDays) % loop over days
        dateID = strrep(fieldsDays{m},'x','');
        currentS = currentSpot.(fieldsDays{m});
        
        fprintf('\n\nRunning analysis for %s %s %s\n',animalID,spotID,dateID)
        [caTracesMean, trialCount, tPs, perfTrue, perfShuf] = doSingleDayAnalysis(currentS);
        S.(fieldsSpots{n}).(fieldsDays{m}).caTracesMean = caTracesMean;
        S.(fieldsSpots{n}).(fieldsDays{m}).trialCount = trialCount;
        S.(fieldsSpots{n}).(fieldsDays{m}).tPs = tPs;
        S.(fieldsSpots{n}).(fieldsDays{m}).perfTrue = perfTrue;
        S.(fieldsSpots{n}).(fieldsDays{m}).perfShuf = perfShuf;
        
        %{
        % Average Neuropil signal for target and distractor
        titleStr = sprintf('%s %s %s Avg Npil',animalID,spotID,dateID);
        h = figure('Name',titleStr,'NumberTitle','off');
        plot(tPs,caTracesMean{1}(end,:),'k'), hold on
        plot(tPs,caTracesMean{2}(end,:),'r')
        legend({sprintf('Targ (%1.0f trials)',trialCount(1)),...
            sprintf('Dist (%1.0f trials)',trialCount(2))})
        
        % Average ROI traces for target and distractor
        titleStr = sprintf('%s %s %s Avg ROI',animalID,spotID,dateID);
        h = figure('Name',titleStr,'NumberTitle','off');
        nROIs = size(caTracesMean{1},1)-1;
        caTracesMeanMat = [caTracesMean{1}(1:nROIs,:); caTracesMean{2}(1:nROIs,:)];
        caTracesMeanMat = ScaleToMinMax(caTracesMeanMat,0,1);
        subplot(1,2,1) % target
        imagesc(tPs,1:nROIs,caTracesMeanMat(1:nROIs,:),[0 1])
        xlabel('Time (s)'), ylabel('ROI')
        title(sprintf('Target (%1.0f trials)',trialCount(1)))
        subplot(1,2,2) % distractor
        imagesc(tPs,1:nROIs,caTracesMeanMat(nROIs+1:end,:),[0 1])
        xlabel('Time (s)'), ylabel('ROI')
        title(sprintf('Distractor (%1.0f trials)',trialCount(2)))
        colormap('hot'), colorbar
        
        % NaiveBayes performance
        titleStr = sprintf('%s %s %s NaiveBayes',animalID,spotID,dateID);
        h = figure('Name',titleStr,'NumberTitle','off');
        shadedErrorBar(tPs,nanmean(perfShuf,1),nanstd(perfShuf,[],1),'k',1); hold on
        shadedErrorBar(tPs,nanmean(perfTrue,1),nanstd(perfTrue,[],1),'r',1);
        set(gca,'xlim',[min(tPs) max(tPs)])
        legend({'Shuf','True'}), xlabel('Time (s)'), ylabel('Classification Perf. +- SD (%)')
        %}
    end
end
S.animalID = animalID;

% if doSave
%     SaveAndCloseFigures
% end

end

%% Function - doSingleDayAnalysis
function [caTracesMean, trialCount, tPs, perfTrue, perfShuf] = doSingleDayAnalysis(S)

imgRate = 76.9; % in Hz
psTimes = [-0.5 2]; % in s
psTimesIx = round(psTimes.*imgRate);

stim = S.behav.stim;
trials = numel(stim);

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
for t = 1:trials
    caTraces = S.caTraces{t};
    imgDelay = S.behav.imgDelays{t};
    stimStartTime = S.behav.stimStartTime{t}-imgDelay;
    timeCa = (1:size(caTraces,2))./imgRate;
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
        tPs = ((psStartIx:psStopIx)-stimStartIx)./imgRate;
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
    oriData = caTracesTrials{n};
    nPSFramesDS = round(size(oriData, 2) / 4) + 1;
    DSData = nan(size(oriData, 1), nPSFramesDS, size(oriData, 3));
    for iROI = 1 : size(oriData, 1);
        for iTrial = 1 : size(oriData, 3);
            [DSData(iROI, :, iTrial), tPs] = interp1DS(imgRate, imgRate / 4, squeeze(oriData(iROI, :, iTrial)));
        end;
    end;
    caTracesMean{1,targetNontarget(n)} = data;
    trialCount(1,targetNontarget(n)) = size(caTracesTrials{n},3);
%     decodeData{1,targetNontarget(n)} = oriData;
    decodeData{1,targetNontarget(n)} = DSData;
end

% time-resolved decoding analysis (target vs. distractor) for neuron population
holdOut = 0.2; % fraction of trials to leave out
% iters = 50; % number of iterations
iters = 100; % number of iterations
decodeTimepoints = size(decodeData{1},2); % consider binning to reduce timepoints
perfTrue = zeros(iters,decodeTimepoints);
perfShuf = zeros(iters,decodeTimepoints);
dispPercent = 10;
fprintf('NaiveBayes classification: 00%% done')
for t = 1:decodeTimepoints
    popData = []; labels = [];
    for stim = 1:numel(decodeData)
        for trial = 1:size(decodeData{stim},3)
            popData = [popData; decodeData{stim}(1:end-1,t,trial)']; % last row is neuropil
            labels(end+1,1) = stim;
        end
    end
    perfTrue(1:iters,t) = doClassify(popData,labels,holdOut,iters,0);
    perfShuf(1:iters,t) = doClassify(popData,labels,holdOut,iters,1);
    percentDone = round(t/decodeTimepoints*100);
    if percentDone >= dispPercent
        fprintf('\b\b\b\b\b\b\b\b%1.0f%% done',percentDone)
        dispPercent = dispPercent + 10;
    end
end
fprintf('\n\n')

end


%% Function - doClassify
function varargout = doClassify(data,labels,holdOut,iters,shuffled)
if ~any(data)
    for n = 1:nargout
        varargout{n} = NaN;
    end
    return
end
perf = zeros(iters,1); postpCell = cell(iters,1);
predictedCell = cell(iters,1); testlabelsCell = cell(iters,1);
% compute the max. number of unique hold-outs (should be > iters)
holdOutN = ceil(numel(labels)*holdOut);
warning('off','MATLAB:nchoosek:LargeCoefficient')
maxHoldOuts = nchoosek(numel(labels),holdOutN);
warning('on','MATLAB:nchoosek:LargeCoefficient')
if maxHoldOuts < iters
    warning('Max. number of unique hold-outs is %1.0f and iterations are %1.0f.',...
        maxHoldOuts,iters)
end
parfor n = 1:iters
    if shuffled
        labels2 = labels(randperm(numel(labels)));
    else
        labels2 = labels;
    end
    c = cvpartition(labels2,'holdout',holdOut);
    trainData = data(c.training,:); trainLabels = labels2(c.training);
    if ~any(trainData)
        perf(n) = NaN;
        continue
    end
    testData = data(c.test,:); testLabels = labels2(c.test);
    model = NaiveBayes.fit(trainData,trainLabels);
    [postP,predicted,logp] = posterior(model,testData);
    perf(n) = (numel(find(predicted==testLabels))./numel(testLabels)).*100;
    postpCell{n} = postP;
    predictedCell{n} = predicted;
    testlabelsCell{n} = testLabels;
end

varargout{1} = perf;

if nargout > 1
    varargout{2} = predictedCell;
    varargout{3} = testlabelsCell;
    varargout{4} = postpCell;
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










