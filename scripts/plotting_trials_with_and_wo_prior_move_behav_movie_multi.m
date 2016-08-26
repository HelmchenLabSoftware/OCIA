
sessInfos = { ...
    '2016_05_11', 'session02_125500', [-1, 1], [18, 22, 215 215];
    '2016_05_11', 'session04_134200', [-1, 1], [18, 22, 215 215];
    };

for iSess = 1 : numel(sessions);

    c;
    
    % init variables related to session
    sessID = sprintf('%s_%s', regexprep(sessInfos{iSess, 1}, '_', ''), sessInfos{iSess, 2});
    
    %% load stuff
%     trialTypes = { 'noisy', 'prior_move', 'no_prior_move', 'quiet_sens', 'delay_move' };
    trialTypes = { 'prior_move', 'no_prior_move', 'delay_move' };
    trialTypesToKeepTrialData = { };
    cropDims = sessInfos{iSess, 4};
    loadingDataForWidefield();

    %% plotting average maps
    cLim = sessInfos{iSess, 3};
    trialTypes = { 'prior_move', 'no_prior_move', 'delay_move' };
%     trialTypes = { 'no_prior_move' };
    
    plotAverageMapsForWidefield();

    %% plotting time courses for each ROI
    % plotTimeCourseForEachROI();

    %% plot single trials for a condition
    % plotSingleTrialsForCondition();

    %% plot average with time course for each condition
    % plotAverageMapWithTimeCourse();

    %% plot single trials with time course for a condition
    % plotTrialMapWithTimeCourse();
    
end;