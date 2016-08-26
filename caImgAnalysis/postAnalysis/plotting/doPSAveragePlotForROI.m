%% Function - doPSAveragePlot
function [fig, fig2] = doPSAveragePlotForROI(iROI, ROIID, PSROIStatsData, uniqueStims,...
    stimNames, frameRate, baseFrames)

figName = sprintf('PSPlot %s', ROIID);
fig = figure('Name', figName, 'NumberTitle', 'off');
hold all;

% setup subplot
if numel(uniqueStims) > 3;
    M = ceil(sqrt(numel(uniqueStims)));
    N = M;
else
    M = numel(uniqueStims);
    N = M;
end;

if N * (M - 1) >= numel(uniqueStims);
    M = M - 1;
end;

AllStimsPSTrace = [];
for iStim = 1 : size(PSROIStatsData, 2);
    
    stimPSTrace = PSROIStatsData{iROI, iStim};
    AllStimsPSTrace = [AllStimsPSTrace; stimPSTrace]; %#ok<AGROW>
    
    subplot(M, N, iStim);
    PSTime = (1:size(stimPSTrace,2)) ./ frameRate;
    PSTime = PSTime - (baseFrames ./ frameRate);
    hErr = errorbar(PSTime, nanmean(stimPSTrace, 1), sem(stimPSTrace, 1), 'k', 'LineWidth', 2);
    hold on;
    removeErrorBarEnds(hErr);
    
%     if iStim >= (M * N) - N + 1;
    if iStim >= size(PSROIStatsData, 2) - N + 1;
        xlabel('Time [s]');
    else
        set(gca, 'XTickLabel', []);
    end;
    if mod(iStim, N) == 1;
        ylabel('DFF [%] \pm SEM');
    else
        set(gca, 'YTickLabel', []);
    end;
    title(sprintf('%s\\_%s', ROIID, sprintf('%3.1fkHz', stimNames(iStim) / 1000)));
end;

adjustSubplotAxes(fig, 'y', [], 'x', [min(PSTime) max(PSTime)]);
tightfig;
hold off;

[psPeak(iROI), i] = max(nanmean(stimPSTrace,1)); %#ok<ASGLU>
psPeakSD(iROI) = nanstd(stimPSTrace(:, i)); %#ok<NASGU>

figName = strrep(figName, 'PSPlot', 'PSPlotAllStims');
fig2 = figure('Name',figName,'NumberTitle','off');
hold all;
plot(PSTime, AllStimsPSTrace, 'Color',[0.5 0.5 0.5]);
hErr = errorbar(PSTime, nanmean(AllStimsPSTrace,1), sem(AllStimsPSTrace,1),...
    'r','LineWidth',2);
removeErrorBarEnds(hErr);
xlabel('Time [s]');
ylabel('DFF [%] \pm SEM');
title(sprintf('PSPlot all stims %s', ROIID));

end