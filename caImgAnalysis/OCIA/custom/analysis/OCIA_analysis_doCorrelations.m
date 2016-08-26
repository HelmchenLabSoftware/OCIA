function OCIA_analysis_doCorrelations(this, iDWRows)
% OCIA_analysis_doCorrelations - [no description]
%
%       OCIA_analysis_doCorrelations(this, iDWRows)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)




% pre-allocate a matrix to store all correlations
corrMatrix = zeros(nRuns, nROIs);
corrMatrixAmp = zeros(nRuns, nROIs);
corrMatrixSetP = zeros(nRuns, nROIs);
corrMatrixExpwhisk = zeros(nRuns, nROIs);
corrMatrixFovwhisk = zeros(nRuns, nROIs);

% define frequency bands
Expwhisk_lower_frequency = 7;   % Hz  frequ. band for exploratory whisking 
Expwhisk_upper_frequency = 12;   % Hz
Fovwhisk_lower_frequency = 15;   % Hz  frequ. band for foveal whisking
Fovwhisk_upper_frequency = 25;   % Hz

% loop through each run and calculate the enveloppe
whiskAngleEnvs = cell(whiskAngles);
whiskAngleAmp = cell(whiskAngles);
whiskAngleSetP = cell(whiskAngles);
whiskAngleExpwhisk = cell(whiskAngles);
whiskAngleFovwhisk = cell(whiskAngles);
WhiskVector = cell(whiskAngles);

whiskAngleLong = [];
for iRun = 1 : nRuns;    
    % calculate the envelope
    whiskAngle = whiskAngles{iRun};
    % winSize = round(nWhiskFrames * 0.005);
    winSize = round(0.3*whiskSampRate);
    whiskAngleEnvs{iRun} = zeros(1, nWhiskFrames);
    for iFrame = 1 : nWhiskFrames;    
        r = iFrame - winSize : iFrame + winSize;
        r(r < 1 | r > nWhiskFrames) = [];
        whiskAngleEnvs{iRun}(iFrame) = max(whiskAngle(r))-min(whiskAngle(r));
        whiskAngleAmp{iRun}(iFrame) = max(whiskAngle(r))-min(whiskAngle(r));  % Whisking amplitude
        whiskAngleSetP{iRun}(iFrame) = mean(whiskAngle(r)); % Whisker set point
              
        
        %whiskAngleExpwhisk{iRun}(iFrame)  = bandpower(whiskAngle(r),whiskSampRate,[Expwhisk_lower_frequency Expwhisk_upper_frequency]);
        %whiskAngleFovwhisk{iRun}(iFrame)  = bandpower(whiskAngle(r),whiskSampRate,[Fovwhisk_lower_frequency Fovwhisk_upper_frequency]);
    end;
    [out, bandpow1, bandpow2] = OCIA_spectraldensity(whiskAngle,128,127,128,200, Expwhisk_lower_frequency, Expwhisk_upper_frequency, Fovwhisk_lower_frequency, Fovwhisk_upper_frequency);
    whiskAngleExpwhisk{iRun}=bandpow1;
    whiskAngleFovwhisk{iRun}=bandpow2;
    
    % now calculate binary whisking vector from ExpWhisk %
    WhiskVector{iRun} = find(whiskAngleExpwhisk{iRun} > 0.01);
    %
    
    whiskAngleLong = cat(2,whiskAngleLong, whiskAngle); 
end;

% loop through each run and each ROI and calculate the correlation
for iRun = 1 : nRuns;    
    for iROI = 1 : nROIs;
        % up-sample the calcium trace for this run and this ROI
        caTraceUS = interp1DS(imgFrameRate, whiskSampRate, squeeze(caTraces(iROI, iRun, :)));
        caTraceUS(end + 1 : nWhiskFrames) = 0;
        % filter the trace if required
        if this.an.an.sgFiltFrameSize > 1 && mod(this.an.an.sgFiltFrameSize, 2) ~= 0;
            caTraceUS = sgolayfilt(caTraceUS, 1, this.an.an.sgFiltFrameSize);
        end;
        % calculate the correlation between the whisker angle and the calcium data
        corrValue = corr([caTraceUS; whiskAngleEnvs{iRun}]', 'rows', 'pairwise');
        corrValueAmp = corr([caTraceUS; whiskAngleAmp{iRun}]', 'rows', 'pairwise');
        corrValueSetP = corr([caTraceUS; whiskAngleSetP{iRun}]', 'rows', 'pairwise');
        corrValueExpwhisk = corr([caTraceUS; whiskAngleExpwhisk{iRun}]', 'rows', 'pairwise');
        corrValueFovwhisk = corr([caTraceUS; whiskAngleFovwhisk{iRun}]', 'rows', 'pairwise');
        % store the correlation coefficient
        corrMatrix(iRun, iROI) = corrValue(1, 2);
        corrMatrixAmp(iRun, iROI) = corrValueAmp(1, 2);
        corrMatrixSetP(iRun, iROI) = corrValueSetP(1, 2);
        corrMatrixExpwhisk(iRun, iROI) = corrValueExpwhisk(1, 2);
        corrMatrixFovwhisk(iRun, iROI) = corrValueFovwhisk(1, 2);
    end;
end;

% calculate the correlation on all traces concatenated
corrMatrix(end + 1, :) = zeros(1, size(corrMatrix, 2)); % allocate for the new correlation row
allWhiskAngleEnvs = cell2mat(whiskAngleEnvs);
allWhiskAngleAmp = cell2mat(whiskAngleAmp);
allWhiskAngleSetP = cell2mat(whiskAngleSetP);
allWhiskAngleExpwhisk = cell2mat(whiskAngleExpwhisk);
allWhiskAngleFovwhisk = cell2mat(whiskAngleFovwhisk);

DFFIntegral = zeros(1,nROIs);
DFFSingleAmp = 8;  % 8% DF/F amplitude single AP
DFFSingleTau = 1;  % 1 sec
DFFSTD = zeros(1,nROIs);
DFFKurtosis = zeros(1,nROIs);
CaTraceAllRunsROIs_ds = nan(nROIs,nRuns*nImgFrames);

for iROI = 1 : nROIs;
    % up-sample the calcium trace for this run and this ROI
    caTraceUSAllRuns = interp1DS(imgFrameRate, whiskSampRate, reshape(squeeze(caTraces(iROI, 1 : nRuns, :))', ...
        nRuns * nImgFrames, 1)');
    caTraceUSAllRuns(end + 1 : numel(allWhiskAngleEnvs)) = 0;
    % filter the trace if required
    if this.an.an.sgFiltFrameSize > 1 && mod(this.an.an.sgFiltFrameSize, 2) ~= 0;
        caTraceUSAllRuns = sgolayfilt(caTraceUSAllRuns, 1, this.an.an.sgFiltFrameSize);
    end;
    % calculate the correlation between the whisker angle and the calcium data
    corrValue = corr([caTraceUSAllRuns; allWhiskAngleEnvs]', 'rows', 'pairwise');
    corrValueAmp = corr([caTraceUSAllRuns; allWhiskAngleAmp]', 'rows', 'pairwise');
    corrValueSetP = corr([caTraceUSAllRuns; allWhiskAngleSetP]', 'rows', 'pairwise');
    corrValueExpwhisk = corr([caTraceUSAllRuns; allWhiskAngleExpwhisk]', 'rows', 'pairwise');
    corrValueFovwhisk = corr([caTraceUSAllRuns; allWhiskAngleFovwhisk]', 'rows', 'pairwise');
    % store the correlation coefficient
    corrMatrix(end, iROI) = corrValue(1, 2);
    corrMatrixAmp(end, iROI) = corrValueAmp(1, 2);
    corrMatrixSetP(end, iROI) = corrValueSetP(1, 2);
    corrMatrixExpwhisk(end, iROI) = corrValueExpwhisk(1, 2);
    corrMatrixFovwhisk(end, iROI) = corrValueFovwhisk(1, 2);
    
    lim = length(caTraceUSAllRuns);
    win = whiskSampRate*10;  % 10 seconds interval
    step = win/20;  % step size
    out = zeros(1,round((lim-win)/step));
    DFFsd = zeros(1,lim-win);
    for ii = 1:round((lim-win)/step)
        out(1,ii) = mean(caTraceUSAllRuns(1+(ii-1)*step:1+(ii-1)*step+win));
        DFFsd(1,ii) = std(caTraceUSAllRuns(1+(ii-1)*step:1+(ii-1)*step+win));
    end
    caTraceTmp = caTraceUSAllRuns-min(out);
    DFFIntegral(iROI) = sum(caTraceUSAllRuns-min(out))/(whiskSampRate*DFFSingleAmp*DFFSingleTau)/(length(caTraceUSAllRuns)/whiskSampRate);  % estimate of mean event rate
    ind = find(out == min(out));
    DFFSTD(iROI) = DFFsd(min(ind));
    DFFKurtosis(iROI) = kurtosis(caTraceUSAllRuns-min(out));
    CaTraceAllRunsROIs_ds(iROI,:)=downsample(caTraceUSAllRuns,20,10);
end;

ToSave = zeros(nROIs,7);
ToSave(:,1)= corrMatrixAmp(end,:)';
ToSave(:,2)= corrMatrixSetP(end,:)';
ToSave(:,3)= corrMatrixExpwhisk(end,:)';
ToSave(:,4)= corrMatrixFovwhisk(end,:)';
ToSave(:,5)= DFFIntegral';
ToSave(:,6)= DFFSTD';
ToSave(:,7)= DFFKurtosis';

save testsaveCorr ToSave;
save testsaveTraces allWhiskAngleAmp allWhiskAngleSetP allWhiskAngleExpwhisk allWhiskAngleFovwhisk;
save CaTraceAllRunsROIs_ds CaTraceAllRunsROIs_ds;
save testwhiskAngle whiskAngleLong;