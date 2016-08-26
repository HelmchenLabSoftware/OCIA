%% Function - mtrainerAnalyser_pooledPerformance
function figHand = mtrainerAnalyser_freqAnalysis_bins(outAll, titleStr, binWidth)

dbgLevel = 2;

nFreqs = 5;

% for each trial: 1 = correct detect, 2 = correct reject, 3 = false alarm, 4 = miss, 5 = early
respTypes = outAll.respTypes(outAll.nFreqs == nFreqs);
freqs = outAll.freqs(outAll.nFreqs == nFreqs);
uniqueFreqs = unique(freqs);
goFreq = unique(outAll.goFreq(outAll.nFreqs == nFreqs));

figHand = 0;

if numel(goFreq) > 1; o('Oh-oh. Problem ! Multiple go freqs', 1, dbgLevel); return; end;

nTrials = length(respTypes);

% calculate number of bins, make sure that there is at least one
nBins = max(round(nTrials / binWidth), 1);

figName = titleStr;
figName = strrep(figName, '\_', '_');
figName = strrep(figName, '''', '');
figName = strrep(figName, ' ', '');
figHand = figure('NumberTitle', 'off', 'WindowStyle', 'docked', 'Name', figName);

% errors = nan(nFreqs, nBins);
errors = nan(nFreqs - 1, nBins);
    
for iBin = 1 : nBins;
    iStart = (iBin - 1) * binWidth + 1; % for binWidth = 10: 1, 11, 21, etc.
    iEnd = min(iBin * binWidth, nTrials); % for binWidth = 10: 10, 20, 30, etc.
    
    
    for iFreq = 1 : nFreqs;
        
        respTypesForFreq = respTypes(freqs(iStart : iEnd) == uniqueFreqs(iFreq));
        o('Bin %d - freq %d, respTypes: %d', iBin, iFreq, numel(respTypesForFreq), 3, dbgLevel);
        
        if uniqueFreqs(iFreq) == goFreq;
            continue;
%             errors(iFreq, iBin) = 100 * sum(respTypesForFreq == 4) / numel(respTypesForFreq);
        else
            errors(iFreq, iBin) = 100 * sum(respTypesForFreq == 3) / numel(respTypesForFreq);
        end;
        
    end;
    
end;

errors = errors(setdiff(1 : nFreqs, find(uniqueFreqs == goFreq)), :);

colors = lines(nFreqs - 1);
% colors = lines(nFreqs);
plotHandles = plot(errors', '-s');
for iHandle = 1 : numel(plotHandles);
    set(plotHandles(iHandle), 'Color', colors(iHandle, :), 'MarkerFaceColor', colors(iHandle, :));
end;

% legend({'4kHz', '8kHz', '12kHz', '16kHz', '20kHz'});
legend({'4kHz', '8kHz', '16kHz', '20kHz'});
ylabel('Errors in %');

step = nBins / (nTrials / 500);
set(gca, 'xlim', [0.8 nBins + 0.2], 'XTick', 1 : step : (nBins + 1), ...
    'XTickLabel', 0 : 500 : ((nBins + 1) * binWidth));
% set(gca, 'YTick', [], 'YTickLabel', []);
xlabel('Trials');
title(titleStr);

makePrettyFigure(figHand);

end
