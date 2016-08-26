
foldPath = 'C:\Users\WideField\Documents\LabVIEW Data\2016_01_19\widefield\';
files = dir([foldPath, '*.h5']);
% fileName = '20160119_193843_exp14_5trialsPerStim_4stims_multiModalityMapping_amplif2_100HzFrameRate';
fileName = regexprep(files(end).name, '.h5$', '');
filePath = [foldPath fileName '.h5'];
datasetPath = ['/mou_bl_160105_XX/2016_01_19/' fileName '/stimFrames/'];
h5disp(filePath, datasetPath)
figure();
hold on;
cols = [1 0 0; 0 1 0; 0 0 1; 0 0 0];
lineSty = {'-', ':', '-.', '--', '-', ':', '-.', '--', '-', ':', '-.', '--' };
marker = {'o', 'o', 'o', 'o', '*', '*', '*', '*', '+', '+', '+', '+' };
stimIDs = { 'aud', 'vis', 'somat', 'blk' };
legendIDs = {};
nTrials = 4;
nFrames = 110;
frameRate = 100;
BLDur = 0.4;
for iStim = 1 : 4;
    for iTrial = 1 : nTrials;
        trialData = squeeze(nanmean(nanmean(h5read(filePath, datasetPath, [1, 1, 1, iTrial, iStim], [512, 512, nFrames, 1, 1]), 1), 2));
        trialData = trialData - nanmean(trialData(1 : 2));
        plot(-BLDur + (1 : nFrames)/frameRate, trialData, 'Color', cols(iStim, :), 'LineStyle', lineSty{iTrial}, 'Marker', marker{iTrial});
        legendIDs = [ legendIDs, { sprintf('%s%d', stimIDs{iStim}, iTrial) } ]; %#ok<AGROW>
    end;
    trialData = squeeze(nanmean(nanmean(nanmean(h5read(filePath, datasetPath, [1, 1, 1, 1, iStim], [512, 512, nFrames, nTrials, 1]), 1), 2), 4));
    trialData = trialData - nanmean(trialData(1 : 2));
    plot(-BLDur + (1 : nFrames)/frameRate, trialData, 'Color', cols(iStim, :), 'LineStyle', '-', 'LineWidth', 2);
    legendIDs = [ legendIDs, { sprintf('%sAvg', stimIDs{iStim}) } ]; %#ok<AGROW>
    
end;
hold off;
legend(legendIDs);