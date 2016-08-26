function figHands = plotPSTrace(PSROIStats, PSTime, ROISet, stimIDs, saveName, nROIPerFig, plotSingleTrials)

% init the size of the data set
nROIs = size(PSROIStats, 1);
nStims = size(PSROIStats, 2);
nTrials = size(PSROIStats{1, 1}, 1);
grayCol = repmat(0.7, 1, 3);

% % normalize limits for all plots
% yLims = [floor(min(min(cell2mat(PSROIStats(:))))) ceil(max(max(cell2mat(PSROIStats(:)))))];
        
PSTimeStims = repmat(PSTime', 1, nTrials);
% PSTimeStims = PSTimeStims + repmat(xShift * (1 : nTrials), nFrames, 1) - xShift; % small shift for each trace

%% plot each group of ROIs in separate figures
subplotCounter = 1;
figHands = [];
for iROI = 1 : nROIs;
    if ~mod(iROI + nROIPerFig - 1, nROIPerFig);
        figHands(end + 1) = figure('Name', sprintf('%s_ROI%s-ROI%s', saveName, ROISet{iROI, 1}, ...
            ROISet{min(iROI + nROIPerFig - 1, nROIs), 1}), 'NumberTitle', 'off'); %#ok<AGROW>
        subplotCounter = 1;
    end;
    
    % normalize limits for each ROI
    allValues = cell2mat(PSROIStats(iROI, :));
    if plotSingleTrials;
        yLims = [floor(min(allValues(:))) ceil(max(allValues(:)))];
    else
        maxValue = -Inf; minValue = Inf;
        for iStim = 1 : nStims;
            subplot(nROIPerFig, nStims, subplotCounter);
            % normalize the traces with their minimum
            caTraces = PSROIStats{iROI, iStim}';
            maxValue = max([nanmean(caTraces, 2); maxValue]);
            minValue = min([nanmean(caTraces, 2); minValue]);
        end;
        yLims = [floor(minValue), ceil(maxValue)];
    end;
    
    for iStim = 1 : nStims;
        subplot(nROIPerFig, nStims, subplotCounter);
        % normalize the traces with their minimum
        caTraces = PSROIStats{iROI, iStim}';
%         caTraces = caTraces - repmat(min(caTraces), nFrames, 1);
        if plotSingleTrials;
            % plot all trials
            plotHands = plot(PSTimeStims, caTraces);
            hold on;
            % make the traces of all trials gray
            for iHand = 1 : numel(plotHands); set(plotHands(iHand), 'Color', grayCol); end;
        end;
        % plot the average in red as an error-bar plot
        errBarHand = errorbar(PSTime, nanmean(caTraces, 2), nansem(caTraces, 2), 'Color', 'red', 'LineWidth', 1.5);
        removeErrorBarEnds(errBarHand);

        % set common Y and X limits for all plots
        set(gca, 'YLim', yLims, 'XLim', [PSTime(1) - 0.05 PSTime(end) + 0.05], 'FontSize', 6);
        % only plot Y axis on left-most plots
        if iStim ~= 1; set(gca, 'YTick', []);
        else ylabel(sprintf('ROI%s', ROISet{iROI, 1})); end;
        % only plot X axis on bottom plots
        if mod(iROI + nROIPerFig, nROIPerFig); set(gca, 'XTick', []); end;
%         else xlabel('Time [s]'); end
        % only plot title on top-most plots
        if ~mod(iROI + nROIPerFig - 1, nROIPerFig); title(stimIDs{iStim}, 'FontSize', 8); end

        hold off;
        subplotCounter = subplotCounter + 1;
    end;
    
    if ~mod(iROI + nROIPerFig - 1, nROIPerFig);
        suptitle(sprintf('Evoked responses for each stimulus for ROIs %s-%s', ...
            ROISet{iROI, 1}, ROISet{min(iROI + nROIPerFig - 1, nROIs), 1}));
    end;
end;

end

