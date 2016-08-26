function perfNbyN1 = textureDisc_SingleSession_NbyN1_script

load a115_allSessions.mat
content = whos('S_a115*');
meanPerf = cell(1,numel(content));
meanPerfShuf = cell(1,numel(content));
roiLabel = cell(1,numel(content));
for n = 1:numel(content)
    fprintf('\nRunning %s (%1.0f/%1.0f)\n',content(n).name,n,numel(content))
    Sin = eval(content(n).name);
    [meanPerf{n},meanPerfShuf{n},roiLabel{n}] = ...
        textureDisc_mvpaSingleSession(Sin);
end

% pooled accuracy by class
perfAll = []; perfS = []; perfM = []; perfN = []; perfNpil = [];
for s = 1:numel(roiLabel)
    for roi = 1:numel(roiLabel{s})
        if strcmp(roiLabel{s}{roi},'npil')
            perfNpil = [perfNpil; meanPerf{s}(roi)];
            continue
        else
            perfAll = [perfAll; meanPerf{s}(roi)];
        end
        if strcmp(roiLabel{s}{roi}(1:2),'SM')
        elseif strcmp(roiLabel{s}{roi}(1),'S')
            perfS = [perfS; meanPerf{s}(roi)];
        elseif strcmp(roiLabel{s}{roi}(1),'M')
            perfM = [perfM; meanPerf{s}(roi)];
        elseif strcmp(roiLabel{s}{roi}(1),'N')
            perfN = [perfN; meanPerf{s}(roi)];
        end
    end
end
titleStr = sprintf('Pooled Classification Single Session');
hFig = figure('Name',titleStr,'NumberTitle','off');
scatter(repmat(0.95,numel(perfAll),1),perfAll,'ko'); hold on
hErr=errorbar(1.05,mean(perfAll),std(perfAll),'rs');
removeErrorBarEnds(hErr);
scatter(repmat(1.95,numel(perfS),1),perfS,'ko'); hold on
hErr=errorbar(2.05,mean(perfS),std(perfS),'rs');
removeErrorBarEnds(hErr);
scatter(repmat(2.95,numel(perfM),1),perfM,'ko'); hold on
hErr=errorbar(3.05,mean(perfM),std(perfM),'rs');
removeErrorBarEnds(hErr);
scatter(repmat(3.95,numel(perfN),1),perfN,'ko'); hold on
hErr=errorbar(4.05,mean(perfN),std(perfN),'rs');
removeErrorBarEnds(hErr);
scatter(repmat(4.95,numel(perfNpil),1),perfNpil,'ko'); hold on
hErr=errorbar(5.05,mean(perfNpil),std(perfNpil),'rs');
removeErrorBarEnds(hErr);
set(gca,'xlim',[0.5 5.5],'xtick',[1 2 3 4 5],'xticklabel',{'All','S','M','N','npil'})
makePrettyFigure(hFig);


% match classification performance for cells across days
perfNbyN1 = zeros(1,2); pos = 1;
perfNbyN1_S = zeros(1,2); posS = 1;
perfNbyN1_M = zeros(1,2); posM = 1;
perfNbyN1_N = zeros(1,2); posN = 1;
for s1 = 1:numel(roiLabel)
    for s2 = 2:numel(roiLabel)
        if s2 <= s1, continue, end
        % match rois
        for roi1 = 1:numel(roiLabel{s1})
            if strcmp(roiLabel{s1}{roi1},'npil')
                continue
            end
            for roi2 = 1:numel(roiLabel{s2})
                if strcmp(roiLabel{s1}{roi1},roiLabel{s2}{roi2})
                    perfNbyN1(pos,1) = meanPerf{s1}(roi1);
                    perfNbyN1(pos,2) = meanPerf{s2}(roi2);
                    pos = pos + 1;
                    if strcmp(roiLabel{s1}{roi1}(1:2),'SM')
                    elseif strcmp(roiLabel{s1}{roi1}(1),'S')
                        perfNbyN1_S(posS,1) = meanPerf{s1}(roi1);
                        perfNbyN1_S(posS,2) = meanPerf{s2}(roi2);
                        posS = posS + 1;
                    elseif strcmp(roiLabel{s1}{roi1}(1),'M')
                        perfNbyN1_M(posM,1) = meanPerf{s1}(roi1);
                        perfNbyN1_M(posM,2) = meanPerf{s2}(roi2);
                        posM = posM + 1;
                    elseif strcmp(roiLabel{s1}{roi1}(1),'N')
                        perfNbyN1_N(posN,1) = meanPerf{s1}(roi1);
                        perfNbyN1_N(posN,2) = meanPerf{s2}(roi2);
                        posN = posN + 1;
                    end
                end
            end
        end
    end
end
hFig = figure('Name','Classification Performance N - N+1','NumberTitle','off');
scatter(perfNbyN1(:,1),perfNbyN1(:,2),'k.'), hold on
scatter(perfNbyN1_S(:,1),perfNbyN1_S(:,2),'ro')
scatter(perfNbyN1_M(:,1),perfNbyN1_M(:,2),'go')
scatter(perfNbyN1_N(:,1),perfNbyN1_N(:,2),'bo')
xlabel('Perf Session 1'), ylabel('Perf Session 2')
legend({'All','S','M','N'})
% correlation
[cc,p] = corrcoef(perfNbyN1(:,1),perfNbyN1(:,2));
title(sprintf('r=%1.2f (p=%1.5e)',cc(1,2),p(1,2)))
fprintf('All: r=%1.2f (p=%1.5e)\n',cc(1,2),p(1,2))
[cc,p] = corrcoef(perfNbyN1_S(:,1),perfNbyN1_S(:,2));
fprintf('S: r=%1.2f (p=%1.5e)\n',cc(1,2),p(1,2))
[cc,p] = corrcoef(perfNbyN1_M(:,1),perfNbyN1_M(:,2));
fprintf('M: r=%1.2f (p=%1.5e)\n',cc(1,2),p(1,2))
[cc,p] = corrcoef(perfNbyN1_N(:,1),perfNbyN1_N(:,2));
fprintf('N: r=%1.2f (p=%1.5e)\n',cc(1,2),p(1,2))

% regression line
p = polyfit(perfNbyN1(:,1),perfNbyN1(:,2),1);
yFit = polyval(p,[0 100]);
plot([0 100],yFit,'k'), hold on
% origin
plot([0 100],[0 100],'k--')
makePrettyFigure(hFig);

