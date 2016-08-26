function config = calculateBFStats(PSROIStats, config)

%% init
nROIs = size(PSROIStats, 1);
ROIPrefs = cell(1, nROIs + 1);
ROIPrefFitParams = cell(1, nROIs + 1);
ROIPrefSEM = cell(1, nROIs + 1);

% init the size of the data set
nStims = size(PSROIStats, 2);

method = 'max';
if isfield(config, 'BFStatCalcMethod');
    method = config.BFStatCalcMethod;
end;
% if fitting is required, set tag to true
BFFit = isfield(config, 'doBFFit') && config.doBFFit;

%% Calculate BF preference for each ROI
for iROI = 1 : nROIs + 1;
    
    % select the ROIStats data for this ROI, if it's the last ROI, it's the data for all ROIs (population)
    if iROI == nROIs + 1;
        
        ROIPrefFieldNames = fieldnames(ROIPrefFitParams{iROI - 1});
%         ROIPrefFieldNames(cellfun(@(fieldName) isnan(ROIPrefFitParams{iROI - 1}.(fieldName), ROIPrefFieldNames));
        ROIPrefFitParams{iROI} = struct();
        for iFieldName = 1 : numel(ROIPrefFieldNames);
            fieldName = ROIPrefFieldNames{iFieldName};
            ROIPrefFitParams{iROI}.(fieldName) = ...
                mean(cellfun(@(ROIPrefForROI) ROIPrefForROI.(fieldName), ROIPrefFitParams(1 : nROIs - 1)));
        end;
        
        % collect the ROI BF preferences as a mean of all ROIs without the neuropil
        ROIPrefs{iROI} = mean(cell2mat(ROIPrefs(1 : nROIs - 1)), 2);
        % collect the ROI BF SEM from the same frame where the max was taken
        ROIPrefSEM{iROI} =  mean(cell2mat(ROIPrefSEM(1 : nROIs - 1)'), 1);
                
        break;
        
%         PSROIStatsNoNPil = PSROIStats(1 : nROIs - 1, :);
%         % get the biggest number of repetitions and frames of all ROIs
%         nReps = max(cell2mat(cellfun(@(x)size(x, 1), PSROIStatsNoNPil(:), 'UniformOutput', false)));
%         nFrames = max(cell2mat(cellfun(@(x)size(x, 2), PSROIStatsNoNPil(:), 'UniformOutput', false)));
%         
%         ROIStatsForPop = zeros(nReps, nFrames, nStims);
%         for iROIPop = 1 : size(PSROIStatsNoNPil, 1);
%             
%         end;
%         
%         % extract the ROIstats for all ROIs without including the neuropil (last ROI)
%         ROIStatsForPop = reshape(cell2mat(PSROIStats(1 : nROIs - 1, :)), nROIs - 1, nReps, nFrames, nStims);
%         % reshape the data to a matrix of nReps x nFrames x nStim and average for the ROIs
%         ROIStatsForROI = reshape(mean(ROIStatsForPop, 1), nReps, nFrames, nStims);
    else
    
        nReps = size(PSROIStats{iROI, 1}, 1);
        nFrames = size(PSROIStats{iROI, 1}, 2);
        ROIStatsForROICell = PSROIStats(iROI, :);
        % reshape the data to a matrix of nReps x nFrames x nStim
        ROIStatsForROI = reshape(cell2mat(ROIStatsForROICell), nReps, nFrames, nStims);
    end;

    if strcmp(method, '3PointsPeak');
        
        % get the evoked frames
        ROIStatsForROIEvoked = ROIStatsForROI(:, config.psFrames.base + 1 : end, :);
        % get the baseline for each repetition and average it
        ROIStatsForROIBaseline = reshape(mean(ROIStatsForROI(:, 1 : config.psFrames.base, :), 2), ...
            nReps, nStims);
        % create a matrix of these averaged baselines
        ROIStatsForROIBaselineRep = reshape(repmat(ROIStatsForROIBaseline, ...
            config.psFrames.evoked, 1), nReps, config.psFrames.evoked, nStims);
        % correct the evoked traces with this baseline
        ROIStatsForROIEvokedCorrected = ROIStatsForROIEvoked - ROIStatsForROIBaselineRep;
        % average for the reps
        ROIStatsForROIMeanEvoked = mean(ROIStatsForROIEvokedCorrected, 1);
        % sort the values of the evoked frames
        ROIStatsForROIMeanEvokedSorted = sort(ROIStatsForROIMeanEvoked);
        % take the 3 biggest
        ROIPref3PointsPeak = ROIStatsForROIMeanEvokedSorted(end - 2 : end, :);
        % get their mean and standard error mean
        ROIPref = mean(ROIPref3PointsPeak);
        ROIPrefSEMforROI = sem(ROIStatsForROIMeanEvoked);
        
        % collect the ROI BF preferences and the SEMs
        ROIPrefs{iROI} = ROIPref(:);
        ROIPrefSEM{iROI} = ROIPrefSEMforROI(:);
        
    elseif strcmp(method, 'max');
        
        % get the evoked frames
        ROIStatsForROIEvoked = ROIStatsForROI(:, config.psFrames.base + 1 : end, :);
        % get the baseline for each repetition and average it
        ROIStatsForROIBaseline = reshape(mean(ROIStatsForROI(:, 1 : config.psFrames.base, :), 2), ...
            nReps, nStims);
        % create a matrix of these averaged baselines
        ROIStatsForROIBaselineRep = reshape(repmat(ROIStatsForROIBaseline, ...
            config.psFrames.evoked, 1), nReps, config.psFrames.evoked, nStims);
        % correct the evoked traces with this baseline
        ROIStatsForROIEvokedCorrected = ROIStatsForROIEvoked - ROIStatsForROIBaselineRep;
        % get the mean trace of every repetition
        ROIStatsForROIEvokedMean = reshape(mean(ROIStatsForROIEvokedCorrected), ...
            config.psFrames.evoked, nStims);
        
%         ROIStatsForROIEvokedMean = reshape(mean(ROIStatsForROIEvoked), ...
%             config.psFrames.evoked, nStims);
%         ROIStatsForROIBaseline = ROIStatsForROI(:, 1 : config.psFrames.base, :);
%         ROIStatsForROIBaselineMean = reshape(mean(ROIStatsForROIBaseline), ...
%             config.psFrames.base, nStims);
%         ROIStatsForROIEvokedMean = ROIStatsForROIEvokedMean - ...
%             repmat(mean(ROIStatsForROIBaselineMean), config.psFrames.evoked, 1);

        % get the maximum trace of the evoked trace for each stimulus (with indexes to get the SEM later)
        [ROIPref, maxFrames] = max(ROIStatsForROIEvokedMean);
        % get the SEM for each frame (manually with a for loop...)
        ROIStatsForROIEvokedSEM = zeros(config.psFrames.evoked, nStims);
        % go trought each stim and each frame and calculate the SEM for each repetition
        for iStim = 1 : nStims;
            for iFrame = 1 : config.psFrames.evoked;
                ROIStatsForROIEvokedSEM(iFrame, iStim) = sem(ROIStatsForROIEvoked(:, iFrame, iStim));
            end;
        end;
        
        % init the structure with NaNs
        ROIPrefFitParams{iROI} = struct('fObj', NaN, 'GOF', NaN, 'width', NaN, 'width_CI', NaN, ...
            'BF', NaN, 'BF_CI', NaN, 'maxEvoked', NaN, 'maxEvoked_CI', NaN, 'rsquare', NaN);
        
%         try
            
            if BFFit; % if fitting is required
                
                % fit with custom expression (gaussian with offset)
                expr = 'a1 * exp(-((x - b1) / c1) ^ 2) + d1';
                % a1 ... height of peak (i.e. max. response at best frequency)
                % b1 ... position of center peak (i.e. best frequency)
                % c1 ... width of curve (standard dev.)?
                % d1 ... baseline offset
                fType = fittype(expr);
                
                % set the fit options with some boundaries and starting points
                fOpt = fitoptions(fType);
                fOpt.Lower = [
                    max(ROIPref) * 0.5      % min height should be above 0
                    min(config.freqIDs)     % min frequency cannot be lower than the freq. list
                    100                     % min width should be at least 100 Hz
                    0                       % min offset can be 0
                ];
                fOpt.Upper = [
                    max(ROIPref) * 1.5      % max height cannot be too high
                    max(config.freqIDs)     % max frequency cannot exceed the freq. list
                    range(config.freqIDs)   % max width cannot exceed the range of the freq. list
                    max(ROIPref) * 0.5      % max offset cannot be too high
                ];
                fOpt.StartPoint = [
                    max(ROIPref)            % start at the highest value
                    mean(config.freqIDs)    % start in the middle of the freq. list
                    1000                    % start with a "sharp" tuning of 1kHz
                    0                       % start with no offset
                ];

                % do the  fitting
                [fObj, GOF] = fit(config.freqIDs', ROIPref', fType, fOpt);

                % get the confidence interval of the fit parameters and store everything
                CI = confint(fObj);
                ROIPrefFitParams{iROI} = struct('fObj', fObj, 'GOF', GOF, ...
                    'width', fObj.c1, 'width_CI', CI(:,3)', 'BF', fObj.b1, 'BF_CI', CI(:,2)', ...
                    'maxEvoked', fObj.a1, 'maxEvoked_CI', CI(:,1)', 'rsquare', GOF.rsquare);
                
            else % if fitting is not required
                
                % use the BF of the max evoked response
                [maxAtBF, BFIndex] = max(ROIPref);
                ROIPrefFitParams{iROI}.BF = config.freqIDs(BFIndex);
                ROIPrefFitParams{iROI}.maxEvoked = maxAtBF;
                
            end;
        
%         % if there is an error, most likely no license for the fitting toolbox
%         catch e;
%             % error related to license for the fitting toolbox, just use the max value
%             if strcmp(e.identifier, 'MATLAB:license:checkouterror');
%                 o('License not available...', 0, 0);
%                 % use the BF of the max evoked response
%                 [maxAtBF, BFIndex] = max(ROIPref);
%                 ROIPrefFitParams{iROI}.BF = config.freqIDs(BFIndex);
%                 ROIPrefFitParams{iROI}.maxEvoked = maxAtBF;
%             % other errors (shouldn't happen)
%             else
%                 error(e.identifier, e.message);
%             end;
%         end;
        
        % collect the ROI BF preferences
        ROIPrefs{iROI} = ROIPref(:);
        % collect the ROI BF SEM from the same frame where the max was taken
        ROIPrefSEM{iROI} = ROIStatsForROIEvokedSEM(sub2ind(size(ROIStatsForROIEvokedSEM), maxFrames, 1:nStims));
    else
        warning('calculateBFStats:UnknownMethod', 'BFStatsCalcMethod is unknown: "%s"', method);
    end;

end;

config.ROIBFPrefs = ROIPrefFitParams;
config.ROIPrefs = ROIPrefs;
config.ROIPrefSEM = ROIPrefSEM;

end
