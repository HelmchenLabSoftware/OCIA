function [perfTrueAll,perfTrueS,perfTrueM,perfTrueN] = ...
    textureDisc_popDecodeMultiSession(varargin)

comparison = 'NogoTexture'; % GoNogo, NogoTexture
iters = 50;
classifier = 'naiveBayes'; % libsvm, naiveBayes
dataField = 'reducedGauss1'; % 'dRR' or 'reducedGauss1'
classifyColumns = []; % columns for classification (empty for all)

Sin = varargin{1}; % cell array of input structures

animalID = Sin{1}.info.animal;

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

roiSessionMatrix = zeros(numel(roiUnique),sessions);
for n = 1:numel(roiUnique)
    for s = 1:sessions
        if sum(strcmp(roiUnique{n},roiLabelAll{s}))
           roiSessionMatrix(n,s) = 1;
        end
    end
end

perfTrueAll = [];
perfTrueSall = [];
perfTrueMall = [];
perfTrueNall = []; pos = 1;
for s1 = 1:sessions
    for s2 = 2:sessions
        if s2 <= s1; continue; end
        matches = find(roiSessionMatrix(:,s1)==1&roiSessionMatrix(:,s2)==1);
        if isempty(matches); continue; end
        s1ID = Sin{s1}.info.session;
        s2ID = Sin{s2}.info.session;
        textureLabelsTrain = Sin{s1}.info.trialVectors.texture;
        textureLabelsTest = Sin{s2}.info.trialVectors.texture;
        switch lower(comparison)
            case 'gonogo'
                textureLabelsTrain(textureLabelsTrain>1) = 2;
                textureLabelsTest(textureLabelsTest>1) = 2;
            case 'nogotexture'
                textureLabelsTrain(textureLabelsTrain==1) = NaN;
                textureLabelsTrain = textureLabelsTrain - 1;
                textureLabelsTest(textureLabelsTest==1) = NaN;
                textureLabelsTest = textureLabelsTest - 1;
            otherwise
                error('Comparison %s not implemented (yet)',comparison)
        end
        roiTextureData = {textureLabelsTrain, textureLabelsTest};
        
        dataTrainAll = []; dataTestAll = [];
        dataTrainM = []; dataTestM = [];
        dataTrainS = []; dataTestS = [];
        dataTrainN = []; dataTestN = [];
        for n = 1:numel(matches)
            roiID = roiUnique{matches(n)};
            dataTrain = Sin{s1}.(roiID).(dataField);
            dataTest = Sin{s2}.(roiID).(dataField);
            if ~isempty(classifyColumns)
                dataTrain = dataTrain(:,classifyColumns(1):classifyColumns(2));
                dataTest = dataTest(:,classifyColumns(1):classifyColumns(2));
            end
            dataTrainAll = [dataTrainAll, dataTrain];
            dataTestAll = [dataTestAll, dataTest];
            if strcmp(roiID(1:2),'SM')
                continue
            elseif strcmp(roiID(1),'S')
                dataTrainS = [dataTrainS, dataTrain];
                dataTestS = [dataTestS, dataTest];
            elseif strcmp(roiID(1),'M')
                dataTrainM = [dataTrainM, dataTrain];
                dataTestM = [dataTestM, dataTest];
            elseif strcmp(roiID(1),'N')
                dataTrainN = [dataTrainN, dataTrain];
                dataTestN = [dataTestN, dataTest];
            end
        end
        
        [perfTrue,perfShuf] = doMultiDayDecode({dataTrainAll,dataTestAll},roiTextureData,iters);
        perfTrueAll(pos) = mean(perfTrue);
        
        [perfTrueS,perfShufS] = doMultiDayDecode({dataTrainS,dataTestS},roiTextureData,iters);
        perfTrueSall(pos) = mean(perfTrueS);
        
        [perfTrueM,perfShufM] = doMultiDayDecode({dataTrainM,dataTestM},roiTextureData,iters);
        perfTrueMall(pos) = mean(perfTrueM);
        
        [perfTrueN,perfShufN] = doMultiDayDecode({dataTrainN,dataTestN},roiTextureData,iters);
        perfTrueNall(pos) = mean(perfTrueN); pos = pos + 1;
        
        titleStr = sprintf('%s %s Train %1.0f Test %1.0f',animalID,comparison,s1ID,s2ID);
        hFig = figure('Name',titleStr,'NumberTitle','off'); hold on
        hErr = errorbar([1 2 3 4],[mean(perfTrue) mean(perfTrueS) mean(perfTrueM) mean(perfTrueN)],...
            [std(perfTrueAll) std(perfTrueS) std(perfTrueM) std(perfTrueN)]);
        set(hErr,'Marker','o','Color','r','LineStyle','-');
        removeErrorBarEnds(hErr);
        hErr = errorbar([1 2 3 4],[mean(perfShuf) mean(perfShufS) mean(perfShufM) mean(perfShufN)],...
            [std(perfShuf) std(perfShufS) std(perfShufM) std(perfShufN)]);
        set(hErr,'Marker','s','Color','k','LineStyle','--');
        removeErrorBarEnds(hErr); legend({'true','shuf'}); title(titleStr)
        set(gca,'xlim',[0.5 4.5],'xtick',[1 2 3 4],'xticklabel',{'All','S','M','N'})
        makePrettyFigure(hFig);
        
    end
end

titleStr = sprintf('%s %s',animalID,comparison);
hFig = figure('Name',titleStr,'NumberTitle','off'); hold on
scatter(repmat(0.95,numel(perfTrueAll),1),perfTrueAll,'ko'); hold on
hErr=errorbar(1.05,mean(perfTrueAll),std(perfTrueAll),'rs');
removeErrorBarEnds(hErr);
scatter(repmat(1.95,numel(perfTrueSall),1),perfTrueSall,'ko'); hold on
hErr=errorbar(2.05,mean(perfTrueSall),std(perfTrueSall),'rs');
removeErrorBarEnds(hErr);
scatter(repmat(2.95,numel(perfTrueMall),1),perfTrueMall,'ko'); hold on
hErr=errorbar(3.05,mean(perfTrueMall),std(perfTrueMall),'rs');
removeErrorBarEnds(hErr);
scatter(repmat(3.95,numel(perfTrueNall),1),perfTrueNall,'ko'); hold on
hErr=errorbar(4.05,mean(perfTrueNall),std(perfTrueNall),'rs');
removeErrorBarEnds(hErr);
set(gca,'xlim',[0.5 4.5],'xtick',[1 2 3 4],'xticklabel',{'All','S','M','N'})
makePrettyFigure(hFig);



