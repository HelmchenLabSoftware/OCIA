function ROIStats = analyseROIStatsSingleDay(config)

dbgLevel = 2;

%% TODO: summary figure of BS preference for all neurons and their "confidence" (as an X over the point?)
%% TODO: plot correlations to neuropil as scatter plot and have a mean neuropil correlation
%%       => should decrease with ROI size (imcrop or imshrink)
%% TODO: ANOVA
%% TODO: Event detection

%% Initialization - prepare ROIStats, ROISet, etc.
o('      #analyseROIStatsSingleDay: initialization ...', 1, dbgLevel);

if ~isfield(config, 'axeH'); config.axeH = []; end; % plotting in new figures

ROIStats = struct();
filters = {'unfilt'};
ROIStats.runs.unfilt = config.ROIStatsData;
nFrames = max(max(cellfun(@(x)size(x, 2), ROIStats.runs.unfilt))); % take the number of frames of the longest run
nFramesFilt = nFrames;

% replace missing runs with NaNs
ROIStats.runs.unfilt(cellfun(@isempty, ROIStats.runs.unfilt(:))) = {nan(1, nFrames)};
 
ROISet = config.ROISet;
stimIDs = config.stimIDs;
if size(ROISet, 2) > 2;
    ROISet(:, 3 : 4) = []; % make space for useful stuff
end;

if config.targetROIs;
    ROIStats.runs.unfilt = ROIStats.runs.unfilt(config.targetROIs, :);
    ROISet = ROISet(config.targetROIs, :);
    if ~strcmp(ROISet{end, 1}, 'NPil');
        warning('analyseROIStatsSingleDay:NoNPil', 'No neuropil included!');
    end;
end;

if config.targetStims;
    ROIStats.runs.unfilt = ROIStats.runs.unfilt(:, config.targetStims);
    stimIDs = stimIDs(:, config.targetStims);
end;

% exclude all empty or all NaN ROIs
allRunsTrace = cell2mat(ROIStats.runs.unfilt(:, :));
validROIs = nansum(isnan(allRunsTrace) + allRunsTrace, 2) ~= 0;
ROISet = ROISet(validROIs, :); % keep only valid ROIs
ROIStats.runs.unfilt = ROIStats.runs.unfilt(validROIs, :);

nROIs = size(ROISet, 1);
nRuns = size(ROIStats.runs.unfilt, 2);

o('        #analys..ngleDay: %d ROIs, %d runs, %d stimulus types.', nROIs, nRuns, numel(stimIDs), 2, dbgLevel);

% if there are no runFileIDs, create some base on the run number
if ~isfield(config, 'runFileIDs') || isempty(config.runFileIDs);
    config.runFileIDs = cell(nRuns, 1);
    for iRun = 1 : nRuns; config.runFileIDs{iRun} = sprintf('Run%02d', iRun); end;
end;

% sort the ROIs according to name
[~, ROISetSortIndexes] = sort(ROISet(:, 1));
ROISet = ROISet(ROISetSortIndexes, :);
ROIStats.ROISet = ROISet;
% store the stimulus
ROIStats.stim = config.stim;

% init the time scale
time = (1 : nFrames) / config.frameRate;
timeFilt = (1 : nFrames) / config.frameRate;

% filter traces
if isfield(config, 'bpfilter') && ~isempty(config.bpfilter);
    filtTic = tic; % for performance timing purposes
    filters = [filters, 'bpfilt'];
    ROIStats.runs.bpfilt = cell(size(ROIStats.runs.unfilt));
    for iRun = 1 : nRuns;
        for iROI = 1 : nROIs;
            caTrace = ROIStats.runs.unfilt{iROI, iRun};
            % if the ROI trace is not empty/null
            if nansum(caTrace);
                singleFiltTic = tic; % for performance timing purposes
                ROIStats.runs.bpfilt{iROI, iRun} = mpi_BandPassFilterTimeSeries(caTrace, 1 / config.frameRate, ...
                    config.bpfilter.low, config.bpfilter.high);
                o('          #analys..ngleDay: ROI%s (%03d) - run %d: filtering done (%3.1f sec).', ROISet{iROI, 1}, ...
                    iROI, iRun, toc(singleFiltTic), 5, dbgLevel);
            else
                ROIStats.runs.bpfilt{iROI, iRun} = caTrace;
                o('          #analys..ngleDay: ROI%s (%03d) - run %d: NaN or empty. Skipping.', ROISet{iROI, 1}, ...
                    iROI, iRun, 4, dbgLevel);
            end;
        end;
    end;
    o('        #analys..ngleDay: band-pass filtering done (%3.1f sec).', toc(filtTic), 2, dbgLevel);
end;
if isfield(config, 'sgfilter') && ~isempty(config.sgfilter) && config.sgfilter.poly + config.sgfilter.win > 1;
    filtTic = tic; % for performance timing purposes
    filters = [filters, 'sgfilt'];
    ROIStats.runs.sgfilt = cell(size(ROIStats.runs.unfilt));
    for iRun = 1 : nRuns;
        for iROI = 1 : nROIs;
            caTrace = ROIStats.runs.unfilt{iROI, iRun};
            % if the ROI trace is not empty/null
            if nansum(caTrace) && config.sgfilter.poly + config.sgfilter.win > 0;
                singleFiltTic = tic; % for performance timing purposes
                % make sure window is odd
                if mod(config.sgfilter.win, 2) == 0; config.sgfilter.win = config.sgfilter.win + 1; end;
                ROIStats.runs.sgfilt{iROI, iRun} = sgolayfilt(caTrace, config.sgfilter.poly, config.sgfilter.win);
                o('          #analys..ngleDay: ROI%s (%03d) - run %d: filtering done (%3.1f sec).', ROISet{iROI, 1}, ...
                    iROI, iRun, toc(singleFiltTic), 5, dbgLevel);
            else
                ROIStats.runs.sgfilt{iROI, iRun} = caTrace;
                o('          #analys..ngleDay: ROI%s (%03d) - run %d: NaN or empty. Skipping.', ROISet{iROI, 1}, ...
                    iROI, iRun, 4, dbgLevel);
            end;
        end;
    end;
    o('        #analys..ngleDay: Savitzky-Golay filtering done (%3.1f sec).', toc(filtTic), 2, dbgLevel);
end;
if isfield(config, 'downSampleFactor') && config.downSampleFactor > 1;
    filtTic = tic; % for performance timing purposes
    filters = [filters, 'dsfilt'];
    ROIStats.runs.dsfilt = cell(size(ROIStats.runs.unfilt));
    config.DSStim = cell(size(config.stim));
    targetFrameRate = config.frameRate / config.downSampleFactor;
    timeFilt = (1 : nFrames) / (config.frameRate / config.downSampleFactor);
    config.DSPSFrames = config.PSFrames;
    config.DSPSFrames.base = round(config.PSFrames.base / config.downSampleFactor);
    config.DSPSFrames.evoked = round(config.PSFrames.evoked / config.downSampleFactor);
    for iRun = 1 : nRuns;
        for iROI = 1 : nROIs;
            caTrace = ROIStats.runs.unfilt{iROI, iRun};
            % if the ROI trace is not empty/null
            if nansum(caTrace);
                singleFiltTic = tic; % for performance timing purposes
                ROIStats.runs.dsfilt{iROI, iRun} = interp1DS(config.frameRate, targetFrameRate, caTrace);
                config.DSStim{iRun} = interp1DS(config.frameRate, targetFrameRate, config.stim{iRun});
                config.DSStim{iRun} = round(config.DSStim{iRun});
                o('          #analys..ngleDay: ROI%s (%03d) - run %d: downsampling done (%3.1f sec).', ...
                    ROISet{iROI, 1}, iROI, iRun, toc(singleFiltTic), 5, dbgLevel);
                nFramesFilt = size(ROIStats.runs.dsfilt{iROI, iRun}, 2);
            else
                ROIStats.runs.dsfilt{iROI, iRun} = caTrace;
                o('          #analys..ngleDay: ROI%s (%03d) - run %d: NaN or empty. Skipping.', ROISet{iROI, 1}, ...
                    iROI, iRun, 4, dbgLevel);
            end;
        end;
    end;
    o('        #analys..ngleDay: downsampling done (%3.1f sec).', toc(filtTic), 2, dbgLevel);
end;

% do the peri-stimulus trace extraction
if config.doPSAnalysis;
    
    o('        #analys..ngleDay: peri-stimulus trace extraction ...', 2, dbgLevel);
    PSExtractTic = tic; % for performance timing purposes
    ROIStats.PS = struct();
    % store the peri-stimulus frame settings
    ROIStats.PS.PSFrames = config.PSFrames;
    for iFilt = 1 : numel(filters);
        PSExtractSingleFiltTic = tic; % for performance timing purposes
        filt = filters{iFilt};
        PSFrames = config.PSFrames;
        stims = config.stim;
        if strcmp(filt, 'dsfilt');
            stims = config.DSStim; PSFrames = config.DSPSFrames;
        end;
        % returns a cell array of nROIs x nStims containing in each cell a matrix of nRuns x nPSFrames
        ROIStats.PS.(filt).raw = extractPSTrace(ROIStats.runs.(filt), stims, PSFrames);
        o('        #analys..ngleDay: peri-stimulus trace extraction done for %s (%3.1f sec).',filt, ...
            toc(PSExtractSingleFiltTic), 2, dbgLevel);
    end;
    o('        #analys..ngleDay: peri-stimulus trace extraction done (%3.1f sec).', toc(PSExtractTic), ...
        2, dbgLevel);

    if isempty(ROIStats.PS.unfilt.raw) || ~any(~isnan(ROIStats.PS.unfilt.raw{1, 1}(:)));
        o('#analys..ngleDay: no peri-stimulus frame !', 0, dbgLevel);
        return;
    end;

    % average across the "trials" (runs/repetitions/blocks/whatever)
    PSStatCalcTic = tic; % for performance timing purposes
    stats = config.PSAnalysisStats;
    dims = {'trial'};
    UOF = {'UniformOutput', false};
    for iFilt = 1 : numel(filters);
        filt = filters{iFilt};

        % init the size of the data set
        nPSFrames = size(ROIStats.PS.(filt).raw{1, 1}, 2);
        nStims = size(ROIStats.PS.(filt).raw, 2);
        PSFrames = config.PSFrames;
        if strcmp(filters{iFilt}, 'dsfilt'); PSFrames = config.DSPSFrames; end;
        nPSEvokedFrames = nPSFrames - PSFrames.base;
        evokedRange = PSFrames.base + 1 : nPSFrames;
        PSTime = ((1 : nPSFrames) - PSFrames.base) / config.frameRate;
        o('        #analys..ngleDay: %d stim(s), %d PSFrame(s).', nStims, nPSFrames, 2, dbgLevel);

        for iDim = 1 : numel(dims);
            dim = dims{iDim};
            ROIStats.PS.(filt).(dim) = struct();

            for iStat = 1 : numel(stats);
                stat = stats{iStat};
                fHandle = str2func(['nan' stat]);

                switch(dim);
                    case 'trial';
                        % average for each ROI separately across trials
                        cellArr = cell(nROIs, 1);
                        for iROI = 1 : nROIs;
                            % if there is only one trial, there is no point of averaging for it
                            nTrialsForROIs = sum(cellfun(@(ROITrace)size(ROITrace, 1), ROIStats.PS.(filt).raw(iROI, :)));
                            if nTrialsForROIs == 1;
                                cellArr(iROI) = ROIStats.PS.(filt).raw(iROI, :)';
                                Ns{1} = 1;
                            else
                                Ns = cellfun(@size, ROIStats.PS.(filt).raw(iROI, :), UOF{:});
                                cellArrayStat = cellfun(fHandle, ROIStats.PS.(filt).raw(iROI, :), UOF{:})';
                                singleValueStat = cellfun(@(x)size(x, 2) == 1, cellArrayStat);
                                cellArrayStat(singleValueStat) = ROIStats.PS.(filt).raw(iROI, singleValueStat);
                                cellArr{iROI} = cell2mat(cellArrayStat);
                            end;
                        end;
                        ROIStats.PS.(filt).(dim).(stat).N = Ns{1}(1);
                        % reshape to a 3D matrix of size nStims x nPSFrames x nROIs
                        ROIStats.PS.(filt).(dim).(stat).all = reshape(cell2mat(cellArr'), nStims, nPSFrames, nROIs);
                        % reshape to a 3D matrix of nPSFrames x nROIs x nStims
                        ROIStats.PS.(filt).(dim).(stat).all = permute(ROIStats.PS.(filt).(dim).(stat).all, [2, 3, 1]);
                        ROIStats.PS.(filt).(dim).(stat).evoked = ROIStats.PS.(filt).(dim).(stat).all(evokedRange, :, :);
                        % normalized by the mean of the baseline
                        ROIStats.PS.(filt).(dim).(stat).allNorm = ROIStats.PS.(filt).(dim).(stat).all - ...
                            repmat(nanmean(ROIStats.PS.(filt).(dim).(stat).all(1 : PSFrames.base, :, :)), nPSFrames, 1);
                        ROIStats.PS.(filt).(dim).(stat).evokedNorm = ...
                            ROIStats.PS.(filt).(dim).(stat).allNorm(evokedRange, :, :);
                end;
            end;
        end;
    end;

    o('        #analys..ngleDay: peri-stimulus trace averagings done (%3.1f sec).', toc(PSStatCalcTic), 2, dbgLevel);

end;

%% - Experimental event detection
if config.eventDetect.performEventDetect
    ticPlot = tic;
    for iFilt = 2:numel(filters)
        filt = filters{iFilt};
         ROIStats.stats.(filt).eventDetection = eventDetector(ROIStats.runs.(filt), config.stim, config.eventDetect.method, config.frameRate, ...
           config.PSFrames, 'eventDetectTest');
           
           %[ROIStats.runs(filt).eventDetection.eventMatAllRuns, ROIStats.runs(filt).eventDetection.instFiringRateAllRuns, ROIStats.runs(filt).eventDetection.residuals, ROIStats.runs(filt).eventDetection.models] = testingEventDetector(ROIStats.runs.(filt), config.stim, config.eventDetect.method, config.frameRate, ...
           %config.PSFrames, 'eventDetectTest');
       % Save a plot with the deconvolved calcium traces
       if config.doSaveEventDeconvPlot
        modelTraces = cell2mat(ROIStats.stats.(filt).eventDetection.models);
        commonArgs = {
            config.axeH;
            iRun; config.runFileIDs{iRun};      % run number and figure name
            modelTraces;                           % calcium traces as a nROI-by-nFrames matrix
            [];                       % filtered calcium traces as a nROI-by-nFrames matrix
            config.stim{iRun};                  % stimulus as a nFrames long vector
            ROISet;                             % name and coordinates of the rois
            time(1 : size(modelTraces, 2));        % time scale
            [];  % time scale
            };
        figTrace = plotROICaTraces(commonArgs{:});
        saveFigToDir(figTrace, sprintf('%s_ROICaTracesDeconv_allRunsConcat', config.saveName), ...
            'ROICaTracesDeconv', config.doSaveEventDeconvPlot, 1, 1);
       end;
    end;
    o('        #analys..ngleDay: Event detection done (%3.1f sec).', toc(ticPlot), 2, dbgLevel);
    
end;

%% - Experimental analysis routines for event detection (alex specific - sorry bro)
if config.spontaneousEventCorrelationAnalysis
    saveNameStim = sprintf('%s_SpontVsEvokedCorrAnalysis_%s', config.saveName, filt);
    dimX = config.img_dims{1}(1);
    dimY = config.img_dims{1}(2);
    
    [figHandsSpontCorrAnalysis, ROIStats.stats.sgfilt.eventDetection.eventDetectInterROICorr, ...
        ROIStats.stats.sgfilt.eventDetection.roiDistance] = eventDetectionCorrelationAnalysis(ROISet, ...
        dimX, dimY, [], ROIStats.stats.sgfilt.eventDetection.models, ROIStats.stats.sgfilt.eventDetection.eventMatAllRuns,  config.stim{1,1});
    
    for iFig = 1 : numel(figHandsSpontCorrAnalysis);
        saveFigToDir(figHandsSpontCorrAnalysis(iFig), sprintf('%s_%02d', saveNameStim, iFig), 'SpontVsEvokedCorrAnalysis', ...
            config.spontaneousEventCorrelationAnalysis, 1, config.spontaneousEventCorrelationAnalysis < 2);
    end;
    
    
    o('        #analys..ngleDay: Event correlation analysis done (%3.1f sec).', toc(ticPlot), 2, dbgLevel);
end;

%% All runs 'noise' analysis
if config.doSaveROICaTracesAllRunsPlot || config.doSaveROICaTracesHeatMapAllRunsPlot;
    
    ticPlot = tic;
    for iFilt = 1 : numel(filters);
        filt = filters{iFilt};
        if ~strcmp(filters{iFilt}, 'dsfilt');
            nNaNSpacing = round(nFrames * 0.03); % in frames
        else
            nNaNSpacing = round(nFrames * 0.03) / config.downSampleFactor; % in frames
        end;
        ROIStats.runs.([filt '_allWithNaNSpacing']) = cell2mat(cellfun(@(caTrace) [caTrace nan(1, nNaNSpacing)], ...
                ROIStats.runs.(filt), 'UniformOutput', false));
        concatStim = cell2mat(cellfun(@(stimVect) [stimVect zeros(1, nNaNSpacing)], ...
            config.stim, 'UniformOutput', false));
    end;
%     runBoundaries = zeros(1, size(ROIStats.runs.([filters{1} '_allWithNaNSpacing']), 2));
%     runBoundaries(isnan(ROIStats.runs.([filters{1} '_allWithNaNSpacing'])(1, :))) = 1;
    concatTime = (1 : size(ROIStats.runs.([filters{1} '_allWithNaNSpacing']), 2)) / config.frameRate;
    concatTimeFilt = 1 : size(ROIStats.runs.([filters{end} '_allWithNaNSpacing']), 2);
    if ~strcmp(filters{end}, 'dsfilt');
        concatTimeFilt = concatTimeFilt / config.frameRate;
    else
        concatTimeFilt = concatTimeFilt / (config.frameRate / config.downSampleFactor);
    end;
    
    commonArgs = {
        config.axeH;
        0; sprintf('%s_ROICaTraces_allRunsConcat', config.saveName);  % run number and figure name
        ROIStats.runs.([filters{1} '_allWithNaNSpacing']);  % calcium traces as a nROI-by-nFrames matrix
        ROIStats.runs.([filters{end} '_allWithNaNSpacing']);  % filtered calcium traces as a nROI-by-nFrames matrix
%         runBoundaries;                  % run boundary labels
        concatStim;                     % stimulus as a nFrames long vector
        ROISet;                         % name and coordinates of the rois
        concatTime;                     % time
        concatTimeFilt;                     % time
    };

    if config.doSaveROICaTracesAllRunsPlot;
        figTrace = plotROICaTraces(commonArgs{:});
        saveFigToDir(figTrace, sprintf('%s_ROICaTraces_allRunsConcat', config.saveName), ...
            'ROICaTraces', config.doSaveROICaTracesAllRunsPlot, 1, 1);
    end;
    if config.doSaveROICaTracesHeatMapAllRunsPlot;
        figHeatMap = plotROICaTracesHeatMap(commonArgs{:}, config.plotLimits, config.colormap);
        saveFigToDir(figHeatMap, sprintf('%s_ROICaHeatMapTraces_allRunsConcat', config.saveName), ...
            'ROICaHeatMapTraces', config.doSaveROICaTracesHeatMapAllRunsPlot, 1, 1);
    end;
    o('        #analys..ngleDay: ROICaTraces(HeatMap)AllRunsPlot done (%3.1f sec).', toc(ticPlot), 2, dbgLevel);
end;


%% Noise level analysis
if config.doSaveAnalyseNoiseLvl;
    ticNoise = tic;
    for iFilt = 2 : numel(filters);
        filt = filters{iFilt};
        saveNameNoise = sprintf('%s_NoiseLevel_%s', config.saveName, filt);
        [ROIStats.stats.(filt).noiseLevels, ROIStats.stats.(filt).noiseLevelThresh] = ...
            analyseNoiseLevel(ROIStats.runs.(filt), ROISet, config.noiseThreshFactor, ...
            saveNameNoise, config.doSaveAnalyseNoiseLvl, 1, config.doSaveAnalyseNoiseLvl - 2);
    end;
    o('        #analys..ngleDay: analyseNoiseLevel done (%3.1f sec).', toc(ticNoise), 2, dbgLevel);
end;

%% ROI calcium traces plot - trace & heat map plots
if config.doSaveROICaTracesPlot || config.doSaveROICaTracesHeatMapPlot;
    ticPlot = tic;
    
    allHandlesTraces = zeros(nRuns, 1); % array of figure handles for group saving
    allHandlesHeatMap = zeros(nRuns, 1); % array of figure handles for group saving
    
    % plot all traces for each run
    for iRun = 1 : nRuns;
        
        modelTraces = cell2mat(ROIStats.runs.(filters{1})(:, iRun));
        caTracesFilt = cell2mat(ROIStats.runs.(filters{end})(:, iRun));
        
        % common args for "ROICaTraces" type plot
        commonArgs = {
            config.axeH;
            iRun; config.runFileIDs{iRun};      % run number and figure name
            modelTraces;                           % calcium traces as a nROI-by-nFrames matrix
            caTracesFilt;                       % filtered calcium traces as a nROI-by-nFrames matrix
            config.stim{iRun};                  % stimulus as a nFrames long vector
            ROISet;                             % name and coordinates of the rois
            time(1 : size(modelTraces, 2));        % time scale
            timeFilt(1 : size(caTracesFilt, 2));  % time scale
        };
        
        % plot (and maybe save) the figure if required 
        if config.doSaveROICaTracesPlot;
            o('      #analyseROIStatsSingleDay: plotting run %d/%d ...', iRun, nRuns, 4, dbgLevel);
            figTrace = plotROICaTraces(commonArgs{:});
            saveFigToDir(figTrace, sprintf('%s_ROICaTraces_run%02d', config.runFileIDs{iRun}, iRun), ...
                'ROICaTraces', config.doSaveROICaTracesPlot, 1, config.doSaveROICaTracesAsGroup < 1);
            o('      #analyseROIStatsSingleDay: plotting (and saving) run %d/%d done.', iRun, nRuns, 3, dbgLevel);
            allHandlesTraces(iRun) = figTrace; % save handle for group saving
        end;
        
        % plot (and maybe save) the figure if required 
        if config.doSaveROICaTracesHeatMapPlot;
            o('      #analyseROIStatsSingleDay: plotting run %d/%d ...', iRun, nRuns, 4, dbgLevel);
            figHeatMap = plotROICaTracesHeatMap(commonArgs{:}, config.plotLimits, config.colormap);
            saveFigToDir(figHeatMap, sprintf('%s_ROICaHeatMapTraces_run%02d', config.runFileIDs{iRun}, iRun), ...
                'ROICaHeatMapTraces', config.doSaveROICaTracesPlot, 1, config.doSaveROICaTracesHeatMapAsGroup < 1);
            o('      #analyseROIStatsSingleDay: plotting (and saving) run %d/%d done.', iRun, nRuns, 3, dbgLevel);
            allHandlesHeatMap(iRun) = figHeatMap; % save handle for group saving
        end;
        
    end;

    saveFigToDir(allHandlesTraces, sprintf('%s_ROICaTraces_allRuns', config.saveName), ...
        'ROICaTraces', config.doSaveROICaTracesAsGroup, 0, 1);
    saveFigToDir(allHandlesHeatMap, sprintf('%s_ROICaHeatMapTraces_allRuns', config.saveName), ...
        'ROICaHeatMapTraces', config.doSaveROICaTracesHeatMapAsGroup, 0, 1);
    o('        #analys..ngleDay: ROICaTraces(HeatMap)Plot done (%3.1f sec).', toc(ticPlot), 2, dbgLevel);
end;

% %% ROI calcium traces plot with behavior data
% if config.doSaveROICaTraceBehaviorPlot;
%     ticPlot = tic;
%     
% end;

%% Only create fields if event detection has not been performed yet!
if ~(config.eventDetect.performEventDetect)
    for iFilt = 2 : numel(filters);
        filt = filters{iFilt};
        if ~isfield(ROIStats,'stats')
            ROIStats.stats.(filt) = [];
        end;
    end;
end;


%% ROI vs NPil analysis
if config.doROINPilAnalysis;
    for iFilt = 2 : numel(filters);
        filt = filters{iFilt};
        ROIStats.stats.(filt).ROINPilResp = analyseROINPilAnova(ROIStats.PS.(filt).raw);
    end;
end;

%% cross correlation
if config.doCrossCorrAnalysis;
    for iFilt = 2 : numel(filters);
        filt = filters{iFilt};
        ROIStats.stats.(filt).crossCorrResp = analyseCrossCorr(ROIStats.PS.(filt).raw, config.frameRate, ...
            config.PSFrames, config.doSaveCrossCorrPlot);
    end;
end;

%% Inter-ROI whole run correlation
if config.doWholeRunCorrAnalysis;
    ticStat = tic;
    for iFilt = 2 : numel(filters);
        filt = filters{iFilt};
        ROIStats.stats.(filt).interROIRunCorr = analyseInterROIWholeRunCorrelations(ROIStats.runs.(filt), ROISet, ...
            sprintf('%s_InterROICorr_%s', config.saveName, filt), nRuns, config.runFileIDs, config.sortMethod, ...
            config.doSaveInterROICorrPlot);
    end;
    o('        #analys..ngleDay: analyseInterROIWholeRunCorrelations done (%3.1f sec).', toc(ticStat), 2, dbgLevel);
end;

%% Inter-trial correlation
if config.doInterTrialCorrAnalysis;
    ticStat = tic;
    for iFilt = 2 : numel(filters);
        filt = filters{iFilt};
        ROIStats.stats.(filt).interTrialMeanCorr = analyseInterTrialCorrelation(ROIStats.PS.(filt).raw, ROISet, ...
            config.PSFrames, stimIDs, 'sum', config.sortMethod, sprintf('%s_InterTrialCorr_%s', config.saveName, filt), ...
            config.doSaveInterTrialCorrPlot);
    end;
    o('        #analys..ngleDay: analyseInterTrialCorrelation done (%3.1f sec).', toc(ticStat), 2, dbgLevel);
end;


%% responsiveness with dprime
if config.doRespProbAnalysis;
    ticStat = tic;
    for iFilt = 2 : numel(filters);
        filt = filters{iFilt};
        [ROIStats.stats.(filt).respTrials, ROIStats.stats.(filt).respProb, ROIStats.stats.(filt).respProbErr] = ...
            analyseRespProb(ROIStats.PS.(filt).raw, config.respProbThresh, config.PSFramesRespProb, ROISet, stimIDs, ...
            sprintf('%s_RespProb_%s', config.saveName, filt), config.doSaveRespProbPlot);
    end;
    o('        #analys..ngleDay: response probability analysis done (%3.1f sec).', toc(ticStat), 2, dbgLevel);
end;

%% t-test on PS trace
if config.doTTestAnalysis;
    ticStat = tic;
    for iFilt = 2 : numel(filters);
        filt = filters{iFilt};
        ROIStats.stats.(filt).ttest = analyseRespTTest(ROIStats.PS.(filt).raw, config.ttestThresh, ...
            config.PSFramesRespProb, ROISet, stimIDs, sprintf('%s_RespTTest_%s', config.saveName, filt), ...
            config.doSaveTTestPlot);
    end;
    o('        #analys..ngleDay: t-test analysis done (%3.1f sec).', toc(ticStat), 2, dbgLevel);
end;


%% t-test on Neuropil signal
if config.doTTestNPil;
    for iFilt = 2 : numel(filters);
        filt = filters{iFilt};
        ROIStats.stats.(filt).ttestNPil = analyseNPilStats(ROIStats.PS.(filt).raw, config.ttestThresh, ...
            config.PSFramesRespProb, ROISet, stimIDs, sprintf('%s_NPilTTest_%s', config.saveName, filt), ...
            config.doSaveTTestNPil, config.sortMethod);
    end;
    o('        #analys..ngleDay: Neuropil t-test analysis done (%3.1f sec).', toc(ticStat), 2, dbgLevel);
end;
%{
%% Analyse tuning / find best stimulus response
%TODO: recode analyseTuning to work with chosen BS stats
if config.doTuningAnalysis;
    for iFilt = 1 : numel(filters);
        filt = filters{iFilt};
        ROIStats.stats.(filt).tuning = analyseTuning(ROIStats.PS.(filt).trial.mean.evokedNorm, ...
            ROIStats.PS.(filt).trial.sem.evoked);
        
    end;
    o('        #analys..ngleDay: Tuning analysis done (%3.1f sec).', toc(ticStat), 2, dbgLevel);
end;
%}

%% GLM on whole run
if config.doGLMAnalysis;
    ticStat = tic;
    for iFilt = 2 : numel(filters);
        filt = filters{iFilt};
        
        NPilTransient = nanmean(ROIStats.PS.(filt).trial.mean.evokedNorm(:, end, :), 3);
        
%         ROIStats.stats.(filt).GLM.runs = struct();
%         ROIStats.stats.(filt).GLM.runs = struct();
%         % each run
%         for iRun = 1 : nRuns;
%             [respGLM, respSEGLM, pvalGLM] = analyseRespGLM(...
%                 cell2mat(ROIStats.runs.(filt)(:, iRun)), NPilTransient, config.stim{iRun}, ...
%                 ROISet, stimIDs, nPSEvokedFrames, config.GLMThresh, ...
%                 sprintf('%s_RespGLM_run%02d_%s', config.saveName, iRun, filt), config.doSaveGLMPlot);
%             ROIStats.stats.(filt).stats.GLM.runs(iRun).respGLM = respGLM;
%             ROIStats.stats.(filt).stats.GLM.runs(iRun).respSEGLM = respSEGLM;
%             ROIStats.stats.(filt).stats.GLM.runs(iRun).pvalGLM = pvalGLM;
%         end;

        % all runs
        ROIStatsAllRuns = cell2mat(ROIStats.runs.(filt));
        stimAllRuns = cell2mat(config.stim);
        [respGLM, pvalGLM] = analyseRespGLM(...
            ROIStatsAllRuns, NPilTransient, stimAllRuns, ROISet, stimIDs, config.PSFrames, ...
            config.GLMThresh, sprintf('%s_RespGLM_allRun_%s', config.saveName, filt), ...
            config.doSaveGLMPlot);
        ROIStats.stats.(filt).GLM.all_runs.respGLM = respGLM;
%         ROIStats.stats.(filt).GLM.all_runs.respSEGLM = respSEGLM;
        ROIStats.stats.(filt).GLM.all_runs.pvalGLM = pvalGLM;
    end;
    o('        #analys..ngleDay: GLM analysis done (%3.1f sec).', toc(ticStat), 2, dbgLevel);
end;

%% ROI response to all trials & all frames
% %% Inter-ROI response correlation
% %% Inter-trial correlation VS evoked response correlation
stats2 = config.evokedRespAnalysisStats;
for iFilt = 2 : numel(filters);
    filt = filters{iFilt};
    
    if ~config.doPSAnalysis || ~isfield(ROIStats.PS.(filt), 'trial') || ~isfield(ROIStats.PS.(filt).trial, 'mean');
        continue;
    end;
    
    evokedResp = ROIStats.PS.(filt).trial.mean.evokedNorm;
    evokedErr = ROIStats.PS.(filt).trial.sem.evokedNorm;

%     %% TODO: HACK: hard-core change
%     evokedErr = ROIStats.PS.(filt).trial.std.evokedNorm;
%     warning('analyseROIStatsSingleDay:SEMTOSTDHACK', 'WARNING!! SEM IS ACTUALLY STD HERE!!!');

    for iStat = 1 : numel(stats2);
        stat = stats2{iStat};
        statUp = [upper(stat(1)), stat(2 : end)];
        respName = sprintf('%s of evoked response', statUp);
        correctStat = ~isempty(config.respStat) && (strcmp(config.respStat, stat) || strcmp(config.respStat, 'all'));
        fHandle = str2func(['nan' stat]);
        
        if ~(isfield(ROIStats.stats.(filt), stat) || exist(['nan' stat]) == 2 || strcmp(stat, 'max3pp')); continue; end; %#ok<EXIST>
        
        %% ROI response to all trials & all frames
        if strcmp(stat, 'max3pp');
            cBarLabel = [respName ' [dFF/dRR]'];
            for iROI = 1 : nROIs;
                for iStim = 1 : nStims;
                    ROIStats.stats.(filt).evokedResp.max3pp(iStim, iROI) = nanmean(maxnpp(evokedResp(:, iROI, iStim), 3));
                    ROIStats.stats.(filt).evokedResp.max3ppErr(iStim, iROI) = sem(maxnpp(evokedErr(:, iROI, iStim), 3));
                end;
            end;
        elseif strcmp(stat, 'respProb');
            ROIStats.stats.(filt).evokedResp.respProb = ROIStats.stats.(filt).respProb';
            ROIStats.stats.(filt).evokedResp.respProbErr = ROIStats.stats.(filt).respProbErr';
        elseif strfind(stat, 'tStat');
            cBarLabel = [respName ' [tStat]'];
            resp = ROIStats.stats.(filt).ttest.(stat);
            pval = ROIStats.stats.(filt).ttest.(strrep(stat, 'tStat', 'pval'));
            resp(pval > config.ttestThresh) = 0;
            ROIStats.stats.(filt).evokedResp.(stat) = resp';
        elseif strcmp(stat, 'GLM');
            cBarLabel = [respName ' [tStat]'];
            ROIStats.stats.(filt).evokedResp.GLM = ROIStats.stats.(filt).GLM.all_runs.respGLM';
%             ROIStats.stats.(filt).evokedResp.GLMErr = ROIStats.stats.(filt).GLM.all_runs.respSEGLM';
        else
            cBarLabel = [respName ' [dFF/dRR]'];
            ROIStats.stats.(filt).evokedResp.(stat) = reshape(fHandle(evokedResp), nROIs, nStims)';
            ROIStats.stats.(filt).evokedResp.([stat 'Err']) = reshape(fHandle(evokedErr), nROIs, nStims)';
        end;

        if config.doSaveEvokedRespPlot && correctStat;
            saveNameEvokedResp = sprintf('%s_%sEvokedResp_%s', config.saveName, statUp, filt);
            figEvokedResp = plotGenericROIStimHeatMap(ROIStats.stats.(filt).evokedResp.(stat)', [], ...
                [respName ' for each stim-ROI combination'], stimIDs, ROISet(:, 1), cBarLabel, ...
                saveNameEvokedResp, 'EvokedResp', min(config.doSaveEvokedRespPlot, 1), '', []);
            title({get(get(gca, 'Title'), 'String'), sprintf('Overall response (mean): %3.1f', ...
                nanmean(ROIStats.stats.(filt).evokedResp.(stat)(:)))});
            xlabel('Stimulus');
            ylabel('ROIs');
            saveFigToDir(figEvokedResp, saveNameEvokedResp, 'EvokedResp', config.doSaveEvokedRespPlot, 1, 1);
        end;
        
        
        %% get the BS and the response at BS for each ROI
%         [maxRespAtBS, maxRespBSInds] = max(ROIStats.stats.(filt).evokedResp.(stat));
%         ROIStats.stats.(filt).tuning.(stat).meanResp = nanmean(ROIStats.stats.(filt).evokedResp.(stat));
%         ROIStats.stats.(filt).tuning.(stat).maxRespAtBS = maxRespAtBS;
%         ROIStats.stats.(filt).tuning.(stat).BS = config.stimIDs(maxRespBSInds);
        

        %% Inter-ROI response correlation
        ROIStats.stats.(filt).interROIEvokedRespCorr.(stat) = corr(ROIStats.stats.(filt).evokedResp.(stat));
        
        if config.doSaveEvokedRespCorrPlot && correctStat;
            saveNameEvokedRespCorr = sprintf('%s_%sEvokedRespROICorr_%s', config.saveName, statUp, filt);
            figEvokedRespCorr = plotGenericROIStimHeatMap(ROIStats.stats.(filt).interROIEvokedRespCorr.(stat), ...
                [-1, 1], sprintf('Inter-ROI correlation of the %s accross all stims', respName), ROISet(:, 1), ...
                ROISet(:, 1), ['Correlation of the ' respName], saveNameEvokedRespCorr, 'EvokedRespROICorr', ...
                min(config.doSaveEvokedRespCorrPlot, 1), '', []);
            title({get(get(gca, 'Title'), 'String'), sprintf('Overall correlation (mean): %5.3f', ...
                nanmean(ROIStats.stats.(filt).interROIEvokedRespCorr.(stat)(:)))});
            xlabel('ROIs');
            ylabel('ROIs');
            saveFigToDir(figEvokedRespCorr, saveNameEvokedRespCorr, 'EvokedRespROICorr', ...
                config.doSaveEvokedRespPlot, 1, 1);
        end;
        
        %% Inter-trial correlation VS evoked response correlation
        if isfield(ROIStats.stats.(filt), 'interTrialMeanCorr');
            saveNameInterTrialCorrVSEvokedRespCorr = sprintf('%s_interTrialCorrVS%sEvokedRespCorr_%s_%s', ...
                config.saveName, statUp, filt);
            % group by ROIs
            ROIStats.stats.(filt).interTrialCorrVSEvokedRespCorr.(stat) = analyseInterTrialVSEvokedRespCorr( ...
                ROIStats.stats.(filt).evokedResp.(stat), ROIStats.stats.(filt).interTrialMeanCorr, statUp, ...
                ROISet, stimIDs, 'ROI', [saveNameInterTrialCorrVSEvokedRespCorr '_GroupedByROI'], ...
                'interTrialCorrVSEvokedRespCorr', config.doSaveInterTrialVSEvokedRespCorrPlot && correctStat);
            if config.doSaveInterTrialVSEvokedRespCorrPlot && ~correctStat; close(gcf); end;

            % group by stimulus
            analyseInterTrialVSEvokedRespCorr( ...
                ROIStats.stats.(filt).evokedResp.(stat), ROIStats.stats.(filt).interTrialMeanCorr, statUp, ...
                ROISet, stimIDs, 'stim', [saveNameInterTrialCorrVSEvokedRespCorr '_GroupedByStim'], ...
                'interTrialCorrVSEvokedRespCorr', config.doSaveInterTrialVSEvokedRespCorrPlot && correctStat);
            if config.doSaveInterTrialVSEvokedRespCorrPlot && ~correctStat; close(gcf); end;
        end;
    end;
end;


%% PSPlot average, stimulus or ROI averaged
if config.doSavePSAvgPlot;
    ticPlot = tic;
    iFiltStart = numel(filters);
    for iFilt = iFiltStart : numel(filters);
        filt = filters{iFilt};
        
        stimIDsAvg = stimIDs;
        % if only one stimulus type, choose the right one
        if ismatrix(ROIStats.PS.(filt).trial.mean.allNorm);
            iUniqueStim = unique(cell2mat(config.stim));
            stimIDsAvg = stimIDs(iUniqueStim(iUniqueStim ~= 0));
        end;
        
        nPSFrames = size(ROIStats.PS.(filt).raw{1, 1}, 2);
        PSFrames = config.PSFrames;
        if strcmp(filters{iFilt}, 'dsfilt'); PSFrames = config.DSPSFrames; end;
        PSTime = ((1 : nPSFrames) - PSFrames.base) / config.frameRate;
        saveNameStim = sprintf('%s_PSAvgStim_%s', config.saveName, filt);
        figStim = plotPSStimAvg(config.axeH, ROIStats.PS.(filt).trial, PSTime, 'ROI', stimIDsAvg, saveNameStim, ...
            ROIStats.PS.(filt).trial.mean.N);
%         saveNameROI = sprintf('%s_PSAvgROI_%s', config.saveName, filt);
%         figROI = plotPSStimAvg(config.axeH, ROIStats.PS.(filt).trial, PSTime, 'stim', ROISet(:, 1), saveNameROI);
           
        saveFigToDir(figStim, saveNameStim, 'PSAvg', config.doSavePSAvgPlot, 1, 1);
%         saveFigToDir(figROI, saveNameROI, 'PSAvg', config.doSavePSAvgPlot, 1, 1);
    end;
    o('        #analys..ngleDay: stim (and ROI) avg plot done (%3.1f sec).', toc(ticPlot), 2, dbgLevel);
end;

%% PSPlot with all traces
if config.doSavePSPlot;
    ticPlot = tic;
    iFiltStart = min(numel(filters), 2);
    for iFilt = iFiltStart : numel(filters);
        filt = filters{iFilt};
        
        saveNameStim = sprintf('%s_PSPlot_%s', config.saveName, filt);
        figHandsPSPlot = plotPSTrace(ROIStats.PS.(filt).raw, PSTime, ROISet, stimIDs, saveNameStim, 5, 1);
        for iFig = 1 : numel(figHandsPSPlot);
            saveFigToDir(figHandsPSPlot(iFig), sprintf('%s_%02d', saveNameStim, iFig), 'PSPlot', ...
                config.doSavePSPlot, 1, config.doSavePSPlot < 2);
        end;
        saveFigToDir(figHandsPSPlot, [saveNameStim '_group'], 'PSPlot', config.doSavePSPlot > 1, 1, 1);
    end;
    o('        #analys..ngleDay: PSPlot done (%3.1f sec).', toc(ticPlot), 2, dbgLevel);
end;

%% PSPlot of average and stimulus tick and box or avg +- sem
if config.doSavePSSingleAvg;
    ticPlot = tic;
    iFiltStart = min(numel(filters), 2);
    for iFilt = iFiltStart : numel(filters);
        filt = filters{iFilt};
        
        saveNameStim = sprintf('%s_PSAvgSinglePlot_%s', config.saveName, filt);
        figHandsRegionStimPreference = plotPSSingleAvg(ROIStats.PS.(filt).raw, PSTime, ROISet, stimIDs, saveNameStim, 5, 1, ...
            config.stimTime, [config.plotLimits(1) config.plotLimits(2)], config.doSavePSSingleshadedBars);
        for iFig = 1 : numel(figHandsRegionStimPreference);
            if config.doSavePSSingleshadedBars
            saveFigToDir(figHandsRegionStimPreference(iFig), sprintf('%s_%02d', saveNameStim, iFig), 'PSAvgSinglePlot_shaded', ...
                config.doSavePSSingleAvg, 1, config.doSavePSSingleAvg < 2);
            else
                saveFigToDir(figHandsRegionStimPreference(iFig), sprintf('%s_%02d', saveNameStim, iFig), 'PSAvgSinglePlot', ...
                config.doSavePSSingleAvg, 1, config.doSavePSSingleAvg < 2);
            end;
        end;
    end;
    o('        #analys..ngleDay: PSAvgSinglePlot done (%3.1f sec).', toc(ticPlot), 2, dbgLevel);
end;
%% Alex: Alterantive plot that should work with any type of data, should replace PSSingleAvg eventually
if config.doSavePSSingleAvgRaw;
    ticPlot = tic;
    for iFilt = 2 : numel(filters);
        filt = filters{iFilt};
        caTracesFilt = cell2mat(ROIStats.runs.(filters{2})(:, iRun));
        saveNameStim = sprintf('%s_PSAvgSinglePlotRaw_%s', config.saveName, filt);
        figHandsRegionStimPreference = plotPSSingleAvgRaw(caTracesFilt, config.stim{1,1}, config.stimIDs, ROISet, ...
            config.numOfStimPerBlock, 5, 1, config.stimTime, config.frameRate, config.plotLimits, saveNameStim);
        for iFig = 1 : numel(figHandsRegionStimPreference);
                saveFigToDir(figHandsRegionStimPreference(iFig), sprintf('%s_%02d', saveNameStim, iFig), 'PSAvgSinglePlotRaw', ...
                config.doSavePSSingleAvgRaw, 1, config.doSavePSSingleAvgRaw < 2);
        end;
    end;
    o('        #analys..ngleDay: PSAvgSinglePlot done (%3.1f sec).', toc(ticPlot), 2, dbgLevel);
end;


%% Alex: Trial adaption analysis
if config.doAnalyseTrialAdaption
    ticPlot = tic;
    for iFilt = 2:numel(filters);
        filt = filters{iFilt};
        [trialAdaptionFigHands, ROIStats.stats.(filt).trialAdaptionStats] = ...
            analyseTrialAdaption(ROIStats.PS.(filt).raw, config.saveName, config.stimIDs, config.doSaveTrialAdaptionPlots);
        saveNameStim = sprintf('%s_TrialAdaption_%s', config.saveName, filt);
        for iFig = 1 : numel(trialAdaptionFigHands);
                saveFigToDir(trialAdaptionFigHands(iFig), sprintf('%s_%02d', saveNameStim, iFig), 'TrialAdaptionAnalysis', ...
                config.doSaveTrialAdaptionPlots, 1, config.doSaveTrialAdaptionPlots < 2);
        end;
    end;
    o('        #analys..ngleDay: Trial adaption analysis and plots done (%3.1f sec).', toc(ticPlot), 2, dbgLevel);
end;

%% Trial Adaption Average plot with stimulus tick and box
if config.doSaveInterTrialAvg;
    ticPlot = tic;
    iFiltStart = min(numel(filters), 2);
    for iFilt = iFiltStart : numel(filters);
        filt = filters{iFilt};
        caTracesFilt = cell2mat(ROIStats.runs.(filters{2})(:, iRun));
        saveNameStim = sprintf('%s_TrialAdaptionAvg_%s', config.saveName, filt);
        
        figHandsInterTrialHeatmap = plotTrialAdaptionAvg(caTracesFilt, config.stim{1,1}, config.stimIDs, ROISet, 5, ...
            config.numOfStimPerBlock, config.stimDuration, config.frameRate, saveNameStim);
        for iFig = 1 : numel(figHandsInterTrialHeatmap);
            saveFigToDir(figHandsInterTrialHeatmap(iFig), sprintf('%s_%02d', saveNameStim, iFig), 'TrialAdaptionAvg', ...
                config.doSaveInterTrialAvg, 1, config.doSaveInterTrialAvg < 2);
        end;
    end;
    o('        #analys..ngleDay: Trial Adaption Plot done (%3.1f sec).', toc(ticPlot), 2, dbgLevel);
end;


%% Heatmap plot of RoiSet data for all stimuli based on caTrace data (no PS-plot!)
if config.doSaveInterTrialHeatmap
    ticPlot = tic;
    iFiltStart = min(numel(filters), 2);
    for iFilt = iFiltStart : numel(filters);
        filt = filters{iFilt};
        caTracesFilt = cell2mat(ROIStats.runs.(filters{2})(:, iRun));
        saveNameStim = sprintf('%s_TrialAdaptionHeatmap_%s', config.saveName, filt);
       figHandsInterTrialHeatmap = plotInterTrialHeatmap(caTracesFilt, config.stim{1,1}, config.stimIDs, ROISet, ...
            config.numOfStimPerBlock, config.stimDuration, config.frameRate, config.plotLimits, saveNameStim);
        for iFig = 1 : numel(figHandsInterTrialHeatmap);
            saveFigToDir(figHandsInterTrialHeatmap(iFig), sprintf('%s_%02d', saveNameStim, iFig), 'InterTrialHeatmaps', ...
                config.doSaveInterTrialHeatmap, 1, config.doSaveInterTrialHeatmap < 2);
        end;
    end;
    o('        #analys..ngleDay: Inter-trial heatmap plot done (%3.1f sec).', toc(ticPlot), 2, dbgLevel);
    
end;

%% PSPlot as heat map for each ROI with each stimulus
if config.doSavePSPlotROIHeatMap;
    ticPlot = tic;
    iFiltStart = min(numel(filters), 2);
    for iFilt = iFiltStart : numel(filters);
        filt = filters{iFilt};
        % plot heat map for each ROI and all ROIs together
        for iROI = 1 : nROIs + 1;

            % if it's the last index, do all ROIs together
            if iROI == nROIs + 1;
                saveNameROI = sprintf('%s_PSAllROIsHeatMap_%s', config.saveName, filt);
                % reshape the data to a matrix of nFrames x nStims
                ROIStatsForROI = reshape(nanmean(ROIStats.PS.(filt).trial.mean.all(:, :, :), 2), nPSFrames, nStims);
                ROIStatsForROIEvoked = reshape(nanmean(ROIStats.PS.(filt).trial.mean.evoked(:, :, :), 2), ...
                    nPSEvokedFrames, nStims);
                iROI = 0; %#ok<FXSET>
            else
                saveNameROI = sprintf('%s_PSROI%sHeatMap_%s', config.saveName, ROISet{iROI, 1}, filt);
                % select the ROIStats data for this ROI as matrix of nPSFrames x nStims
                ROIStatsForROI = reshape(ROIStats.PS.(filt).trial.mean.all(:, iROI, :), nPSFrames, nStims);
                ROIStatsForROIEvoked = reshape(ROIStats.PS.(filt).trial.mean.evoked(:, iROI, :), ...
                    nPSEvokedFrames, nStims);
            end;

            % plot the ROIStats as heat map
            figROI = plotPSStimROIHeatMapPlot(iROI, saveNameROI, ROIStatsForROI, ROIStatsForROIEvoked, PSTime, ...
                ROISet, stimIDs, config.stimLabel, [config.plotLimits(1) config.plotLimits(2)], 'ROIs', 0);

            makePrettyFigure(figROI);

            saveFigToDir(figROI, saveNameROI, 'PSROIHeatMap', config.doSavePSPlotROIHeatMap, 1, 1);
        end;
    end;
    o('  #analys..ngleDay: plotting the PSROIHeatMap done (%3.1f sec).', toc(ticPlot), 2, dbgLevel);
end;

%% PSPlot as heat map for each stimulus with each ROI
if config.doSavePSPlotStimHeatMap;
    ticPlot = tic;
    iFiltStart = min(numel(filters), 2);
    for iFilt = iFiltStart : numel(filters);
        filt = filters{iFilt};
        % plot heat map for each stim and for all stims together
        for iStim = 1 : nStims + 1;

            % if it's the last index, do all stims together
            if iStim == nStims + 1;
                saveNameStim = sprintf('%s_PSAllStimsHeatMap_%s', config.saveName, filt);
                % reshape the data to a matrix of nFrames x nROIs
                ROIStatsForStim = reshape(nanmean(ROIStats.PS.(filt).trial.mean.all(:, :, :), 3), nPSFrames, nROIs);
                ROIStatsForStimEvoked = reshape(nanmean(ROIStats.PS.(filt).trial.mean.evoked(:, :, :), 3), ...
                    nPSEvokedFrames, nROIs);
                iStim = 0; %#ok<FXSET>
            else
                saveNameStim = sprintf('%s_PSStim%dHeatMap_%s', config.saveName, iStim, filt);
                % select the ROIStats data for this stim as matrix of nFrames x nROIs
                ROIStatsForStim = reshape(ROIStats.PS.(filt).trial.mean.all(:, :, iStim), nPSFrames, nROIs);
                ROIStatsForStimEvoked = reshape(ROIStats.PS.(filt).trial.mean.evoked(:, :, iStim), ...
                    nPSEvokedFrames, nROIs);
            end;

            % plot the ROIStats as heat map
            figStim = plotPSStimROIHeatMapPlot(iStim, saveNameStim, ROIStatsForStim, ROIStatsForStimEvoked, PSTime, ...,
                ROISet, stimIDs, config.stimLabel, [config.plotLimits(1) config.plotLimits(2)], 'Stims', 0);

            makePrettyFigure(figStim);
            saveFigToDir(figStim, saveNameStim, 'PSStimHeatMap', config.doSavePSPlotStimHeatMap, 1, 1);
        end;
    end;
    
    o('  #analys..ngleDay: plotting the PSStimHeatMap done (%3.1f sec).', toc(ticPlot), 2, dbgLevel);
end;


%% PSPlot as heat map for all ROI with each stimulus
if config.doSavePSPlotAllStimHeatMap;
    ticPlot = tic;
    iFiltStart = min(numel(filters), 2);
    for iFilt = iFiltStart : numel(filters);
        filt = filters{iFilt};
        saveNameStim = sprintf('%s_PSAllStimsHeatMap_%s', config.saveName, filt);
        saveNameAllStimsAllROI = sprintf('%s_PSAllStimsAllROIsHeatMap_%s', config.saveName, filt);
        % plot the ROIStats as heat map
        figAllStimsAllROI = plotPSAllStimROIHeatMapPlot(config.axeH, saveNameAllStimsAllROI, ROIStats.PS.(filt).trial.mean.allNorm, ...
            config.PSFrames.base, ROISet, stimIDs, [config.plotLimits(1) config.plotLimits(2)], 'Stims', ...
            ROIStats.PS.(filt).trial.mean.N, config.frameRate, config.stimDur);
        saveFigToDir(figAllStimsAllROI, saveNameStim, 'PSAllStimHeatMap', config.doSavePSPlotAllStimHeatMap, 1, 1);
    end;
    
    o('  #analys..ngleDay: PSAllStimROIHeatMapPlot done (%3.1f sec).', toc(ticPlot), 2, dbgLevel);
end;

%% Best stimulus plot
if config.doSaveBSPlot || config.doSaveBSOvlPlot;
    ticPlot = tic;
    for iFilt = 2 : numel(filters);
        filt = filters{iFilt};
        plotBSPref(sprintf('%s_%s', config.saveName, filt), ROIStats.stats.(filt).evokedResp, ...
            ROISet, stimIDs, 1, config.tuningStat, config.doSaveBSOvlPlot, config.doSaveBSPlot, config.stimLabel);
    end;
    o('  #analys..ngleDay: plotting the stimulus tuning for each ROI done (%3.1f sec).', toc(ticPlot), 2, dbgLevel);
    
end;

%% Perform ANOVA test on a single ROI (3P mean per trial) or a chosen metric (population)
if config.doROIAnovaAnalysis || config.doPopulationAnovaAnalysis
    
    for iFilt = 2: numel(filters);
               
        filt = filters{iFilt};
        commonArgs = {
            ROIStats.PS.(filt).raw;              %ROIStats for ROI Anova
            ROIStats.stats.(filt).evokedResp;    %ROIStats for population Anova / tuningStruct
            config.PSFramesRespProb;             %Base and evoked frames
            config.stimIDs;                      %Stim IDs (names)
            config.saveName;                     %Folder and file save name
            config.tuningStat;                   %Statistical metric to chose for pop anova
            config.anovaEvokedMethod;            % Method to extract mean normalized evoked dRR/dFF; 3pp or evokedMean
            config.doSaveROIAnovaPlot;           %Save ROI Anova plots
            config.doSaveAnovaPopPlot;           %Save Population Anova plot
            };
        [ROIStats.stats.(filt).anovaROIStats, ROIStats.stats.(filt).anovaPopStats] = analyseAnova(commonArgs{:});
    end;
    o('        #analys..ngleDay: ANOVA analysis done (%3.1f sec).', toc(ticStat), 2, dbgLevel);
end;


%% Perform a multiple comparison test based on obtained ANOVA statistics
if config.doROIMultiCompare || config.doPopMultiCompare
    
    %Check if anova has been performed, otherwise skip
    for iFilt = 2: numel(filters);
               
        filt = filters{iFilt};
        
            % Only perform multiple comparsion if anova test has been
            % performed for the chosen set (ROI or population)
            % Replace if there is a more elegant way to test this
            if config.doROIMultiCompare
                if ~isfield(ROIStats.stats.(filt), 'anovaROIStats')
                    warning('analyseROIStatsSingleDay:MultiCompare', 'ROI Multicompare will be skipped as Anova test is missing');
                    % Set config parameter accordingly
                    config.doROIMultiCompare = 0;
                end;
            end;
            if config.doPopMultiCompare
               if ~isfield(ROIStats.stats.(filt), 'anovaROIStats')
                    warning('analyseROIStatsSingleDay:MultiCompare', 'Population Multicompare will be skipped as Anova test is missing');
                    % Set config parameter accordingly
                    config.doPopMultiCompare = 0;
               end;
            end;
            
        commonArgs = {
            ROIStats.stats.(filt).anovaROIStats;    %ROIStats for ROI Anova statistics
            ROIStats.stats.(filt).anovaPopStats     %ROIStats for Population Anova statistics
            ROIStats.stats.(filt).evokedResp;       %ROIStats for population Anova /tuningStruct
            config.multiCompareThresh               %Confidence interval threshold
            config.saveName;                        %Folder and file save name
            config.tuningStat;                      %Statistical metric to chose for pop anova
            config.doSaveMultiCompROI;              %Save ROI Multiple comparison plots
            config.doSaveMultiCompPop;              %Save Population multiple comparsion plots
            };
        [ROIStats.stats.(filt).multiCompStatsROI, ROIStats.stats.(filt).multiCompStatsPop] = multiStimComparison(commonArgs{:});
    end;
    o('        #analys..ngleDay: Multiple Comparison analysis done (%3.1f sec).', toc(ticStat), 2, dbgLevel);
end;


%% Extract significant stimulus pairs and plot them based on multiple comparison metrics
%if config.doSaveTuningPlot || config.doSavePairedTuningPlot
if config.doPopMultiCompare
    %Check if anova has been performed, otherwise skip
    for iFilt = 2: numel(filters);
        
        filt = filters{iFilt};
        
        % Only create plots if parameters are present
        if config.doPopMultiCompare
            if ~isfield(ROIStats.stats.(filt), 'multiCompStatsROI')
                warning('analyseROIStatsSingleDay:analyseStimulusTuning', ' Multiple comparison test data is missing.');
                % Set config parameter accordingly
                config.doTuningPlot = 0;
                config.doPairedTuningPlot = 0;
            end;
        end;
        
        commonArgs = {
            ROIStats.stats.(filt).multiCompStatsROI;    %ROIStats for ROI Anova statistics
            config.stimIDs;                             %Stim IDs
            config.multiCompareThresh                   %Confidence interval threshold
            config.saveName;                            %Folder and file save name
            [config.plotLimits(1) config.plotLimits(2)];            %Plot limits
            config.doSaveTuningPlot;                    %Save Tuning plots
            config.doSavePairedTuningPlot;              %Save paired plots
            };
        ROIStats.stats.(filt).multiCompTuningPairs = analyseStimulusTuning(commonArgs{:});
    end;
end;

%% Extract scatter plots of all stimulus combinations to visualise population tuning
if config.doSavePopulationScatter
    for iFilt = 2: numel(filters);
        filt = filters{iFilt};
        commonArgs = {
            config.saveName;                         %Save name
            ROIStats.stats.(filt).evokedResp;        %tuning stats
            config.stimIDs;                          %Stim IDs
            config.tuningStat;                       %Statistical metric
            config.doSavePopulationScatter;          %Save Scatter plots
            config.doScatterTick;                    %Save paired plots
            };
       plotBSScatter(commonArgs{:})
    end;
end;


%% - Alex: Save extracted tuning stats for galvo analysis
if config.doAnalyseGalvoTuning
    for iFilt = 2: numel(filters);
        filt = filters{iFilt};
        % Only perform analysis if parameters are present
        if isfield(ROIStats.stats.(filt), 'multiCompStatsROI')
            if isfield(ROIStats.stats.(filt), 'multiCompTuningPairs')
                ROIStats.stats.(filt).ROIStimPreference = galvoTuningAnalysis(ROIStats.stats.(filt).multiCompTuningPairs, ROIStats.stats.(filt).multiCompStatsROI, config.stimSortMethod);
            else
                warning('analyseROIStatsSingleDay:analyseStimulusTuning', 'No tuning stats will be saved as required data is missing!');
            end
        end
    end;
end;


%% - Alex: Overview representation of multiple stats and single ROI coding properties
if config.doSavePlotROIResponseOverview;
    % The following function needs a tuning analysis metric either custom
    % tailored for specified dataset or coding metrics as from GLM
    for iFilt = 2: numel(filters);
        filt = filters{iFilt};
        if isfield(ROIStats.stats.(filt), 'multiCompStatsROI')
            if isfield(ROIStats.stats.(filt), 'multiCompTuningPairs')
                currentFolder = pwd;
                caTracesFilt = cell2mat(ROIStats.runs.(filters{2})(:, iRun));
                commonArgs = {
                    currentFolder;
                    caTracesFilt;
                    config.stim{1,1};
                    config.numOfStimPerBlock;
                    config.stimDuration
                    config.frameRate
                    config.saveName;
                    filt;
                    config.stimSortMethod;
                    config.tuningStat;
                    config.stimIDs
                    ROIStats.stats.(filt).multiCompStatsROI;
                    ROIStats.stats.(filt).multiCompTuningPairs;
                    ROIStats.stats.(filt).ttestNPil;
                    config.showStimTuning;
                    config.doSavePlotROIResponseOverview
                    };
                
                plotROIResponseOverview(commonArgs{:});
            else
                warning('analyseROIStatsSingleDay:plotROIResponseOverivew', 'No tuning plots will be saved as required data is missing!');
            end;
        end;
    end;
end;

%% - Alex: Alternative overview representation to evaluate responsiveness vs tuning
if config.doSavePlotROIResponsiveness
    for iFilt = 2: numel(filters);
        filt = filters{iFilt};
        if isfield(ROIStats.stats.(filt), 'multiCompStatsROI')
            if isfield(ROIStats.stats.(filt), 'multiCompTuningPairs')
                currentFolder = pwd;
                
                commonArgs = {
                    currentFolder;
                    ROIStats.stats.(filt).evokedResp;
                    PSTime;
                    ROIStats.PS.(filt).raw;
                    ROISet;
                    config.saveName;
                    config.tuningStat;
                    config.stimIDs;
                    ROIStats.stats.(filt).multiCompStatsROI;
                    1;
                    config.stimTime
                    config.doSavePlotROIResponsiveness;
                    };
                
                plotROIResponse(commonArgs{:});
                
            else
                warning('analyseROIStatsSingleDay:plotROIResponseOverivew', 'No tuning plots will be saved as required data is missing!');
            end;
        end;
    end;
end;


%% - Alex: Plot a stimulus preference matrix heatmap
if config.doSaveStimulusPreferenceHeatmap
    plotStimulusPreferenceHeatmap(config.saveName, ROIStats.stats.(filt).evokedResp, config.stimIDs, config.tuningStat, config.doSaveStimulusPreferenceHeatmap);
end;

%% - Alex: Plot stimulus direction specific heatmap 
if config.doSaveWhiskerTuningHeatmap
    plotWhiskerTuningHeatmap(config.saveName, ROIStats.stats.(filt).evokedResp, ...
        config.stimIDs, config.tuningStat, config.doSaveWhiskerTuningHeatmap, [config.plotLimits(1) config.plotLimits(2)]);
end;

%% - Alex: Plot tuning ROI maps
if config.doSaveROITuningMaps   
    dimX = config.img_dims{1}(1);
    dimY = config.img_dims{1}(2);
    for iFilt = 2:numel(filters)
        filt = filters{iFilt};
        if isfield(ROIStats.stats.(filt), 'ROIStimPreference')
            plotROITuningMaps(dimX, dimY, config.refImgPath, config.stimIDs, ROISet, ...
                ROIStats.stats.(filt).ROIStimPreference, config.saveName, config.doSaveROITuningMaps);
        else
            warning('analyseROIStatsSingleDay:plotTuningMaps', 'No tuning maps will be saved as required data is missing!');
        end;
    end;
end;

%{
%% - Alex: alternative Region tuning plot for ROISets
if config.doSaveRegionStimPreference
    dimX = config.img_dims{1}(1);
    dimY = config.img_dims{1}(2);
    ticPlot = tic;
    for iFilt = 2:numel(filters)
        saveNameStim = sprintf('%s_RegionStimTuning_%s', config.saveName, filt);
        filt = filters{iFilt};
        figHandsRegionStimPreference = plotRegionStimPreference(dimX, dimY, config.refImgPath, config.stimIDs, ROISet, ...
            config.saveName,ROIStats.stats.(filt).evokedResp, config.tuningStat, config.pointSize);
        for iFig = 1 : numel(figHandsRegionStimPreference);
            saveFigToDir(figHandsRegionStimPreference(iFig), sprintf('%s_%02d', saveNameStim, iFig), 'RegionStimTuning', ...
                config.doSaveRegionStimPreference, 1, config.doSaveRegionStimPreference < 2);
        end;
        o('  #analys..ngleDay: Plotting region tuning done (%3.1f sec).', toc(ticPlot), 2, dbgLevel);
    end;
end;
%}

%% - Alex: calculation of ROI selectivity index
if config.doAnalyseRegionStimPreference
    dimX = config.img_dims{1}(1);
    dimY = config.img_dims{1}(2);
    ticPlot = tic;
    for iFilt = 2:numel(filters)
        saveNameStim = sprintf('%s_RegionStimTuning_%s', config.saveName, filt);
        filt = filters{iFilt};
        figHandsRegionStimPreference = analyseRegoinStimPreference(dimX, dimY, config.refImgPath, config.stimIDs, ROISet, ...
            config.saveName,ROIStats.stats.(filt).evokedResp, config.tuningStat, config.pointSize, config.doSaveRegionStimPreference);
        for iFig = 1 : numel(figHandsRegionStimPreference);
            saveFigToDir(figHandsRegionStimPreference(iFig), sprintf('%s_%02d', saveNameStim, iFig), 'RegionStimTuning', ...
                config.doSaveRegionStimPreference, 1, config.doSaveRegionStimPreference < 2);
        end;
        o('  #analys..ngleDay: Plotting region tuning done (%3.1f sec).', toc(ticPlot), 2, dbgLevel);
    end;
end;


%% - Alex: spont. vs evoked plots
if config.doSaveSpontVsEvoked
    ticPlot = tic;
    %Check if noise level field is active (possible sort option to
    %visualise the least noisy neurons
    if ~isfield(ROIStats.stats.sgfilt, 'noiseLevels')
        warning('analyseROIStatsSingleDay:spontVsEvoked','Aborting. Noise level analysis missing');
    else
        for iFilt = 1:numel(filters)
            saveNameStim = sprintf('%s_SpontVsEvoked_%s', config.saveName, filt);
            filt = filters{iFilt};
            caTracesFilt = cell2mat(ROIStats.runs.(filters{iFilt})(:, iRun));
            figHandsSppontVsEvoked = plotSpontVsEvoked(caTracesFilt, ROIStats.stats.sgfilt.noiseLevels,...
                ROIStats.stats.(filters{2}).evokedResp, config.tuningStat, config.stim{1,1}, config.stimIDs, config.plotLimits, saveNameStim);
            for iFig = 1 : numel(figHandsSppontVsEvoked);
                saveFigToDir(figHandsSppontVsEvoked(iFig), sprintf('%s_%02d', saveNameStim, iFig), 'SpontVsEvoked', ...
                    config.doSaveSpontVsEvoked, 1, config.doSaveSpontVsEvoked < 2);
            end;
            o('  #analys..ngleDay: Plotting spont. vs. evoked done (%3.1f sec).', toc(ticPlot), 2, dbgLevel);
        end;
    end;
end;


%% ROI maps with stats (BS, maxEvoked, tuning width)
if config.doSaveMaps;
    ticPlot = tic;
    for iFilt = 2 : numel(filters);
        filt = filters{iFilt};
        saveNameMaps = sprintf('%s_Maps_%s', config.saveName, filt);
        saveNameMapsBS = [saveNameMaps '_BS'];
        saveNameMapPeakEvoked = [saveNameMaps '_PeakEvokedResp'];
        saveNameMapMeanEvoked = [saveNameMaps '_MeanEvokedResp'];
        
        dimX = config.img_dims{1}(1);
        dimY = config.img_dims{1}(2);
        ROILocs = ROISet(1 : (nROIs - 1), 2);
        
        %tuningStruct = ROIStats.stats.(filt).tuning.(config.tuningStat);
        tuningStruct = ROIStats.stats.(filt).evokedResp.(config.tuningStat);
        
        BS = tuningStruct.BS(1 : (nROIs - 1));
        BSLims = [1 numel(stimIDs)]; % limits for colorbar
        
        maxRespAtBS = tuningStruct.maxRespAtBS(:, 1 : (nROIs - 1));
        peakRespLims = [floor(min(maxRespAtBS)) ceil(max(maxRespAtBS))];
        
        meanResp = tuningStruct.meanResp(:, 1 : (nROIs - 1));
        meanRespLims = [floor(min(meanResp)) ceil(max(meanResp))];
        
        if ischar(config.matFiles{1});
            imgMat = tiffread2_wrapper(config.matFiles{1});
            refImg = imgMat.img_data;
        else 
            refImgMat = load(config.matFiles{1});
            refImg = refImgMat.(genvarname(config.matFiles{1})).refImg;
        end;
        refImg = linScale(reshape(cell2mat(refImg), dimX, dimY, 3));

        figBS = plotROILocHeatMapPoint(BS, BSLims, refImg, dimX, dimY, ROILocs, ...
            saveNameMapsBS, 'Best stimulus', config.pointSize, 'jet');
        tightfig();
        saveFigToDir(figBS, saveNameMapsBS, 'Maps', config.doSaveMaps, 1, 1);
        
        figEvokedPeak = plotROILocHeatMapPoint(maxRespAtBS, peakRespLims, refImg, ...
            dimX, dimY, ROILocs, saveNameMapPeakEvoked, 'Peak Evoked Resp. at BS [?]', 'jet');
        tightfig();
        saveFigToDir(figEvokedPeak, saveNameMapPeakEvoked, 'Maps', config.doSaveMaps, 1, 1);
        
        figEvokedMean = plotROILocHeatMapPoint(meanResp, meanRespLims, refImg, ...
            dimX, dimY, ROILocs, saveNameMapMeanEvoked, 'Mean Evoked Resp. [?]', 'jet');
        tightfig();
        saveFigToDir(figEvokedMean, saveNameMapMeanEvoked, 'Maps', config.doSaveMaps, 1, 1);
        
    end;
    o('  #analys..ngleDay: maps done (%3.1f sec).', toc(ticPlot), 2, dbgLevel);
end;

end
