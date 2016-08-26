function varargout = eventDetector(roiStats, eventDetectMethod)
% event detection function - wrapper to different event detection algorithms
% input: structure created by GetRoiStats (*_RoiStats)
dbgLevel = 2;
% required folders
folderList = {'Projects/EventDetect','Projects/TwoPhotonAnalyzer'};
addFolders2Path(folderList,1);
maxRuns = Inf; % for testing
% maxRuns = 2; % for testing
doCaTracesPlot = 1;
doPlotEvents = doCaTracesPlot && 0; %%#ok<NASGU>
doRasterPlot = 0;
doStimEventRasterPlot = 0;
doPsStimPlot = 0;
doEventCountPlot = 0;
doEventDetection = 0;
o('    #eventDetector: method: "%s", maxRuns = %d ...', eventDetectMethod, maxRuns, 1, dbgLevel);
%% Event detection parameters
[config, V, P] = getDefaultParameters(eventDetectMethod, roiStats.frameRate{1}); %%#ok<NASGU,ASGLU>
o('    #eventDetector: event detection parameters configured.', 3, dbgLevel);
%% Event detection
% event detection on roiStats
allDFFData = roiStats.dataRoi;
% last row is neuropil, remove it
allDFFData(end, :) = [];
% init sizes of data set
nROIs = size(allDFFData, 1);
nRuns = size(allDFFData, 2);
nFrames = size(allDFFData{1, 1}, 2);
% only process requested runs
if nRuns > maxRuns;
    nRuns = maxRuns;
    allDFFData(:, maxRuns + 1 : end) = [];
end

o('    #eventDetector: variables initialized.', 3, dbgLevel);
o('    #eventDetector: starting event detection ... ', 2, dbgLevel);
eventDetectStartTime = tic;
eventData = cell(size(allDFFData));
eventMatAllRuns = zeros(nROIs, nRuns * size(allDFFData{1, 1}, 2));
StimVectorAllRuns = zeros(1, nRuns * size(allDFFData{1, 1}, 2));
outerDffData = allDFFData;
nRunsWithError = 0;
nTotEvents = 0;
% nRuns = 1; o('/!\\ WARNING: overriding nRuns! nRuns is now = %d.', nRuns, 0, 0);
for iRun = 1 : nRuns;
    try
        allDFFData = outerDffData;
        startIndex = (iRun - 1) * nFrames + 1;
        endIndex = iRun * nFrames;
        eventDetect = config.EventDetect;
        o('      #eventDetector: run %d/%d, %d rois...', iRun, nRuns, nROIs, 4, dbgLevel);
        if size(roiStats.stim{iRun}, 2) ~= startIndex - endIndex + 1;
        o('      #eventDetector: run %d/%d, %d rois: skip for bad size.', iRun, nRuns, nROIs, 1, dbgLevel);
            continue;
        end;
        StimVectorAllRuns(startIndex : endIndex) = roiStats.stim{iRun};
        eventDetect.rate = roiStats.frameRate{iRun};
        eventCounts = zeros(1, nROIs);
%         residualVector = zeros(1,nROIs);
        currentEventMat = zeros(nROIs, nFrames);
        
        if doEventDetection;
            parfor iRoi = 1 : nROIs;
                o('        #eventDetector: run %d/%d - roi %d/%d ...', iRun, nRuns, iRoi, nROIs, 5, dbgLevel);
                dff = allDFFData{iRoi, iRun};
                if isempty(dff);
                    warning('eventDetector:dffEmpty', 'dff is empty!');
                    continue;
                end;
                switch lower(eventDetectMethod)
                    case 'fast_oopsi'
                        oopsiOut = fast_oopsi(dff, V, P);
                        oopsiOut(oopsiOut < config.EventDetect.oopsi_thr) = 0; %#ok<PFBNS>
                        currentEventMat(iRoi, :) = oopsiOut';
                        eventData{iRoi, iRun} = oopsiOut';
                    case 'peeling'
                        eventOut = doPeeling(eventDetect,dff);
    %                     residual{iRoi,iRun} = eventOut.data.peel;
    %                     model{iRoi,iRun} = eventOut.data.model;
                        eventCounts(iRoi) = sum(eventOut.data.spiketrain); %%#ok<PFOUS>
    %                     residualVector(iRoi) = sum(abs(eventOut.data.peel)) / length(eventOut.data.peel);
                        currentEventMat(iRoi, :) = eventOut.data.spiketrain;
                        eventData{iRoi, iRun} = eventOut.data.spiketrain;
                end;
                nEventsFound = sum(currentEventMat(iRoi, :));
                nTotEvents = nTotEvents + nEventsFound;
                o('        #eventDetector: run %d/%d - roi %d/%d done, %d event(s) found.', ...
                    iRun, nRuns, iRoi, nROIs, nEventsFound, 4, dbgLevel);
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
PSTraceRoi = PsPlotAnalysis(cell2mat(allDFFData(:, :)), StimVectorAllRuns, roiStats.psConfig);
o('    #eventDetector: event detection done for %d runs (%d error(s), %d total events, %.2f sec).', ...
    nRuns, nRunsWithError, nTotEvents, eventDetectEndTime, 2, dbgLevel);
if ~isempty(eventMatAllRuns) && nTotEvents > 0;
    o('    #eventDetector: extracting peri-stimulus events...', 3, dbgLevel);
    PSEventRoi = PsPlotAnalysis(eventMatAllRuns, StimVectorAllRuns, roiStats.psConfig);
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
    for iRun = 1 : nRuns;
        o('      #eventDetector: plotting run %d/%d ...', iRun, nRuns, 4, dbgLevel);
        fig = plotROICaTraces(iRun, roiStats.saveName, ... % run number and figure name
            cell2mat(allDFFData(:, iRun)), ...  % calcium traces as a nROI-by-nFrames matrix
            cell2mat(eventData(:, iRun)), ...   % detected events as a nROI-by-nFrames matrix
            roiStats.stim{iRun}, ...            % stimulus as a nFrames long vector
            roiStats.ROISet, ...                % name and coordinates of the rois
            roiStats.frameRate{1}, ...          % frame rate
            eventDetectMethod, ...              % used detection method
            doPlotEvents);                      % tells whether to plot the events or not
        o('      #eventDetector: plotting run %d/%d done, saving...', iRun, nRuns, 4, dbgLevel);
        set(fig, 'WindowStyle', 'docked');
        if doPlotEvents;
            saveName = sprintf('%s_ROICaTracesWithEvents_run%02d_%s', roiStats.saveName, iRun, ...
                eventDetectMethod);
        else
            saveName = sprintf('%s_ROICaTracesWithoutEvents_run%02d_%s', roiStats.saveName, iRun, ...
                eventDetectMethod);
        end;
        saveas(fig, saveName);
        saveas(fig, [saveName '.png']);
        close(fig);
        o('      #eventDetector: plotting & saving run %d/%d done.', iRun, nRuns, 3, dbgLevel);
    end
    o('    #eventDetector: plotting %d run(s) done.', nRuns, 2, dbgLevel);
end;
%% Event count plot
if doEventCountPlot;
    o('    #eventDetector: plotting the event counts for ROI image...', 2, dbgLevel); %#ok<*UNRCH>
    fig = plotCountROIMap( ...
        eventCounts, ...                                % event counts for each ROI
        roiStats.img_dims(1), roiStats.img_dims(2), ... % dimensions of the frame
        roiStats.ROISet(1 : end - 1, 2));           % the positions of the ROI
    
    set(fig, 'WindowStyle', 'docked');
    saveas(fig, sprintf('%s_ROIEventCount_%s', roiStats.saveName, eventDetectMethod));
    saveas(fig, sprintf('%s_ROIEventCount_%s.png', roiStats.saveName, eventDetectMethod));
    close(fig);
    o('    #eventDetector: plotting the event counts for ROI image done.', 3, dbgLevel); %#ok<*UNRCH>
end;
%% Population stimulus event raster plot
if doStimEventRasterPlot;
    o('    #eventDetector: plotting the peri-stimulus event raster plot ...', 2, dbgLevel); %#ok<*UNRCH>
    fig = plotStimEventRaster( ...
        'PopRasterSinglePlot',  ...             % title of the plot
        PSEventRoi, ...                     % event counts around the stimulus
        roiStats.stim{1}, ...                   % stimuli for extracting their 'name'
        roiStats.psConfig.baseFrames, ...       % number of frames looked before the stimulus
        roiStats.psConfig.evokedFrames, ...     % number of frames looked after the stimulus
        roiStats.frameRate{1});                 % frame rate
    set(fig, 'WindowStyle', 'docked');
    saveas(fig, sprintf('%s_EventStimRaster_%s', roiStats.saveName, eventDetectMethod));
    saveas(fig, sprintf('%s_EventStimRaster_%s.png', roiStats.saveName, eventDetectMethod));
    close(fig);
    o('    #eventDetector: plotting the peri-stimulus event raster plot done.', 2, dbgLevel); %#ok<*UNRCH>
end;
%% Population stimulus plot
if doPsStimPlot;
    o('    #eventDetector: plotting the peri-stimulus plot ...', 2, dbgLevel); %#ok<*UNRCH>
    fig = plotPSStimPlot( ...
        'PopPeriStimPlot',  ...                 % title of the plot
        PSTraceRoi, ...                         % all traces around the stimulus
        roiStats.stim{1}, ...                   % stimuli for extracting their 'name'
        roiStats.psConfig.baseFrames, ...       % number of frames looked before the stimulus
        roiStats.psConfig.evokedFrames, ...     % number of frames looked after the stimulus
        roiStats.frameRate{1});                 % frame rate
    set(fig, 'WindowStyle', 'docked');
    saveas(fig, sprintf('%s_PSStimAverage_%s', roiStats.saveName, eventDetectMethod));
    saveas(fig, sprintf('%s_PSStimAverage_%s.png', roiStats.saveName, eventDetectMethod));
    close(fig);
    o('    #eventDetector: plotting the peri-stimulus plot done.', 2, dbgLevel); %#ok<*UNRCH>
end;
%% Population raster plot
if doRasterPlot;
    o('    #eventDetector: plotting the population raster plot ...', 2, dbgLevel); %#ok<*UNRCH>
    roiSet = roiStats.ROISet;
    cellIDaxes = roiSet(:, 1);
    switch lower(eventDetectMethod)
        case {'peeling', 'fast_oopsi'};
            titleStr = 'PopRaster';
            [fig, ~] = PsPlot2Raster(PSEventRoi, roiStats.frameRate{1}, ...
                roiStats.psConfig.baseFrames + 1, cellIDaxes(1 : length(cellIDaxes) - 1), 1, 0);
            set(fig, 'Name', titleStr, 'NumberTitle', 'off');
            set(fig, 'WindowStyle', 'docked');
            saveas(fig,sprintf('%s_EventRasterByRoi_%s', roiStats.saveName, eventDetectMethod));
            saveas(fig,sprintf('%s_EventRasterByRoi_%s.png', roiStats.saveName, eventDetectMethod));
            close(fig);
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
