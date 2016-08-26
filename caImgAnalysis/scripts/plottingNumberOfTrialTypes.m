
% figPos = [305 45 1125 985];
figPos = [305 45 1085 985];
   
doSavePlots = true;
% doSavePlots = false;

trialTypes = { 'no_prior_move', 'prior_move', 'delay_move', 'quiet_then_move', 'noisy' };
% trialTypes = { 'delay_move', 'no_prior_move', 'prior_move' };

%% count trial numbers
nSess = size(trialTypesPooled, 1);
nTrialTypes = numel(trialTypes);
nTrialsPerTypePooled = zeros(nSess, nTrialTypes, 2);
for iSess = 1 : nSess;
    nTrialsPerTypePooled(iSess, :, 1) = cellfun(@(typ) sum(strcmp(trialTypesPooled{iSess, 1}, typ)), trialTypes);
    nTrialsPerTypePooled(iSess, :, 2) = cellfun(@(typ) sum(strcmp(trialTypesPooled{iSess, 2}, typ)), trialTypes);
end;

%% plot
close all;

figure('Name', 'Trial proportions per session', figProps{:}, 'Position', [150 115 1300 980]);
colormap(lines(5));
hold('on');
xHit = (1 : nSess) - 0.15 - 0.35;
xCR = (1 : nSess) + 0.35 - 0.15 - 0.35;
barHHit = bar(xHit, nTrialsPerTypePooled(:, :, 1), 0.3, 'stacked');
barHCR = bar(xCR, nTrialsPerTypePooled(:, :, 2),  0.3, 'stacked');
text(xHit, sum(nTrialsPerTypePooled(:, :, 1), 2), 'hit', 'Color', 'green', 'FontSize', 30, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
text(xCR, sum(nTrialsPerTypePooled(:, :, 2), 2), 'CR', 'Color', 'red', 'FontSize', 30, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
hold('off');
set(gca, 'FontSize', 30);
ylabel('# trials', 'FontSize', 40);
legend(regexprep(trialTypes, '_', ' '), 'Interpreter', 'none', 'Location', 'EastOutside', 'FontSize', 20);

% xTickLabels = arrayfun(@(iSess) sprintf('%s-%s', regexprep(sessInfos{iSess, 1}, '_', ''), ...
%     regexprep(regexprep(sessInfos{iSess, 2}, 'session', 'S'), '_', ' ')), 1 : nSess, 'UniformOutput', false);
xTickLabels = arrayfun(@(iSess) sprintf('%s', ...
    regexprep(regexprep(sessInfos{iSess, 2}, 'session', 'S'), '_', ' ')), 1 : nSess, 'UniformOutput', false);
set(gca, 'XTick', 1 : nSess, 'XTickLabel', xTickLabels(1 : end), 'XTickLabelRotation', 40);

% plot and save
if doSavePlots;
    saveName = 'trialNumbersPerSession'; %#ok<*UNRCH>
    export_fig(sprintf('%s.png', saveName), '-r300', gcf);
    export_fig(sprintf('%s.fig', saveName), gcf);
end;

%% plot 2
figure('Name', 'Trial proportions', figProps{:}, 'Position', [150 115 1300 980]);
colormap(lines(2));
hold('on');
xHit = (1 : nTrialTypes) - 0.05 - 0.35;
xCR = (1 : nTrialTypes) + 0.35 - 0.05 - 0.35;
barHHit = bar(xHit, sum(nTrialsPerTypePooled(:, :, 1), 1), 0.3);
barHCR = bar(xCR, sum(nTrialsPerTypePooled(:, :, 2), 1),  0.3, 'stacked');
text(xHit, sum(nTrialsPerTypePooled(:, :, 1), 1), 'hit', 'Color', 'green', 'FontSize', 30, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
text(xCR, sum(nTrialsPerTypePooled(:, :, 2), 1), 'CR', 'Color', 'red', 'FontSize', 30, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
hold('off');
set(gca, 'FontSize', 30);
ylabel('# trials', 'FontSize', 40);

set(gca, 'XTick', 1 : nSess, 'XTickLabel', regexprep(trialTypes, '_', ' '), 'XTickLabelRotation', 40);


% plot and save
if doSavePlots;
    saveName = 'trialNumbers'; %#ok<*UNRCH>
    export_fig(sprintf('%s.png', saveName), '-r300', gcf);
    export_fig(sprintf('%s.fig', saveName), gcf);
end;

%%
trialText = get(this, this.dw.selectedTableRows, 'dim');
trialCountsCell = cellfun(@(txt) regexp(txt, '^(?<nHit>\d+) hit trials, (?<nCR>\d+) CR trials$', 'names'), trialText, 'UniformOutput', false);
trialCountsCell(cellfun(@isempty, trialCountsCell)) = [];
trialCounts = cell2mat(cellfun(@(stru)[str2double(stru.nHit), str2double(stru.nCR)], trialCountsCell, 'UniformOutput', false));

sum(trialCounts)

%%
figure('Name', 'Trial proportions per session', figProps{:}, 'Position', [150 115 1300 980]);
colormap(lines(2));
x = -2 : 4 : 66;
nHitBin = histc(trialCounts(:, 1), x);
nCRBin = histc(trialCounts(:, 2), x);
hold('on');
stairs(x + 0.5, nHitBin, 'g', 'LineWidth', 3);
stairs(x - 0.5, nCRBin, 'r', 'LineWidth', 3);
hold('off');

xlim([x(1) x(end)]);
set(gca, 'FontSize', 30);
ylabel('count', 'FontSize', 40);
xlabel('# trials per session', 'FontSize', 40);
legend({ sprintf('HIT %d trials', sum(trialCounts(:, 1))), sprintf('CR %d trials', sum(trialCounts(:, 2))) }, 'FontSize', 40, 'Location', 'NorthWest');


% plot and save
if doSavePlots;
    saveName = 'trialNumbersWithinSessions'; %#ok<*UNRCH>
    export_fig(sprintf('%s.png', saveName), '-r300', gcf);
    export_fig(sprintf('%s.fig', saveName), gcf);
end;

