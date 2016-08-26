
basePath = 'F:\RawData\1601_behav\mou_bl_160105_03\__DAY__\widefield_labview\__SESSION__\Matt_files';
sessInfos = { ...
    '2016_05_11', 'session02_125500', [-1, 1], [-1.4, 1.4], [-3.0 3.0], [18, 22, 215 215], ...
    [6, 7, 13, 29, 28 34, 38], [7, 14, 17, 22, 45, 46, 49, 51], ...
    { [-1.4 1.4], [-0.9 0.9], [-1.6 1.6] }, { [-4.9 3.6], [-4.9 2.1], [-4.9 3.6] };
    
    '2016_05_11', 'session05_140900', [-1, 1], [-1.2, 1.2], [-3.0 3.0], [18, 22, 215 215], ...
    [11, 18], [7, 9, 19, 51], ...
    { [-1.4 1.4], [-0.9 0.9], [-1.2 1.2] }, { [-5.4 3.6], [-5.4 2.1], [-5.4 3.6] };
    
    '2016_05_12', 'session01_104000', [-1, 1], [-1.0, 1.0], [-2.5 2.5], [09, 29, 223 223], ...
    [4, 5, 9, 16, 17, 19, 20], [2, 3, 13, 17, 21, 33, 37, 40, 44, 49, 50, 51], ...
    { [-1.0 1.0], [-0.9 0.9], [-1.0 1.0] }, { [-2.9 1.8], [-4.8 2.1], [-4.8 3.6] };
    
    '2016_05_12', 'session02_111500', [-1, 1], [-1.0, 1.0], [-2.5 2.5], [09, 29, 223 223], ...
    [2, 9, 12, 13, 15, 16, 20, 23, 25, 26, 27, 30], [1, 2, 3, 13, 15, 16, 20, 21, 26, 27, 28, 31, 32, 33, 39, 43, 47, 50], ...
    { [-1.0 1.0], [-0.9 0.9], [-1.0 1.0] }, { [-2.9 1.8], [-4.8 2.1], [-4.8 3.6] };
    
    '2016_05_12', 'session04_121800', [-1, 1], [-1.0, 1.0], [-2.5 2.5], [09, 29, 223 223], ...
    [1, 2, 4, 8, 10, 12, 13, 19, 22], [1, 3, 7, 8, 11, 16, 17, 19, 21, 22, 28, 29, 31, 32, 33, 36, 37, 45, 47, 50, 51, 54], ...
    { [-1.0 1.0], [-0.9 0.9], [-1.0 1.0] }, { [-2.9 1.8], [-4.8 2.1], [-4.8 3.6] };
    
    };

warning('off', 'MATLAB:LargeImage');

% if ~exist('nStructPooled', 'var');
%     nStructPooled = struct();
% end;
% if ~exist('meanStructPooled', 'var');
%     meanStructPooled = struct();
% end;

%%
baseVars = struct2cell(whos);
baseVars = [baseVars(1, :), 'baseVars', 'iSess', 'varsToDelete'];

for iSess = 1 : size(sessInfos, 1);

    close all force;
    
    varsToDelete = struct2cell(whos); varsToDelete = varsToDelete(1, :);
    varsToDelete(ismember(varsToDelete, baseVars)) = [];
    if ~isempty(varsToDelete);
        clear(varsToDelete{:});
    end;
    
    [dayID, sessName, cLimAvgBase, cLimAvgExcl, cLimTrial, cropDims, exclTrials_hit, exclTrials_CR, ...
        cLimsTimeCourseAvgMap, yLimsTimeCourseAvg] = sessInfos{iSess, :};
    sessID = sprintf('%s_%s', regexprep(dayID, '_', ''), regexprep(sessName, 'session', 'S'));
    sessionPath = regexprep(regexprep(basePath, '__DAY__', dayID), '__SESSION__', sessName);    
    cd(sessionPath);
    
    %% load stuff
%     trialTypes = { 'noisy', 'prior_move', 'no_prior_move', 'quiet_sens', 'delay_move' }; %#ok<*NASGU>
%     trialTypes = { 'prior_move', 'no_prior_move', 'delay_move' };  %#ok<*NASGU>
    trialTypes = { 'no_prior_move' }; %#ok<*NASGU>
%     trialTypesToKeepTrialData = { };
    trialTypesToKeepTrialData = { 'no_prior_move' };
    
    nMaxTrialsToLoadPerCondition = Inf;
%     nMaxTrialsToLoadPerCondition = 3;
%     doExclTrials = false;
    doExclTrials = true;
    
    loadingDataForWidefield();
    
    %% plotting average maps
%     trialTypes = { 'prior_move', 'no_prior_move', 'delay_move' };
    trialTypes = { 'no_prior_move' };
%     doSave = false;
    doSave = true;
    cLimAvg = iff(doExclTrials, cLimAvgExcl, cLimAvgBase);
    plotAverageMapsForWidefield();

    %% plotting time courses for each ROI
    % plotTimeCourseForEachROI();

    %% plot single trials for a condition
%     doSave = false;
    doSave = true;
    trialTypes = { 'no_prior_move' };
    plotSingleTrialsForCondition();

    %% plot average with time course for each condition
%     doSave = false;
    doSave = true;
    plotAverageMapWithTimeCourse();

    %% plot single trials with time course for a condition
    % plotTrialMapWithTimeCourse();
    
end;