%% init
load('ROIs.mat');
load('first_move_in_delay.mat');
load('trials_with_and_wo_initial_moves_OCIA_from_movie.mat');
load('move_vectors_from_movie.mat');
load('behaviorVectors.mat');

figProps = { 'NumberTitle', 'off', 'Color', 'white', 'Position', [50 50 1150 880]};
% figProps = { 'NumberTitle', 'off', 'Color', 'white', 'Position', [10 10 1900 1100]};

exportArgsPNG = { '-r500' };

ROIsToPlot = { 'M2', 'S1BC', 'S1FL', 'A1', 'V1', 'PPC' };

caROIs = find(strcmp(ROIs.axeH, 'wf') & ismember(ROIs.ROINames, ROIsToPlot));
ROINames = ROIs.ROINames(caROIs);
[~, ROISortInds] = ismember(ROIsToPlot, ROINames);
nROIs = numel(ROINames);
ROIMasks = ROIs.ROIMasks(caROIs(ROISortInds));
ROINames = ROINames(ROISortInds);

%% get averages for each trial type
% trialTypes = { 'noisy', 'prior_move', 'no_prior_move', 'quiet_sens', 'delay_move' };
% trialTypes = { 'no_prior_move' };
% trialTypes = { 'prior_move', 'no_prior_move', 'delay_move' };

% trialTypesToKeepTrialData = { 'no_prior_move' };
% trialTypesToKeepTrialData = { };

if ~exist('cropDims', 'var');
    cropDims = [0, 0, 256 256]; % no cropping
end;
if ~exist('doExclTrials', 'var');
    doExclTrials = false;
end;

if ~exist('nMaxTrialsToLoadPerCondition', 'var');
    nMaxTrialsToLoadPerCondition = Inf;
end;

if ~exist('sessID', 'var');
    sessID = sprintf('%08d', round(rand * 10000000));
    currPath = pwd;
    nameHits = regexp(currPath, '(?<date>\d{4}_\d{2}_\d{2}).+(?<sess>session\d{2}_\d{6})', 'names');
    if ~isempty(nameHits);
        sessID = sprintf('%s_%s', regexprep(nameHits.date, '_', ''), regexprep(nameHits.sess, 'session', 'S'));
    end;
end;


% conds = { 'CR' };
conds = { 'hit', 'CR' };

nTypes = numel(trialTypes);
nConds = numel(conds);

% only create if not already existing
if ~exist('dataStruct', 'var');
    dataStruct = struct();
end;
% only create if not already existing
if ~exist('meanStruct', 'var');
    meanStruct = struct();
end;
% only create if not already existing
if ~exist('semStruct', 'var');
    semStruct = struct();
end;
% only create if not already existing
if ~exist('nStruct', 'var');
    nStruct = struct();
end;
% only create if not already existing
if ~exist('nPerFrameStruct', 'var');
    nPerFrameStruct = struct();
end;

for iTrialType = 1 : nTypes;
    trialType = trialTypes{iTrialType};
    for iCond = 1 : nConds;
        cond = conds{iCond};
        fieldName = sprintf('%s_%s', cond, trialType);
        
        eval(sprintf('trialIndices = tr_%s;', fieldName));
        eval(sprintf('firstMoveVect = first_move_%s_delay;', cond));
        if doExclTrials;
            eval(sprintf('exclTrials = exclTrials_%s;', cond)); %#ok<*UNRCH>
        else
            exclTrials = [];
        end;
        nTrials = numel(trialIndices);
        
        if isfield(meanStruct, fieldName) && (~(~isempty(trialTypesToKeepTrialData) ...
                && ismember(trialTypesToKeepTrialData, trialType)) || isfield(dataStruct, fieldName));
            fprintf('Average already loaded for %s %s, skipping.\n', cond, trialType);
            continue;
        end;
        
        iTrialLoop = 1;
        for iTrial = trialIndices;
            
            if iTrialLoop > nMaxTrialsToLoadPerCondition; continue; end;
            
            if doExclTrials;
                if ismember(iTrial, exclTrials);
                    fprintf(' Skipping trial %02d / %02d (%02d) for %s %s ...\n', iTrialLoop, nTrials, iTrial, cond, trialType);
                    continue;
                end;
            end;
            
            fprintf(' Loading trial %02d / %02d (%02d) for %s %s ...\n', iTrialLoop, nTrials, iTrial, cond, trialType);
            load(sprintf('cond_%s_trial%d', cond, iTrial));
            
            if exist('cropDims', 'var');
                tr = tr((cropDims(2) + 1) : (cropDims(2) + cropDims(4)), ...
                    (cropDims(1) + 1) : (cropDims(1) + cropDims(3)), :);
                fprintf('   Cropping trial %02d / %02d (%02d) for %s %s ...\n', iTrialLoop, nTrials, iTrial, cond, trialType);
            end;
            
            % store dimensions
            [imgDimX, imgDimY, nFrames] = size(tr);
            
            % init trial and average matrices
            if iTrialLoop == 1;        
                fprintf('  Allocating space for %02d trial(s) for %s %s ...\n', nTrials, cond, trialType);
                dataStruct.(fieldName) = nan([size(tr), nTrials]);
                if ~isfield(meanStruct, fieldName);
                    meanStruct.(fieldName) = zeros(size(tr));
                    nStruct.(fieldName) = 0;
                    nPerFrameStruct.(fieldName) = zeros(1, size(tr, 3));
                end;
            end;
            
            if ~strcmp(trialType, 'delay_move');
                fprintf('   Cutting end at %d for trial %02d / %02d (%02d) for %s %s ...\n', firstMoveVect(iTrial), ...
                    iTrialLoop, nTrials, iTrial, cond, trialType);
                tr(:, :, firstMoveVect(iTrial) : end) = NaN;
            end;
            dataStruct.(fieldName)(:, :, :, iTrialLoop) = 100 * (tr - 1);
            
            if isfield(meanStruct, fieldName) && nStruct.(fieldName) == 0;
                data = dataStruct.(fieldName)(:, :, :, iTrialLoop);
                nPerFrameStruct.(fieldName) = nPerFrameStruct.(fieldName) + reshape(~isnan(data(128, 128, :)), 1, size(tr, 3));
                data(:, :, squeeze(all(all(isnan(data), 1), 2))) = 0;
                meanStruct.(fieldName) = meanStruct.(fieldName) + data;
                
            end;
            
            % clear data
            if ~isempty(trialTypesToKeepTrialData) && ismember(trialTypesToKeepTrialData, trialType);
                fprintf('    Keeping trial %d for %s %s.\n', iTrialLoop, cond, trialType);

            else
                fprintf('    Clearing trial %d for %s %s ...\n', iTrialLoop, cond, trialType);
                dataStruct.(fieldName)(:, :, :, iTrialLoop) = nan(size(dataStruct.(fieldName)(:, :, :, iTrialLoop)));
                fprintf('    Clearing trial %d for %s %s done.\n', iTrialLoop, cond, trialType);

            end;
            
            iTrialLoop = iTrialLoop + 1;
        end;
        
        if ~isfield(meanStruct, fieldName);
            fprintf('Averaging %02d trial(s) for %s %s ...\n', nTrials, cond, trialType);
            nStruct.(fieldName) = size(dataStruct.(fieldName), 4) - numel(exclTrials);
            meanStruct.(fieldName) = nanmean(dataStruct.(fieldName), 4);
            semStruct.(fieldName) = nanstd(dataStruct.(fieldName), [], 4) ./ sqrt(size(dataStruct, 4));
            
        elseif isfield(meanStruct, fieldName) && nStruct.(fieldName) == 0;
            nStruct.(fieldName) = size(dataStruct.(fieldName), 4) - numel(exclTrials);
            meanStruct.(fieldName) = meanStruct.(fieldName) ./ repmat(reshape(nPerFrameStruct.(fieldName), 1, 1, size(meanStruct.(fieldName), 3)), ...
                [size(meanStruct.(fieldName), 1), size(meanStruct.(fieldName), 2), 1]);
            
        end;
        
        % remove empty trials
        dataStruct.(fieldName)(:, :, :, iTrialLoop : end) = [];
        
        % clear data
        if ~isempty(trialTypesToKeepTrialData) && ismember(trialTypesToKeepTrialData, trialType);
            fprintf('Keeping %02d trial(s) for %s %s.\n', nTrials, cond, trialType);
            
        else
            fprintf('Clearing %02d trial(s) for %s %s ...\n', nTrials, cond, trialType);
            dataStruct = rmfield(dataStruct, fieldName);
            fprintf('Clearing %02d trial(s) for %s %s done.\n', nTrials, cond, trialType);
            
        end;
    end;
    fprintf('Trial type %s done.\n\n', trialType);
end;
