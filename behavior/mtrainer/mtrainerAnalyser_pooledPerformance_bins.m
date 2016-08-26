%% Function - mtrainerAnalyser_pooledPerformance
function figHand = mtrainerAnalyser_pooledPerformance_bins(outAll, titleStr, binWidth)

% dbgLevel = 2;

nTrials = length(outAll.respTypes);

% calculate number of bins, make sure that there is at least one
nBins = max(round(nTrials / binWidth), 1);

figName = titleStr;
figName = strrep(figName, '\_', '_');
figName = strrep(figName, '''', '');
figName = strrep(figName, ' ', '');
figHand = figure('NumberTitle', 'off', 'WindowStyle', 'docked', 'Name', figName);

hitRate = zeros(1, nBins);           % correct detection, CR+, hitRate
% hitRateError = zeros(1, nBins);      % correct detection, CR+, hitRate errors
falsePosRate = zeros(1, nBins);      % false alarm, CR-, false positive
% falsePosRateError = zeros(1, nBins); % false alarm, CR-, false positive errors
dprimes = zeros(1, nBins);           % d prime
% dprimesError = zeros(1, nBins);      % d prime errors

useSEM = 1;
prevNFreqs = 0;
prevNTones = 0;
dprimeMaxVal = 3.5;
dprimeMinVal = -2;
changeOfFreqOrToneNum = zeros(1, nBins);

for iBin = 1 : nBins;
    iStart = (iBin - 1) * binWidth + 1; % for binWidth = 10: 1, 11, 21, etc.
    iEnd = min(iBin * binWidth, nTrials); % for binWidth = 10: 10, 20, 30, etc.
    countsForBin = mtrainerAnalyzer_getCounts(outAll.respTypes(iStart : iEnd));
        
    % extract the current session's number of frequency and number of tones
    nFreqs = outAll.nFreqs(iStart : iEnd);
    nTones = outAll.nTones(iStart : iEnd);
    if ~numel(nFreqs); continue; end;
    nFreqs = nFreqs(1);
    nTones = nTones(1);
    
    % skip basic sessions
%     if nFreqs == 1 && nTones == 1;
%         hitRate(iBin) = NaN;
%         falsePosRate(iBin) = NaN;
%         dprimes(iBin) = NaN;
%         continue;
%     end;
    
    % if there is a change in the number of frequencies or tones, mark it
    if prevNFreqs ~= 0 && (nFreqs ~= prevNFreqs || nTones ~= prevNTones);
        changeOfFreqOrToneNum(iBin) = iBin - 1;
    end;
        
    % store for next iteration
    prevNFreqs = nFreqs;
    prevNTones = nTones;

    hitRate(iBin) = 100 * countsForBin.TGO / countsForBin.T;
    falsePosRate(iBin) = 100 * countsForBin.NTGO / countsForBin.NT;
    if isnan(countsForBin.DPRIME) || isinf(countsForBin.DPRIME);
        countsForBin.DPRIME = 0;
    end;

    % restrict the dprime value between +dprimeMaxVal and -dprimeMaxVal
    countsForBin.DPRIME = min(dprimeMaxVal, countsForBin.DPRIME);
    countsForBin.DPRIME = max(-dprimeMaxVal, countsForBin.DPRIME);

    dprimes(iBin) = countsForBin.DPRIME;
end;

TGOsHand = plot(1 : nBins, hitRate, '-sg', 'MarkerFaceColor', 'green');
% TGOsErrHand = errorbar(1 : nBins, hitRate, hitRateError, '-sg', 'MarkerFaceColor', 'green');
% removeErrorBarEnds(TGOsErrHand);

hold all;
hitRateAxes = gca;
NTNGOsHand = plot((1 : nBins) + 0.15, falsePosRate, '-sr', 'MarkerFaceColor', 'red');
% NTNGOsErrHand = errorbar((1 : nBins) + 0.15, falsePosRate, falsePosRateError, '-sr', 'MarkerFaceColor', 'red');
% removeErrorBarEnds(NTNGOsErrHand);

set(hitRateAxes, 'ylim', [0 110], 'YTick', 0 : 10 : 110, 'YTickLabel', 0 : 10 : 110);

if useSEM;
%     ylabel('% of Trials \pm SEM'); %%#ok<UNRCH>
    ylabel('% of trials'); %%#ok<UNRCH>
else
%     ylabel('% of Trials \pm SD'); %#ok<UNRCH>
    ylabel('% of trials'); %#ok<UNRCH>
end;

vertLineHandles = zeros(1, sum(changeOfFreqOrToneNum > 0));
vertLineTextHandles = zeros(2, sum(changeOfFreqOrToneNum > 0));
iLineHandle = 1;
for iChange = 1 : numel(changeOfFreqOrToneNum);
    if ~changeOfFreqOrToneNum(iChange); continue; end;
    changeX = changeOfFreqOrToneNum(iChange) - 0.5;
    
    iBin = changeOfFreqOrToneNum(iChange);
    iStart = (iBin - 1) * binWidth + 1; % for binWidth = 10: 1, 11, 21, etc.
    iEnd = min(iBin * binWidth, nTrials); % for binWidth = 10: 10, 20, 30, etc.
    
    nFreqs1 = outAll.nFreqs(iStart : iEnd);
    nFreqs1 = nFreqs1(1);
    
    iBin = changeOfFreqOrToneNum(iChange) + 1;
    iStart = (iBin - 1) * binWidth + 1; % for binWidth = 10: 1, 11, 21, etc.
    iEnd = min(iBin * binWidth, nTrials); % for binWidth = 10: 10, 20, 30, etc.
    
    nFreqs2 = outAll.nFreqs(iStart : iEnd);
    nFreqs2 = nFreqs2(1);
    
    if mod(iChange, 2) == 0;
        changeY = 9;
    else
        changeY = 12;
    end;
    
    vertLineTextHandles(1, iLineHandle) = text(changeX, changeY, ...
        sprintf('%d freq \\leftarrow ', nFreqs1), 'HorizontalAlignment', 'right');
    vertLineTextHandles(2, iLineHandle) = text(changeX, changeY, sprintf(' \\rightarrow %d freq', nFreqs2));
    
    vertLineHandles(iLineHandle) = line([changeX changeX], [0 100], ...
        'LineStyle', ':', 'Color', 'black');
    iLineHandle = iLineHandle + 1;
    
    
end;

xlimits = [0 nBins * 1.05];
xlim(xlimits);
set(hitRateAxes, 'XTick', [], 'XTickLabel', []);

xTickAxes = axes('Position', get(gca, 'Position'), ...
    'YAxisLocation', 'right', 'XAxisLocation', 'bottom', 'Color', 'none');
step = nBins / (nTrials / 500);
set(xTickAxes, 'xlim', xlimits, ...
    'XTick', 1 : step : (nBins + 1), 'XTickLabel', 0 : 500 : ((nBins + 1) * binWidth));
set(xTickAxes, 'YTick', [], 'YTickLabel', []);
xlabel('Trials');

dprimeAxes = axes('Position', get(gca, 'Position'), ...
    'YAxisLocation', 'right', 'XAxisLocation', 'top', 'Color', 'none');
hold all;
dprimesHand = plot((1 : nBins) + 0.3, dprimes, '-sb', 'MarkerFaceColor', 'blue');
% dprimesErrHand = errorbar((1 : nBins) + 0.3, dprimes, dprimesError, '-sb', 'MarkerFaceColor', 'blue');
% removeErrorBarEnds(dprimesErrHand);

set(dprimeAxes, 'ylim', [dprimeMinVal dprimeMaxVal], 'YTick', dprimeMinVal : 0.5 : dprimeMaxVal, ...
    'YTickLabel', dprimeMinVal : 0.5 : dprimeMaxVal);
set(dprimeAxes, 'XTick', [], 'XTickLabel', []);
xlim(xlimits);
if useSEM;
%     ylabel('d'' value \pm SEM'); %%#ok<UNRCH>
    ylabel('d'' value'); %%#ok<UNRCH>
else
%     ylabel('d'' value \pm SD'); %#ok<UNRCH>
    ylabel('d'' value'); %#ok<UNRCH>
end;

% legend([TGOsErrHand, NTNGOsErrHand, dprimesErrHand], {'HitRate', 'FalsePos', 'd'''}, ...
%     'Location', 'NorthWest');
legend([TGOsHand, NTNGOsHand, dprimesHand], {'HitRate', 'FalsePos', 'd'''}, ...
    'Location', 'NorthWest');

% title(sprintf('%s \\fontsize{10} [Total number of trials = %.0f, binWidth = %.0f]', ...
%     titleStr, nTrials, binWidth));
title(titleStr);

hold off;
makePrettyFigure(figHand);
set(xTickAxes, 'FontSize', 9);
for iLineHandle = 1 : numel(vertLineHandles);
    set(vertLineHandles(iLineHandle), 'LineWidth', 0.5);
    set(vertLineTextHandles(1, iLineHandle), 'FontSize', 10);
    set(vertLineTextHandles(2, iLineHandle), 'FontSize', 10);
end;
    
end
