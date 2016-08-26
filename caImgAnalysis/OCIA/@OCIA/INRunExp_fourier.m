function INRunExp_fourier(this)
% INRunExp_fourier - [no description]
%
%       INRunExp_fourier(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

o('#%s ...', mfilename, 3, this.verb);

if isempty(this.in.data.refImg);
    showWarning(this, 'OCIA:INRunExp_fourier:NoRefImg', 'No reference image.');
    INEndExp(this);
    return;
end;

%% init
% extract the parameters structure
params = this.in.fourier;
comParams = this.in.common;

% timing reference
t0 = nowUNIX();
this.in.expStartTime = t0;
this.in.timestamp = datestr(unix2dn(t0), 'yyyymmdd_HHMMSS');

% update experiment counter
this.in.common.expNumber = this.in.common.expNumber + 1;

% calculate total time
totStimDur = params.nSweeps * params.sweepDur;

% stores the frames for the whole stimulation procedure
this.in.data.stimFrames = [];

% get the save path
saveName = INGetSaveName(this);
h5FilePath = sprintf('%s%s.h5', this.path.intrSave, saveName);
logFilePath = sprintf('%s%s.log', this.path.intrSave, saveName);
% make sure folder exists
if exist(this.path.intrSave, 'dir') ~= 7; mkdir(this.path.intrSave); end;

% start logging
diary(logFilePath);

% initialize stimulation
INInitStim(this);

%% init camera
% flush the previous data
stop(this.in.camH);
flushdata(this.in.camH);
% switch to non-stop collection mode with manual software trigger
triggerconfig(this.in.camH, 'manual');
set(this.in.camH, 'FramesPerTrigger', Inf);

% set logging to memory
set(this.in.camH, 'LoggingMode', 'memory');
this.in.camH.DiskLogger = [];
% start camera but it waits for trigger
start(this.in.camH);

%% starting delay
showMessage(this, sprintf('%s | Intrinsic: starting delay (%.1f sec) ...', INGetTime(this), comParams.startDelay), ...
    'yellow');
pause(comParams.startDelay);
if ~this.in.expRunning; INEndExp(this); return; end;

%% start camera recording and stimulation

showMessage(this, sprintf('%s | Intrinsic: trigerring camera ...', INGetTime(this)), 'yellow');
trigger(this.in.camH);
tCamTrigg = nowUNIXSec(); % camera triggering time reference

showMessage(this, sprintf('%s | Intrinsic: triggering stimulus ...', INGetTime(this)), 'yellow');
tSweep = nowUNIXSec(); % current sweep triggering time reference
tStimTrigg = nowUNIXSec(); % stimulus triggering time reference
% play sound using TDT
if strcmp(comParams.stimMode, 'TDT');
    % use the software trigger to launch the sound
    this.in.RP.SoftTrg(1);

% play sound without TDT
elseif strcmp(comParams.stimMode, 'soundCard');
    % blocking so that the program waits for the stimlus to finish
    this.in.audioplayer.play();

% send out a digital trigger
elseif strcmp(comParams.stimMode, 'trigOut');
    outputSingleScan(this.in.daq.sessHandle, 1); % TTL high
    outputSingleScan(this.in.daq.sessHandle, 0); % back to TTL low

end;
if ~this.in.expRunning; INEndExp(this); return; end;

% wait until stimulation finished
lastPercent = -1;
iSweep = 1;
while (nowUNIXSec() - tStimTrigg) < totStimDur;
    pause(0.001); % avoid full-speed looping
    
    % monitor sweep progression
    if (nowUNIXSec() - tSweep) >= params.sweepDur;
        tSweep = nowUNIXSec();
        iSweep = iSweep + 1;
        showMessage(this, sprintf('%s | Intrinsic: sweep %02d/%02d ...', INGetTime(this), iSweep, ...
            params.nSweeps), 'yellow');
        if ~this.in.expRunning; INEndExp(this); return; end;
    end;
    
    percentDone = floor(10 * (nowUNIXSec() - tStimTrigg) / totStimDur) * 10;
    if percentDone ~= lastPercent;
        lastPercent = percentDone;
        nFramesRec = get(this.in.camH, 'FramesAcquired');
        showMessage(this, sprintf('%s | Intrinsic: stimulation progress: %02d%% ... (%03d frames)', ...
            INGetTime(this), percentDone, nFramesRec), 'yellow');
    end;
end;

% stop recording
camDur = nowUNIXSec() - tCamTrigg;
stop(this.in.camH);

% calculate frame rate
nFramesRec = get(this.in.camH, 'FramesAcquired');
showMessage(this, sprintf('%s | Intrinsic: recording done (%d frames, %.3f sec, %.3f fps).', INGetTime(this), ...
    nFramesRec, camDur, this.in.fourier.frameRate));
if ~this.in.expRunning; INEndExp(this); return; end;

%% save data to disk

% calculate number of chunks
chunkSize = [16 16 100];
nChunks = ceil(nFramesRec / chunkSize(3));
    
% get the image's dimensions and adjust the chunk size if needed
imgDim = this.in.camH.ROIPosition / this.in.common.spatialDSFactor;
imgDim = imgDim(3:4);
if mod(imgDim(1), 10) == 0 && mod(imgDim(2), 10) == 0;
    chunkSize = [10 10 100];
end;
% get the dataset path
datasetPathRoot = sprintf('/%s/%s/%s', this.in.common.animalID, datestr(now, 'yyyy_mm_dd'), saveName);
datasetPathStim = sprintf('%s/stimFrames', datasetPathRoot);
% create the data set with the required size and data type 'double'
h5create(h5FilePath, datasetPathStim, [imgDim nFramesRec], 'ChunkSize', chunkSize, ...
    'Deflate', this.in.common.h5saveDeflate, 'DataType', 'uint16');

% save the reference image
showMessage(this, sprintf('%s | Intrinsic: saving ref. image ...', INGetTime(this)), 'yellow');
pause(0.02);
h5create(h5FilePath, regexprep(datasetPathStim, 'stimFrames', 'refImg'), imgDim, 'ChunkSize', chunkSize(1 : 2), ...
    'Deflate', this.in.common.h5saveDeflate, 'DataType', 'uint16');
h5write(h5FilePath, regexprep(datasetPathStim, 'stimFrames', 'refImg'), this.in.data.refImg);
  
showMessage(this, sprintf('%s | Intrinsic: saving data ...', INGetTime(this)), 'yellow');  
pause(0.02);
% go through the frames chunk by chunk
lastPercent = -1;
for iChunk = 1 : nChunks;
    % extract data reshape it
    [frames, ~, metadata] = getdata(this.in.camH, min(chunkSize(3), this.in.camH.FramesAvailable));
    [H, W, ~, nFrames] = size(frames);
    frames = reshape(frames, [H W nFrames]);
    % extract current starting frame from metadata
    cellMetadata = struct2cell(metadata);
    startFrameForChunk = cellMetadata{3, 1};
    % spatial down-sampling (binning)
    frames = INSpatialDownSample(this, frames);
    [dSH, dSW, nFrames] = size(frames);
    % append data to dataset
    h5write(h5FilePath, datasetPathStim, frames, [1 1 startFrameForChunk], [dSH dSW nFrames]);
    % display progress
    percentDone = floor(10 * (iChunk  / nChunks)) * 10;
    if percentDone ~= lastPercent;
        lastPercent = percentDone;
        showMessage(this, sprintf('%s | Intrinsic: saving chunk %02d/%02d (%02d%% done) ...', INGetTime(this), ...
            iChunk, nChunks, percentDone), 'yellow');
        pause(0.05);
    end;
end;

% save all parameters as attribute
attrDatasetPath = datasetPathRoot;
h5createwrite_wrapper(h5FilePath, attrDatasetPath, this.in.common, {}, {});
h5createwrite_wrapper(h5FilePath, attrDatasetPath, this.in.fourier, {}, {});

showMessage(this, sprintf('%s | Intrinsic: saving data done.', INGetTime(this)), 'yellow');
pause(0.02);

%% finish
% release ressources
INCleanUp(this);

% finalize
this.in.expRunning = false;

% update in GUI
set(this.GUI.handles.in.paramPanElems.expNumber, 'String', sprintf('%d', this.in.common.expNumber));
set(this.GUI.handles.in.runExpBut, 'BackgroundColor', 'red', 'Value', 0);
showMessage(this, sprintf('%s | Intrinsic: experiment number %02d done !', INGetTime(this), this.in.common.expNumber));

end
