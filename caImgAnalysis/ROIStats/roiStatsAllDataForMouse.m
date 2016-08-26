function out = roiStatsAllDataForMouse(animalID, targetDays, targetSpots, targetRuns)
% run roiStatsScript for all day for an animal

dbgLevel = 1;
roiStatsAllTic = tic; % for performance timing purposes

%% Get days with spots
year = '2013'; % leave this as a string, not a number
analysisRootPaths = struct( ...
    ...'HIFOWSH350x2D01', 'W:\Neurophysiology\RawData\Balazs_Laurenczy\', ...
    'HIFOWSH350x2D01',  'D:\Balazs\Analysis\', ...
    'HIFOWSH640x2D03',  'C:\Users\laurenczy.HIFO\Documents\LocalData\Analysis\', ...
    'OoPC',             'D:\Users\BaL\PhD\AuditoryLearningAnalysis\');
MIRTPaths = struct( ...
    'HIFOWSH350x2D01',  'P:\matlab\dynamicPath\MIRT\', ...
    'HIFOWSH640x2D03',  'P:\matlab\dynamicPath\MIRT\', ...
    'OoPC',             'D:\Users\BaL\PhD\MATLAB\matlab\dynamicPath\MIRT\');

[~, computerName] = system('hostname');
analysisRootPath = analysisRootPaths.(genvarname(computerName));

analysisPathExtended = [analysisRootPath year '\' animalID '\'];

o('#roiStatsAllDataForMouse(): animalID = "%s".', animalID, 1, dbgLevel);
o('#roiStat...ForMouse(): analysisRootPath = "%s".', analysisRootPath, 3, dbgLevel);
o('#roiStat...ForMouse(): analysisPathExtended = "%s".', analysisPathExtended, 3, dbgLevel);

% get all days with at least 1 "spot**" folder inside for this mouse
daysWithSpot = getDaysWithSpot(year, analysisRootPath, animalID, 1);
o('#roiStat...ForMouse(): Found %d day(s) with spot for animal %s.', numel(daysWithSpot), animalID, ...
    2, dbgLevel);

o('#roiStat...ForMouse(): %d day(s) to process...', numel(daysWithSpot), 1, dbgLevel);

doAddRois = 1; % only necessary once
sendMail = 0; % requires sendGmail and setup

% configuration parameters (these are handed to roiStatsScript)
%% parameters
% config.statsType = 'dff';
% config.channelVector = 2;
config.statsType = 'drr';
config.channelVector = [2 3];
config.doOgbSRsegmentation = 0;
% config.EventDetect.method = 'None';
% config.doGLMstats = 0;
% more segmentation options
config.segOptions.filt_range = [3 3];
config.segOptions.filt_order = prod(config.segOptions.filt_range);
config.segOptions.erode = 0;
config.f0.method = 'polyFit';
config.f0.params = 2;
config.HiPass.method = 'polyFit';
config.HiPass.polyOrder = 2;

% config.reg.regChannel = 1; % which channel to perform registration on
% if more than one channel is specified, registration is done on difference of the channels
config.reg.regChannel = 2;
config.reg.multiRegChannelForbidNegatives = 1;
config.reg.doRegistration = 1;

% these are default settings of the most important MIRT parameters
% they may or may not give good results with a particular image
 % Main settings
% config.reg.main.similarity='ssd';  % similarity measure, e.g. SSD, CC, SAD, RC, CD2, MS, MI 
config.reg.main.similarity = 'CC';   % similarity measure, e.g. SSD, CC, SAD, RC, CD2, MS, MI 
config.reg.main.subdivide = 3;       % use 3 hierarchical levels
config.reg.main.okno = 5;            % mesh window size
config.reg.main.lambda = 0.005;      % transformation regularization weight, 0 for none
config.reg.main.single = 1;          % show mesh transformation at every iteration

% Optimization settings
config.reg.optim.maxsteps = 200;   % maximum number of iterations at each hierarchical level
config.reg.optim.fundif = 1e-5;    % tolerance (stopping criterion)
config.reg.optim.gamma = 1;        % initial optimization step size 
config.reg.optim.anneal = 0.8;     % annealing rate on the optimization step  

config.reg.balazsMIRTPath = MIRTPaths.(genvarname(computerName));

config.reg.doSaveRegOverlayPlot     = 2;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.reg.doSaveRefImagePlot       = 2;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.reg.doSaveRegImagePlot       = 2;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.reg.doSaveRegProgressPlot    = 2;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.reg.doSaveRegComparisonPlot  = 2;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveROIRGBPlot             = 2;     % 0 = don't plot, 1 = plot, 2 = plot & save
config.doSaveF0AndExtractPlot       = 2;     % 0 = don't plot, 1 = plot, 2 = plot & save

% restrict the running to specific day(s), spot(s), run(s). Can be set to 0 to run all or
% can be set to single number: targetDays = 2; or to a list: targetSpots = [2 3 5];
% config.targetDays = 2;
% config.targetSpots = 1;
config.targetDays = targetDays;
config.targetSpots = targetSpots;
config.targetRuns = targetRuns;

% % override fields from the inputConfig structure
% fieldsToOverride = {'targetDays', 'targetSpots', 'targetRuns'};
% for iField = 1 : numel(fieldsToOverride);
%     if exist('inputConfig', 'var') && isfield(inputConfig, fieldsToOverride{iField});
%         config.(fieldsToOverride{iField}) = inputConfig.(fieldsToOverride{iField});
%     end;
% end;

startDir = pwd;

if sendMail;
    pw = passwordEntryDialog('CheckPasswordLength',false); %#ok<UNRCH>
end;

%% Process each day with spots
out = cell(1, numel(daysWithSpot));
for iDay = 1 : numel(daysWithSpot);
    dayTic = tic; % for performance timing purposes
    
    % only target day(s)
    if any(config.targetDays) && ~any(config.targetDays == iDay); continue; end;
    
    day = daysWithSpot(iDay);
    % list of spots with short name in notebook file
    spotList = day.spotList(:, 1);
    currentDate = day.date;
    
    o('  #roiStat...ForMouse(): processing day %d/%d: "%s", %d spot(s)...', iDay, numel(daysWithSpot), ...
        currentDate, numel(spotList), 2, dbgLevel);
    
    % perform analysis in different directory than the raw data directory
    analysisPath = [analysisPathExtended currentDate];
    
    try
        cd(analysisPath);
        out{iDay} = roiStatsSingleDay(spotList, doAddRois, config);
        if ~iscell(out{iDay}) && out{iDay} == -1; error('roiStatsAllDataForMouse:aborted', 'Aborted'); end;
        cd(startDir);
        close all;
        body = sprintf('Completed roiStatsSingleDay for %s at %s (%.2f seconds).', ...
            currentDate, datestr(clock, 31), toc(dayTic));
        if sendMail;
            subj = sprintf('Completed roiStats for %s', currentDate); %#ok<UNRCH>
            sendGmail('hluetck@gmail.com',subj,body,pw);
        end;
        o('  #roiStat...ForMouse(): %s', body, 1, dbgLevel);
    catch e;
        body = sprintf('Error during roiStatsSingleDay for %s occured at %s (%.2f seconds).', ...
            currentDate, datestr(clock, 31), toc(dayTic));
        if sendMail;
            subj = sprintf('Error during roiStats for %s', currentDate); %#ok<UNRCH>
            sendGmail('hluetck@gmail.com',subj,body,pw);
        end;
        o('#roiStat...ForMouse(): %s', body, 1, dbgLevel);
        cd(startDir);
        rethrow(e);
    end;
    
end;
    
o('#roiStat...ForMouse(): done (%.2f seconds).', toc(roiStatsAllTic), 1, dbgLevel);

end
