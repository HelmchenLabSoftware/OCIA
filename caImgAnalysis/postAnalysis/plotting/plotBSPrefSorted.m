function plotBSPrefSorted(saveName, ROIPrefFitParams, ROIPrefs, ROIPrefSEM, freqIDs, ...
    ROISet, doSaveBFPlotSorted)

%% init
% last one is the population, before last one is the neuropil
nROIs = size(ROIPrefFitParams, 2) - 1;

%% adjust Y-scale: get the right range for plotting
maxROIPref = -Inf;
minROIPref = Inf;
for iROI = 1 : nROIs + 1;
    maxROIPref = max([ROIPrefs{iROI}(:)' + ROIPrefSEM{iROI}(:)' maxROIPref]);
    minROIPref = min([ROIPrefs{iROI}(:)' - ROIPrefSEM{iROI}(:)' minROIPref]);
end;
% offset this max and min so that every trace fits in the plot
maxROIPref = maxROIPref * 1.1;
minROIPref = minROIPref * 1.1;

%% Plot BF Pref sorted and with polyfit slope for each ROI
for iROI = 1 : nROIs + 1;

    log2FreqIDs = log2(freqIDs);
    log2kHzFreqIDs = log2(freqIDs / 1000);
    
    [ROIPrefForROI, ROIPrefSortedIndexes] = sort(ROIPrefs{iROI}, 'descend');
    [slopeOffset, fitValues] = polyfit(log2FreqIDs, ROIPrefForROI', 1);
    ROIPrefSEMForROI = ROIPrefSEM{iROI}(ROIPrefSortedIndexes);
    
    % if it's the last ROI, it's the data for all ROIs (population)
    if iROI == nROIs;
        saveNameBF = sprintf('%s_BestFreqSorted_Npil', saveName);
    elseif iROI == nROIs + 1;
        saveNameBF = sprintf('%s_BestFreqSorted_All_ROIs', saveName);
    else
        saveNameBF = sprintf('%s_BestFreqSorted_ROI%s', saveName, ROISet{iROI, 1});
    end;
    figBF = figure('Name', saveNameBF, 'NumberTitle', 'off');

    hErr = errorbar(log2kHzFreqIDs, ROIPrefForROI, ROIPrefSEMForROI);
    removeErrorBarEnds(hErr);
    hold on;
    plot(log2kHzFreqIDs, polyval(slopeOffset, log2FreqIDs), 'r');
    
%     roundFreqs = freqIDs(~mod(freqIDs, 1)) / 1000;
%     set(gca, 'XTick', log2(roundFreqs));
%     set(gca, 'XTickLabel', roundFreqs);

    set(gca, 'XTick', log2kHzFreqIDs);
    set(gca, 'XTickLabel', round(freqIDs(ROIPrefSortedIndexes) / 100) / 10);
    ylim([floor(minROIPref) ceil(maxROIPref)]);
    xlim([min(log2kHzFreqIDs) - 0.1 max(log2kHzFreqIDs) + 0.1]);
    ylabel('DFF/DRR [%]');
    xlabel('Frequency [kHz]');
    
    titleStr = regexprep(saveNameBF, 'ROIStats_[\d_]+[A-Za-z0-9]+_spot\d+_BestFreqSorted_', '');
    titleStr = sprintf('%s slope: %f, normR: %.2f', titleStr, slopeOffset(1), fitValues.normr);
    title(titleStr, 'Interpreter', 'none');
    
    makePrettyFigure(figBF);
    
    if doSaveBFPlotSorted > 1;
        if exist('ROIBF', 'dir') ~= 7; mkdir('ROIBF'); end;
        saveNameBF = ['ROIBF/' saveNameBF]; %#ok<AGROW>
        saveas(figBF, saveNameBF);
        saveas(figBF, [saveNameBF '.png']);
        close(figBF);
    end;
end;

end