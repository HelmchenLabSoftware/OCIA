function behavDataImg = DWExtractBehavDataForImagingRow(this, iTrial, behavData) %#ok<INUSL>
% DWExtractBehavDataForImagingRow - [no description]
%
%       behavDataImg = DWExtractBehavDataForImagingRow(this, iTrial, behavData)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% create a structure that will hold the behavior data for the imaging rows
behavDataImg = struct();

% extract the recorded behavior data from each analog input
fieldNames = fieldnames(behavData.record);
nSamples = max(arrayfun(@(i)size(behavData.record.(fieldNames{i}){iTrial}, 1), 1 : numel(fieldNames)));
% if no samples, abort
if nSamples == 0; return; end;
bRecData = nan(size(fieldNames, 1), nSamples);
for iFieldName = 1 : size(fieldNames, 1);
    recData = behavData.record.(fieldNames{iFieldName}){iTrial};
    bRecData(iFieldName, 1 : numel(recData)) = reshape(recData, 1, numel(recData));
end

% store the analog in data and its name
behavDataImg.analogInData = bRecData;
behavDataImg.analogInNames = fieldNames;

%% - #OCIA:DW:DWExtractBehavDataForImagingRow : general informations about imaging
if isfield(behavData, 'anInSampRate');      behavDataImg.analogInSampRate = behavData.anInSampRate; end;
if isfield(behavData, 'anInSampleRate');      behavDataImg.analogInSampRate = behavData.anInSampleRate; end;

%% - #OCIA:DW:DWExtractBehavDataForImagingRow : general informations about behavior
behavDataImg.ISI = behavData.config.tone.ISI;
behavDataImg.taskType = behavData.taskType;
if isfield(behavData, 'piezoThresh');
    behavDataImg.piezoThresh = behavData.piezoThresh;
elseif isfield(behavData, 'params') && isfield(behavData.params, 'piezoThresh');
    behavDataImg.piezoThresh = behavData.params.piezoThresh;
end
if isfield(behavData, 'nTones');     behavDataImg.nTones = behavData.nTones; end;
if isfield(behavData, 'resps');      behavDataImg.resp = behavData.resps(iTrial); end;
if isfield(behavData, 'respTypes');  behavDataImg.respType = behavData.respTypes(iTrial); end;
if isfield(behavData, 'autoRewardGiven');  behavDataImg.autoReward = behavData.autoRewardGiven(iTrial); end;
if isfield(behavData, 'stims');      behavDataImg.stim = behavData.stims(iTrial); end;
if isfield(behavData, 'oddPos');     behavDataImg.oddPos = behavData.oddPos(iTrial); end;
if isfield(behavData, 'respDelays'); behavDataImg.respDelay = behavData.respDelays(iTrial); end;
if isfield(behavData, 'times');
    if isfield(behavData.times, 'init'); behavDataImg.initTime = behavData.times.init(iTrial); end;
    if isfield(behavData.times, 'start'); behavDataImg.startTime = behavData.times.start(iTrial); end;
    if isfield(behavData.times, 'sound'); behavDataImg.soundTime = behavData.times.sound(iTrial); end;
    if isfield(behavData.times, 'trialStartCue'); behavDataImg.trialStartCue = behavData.times.trialStartCue(iTrial); end;
    if isfield(behavData.times, 'lightCueOn'); behavDataImg.lightTime = behavData.times.lightCueOn(iTrial); end;
    if isfield(behavData.times, 'respTime'); behavDataImg.respTime = behavData.times.respTime(iTrial); end;
    if isfield(behavData.times, 'rewStart'); behavDataImg.rewTime = behavData.times.rewStart(iTrial); end;
end;
if isfield(behavData, 'stims') && isfield(behavData, 'config') && isfield(behavData.config, 'tone') ...
        && isfield(behavData.config.tone, 'goStim');
    % in case config.tone.goStim is just the index of the good stimulus (e.g. 1 for stim 1, 2 for stim 2 and empty for
    % none but this fails to encode both stims are go)
    if numel(behavData.config.tone.goStim) == 1 && behavData.config.tone.goStim > 1;
        behavDataImg.target = double(isempty(behavData.config.tone.goStim) ...
            || behavData.stims(iTrial) == behavData.config.tone.goStim);
        
    % in case config.tone.goStim is an array with 1 where the go stim is (e.g. [1 0] for stim 1, [0 1] for stim 2
    % or [1 1] for both stim and [0 0] for none
    else
        behavDataImg.target = double(isempty(behavData.config.tone.goStim) ...
            || any(behavData.stims(iTrial) == find(behavData.config.tone.goStim)));
    end;
end;
if isfield(behavData, 'config') && isfield(behavData.config, 'tone') && isfield(behavData.config.tone, 'stimDur');
    behavDataImg.stimDur = behavData.config.tone.stimDur;
end;


end
