function plotBSPref(saveName, tuningStruct, ROISet, stimIDs, sameYLim, BSStat, doSaveBSOvlPlot, doSaveBSPlot, stimLabel)
% Generate a best stimulus preference plot based on the chosen statistics
%
% Usage: plotBSPref(saveName, tuningStruct, ROISet, stimIDs, sameYLim, BSStat, doSaveBSOvlPlot, doSaveBSPlot, stimLabel)
%
% Author: B. Laurency, 2013
    
%% init
nROIs = size(ROISet, 1);
nStims = size(stimIDs, 1);

statTypes = unique(strrep(fieldnames(tuningStruct), 'Err', ''));
nStats = numel(statTypes);
iTargetStat = find(strcmp(statTypes, BSStat));


%% adjust Y-scale: get the right range for plotting
yLims = struct();
tunings = nan(nStats, nROIs, nStims);
tuningsNorm = nan(nStats, nROIs, nStims);
tuningsErr = nan(nStats, nROIs, nStims);
tuningsErrNorm = nan(nStats, nROIs, nStims);

% offset this max and min so that every trace fits in the plot
for iStat = 1 : nStats;
    tuning = tuningStruct.(statTypes{iStat});
    
    tunings(iStat, :, :) = tuning';
    if isfield(tuningStruct, [statTypes{iStat}, 'Err']);
        tuningsErr(iStat, :, :) = tuningStruct.([statTypes{iStat}, 'Err'])';
    else
        tuningsErr(iStat, :, :) = zeros(nROIs, nStims);
    end;
    
    normTuning = (tuning - repmat(min(tuning), nStims, 1));
    normTuning = normTuning ./ repmat(max(normTuning), nStims, 1);
    tuningsNorm(iStat, :, :) = normTuning';
    if isfield(tuningStruct, [statTypes{iStat}, 'Err']);
        tuningsErrNorm(iStat, :, :) = (tuningStruct.([statTypes{iStat}, 'Err']) ./ repmat(max(tuning), nStims, 1))';
    else
        tuningsErrNorm(iStat, :, :) = zeros(nROIs, nStims);
    end;
    
%     tuningsErr(iStat, :, :) = tuningStruct.([statTypes{iStat}, 'Err'])';
    if sameYLim;
        yLims.(statTypes{iStat}) = [floor(min(tuning(:)) * 1.1), ceil(max(tuning(:)) * 1.1)];
    else
        yLims.(statTypes{iStat}) = [];
    end;
end


% for iROI = 1 : nROIs;
%     errorbar(1 : nStims, respRegr(iROI, :), respRegrCI(iROI, :, 1) - respRegr(iROI, :), respRegrCI(iROI, :, 2) - respRegr(iROI, :));
% end;
    

%% plot for each ROI
for iROI = 1 : nROIs + 1;

    % if it's the last ROI, it's the data for all ROIs (population)
    if iROI == nROIs + 1;
        saveNameBS = sprintf('%s_BestStim_All_ROIs', saveName);
        tuningForROINorm = reshape(mean(tuningsNorm, 2), nStats, nStims);
        tuningErrForROINorm = reshape(mean(tuningsErrNorm, 2), nStats, nStims);
        tuningForROI = reshape(mean(tunings, 2), nStats, nStims);
        tuningErrForROI = reshape(mean(tuningsErr, 2), nStats, nStims);
%         pvalForROI = ones(nStims, 1);
    else
        saveNameBS = sprintf('%s_BestStim_ROI_%s', saveName, ROISet{iROI, 1});
        tuningForROINorm = reshape(tuningsNorm(:, iROI, :), nStats, nStims);
        tuningErrForROINorm = reshape(tuningsErrNorm(:, iROI, :), nStats, nStims);
        tuningForROI = reshape(tunings(:, iROI, :), nStats, nStims);
        tuningErrForROI = reshape(tuningsErr(:, iROI, :), nStats, nStims);
%         pvalForROI = tuningPVals(iROI, :);
    end;
    
    % plot the overlay
    if doSaveBSOvlPlot;
        figBSOvl = figure('Name', [saveNameBS '_overlay'], 'NumberTitle', 'off');
        xVal = repmat(1 : nStims, nStats, 1)' + repmat(1 : nStats, nStims, 1) / 30;
        errHands = errorbar(xVal, tuningForROINorm', tuningErrForROINorm');
        for iHand = 1 : numel(errHands); removeErrorBarEnds(errHands(iHand)); end;
        set(gca, 'XLim', [0.5, nStims + 0.5], 'XTick', 1 : nStims, 'XTickLabel', stimIDs);
        ylabel('Evoked response');
        xlabel(stimLabel);
        legend(statTypes, 'Location', 'NorthWest');
        title([saveNameBS '_overlay'], 'Interpreter', 'none');
        makePrettyFigure(figBSOvl);
        set(gca, 'FontSize', 8);
        tightfig();
        saveFigToDir(figBSOvl, [saveNameBS '_overlay'], 'ROIBS', doSaveBSOvlPlot, 1, 1);
    end;
    
    % plot the single trace
    if doSaveBSPlot;
        figBS = figure('Name', [saveNameBS '_' BSStat], 'NumberTitle', 'off');
        errHand = errorbar(1 : nStims, tuningForROI(iTargetStat, :), tuningErrForROI(iTargetStat, :));
        removeErrorBarEnds(errHand);
        set(gca, 'XLim', [0.5, nStims + 0.5], 'XTick', 1 : nStims, 'XTickLabel', stimIDs);
        if ~isempty(yLims.(BSStat)); ylim(yLims.(BSStat)); end;
        ylabel('Evoked response');
        xlabel(stimLabel);
        title([saveNameBS '_' BSStat], 'Interpreter', 'none');
        makePrettyFigure(figBS);
        set(gca, 'FontSize', 8);
        tightfig();
        saveFigToDir(figBS, [saveNameBS '_' BSStat], 'ROIBS', doSaveBSPlot, 1, 1);
    end;
end;

end