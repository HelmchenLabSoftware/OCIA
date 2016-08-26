
load('behaviorVectors.mat');

frameRate = 30;
timeOffset = -3;

conds = { 'CR', 'hit' };
for iCond = 1 : numel(conds);
    
    eval(sprintf('data = ROIBehavData_cond_%s;', conds{iCond}));
    [nROIs, nTrials, nFrames] = size(data);
    
    subplot(numel(conds), 1, iCond);
    hold('on');
    lineCols = lines(nROIs);
    for iROI = 1 : nROIs;
        t = (1 : nFrames) / frameRate + timeOffset;
        
%         meanVal = squeeze(nanmean(data(iROI, :, :), 2))';
%         stdVal = squeeze(nanstd(data(iROI, :, :), [], 2))';
%         shadedErrorBar(t, meanVal, stdVal, { 'Color', lineCols(iROI, :) }, 1, gcf, gca);
%         xlim([t(1) t(end)]);
%         ylim([-0.15 0.35]);
        
        meanVal = squeeze(nanmean(data(iROI, :, :), 2) > 0.1)';
        plot(t, meanVal,  'Color', lineCols(iROI, :));
        xlim([t(1) t(end)]);
        ylim([-0.05 1.55]);
        
    end;
    hold('off');
end;