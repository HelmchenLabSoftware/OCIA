function changing_frame_0_balazs()

fr0 = [];

load('stimStartFrames');
load('trials_ind');
load('norm_frame');
load('rois_OCIA_old');
load('ROIs_registered');

fr2=57:58;
fr_dev2 = nan(size(fr_dev)); %#ok<*NODEF>
stimFrames = 59:68;
fixedStartFrame = max(stimStartFrame);
% trialTypes = { 'hit', 'CR' };
trialTypes = { 'hit' };

nMaxTrials = 1;

% exclTrials = { [4 5 7 8 11 12 15 19 22 27 28 29], [] };
exclTrials = { [], [] };

doSinglePlots = true;
doAvgPlot = false;

avgYLims = [-0.01 0.01];
trialYLims = [-0.05 0.05]; %#ok<*NASGU>

avgCLim = [-0.001 0.001];
trialCLim = [-0.005 0.01]; %#ok<*NASGU>


% ROINames = { 'V1', 'M2', 'A1', 'S1FL' };
% ROIColors = { 'b', 'k', 'g', 'r' };
% ROINames = { 'V1', 'A1', 'S1FL' };
% ROIColors = { 'b', 'g', 'c' };
ROINames = {  };
ROIColors = {  };



ROI2Inds = 1 : 6;
ROIColors2 = [0 1 1; 1 0 1; 0 1 0; 1 1 0; 1 0 0; 0 0 1];
% ROI2Inds = [6, 3, 1];
% ROIColors2 = [0 0 1; 0 1 0; 0 1 1;];


ROIs = ROIs(ROI2Inds, :);


%% HIT trials
for iType = 1 : numel(trialTypes);
    
    listTrials = dir(['cond_' trialTypes{iType} '_trial*']);
    cond_avg = zeros(256, 256, 240);
    cond_avg_0 = zeros(256, 256, 240);
    cond_avgNoAlign = zeros(256, 256, 240);
    cond_avgNoAlign_0 = zeros(256, 256, 240);
    nTrials = 0;
    trialInd = eval(['tr_', trialTypes{iType}]);

    for iTrial = 1 : min(nMaxTrials, size(listTrials, 1));

        if ismember(iTrial, exclTrials{iType}); continue; end;

        trialPath = sprintf('cond_%s_trial%d.mat', trialTypes{iType}, iTrial);
        if ~exist(trialPath, 'file'); continue; end;
        
        fprintf('Loading trial %s %03d ...\n', trialTypes{iType}, iTrial);
        load(trialPath);

        % reset the baseline
        tr = tr .* repmat(fr_dev(:, :, trialInd(iTrial)), [1, 1, size(tr, 3)]);
        trNoAlign = tr;

        % re-align frames
        stimStartFrameTrial = stimStartFrame(trialInd(iTrial));
        nFramesDiff = fixedStartFrame - stimStartFrameTrial;
        if nFramesDiff > 0;
            tr = cat(3, nan(size(tr, 1), size(tr, 2), nFramesDiff), tr(:, :, 1 : (end - nFramesDiff)));
        elseif nFramesDiff < 0;
            tr = cat(3, tr(:, :, (nFramesDiff + 1) : end), nan(size(tr, 1), size(tr, 2), nFramesDiff));
        end;

        % re-normalize with baseline
        tr0 = tr;
        tr0 = tr0 ./ repmat(fr_dev(:, :, trialInd(iTrial)), [1 1 size(tr0, 3)]);
        fr_dev2(:, :, trialInd(iTrial)) = nanmean(tr(:, :, fr2), 3);
        tr = tr ./ repmat(fr_dev2(:, :, trialInd(iTrial)), [1 1 size(tr, 3)]);
        % re-normalize with baseline
        trNoAlign0 = trNoAlign;
        trNoAlign0 = trNoAlign0 ./ repmat(fr_dev(:, :, trialInd(iTrial)), [1 1 size(trNoAlign0, 3)]);
        fr_dev2(:, :, trialInd(iTrial)) = nanmean(trNoAlign(:, :, fr2), 3);
        trNoAlign = trNoAlign ./ repmat(fr_dev2(:, :, trialInd(iTrial)), [1 1 size(trNoAlign, 3)]);

        % add average
        cond_avg = cond_avg + tr;
        cond_avg_0 = cond_avg_0 + tr0;
        cond_avgNoAlign = cond_avgNoAlign + tr;
        cond_avgNoAlign_0 = cond_avgNoAlign_0 + tr0;
        nTrials = nTrials + 1;

        % plot
        if doSinglePlots;
            createPlot(sprintf('%s %03d - trial %03d', trialTypes{iType}, iTrial, trialInd(iTrial)), ...
                tr0, tr, trNoAlign0, trNoAlign, fr0, fr2, stimFrames, roi_V1, roi_M2, roi_A1, roi_S1FL, ROINames, ...
                ROIColors, ROIColors2, ROIs, trialCLim, trialYLims); %#ok<*UNRCH>

        end;

    end

    % compute average
    cond_avg = cond_avg ./ nTrials;
    cond_avg_0 = cond_avg_0 ./ nTrials;
    cond_avgNoAlign = cond_avgNoAlign ./ nTrials;
    cond_avgNoAlign_0 = cond_avgNoAlign_0 ./ nTrials;

    % plot
    if doAvgPlot;

        createPlot(sprintf('%s average - %03d trial(s)', trialTypes{iType}, nTrials), ...
            cond_avg_0, cond_avg, cond_avgNoAlign, cond_avgNoAlign_0, fr0, fr2, stimFrames, ...
            roi_V1, roi_M2, roi_A1, roi_S1FL, ROINames, ROIColors, ROIColors2, ROIs, avgCLim, avgYLims);

    end;

end;

end


function createPlot(figTitle, dataFr0, dataFr2, dataNoAlignFr0, dataNoAlignFr2, fr0, fr2, ...
    stimFrames, roi_V1, roi_M2, roi_A1, roi_S1FL, ROINames, ROIColors, ROIColors2, ROIs, cLim, yLims) %#ok<INUSL>

subPlotTitles = { sprintf('Sound aligned, norm. %02d:%02d', fr0(1), fr0(end)), ...
sprintf('Sound aligned, norm. %02d:%02d, stim. %02d:%02d', fr0([1 end]), stimFrames([1 end])), ...
sprintf('Trig. aligned, norm %02d:%02d', fr2([1 end])), ...
sprintf('Trig. aligned, norm. %02d:%02d, stim. %02d:%02d', fr2([1 end]), stimFrames([1 end])) };

legendParams = { [ROINames ROIs(:, 1)'], 'Location', 'NorthOutside', 'Orientation', 'Horizontal', 'FontSize', 6 };
        
figure('Name', figTitle, 'NumberTitle', 'off', 'Position', [30 100 1850 970]);

dataToPlot = { dataFr0, dataFr2, dataNoAlignFr0, dataNoAlignFr2 };

iSubPlot = 1;
for iData = 1 : 4;
    
    subplot(2, 4, iSubPlot);
    title(subPlotTitles{1});
    hold on;
    linTr = reshape(dataToPlot{iData}, size(dataToPlot{iData}, 2) * size(dataToPlot{iData}, 2), size(dataToPlot{iData}, 3));
    for iROI = 1 : numel(ROINames);
        plot(squeeze(nanmean(linTr(eval(['roi_' ROINames{iROI}]), :), 1)) - 1, ['--', ROIColors{iROI}]);
    end;
    for iROI = 1 : size(ROIs, 1);
        trace = nanmean(GetRoiTimeseries(dataFr2, ROIs{iROI, 3})) - 1;
        plot(trace, 'Color', ROIColors2(iROI, :), 'LineStyle', '-');
    end;
    plot(repmat(stimFrames(1), 1, 2), yLims, ':k');
    plot(repmat(stimFrames(end), 1, 2), yLims, ':k');
    set(gca, 'YLim', yLims);
    hold off;
    legend(legendParams{:});
    iSubPlot = iSubPlot + 1;

    subplot(2, 4, iSubPlot);
    title(subPlotTitles{2});
    imagesc(1 : 256, 1 : 256, smoothn(nanmean(dataToPlot{iData}(:, :, stimFrames) - 1, 3), [5 5], 'Gauss'), cLim);
    colorbar();
    axis('square');
    colormap(mapgeog);
    hold on;
    for iROI = 1 : numel(ROINames);
        h = zeros(256 * 256, 1);
        h(eval(['roi_' ROINames{iROI}])) = 1;
        contour(reshape(h, 256, 256), ROIColors{iROI});
    end;
    for iROI = 1 : size(ROIs, 1);
        contour(ROIs{iROI, 3}, 'Color', ROIColors2(iROI, :), 'LineStyle', '-');
    end;
    hold off;
    iSubPlot = iSubPlot + 1;
    
end;

end



