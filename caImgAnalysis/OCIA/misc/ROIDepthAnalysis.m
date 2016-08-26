% ROI Table depth analysis function

% define some paths
% tablePath = 'W:/Neurophysiology/Projects/RUNNING/RCaMP/Analysis/2015_08_06__Balazs__pooledAnalysis/ROITable_depthCorrected_allMice_20150720_Balazs.mat';
% savePath = 'W:/Neurophysiology/Projects/RUNNING/RCaMP/Analysis/2015_08_06__Balazs__pooledAnalysis/';
% tablePath = 'W:/Projects/RUNNING/RCaMP/Analysis/2015_09_03__Balazs/ROITable_depthCorrected.mat';
% savePath = 'W:/Projects/RUNNING/RCaMP/Analysis/2015_09_03__Balazs/';
tablePath = 'F:/RawData/WenRui/ROITable_depthCorrected.mat';
savePath = 'E:/Analysis/WenRui/2015_09_03__Balazs/';

% load the table
load(tablePath);

% get the variable names
varNames = ROITable.Properties.VariableNames;

% get the depth values and animal IDs
depths = ROITable.depth;
animIDs = ROITable.animal;

% set parameters for plotting
% figPos = [1965 50 1200 870];
figPos = [10 100 1200 870];
titleFontSize = 20;
axeFontSize = 16;
axeLabelFontSize = 20;
pointSize = 12;

% set parameters for saving
doSavePlots = 1;
saveRes = '-r350';
warning('off', 'MATLAB:LargeImage');

% create save folder if needed
if doSavePlots && exist(savePath, 'dir') ~= 7;
    mkdir(savePath);
end;
if doSavePlots && exist([savePath 'fig/'], 'dir') ~= 7;
    mkdir([savePath 'fig/']);
end;
if doSavePlots && exist([savePath 'png/'], 'dir') ~= 7;
    mkdir([savePath 'png/']);
end;

%% process each relevant variable
for iVar = 6 : numel(varNames);
    
    % extract values for this variable
    varName = varNames{iVar};
    varNameDisplay = varName;
    varNameDisplay = regexprep(varNameDisplay, '_', ' ');
    varNameDisplay = regexprep(varNameDisplay, 'evokedResp', 'evoked response');
    varNameDisplay = regexprep(varNameDisplay, 'eventDetect', 'event detection');
    varNameDisplay = regexprep(varNameDisplay, 'crossCorr', 'cross-correlation');
    varNameDisplay = regexprep(varNameDisplay, 'sum', '(sum)');
    varNameDisplay = regexprep(varNameDisplay, 'max', '(peak)');
    varNameDisplay = regexprep(varNameDisplay, 'bestLagTime', '(best lag-time)');
    varNameDisplay = regexprep(varNameDisplay, 'valueAtBestLagTime', '(corr. value at best lag-time)');
    varNameDisplay = regexprep(varNameDisplay, 'pValueAtBestLagTime', '(p-value at best lag-time)');
    varNameDisplay = regexprep(varNameDisplay, 'isCorrSignificant', '(corr. is significant)');
    varNameDisplay = regexprep(varNameDisplay, 'corrDirection', '(corr. direction)');
    varNameDisplay = regexprep(varNameDisplay, 'Trace', ' (trace)');
    varNameDisplay = regexprep(varNameDisplay, ') (', ', ');
    varNameDisplay = regexprep(varNameDisplay, 'earlyTimeWindow', 'early time window');
    varNameDisplay = regexprep(varNameDisplay, 'lateTimeWindow', 'late time window');
    values = ROITable.(varName);
    
    %% color scatter plot    
    % create the figure for this variable
    figure('NumberTitle', 'off', 'Name', sprintf('%s - color scatter plot', varNameDisplay), 'Position', figPos);

    % plot the scatter plot with animal grouping
    gscatter(depths, values, animIDs, '', '.', pointSize);

    % enhance figure
    makePrettyFigure();
    title(sprintf('%s VS depth', varNameDisplay), 'Interpreter', 'none', 'FontSize', titleFontSize);
    xlabel('Depth [um]', 'FontSize', axeLabelFontSize);
    ylabel(varNameDisplay, 'FontSize', axeLabelFontSize);
    set(gca, 'FontSize', axeFontSize);

    % adjust Y limits if needed
    yLim = get(gca, 'YLim');
    if yLim(1) == 0; yLim(1) = -5; end;
    set(gca, 'YLim', yLim);

    % save plot if required
    if doSavePlots;
        saveas(gcf, sprintf('%sfig/scatterPlotColor_%s.fig', savePath, varName));
        export_fig(sprintf('%spng/scatterPlotColor_%s.png', savePath, varName), saveRes, gcf);
        close all;
    end;
    
    %% gray scatter plot    
    % create the figure for this variable
    figure('NumberTitle', 'off', 'Name', sprintf('%s - gray scatter plot', varNameDisplay), 'Position', figPos);

    % plot the scatter plot
    scatter(depths, values, pointSize, 'kx');

    % enhance figure
    makePrettyFigure();
    title(sprintf('%s VS depth', varNameDisplay), 'Interpreter', 'none', 'FontSize', titleFontSize);
    xlabel('Depth [um]', 'FontSize', axeLabelFontSize);
    ylabel(varNameDisplay, 'FontSize', axeLabelFontSize);
    set(gca, 'FontSize', axeFontSize);

    % adjust Y limits
    yLim = get(gca, 'YLim');
    if yLim(1) == 0; yLim(1) = -5; end;
    set(gca, 'YLim', yLim);

    % save plot if required
    if doSavePlots;
        saveas(gcf, sprintf('%sfig/scatterPlotGray_%s.fig', savePath, varName));
        export_fig(sprintf('%spng/scatterPlotGray_%s.png', savePath, varName), saveRes, gcf);
        close all;
    end;
    
    %% boxplots with binning
    % calculate the binned values
    binW = 50; minDepth = 0; maxDepth = 900;
    depthBinsBorders = minDepth : binW : maxDepth;
    nBins = numel(depthBinsBorders);
    depthBinsCenters = (binW / 2) + depthBinsBorders;
    [binCount, grouping] = histc(depths, [-Inf, depthBinsBorders(2 : end - 1), Inf]);
    existingUniqueGroups = unique(grouping);
    
    % create the figure for this variable
    figure('NumberTitle', 'off', 'Name', sprintf('%s - boxplot', varNameDisplay), 'Position', figPos);
    
    % plot the scatter plot
    boxplot(values, grouping, 'positions', depthBinsCenters(existingUniqueGroups), ...
        'labels', repmat({''}, 1, numel(existingUniqueGroups)), 'widths', binW * 0.9);
    xlim([minDepth, maxDepth]);
    set(gca, 'XTick', depthBinsBorders, 'XTickLabel', depthBinsBorders);

    % enhance figure
    makePrettyFigure();
    title(sprintf('%s VS depth', varNameDisplay), 'Interpreter', 'none', 'FontSize', titleFontSize);
    xlabel('Depth [um]', 'FontSize', axeLabelFontSize);
    ylabel(varNameDisplay, 'FontSize', axeLabelFontSize);
    set(gca, 'FontSize', axeFontSize);

    % adjust Y limits
    yLim = get(gca, 'YLim');
    if yLim(1) == 0; yLim(1) = -5; end;
    set(gca, 'YLim', yLim);

    % save plot if required
    if doSavePlots;
        saveas(gcf, sprintf('%sfig/boxPlotBinning_%s.fig', savePath, varName));
        export_fig(sprintf('%spng/boxPlotBinning_%s.png', savePath, varName), saveRes, gcf);
        close all;
    end;
    
    % plot the number of ROIs per depth collected
    if iVar == 6;
        
        % create the figure for this variable
        figure('NumberTitle', 'off', 'Name', 'number of neuron - boxplot', 'Position', figPos);

        % plot the scatter plot
        [y, x] = hist(depths, depthBinsCenters);
        bar(x, y);
        xlim([minDepth, maxDepth]);
        set(gca, 'XTick', depthBinsBorders, 'XTickLabel', depthBinsBorders);

        % enhance figure
        makePrettyFigure();
        title('Number of neurons per depth bin', 'Interpreter', 'none', 'FontSize', titleFontSize);
        xlabel('Depth [um]', 'FontSize', axeLabelFontSize);
        ylabel('Number of neuron', 'FontSize', axeLabelFontSize);
        set(gca, 'FontSize', axeFontSize);

        % save plot if required
        if doSavePlots;
            saveas(gcf, sprintf('%sfig/boxPlotBinning_nNeurons.fig', savePath));
            export_fig(sprintf('%spng/boxPlotBinning_nNeurons.png', savePath), saveRes, gcf);
            close all;
        end;
        
    end;
    
end;

warning('on', 'MATLAB:LargeImage');