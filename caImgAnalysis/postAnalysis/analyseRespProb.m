function [respTrials, respProb, respProbErr] = analyseRespProb(PSROIStats, respThresh, ...
    PSFrames, ROISet, stimIDs, saveName, doSavePlot)
    
nStims = size(PSROIStats, 2);
nROIs = size(ROISet, 1);
nTrials = size(PSROIStats{1, 1}, 1);
respTrials = nan(nTrials, nROIs, nStims);
respMean = nan(nROIs, nStims);
respProb = nan(nROIs, nStims);
respProbErr = nan(nROIs, nStims);

% NPilIndex = find(cellfun(@(ROIID)strcmp(ROIID, 'NPil'), ROISet(:, 1))); %#ok<EFIND>
% if isempty(NPilIndex); warning('analyseRespTTest:NoNPil', 'No neuropil ! Aborting.'); return; end;
  
%% calculate response on each trial
% go trough each stim and each ROI
for iStim = 1 : nStims;
    for iROI = 1 : nROIs;
        for iTrial = 1 : nTrials;
            frames = PSROIStats{iROI, iStim}(iTrial, :);
            base = frames(1 : PSFrames.base);
            evoked = frames((PSFrames.base + 1) : (PSFrames.base + PSFrames.evoked));
%             respTrials(iTrial, iROI, iStim) = (mean(evoked) - mean(base)) / (0.5 * (var(evoked) + var(base)));
%             respTrials(iTrial, iROI, iStim) = (max(evoked) - max(base)) / (0.5 * (var(evoked) + var(base)));
            respTrials(iTrial, iROI, iStim) = (mean(maxnpp(evoked, 3)) - mean(maxnpp(base, 3))) ...
                / (0.5 * (var(maxnpp(evoked, 3)) + var(maxnpp(base, 3))));
%             respTrials(iTrial, iROI, iStim) = mean(evoked) - mean(base);
%             respTrials(iTrial, iROI, iStim) = (max(evoked) - max(base)) / (0.5 * (var(evoked) + var(base)));
        end;
    end;
end;
respBin = respTrials > respThresh;

%% calculate response probability for all trials
% go trough each stim and each ROI
for iStim = 1 : nStims;
    for iROI = 1 : nROIs;
        respMean(iROI, iStim) = mean(respTrials(:, iROI, iStim));
        respProb(iROI, iStim) = mean(respBin(:, iROI, iStim));
        respProbErr(iROI, iStim) = sem(respBin(:, iROI, iStim));
    end;
end;
   
%% plotting
if doSavePlot;
%     PSTime = ((1 : (PSFrames.base + PSFrames.evoked)) - PSFrames.base) / 10;
    PSTimeBase = (-PSFrames.base : (0 - 1)) / 10;
    PSTimeEvoked = (0 : (PSFrames.evoked - 1)) / 10;
    M = 4; N = 10;
    for iStim = 1 : nStims;
%         iStim = 11; ROIs = [6 22 23 24];
%         for yROI = 1 : numel(ROIs);
%           iROI = ROIs(yROI);
        for iROI = 1 : nROIs;
            saveNameROIStim = sprintf('ROI%sStim%s_max3pp, thresh: %3.1f.', ROISet{iROI, 1}, stimIDs{iStim}, respThresh);
            figure('Name', [saveName, '_', saveNameROIStim], 'NumberTitle', 'off');
            ylims = [floor(min(PSROIStats{iROI, iStim}(:))), ceil(max(PSROIStats{iROI, iStim}(:)))];
            for iTrial = 1 : nTrials;
                subplot(M, N, iTrial);
                frames = PSROIStats{iROI, iStim}(iTrial, :);
                base = frames(1 : PSFrames.base);
                evoked = frames(PSFrames.base + 1 : (PSFrames.base + PSFrames.evoked));
                hold on;
                plot(PSTimeBase, base, 'k');
                [max3ppBase, max3ppBaseInd] = maxnpp(base, 3);
                scatter(PSTimeBase(max3ppBaseInd), max3ppBase, 'xk');
                plot([PSTimeBase(end) PSTimeEvoked(1)], [base(end) evoked(1)], 'Color', repmat(0.7, 1, 3));
                plot(PSTimeEvoked, evoked, 'r');
                [max3ppEvoked, max3ppEvokedInd] = maxnpp(evoked, 3);
                scatter(PSTimeEvoked(max3ppEvokedInd), max3ppEvoked, 'xr');
                if respTrials(iTrial, iROI, iStim) >= respThresh;
                    set(gca, 'Color', [0.8, 1, 0.8]);
                else
                    set(gca, 'Color', [1, 0.8, 0.8]);
                end
                set(gca, 'XLim', [PSTimeBase(1) - 0.05, PSTimeEvoked(end) + 0.05], 'YLim', ylims);
                if mod(iTrial - 1, N); set(gca, 'YTick', []); end;
                if iTrial <= nTrials - N; set(gca, 'XTick', []); end;
                title(sprintf('d'' = %4.2f', respTrials(iTrial, iROI, iStim)));
                hold off;
            end;
            suptitle(strrep(saveNameROIStim, '_', '\_'));
        end;
    end;
end;
end
