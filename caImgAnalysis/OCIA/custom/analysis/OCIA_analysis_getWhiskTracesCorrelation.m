function corrMatrix = OCIA_analysis_getWhiskTracesCorrelation(this, iDWRows, caTraces, whiskTraces, doDownSampling)

totalTic = tic; % for performance timing purposes

%% fetch or extract data
% get the size of the data set
caTracesSize = size(caTraces);
if ismatrix(caTraces);
    [nROIs, nFrames] = size(caTraces);
    nTrials = 1;
    caTraces = reshape(caTraces, [nTrials, nROIs, nFrames]);
else
    [nTrials, nROIs, ~] = size(caTraces);
end;

ANShowHideMessage(this, 1, 'Loading correlation matrix ...');
% get the data in memory
hashStruct = struct('iDWRows', iDWRows, 'caTracesSize', caTracesSize, 'combineROIs', this.an.img.combineROIs, ...
    'noisyTrialsThresh', this.an.img.noisyTrialsThresh, 'doDownSampling', doDownSampling, 'dataType', 'whiskTracesCorr');
cachedData = ANGetCachedData(this, 'whisk', hashStruct);

% if the raw calcium traces matrix is not in cache yet, create it
if isempty(cachedData) || iscell(cachedData);
    
    % allocate space for the correlation matrix
    corrMatrix = nan(nTrials, nROIs);
    
    % get the correlation for each ROI
    for iROI = 1 : nROIs;
        % get the correlation for each trial
        for iTrial = 1 : nTrials;
            % calculate the correlation between the whisker angle and the calcium data
            corrValue = corr([squeeze(caTraces(iTrial, iROI, :))'; squeeze(whiskTraces(iTrial, :))]', 'rows', 'pairwise');
            % store the correlation coefficient
            corrMatrix(iTrial, iROI) = corrValue(1, 2);
        end;
    end;
    
    % store the variables in the cached structure
    cachedData = struct('corrMatrix', corrMatrix, 'dataType', 'whiskTracesCorr', 'params', hashStruct);
    % store the data in memory
    ANStoreCachedData(this, 'whisk', hashStruct, cachedData);

% if data was in memory, fetch it
else
    % fetch the data
    corrMatrix = cachedData.corrMatrix;    
end;

o('#%s done (%3.1f sec).', mfilename(), toc(totalTic), 2, this.verb);

end