% plot Wide-Field maps

sessDirs = dir();
sessDirs(arrayfun(@(i) isempty(regexp(sessDirs(i).name, '^session\d\d_\d+$', 'once')), 1 : numel(sessDirs))) = [];

sessDirs = sessDirs([1, 2, 4 6]);

if ~exist('sessMat', 'var');
    sessMat = struct();
    sessMat(numel(sessDirs)) = struct();
end;

trialTypesRegexp = { 'hit', 'CR', 'quiet', 'moveDur', 'moveBef', ...
    'hit_AND_moveDur', 'hit_AND_quiet', 'hit_AND_moveBef', 'hit_AND_[quiet|moveBef]', ...
    'CR_AND_moveDur', 'CR_AND_quiet', 'CR_AND_moveBef', 'CR_AND_[quiet|moveBef]' };
trialTypeSaveName = { 'hit', 'CR', 'strict_quiet', 'move', 'early_move', ...
    'strict_quiet_hit', 'move_hit', 'early_move_hit', 'quiet_hit', ...
    'strict_quiet_CR', 'move_CR', 'early_move_CR', 'quiet_CR' };

%% delay
timePeriod = 'delay';
framesToAvg = 104 : 140;
cLim = [-0.005, 0.02];

figure('NumberTitle', 'off', 'Name', timePeriod, 'Position', [67, 432, 1803, 505]);
    
iPlot = 1;
for iSess = 1 : numel(sessDirs);
    if ~isfield(sessMat(iSess), 'hit') || isempty(sessMat(iSess).hit);
        hitAvgMat = load([sessDirs(iSess).name, '/Matt_files/cond_hit_average.mat']);
        sessMat(iSess).hit = hitAvgMat;
    end;
    subplot(2, numel(sessDirs), iPlot);
    imagesc(1 : 256, 1 : 256, smoothn(nanmean(sessMat(iSess).hit.tr_ave(:, :, framesToAvg), 3) - 1, [5 5], 'Gauss'));
    set(gca, 'CLim', cLim, 'XLim', [1 256], 'YLim', [1 256], 'XTick', [], 'YTick', []);
    title(sprintf('Hit - %s', sessDirs(iSess).name), 'Interpreter', 'none');
    colorbar();
    colormap(gca, 'mapgeog');
    iPlot = iPlot + 1;
end;

for iSess = 1 : numel(sessDirs);
    if ~isfield(sessMat(iSess), 'CR') || isempty(sessMat(iSess).CR);
        CRAvgMat = load([sessDirs(iSess).name, '/Matt_files/cond_CR_average.mat']);
        sessMat(iSess).CR = CRAvgMat;
    end;
    subplot(2, numel(sessDirs), iPlot);
    imagesc(1 : 256, 1 : 256, smoothn(nanmean(sessMat(iSess).CR.tr_ave(:, :, framesToAvg), 3) - 1, [5 5], 'Gauss'));
    set(gca, 'CLim', cLim, 'XLim', [1 256], 'YLim', [1 256], 'XTick', [], 'YTick', []);
    title(sprintf('CR - %s', sessDirs(iSess).name), 'Interpreter', 'none');
    colorbar();
    colormap(gca, 'mapgeog');
    iPlot = iPlot + 1;
end;

%% sensation
timePeriod = 'sensation';
framesToAvg = 60 : 100;
cLim = [-0.005, 0.02];

figure('NumberTitle', 'off', 'Name', timePeriod, 'Position', [67, 432, 1803, 505]);
iPlot = 1;
for iSess = 1 : numel(sessDirs);
    if ~isfield(sessMat(iSess), 'hit') || isempty(sessMat(iSess).hit);
        hitAvgMat = load([sessDirs(iSess).name, '/Matt_files/cond_hit_average.mat']);
        sessMat(iSess).hit = hitAvgMat;
    end;
    subplot(2, numel(sessDirs), iPlot);
    imagesc(1 : 256, 1 : 256, smoothn(nanmean(hitAvgMat.tr_ave(:, :, framesToAvg), 3) - 1, [5 5], 'Gauss'));
    set(gca, 'CLim', cLim, 'XLim', [1 256], 'YLim', [1 256], 'XTick', [], 'YTick', []);
    title(sprintf('Hit - %s', sessDirs(iSess).name), 'Interpreter', 'none');
    colorbar();
    colormap(gca, 'mapgeog');
    iPlot = iPlot + 1;
end;

for iSess = 1 : numel(sessDirs);
    if ~isfield(sessMat(iSess), 'CR') || isempty(sessMat(iSess).CR);
        CRAvgMat = load([sessDirs(iSess).name, '/Matt_files/cond_CR_average.mat']);
        sessMat(iSess).CR = CRAvgMat;
    end;
    subplot(2, numel(sessDirs), iPlot);
    imagesc(1 : 256, 1 : 256, smoothn(nanmean(CRAvgMat.tr_ave(:, :, framesToAvg), 3) - 1, [5 5], 'Gauss'));
    set(gca, 'CLim', cLim, 'XLim', [1 256], 'YLim', [1 256], 'XTick', [], 'YTick', []);
    title(sprintf('CR - %s', sessDirs(iSess).name), 'Interpreter', 'none');
    colorbar();
    colormap(gca, 'mapgeog');
    iPlot = iPlot + 1;
end;

%{

function doPlot(timePeriod, framesToAvg, cLim);

figure('NumberTitle', 'off', 'Name', timePeriod, 'Position', [67, 432, 1803, 505]);
iPlot = 1;
for iSess = 1 : numel(sessDirs);
    if ~isfield(sessMat(iSess), 'hit') || isempty(sessMat(iSess).hit);
        hitAvgMat = load([sessDirs(iSess).name, '/Matt_files/cond_hit_average.mat']);
        sessMat(iSess).hit = hitAvgMat;
    end;
    subplot(2, numel(sessDirs), iPlot);
    imagesc(1 : 256, 1 : 256, smoothn(nanmean(hitAvgMat.tr_ave(:, :, framesToAvg), 3) - 1, [5 5], 'Gauss'));
    set(gca, 'CLim', cLim, 'XLim', [1 256], 'YLim', [1 256], 'XTick', [], 'YTick', []);
    title(sprintf('Hit - %s', sessDirs(iSess).name), 'Interpreter', 'none');
    colorbar();
    colormap(gca, 'mapgeog');
    iPlot = iPlot + 1;
end;

for iSess = 1 : numel(sessDirs);
    if ~isfield(sessMat(iSess), 'CR') || isempty(sessMat(iSess).CR);
        CRAvgMat = load([sessDirs(iSess).name, '/Matt_files/cond_CR_average.mat']);
        sessMat(iSess).CR = CRAvgMat;
    end;
    subplot(2, numel(sessDirs), iPlot);
    imagesc(1 : 256, 1 : 256, smoothn(nanmean(CRAvgMat.tr_ave(:, :, framesToAvg), 3) - 1, [5 5], 'Gauss'));
    set(gca, 'CLim', cLim, 'XLim', [1 256], 'YLim', [1 256], 'XTick', [], 'YTick', []);
    title(sprintf('CR - %s', sessDirs(iSess).name), 'Interpreter', 'none');
    colorbar();
    colormap(gca, 'mapgeog');
    iPlot = iPlot + 1;
end;

%}