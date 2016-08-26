function fitStats = analyseInterTrialVSEvokedRespCorr(evokedResp, interTrialMeanCorr, statName, ROISet, ...
    stimIDs, grouping, saveName, dirName, doSavePlot)
% scatter between peri-stimulus evoked response and mean inter-trial correlation
 
p = polyfit(interTrialMeanCorr(:), evokedResp(:), 1);
yFit = polyval(p, interTrialMeanCorr(:));
yResid = evokedResp(:) - yFit;
SSResid = sum(yResid .^ 2);
SSTot = (length(evokedResp(:)) - 1) * var(evokedResp(:));
RSquare = 1 - SSResid / SSTot;

fitStats = struct('Slope', p(1), 'RSquare', RSquare);

if doSavePlot;
    
    nROIs = size(interTrialMeanCorr, 2);
    nStims = size(interTrialMeanCorr, 1);
    
    figH = figure('Name', saveName, 'NumberTitle', 'off');
    hold on;
    if strcmp(grouping, 'ROI');
        gscatter(interTrialMeanCorr(:), evokedResp(:), reshape(repmat((1 : nROIs)', 1, nStims)', 1, nStims * nROIs));
        legHand = legend(ROISet(:, 1), 'Location', 'EastOutside');
    elseif strcmp(grouping, 'stim');
        gscatter(interTrialMeanCorr(:), evokedResp(:), repmat((1 : nStims), 1, nROIs));
        legHand = legend(stimIDs, 'Location', 'EastOutside');
    end;
    xlim([- 0.01, max(interTrialMeanCorr(:)) + 0.01]);
    ylim([min(evokedResp(:)) - 1, max(evokedResp(:)) + 1]);
   
%     hScatt = scatter(interTrialMeanCorr(:), evokedResp(:));
%     set(hScatt, 'Marker', 'x', 'MarkerEdgeColor', 'blue');
    
%     stimCol = jet(nStims);
%     ROICol = jet(nROIs);
%     stimCol = lines(nStims);
%     ROICol = lines(nROIs);
%     for iStim = 1 : nStims;
%         for iROI = 1 : nROIs;
%             hScatt = scatter(interTrialMeanCorr(iStim, iROI), evokedResp(iStim, iROI), 40, ...
%                 'MarkerFaceColor', stimCol(iStim, :), 'MarkerEdgeColor', stimCol(iStim, :));
%             hScatt = scatter(interTrialMeanCorr(iStim, iROI), evokedResp(iStim, iROI), 10, ...
%                 'MarkerFaceColor', ROICol(iROI, :), 'MarkerEdgeColor', ROICol(iROI, :));
%         end;
%     end;

    fitLineHandle = plot(interTrialMeanCorr(:), yFit, ':r', 'DisplayName', 'FitLine');
    xlabel('Mean inter-trial correlation');
    ylabel([statName ' evoked response (dFF/dRR) [%]']);
    titleHand = title({[statName ' evoked response VS mean inter-trial correlation'], ...
        sprintf('\\fontsize{10pt} Slope: %5.3f, RSquare: %5.3f', p(1), RSquare)});

    makePrettyFigure(figH);
    set(fitLineHandle, 'LineWidth', 0.5);
    set(titleHand, 'FontSize', 11);
    set(legHand, 'FontSize', 10);
    hold off;
    
    saveFigToDir(figH, saveName, dirName, doSavePlot, 1, 1);
end;

end
