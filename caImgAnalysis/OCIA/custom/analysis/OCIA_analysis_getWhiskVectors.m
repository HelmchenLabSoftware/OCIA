%% #OCIA:AN:OCIA_analysis_caTraces_whiskvectors
function [WAEnvs, WAAmp, WASetP, WAExpWhisk, WAFovWhisk] = OCIA_analysis_getWhiskVectors(this, ...
    rawWhiskTraces, whiskFrameRateCellArray)

nRuns = numel(rawWhiskTraces);

% define frequency bands
Expwhisk_low_frequ = 7;             % Hz  frequ. band for exploratory whisking 
Expwhisk_up_frequ = 12;             % Hz
Fovwhisk_low_frequ = 15;            % Hz  frequ. band for foveal whisking
Fovwhisk_up_frequ = 25;             % Hz
EnvWinSize = 0.3;                   % window size in seconds for envelope and sliding mean/amp calculation

% loop through each run and calculate various whisking angle (WA) variables
WAEnvs = cell(size(rawWhiskTraces));        % envelope (max - min)
WAAmp = cell(size(rawWhiskTraces));         % amplitude (max)
WASetP = cell(size(rawWhiskTraces));        % set point (mean angle)
WAExpWhisk = cell(size(rawWhiskTraces));    % exploratory whisking
WAFovWhisk = cell(size(rawWhiskTraces));    % foveal whisking

parfor iRun = 1 : nRuns;
    
    whiskFrameRate = whiskFrameRateCellArray{iRun};
    
    % calculate the envelope
    whiskAngle = rawWhiskTraces{iRun};
    nWhiskFrames = size(whiskAngle, 2);
    winSize = round(EnvWinSize * whiskFrameRate);
    for iFrame = 1 : nWhiskFrames;    
        r = iFrame - winSize : iFrame + winSize;
        r(r < 1 | r > nWhiskFrames) = [];
        WAEnvs{iRun}(iFrame) = max(whiskAngle(r)) - min(whiskAngle(r));     % Whisking envelope
        WAAmp{iRun}(iFrame)  = max(whiskAngle(r));                          % Whisking amplitude
        WASetP{iRun}(iFrame) = mean(whiskAngle(r));                         % Whisker set point
     end;
    [~, bandpow1, bandpow2] = spectralDensityAnalysis(whiskAngle, 128, 127, 128, whiskFrameRate, ...
        Expwhisk_low_frequ, Expwhisk_up_frequ, Fovwhisk_low_frequ, Fovwhisk_up_frequ);
    
    % ...(whiskAngle, windowsiz, overlap, nfft, ...)
    WAExpWhisk{iRun} = bandpow1;
    WAFovWhisk{iRun} = bandpow2;
    
end;


