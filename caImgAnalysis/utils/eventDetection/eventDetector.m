function eventDetection = eventDetector(ROIStats, stim, eventDetectMethod, frameRate, psConfig, saveName)
    %[eventMatAllRuns, instFiringRateAllRuns, residuals, models] = testingEventDetector(ROIStats, stim, eventDetectMethod, frameRate, psConfig, saveName)
% event detection function - wrapper to different event detection algorithms
% input: structure created by GetRoiStats (*_RoiStats)
%
%
% Adapted from eventDetector coded by Balazs Laurency, 2013
% Modified by A. van der Bourg, 2014


dbgLevel = 2;

doStimEventRasterPlot = 1;
doEventDetection = 1;

%% Event detection parameters
[config, V, P] = getDefaultParameters(eventDetectMethod, frameRate); %%#ok<NASGU,ASGLU>
o('    #eventDetector: loading event detection parameters of default config!', 3, dbgLevel);

%% Event detection
% event detection on roiStats
% % last row is neuropil, remove it
% allDFFData(end, :) = [];
% init sizes of data set
nROIs = size(ROIStats, 1);
nRuns = size(ROIStats, 2);
nFrames = size(ROIStats{1, 1}, 2);

o('    #eventDetector: variables initialized.', 3, dbgLevel);
o('    #eventDetector: starting event detection ... ', 2, dbgLevel);
eventDetectStartTime = tic;

eventData = cell(size(ROIStats));
residuals = cell(size(ROIStats));
models = cell(size(ROIStats));
eventMatAllRuns = zeros(nROIs, nRuns * size(ROIStats{1, 1}, 2));
instFiringRateAllRuns = zeros(nROIs, nRuns* size(ROIStats{1, 1}, 2));
stimVectorAllRuns = zeros(1, nRuns * size(ROIStats{1, 1}, 2));
% outerDffData = ROIStats;
nRunsWithError = 0;
nTotEvents = 0;

for iRun = nRuns;
    try
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
        currentEventMat = zeros(nROIs, nFrames);
        instFiringRate = zeros(nROIs, nFrames);
        
        if doEventDetection;
             %Parallel computing for multiple ROIs
            parfor iROI = 1 : nROIs;
                o('        #eventDetector: run %d/%d - roi %d/%d ...', iRun, nRuns, iROI, nROIs, 5, dbgLevel);
                caTrace = ROIStats{iROI, iRun};
%                 caTrace = mpi_BandPassFilterTimeSeries(caTrace, 1 / frameRate, bpfilter.low, bpfilter.high); %#ok<PFBNS>
                if isempty(caTrace);
                    warning('eventDetector:caTraceEmpty', 'caTrace is empty!');
                    continue;
                elseif isnan(caTrace);
%                     warning('eventDetector:caTraceNaN', 'caTrace is NaN!');
                    eventData{iROI, iRun} = nan(1, nFrames); %#ok<PFOUS>
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
                        %if doExtractInstFiringRate
                            % smoothing kernel for converting spike trains into inst. firing rate (in Hz);
                            % sigma in units of frames (default: 1 frames)
                            
                            % Smoothed gauss kernel instantaneous firing
                            % rate extraction
                            gausskern = normpdf((1:nFrames),round(0.5*nFrames),1);
                            APdens = conv(peelRes.spiketrain', gausskern);
                            %Obtain the instantaneous firing rate from the
                            %smoothed AP-density
                            instFiringRate(iROI,:) = frameRate*APdens(round(0.5*nFrames):round(0.5*nFrames)+nFrames-1);
                        %end;
                end;
                nEventsFound = sum(currentEventMat(iROI, :));
                nTotEvents = nTotEvents + nEventsFound;
                o('        #eventDetector: run %d/%d - roi %d/%d done, %d event(s) found.', ...
                    iRun, nRuns, iROI, nROIs, nEventsFound, 4, dbgLevel);
            end ;
        end;
        eventMatAllRuns(:, startIndex : endIndex) = currentEventMat;
        instFiringRateAllRuns(:, startIndex:endIndex) = instFiringRate;
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


%% Output all variables
 eventDetection.eventMatAllRuns = eventMatAllRuns;
 eventDetection.instFiringRateAllRuns= instFiringRateAllRuns;
 eventDetection.residuals = residuals;
 eventDetection.models = models;
%varargout{1} = config;

end

%Default parameters - optimized for OGB?
function [config, V, P] = getDefaultParameters(eventDetectMethod, frameRate)
    amp = 12;
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
