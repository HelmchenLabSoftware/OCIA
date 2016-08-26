function INRunExp_trial(this)
% INRunExp_trial - [no description]
%
%       INRunExp_trial(this)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

o('#%s ...', mfilename, 3, this.verb);

if isempty(this.in.data.refImg);
    showWarning(this, 'OCIA:INRunExp_trial:NoRefImg', 'No reference image.');
    INEndExp(this);
    return;
end;

%% init
% extract the parameters structure
params = this.in.trial;
comParams = this.in.common;

% timing reference
t0 = nowUNIX();
this.in.expStartTime = t0;
this.in.timestamp = datestr(unix2dn(t0), 'yyyymmdd_HHMMSS');

% update experiment counter
this.in.common.expNumber = this.in.common.expNumber + 1;

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

%% init data saving
% calculate number of chunks
chunkSize = [16, 16, 100, 1, 1];
nFramesPerTrigger = comParams.frameRate * (params.BLDur + params.EVDur);
% calculate number of real trials
nStimTypes = numel(params.stimIDs);
nTotTrialsPerStim = comParams.nSweeps * ceil(numel(params.stimVect) / nStimTypes);
    
% get the image's dimensions and adjust the chunk size if needed
imgDim = this.in.camH.ROIPosition ./ this.in.common.spatialDSFactor;
imgDim = imgDim(3:4);
if mod(imgDim(1), 10) == 0 && mod(imgDim(2), 10) == 0;
    chunkSize = [10, 10, 100, 1, 1];
end;
if mod(nFramesPerTrigger, 10) == 0;
    chunkSize(3) = nFramesPerTrigger / 10;
end;

% check that no dimension of chunkSize exceed actual dataset's size
if any(imgDim < chunkSize(1 : 2));
    chunkSize(1 : 2) = min([imgDim', chunkSize(1 : 2)'], [], 2);
end;
if nFramesPerTrigger < chunkSize(3);
    chunkSize(3) = min(nFramesPerTrigger, chunkSize(3));
end;

showMessage(this, sprintf('%s | Intrinsic: creating file ...', INGetTime(this)), 'yellow');
% get the dataset path
datasetPathRoot = sprintf('/%s/%s/%s', this.in.common.animalID, datestr(now, 'yyyy_mm_dd'), saveName);
datasetPathStim = sprintf('%s/stimFrames', datasetPathRoot);
% create the data set with the required size and data type 'double'
h5create(h5FilePath, datasetPathStim, [imgDim, nFramesPerTrigger, nTotTrialsPerStim, nStimTypes], ...
    'ChunkSize', chunkSize, 'Deflate', this.in.common.h5saveDeflate, 'DataType', 'uint16');

% save all parameters as attribute
attrDatasetPath = datasetPathRoot;
h5createwrite_wrapper(h5FilePath, attrDatasetPath, this.in.common, {}, {});
h5createwrite_wrapper(h5FilePath, attrDatasetPath, this.in.trial, {}, {});

% save the reference image
showMessage(this, sprintf('%s | Intrinsic: saving ref. image ...', INGetTime(this)), 'yellow');
pause(0.02);
h5create(h5FilePath, regexprep(datasetPathStim, 'stimFrames', 'refImg'), imgDim, 'ChunkSize', chunkSize(1 : 2), ...
    'Deflate', this.in.common.h5saveDeflate, 'DataType', 'uint16');
h5write(h5FilePath, regexprep(datasetPathStim, 'stimFrames', 'refImg'), this.in.data.refImg);

%% init camera
% flush the previous data
stop(this.in.camH);
flushdata(this.in.camH);
% switch to limited frame number collection mode with manual software trigger
triggerconfig(this.in.camH, 'hardware', 'RisingEdge', 'EdgeTrigger');
% triggerconfig(this.in.camH, 'manual');
set(this.in.camH, 'FramesPerTrigger', nFramesPerTrigger, 'TriggerRepeat', 0);

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

%% start camera recording and stimulation for each trial
iCurrTrialsPerStimType = zeros(nStimTypes, 1);
% figH = figure('Name', 'Average responses', 'Position', [1, 45, 1280, 913]);
for iSweep = 1 : comParams.nSweeps;
    for iStim = 1 : numel(params.stimVect);

        if ~this.in.expRunning; INEndExp(this); return; end;
        
        iStimType = params.stimVect(iStim);
        iCurrTrialsPerStimType(iStimType) = iCurrTrialsPerStimType(iStimType) + 1;
        iTrialForStim = iCurrTrialsPerStimType(iStimType);
        stimID = params.stimIDs{iStimType};
        if isnumeric(stimID); stimID = sprintf('%d', stimID); end;
        showMessage(this, sprintf('%s | Intrinsic: sweep %02d/%02d, stim %02d/%02d (stim %d "%s", trial %02d/%02d) ...', ...
            INGetTime(this), iSweep, comParams.nSweeps, iStim, numel(params.stimVect), iStimType, stimID, ...
            iTrialForStim, nTotTrialsPerStim), 'yellow');
        
        showMessage(this, sprintf('%s | Intrinsic: sweep %02d/%02d, stim %02d/%02d: trigerring camera & stimulus ...', ...
            INGetTime(this), iSweep, comParams.nSweeps, iStim, numel(params.stimVect)), 'yellow');
        camTic = tic;
%         trigger(this.in.camH);

        stimTic = tic;
        elapsedTimeCamTrig = toc(camTic);

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

            outputSingleScan(this.in.daq.sessHandle, 0); % TTL low
            outputSingleScan(this.in.daq.sessHandle, 1); % TTL high
            outputSingleScan(this.in.daq.sessHandle, 0); % TTL low
            % make a double-trigger since only one does not work with camera...
            while this.in.camH.FramesAcquired <= 1;
                pauseTicToc(0.01);
                outputSingleScan(this.in.daq.sessHandle, 0); % TTL low
                outputSingleScan(this.in.daq.sessHandle, 1); % TTL high
                outputSingleScan(this.in.daq.sessHandle, 0); % TTL low
            end;

        end;
        if ~this.in.expRunning; INEndExp(this); return; end;
        
        elapsedTimeStimTrig = toc(stimTic);
        elapsedTimeTot = elapsedTimeCamTrig + elapsedTimeStimTrig;
        tStimTrigg = nowUNIXSec(); % stimulus triggering time reference
        showMessage(this, sprintf(['%s | Intrinsic: sweep %02d/%02d, stim %02d/%02d: trigerring done ', ...
            '(camera: %.5f, stimulus: %.5f, total: %.5f).'], INGetTime(this), iSweep, comParams.nSweeps, ...
            iStim, numel(params.stimVect), elapsedTimeCamTrig, elapsedTimeStimTrig, elapsedTimeTot), 'yellow');

        % wait until trial finished
        startDone = false;
        baselineDone = false;
        savingDone = false;
        ITIDone = false;
        while ((nowUNIXSec() - tStimTrigg) < params.trialDur) || islogging(this.in.camH);
            pause(0.005); % avoid full-speed looping

            if ~this.in.expRunning; INEndExp(this); return; end;
            
            if ~startDone;
                showMessage(this, sprintf('%s | Intrinsic: sweep %02d/%02d, stim %02d/%02d: baseline ...', ...
                    INGetTime(this), iSweep, comParams.nSweeps, iStim, numel(params.stimVect)), 'yellow');
                startDone = true;
            end;
            if ~baselineDone && ((nowUNIXSec() - tStimTrigg) > params.BLDur);
                showMessage(this, sprintf('%s | Intrinsic: sweep %02d/%02d, stim %02d/%02d: stim ...', ...
                    INGetTime(this), iSweep, comParams.nSweeps, iStim, numel(params.stimVect)), 'yellow');
                baselineDone = true;
            end;
            
            % if camera is done, save data
            if ~savingDone && ~islogging(this.in.camH);
                
                if ~this.in.expRunning; INEndExp(this); return; end;
                
                showMessage(this, sprintf('%s | Intrinsic: saving data ...', INGetTime(this)), 'yellow');
                pause(0.02);
                % extract data reshape it
                frames = getdata(this.in.camH, this.in.camH.FramesAvailable);
                [H, W, ~, nFrames] = size(frames);
                frames = reshape(frames, [H W nFrames]);
                % spatial down-sampling (binning)
                frames = INSpatialDownSample(this, frames);
                [dSH, dSW, nFrames] = size(frames);
                
                if ~this.in.expRunning; INEndExp(this); return; end;
                
                % append data to dataset
                h5write(h5FilePath, datasetPathStim, frames, [1, 1, 1, iTrialForStim, iStimType], [dSH dSW nFrames, 1, 1]);

                showMessage(this, sprintf('%s | Intrinsic: saving data done.', INGetTime(this)), 'yellow');
                pause(0.02);
                savingDone = true;
                
                stop(this.in.camH);
                flushdata(this.in.camH);
                
                % start camera again but it waits for trigger
                start(this.in.camH);
                
                if exist('figH', 'var');
                    if ~exist('iCount', 'var'); iCount = 1; end;
                    figure(figH);
%                     subplot(comParams.nSweeps, numel(params.stimVect), iCount);
                    subplot(3, 4, iCount);
                    plot(((1 : size(frames, 3)) / comParams.frameRate) - params.BLDur, squeeze(nanmean(nanmean(frames, 1), 2)));
                    title(sprintf('SWEP%d|STIM%d|TYPE%d\nSTIM:%s|ITRIAL%d|ICOUNT%d', iSweep, iStim, iStimType, stimID, ...
                        iTrialForStim, iCount), 'FontSize', 6);
                    set(gca, 'YTick', []);
                    iCount = iCount + 1;
                end;
                
            end;
            if ~ITIDone && ((nowUNIXSec() - tStimTrigg) > (params.BLDur + params.EVDur));
                showMessage(this, sprintf('%s | Intrinsic: sweep %02d/%02d, stim %02d/%02d: inter-trial ...', ...
                    INGetTime(this), iSweep, comParams.nSweeps, iStim, numel(params.stimVect)), 'yellow');
                ITIDone = true;
            end;
        end;
    end;
end;
                
% stop recording
stop(this.in.camH);

% calculate frame rate
showMessage(this, sprintf('%s | Intrinsic: recording done.', INGetTime(this)));
if ~this.in.expRunning; INEndExp(this); return; end;

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
