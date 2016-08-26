function [filePath, datasetPath, framesDatasetPath, refImgDatasetPath, framesDim, frameRate, chunkSize, pitchLims, recordDur, attribs] ...
    = OCIA_analysis_widefield_extractFileInfo(this, filePath)
% OCIA_analysis_widefield_extractFileInfo - [no description]
%
%       [filePath, datasetPath, framesDatasetPath, refImg, framesDim, frameRate, chunkSize, pitchLims, ...
%           recordDur, attribs] = OCIA_analysis_widefield_extractFileInfo(this, iFile, noRefImg)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

[datasetPath, framesDatasetPath, refImgDatasetPath, framesDim, frameRate, chunkSize, pitchLims, recordDur, ...
    attribs] = deal([]);

% if not an h5 file, just return file path
if isempty(regexp(filePath, '\.h5$', 'once')) && ~isempty(regexp(filePath, 'stim_trial\d+\.mat$', 'once'));
    return;
elseif isempty(regexp(filePath, '\.h5$', 'once')) && ~isempty(regexp(filePath, 'cond_\w+_average\.mat$', 'once'));
    return;
elseif isempty(regexp(filePath, '\.h5$', 'once')) && ~isempty(regexp(filePath, 'exp\d+_\w+$', 'once'));
    return;
end;
%% get the dataset path
datasetPath = '/';
% animalID
dataStruct = h5info(filePath, datasetPath);
datasetPath = dataStruct.Groups(1).Name;
% dayID
dataStruct = h5info(filePath, datasetPath);
datasetPath = dataStruct.Groups(1).Name;
% dataset ID
dataStruct = h5info(filePath, datasetPath);
datasetPath = dataStruct.Groups(1).Name;
% get the datasets
refImgDatasetPath = [datasetPath, '/refImg'];
framesDatasetPath = [datasetPath, '/stimFrames'];

%% dataset infos
dataStruct = h5info(filePath, framesDatasetPath);
framesDim = dataStruct.Dataspace.Size;
chunkSize = dataStruct.ChunkSize;

%% get the frame rate
attribs = h5read_wrapper(filePath, datasetPath, {});
if ~isfield(attribs, 'frameRate') || isempty(attribs.frameRate);
    frameRate = 100;
    showWarning(this, sprintf('OCIA:%s:FrameRateNotFound', mfilename()), ...
        sprintf('Frame rate not found. Using default frame rate (%.1f fps).', frameRate));
else
    frameRate = attribs.frameRate;
end;
% % fix missing sweep direction
% if ~isfield(attribs, 'sweepDir');
%     attribs.sweepDir = iff(isempty(regexp(filePath, 'upSweep', 'once')), 'down', 'up');
%     showWarning(this, sprintf('OCIA:%s:SweepDirInitialized', mfilename()), ...
%         sprintf('Sweep direction initialized to "%s".', attribs.sweepDir));
% end;

%% calculate stim freq
if isfield(attribs, 'sweepDur') && ~isempty(attribs.sweepDur) && this.an.wf.stimFreq == 0;
    this.an.wf.stimFreq = 1 / attribs.sweepDur;
    this.an.wf.highPassFilterFreq = this.an.wf.stimFreq / 2;
    showWarning(this, sprintf('OCIA:%s:StimFreqInitialized', mfilename()), ...
        sprintf('Stimulus frequency initialized to %.3f (sweepDur = %d).', this.an.wf.stimFreq, attribs.sweepDur));
end;

%% calculate pitch limits
if isfield(attribs, 'fouNFreqs');
    % get the frequencies composing the ramp
    powerTerm = (2 .^ ((0 : attribs.fouNFreqs - 1) * (2 ^ attribs.fouPowOf2)));
    if isempty(powerTerm); powerTerm = 1; end;
    uniqueFreqs = attribs.fouBaseFreq .* powerTerm;
    % invert the direction if needed
    pitchLims = uniqueFreqs(iff(strcmp(attribs.sweepDir, 'up'), [1, end], [end ,1]));
else
    pitchLims = [];
end;

%% recording duration
if isfield(attribs, 'sweepDur');
    recordDur = attribs.nSweeps * attribs.sweepDur;
else
    recordDur = 0;
end;

end