function varargout = eventDetector(ROIStats, stim, ROISet, eventDetectMethod, frameRate, bpfilter, psConfig, saveName)
% event detection function - wrapper to different event detection algorithms
% input: structure created by GetRoiStats (*_RoiStats)
dbgLevel = 2;
% required folders
%folderList = {'Projects/EventDetect','Projects/TwoPhotonAnalyzer'};
%addFolders2Path(folderList,1);
maxRuns = Inf; % for testing
% maxRuns = 2; % for testing
doCaTracesPlot = 1;
doPlotEvents = doCaTracesPlot && 1; %%#ok<NASGU>
doRasterPlot = 1;
doStimEventRasterPlot = 1;
% doPsStimPlot = 1;
doEventCountPlot = 0;
doEventDetection = 1;
o('    #eventDetector: method: "%s", maxRuns = %d ...', eventDetectMethod, maxRuns, 1, dbgLevel);
%% Event detection parameters
[config, V, P] = getDefaultParameters(eventDetectMethod, frameRate); %%#ok<NASGU,ASGLU>
o('    #eventDetector: event detection parameters configured.', 3, dbgLevel);
%% Event detection
% event detection on roiStats
% % last row is neuropil, remove it
% allDFFData(end, :) = [];
% init sizes of data set
nROIs = size(ROIStats, 1);
nRuns = size(ROIStats, 2);
nFrames = size(ROIStats{1, 1}, 2);
% only process requested runs
if nRuns > maxRuns;
    nRuns = maxRuns;
    ROIStats(:, maxRuns + 1 : end) = [];
end

o('    #eventDetector: variables initialized.', 3, dbgLevel);
o('    #eventDetector: starting event detection ... ', 2, dbgLevel);
eventDetectStartTime = tic;
eventData = cell(size(ROIStats));
residuals = cell(size(ROIStats));
models = cell(size(ROIStats));
eventMatAllRuns = zeros(nROIs, nRuns * size(ROIStats{1, 1}, 2));
stimVectorAllRuns = zeros(1, nRuns * size(ROIStats{1, 1}, 2));
% outerDffData = ROIStats;
nRunsWithError = 0;
nTotEvents = 0;
% nRuns = 1; o('/!\\ WARNING: overriding nRuns! nRuns is now = %d.', nRuns, 0, 0);
% for iRun = 1 : nRuns;
nRuns = 1; o('/!\\ WARNING: overriding nRuns! nRuns is now = %d.', nRuns, 0, 0);
for iRun = 7;
    try
%         ROIStats = outerDffData;
        startIndex = (iRun - 1) * nFrames + 1;
        endIndex = iRun * nFrames;
        eventDetect = config.EventDetect;
        o('      #eventDetector: run %d/%d, %d rois...', iRun, nRuns, nROIs, 4, dbgLevel);
        if size(stim{iRun}, 2) ~= endIndex - startIndex + 1;
        o('      #eventDetector: run %d/%d, %d rois: skip for bad size.', iRun, nRuns, nROIs, 1, dbgLevel);
            continue;
        end;
        stimVectorAllRuns(startIndex : endIndex) = stim{iRun};
        eventDetect.rate = frameRate;
%         eventCounts = zeros(1, nROIs);
%         residuals = zeros(1, nROIs);
        currentEventMat = zeros(nROIs, nFrames);
        
        if doEventDetection;
%             parfor iROI = 1 : nROIs;
%             for iROI = 1 : nROIs;
            for iROI = 1 : 3;
                o('        #eventDetector: run %d/%d - roi %d/%d ...', iRun, nRuns, iROI, nROIs, 5, dbgLevel);
                caTrace = ROIStats{iROI, iRun};
%                 caTrace = mpi_BandPassFilterTimeSeries(caTrace, 1 / frameRate, bpfilter.low, bpfilter.high); %#ok<PFBNS>
                if isempty(caTrace);
                    warning('eventDetector:caTraceEmpty', 'caTrace is empty!');
                    continue;
                elseif isnan(caTrace);
%                     warning('eventDetector:caTraceNaN', 'caTrace is NaN!');
                    eventData{iROI, iRun} = nan(1, nFrames);
                    continue;
                end;
                switch lower(eventDetectMethod)
                    case 'fast_oopsi'
                        oopsiOut = fast_oopsi(caTrace, V, P);
                        oopsiOut(oopsiOut < config.EventDetect.oopsi_thr) = 0; %#ok<PFBNS>
                        currentEventMat(iROI, :) = oopsiOut';
                        eventData{iROI, iRun} = oopsiOut';
                    case 'peeling'
%                         eventOut = doPeeling(eventDetect, caTrace);
                        [~, ~, peelRes] = Peeling(caTrace, frameRate);
                        residuals{iROI, iRun} = peelRes.peel;
                        models{iROI, iRun} = peelRes.model;
%                         eventCounts(iROI) = sum(peelRes.spiketrain); %%#ok<PFOUS>
%                         residualVector(iROI) = sum(abs(eventOut.data.peel)) / length(eventOut.data.peel);
                        currentEventMat(iROI, :) = peelRes.spiketrain;
                        eventData{iROI, iRun} = peelRes.spiketrain;
                end;
                nEventsFound = sum(currentEventMat(iROI, :));
                nTotEvents = nTotEvents + nEventsFound;
                o('        #eventDetector: run %d/%d - roi %d/%d done, %d event(s) found.', ...
                    iRun, nRuns, iROI, nROIs, nEventsFound, 4, dbgLevel);
            end ;
        end;
        eventMatAllRuns(:, startIndex : endIndex) = currentEventMat;
        o('      #eventDetector: run %d/%d done.', iRun, nRuns, 3, dbgLevel);
    catch err;
        nRunsWithError = nRunsWithError + 1; %#ok<NASGU>
        o('      #eventDetector: problem in run %d/%d.', iRun, nRuns, 2, dbgLevel);
        rethrow(err);
    end;
end;
eventDetectEndTime = toc(eventDetectStartTime);
% PSTraceRoi = PsPlotAnalysisCellArray(ROIStats, stim, psConfig);
o('    #eventDetector: event detection done for %d runs (%d error(s), %d total events, %.2f sec).', ...
    nRuns, nRunsWithError, nTotEvents, eventDetectEndTime, 2, dbgLevel);
if ~isempty(eventMatAllRuns) && nTotEvents > 0;
    o('    #eventDetector: extracting peri-stimulus events...', 3, dbgLevel);
    PSEventRoi = PsPlotAnalysis(eventMatAllRuns, stimVectorAllRuns, psConfig);
    config.PsPlotEventRoi = PSEventRoi;
    o('    #eventDetector: extracting peri-stimulus events done.', 2, dbgLevel);
else
    o('    #eventDetector: no events found (%d).', nTotEvents, 1, dbgLevel);
end

o('    #eventDetector: moving to plotting section ...', 3, dbgLevel);
%% Calcium DFF / DRR Plot - with events
if doCaTracesPlot; % only plot if required
    o('    #eventDetector: plotting the calcium DFF (or DRR) Plot with events...', 2, dbgLevel); %#ok<*UNRCH>
    % go through each run
%     nRuns = 1; o('/!\\ WARNING: overriding nRuns! nRuns is now = %d.', nRuns, 0, 0);
%     for iRun = 1 : nRuns;
    nRuns = 1; o('/!\\ WARNING: overriding nRuns! nRuns is now = %d.', nRuns, 0, 0);
    for iRun = 7;
        o('      #eventDetector: plotting run %d/%d ...', iRun, nRuns, 4, dbgLevel);
        fig = plotROICaTracesWithEvent(iRun, saveName, ... % run number and figure name
            cell2mat(ROIStats(:, iRun)), ...    % calcium traces as a nROI-by-nFrames matrix
            cell2mat(eventData(:, iRun)), ...   % detected events as a nROI-by-nFrames matrix
            stim{iRun}, ...                     % stimulus as a nFrames long vector
            ROISet, ...                         % name and coordinates of the rois
            frameRate, ...                      % frame rate
            bpfilter, ...                       % band-pass filter settings
            eventDetectMethod, ...              % used detection method
            doPlotEvents);                      % tells whether to plot the events or not
        
        fig = plotROICaTracesWithEvent(iRun, saveName, ... % run number and figure name
            cell2mat(residuals(:, iRun)), ...    % calcium traces as a nROI-by-nFrames matrix
            cell2mat(eventData(:, iRun)), ...   % detected events as a nROI-by-nFrames matrix
            stim{iRun}, ...                     % stimulus as a nFrames long vector
            ROISet, ...                         % name and coordinates of the rois
            frameRate, ...                      % frame rate
            [], ...                             % band-pass filter settings
            eventDetectMethod, ...              % used detection method
            doPlotEvents);                      % tells whether to plot the events or not
        
        fig = plotROICaTracesWithEvent(iRun, saveName, ... % run number and figure name
            cell2mat(models(:, iRun)), ...    % calcium traces as a nROI-by-nFrames matrix
            cell2mat(eventData(:, iRun)), ...   % detected events as a nROI-by-nFrames matrix
            stim{iRun}, ...                     % stimulus as a nFrames long vector
            ROISet, ...                         % name and coordinates of the rois
            frameRate, ...                      % frame rate
            [], ...                             % band-pass filter settings
            eventDetectMethod, ...              % used detection method
            doPlotEvents);                      % tells whether to plot the events or not
        
        o('      #eventDetector: plotting run %d/%d done, saving...', iRun, nRuns, 4, dbgLevel);
%         set(fig, 'WindowStyle', 'docked');
        if doCaTracesPlot > 1;
            if doPlotEvents;
                saveName = sprintf('%s_ROICaTracesWithEvents_run%02d_%s', saveName, iRun, ...
                    eventDetectMethod);
            else
                saveName = sprintf('%s_ROICaTracesWithoutEvents_run%02d_%s', saveName, iRun, ...
                    eventDetectMethod);
            end;
            saveas(fig, saveName);
            saveas(fig, [saveName '.png']);
            close(fig);
        end;
        o('      #eventDetector: plotting & saving run %d/%d done.', iRun, nRuns, 3, dbgLevel);
    end
    o('    #eventDetector: plotting %d run(s) done.', nRuns, 2, dbgLevel);
end;
%% Event count plot
if doEventCountPlot;
    o('    #eventDetector: plotting the event counts for ROI image...', 2, dbgLevel); %#ok<*UNRCH>
    fig = plotCountROIMap( ...
        eventCounts, ...                                % event counts for each ROI
        256, 256, ... % dimensions of the frame
        ROISet(1 : end - 1, 2));           % the positions of the ROI
    %% TODO HARD CODED IMAGE DIMS
    if doEventCountPlot > 1;
        set(fig, 'WindowStyle', 'docked');
        saveas(fig, sprintf('%s_ROIEventCount_%s', saveName, eventDetectMethod));
        saveas(fig, sprintf('%s_ROIEventCount_%s.png', saveName, eventDetectMethod));
        close(fig);
    end;
    o('    #eventDetector: plotting the event counts for ROI image done.', 3, dbgLevel); %#ok<*UNRCH>
end;
%% Population stimulus event raster plot
if doStimEventRasterPlot;
    o('    #eventDetector: plotting the peri-stimulus event raster plot ...', 2, dbgLevel); %#ok<*UNRCH>
    fig = plotStimEventRaster( ...
        'PopRasterSinglePlot',  ...             % title of the plot
        PSEventRoi, ...                     % event counts around the stimulus
        stim{1}, ...                   % stimuli for extracting their 'name'
        psConfig.base, ...       % number of frames looked before the stimulus
        psConfig.evoked, ...     % number of frames looked after the stimulus
        frameRate);                 % frame rate
%     set(fig, 'WindowStyle', 'docked');
    if doStimEventRasterPlot > 1;
        saveas(fig, sprintf('%s_EventStimRaster_%s', saveName, eventDetectMethod));
        saveas(fig, sprintf('%s_EventStimRaster_%s.png', saveName, eventDetectMethod));
        close(fig);
    end;
    o('    #eventDetector: plotting the peri-stimulus event raster plot done.', 2, dbgLevel); %#ok<*UNRCH>
end;
% %% Population stimulus plot
% if doPsStimPlot;
%     o('    #eventDetector: plotting the peri-stimulus plot ...', 2, dbgLevel); %#ok<*UNRCH>
%     fig = plotPSStimPlot( ...
%         'PopPeriStimPlot',  ...                 % title of the plot
%         PSTraceRoi, ...                         % all traces around the stimulus
%         stim{1}, ...                   % stimuli for extracting their 'name'
%         psConfig.base, ...       % number of frames looked before the stimulus
%         psConfig.evoked, ...     % number of frames looked after the stimulus
%         frameRate);                 % frame rate
%     if doPsStimPlot > 1;
% %         set(fig, 'WindowStyle', 'docked');
%         saveas(fig, sprintf('%s_PSStimAverage_%s', roiStats.saveName, eventDetectMethod));
%         saveas(fig, sprintf('%s_PSStimAverage_%s.png', roiStats.saveName, eventDetectMethod));
%         close(fig);
%     end;
%     o('    #eventDetector: plotting the peri-stimulus plot done.', 2, dbgLevel); %#ok<*UNRCH>
% end;
%% Population raster plot
if doRasterPlot;
    o('    #eventDetector: plotting the population raster plot ...', 2, dbgLevel); %#ok<*UNRCH>
    cellIDaxes = ROISet(:, 1);
    switch lower(eventDetectMethod)
        case {'peeling', 'fast_oopsi'};
            titleStr = 'PopRaster';
            [fig, ~] = PsPlot2Raster(PSEventRoi, frameRate, ...
                psConfig.base + 1, cellIDaxes(1 : length(cellIDaxes) - 1), 1, 0);
            set(fig, 'Name', titleStr, 'NumberTitle', 'off');
%             set(fig, 'WindowStyle', 'docked');
        if doRasterPlot > 1;
            saveas(fig,sprintf('%s_EventRasterByRoi_%s', saveName, eventDetectMethod));
            saveas(fig,sprintf('%s_EventRasterByRoi_%s.png', saveName, eventDetectMethod));
            close(fig);
        end;
    end
    o('    #eventDetector: plotting the population raster plot done.', 2, dbgLevel); %#ok<*UNRCH>
end;
%% end
varargout{1} = config;
end

function [config, V, P] = getDefaultParameters(eventDetectMethod, frameRate)
    amp = 10;
    tau = 2;
    onsettau = 0.01;
    switch lower(eventDetectMethod);
        case 'fast_oopsi';
            config.EventDetect.amp = amp;
            config.EventDetect.tau = tau;
            config.EventDetect.onsettau = onsettau;
            config.EventDetect.doPlot = 0; % should be switched off
            config.EventDetect.lam = 0.2; % firing rate(ish)
            config.EventDetect.base_frames = 10;
            config.EventDetect.oopsi_thr = 0.3;
            config.EventDetect.integral_thr = 5;
            config.EventDetect.filter = [7 2];
            config.EventDetect.minGof = 0.5;
            P.lam = config.EventDetect.lam;
            % P.gam = (1-(1/freq_ca)) / ca_tau;
            V.dt = 1/frameRate;
            V.est_gam = 1; % estimate decay time parameter (does not work)
            V.est_sig = 1; % estimate baseline noise SD
            V.est_lam = 1; % estimate firing rate
            V.est_a = 0; % estimate spatial filter
            V.est_b = 0; % estimate background fluo.
            V.fast_thr = 1;
            V.fast_iter_max = 3;
        case 'peeling';
            V = [];
            P = [];
            config.EventDetect.optimizeSpikeTimes = 0;
            config.EventDetect.schmittHi = [1.75 0 3];
            config.EventDetect.schmittLo = [-1 -3 0];
            config.EventDetect.schmittMinDur = [0.3 0.05 3];
            config.EventDetect.A1 = amp;
            config.EventDetect.tau1 = tau;
            config.EventDetect.onsettau = onsettau;
            config.EventDetect.optimMethod = 'none';
            config.EventDetect.minPercentChange = 0.1;
            config.EventDetect.maxIter = 20;
            config.EventDetect.plotFinal = 0;
        case 'none';
            config = [];
            V = [];
            P = [];
            warning('Nothing to do here! Exit ...')
            return;
    end;
end
