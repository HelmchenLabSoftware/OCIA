function BEInitExp(this)
% BEInitExp - [no description]
%
%       BEInitExp(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if ~this.be.configLoaded;
    showWarning(this, 'OCIA:Behavior:InitExp:configNotLoaded', ...
        'Cannot initialize experiment because config is not loaded.');
    return;
end;
if isempty(this.be.animalID);
    showWarning(this, 'OCIA:Behavior:InitExp:NoMouseId', ...
        'Cannot initialize experiment because there is no animalID.');
    return;
end;
o('  #BEInitExp: initializing experiment ... ', 2, this.verb);

%% - #BEInitExp - initializing settings
nTrials = this.be.config.training.nTrials;
% create time storing structure
this.be.times = struct();
timeFieldNames = { ...
    'init', 'ETLTrigStart', 'ETLTrigEnd', 'vidStartTCPTrig', 'soundLoadStart', 'soundLoadEnd', 'startDelay', ...
    'clearTime', 'start', 'imgStart', 'trialStartCue', 'sound', 'respWaitStart', 'respMin', 'respMax', 'lightOut', ...
    'lightIn', 'respWaitRealStart', 'lightCueOn', 'lightCueOff', 'soundDur', 'spoutIn', 'spoutOut', 'realSound', ...
    'soundDelay', 'respTime', 'rewCollStart', 'rewCollEnd', 'rewTime', 'imgStopExp', 'imgStopObs', ...
    'endPunish', 'vidEndTCPTrig', 'end' };
for iName = 1 : numel(timeFieldNames);
    this.be.times.(timeFieldNames{iName}) = nan(1, nTrials);    
end;

this.be.resps = nan(1, nTrials);
this.be.punishTimeOuts = nan(1, nTrials);
this.be.respDelays = nan(1, nTrials);
% for each trial: 1 = correct detect, 2 = correct reject, 3 = false alarm, 4 = miss, 5 = early
this.be.respTypes = nan(1, nTrials);
this.be.earlyAllowed = nan(1, nTrials);
this.be.giveRewards = nan(1, nTrials);
this.be.autoRewardModes = cell(1, nTrials);
this.be.autoRewardGiven = nan(1, nTrials);

this.be.isPaused = false;
this.be.isRunning = false;
this.be.isToReset = false;

amplifFactor = 40;
toneDur = 0.5;
this.be.punishSound = makeNoiseTone([500 15000], toneDur, this.be.config.tone.samplingFreq, 0, 0.001) .* amplifFactor;

set(this.GUI.handles.be.pauseExp, 'BackgroundColor', 'red', 'Value', 0);
set(this.GUI.handles.be.startExp, 'BackgroundColor', 'red', 'Value', 0);

this.be.saveTime = datestr(now(), 'yyyy_mm_dd__HH_MM_SS');
saveFolder = sprintf('%s/behav/', this.path.behavSave);
this.be.savePath = sprintf('%sBehavior_%s.mat', saveFolder, this.be.saveTime);
if exist(saveFolder, 'dir') ~=7; mkdir(saveFolder); end;
this.be.logDateFormat = 'yyyy-mm-dd HH:MM:SS.FFF';
o('  #BEInitExp: save folder initialized.', 2, this.verb);

% structure containing the recorded data (analog input )
this.be.record = struct();
for iChan = 1 : size(this.be.hw.analogIns, 2);
    anInName = this.be.hw.analogIns{iChan};
    this.be.record.(anInName) = cell(1, nTrials);
end;

end

