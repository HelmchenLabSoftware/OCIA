function this = OCIA_trialview_processBehaviorData(this)
% OCIA_trialview_processBehaviorData - Extracts information about the behavior
%
%       OCIA_trialview_processBehaviorData(this, pad)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% '*.avi' movie
% get files matching the pattern
behavMovieFiles = dir([ this.tv.params.behavDataPath, '*.avi' ]);
% check number of files found
if numel(behavMovieFiles) <= 0;
    showWarning(this, sprintf('OCIA:%s:BehavMovieNotFound', mfilename()), 'Could not find a behavior movie ("*.avi").');
    return;
    
elseif numel(behavMovieFiles) > 1;
    showWarning(this, sprintf('OCIA:%s:MoreThanOneBehavMovieFile', mfilename()), ...
        sprintf('Found %d behavior movies ("*.avi"), selecting first one ("%s").', ...
        numel(behavMovieFiles), behavMovieFiles(1).name));
    behavMovieFiles = behavMovieFiles(1);
    
end;

% display row name in GUI
showMessage(this, sprintf('TrialView: loading "%s" ...', behavMovieFiles.name), 'yellow');
set(this.GUI.handles.tv.behav.panel, 'Title', sprintf('Behavior - "%s"', behavMovieFiles.name));

% store path
this.tv.params.behavMoviePath = [this.tv.params.behavDataPath, behavMovieFiles.name];
% create a video reader and store it in the video reader handles
this.tv.VRHBehav = VideoReader(this.tv.params.behavMoviePath);
% % update frame rate in model and in view
% this.tv.params.behavFrameRate = this.tv.VRHBehav.FrameRate;
% if isfield(this.GUI.handles.tv.paramPan, 'behavFrameRate');
%     set(this.GUI.handles.tv.paramPan, 'String', sprintf('%.1f', this.tv.params.behavFrameRate));
% end;
% extract size of the behavior movie
this.tv.params.behavMovieSize = [this.tv.VRHBehav.Width, this.tv.VRHBehav.Height, ...
    round(this.tv.VRHBehav.Duration * this.tv.params.behavFrameRate)];
% read first frame and display it
firstFrame = nanmean(this.tv.VRHBehav.readFrame(), 3);
set(this.GUI.handles.tv.behav.img, 'CData', firstFrame);
set(this.GUI.handles.tv.behav.axe, 'XLim', [0.5, this.tv.VRHBehav.Width - 0.5], 'YLim', [0.5, this.tv.VRHBehav.Height - 0.5]);
% change colormap to gray
colormap(this.GUI.handles.tv.behav.axe, 'gray'); figH = gcf; if figH ~= this.GUI.figH; close(figH); end;

%% 'Behavior_*.mat' behavior file 
% get files matching the pattern
behavMatFiles = dir([ this.tv.params.behavDataPath, 'Behavior_*.mat' ]);
% check number of files found
if numel(behavMatFiles) > 0;
    if numel(behavMatFiles) > 1;
        showWarning(this, sprintf('OCIA:%s:MoreThanOneBehavMatFile', mfilename()), ...
            sprintf('Found %d behavior mat files ("Behavior_*.mat"), selecting first one ("%s").', ...
            numel(behavMatFiles), behavMatFiles(1).name));
        behavMatFiles = behavMatFiles(1);

    end;
    showMessage(this, sprintf('TrialView: processing "%s" ...', behavMatFiles.name), 'yellow');

    % store path
    this.tv.params.behavFilePath = [this.tv.params.behavDataPath, behavMatFiles.name];

    % load file and extract trial start times
    behavMat = load(this.tv.params.behavFilePath);
    startTimes = behavMat.out.times.start;
    startTimes(isnan(startTimes)) = 0;
    startTimeStamps = datestr(unix2dn(startTimes * 1000), 'yyyymmdd_HHMMSS.FFF');
    startUNIXTrial1 = dn2unix(datenum(startTimeStamps(1, 10 : 18), 'HHMMSS.FFF'));
    startsUNIXMilliSec = dn2unix(datenum(startTimeStamps(:, 10 : 18), 'HHMMSS.FFF')) - startUNIXTrial1;
    zeroTimeUNIXMilliSec = startsUNIXMilliSec + (behavMat.out.times.sound' - this.tv.params.WFTimeOffset) * 1000;
    this.tv.trialZeroTimes = round(zeroTimeUNIXMilliSec) / 1000;
    this.tv.trialStartTimes = round(startsUNIXMilliSec) / 1000 + this.tv.params.behavTimeOffset;

    % store behavior data
    this.tv.data.behav = behavMat.out;
   
% no behavior mat file found 
else    
    showWarning(this, sprintf('OCIA:%s:BehavMatFileNotFound', mfilename()), 'Could not find a behavior mat file ("Behavior_*.mat").');
    
end;

%% 'YYYYMMDDS.mat' behavior file 
% get files matching the pattern
behavMatFiles = dir([ this.tv.params.behavDataPath, '*.mat' ]);
behavMatFiles(arrayfun(@(i) isempty(regexp(behavMatFiles(i).name, '\d{8}\w.mat$', 'once')), 1 : numel(behavMatFiles))) = [];
% check number of files found
if numel(behavMatFiles) > 0;    
    if numel(behavMatFiles) > 1;
        showWarning(this, sprintf('OCIA:%s:MoreThanOneBehavMatFile', mfilename()), ...
            sprintf('Found %d behavior mat files ("YYYYMMDDS.mat"), selecting first one ("%s").', ...
            numel(behavMatFiles), behavMatFiles(1).name));
        behavMatFiles = behavMatFiles(1);

    end;
    showMessage(this, sprintf('TrialView: processing "%s" ...', behavMatFiles.name), 'yellow');

    % store path
    this.tv.params.behavFilePath = [this.tv.params.behavDataPath, behavMatFiles.name];

    % load file and extract trial start times
    behavMat = load(this.tv.params.behavFilePath);
    nTrials = numel(behavMat.trials);
    startTimeStamps = arrayfun(@(i) behavMat.trials(i).time_stamp, 1 : nTrials, 'UniformOutput', false)';
    startUNIXTrial1 = dn2unix(datenum(startTimeStamps(1, :), 'HH:MM:SS.FFF'));
    startsUNIXMilliSec = arrayfun(@(i) dn2unix(datenum(startTimeStamps(i, :), 'HH:MM:SS.FFF')), 1 : nTrials)' - startUNIXTrial1;
    zeroTimeUNIXMilliSec = startsUNIXMilliSec + this.tv.params.WFTimeOffset * 1000;
    this.tv.trialZeroTimes = round(zeroTimeUNIXMilliSec) / 1000;
    
    % store behavior data
    this.tv.data.behav = behavMat.trials;
   
% no behavior mat file found 
else    
    showWarning(this, sprintf('OCIA:%s:BehavMatFileNotFound', mfilename()), ...
        'Could not find a behavior mat file ("YYYYMMDDS.mat").');
    
end;

%% 'lick_traces.mat' lick data file 
% get files matching the pattern
lickFiles = dir([ this.tv.params.behavDataPath, 'lick_traces.mat' ]);
% check number of files found
if numel(lickFiles) > 0;    
    if numel(lickFiles) > 1;
        showWarning(this, sprintf('OCIA:%s:MoreThanOneLickFile', mfilename()), ...
            sprintf('Found %d lick trace files ("lick_traces.mat"), selecting first one ("%s").', ...
            numel(lickFiles), lickFiles(1).name));
        lickFiles = lickFiles(1);

    end;
    showMessage(this, sprintf('TrialView: processing "%s" ...', lickFiles.name), 'yellow');
    % store path
    this.tv.params.lickFilePath = [this.tv.params.behavDataPath, lickFiles.name];
    % load file
    lickMat = load(this.tv.params.lickFilePath);
    % store lick data
    this.tv.data.lick = lickMat;
   
% no lick trace file found 
else    
    showWarning(this, sprintf('OCIA:%s:LickFileNotFound', mfilename()), ...
        'Could not find a lick trace file ("lick_traces.mat").');
    
end;

%% 'whisker_enevelope.mat/whiskAngle.mat' whisk data file 
% get files matching the pattern
whiskFilesEnv = dir([ this.tv.params.behavDataPath, '*.mat' ]);
whiskFilesEnv(arrayfun(@(i) isempty(regexp(whiskFilesEnv(i).name, 'whisker_envelope.mat$', 'once')), ...
    1 : numel(whiskFilesEnv))) = [];
whiskFilesAngle = dir([ this.tv.params.behavDataPath, '*.mat' ]);
whiskFilesAngle(arrayfun(@(i) isempty(regexp(whiskFilesAngle(i).name, 'whiskAngle.mat$', 'once')), ...
    1 : numel(whiskFilesAngle))) = [];
whiskFiles = [whiskFilesEnv, whiskFilesAngle]; 
% check number of files found
if numel(whiskFiles) > 0;
    whiskFiles = whiskFiles(1); % take only first file
    showMessage(this, sprintf('TrialView: processing "%s" ...', whiskFiles.name), 'yellow');
    % store path
    this.tv.params.whiskFilePath = [this.tv.params.behavDataPath, whiskFiles.name];
    % load file
    whiskMat = load(this.tv.params.whiskFilePath);
    % store whisk data
    this.tv.data.whisk = whiskMat;
   
% no whisk trace file found 
else    
    showWarning(this, sprintf('OCIA:%s:WhiskFileNotFound', mfilename()), ...
        'Could not find a whisk trace file ("whisker_envelope.mat/whiskAngle.mat").');
    
end;

end
