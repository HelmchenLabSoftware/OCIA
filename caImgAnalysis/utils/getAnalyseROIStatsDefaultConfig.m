function config = getAnalyseROIStatsDefaultConfig()

config = struct();

config.axeH = [];
config.saveName = 'default';
config.stimLabel = 'stimulus';

%% best stimulus calculation parameters
config.doBSFit                                = 0;     % 0 = don't do fitting, 1 = do fitting
config.BSStat                                 = 'sum';

%% statistics
config.PSFramesRespProb.base                  = 7;      % number of base frames
config.PSFramesRespProb.evoked                = 9;      % number of evoked frames
config.doPSAnalysis                           = 0;      % 0 = don't do the analysis, 1 = do the analysis
config.doInterTrialCorrAnalysis               = 0;      % 0 = don't do the analysis, 1 = do the analysis
config.doWholeRunCorrAnalysis                 = 0;      % 0 = don't do the analysis, 1 = do the analysis
config.doRespProbAnalysis                     = 0;      % 0 = don't do the analysis, 1 = do the analysis
config.respProbThresh                         = 4;      % responsiveness threshold
config.doTTestAnalysis                        = 0;      % 0 = don't do the analysis, 1 = do the analysis
config.doTTestNPil                            = 0;      % 0 = don't do the analysis, 1 = do the analysis
config.ttestThresh                            = 0.05;   % alpha significance threshold
config.doGLMAnalysis                          = 0;      % 0 = don't do the analysis, 1 = do the analysis
config.GLMThresh                              = 0.0001; % alpha significance threshold
config.doROIAnovaAnalysis                     = 0;      % 0 = don't do the analysis, 1 = do the analysis
config.anovaEvokedMethod                      = '3pp';  % 3pp or evokedMean; method to extract mean resp
config.doPopulationAnovaAnalysis              = 0;      % 0 = don't do the analysis, 1 = do the analysis
config.doROIMultiCompare                      = 0;      % 0 = don't do the analysis, 1 = do the analysis
config.doPopMultiCompare                      = 0;      % 0 = don't do the analysis, 1 = do the analysis
config.multiCompareThresh                     = 0.001;  % alpha significance threshold
config.showStimTuning                         = 0;      % 0 = don't do the analysis, 1 = do the analysis    
config.doAnalyseGalvoTuning                   = 0;      % 0 = don't do the analysis, 1 = do the analysis
config.doROINPilAnalysis                      = 0;      % 0 = don't do the analysis, 1 = do the analysis
config.doCrossCorrAnalysis                    = 0;      % 0 = don't do the analysis, 1 = do the analysis
config.doAnalyseTrialAdaption                 = 0;      % 0 = don't do the analysis, 1 = do the analysis
config.doAnalyseRegionStimPreference          = 0;      % 0 = don't do the analysis, 1 = do the analysis 

% tells which statistics should be done on the peri-stimulus traces
% config.PSAnalysisStats                        = { 'mean', 'std' };
config.PSAnalysisStats                        = { 'mean', 'sem' };
config.evokedRespAnalysisStats                = { 'mean', 'max', 'median', 'sum', 'max3pp', 'respProb', ...
                                                    'tStatMax3PP', 'tStatMax', 'tStatMean', 'GLM' };

%% responses
config.respStat                               = 'all'; % response measure type for assesing responsiveness
config.tuningStat                             = 'sum'; % response measure type for assesing tuning
config.sortMethod                             = '';    % sorting of the plots

%% noise level parameters
config.noiseThreshFactor                      = 5;    % used for setting the limits of the noise level

%% plotting/saving parameters
config.doSaveROICaTracesAllRunsPlot           = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveROICaTracesPlot                  = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveROICaTracesAsGroup               = 0;     % 0 = don't save as group, 1 = save as group
config.doSaveROICaTracesHeatMapAllRunsPlot    = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveROICaTracesHeatMapPlot           = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveROICaTracesHeatMapAsGroup        = 0;     % 0 = don't save as group, 1 = save as group
config.doSaveAnalyseNoiseLvl                  = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveROINPilPlot                      = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveCrossCorrPlot                    = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveInterROICorrPlot                 = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveInterTrialCorrPlot               = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveRespProbPlot                     = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveTTestPlot                        = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveTTestNPilPlot                    = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveGLMPlot                          = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveEvokedRespPlot                   = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveEvokedRespCorrPlot               = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveInterTrialVSEvokedRespCorrPlot   = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSavePSAvgPlot                        = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveInterTrialAvg                    = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveInterTrialHeatmap                = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSavePSSingleAvg                      = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSavePSSingleshadedBars               = 0;     % 0 = don't plot, 1 = plot
config.doSavePSPlot                           = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSavePSPlotROIHeatMap                 = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSavePSPlotStimHeatMap                = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSavePSPlotAllStimHeatMap             = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveBSPlot                           = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveBSOvlPlot                        = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveBSPlotSorted                     = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSavePSPlotRuns                       = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveMaps                             = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveTuningPlot                       = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSavePairedTuningPlot                 = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveROIAnovaPlot                     = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveAnovaPopPlot                     = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveMultiCompROI                     = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveMultiCompPop                     = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSavePopulationScatter                = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doScatterTick                          = 0;     % 0 = don't plot, 1 = plot
config.doSavePlotROIResponseOverview          = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSavePlotROIResponsiveness            = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveStimulusPreferenceHeatmap        = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveWhiskerTuningHeatmap             = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveRegionStimPreference             = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveROITuningMaps                    = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSavePSSingleAvgRaw                   = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveSpontVsEvoked                    = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveSpontVsEvoked                    = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveEventDeconvPlot                  = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.spontaneousEventCorrelationAnalysis    = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save 
config.doSaveTrialAdaptionPlots               = 0;     % 0 = don't plot, 1 = plot, 2 = plot & save  


%% filter and down-sampling parameters
% masterConfig.bpfilter.low                           = 0.05;  % lower boundary in Hz for the band-pass filter
% masterConfig.bpfilter.high                          = 1.5;   % higher boundary in Hz for the band-pass filter
config.sgfilter.poly                          = 1;    % polynomial order for the Savitzky-Golay filter
config.sgfilter.win                           = 5;    % window size for the Savitzky-Golay filter
config.downSampleFactor                       = 0;    % down-sampling factor
 
%% peri-stimulus, frame-rate, stim. frequency, plot limits parameters
config.frameRate                              = 77.76; % frame rate of imaging in Hz        
% config.PSFrames.base                          = 150;   % number of base frames for peri-stim averaging
% config.PSFrames.evoked                        = 250;   % number of evoked frames for peri-stim averaging
config.PSFrames.base                          = 120;    % number of base frames for peri-stim averaging
config.PSFrames.evoked                        = 240;   % number of evoked frames for peri-stim averaging
% config.PSFrames.base                          = 20;    % number of base frames for peri-stim averaging
% config.PSFrames.evoked                        = 100;   % number of evoked frames for peri-stim averaging
                                              % auditory stimulation frequency in Hz
config.stimIDs                                = 4000 * (2 .^ (((1 : 25) - 1) * (2 ^ -3)));
config.plotLimits                             = [-0.5 12]; % ploting limits for evoked responses
config.colormap                               = 'hot'; % default colormap to use for heat maps
config.pointSize                              = 250; %point size for tuning map plots (plotROILocHeatMapPoint)

%% event detection parameters
config.eventDetect.performEventDetect         = 0;
config.eventDetect.method                     = 'peeling';

config.eventDetect.fast_oopsi.amp             = 10;
config.eventDetect.fast_oopsi.tau             = 2;
config.eventDetect.fast_oopsi.onsettau        = 0.01;
config.eventDetect.fast_oopsi.doPlot          = 0;        % should be switched off
config.eventDetect.fast_oopsi.lam             = 0.2;      % firing rate(ish)
config.eventDetect.fast_oopsi.base_frames     = 10;
config.eventDetect.fast_oopsi.oopsi_thr       = 0.3;
config.eventDetect.fast_oopsi.integral_thr    = 5;
config.eventDetect.fast_oopsi.filter          = [7 2];
config.eventDetect.fast_oopsi.minGof          = 0.5;
config.eventDetect.fast_oopsi.P.lam           = config.eventDetect.fast_oopsi.lam;
% masterConfig.eventDetect.fast_oopsi.P.gam           = (1-(1/freq_ca)) / ca_tau;
config.eventDetect.fast_oopsi.V.dt            = 1 / config.frameRate;
config.eventDetect.fast_oopsi.V.est_gam       = 1; % estimate decay time parameter (does not work)
config.eventDetect.fast_oopsi.V.est_sig       = 1; % estimate baseline noise SD
config.eventDetect.fast_oopsi.V.est_lam       = 1; % estimate firing rate
config.eventDetect.fast_oopsi.V.est_a         = 0; % estimate spatial filter
config.eventDetect.fast_oopsi.V.est_b         = 0; % estimate background fluo.
config.eventDetect.fast_oopsi.V.fast_thr      = 1;
config.eventDetect.fast_oopsi.V.fast_iter_max = 3;

config.eventDetect.peeling.amp                = 10;
config.eventDetect.peeling.tau                = 2;
config.eventDetect.peeling.onsettau           = 0.01;
config.eventDetect.peeling.rate               = config.frameRate;
config.eventDetect.peeling.optimizeSpikeTimes = 0;
config.eventDetect.peeling.schmittHi          = [1.75 0 3];
config.eventDetect.peeling.schmittLo          = [-1 -3 0];
config.eventDetect.peeling.schmittMinDur      = [0.3 0.05 3];
config.eventDetect.peeling.A1                 = config.eventDetect.peeling.amp;
config.eventDetect.peeling.tau1               = config.eventDetect.peeling.tau;
config.eventDetect.peeling.onsettau           = config.eventDetect.peeling.onsettau;
config.eventDetect.peeling.optimMethod        = 'none';
config.eventDetect.peeling.minPercentChange   = 4;
config.eventDetect.peeling.maxIter            = 20;
config.eventDetect.peeling.plotFinal          = 0;

% restrict the running to specific day(s), spot(s), stim(s) or ROI(s). Can be set to 0 to run all or
% can be set to single number: targetStims = 0; or to a list: targetROIs = [2 3 5 16];
config.targetDays = [];
config.targetSpots = [];
config.targetStims = 0;
config.targetROIs = 0;

config.doMultiDayAnalysis = 0;
config.doSaveROIPresencePlot = 0;
config.doSaveSpotRespProbPlot = 0;
config.doSaveSpotTunPlot = 0;
config.doSaveSpotDayTimeCoursePlot = 0;
config.doSaveNvsNP1Plots = 0;

end

