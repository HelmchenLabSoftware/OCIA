% plot Wide-Field maps

sessDirs = dir();
sessDirs(arrayfun(@(i) isempty(regexp(sessDirs(i).name, '^session\d\d_\d+$', 'once')), 1 : numel(sessDirs))) = [];

% sessDirs = sessDirs([5, 9, 11, 7, 8, 10]);

if ~exist('saveStruct', 'var');
    if exist('analysis/saveStruct.mat', 'file');
        saveStructMat = load('analysis/saveStruct.mat');
        saveStruct = saveStructMat.saveStruct;
    else
        saveStruct = struct();
        saveStruct(numel(sessDirs)) = struct();
    end;
end;

nFrames = 200; frameRate = 20; baseLineTime = 0;
t = ((1 : nFrames) / frameRate) - baseLineTime;

% framesToAvgCell = { 10 : 20, 15 : 20, 14 : 18 };
% timePeriodCell = { 'x0p00To0p50Sec', 'x0p25To0p50Sec', 'x0p20To0p40Sec' };

framesToAvgCell = { 20 : 30 };
timePeriodCell = { 'lightCue' };

% cLimsCellTimePeriod = { [5, 0.02], [5, 0.02], [5, 0.02] };
cLimsCellTimePeriod = [];
% cLimsCellSession = { [-0.2, 1.2], [-0.2, 1.4], [-0.2, 0.6], [-0.2, 0.5], [-0.2, 0.7], [-0.2, 2.4] };
cLimsCellSession = [];

cLim = [-0.4, 1.4];

% posCell = { [30, 130, 820, 870], [1000, 130, 820, 870] };
% posCell = { [30, 130, 820, 870], [500, 130, 820, 870], [1000, 130, 820, 870] };
% posCell = { [30, 80, 1850, 910], [30, 80, 1850, 910], [30, 80, 1850, 910] };
posCell = { [30, 80, 1850, 910] };

% save parameters
saveStruct(1).params.sessDirs = sessDirs;
saveStruct(1).params.t = t;
saveStruct(1).params.framesToAvgCell = framesToAvgCell;
saveStruct(1).params.timePeriodCell = timePeriodCell;
saveStruct(1).params.cLimsCellTimePeriod = cLimsCellTimePeriod;
saveStruct(1).params.cLimsCellSession = cLimsCellSession;
saveStruct(1).params.posCell = posCell;


%% plot
% define subplot size
M = ceil(sqrt(numel(sessDirs))); N = M; if (N - 1) * M >= numel(sessDirs); N = N - 1; end;
saveStruct(1).params.M = M;
saveStruct(1).params.N = N;

% plot each period in a new figure
figHs = zeros(numel(timePeriodCell));
for iPer = 1 : numel(timePeriodCell);

    % get the parameters for the current period
    timePeriod = timePeriodCell{iPer};
    framesToAvg = framesToAvgCell{iPer};
    if isempty(cLimsCellSession) && ~isempty(cLimsCellTimePeriod);
        cLim = cLimsCellTimePeriod{iPer};
    end;
    pos = posCell{iPer};

    % create figure
    figHs(iPer) = figure('NumberTitle', 'off', 'Name', timePeriod, 'Position', pos, 'Color', 'white');

    % go through each session
    for iSess = 1 : numel(sessDirs);
        
        % load the average for each session
        if ~isfield(saveStruct(iSess), timePeriod) || isempty(saveStruct(iSess).(timePeriod));
            avgMat = load([sessDirs(iSess).name, '/Matt_files/cond_hit_average.mat']);
            saveStruct(iSess).(timePeriod) = avgMat;
        end;
        
        if ~isempty(cLimsCellSession) && isempty(cLimsCellTimePeriod);
            cLim = cLimsCellSession{iSess};
        end;
        
        % plot each session in a new subplot
        subplot(N, M, iSess);
        imagesc(1 : 256, 1 : 256, 100 * (smoothn(nanmean(saveStruct(iSess).(timePeriod).tr_ave(:, :, framesToAvg), 3) - 1, [7 7], 'Gauss')));
        set(gca, 'CLim', cLim, 'XLim', [1 256], 'YLim', [1 256], 'XTick', [], 'YTick', []);
        axis('square');
        sessNameClean = regexprep(regexprep(sessDirs(iSess).name, 'session\d+_(\w+)', '$1'), '_', ' ');
        sessNum = regexprep(sessDirs(iSess).name, 'session(\d+)_\w+', '$1');
%         title(sprintf('%s - %s (%s)', timePeriod, sessNameClean, sessNum), 'Interpreter', 'none', 'FontSize', 15);
%         title(sprintf('%s (%s)', sessNameClean, sessNum), 'Interpreter', 'none', 'FontSize', 25);
        title(sprintf('%s', sessNameClean), 'Interpreter', 'none', 'FontSize', 25);
        cBar = colorbar('FontSize', 25);
        set(get(cBar, 'Label'), 'String', '\DeltaF/F %');
        colormap(gca, 'mapgeog');

    end;
    
%     export_fig(sprintf('analysis/%s.png', timePeriod), '-r300', gcf);
%     export_fig(sprintf('analysis/%s.fig', timePeriod), gcf);
    
end;

% save('analysis/saveStruct.mat', 'saveStruct');

%% define ROIs
%{
ROIs = {
... per,    sess,   name,       coords,     mask
    1,      1,      'S1FL',     [],         [];
    1,      2,      'S1HL',     [],         [];
    1,      3,      'A1',       [],         [];
    1,      5,      'S1BC',     [],         [];
    1,      5,      'S2',       [],         [];
    1,      6,      'V1',       [],         [];
};


% define for each period in a new figure
for iROI = 1 : size(ROIs, 1);

    % get the parameters for the current period
    timePeriod = timePeriodCell{ROIs{iROI, 1}};
    
    % go to the right figure
    figure(figHs(ROIs{iROI, 1}));
        
    % go to the right subplot
    axeH = subplot(N, M, ROIs{iROI, 2});

    % draw the ROI
    ROIHandle = imfreehand(axeH);

    % get infos about it and save them
    ROIs{iROI, 4} = round(ROIHandle.getPosition());
    ROIs{iROI, 5} = ROIHandle.createMask();
    
    
    
end;

% remove useless columns
ROIs(:, 1:2) = [];

% save('analysis/ROIs.mat', 'ROIs');

%}


%% plot ROIs on maps
%{
% go through each session
for iSess = 1 : numel(sessDirs);
    subplot(N, M, iSess);
    hold('on');
    for iROI = 1 : size(ROIs, 1);
        contour(ROIs{iROI, 3}, ':k');
    end;
end;
hold('off');
export_fig(sprintf('analysis/%s_withROIs.png', timePeriod(2:end)), '-r300', gcf);
export_fig(sprintf('analysis/%s_withROIs.fig', timePeriod(2:end)), gcf);
%}

%% plot ROIs on ref
%{
figHs(iPer) = figure('NumberTitle', 'off', 'Name', 'Reference', 'Position', [470 170 950 910], 'Color', 'white');
imagesc(1 : 256, 1 : 256, imadjust(refImg));
colormap('gray');
set(gca, 'CLim', [-0.05 1.05]);
axis('square');
hold('on');
ROIColors = [0 1 1; 1 0 1; 0 1 0; 1 1 0; 1 0 0; 0 0 1];
for iROI = 1 : size(ROIs, 1);
    contour(ROIs{iROI, 3}, 'Color', ROIColors(iROI, :), 'LineStyle', '-');
end;
legend(ROIs(:, 1));
hold('off');
export_fig('analysis/ref_withROIs.png', '-r300', gcf);
export_fig('analysis/ref_withROIs.fig', gcf);
%}

%% plot ROIs on ref
%{
figHs(iPer) = figure('NumberTitle', 'off', 'Name', 'Reference', 'Position', [470 170 950 910], 'Color', 'white');
imagesc(1 : 256, 1 : 256, imadjust(PseudoFlatfieldCorrect(refImg)));
colormap('gray');
set(gca, 'CLim', [-0.05 0.95]);
axis('square');
hold('on');
ROIColors = [0 1 1; 1 0 1; 0 1 0; 1 1 0; 1 0 0; 0 0 1];
for iROI = 1 : size(ROIs, 1);
    contour(ROIs{iROI, 3}, 'Color', ROIColors(iROI, :), 'LineStyle', '-');
end;
legend(ROIs(:, 1));
hold('off');
export_fig('analysis/vessels_withROIs.png', '-r300', gcf);
export_fig('analysis/vessels_withROIs.fig', gcf);
%}