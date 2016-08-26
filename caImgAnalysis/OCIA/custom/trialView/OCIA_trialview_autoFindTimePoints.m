function [this, peakTimes, frameCorrsROI] = OCIA_trialview_autoFindTimePoints(this, ~, ~)
% OCIA_trialview_autoFindTimePoints - Find time points in the behavior movie
%
%       [this, peakTimes, frameCorrsROI] = OCIA_trialview_autoFindTimePoints(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

showMessage(this, 'TrialView: Auto-find time points ...', 'yellow');

doDebugPlot = true;
figPos = [100 85 1725 1015];

% read a frame to draw ROI
VRHBehav = this.tv.VRHBehav;
VRHBehav.CurrentTime = VRHBehav.Duration * 0.5;
refFrame = nanmean(VRHBehav.readFrame(), 3);
imgDim = size(refFrame);

%% display frame and draw ROI
showMessage(this, 'TrialView: Auto-find time points in behavior movie: drawing ROI ...', 'yellow');
figH = figure('Position', [100 85 1725 1015]);
refFrame = PseudoFlatfieldCorrect(refFrame);
imagesc(1 : imgDim(1), 1 : imgDim(2), refFrame);
set(gca, 'XTick', [], 'YTick', [], 'CLim', [0.1 0.5]);
tightfig(gcf);
set(gcf, 'Position', figPos);
colormap('gray');

ROIHandle = imfreehand(gca);
ROIMask = ROIHandle.createMask();
ROIPos = ROIHandle.getPosition();
close(figH);

showMessage(this, 'TrialView: Auto-find time points: calculating ROI area ...', 'yellow');
% get the x and y positions of this ROI's pixels
ROIPixels = unique(find(ROIMask > 0));
[yVals, xVals] = ind2sub(imgDim([1, 2]), ROIPixels);

% get the bounding box of this ROI
ROIXRange = round([min(xVals), max(xVals)]);
ROIYRange = round([min(yVals), max(yVals)]);
% skip if the ROI with bounding box is not completely in the image 
if ROIXRange(1) < 1 || ROIXRange(end) > imgDim(2) || ROIYRange(1) < 1 || ROIYRange(end) > imgDim(1);
    showMessage(this, 'TrialView: Auto-find time points: ROI area out of bounds, aborting.', 'red');
    return;
end;

% empty memory and calculate dimensions
clear('xVals', 'yVals', 'ROIPixels');
ROIImgDim = abs([diff(ROIXRange), diff(ROIYRange)]);

%% load the movie for the ROI-related area
% set time to 0
VRHBehav.CurrentTime = 0;
targetFrameRateBehav = 5;
nTotFramesEstim = round(VRHBehav.Duration * targetFrameRateBehav);
iFrame = 1;

imgMovie = nan(ROIImgDim(2), ROIImgDim(1), nTotFramesEstim);
while hasFrame(VRHBehav);
    
    % get frame and time
    currFrame = nanmean(VRHBehav.readFrame(), 3);
    
    % update time
    if VRHBehav.CurrentTime + (1 / targetFrameRateBehav) > VRHBehav.Duration; break; end;
    VRHBehav.CurrentTime = VRHBehav.CurrentTime + (1 / targetFrameRateBehav);
    
    % pre-process frame
    currFrame = PseudoFlatfieldCorrect(currFrame);
    currFrame(~ROIMask) = NaN;
    imgMovie(:, :, iFrame) = currFrame(ROIYRange(1) : ROIYRange(2) - 1, ROIXRange(1) : ROIXRange(2) - 1);
    
    
    loadText = sprintf('Loaded frame %04d / %04d (%07.2fs / %07.2fs)', iFrame, nTotFramesEstim, ...
        VRHBehav.CurrentTime, VRHBehav.Duration);
    fprintf([repmat('\b', 1, numel(loadText) + 12) 'TrialView: %s\n'], loadText);
    iFrame = iFrame + 1;
    
end;

% remove NaN frames
imgMovie(:, :, all(all(isnan(imgMovie), 1), 2)) = [];
nFrames = size(imgMovie, 3);

%% calculate frame-wise correlation
frameCorrsROI = nan(1, nFrames - 1);
parfor iFrame = 1 : (nFrames - 1);
    % get the correlation coefficient of each frames compared to the average
    frameCorrMat = corrcoef(imgMovie(:, :, iFrame + 1), imgMovie(:, :, iFrame), 'rows', 'pairwise'); %#ok<PFBNS>
    % extract the inter-frame correlation coefficient
    frameCorrsROI(iFrame) = frameCorrMat(1, 2);
end;

%% extract peaks
nFramesWF = 200; frameRateWF = 20;
if targetFrameRateBehav == 5;        frameRateFactor = 1.1682;
elseif targetFrameRateBehav == 2;    frameRateFactor = 1.068;
else                            frameRateFactor = 1;
end;
t = ((2 : nFrames) / targetFrameRateBehav * frameRateFactor);

peakTrace = 1 - frameCorrsROI;
% peakTrace = sgolayfilt(peakTrace, 1, 3);
thresh = 0.01; minDist = 1 * targetFrameRateBehav;
[peaksY, peaksX] = findpeaks(peakTrace, 'MinPeakHeight', thresh, 'MinPeakDistance', minDist);
peakTimes = t(peaksX);

% find behavior times
startTimes = this.tv.data.behav.times.start;
rewTimes = this.tv.data.behav.times.rewTime';
soundTimes = this.tv.data.behav.times.sound';
imgStartTimes = this.tv.data.behav.times.imgStart';
trialStartCueTimes = this.tv.data.behav.times.trialStartCue';

soundTimes(isnan(startTimes)) = 0;
imgStartTimes(isnan(startTimes)) = 0;
trialStartCueTimes(isnan(startTimes)) = 0;
startTimes(isnan(startTimes)) = 0;

startTimeStamps = datestr(unix2dn(startTimes * 1000), 'yyyymmdd_HHMMSS.FFF');
startUNIXTrial1 = dn2unix(datenum(startTimeStamps(1, 10 : 18), 'HHMMSS.FFF'));
startsUNIXMilliSec = dn2unix(datenum(startTimeStamps(:, 10 : 18), 'HHMMSS.FFF')) - startUNIXTrial1;

rewTimeUNIXMilliSec = startsUNIXMilliSec + rewTimes * 1000;
soundTimeUNIXMilliSec = startsUNIXMilliSec + soundTimes * 1000;
imgStartTimeUNIXMilliSec = startsUNIXMilliSec + imgStartTimes * 1000;
trialStartCueTimeUNIXMilliSec = startsUNIXMilliSec + trialStartCueTimes * 1000;

finalRewTimes = round(rewTimeUNIXMilliSec) / 1000 + this.tv.params.behavTimeOffset;
finalSoundTimes = round(soundTimeUNIXMilliSec) / 1000 + this.tv.params.behavTimeOffset;
finalImgStartTimes = round(imgStartTimeUNIXMilliSec) / 1000 + this.tv.params.behavTimeOffset;
finalImgEndTimes = finalImgStartTimes + (nFramesWF / frameRateWF);
finalTrialStartCueTimes = round(trialStartCueTimeUNIXMilliSec) / 1000 + this.tv.params.behavTimeOffset;
realSoundTimes = finalImgStartTimes + stimStartFrame / frameRateWF;

noNaNRewTimes = finalRewTimes(~isnan(finalRewTimes));
noNaNSoundTimes = finalSoundTimes(~isnan(finalRewTimes));
realSoundTimes = realSoundTimes(~isnan(finalRewTimes));

% match reward times and peaks
diffMat = abs(repmat(noNaNRewTimes, 1, numel(peakTimes)) - repmat(peakTimes, numel(noNaNRewTimes), 1));
[~, minIndexes] = min(diffMat, [], 2);
if numel(minIndexes) ~= unique(minIndexes);
    showMessage(this, 'TrialView: Auto-find time points: multi-match for some trials ...');
end;
matchedPeaksX = peaksX(minIndexes); %#ok<NASGU>
matchedPeaksY = peaksY(minIndexes);
matchedPeakTimes = peakTimes(minIndexes);

% debug plot
if doDebugPlot;
    figure('Position', figPos, 'Color', 'white');
    
    subplot(3, 3, 1);
    imagesc(1 : imgDim(1), 1 : imgDim(2), refFrame);
    set(gca, 'XTick', [], 'YTick', [], 'CLim', [0.1 0.5]);
    colormap(gray);
    imfreehand(gca, ROIPos);
    title('Reference frame with ROI labeled');
    
    subplot(3, 3, 2);
    plot(frameCorrsROI);
    xlim([1 numel(frameCorrsROI)]);
    xlabel('Frames');
    ylabel('Frame-to-frame correlation')
    title(sprintf('Measured at %.1f Hz frame rate (movie: %.1f Hz)', targetFrameRateBehav, VRHBehav.FrameRate));
    
    subplot(3, 3, 3);
    plotHands = [];
    plotHands(end + 1) = plot(t, peakTrace);
    hold on;
    plotHands(end + 1) = scatter(peakTimes, peaksY, 100, 'blue', 'Marker', 'o'); %#ok<*MSNU>
    plotHands(end + 1) = scatter(matchedPeakTimes, matchedPeaksY, 100, 'green', 'Marker', 'o');
    lineHands = line(repmat(finalRewTimes', 2, 1), ...
        repmat([min(peakTrace); max(peakTrace)], 1, numel(finalRewTimes)), 'Color', 'red'); %#ok<*NASGU>
    plotHands(end + 1) = lineHands(1);
    lineHands = line(repmat(finalSoundTimes', 2, 1), ...
        repmat([min(peakTrace); max(peakTrace)], 1, numel(finalSoundTimes)), 'Color', 'green');
    plotHands(end + 1) = lineHands(1);
    lineHands = line(repmat(realSoundTimes', 2, 1), ...
        repmat([min(peakTrace); max(peakTrace)], 1, numel(realSoundTimes)), 'Color', [0 0.5 0]);
    plotHands(end + 1) = lineHands(1);
    lineHands = line(repmat(finalImgStartTimes', 2, 1), ...
        repmat([min(peakTrace); max(peakTrace)], 1, numel(finalImgStartTimes)), 'Color', 'blue');
    plotHands(end + 1) = lineHands(1);
    lineHands = line(repmat(finalImgEndTimes', 2, 1), ...
        repmat([min(peakTrace); max(peakTrace)], 1, numel(finalImgEndTimes)), 'Color', 'blue');
    plotHands(end + 1) = lineHands(1);
    lineHands = line(repmat(finalTrialStartCueTimes', 2, 1), ...
        repmat([min(peakTrace); max(peakTrace)], 1, numel(finalTrialStartCueTimes)), 'Color', 'cyan');
    plotHands(end + 1) = lineHands(1);
    
    hold off;
    set(gca, 'XLim', [826 842], 'YLim', [0 0.05]);
    xlabel('Time [s]');
    ylabel('1 - (frame-to-frame correlation)');
    set(plotHands(2), 'MarkerEdgeColor', 'blue');
    legend(plotHands, 'corr.', 'detected peaks', 'validated peaks', 'T_{rew[TS]}', 'T_{sound[TS]}', ...
        'T_{sound[AI]}', 'T_{imgStart[TS]}', 'T_{imgEnd[TS]}', 'T_{light[TS]}', 'Location', 'EastOutside');
    
    subplot(3, 3, [4 5 6]);
    plotHands = [];
    plotHands(end + 1) = plot(t, peakTrace);
    hold on;
    plotHands(end + 1) = scatter(peakTimes, peaksY, 100, 'blue', 'Marker', 'o'); %#ok<*MSNU>
    plotHands(end + 1) = scatter(matchedPeakTimes, matchedPeaksY, 100, 'green', 'Marker', 'o');
    lineHands = line(repmat(finalRewTimes', 2, 1), ...
        repmat([min(peakTrace); max(peakTrace)], 1, numel(finalRewTimes)), 'Color', 'red');
    plotHands(end + 1) = lineHands(1);
    lineHands = line(repmat(finalSoundTimes', 2, 1), ...
        repmat([min(peakTrace); max(peakTrace)], 1, numel(finalSoundTimes)), 'Color', 'green');
    plotHands(end + 1) = lineHands(1);
    lineHands = line(repmat(realSoundTimes', 2, 1), ...
        repmat([min(peakTrace); max(peakTrace)], 1, numel(realSoundTimes)), 'Color', [0 0.5 0]);
    plotHands(end + 1) = lineHands(1);
    lineHands = line(repmat(finalImgStartTimes', 2, 1), ...
        repmat([min(peakTrace); max(peakTrace)], 1, numel(finalImgStartTimes)), 'Color', 'blue');
    plotHands(end + 1) = lineHands(1);
    lineHands = line(repmat(finalImgEndTimes', 2, 1), ...
        repmat([min(peakTrace); max(peakTrace)], 1, numel(finalImgEndTimes)), 'Color', 'blue');
    plotHands(end + 1) = lineHands(1);
    lineHands = line(repmat(finalTrialStartCueTimes', 2, 1), ...
        repmat([min(peakTrace); max(peakTrace)], 1, numel(finalTrialStartCueTimes)), 'Color', 'cyan');
    plotHands(end + 1) = lineHands(1);
    hold off;
    xlim([t(1) t(end)]);
    xlabel('Time [s]');
    ylabel('1 - (frame-to-frame correlation)');
    
    subplot(3, 3, [7 8 9]);
    plot(1 : numel(noNaNRewTimes), matchedPeakTimes' - noNaNRewTimes);
    xlabel('Rewarded trials');
    ylabel('\Delta time [s]')
    legend('T_{rew[TS]} - T_{rew}(movie) [s]', 'Location', 'SouthEast');
    ylim([-0.35 0.35]);
    title(sprintf('Frame rate correction factor: %.4f', frameRateFactor));
    
%     export_fig('analysis/reward_time_alignment.png', '-r300', gcf);
%     export_fig('analysis/reward_time_alignment.fig', gcf);
end;


showMessage(this, 'TrialView: Auto-find time points in behavior movie done.');

end
