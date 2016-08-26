%% Function - mtrainerAnalyser_performance
function mtrainerAnalyser_performance(varargin)

    if nargin >= 1;
        % for each trial: 1 = correct detect, 2 = correct reject, 3 = false alarm, 4 = miss, 5 = early
        respTypes = varargin{1};
        doSavePlots = 0;
        savePath = '';
    end;
    if nargin >= 2;
        doSavePlots = varargin{2};
        savePath = 'perf.png';
    end;
    if nargin >= 3;
        savePath = varargin{3};
    end;
    if nargin == 4;
        nIntrLick = varargin{4};
    end;

    if nargin < 1 || nargin > 4;
        error('mtrainerAnalyser_performance:WrongArgumentNumberException', ...
            ['Number of arguments should be 1 ', ...
            '(responseTypeVector), 2 (responseTypeVector, doSavePlots) ', ...
            'or 3 (responseTypeVector, doSavePlots, savePath) (or 4 with nIntrLick)', ...
            'Please see the help for this function.']);
    end;
    
    counts_all = mtrainerAnalyzer_getCounts(respTypes);
    
    % print out a 'nicely' formatted table
    % 'fprintf' patterns for the content of the headers and the cells
    n = '3'; % number of digits to display for number
    np = '3'; % number of digits to display for percents
    headerPattern = [' (%0' n 'd|%0' np '.f%%) '];
    cellPattern = ['%0' n 'd (%0' np '.0f%%)  '];
    
    fprintf(['Performance: d'' = %.3f, early: %0' n 'd/%0' n 'd (%0' np '.f%%), ' ...
        'correctness: %0' np '.f%%\n'], counts_all.DPRIME, counts_all.EARLY, counts_all.TOT, ...
        counts_all.EARLYP, counts_all.CiP);
    if ~counts_all.NT; tableContent = cell(3, 2);
    else tableContent = cell(3, 3); end;
    % header line
    tableContent{1, 1} = sprintf([' VALID: %0' n 'd/%0' n 'd (%0' np '.f%%)'], ...
        counts_all.VTOT, counts_all.TOT, counts_all.VTOTP);
    tableContent{1, 2} = sprintf(['TARG.',     headerPattern], counts_all.T, counts_all.TP);
    if counts_all.NT; tableContent{1, 3} = sprintf(['NON-TARG.', headerPattern], ...
            counts_all.NT, counts_all.NTP); end;
    % GO line
    tableContent{2, 1} = sprintf([' GO     ',   headerPattern], counts_all.GO, counts_all.GOP);
    tableContent{2, 2} = sprintf(cellPattern, counts_all.TGO, counts_all.TGOP);
    if counts_all.NT; tableContent{2, 3} = sprintf(cellPattern, counts_all.NTGO, counts_all.NTGOP); end;
    % NO-GO line
    tableContent{3, 1} = sprintf([' NO-GO  ',   headerPattern], counts_all.NGO, counts_all.NGOP);
    tableContent{3, 2} = sprintf(cellPattern, counts_all.TNGO, counts_all.TNGOP);
    if counts_all.NT; tableContent{3, 3} = sprintf(cellPattern, counts_all.NTNGO, counts_all.NTNGOP); end;
    tprintf(23, tableContent);
    fprintf('(Percentages of the table are relative to valid trials (non-early))\n');
    
    if doSavePlots < 1;
        return;
    end;
    
    saveName = strrep(regexp(savePath, '\\[\d_]+$', 'match'), '\', '');
    if numel(saveName);
        saveName = ['Perf - ' saveName{1}];
    else
        saveName = 'Perf';
    end;
    fprintf('Plotting... (doSavePlots: %d)\n', doSavePlots);
    figure('Name', saveName, 'NumberTitle', 'off', 'MenuBar', 'none', 'WindowStyle', 'docked');
    title(strrep(saveName, '_', '\_'));
    % Valid trials
    subplot(3, 2, 1);
    bar(1, counts_all.EARLY, 1, 'FaceColor', [0.3 0.3 0.3]);
    hold on;
    bar(2, counts_all.VTOT, 1, 'FaceColor', [0 1 0]);
    text(1.3, - max(ylim) / 10, sprintf('Early (%3.f%%)', counts_all.EARLYP), ...
        'horizontalalignment', 'right', 'FontSize', 10);
    text(2.3, - max(ylim) / 10, sprintf('Valid (%3.f%%)', counts_all.VTOTP), ...
        'horizontalalignment', 'right', 'FontSize', 10);
    set(gca, 'XTickLabel', '');
    title(sprintf('Early versus valid trials (%d trials)', counts_all.TOT));
%     ylim([0 counts_all.TOT * 1.01]);
    ylim([0 max(counts_all.EARLY, counts_all.VTOT) * 1.2]);
    ylabel('Number of Trials');
    % Correct vs false
    subplot(3, 2, 2);
    bar(1, counts_all.C, 1, 'FaceColor', [0 1 0]);
    hold on;
    bar(2, counts_all.F, 1, 'FaceColor', [1 0 0]);
    text(1.4, - max(ylim) / 10, sprintf('Correct (%3.f%%)', counts_all.CP), ...
        'horizontalalignment', 'right', 'FontSize', 10);
    text(2.4, - max(ylim) / 10, sprintf('Wrong (%3.f%%)', counts_all.FP), ...
        'horizontalalignment', 'right', 'FontSize', 10);
    set(gca, 'XTickLabel', '');
    title(sprintf('Correct versus wrong trials (%d valid trials)', counts_all.VTOT));
    ylim([0 max(counts_all.C, counts_all.F) * 1.2]);
%     ylim([0 counts_all.TOT * 1.01]);
    ylabel('Number of Trials');
    
    
    TGOovTimeP = zeros(1, counts_all.TOT);
    NTNGOovTimeP = zeros(1, counts_all.TOT);
    NTGOovTimeP = zeros(1, counts_all.TOT);
    TNGOovTimeP = zeros(1, counts_all.TOT);
    EARLYovTimeP = zeros(1, counts_all.TOT);
    
%     binWidth = -1; % cumulative
    binWidth = fix(counts_all.TOT * 0.1); % binning
%     binWidth = 3; % binning
    for i = 1 : counts_all.TOT;
%     for i = 1 : binWidth : counts_all.TOT;
        if binWidth ~= -1;
%             iStart = max(i - 0.5 * (binWidth - 1), 1);
%             iEnd = min(i + 0.5 * (binWidth - 1), counts_all.TOT);
            iStart = max(i - binWidth, 1);
            iEnd = min(i + binWidth, counts_all.TOT);
            TGOovTimeP(i) = (sum(respTypes(iStart : iEnd) == 1) / (iEnd - iStart)) * 100;
            NTNGOovTimeP(i) = (sum(respTypes(iStart : iEnd) == 2) / (iEnd - iStart)) * 100;
            NTGOovTimeP(i) = (sum(respTypes(iStart : iEnd) == 3) / (iEnd - iStart)) * 100;
            TNGOovTimeP(i) = (sum(respTypes(iStart : iEnd) == 4) / (iEnd - iStart)) * 100;
            EARLYovTimeP(i) = (sum(respTypes(iStart : iEnd) == 5) / (iEnd - iStart)) * 100;
        else
            TGOovTimeP(i) = sum(respTypes(1 : i) == 1) / i * 100;
            NTNGOovTimeP(i) = sum(respTypes(1 : i) == 2) / i * 100;
            NTGOovTimeP(i) = sum(respTypes(1 : i) == 3) / i * 100;
            TNGOovTimeP(i) = sum(respTypes(1 : i) == 4) / i * 100;
            EARLYovTimeP(i) = sum(respTypes(1 : i) == 5) / i * 100;
        end;
    end;
    
    pause(0.05);
    subplot(3, 2, 3);
    percents = [TGOovTimeP; NTNGOovTimeP; NTGOovTimeP; ...
        TNGOovTimeP; EARLYovTimeP];
    bar(percents', 1, 'stacked', 'EdgeColor', 'none');
%     bar(percents', binWidth, 'stacked', 'EdgeColor', 'none');
    hold off;
    title('Percent of trials types over time');
    ylim([0 100]);
    xlim([1 counts_all.TOT]);
    ylabel('% Trials');
    xlabel('Trials');
%     legHand = legend({'Corr. det.', 'Corr. rej.', 'False alarm', 'Miss', 'Early'}, 'Location', 'EastOutside', ...
%         'FontSize', 12, 'Orientation', 'vertical');
    
    DPRIMEovTimeP = zeros(1, counts_all.TOT);
    
%     binWidth = -1; % cumulative
    binWidth = fix(counts_all.TOT * 0.1); % binning
%     binWidth = 5; % binning
    for i = 1 : counts_all.TOT;
%     for i = 1 : binWidth : counts_all.TOT;
        if binWidth ~= -1;
%             iStart = max(i - 0.5 * (binWidth - 1), 1);
%             iEnd = min(i + 0.5 * (binWidth - 1), counts_all.TOT);
            iStart = max(i - binWidth, 1);
            iEnd = min(i + binWidth, counts_all.TOT);
            counts_till_i = mtrainerAnalyzer_getCounts(respTypes(iStart : iEnd));
            DPRIMEovTimeP(i) = dprime(counts_till_i.TGO ./ counts_till_i.T, ...
                counts_till_i.NTGO ./ counts_till_i.NT, counts_till_i.T, counts_till_i.NT);
        else
            counts_till_i = mtrainerAnalyzer_getCounts(respTypes(1 : i));
            DPRIMEovTimeP(i) = dprime(counts_till_i.TGO ./ counts_till_i.T, ...
                counts_till_i.NTGO ./ counts_till_i.NT, counts_till_i.T, counts_till_i.NT);
        end;
    end;
    subplot(3, 2, 4);
    plot(1 : counts_all.TOT, DPRIMEovTimeP);
    title('d'' over time');
%     ylim([0 100]);
    xlim([1 counts_all.TOT]);
    ylabel('d''');
    xlabel('Trials');
%     legHand = legend({'Corr. det.', 'Corr. rej.', 'False alarm', 'Miss', 'Early'}, 'Location', 'EastOutside', ...
%         'FontSize', 12, 'Orientation', 'vertical');
    
    subplot(3, 2, 5);
    plot(1 : counts_all.TOT, TGOovTimeP + NTGOovTimeP + EARLYovTimeP);
    title('Responsiveness');
    ylim([0 100]);
    xlim([1 counts_all.TOT]);
    ylabel('% of GO');
    xlabel('Trials');
    
    if exist('nIntrLick', 'var');
        subplot(3, 2, 6);
        plot(1 : numel(nIntrLick), nIntrLick);
        title('Number of inter-trial licking');
%         ylim([0 100]);
        xlim([1 numel(nIntrLick)]);
        ylabel('Number of lick');
        xlabel('Trials');
    end;

    pause(0.05);
%     makePrettyFigure(gcf);
    
%     set(legHand, 'FontSize', 12);
    
    if doSavePlots < 2;
        return;
    end;
    fprintf('Saving... (doSavePlots: %d)\n', doSavePlots);
    saveas(gcf, [savePath '_perf.png']);
    saveas(gcf, [savePath '_perf.fig']);
    
end
