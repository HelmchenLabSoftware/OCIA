% analyse widefield imaging data

%% init
dataFilePath = 'F:\RawData\1509_tonotopy\mou_bl_151007_01\2015_10_19\widefield_labview\20151019_173300_5freqs_100frames_20trials_256x256.h5';


%% create ROI

nROIs = 5 ^ 2;

% display image
% imagesc(refImgSD);
imagesc(refImg);
refImgCol = refImg;

ROIMasks = false(imDimY, imDimX, nROIs);

iROI = 1;
for iROIX = 1 : sqrt(nROIs);
    for iROIY = 1 : sqrt(nROIs);
        wROI = round(imDimX / sqrt(nROIs));
        hROI = round(imDimY / sqrt(nROIs));
        ROIMasks((iROIY - 1) * hROI + 1 : iROIY * hROI, ...
            (iROIX - 1) * wROI + 1 : iROIX * wROI, iROI) = true;
        refImgCol((iROIY - 1) * hROI + 1 : iROIY * hROI, ...
            (iROIX - 1) * wROI + 1 : iROIX * wROI) = iROI;
        iROI = iROI + 1;
    end;
end;


imagesc(refImgCol);

% % draw ROI
% hROI = imfreehand(gca);
% maskROI = hROI.createMask();
% delete(hROI);
close(gcf);

%% extract time-serie for each trial
traceData = zeros(nTrials, nROIs, nFrames);
for iTrial = 1 : nTrials;
    for iROI = 1 : nROIs;
        traceData(iTrial, iROI, :) = nanmean(GetRoiTimeseries( ...
            squeeze(data(iTrial, :, :, :)), squeeze(ROIMasks(:, :, iROI))));
        if any(abs(traceData(iTrial, iROI, :)) > 30);
            traceData(iTrial, iROI, :) = NaN;
        end;
    end;
end;

%% visualize data
figure('Name', 'DFF traces');
for iROI = 1 : nROIs;
    subplot(sqrt(nROIs), sqrt(nROIs), iROI);
    hold on;
    for iTrial = 1 : nTrials;
        plot(squeeze(traceData(iTrial, iROI, :)), 'Color', 0.7 * [1 1 1], 'LineStyle', ':');
    end;
    plot(nanmean(squeeze(traceData(:, iROI, :)), 1), 'r', 'LineWidth', 2);
    hold off;
end;


%%
%{
trialMeanData = squeeze(nanmean(data, 1));

refImg = squeeze(linScale(data(1, :, :, 1)));

F0 = nanmean(trialMeanData(:, :, :), 3);
DFFData = (trialMeanData - repmat(F0, 1, 1, 80)) ./ repmat(F0, 1, 1, 80);
%}