function BS = analyseTuning(PSROIStats, PSROIStatsSEM)

%% init
nROIs = size(PSROIStats, 2);
nStims = size(PSROIStats, 3);

stats = {'mean', 'max', 'median', 'sum'};
for iStat = 1 : numel(stats);
    stat = stats{iStat};
    fHandle = str2func(['nan' stat]);
    BS.(stat) = reshape(fHandle(PSROIStats), nROIs, nStims);
    BS.([stat 'SEM']) = reshape(fHandle(PSROIStatsSEM), nROIs, nStims);
end;

for iROI = 1 : nROIs;
    for iStim = 1 : nStims;
        BS.max3pp(iROI, iStim) = mean(maxnpp(PSROIStats(:, iROI, iStim), 3));
        BS.max3ppSEM(iROI, iStim) = sem(maxnpp(PSROIStats(:, iROI, iStim), 3));
    end;
end;
 
% % fit with custom expression (gaussian with offset)
% expr = 'a1 * exp(-((x - b1) / c1) ^ 2) + d1';
% % a1 ... height of peak (i.e. max. response at best frequency)
% % b1 ... position of center peak (i.e. best frequency)
% % c1 ... width of curve (standard dev.)?
% % d1 ... baseline offset
% fType = fittype(expr);
% 
% % set the fit options with some boundaries and starting points
% fOpt = fitoptions(fType);
% fOpt.Lower = [
%     max(ROIPref) * 0.5      % min height should be above 0
%     min(config.freqIDs)     % min frequency cannot be lower than the freq. list
%     100                     % min width should be at least 100 Hz
%     0                       % min offset can be 0
% ];
% fOpt.Upper = [
%     max(ROIPref) * 1.5      % max height cannot be too high
%     max(config.freqIDs)     % max frequency cannot exceed the freq. list
%     range(config.freqIDs)   % max width cannot exceed the range of the freq. list
%     max(ROIPref) * 0.5      % max offset cannot be too high
% ];
% fOpt.StartPoint = [
%     max(ROIPref)            % start at the highest value
%     mean(config.freqIDs)    % start in the middle of the freq. list
%     1000                    % start with a "sharp" tuning of 1kHz
%     0                       % start with no offset
% ];
% 
% % do the  fitting
% [fObj, GOF] = fit(config.freqIDs', ROIPref', fType, fOpt);
% 
% % get the confidence interval of the fit parameters and store everything
% CI = confint(fObj);
% ROIPrefFitParams{iROI} = struct('fObj', fObj, 'GOF', GOF, ...
%     'width', fObj.c1, 'width_CI', CI(:,3)', 'BS', fObj.b1, 'BS_CI', CI(:,2)', ...
%     'maxEvoked', fObj.a1, 'maxEvoked_CI', CI(:,1)', 'rsquare', GOF.rsquare);

end
