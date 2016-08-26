function OCIA_startFunction_motionAnalysis(this)
% OCIA_startFunction_motionAnalysis - [no description]
%
%       OCIA_startFunction_motionAnalysis(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

    % go to DataWatcher mode
    OCIAChangeMode(this, 'DataWatcher');

    if ischar(this.GUI.dw.DWWatchTypes);
        DWWatchTypesStr = this.GUI.dw.DWWatchTypes;
    elseif iscell(this.GUI.dw.DWWatchTypes);
        DWWatchTypesStr = ['|', sprintf('%s|', this.GUI.dw.DWWatchTypes{:})];
    else
        DWWatchTypesStr = '?';
    end;

    showMessage(this, sprintf(['Processing options: start function: %s, noGUI: %d, DWFilt: %s, ', ...
        'DWWatchTypes: %s, DWSkiptMeta: %d, preProcOptions: %s, rawOrLocal: %s.'], ...
        regexprep(mfilename(), 'OCIA_startFunction_', ''), this.GUI.noGUI, ...
        ['|', sprintf('%s|', this.GUI.dw.DWFilt{:})], DWWatchTypesStr, ...
        this.GUI.dw.DWSkiptMeta, ['|', sprintf('%s|', this.an.an.preProcOptions{:})], this.GUI.dw.DWRawOrLocal));

    % process the selected folder and extract the notebook informations
    DWProcessWatchFolder(this);

    if size(this.dw.table, 1) == 0;
        showWarning(this, 'OCIA:OCIAStartFunction:motionAnalysisPipeline:TableEmpty', 'Table is empty. Aborting');
        return;
    end;

    % if there are any filters for row type or run type, select them
    GUIDWFiltH = this.GUI.handles.dw.filt;
    if ~isempty(get(GUIDWFiltH.rowtype, 'String')) || ~isempty(get(GUIDWFiltH.runtype, 'String'));
        DWFilterSelectTable(this, 'new');
    end;
    
    %% analyse response delays
    animalID = this.an.behav{1, 4}.mouseId;
    saveName = sprintf('respDelays_%s', animalID);
    savePath = 'E:/Analysis/motionAnalysis/';
    respDelayFigH = figure('Name', saveName, 'NumberTitle', 'off');
    respDelaysNaNs = cell2mat(cellfun(@(s)s.respDelays, this.an.behav(:, 4), 'UniformOutput', false)');
    respDelays = respDelaysNaNs(~isnan(respDelaysNaNs));
    nTrials = numel(respDelays);
    subplot(1, 10, 1 : 6);
    scatter(1 : nTrials, respDelays, 'bx');
    meanRespDelay = nanmean(respDelays);
    hold on;
    meanLineH = line([1 nTrials], repmat(meanRespDelay, 1, 2), 'Color', 'red', 'LineStyle', ':', 'LineWidth', 3);
    title(sprintf('Response delays for %s', animalID), 'Interpreter', 'none');
    xlabel('Trials');
    ylabel('Response delay from tone onset (s)');
    subplot(1, 10, 8 : 10);
    [xOutHits, yOutHits] = hist(respDelays, 1000);
    plot(xOutHits, yOutHits);
    makePrettyFigure(respDelayFigH);
    tightfig(respDelayFigH);
    set(respDelayFigH, 'Position', get(this.GUI.figH, 'Position'));
    set(meanLineH, 'LineWidth', 3);
    saveas(respDelayFigH, sprintf('%s%s', savePath, saveName));
    
    %% analyse response delays
    animalID = this.an.behav{1, 4}.mouseId;
    saveName = sprintf('respDelays_%s_hitsVSFalseAls', animalID);
    savePath = 'E:/Analysis/motionAnalysis/';
    respDelayFigH = figure('Name', saveName, 'NumberTitle', 'off');
    respDelaysNaNs = cell2mat(cellfun(@(s)s.respDelays, this.an.behav(:, 4), 'UniformOutput', false)');
    respDelays = respDelaysNaNs(~isnan(respDelaysNaNs));
    nTrials = numel(respDelays);
    respTypes = cell2mat(cellfun(@(s)s.respTypes, this.an.behav(:, 4), 'UniformOutput', false)');
    respTypes = respTypes(~isnan(respDelaysNaNs));
    hits = respTypes == 1 | respTypes == 2;
    falseAls = ~hits;
    respDelaysHits = respDelays;
    respDelaysHits(falseAls) = NaN;
    respDelaysFalsAls = respDelays;
    respDelaysFalsAls(hits) = NaN;
    subplot(2, 10, 1 : 6);
    hold on;
    scatter(1 : nTrials, respDelaysHits,   'bx');
    scatter(1 : nTrials, respDelaysFalsAls, 'rx');
    meanRespDelayHits = nanmean(respDelaysHits);
    meanRespDelayFalsAls = nanmean(respDelaysFalsAls);
    meanLineHGos = line([1 nTrials], repmat(meanRespDelayHits, 1, 2), 'Color', 'blue');
    meanLineHNoGos = line([1 nTrials], repmat(meanRespDelayFalsAls, 1, 2), 'Color', 'red');
    title(sprintf('Response delays for %s, blue is correct trials, red is false alarm trials', animalID), 'Interpreter', 'none');
    xlabel('Trials');
    ylabel('Response delay from tone onset (s)');
    subplot(2, 10, 8 : 10);
    [xOutHits, yOutHits] = hist(respDelaysHits, 1000);
    [xOutFalsAls, yOutFalsAls] = hist(respDelaysFalsAls, 1000);
    hold on;
    plot(xOutHits, yOutHits, 'b');
    plot(xOutFalsAls, yOutFalsAls, 'r');
    subplot(2, 10, 11 : 20);
    boxplot([respDelaysHits, respDelaysFalsAls], [repmat(1, 1, nTrials), repmat(2, 1, nTrials)], ...
        'labels', {'Hits', 'FalseAlarms'});
%     set(gca, 'XTickLabel', );
    makePrettyFigure(respDelayFigH);
%     tightfig(respDelayFigH);
    set(respDelayFigH, 'Position', get(this.GUI.figH, 'Position'));
    set([meanLineHGos meanLineHNoGos], 'LineWidth', 2);
    saveas(respDelayFigH, sprintf('%s%s', savePath, saveName));

    %% --- #OCIA: launch: run motion correction & detection
    selRows = this.dw.selectedTableRows;
    nRows = numel(selRows);
    frameCorrs = cell(nRows, 1);
    for iRow = 1 : nRows;
        iDWRow = selRows(iRow);
        DWLoadRow(this, iDWRow, 'full');
        ANExtractBehavForRow(this, iDWRow, -1);
        ANFrameShiftCorrection(this, iDWRow);
        ANFrameJitterCorrection(this, iDWRow);
        ANMotionCorrection(this, iDWRow);
        frameCorrs{iRow} = ANMotionDetection(this, iDWRow);
        chanStats = ANCalcDRRForRow(this, iDWRow);
        DWFlushData(this, 'raw,preProc'); % for memory
    end;

    % --- #OCIA: launch: exclude bad rows
    NPilCell = this.data.img.caTraces(selRows);
    NPilCell = cellfun(@(caTraces) caTraces(end, :), NPilCell, 'UniformOutput', false);
    stimCell = this.data.img.stim(selRows);
    badRows = find(cellfun(@isempty, stimCell));
    stimCell(badRows) = [];
    frameCorrs(badRows) = [];
    NPilCell(badRows) = [];
    selRows(badRows) = [];
    nRows = numel(stimCell);

    % --- #OCIA: launch: re-arrange things for plotting
    stimFrames = cellfun(@(stim) find(stim > 0), stimCell);
    [~, iMaxStimFrame] = max(cellfun(@numel, frameCorrs));
    frameCorrsPaddedForStim = cell(nRows, 1);
    stimsPaddedForStim = cell(nRows, 1);
    nPilPaddedForStim = cell(nRows, 1);
    for iRow = 1 : nRows;
        if iRow ~= iMaxStimFrame;
            nPadFramesBefore = stimFrames(iMaxStimFrame) - stimFrames(iRow);
            frameCorrsPaddedForStim{iRow} = [nan(1, nPadFramesBefore) frameCorrs{iRow}];
            stimsPaddedForStim{iRow} = [zeros(1, nPadFramesBefore) stimCell{iRow}];
            nPilPaddedForStim{iRow} = [nan(1, nPadFramesBefore) NPilCell{iRow}];
        else
            frameCorrsPaddedForStim{iRow} = frameCorrs{iRow};
            stimsPaddedForStim{iRow} = stimCell{iRow};
            nPilPaddedForStim{iRow} = NPilCell{iRow};
        end;
    end;

    frameCorrsPaddedForLength = cell(nRows, 1);
    stimsPaddedForLength = cell(nRows, 1);
    nPilPaddedForLength = cell(nRows, 1);
    [maxFrames, iMaxFrames] = max(cellfun(@numel, frameCorrsPaddedForStim));
    for iRow = 1 : nRows;
        if iRow ~= iMaxFrames;
            nPadFramesAfter = maxFrames - numel(frameCorrsPaddedForStim{iRow});
            frameCorrsPaddedForLength{iRow} = [frameCorrsPaddedForStim{iRow} nan(1, nPadFramesAfter)];
            stimsPaddedForLength{iRow} = [stimsPaddedForStim{iRow} zeros(1, nPadFramesAfter)];
            nPilPaddedForLength{iRow} = [nPilPaddedForStim{iRow} nan(1, nPadFramesAfter)];
        else
            frameCorrsPaddedForLength{iRow} = frameCorrsPaddedForStim{iRow};
            stimsPaddedForLength{iRow} = stimsPaddedForStim{iRow};
            nPilPaddedForLength{iRow} = nPilPaddedForStim{iRow};
        end;
    end;

    frameCorrsPaddedMat = cell2mat(frameCorrsPaddedForLength);
    nPilPaddedMat = cell2mat(nPilPaddedForLength);

    % --- #OCIA: launch: plot frame corrs
    frameRate = 77.7;
    concatTime = (1 : size(frameCorrsPaddedMat, 2)) / frameRate;

    rowIDs = regexprep(this.dw.table(selRows, 3), '_', '');
    rowIDs = arrayfun(@(iRun)sprintf('%s', rowIDs{iRun, :}), 1 : nRows, 'UniformOutput', false);

    traceToPlotName = {'frameCorr', 'NPil'};
    traceToPlot = {frameCorrsPaddedMat, nPilPaddedMat};

    for iToPlot = 1 : numel(traceToPlot);

        saveName = sprintf('%s_%s_%s_%s', this.dw.table{selRows(end), [6 7 2]}, traceToPlotName{iToPlot});
        savePath = 'E:/Analysis/motionAnalysis/';
        commonArgs = {
            [];
            0; saveName;
            traceToPlot{iToPlot};        % calcium traces as a nROI-by-nFrames matrix
            [];
            stimsPaddedForLength{1};    % stimulus as a nFrames long vector
            rowIDs';                    % name and coordinates of the lines
            concatTime;                 % time
            [];
        };

        figTraceCorr = plotROICaTraces(commonArgs{:});
        tightfig(figTraceCorr);
        set(figTraceCorr, 'Position', get(this.GUI.figH, 'Position'));
        ylabel(traceToPlotName{iToPlot});


        % --- #OCIA: launch: color and save stuff
        child = get(figTraceCorr, 'Children');
        lineHandles = get(child(1), 'Children');
        set(lineHandles(end), 'Color', 'black', 'LineStyle', ':');
        lineHandles(end) = [];
        lineHandles = flipud(lineHandles);
        colLab = {'targ', 'corr', 'low', 'go'};
        colLabOpp = {'distr', 'false', 'high', 'nogo'};
        for iLab = 1 : numel(colLab);

            isTarget = false(nRows, 1);
            for iRow = 1 : nRows;

                comment = this.dw.table{selRows(iRow), end};
                if strcmp(colLab{iLab}, 'go');
                    isTarget(iRow) = this.data.behav(selRows(iRow)).resp;
                else
                    isTarget(iRow) = ~isempty(regexp(comment, colLab{iLab}, 'once'));
                end;

                if isTarget(iRow);  set(lineHandles(iRow), 'Color', 'red');
                else                set(lineHandles(iRow), 'Color', 'black');
                end;
            end;
            figure(figTraceCorr);
            title(sprintf('%s_%sVS%s: %s is red, %s is black', saveName, colLab{iLab}, colLabOpp{iLab}, ...
                colLab{iLab}, colLabOpp{iLab}), 'Interpreter', 'none');
            set(figTraceCorr, 'Name', sprintf('%s_%sVS%s', saveName, colLab{iLab}, colLabOpp{iLab}));
            saveas(figTraceCorr, sprintf('%s%s_%sVS%s', savePath, saveName, colLab{iLab}, colLabOpp{iLab}));

            figTraceMean = figure('Name', sprintf('%s_%sVS%s_mean', saveName, colLab{iLab}, colLabOpp{iLab}));
            plot(concatTime, nanmean(traceToPlot{iToPlot}(isTarget, :)), 'r');
            hold on;
            plot(concatTime, nanmean(traceToPlot{iToPlot}(~isTarget, :)), 'k');
            stimTime = find(stimsPaddedForLength{1}) / frameRate;
            yLims = get(gca, 'YLim');
            line([stimTime stimTime], yLims, 'Color', 'black', 'LineStyle', ':');
            xlabel('Time (s)'); ylabel(sprintf('mean %s', traceToPlotName{iToPlot}));
            title(sprintf('%s_%sVS%s_mean: %s is red, %s is black', saveName, colLab{iLab}, colLabOpp{iLab}, ...
                colLab{iLab}, colLabOpp{iLab}), 'Interpreter', 'none');
            saveas(figTraceMean, sprintf('%s%s_%sVS%s_mean', savePath, saveName, colLab{iLab}, colLabOpp{iLab}));

        end;
    end;
            
end
