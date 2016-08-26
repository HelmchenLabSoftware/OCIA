function [perfMeanSD_true, perfMeanSD_shuff, roiUnique] = ...
    textureDisc_mvpaMultiSession(varargin)

comparison = 'NogoTexture'; % GoNogo, NogoTexture
iters = 50;
classifier = 'naiveBayes'; % not used
dataField = 'dRR'; % 'dRR' or 'reducedGauss1' / dRR is interpolated!
classifyColumns = []; % columns for classification (empty for all)

Sin = varargin{1}; % cell array of input structures

animalID = Sin{1}.info.animal;
sessionID = Sin{1}.info.session;

sessions = numel(Sin);

% match cells across sessions
roiUnique = {};
for n = 1:sessions
    currentS = Sin{n};
    animal = currentS.info.animal;
    sess = currentS.info.session;
    roiLabel = currentS.info.roiLabel;
    roiLabel = strrep(roiLabel,sprintf('%s-%1.0f-',animal,sess),'');
    roiLabel(strcmp(roiLabel,'neuropil')) = [];
    roiLabelAll{n} = roiLabel;
    roiUnique = [roiUnique; roiLabel];
end

sessionCount = zeros(numel(roiUnique),1);
for n = 1:numel(roiUnique)
    sessionCount(n) = sum(strcmp(roiUnique,roiUnique{n}));
end
roiUnique(sessionCount==1) = [];
sessionCount(sessionCount==1) = [];

perfMeanSD_true = zeros(2,numel(roiUnique));
perfMeanSD_shuff = zeros(2,numel(roiUnique));
for n = 1:numel(roiUnique)
    roiID = roiUnique{n};
    roiDrrData = cell(1,sessionCount(n));
    roiTextureData = cell(1,sessionCount(n)); pos = 1;
    for s = 1:sessions
        if sum(strcmp(roiID,roiLabelAll{s}))
            
            data = Sin{s}.(roiID).(dataField);
            if ~isempty(classifyColumns)
                data = data(:,classifyColumns(1):classifyColumns(2));
            end
            % interpolate dRR
            if strcmp(dataField,'dRR')
                tOrig = 1:size(data,2);
                tInterp = linspace(1,size(data,2),10);
                dataInterp = interp1(tOrig,data',tInterp);
                data = dataInterp';
            end
            roiDrrData{pos} = data;
            
            textureLabels = Sin{s}.info.trialVectors.texture;
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
            roiTextureData{pos} = textureLabels;
            pos = pos + 1;
        end
    end
    % do across-session decoding
    [perf_true,perf_shuff] = doMultiDayDecode(roiDrrData,roiTextureData,iters);
    perfMeanSD_true(1:2,n) = [mean(perf_true); std(perf_true)];
    perfMeanSD_shuff(1:2,n) = [mean(perf_shuff); std(perf_shuff)];
end

[~,idx] = sort(perfMeanSD_true(1,:),'descend');
perfMeanSD_true = perfMeanSD_true(1:2,idx);
perfMeanSD_shuff = perfMeanSD_shuff(1:2,idx);
roiUnique = roiUnique(idx);
figure('Name',sprintf('Multi-session %s',comparison),'NumberTitle','off')
% hErr = errorbar(perfMeanSD_true(1,:),perfMeanSD_true(2,:),'or','LineStyle','none'); hold on
% removeErrorBarEnds(hErr);
% hErr = errorbar(perfMeanSD_shuff(1,:),perfMeanSD_shuff(2,:),'sk','LineStyle','none');
% removeErrorBarEnds(hErr);

shadedErrorBar(1:size(perfMeanSD_shuff,2),perfMeanSD_shuff(1,:),perfMeanSD_shuff(2,:),'-k',1); hold on
shadedErrorBar(1:size(perfMeanSD_true,2),perfMeanSD_true(1,:),perfMeanSD_true(2,:),'-r',1);
set(gca,'xtick',1:numel(roiUnique),'xticklabel',roiUnique)
legend({'true' 'shuffled'})

% average cell groups
perfSM = []; posSM = 1;
perfS = []; posS = 1;
perfM = []; posM = 1;
perfN = []; posN = 1;
for n = 1:numel(roiUnique)
    if strcmp(roiUnique{n}(1:2),'SM')
        perfSM(posSM) = perfMeanSD_true(1,n); posSM = posSM + 1;
    elseif strcmp(roiUnique{n}(1),'S')
        perfS(posS) = perfMeanSD_true(1,n); posS = posS + 1;
    elseif strcmp(roiUnique{n}(1),'M')
        perfM(posM) = perfMeanSD_true(1,n); posM = posM + 1;
    elseif strcmp(roiUnique{n}(1),'N')
        perfN(posN) = perfMeanSD_true(1,n); posN = posN + 1;
    end
end
titleStr = sprintf('%s %s',animalID,comparison);
hFig = figure('Name',titleStr,'NumberTitle','off');
scatter(repmat(0.95,size(perfMeanSD_true,2),1),perfMeanSD_true(1,:)','ko'); hold on
hErr=errorbar(1.05,mean(perfMeanSD_true(1,:)),std(perfMeanSD_true(1,:)),'rs');
removeErrorBarEnds(hErr);
scatter(repmat(1.95,numel(perfS),1),perfS','ko'); hold on
hErr=errorbar(2.05,mean(perfS),std(perfS),'rs');
removeErrorBarEnds(hErr);
scatter(repmat(2.95,numel(perfM),1),perfM','ko'); hold on
hErr=errorbar(3.05,mean(perfM),std(perfM),'rs');
removeErrorBarEnds(hErr);
scatter(repmat(3.95,numel(perfN),1),perfN','ko'); hold on
hErr=errorbar(4.05,mean(perfN),std(perfN),'rs');
removeErrorBarEnds(hErr);
set(gca,'xlim',[0.5 4.5],'xtick',[1 2 3 4],'xticklabel',{'All','S','M','N'})
makePrettyFigure(hFig);




