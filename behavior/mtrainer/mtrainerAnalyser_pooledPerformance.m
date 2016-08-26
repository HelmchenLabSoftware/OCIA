%% Function - mtrainerAnalyser_pooledPerformance
function mtrainerAnalyser_pooledPerformance(outAll, titleStr)

dbgLevel = 2;

uniqueDays = unique(cellstr(datestr(outAll.datesAsNum, 'yyyymmdd')));
nDays = numel(uniqueDays);
o('#mtrain...pooledPerf: %d trial(s) in %d day(s).', numel(outAll.respTypes), nDays, 1, dbgLevel);

runs = unique(cellstr(datestr(outAll.datesAsNum, 'yyyymmdd_HHMMSS')));
nextSessThreshIndiv = 0.08; % pool data with morning and afternoon sessions separately
% nextSessThreshIndiv = 0.0005; % pool data with each run (100 trials) separately
nextSessThreshDaily = 0.35; % pool data daily

[~, sessionIndexesIndiv, nTrialsPerSessIndiv] = separateIntoSessions(outAll, runs, ...
    nextSessThreshIndiv, dbgLevel);
[runs, sessionIndexesDaily, nTrialsPerSessDaily] = separateIntoSessions(outAll, runs, ...
    nextSessThreshDaily, dbgLevel); %#ok<ASGLU>

sessionIndexes = sessionIndexesDaily;
nTrialsPerSess = nTrialsPerSessDaily;
nSessionIndiv = max(sessionIndexesIndiv);
nSessionDaily = max(sessionIndexesDaily);
nSession = nSessionDaily;

o('#mtrain...pooledPerf: found %d daily session(s) and %d individual session(s).', ...
    nSessionDaily, nSessionIndiv, 2, dbgLevel);
o('#mtrain...pooledPerf: mean nTrials per day: %03.0f, per indiv session: %03.0f.', ...
    mean(nTrialsPerSessDaily), mean(nTrialsPerSessIndiv), 2, dbgLevel);

figName = titleStr;
figName = strrep(figName, '\_', '_');
figName = strrep(figName, '''', '');
figName = strrep(figName, ' ', '');
figHand = figure('NumberTitle', 'off', 'WindowStyle', 'docked', 'Name', figName);

hitRate = zeros(1, nSession);          % correct detection, CR+, hitRate
hitRateError = zeros(1, nSession);     % correct detection, CR+, hitRate errors
falsePosRate = zeros(1, nSession);     % false alarm, CR-, false positive
falsePosRateError = zeros(1, nSession);% false alarm, CR-, false positive errors
dprimes = zeros(1, nSession);          % d prime
dprimesError = zeros(1, nSession);     % d prime errors

useSEM = 1;
iBinAll = 1;
prevNFreqs = 0;
prevNTones = 0;
dprimeMaxVal = 3.5;
dprimeMinVal = -2;
changeOfFreqOrToneNum = zeros(1, nSession);

for iSess = 1 : nSession;
    
    % extract the current session's number of frequency and number of tones
    nFreqs = outAll.nFreqs(sessionIndexes == iSess);
    nTones = outAll.nTones(sessionIndexes == iSess);
    if ~numel(nFreqs); continue; end;
    nFreqs = nFreqs(1);
    nTones = nTones(1);
    
    % skip basic sessions
%     if nFreqs == 1 && nTones == 1;
%         hitRate(iBinAll) = NaN;
%         falsePosRate(iBinAll) = NaN;
%         dprimes(iBinAll) = NaN;
%         iBinAll = iBinAll + 1;
%         continue;
%     end;
    
    % if there is a change in the number of frequencies or tones, mark it
    if prevNFreqs ~= 0 && (nFreqs ~= prevNFreqs || nTones ~= prevNTones);
        changeOfFreqOrToneNum(iSess) = iSess - 1;
    end;
        
    % store for next iteration
    prevNFreqs = nFreqs;
    prevNTones = nTones;
    
    % extract the respTypes for this session
    % for each trial, 1 = correct detect, 2 = correct reject, 3 = false alarm, 4 = miss, 5 = early
    sessionRespTypes = outAll.respTypes(sessionIndexes == iSess);
    
    sessInDay = sessionIndexesIndiv(sessionIndexes == iSess);
    sessStart = min(sessInDay);
    sessEnd = max(sessInDay);
    dPrimesIndivSess = zeros(1, sessEnd - sessStart + 1);
    hitRatesIndivSess = zeros(1, sessEnd - sessStart + 1);
    falsePosIndivSess = zeros(1, sessEnd - sessStart + 1);
    for iSessIndiv = sessStart : sessEnd;
        indivSessionRespTypes = outAll.respTypes(sessionIndexesIndiv == iSessIndiv);
        countsForIndivSession = mtrainerAnalyzer_getCounts(indivSessionRespTypes);
        if isnan(countsForIndivSession.DPRIME);
            countsForIndivSession.DPRIME = 0;
        end;
        dPrimesIndivSess(iSessIndiv - sessStart + 1) = countsForIndivSession.DPRIME;
        hitRatesIndivSess(iSessIndiv - sessStart + 1) = ...
            100 * countsForIndivSession.TGO / countsForIndivSession.T;
        falsePosIndivSess(iSessIndiv - sessStart + 1) = ...
            100 * countsForIndivSession.NTGO / countsForIndivSession.NT;
    end;
    
    if useSEM;
        dprimesError(iBinAll) = sem(dPrimesIndivSess); %%#ok<UNRCH>
        hitRateError(iBinAll) = sem(hitRatesIndivSess);
        falsePosRateError(iBinAll) = sem(falsePosIndivSess);
    else
        dprimesError(iBinAll) = std(dPrimesIndivSess); %#ok<UNRCH>
        hitRateError(iBinAll) = std(hitRatesIndivSess);
        falsePosRateError(iBinAll) = std(falsePosIndivSess);
    end;
    
    % make an overall counting for the session
    countsForSession = mtrainerAnalyzer_getCounts(sessionRespTypes);
    o('  #mtrain...pooledPerf: session %d, taskType: "%s".', iSess, ...
        sprintf('%F%T', nFreqs, nTones), 3, dbgLevel);
    
    hitRate(iBinAll) = 100 * countsForSession.TGO / countsForSession.T;
    falsePosRate(iBinAll) = 100 * countsForSession.NTGO / countsForSession.NT;
    if isnan(countsForSession.DPRIME);
        countsForSession.DPRIME = 0;
    end;

    % restrict the dprime value between dprimeMaxVal and dprimeMinVal
    countsForSession.DPRIME = min(dprimeMaxVal, countsForSession.DPRIME);
    countsForSession.DPRIME = max(dprimeMinVal, countsForSession.DPRIME);

    dprimes(iBinAll) = countsForSession.DPRIME;
    
    o('  #mtrain...pooledPerf: session %d, HitRate: %04.1f, FalsePosRate = %04.1f, d'' = %.2f.', ...
        iSess, hitRate(iBinAll), falsePosRate(iBinAll), dprimes(iBinAll), 3, dbgLevel);
    
    iBinAll = iBinAll + 1;
%     
%     binWidth = 100;
%     
%     % calculate number of bins, make sure that there is at least one
%     nBins = max(round(countsForSession.TOT / binWidth), 1);
%     for iBin = 1 : nBins;
%         iStart = (iBin - 1) * binWidth + 1; % for binWidth = 10: 1, 11, 21, etc.
%         iEnd = min(iBin * binWidth, countsForSession.TOT); % for binWidth = 10: 10, 20, 30, etc.
%         countsForBin = mtrainerAnalyzer_getCounts(sessionRespTypes(iStart : iEnd));
%         
%         if countsForBin.GOP < 50;
%             trialIndex = find(sessionIndexes == iSess);
%             trialIndex = trialIndex(1) + iBin * binWidth;
%             runsForSession = runs(cell2mat(runs(:, 2)) == iSess);
%             iRun = 1;
%             while iRun < numel(runsForSession);
%                 if sum(nTrialsPerSess
%             end;
%             o('  #mtrain...pooledPerf: session %d, %s, bin %d (trial %.0f) has a GOP of %.2f.', ...
%                 iSess, runsForSession{1}, iBin, trialIndex, countsForBin.GOP, 3, dbgLevel);
%             hitRate(iBinAll) = NaN;
%             falsePosRate(iBinAll) = NaN;
%             dprimes(iBinAll) = NaN;
%             iBinAll = iBinAll + 1;
%             continue;
%         end;
%         
%         hitRate(iBinAll) = 100 * countsForBin.TGO / countsForBin.T;
%         falsePosRate(iBinAll) = 100 * countsForBin.NTGO / countsForBin.NT;
%         if isnan(countsForBin.DPRIME) || isinf(countsForBin.DPRIME);
%             countsForBin.DPRIME = 0;
%         end;
%         
%         % restrict the dprime value between +dprimeMaxVal and -dprimeMaxVal
%         countsForBin.DPRIME = min(dprimeMaxVal, countsForBin.DPRIME);
%         countsForBin.DPRIME = max(-dprimeMaxVal, countsForBin.DPRIME);
%         
%         dprimes(iBinAll) = countsForBin.DPRIME;
%         iBinAll = iBinAll + 1;
%     end;
end;

nTotBins = iBinAll - 1;

% TGOsHand = plot(hitRate, '-sg', 'MarkerFaceColor', 'green');
TGOsErrHand = errorbar(1 : nSession, hitRate, hitRateError, '-sg', 'MarkerFaceColor', 'green');
removeErrorBarEnds(TGOsErrHand);

hold all;
hitRateAxes = gca;
% NTNGOsHand = plot(falsePosRate, '-sr', 'MarkerFaceColor', 'red');
NTNGOsErrHand = errorbar((1 : nSession) + 0.15, falsePosRate, falsePosRateError, '-sr', 'MarkerFaceColor', 'red');
removeErrorBarEnds(NTNGOsErrHand);

set(hitRateAxes, 'ylim', [0 110], 'YTick', 0 : 10 : 110, 'YTickLabel', 0 : 10 : 110);

if useSEM;
    ylabel('% of Trials \pm SEM'); %%#ok<UNRCH>
else
    ylabel('% of Trials \pm SD'); %#ok<UNRCH>
end;

vertLineHandles = zeros(1, sum(changeOfFreqOrToneNum > 0));
vertLineTextHandles = zeros(2, sum(changeOfFreqOrToneNum > 0));
iLineHandle = 1;
for iChange = 1 : numel(changeOfFreqOrToneNum);
    if ~changeOfFreqOrToneNum(iChange); continue; end;
    changeX = changeOfFreqOrToneNum(iChange) + 0.5;
    
    nFreqs1 = outAll.nFreqs(sessionIndexes == changeOfFreqOrToneNum(iChange));
    nFreqs1 = nFreqs1(1);
    nFreqs2 = outAll.nFreqs(sessionIndexes ==changeOfFreqOrToneNum(iChange) + 1);
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
xlimits = [0 nTotBins * 1.05];
xlim(xlimits);
set(hitRateAxes, 'XTick', [], 'XTickLabel', []);

xTickAxes = axes('Position', get(gca, 'Position'), ...
    'YAxisLocation', 'right', 'XAxisLocation', 'bottom', 'Color', 'none');
sessionLabels = cellstr(datestr(outAll.datesAsNum([diff(sessionIndexes) > 0, true]), 'dd/mm'));
set(xTickAxes, 'xlim', xlimits, ...
    'XTick', 1 : nSession, 'XTickLabel', sessionLabels(1 : nSession));
% set(xTickAxes, 'xlim', xlimits, ...
%     'XTick', 0 : 10 : nTotBins, 'XTickLabel', (0 : 10 : nTotBins) * binWidth);
set(xTickAxes, 'YTick', [], 'YTickLabel', []);
xlabel('Sessions');

dprimeAxes = axes('Position', get(gca, 'Position'), ...
    'YAxisLocation', 'right', 'XAxisLocation', 'top', 'Color', 'none');
hold all;
% dprimesHand = plot(dprimes, '-sb', 'MarkerFaceColor', 'blue');
dprimesErrHand = errorbar((1 : nSession) + 0.3, dprimes, dprimesError, '-sb', 'MarkerFaceColor', 'blue');
removeErrorBarEnds(dprimesErrHand);

set(dprimeAxes, 'ylim', [dprimeMinVal dprimeMaxVal], 'YTick', dprimeMinVal : 0.5 : dprimeMaxVal, ...
    'YTickLabel', dprimeMinVal : 0.5 : dprimeMaxVal);
set(dprimeAxes, 'XTick', [], 'XTickLabel', []);
xlim(xlimits);
if useSEM;
    ylabel('d'' value \pm SEM'); %%#ok<UNRCH>
else
    ylabel('d'' value \pm SD'); %#ok<UNRCH>
end;

legend([TGOsErrHand, NTNGOsErrHand, dprimesErrHand], {'HitRate', 'FalsePos', 'd'''}, ...
    'Location', 'NorthWest');
% legend([TGOsHand, NTNGOsHand, dprimesHand], {'HitRate', 'FalsePos', 'd'''}, ...
%     'Location', 'NorthWest');

title(sprintf('%s \\fontsize{10} [Total number of trials = %.0f, mean trials per session = %.0f]', ...
    titleStr, sum(nTrialsPerSess), mean(nTrialsPerSess)));

hold off;
makePrettyFigure(figHand);
set(xTickAxes, 'FontSize', 9);
for iLineHandle = 1 : numel(vertLineHandles);
    set(vertLineHandles(iLineHandle), 'LineWidth', 0.5);
    set(vertLineTextHandles(1, iLineHandle), 'FontSize', 10);
    set(vertLineTextHandles(2, iLineHandle), 'FontSize', 10);
end;
    
end

function [runs, sessionIndexes, nTrialsPerSess] = separateIntoSessions(outAll, runs, nextSessThresh, dbgLevel)

sessionIndexes = zeros(1, numel(outAll.respTypes));
nTrialsPerSess = zeros(1, 1);
iRun = 1;
iSess = 1;

% loop trough all runs
while iRun <= size(runs, 1);
    % current run's date as number
    dateAsNum = datenum(runs{iRun, 1}, 'yyyymmdd_HHMMSS');
    o('  #mtrain...pooledPerf: run %d, date: %s (%8.3f).', iRun, runs{iRun, 1}, dateAsNum, 3, dbgLevel);
    
    % for all runs before the last, check with next run
    if iRun < size(runs, 1);
        dateAsNumNext = datenum(runs{iRun + 1, 1}, 'yyyymmdd_HHMMSS');
    else % for last run, make the difference big enough
        dateAsNumNext = dateAsNum + 100 * nextSessThresh;
    end;
    
    runs{iRun, 2} = iSess;
    o('    #mtrain...pooledPerf: run %d''s session: %d, dateAsNumNext: %8.3f, diff: %.2f, thresh: %.2f.', ...
        iRun, iSess, dateAsNumNext, abs(dateAsNum - dateAsNumNext), nextSessThresh, 3, dbgLevel);
    
    % if they are too different, next run is in a new session
    if abs(dateAsNum - dateAsNumNext) > nextSessThresh;
        % get all the respTypes for that session (earlier dates that are not yet assigned to a sessions)
        respTypesForSession = outAll.respTypes(outAll.datesAsNum <= dateAsNum & ~sessionIndexes);
        nTrials = numel(respTypesForSession);
        zeroIndex = find(~sessionIndexes); % get indexes where sessionIndex is still 0
        sessionIndexes(zeroIndex(1) : zeroIndex(1) + nTrials - 1) = ones(1, nTrials) * iSess;
        nTrialsPerSess(iSess) = nTrials;
        o('    #mtrain...pooledPerf: run %d is the last of session %d, nTrials: %d, tagging from %d to %d.', ...
            iRun, iSess, nTrials, zeroIndex(1), zeroIndex(1) + nTrials - 1, 3, dbgLevel);
        iSess = iSess + 1;
        iRun = iRun + 1;
    else % otherwise if they are not too different, go on
        iRun = iRun + 1;
    end;
end;

end