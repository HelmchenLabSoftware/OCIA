function [dprime,auc] = rocAnalysis(v1,v2)

if isequal(v1,v2) % no need to fit anything
    dprime = 0; auc = 0.5;
    return
end

v = [v1, v2];
if ~any(v)
    dprime = 0; auc = 0.5;
    return
end

cutoff = min(v):range(v)./100:max(v);
% plot data histograms
% figure('Name','Histograms')
% [count1,xout1] = hist(v1,sqrt(numel(v1)));
% [count2,xout2] = hist(v2,sqrt(numel(v2)));
% stairs(xout1,count1,'k'), hold on
% stairs(xout2,count2,'r')
% legend({'1','2'})

% vary cut-off and determine correct / false detections
for n = 1:numel(cutoff)
    hitRate(n) = numel(find(v1<=cutoff(n))) ./ numel(v1);
    fpRate(n) = numel(find(v2<=cutoff(n))) ./ numel(v2);
end

[dprime,auc] = fitROCcurve(fpRate,hitRate,0);
end