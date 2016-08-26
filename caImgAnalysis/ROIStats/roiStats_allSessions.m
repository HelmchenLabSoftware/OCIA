function out = roiStatsAllDataForMouse(animalID)
% run roiStatsScript for all sessions

global dbgLevel;
dbgLevel = 4;

%% Get days with spots
year = '2013'; % leave this as a string, not a number
rawDataRootPath = 'W:\Neurophysiology\RawData\Balazs_Laurenczy\';
analysisRootPath = ['W:\Neurophysiology\Projects\Auditory\Analysis\AuditoryLearning\' animalID '\'];

o('#convertRawData_script_allDayForMouse(): animalID = %s.', animalID, 1, dbgLevel);
o('#convert...ForMouse(): rawDataRootPath = "%s".', rawDataRootPath, 3, dbgLevel);
o('#convert...ForMouse(): analysisRootPath = "%s".', analysisRootPath, 3, dbgLevel);

% get all days with at least 1 "spot**" folder inside for this mouse
daysWithSpot = getDaysWithSpot(year, rawDataRootPath, animalID);
o('#convert...ForMouse(): Found %d day(s) with spot for animal %s.', numel(daysWithSpot), 2, dbgLevel);

% sessionSpotList = { ...
%     '2013_05_08', {'spot01'}; ...
%     };

o('#roiStats_allSessions(): %d day(s) to process...', size(daysWithSpot, 1), 1, dbgLevel);

doAddRois = 0; % only necessary once
sendMail = 0; % requires sendGmail and setup

% configuration parameters (these are handed to roiStatsScript)
%% parameters
config.channelVector = 2;
config.statsType = 'dff';
config.doOgbSRsegmentation = 0;
% config.EventDetect.method = 'None';
% config.doGLMstats = 0;
% more segmentation options
config.segOptions.filt_range = [3 3];
config.segOptions.filt_order = prod(config.segOptions.filt_range);
config.segOptions.erode = 0;
config.reg.regChannel = 1; % which channel to perform registration on
config.reg.doRegistration = 1;
% frames for ps-averaging / in frames!!!
config.psConfig.baseFrames = 5;
config.psConfig.evokedFrames = 10;

startDir = pwd;

if sendMail;
    pw = passwordEntryDialog('CheckPasswordLength',false); %#ok<UNRCH>
end;

out = cell(1, size(daysWithSpot, 1));
for currentDir = 1:size(daysWithSpot, 1);
    
    day = daysWithSpot(iDay);
    notebookFileName = day.notebookFileName;
    % list of spots with short name in notebook file
    spotList = day.spotList;
    currentDate = day.date;
    
    o('  #roiStats_allSessions(): processing %d/%d: "%s"...', currentDir, size(daysWithSpot,1), ...
        daysWithSpot(1).day, 2, dbgLevel);
    try
        cd(sessionSpotList{currentDir,1});
        out{currentDir} = roiStatsScript(sessionSpotList{currentDir,2},...
            doAddRois,config);
        cd(startDir);
        close all;
        subj = sprintf('Completed roiStats for %s',sessionSpotList{currentDir,1}); %#ok<NASGU>
        body = sprintf('Completed roiStats for %s at %s',...
            sessionSpotList{currentDir,1},datestr(clock,31));
        if sendMail;
            sendGmail('hluetck@gmail.com',subj,body,pw); %#ok<UNRCH>
        end;
        fprintf('\n%s\n',body);
    catch e;
        subj = sprintf('Error during roiStats for %s',sessionSpotList{currentDir,1}); %#ok<NASGU>
        body = sprintf('Error during roiStats for %s occured at %s',...
            sessionSpotList{currentDir,1},datestr(clock,31));
        if sendMail;
            sendGmail('hluetck@gmail.com',subj,body,pw); %#ok<UNRCH>
        end;
        fprintf('\n%s\n',body);
        cd(startDir);
        rethrow(e);
    end;
end;

end
