% cd W:\Neurophysiology-Storage1\Gilad\Data_per_mouse\mouse_tgg6fl23_8\20151021\b
% cd F:\RawData\1601_behav\mou_bl_160105_03\2016_05_11\widefield_labview\session02_125500\Matt_files

load('behaviorVectors.mat');
[nROIsCa, nTrials_hit, nFramesCa] = size(ROICaData_cond_hit);
[nROIs, nTrials_CR, nFrames] = size(ROIBehavData_cond_CR);

paramsMat = load('params.mat');
behavFrameRate = paramsMat.params.behavFrameRate;

figProps = { 'NumberTitle', 'off', 'Color', 'white', 'Position', [50 50 1150 880]};
% figProps = { 'NumberTitle', 'off', 'Color', 'white', 'Position', [10 10 1900 1100]};
xLims = [-3.1, 7.1];

doSavePlots = true;
% doSavePlots = false;
doSaveVars = true;
% doSaveVars = false;
plotPath = 'moveVectorPlots';
if exist(plotPath, 'dir') ~=7; mkdir(plotPath); end;

if ~exist('sessID', 'var');
    sessID = sprintf('%08d', round(rand * 10000000));
    currPath = pwd;
    nameHits = regexp(currPath, '(?<date>\d{4}_\d{2}_\d{2}).+(?<sess>session\d{2}_\d{6})', 'names');
    if ~isempty(nameHits);
        sessID = sprintf('%s_%s', regexprep(nameHits.date, '_', ''), regexprep(nameHits.sess, 'session', 'S'));
    end;
end;

%% definitions of threshold and time periods
F2FCorrThresh = 0.02;
baseT   = [-2.65 -2.35];  % time period of baseline
stimT   = [-1.00  2.00];  % time period of stimulus and prestimulus
delayT  = [ 2.20  3.00];  % time period of quiet delay
% moveThreshT = 0.65; % duration threshold in seconds for movement during sensation
moveThreshT = 0.45; % duration threshold in seconds for movement during sensation

%% create body vector
bodyROINames = { 'behavLimbs', 'behavBack' }; nBodyROINames = numel(bodyROINames);

ROIBehavData_cond_CR(end + 1, : ,:) = nanmean(ROIBehavData_cond_CR(ismember(behavROINames, bodyROINames), :, :), 1);
ROIBehavData_cond_hit(end + 1, : ,:) = nanmean(ROIBehavData_cond_hit(ismember(behavROINames, bodyROINames), :, :), 1);

behavROIMasks{end + 1} = any(reshape(cell2mat(behavROIMasks(ismember(behavROINames, bodyROINames))), ...
    [size(behavROIMasks{1}), nBodyROINames]), 3);
behavROINames{end + 1} = 'body';
nROIs = nROIs + 1;

%% overview - each trial
%{
close all;
figHs = zeros(nROIs, 1);
for iROI = 1 : nROIs;
    figHs(iROI) = figure('Name', sprintf('Overview F2F corr for %s - each trial', behavROINames{iROI}), figProps{:});
    hold('on');
    
    for iTrial = 1 : nTrials_hit; 
        hHit = plot(tBehav, smooth(squeeze(ROIBehavData_cond_hit(iROI, iTrial, :)), 5,'Gauss'), 'r--');
    end;
    for iTrial = 1 : nTrials_CR; 
        hCR = plot(tBehav, smooth(squeeze(ROIBehavData_cond_CR(iROI, iTrial, :)), 5,'Gauss'), 'k');
    end;
    
    hold('off');
    xlim(xLims);
    ylim([-0.03, 0.4]);
    xlabel('Time [s]');
    ylabel('Frame-to-frame correlation');
    title(behavROINames{iROI});
    legend([hHit, hCR], { 'hit', 'CR' }, 'Location', 'NorthWest');
    
    if doSavePlots;
        export_fig(sprintf('%s/overview_F2FCorrs_allTrials_%s.png', plotPath, behavROINames{iROI}), '-r200', figHs(iROI));
    end;
    
end;
tilefigs(figHs);
%}

%% overview - shaded error bars
%{
close all;
figHs = zeros(nROIs, 1);
for iROI = 1 : nROIs;
    
    figHs(iROI) = figure('Name', sprintf('Overview F2F corr for %s - errorbar', behavROINames{iROI}), figProps{:});
    hold('on');
    
    hHit = shadedErrorBar(tBehav, smooth(squeeze(nanmean(ROIBehavData_cond_hit(iROI, :, :), 2)), 5, 'Gauss'), ...
        squeeze(nansem(squeeze(ROIBehavData_cond_hit(iROI, :, :)), 1)), 'r--', 1, figHs(iROI), gca);
    hCR = shadedErrorBar(tBehav, smooth(squeeze(nanmean(ROIBehavData_cond_CR(iROI, :, :), 2)), 5, 'Gauss'), ...
        squeeze(nansem(squeeze(ROIBehavData_cond_CR(iROI, :, :)), 1)), 'k', 1, figHs(iROI), gca);
    
    hold('off');
    xlim(xLims);
    ylim([-0.01, 0.15]);
    title(behavROINames{iROI});
    xlabel('Time [s]');
    ylabel('Frame-to-frame corr. \pm SEM');
    legend([hHit.mainLine, hCR.mainLine], { 'hit', 'CR' }, 'Location', 'NorthWest');
    
    if doSavePlots;
        export_fig(sprintf('%s/overview_F2FCorrs_shadedErrorBars_%s.png', plotPath, behavROINames{iROI}), '-r200', figHs(iROI));
    end;
    
end;
tilefigs(figHs);
%}

%% define threshold
ROIBody_hit = squeeze(ROIBehavData_cond_hit(end, :, :))';
ROIBody_CR = squeeze(ROIBehavData_cond_CR(end, :, :))';

ROIBodySmoothed_hit = zeros(size(ROIBody_hit));
ROIBodySmoothed_CR = zeros(size(ROIBody_CR));
for iTrial = 1 : nTrials_hit;
    ROIBodySmoothed_hit(:, iTrial) = smooth(ROIBody_hit(:, iTrial), 9, 'Gauss');
end
for iTrial = 1 : nTrials_CR;
    ROIBodySmoothed_CR(:, iTrial) = smooth(ROIBody_CR(:, iTrial), 9, 'Gauss');
end

%{
iPlot = 1;
plotProb = 0.3;
nTrialsMax = max(nTrials_hit, nTrials_CR);
nTrialsExp = ceil(nTrialsMax * plotProb);
M = ceil(sqrt(nTrialsExp)); N = iff((M * (M - 1)) >= nTrialsExp, M - 1, M);
figure('Name', 'Threshold check', figProps{:});
for iTrial = 1 : nTrialsMax;
    if rand(1) >= plotProb; continue; end;
    
    subplot(M, N, iPlot);
    hold('on');
    if iTrial <= nTrials_hit; plot(tBehav, ROIBodySmoothed_hit(:, iTrial), 'r--'); end;
    if iTrial <= nTrials_CR; plot(tBehav, ROIBodySmoothed_CR(:, iTrial), 'k'); end;
    plot(tBehav([1 end]), F2FCorrThresh * ones(1, 2), 'k--');
    hold('off');
    
    xlim(xLims);
    ylim([-0.01, 0.2]);
    title(sprintf('Trial %02d', iTrial));
    
    iPlot = iPlot + 1;
    if iPlot > nTrialsExp; break; end;
end
    
if doSavePlots;
    export_fig(sprintf('%s/exampleTrials_F2FCorr_thresholds_bodyVectorSmoothed.png', plotPath), '-r200', gcf);
end;
%}

%% calculate move vectors from body trace
moveVect_hit = ROIBodySmoothed_hit > F2FCorrThresh;
moveVect_CR = ROIBodySmoothed_CR > F2FCorrThresh;

nMinFramesMove = 5;
nMinGapBetweenMoves = 5;
% clean up move vectors
conds = { 'hit', 'CR' };
for iCond = 1 : numel(conds);
    cond = conds{iCond};
    eval(sprintf('nTrials = nTrials_%s;', cond));
    for iTrial = 1 : nTrials;
        eval(sprintf('moveVect = moveVect_%s(:, iTrial);', cond));
        moveVect = cleanMoveVect(moveVect, nMinFramesMove, nMinGapBetweenMoves);
        eval(sprintf('moveVect_%s(:, iTrial) = moveVect;', cond));
    end;
end;

%{
iPlot = 1;
plotProb = 0.3;
nTrialsMax = max(nTrials_hit, nTrials_CR);
nTrialsExp = ceil(nTrialsMax * plotProb);
M = ceil(sqrt(nTrialsExp)); N = iff((M * (M - 1)) >= nTrialsExp, M - 1, M);
figure('Name', 'Threshold check', figProps{:});
for iTrial = 1 : nTrialsMax;
    if rand(1) >= plotProb; continue; end;
    
    subplot(M, N, iPlot);
    hold('on');
    if iTrial <= nTrials_hit; plot(tBehav, moveVect_hit(:, iTrial), 'r--'); end;
    if iTrial <= nTrials_CR; plot(tBehav, moveVect_CR(:, iTrial), 'k'); end;
    hold('off');
    
    xlim(xLims);
    ylim([-0.05, 1.05]);
    title(sprintf('Trial %02d', iTrial));
    
    iPlot = iPlot + 1;
    if iPlot > nTrialsExp; break; end;
end
    
if doSavePlots;
    export_fig(sprintf('%s/exampleTrials_thresholds_moveVector.png', plotPath), '-r200', gcf);
end;
%}

if doSaveVars;
    save('move_vectors_from_movie.mat', 'moveVect_hit', 'moveVect_CR', 'F2FCorrThresh');
end;

%% plot move vector - shaded error bars
%{
close all;
figH = figure('Name', 'Overview move vector - errorbar', figProps{:});
hold('on');
hHit = shadedErrorBar(tBehav, nanmean(moveVect_hit, 2), nansem(moveVect_hit, 2), 'r--', 1, figH, gca);
hCR = shadedErrorBar(tBehav, nanmean(moveVect_CR, 2), nansem(moveVect_CR, 2), 'k', 1, figH, gca);
hold('off');
xlim(xLims);
ylim([-0.05, 1.05]);
title('Move probability');
xlabel('Time [s]');
ylabel('Move probability \pm SEM');
legend([hHit.mainLine, hCR.mainLine], { 'hit', 'CR' }, 'Location', 'NorthWest');

if doSavePlots;
    export_fig(sprintf('%s/average_moveVector_shadedErrorBars.png', plotPath), '-r200', figH);
end;
%}

%% define move vector time/frame constraints
% convert to frames
frameOffSet = round(paramsMat.params.WFTimeOffset * behavFrameRate);
baseFrames = (round(behavFrameRate * baseT(1)) : round(behavFrameRate * baseT(2))) + frameOffSet;
stimFrames = (round(behavFrameRate * stimT(1)) : round(behavFrameRate * stimT(2))) + frameOffSet;
delayFrames = (round(behavFrameRate * delayT(1)) : round(behavFrameRate * delayT(2))) + frameOffSet;
moveThresh = round(moveThreshT * behavFrameRate);     

%% classify trials
% variables for trial indices
tr_hit_noisy = [];
tr_hit_prior_move = [];
tr_hit_no_prior_move = [];
tr_hit_quiet_sens = [];
tr_hit_quiet_then_move = [];
tr_types_hit = cell(nTrials_hit, 1);

% go through hit trials
for iTrial = 1 : nTrials_hit;
    % if there is any movement during baseline, mark as noisy trial (because of baseline problems)
    if any(moveVect_hit(baseFrames, iTrial));
        tr_hit_noisy(end + 1) = iTrial; %#ok<SAGROW>
        tr_types_hit{iTrial} = 'noisy';
        
    % if there is movement exceed threshold during stimulus
    elseif sum(moveVect_hit(stimFrames, iTrial)) > moveThresh;
        % if there is no movement during delay, mark as "prior_move" trial (quiet delay but *not* quiet before)
        if ~any(moveVect_hit(delayFrames, iTrial));
            tr_hit_prior_move(end + 1) = iTrial; %#ok<SAGROW>
            tr_types_hit{iTrial} = 'prior_move';
        
        else
            tr_types_hit{iTrial} = 'delay_move';
            
        end;
        
    % if movement does not exceed threshold during stimulus
    else
        % mark as "quiet_sens" trial (quiet during sensation event there is movment during delay
        tr_hit_quiet_sens(end + 1) = iTrial; %#ok<SAGROW>
        
        % if there is no movement during delay, mark as "no_prior_move" trial (quiet delay *and* quiet before)
        if ~any(moveVect_hit(delayFrames, iTrial));
            tr_hit_no_prior_move(end + 1) = iTrial; %#ok<SAGROW>
            tr_types_hit{iTrial} = 'no_prior_move';
        else
            tr_hit_quiet_then_move(end + 1) = iTrial; %#ok<SAGROW>
            tr_types_hit{iTrial} = 'quiet_then_move';
        end;
    end;
end;      

% variables for trial indices
tr_CR_noisy = [];
tr_CR_prior_move = [];
tr_CR_no_prior_move = [];
tr_CR_quiet_sens = [];
tr_CR_quiet_then_move = [];
tr_types_CR = cell(nTrials_CR, 1);

% go through CR trials
for iTrial = 1 : nTrials_CR;
    % if there is any movement during baseline, mark as noisy trial (because of baseline problems)
    if any(moveVect_CR(baseFrames, iTrial));
        tr_CR_noisy(end + 1) = iTrial; %#ok<SAGROW>
        tr_types_CR{iTrial} = 'noisy';
        
    % if there is movement exceed threshold during stimulus
    elseif sum(moveVect_CR(stimFrames, iTrial)) > moveThresh;
        % if there is no movement during delay, mark as "prior_move" trial (quiet delay but *not* quiet before)
        if ~any(moveVect_CR(delayFrames, iTrial));
            tr_CR_prior_move(end + 1) = iTrial; %#ok<SAGROW>
            tr_types_CR{iTrial} = 'prior_move';
        
        else
            tr_types_CR{iTrial} = 'delay_move';
            
        end;
        
        
    % if movement does not exceed threshold during stimulus
    else
        % mark as "quiet_sens" trial (quiet during sensation event there is movment during delay
        tr_CR_quiet_sens(end + 1) = iTrial; %#ok<SAGROW>
        
        % if there is no movement during delay, mark as "no_prior_move" trial (quiet delay *and* quiet before)
        if ~any(moveVect_CR(delayFrames, iTrial));
            tr_CR_no_prior_move(end + 1) = iTrial; %#ok<SAGROW>
            tr_types_CR{iTrial} = 'no_prior_move';
        else
            tr_CR_quiet_then_move(end + 1) = iTrial; %#ok<SAGROW>
            tr_types_CR{iTrial} = 'quiet_then_move';
        end;
    end;
end;

% find movement trials
tr_CR_delay_move = find(any(moveVect_CR(delayFrames, :)));
tr_hit_delay_move = find(any(moveVect_hit(delayFrames, :)));

if doSaveVars;
    save('trials_with_and_wo_initial_moves_OCIA_from_movie', 'tr_*');
end;

%% plot move vectors
% %{
close all

% trialTypes = unique([tr_types_CR; tr_types_hit]);
trialTypes = { 'delay_move', 'no_prior_move', 'prior_move' };
nTrialPerType_CR = cellfun(@(typ) sum(strcmp(tr_types_CR, typ)), trialTypes);
nTrialPerType_hit = cellfun(@(typ) sum(strcmp(tr_types_hit, typ)), trialTypes);

for iTrialType = 1 : numel(trialTypes);
    trialType = trialTypes{iTrialType};
    
    figure('Name', sprintf('Move vectors %s - %s', trialType, sessID), figProps{:});
    conds = { 'hit', 'CR' };
        
    eval(sprintf('trialInds_hit = tr_hit_%s;', trialType));
    eval(sprintf('trialInds_CR = tr_CR_%s;', trialType));
    
%     nTrialsMax = max(numel(trialInds_hit), numel(trialInds_CR));
    nTrialsMax = max([nTrialPerType_CR, nTrialPerType_hit]);

    botPad = 0.12; leftPad = 0.07; topPad = 0.09; rightPad = 0.01;
    xPad = 0.03; yPad = 0.02;
    W = (1 - leftPad - rightPad - 1 * xPad) / 2;
    H = (1 - botPad - topPad - (nTrialsMax - 1) * yPad) / nTrialsMax;
    if H < 0; H = 0.1; end;
    xPos = leftPad; yPos = 1 - H - topPad;

    for iCond = 1 : numel(conds);
        cond = conds{iCond};
        iPlot = iff(strcmp(cond, 'hit'), 1, 2);
        
        eval(sprintf('trialInds = trialInds_%s;', cond));
        eval(sprintf('moveVect = moveVect_%s(:, trialInds);', cond));
        nTrials = numel(trialInds);

        for iTrial = 1 : nTrials;
            subplot('position', [xPos, yPos, W, H]);
            
            hold('on');
            plot(tBehav, moveVect(:, iTrial), iff(strcmp(cond, 'hit'), 'g', 'r'), 'LineWidth', 2);
            
            plot([baseT(1) baseT(1)], [-1000 1000], '-', 'LineWidth', 0.5, 'Color', 0.2 * ones(3, 1));
            plot([baseT(2) baseT(2)], [-1000 1000], '-', 'LineWidth', 0.5, 'Color', 0.2 * ones(3, 1));
            
            plot([stimT(1) stimT(1)], [-1000 1000], '-', 'LineWidth', 0.5, 'Color', 0.2 * ones(3, 1));
            plot([stimT(2) stimT(2)], [-1000 1000], '-', 'LineWidth', 0.5, 'Color', 0.2 * ones(3, 1));
            
            plot([delayT(1) delayT(1)], [-1000 1000], '-', 'LineWidth', 0.5, 'Color', 0.2 * ones(3, 1));
            plot([delayT(2) delayT(2)], [-1000 1000], '-', 'LineWidth', 0.5, 'Color', 0.2 * ones(3, 1));
            hold('off');

            set(gca, 'YTick', [], 'YColor', 'white', 'FontSize', 20);
            if iTrial ~= nTrials;
                set(gca, 'XTick', [], 'XColor', 'white');
            else
                xlabel('Time [s]', 'FontSize', 30);
            end;
            
            if iCond == 1 && iTrial == round(nTrialsMax * 0.5);
                text(tBehav(1) - 0.3, 0, regexprep(trialType, '_', ' '), 'FontSize', 50, 'Rotation', 90, ...
                    'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
                
            elseif iCond == 1 && nTrials < round(nTrialsMax * 0.5) && iTrial == round(nTrials * 0.5);
                text(tBehav(1) - 0.5, 0, regexprep(trialType, '_', ' '), 'FontSize', 40, 'Rotation', 90, ...
                    'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
                
            end;
            
            text(tBehav(1) + 0.2, 0.1, sprintf('%03d', trialInds(iTrial)), ...
                'Color', iff(strcmp(cond, 'hit'), 'green', 'red'), 'FontSize', 15, ...
                'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom');
            
            if iTrial == 1;
                text(tBehav(1) + (tBehav(end) - tBehav(1)) * 0.5, 1, regexprep(cond, '_', ' '), ...
                    'Color', iff(strcmp(cond, 'hit'), 'green', 'red'), 'FontSize', 50, ...
                    'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
            end;

            xlim(xLims);
            ylim([-0.05, 1.05]);
            
            yPos = yPos - H - yPad;
        end
        
        xPos = xPos + W + xPad;
        yPos = 1 - H - topPad;
        
    end;
    
    if doSavePlots;
        export_fig(sprintf('%s/%s_moveVectors_%s.png', plotPath, sessID, trialType), '-r200', gcf);
    end;
end;
%}

%% plot move vectors probability
% %{
close all

% trialTypes = unique([tr_types_CR; tr_types_hit]);
trialTypes = { 'delay_move', 'no_prior_move', 'prior_move' };
nTrialPerType_CR = cellfun(@(typ) sum(strcmp(tr_types_CR, typ)), trialTypes);
nTrialPerType_hit = cellfun(@(typ) sum(strcmp(tr_types_hit, typ)), trialTypes);
    
figure('Name', sprintf('Move vectors probability - %s', sessID), figProps{:}, 'Position', [60 425 1815 480]);

botPad = 0.25; leftPad = 0.07; topPad = 0.15; rightPad = 0.01;
xPad = 0.05; yPad = 0.00;
W = (1 - leftPad - rightPad - (numel(trialTypes) - 1) * xPad) / numel(trialTypes);
H = (1 - botPad - topPad - 0 * yPad) / 1;
xPos = leftPad; yPos = 1 - H - topPad;

for iTrialType = 1 : numel(trialTypes);
    trialType = trialTypes{iTrialType};
    conds = { 'hit', 'CR' };
        
    eval(sprintf('trialInds_hit = tr_hit_%s;', trialType));
    eval(sprintf('trialInds_CR = tr_CR_%s;', trialType));

    subplot('position', [xPos, yPos, W, H]);
    hConds = [];

    for iCond = 1 : numel(conds);
        cond = conds{iCond};
        iPlot = iff(strcmp(cond, 'hit'), 1, 2);
        
        eval(sprintf('trialInds = trialInds_%s;', cond));
        eval(sprintf('moveVect = moveVect_%s(:, trialInds);', cond));
        nTrials = numel(trialInds);
        
        moveVectAvg = nanmean(moveVect, 2);

        hold('on');
        hConds(iCond) = stairs(tBehav, sgolayfilt(moveVectAvg, 1, 3), iff(strcmp(cond, 'hit'), 'g', 'r'), 'LineWidth', 3);

        plot([baseT(1) baseT(1)], [-1000 1000], '-', 'LineWidth', 0.5, 'Color', 0.2 * ones(3, 1));
        plot([baseT(2) baseT(2)], [-1000 1000], '-', 'LineWidth', 0.5, 'Color', 0.2 * ones(3, 1));

        plot([stimT(1) stimT(1)], [-1000 1000], '-', 'LineWidth', 0.5, 'Color', 0.2 * ones(3, 1));
        plot([stimT(2) stimT(2)], [-1000 1000], '-', 'LineWidth', 0.5, 'Color', 0.2 * ones(3, 1));

        plot([delayT(1) delayT(1)], [-1000 1000], '-', 'LineWidth', 0.5, 'Color', 0.2 * ones(3, 1));
        plot([delayT(2) delayT(2)], [-1000 1000], '-', 'LineWidth', 0.5, 'Color', 0.2 * ones(3, 1));
        hold('off');
        
        set(gca, 'FontSize', 25);
        if iTrialType == 2;
            xlabel('Time [s]', 'FontSize', 40);
        end;
        if iTrialType == 1;
            ylabel('Move probability', 'FontSize', 40);
        end;
        title(regexprep(trialType, '_', ' '), 'FontSize', 40);

        xlim(xLims);
        ylim([-0.05, 1.05]);
        
    end;
    
    condsWithNTrials = conds;
    legend(hConds, condsWithNTrials, 'FontSize', 30, 'Location', 'NorthWest');
        
    xPos = xPos + W + xPad;
end;
    
if doSavePlots;
    export_fig(sprintf('%s/%s_moveVectorsProbability.png', plotPath, sessID), '-r200', gcf);
end;
%}

%% plot classified move vector - shaded error bars
%{
trialTypes = { 'noisy', 'prior_move', 'no_prior_move', 'quiet_sens', 'delay_move' };
nTypes = numel(trialTypes);

close all;

figHs = zeros(nTypes, 1);
for iTrialType = 1 : nTypes;
    trialType = trialTypes{iTrialType};
    figHs(iTrialType) = figure('Name', sprintf('Overview move vector %s - errorbar', trialType), figProps{:});
    
    % get trials for the current type
    eval(sprintf('moveVectForType_hit = moveVect_hit(:, tr_hit_%s);', trialType));
    eval(sprintf('moveVectForType_CR = moveVect_CR(:, tr_CR_%s);', trialType));
    
    hold('on');
    hHit = shadedErrorBar(tBehav, nanmean(moveVectForType_hit, 2), nansem(moveVectForType_hit, 2), ...
        'r--', 1, figHs(iTrialType), gca);
    hCR = shadedErrorBar(tBehav, nanmean(moveVectForType_CR, 2), nansem(moveVectForType_CR, 2), ...
        'k', 1, figHs(iTrialType), gca);
    hold('off');
    
    xlim(xLims);
    ylim([-0.05, 1.05]);
    title(sprintf('Move probability N_{hit} = %02d, N_{CR} = %02d', ...
        size(moveVectForType_hit, 2), size(moveVectForType_CR, 2)));
    xlabel('Time [s]');
    ylabel('Move probability \pm SEM');
    legend([hHit.mainLine, hCR.mainLine], { 'hit', 'CR' }, 'Location', 'NorthWest');
    
    if doSavePlots;
        export_fig(sprintf('%s/overview_moveVector_shadedErrorBars_%s.png', plotPath, trialType), '-r200', figHs(iTrialType));
    end;

end;

tilefigs(figHs);
%}

%% plot classified move vector - each trial
%{
trialTypes = { 'noisy', 'prior_move', 'no_prior_move', 'quiet_sens', 'delay_move' };
nTypes = numel(trialTypes);

close all;

figHs = zeros(nTypes, 1);
for iTrialType = 1 : nTypes;
    trialType = trialTypes{iTrialType};
    
    % get trials for the current type
    eval(sprintf('moveVectForType_hit = moveVect_hit(:, tr_hit_%s);', trialType));
    eval(sprintf('moveVectForType_CR = moveVect_CR(:, tr_CR_%s);', trialType));
    
    nTrialsForType_hit = size(moveVectForType_hit, 2);
    nTrialsForType_CR = size(moveVectForType_CR, 2);
    
    iPlot = 1;
    plotProb = 1;
    nTrialsMax = max(nTrialsForType_hit, nTrialsForType_CR);
    nTrialsExp = ceil(nTrialsMax * plotProb);
    M = ceil(sqrt(nTrialsExp)); N = iff((M * (M - 1)) >= nTrialsExp, M - 1, M);
    figHs(iTrialType) = figure('Name', sprintf('Trial check %s', trialType), figProps{:});
    for iTrial = 1 : nTrialsMax;
        if rand(1) >= plotProb; continue; end;

        subplot(M, N, iPlot);
        hold('on');
        if iTrial <= nTrialsForType_hit; plot(tBehav, moveVectForType_hit(:, iTrial), 'r--'); end;
        if iTrial <= nTrialsForType_CR; plot(tBehav, moveVectForType_CR(:, iTrial), 'k'); end;
        hold('off');

        xlim(xLims);
        ylim([-0.05, 1.05]);
        title(sprintf('Trial %02d', iTrial));

        iPlot = iPlot + 1;
        if iPlot > nTrialsExp; break; end;
    end
    
    if doSavePlots;
        export_fig(sprintf('%s/overview_moveVector_allTrials_%s.png', plotPath, trialType), '-r200', figHs(iTrialType));
    end;

end;

tilefigs(figHs);
%}

%% find the first movement during delay in the movement trials
% use a constant frame offset for getting the "real" first move and not the one from threshold
firstMoveFrameOffset = 7;
% store the first move frame
first_move_hit_delay = nan(1, nTrials_hit);
first_move_hit_delay_movie = nan(1, nTrials_hit);
% go through all hit trials
for iTrial = 1 : nTrials_hit;
    % find first movement within the delay period
    firstMoveFrame = find(moveVect_hit(delayFrames(1) : end, iTrial), 1) + delayFrames(1) - 1;
    % if a movement was found, mark it
    if ~isempty(firstMoveFrame);
        % find the movement frame in the calcium imaging's time frame
        firstMoveFrameCaTime = find(abs(tBehav(firstMoveFrame - firstMoveFrameOffset) - tCa) == min(abs(tBehav(firstMoveFrame - firstMoveFrameOffset) - tCa)));
        first_move_hit_delay(iTrial) = firstMoveFrameCaTime;
        first_move_hit_delay_movie(iTrial) = firstMoveFrame - firstMoveFrameOffset;
        
    % if no movement found, use last frame
    else
        first_move_hit_delay(iTrial) = nFramesCa;
        first_move_hit_delay_movie(iTrial) = nFramesCa;
    end
end

% store the first move frame
first_move_CR_delay = nan(1, nTrials_CR);
first_move_CR_delay_movie = nan(1, nTrials_CR);
% go through all CR trials
for iTrial = 1 : nTrials_CR;
    % find first movement within the delay period
    firstMoveFrame = find(moveVect_CR(delayFrames(1) : end, iTrial), 1) + delayFrames(1) - 1;
    % if a movement was found, mark it
    if ~isempty(firstMoveFrame);
        % find the movement frame in the calcium imaging's time frame
        firstMoveFrameCaTime = find(abs(tBehav(firstMoveFrame - firstMoveFrameOffset) - tCa) == min(abs(tBehav(firstMoveFrame - firstMoveFrameOffset) - tCa)));
        first_move_CR_delay(iTrial) = firstMoveFrameCaTime;
        first_move_CR_delay_movie(iTrial) = firstMoveFrame - firstMoveFrameOffset;
        
    % if no movement found, use last frame
    else
        first_move_CR_delay(iTrial) = nFramesCa;
        first_move_CR_delay_movie(iTrial) = nFramesCa;
    end
end

if doSaveVars;
    save('first_move_in_delay.mat', 'first_move_*');
end;

%% cut the body vectors until the first move
ROIBody_CR_cut = nan(size(ROIBody_CR));
for iTrial = 1 : nTrials_CR;
    ROIBody_CR_cut(1 : first_move_CR_delay_movie(iTrial), iTrial) = ROIBody_CR(1 : first_move_CR_delay_movie(iTrial), iTrial);    
end
ROIBody_hit_cut = nan(size(ROIBody_hit));
for iTrial = 1 : nTrials_hit;
    ROIBody_hit_cut(1 : first_move_hit_delay_movie(iTrial), iTrial) = ROIBody_hit(1 : first_move_hit_delay_movie(iTrial), iTrial);    
end

moveVect_CR_cut = zeros(size(moveVect_CR));
for iTrial = 1 : nTrials_CR;
    moveVect_CR_cut(1 : first_move_CR_delay_movie(iTrial), iTrial) = moveVect_CR(1 : first_move_CR_delay_movie(iTrial), iTrial);    
end
moveVect_hit_cut = zeros(size(moveVect_hit));
for iTrial = 1 : nTrials_hit;
    moveVect_hit_cut(1 : first_move_hit_delay_movie(iTrial), iTrial) = moveVect_hit(1 : first_move_hit_delay_movie(iTrial), iTrial);    
end

%% plot move vectors probability cut
% %{
close all

% trialTypes = unique([tr_types_CR; tr_types_hit]);
trialTypes = { 'delay_move', 'no_prior_move', 'prior_move' };
nTrialPerType_CR = cellfun(@(typ) sum(strcmp(tr_types_CR, typ)), trialTypes);
nTrialPerType_hit = cellfun(@(typ) sum(strcmp(tr_types_hit, typ)), trialTypes);
    
figure('Name', sprintf('Move vectors probability cut - %s', sessID), figProps{:}, 'Position', [60 425 1815 480]);

botPad = 0.25; leftPad = 0.07; topPad = 0.15; rightPad = 0.01;
xPad = 0.05; yPad = 0.00;
W = (1 - leftPad - rightPad - (numel(trialTypes) - 1) * xPad) / numel(trialTypes);
H = (1 - botPad - topPad - 0 * yPad) / 1;
xPos = leftPad; yPos = 1 - H - topPad;

for iTrialType = 1 : numel(trialTypes);
    trialType = trialTypes{iTrialType};
    conds = { 'hit', 'CR' };
        
    eval(sprintf('trialInds_hit = tr_hit_%s;', trialType));
    eval(sprintf('trialInds_CR = tr_CR_%s;', trialType));

    subplot('position', [xPos, yPos, W, H]);
    hConds = [];

    for iCond = 1 : numel(conds);
        cond = conds{iCond};
        iPlot = iff(strcmp(cond, 'hit'), 1, 2);
        
        eval(sprintf('trialInds = trialInds_%s;', cond));
        eval(sprintf('moveVect = moveVect_%s_cut(:, trialInds);', cond));
        nTrials = numel(trialInds);
        
        moveVectAvg = nanmean(moveVect, 2);

        hold('on');
        hConds(iCond) = stairs(tBehav, sgolayfilt(moveVectAvg, 1, 3), iff(strcmp(cond, 'hit'), 'g', 'r'), 'LineWidth', 3);

        plot([baseT(1) baseT(1)], [-1000 1000], '-', 'LineWidth', 0.5, 'Color', 0.2 * ones(3, 1));
        plot([baseT(2) baseT(2)], [-1000 1000], '-', 'LineWidth', 0.5, 'Color', 0.2 * ones(3, 1));

        plot([stimT(1) stimT(1)], [-1000 1000], '-', 'LineWidth', 0.5, 'Color', 0.2 * ones(3, 1));
        plot([stimT(2) stimT(2)], [-1000 1000], '-', 'LineWidth', 0.5, 'Color', 0.2 * ones(3, 1));

        plot([delayT(1) delayT(1)], [-1000 1000], '-', 'LineWidth', 0.5, 'Color', 0.2 * ones(3, 1));
        plot([delayT(2) delayT(2)], [-1000 1000], '-', 'LineWidth', 0.5, 'Color', 0.2 * ones(3, 1));
        hold('off');
        
        set(gca, 'FontSize', 25);
        if iTrialType == 2;
            xlabel('Time [s]', 'FontSize', 40);
        end;
        if iTrialType == 1;
            ylabel('Move probability', 'FontSize', 40);
        end;
        title(regexprep(trialType, '_', ' '), 'FontSize', 40);

        xlim(xLims);
        ylim([-0.05, 1.05]);
        
    end;
    
    condsWithNTrials = conds;
    legend(hConds, condsWithNTrials, 'FontSize', 30, 'Location', 'NorthWest');
        
    xPos = xPos + W + xPad;
end;
    
if doSavePlots;
    export_fig(sprintf('%s/%s_moveVectorsProbability_cut.png', plotPath, sessID), '-r200', gcf);
end;
%}

%% plot the cut body vectors - shaded error bars
%{
trialTypes = { 'noisy', 'prior_move', 'no_prior_move', 'quiet_sens', 'delay_move' };
nTypes = numel(trialTypes);

close all;

figHs = zeros(nTypes, 1);
for iTrialType = 1 : nTypes;
    trialType = trialTypes{iTrialType};
    figHs(iTrialType) = figure('Name', sprintf('Overview ROI body cut %s - errorbar', trialType), figProps{:});
    
    % get trials for the current type
    eval(sprintf('ROIBodyCutForType_hit = ROIBody_hit_cut(:, tr_hit_%s);', trialType));
    eval(sprintf('ROIBodyCutForType_CR = ROIBody_CR_cut(:, tr_CR_%s);', trialType));
    
    hold('on');
    hHit = shadedErrorBar(tBehav, nanmean(ROIBodyCutForType_hit, 2), nansem(ROIBodyCutForType_hit, 2), ...
        'r--', 1, figHs(iTrialType), gca);
    hCR = shadedErrorBar(tBehav, nanmean(ROIBodyCutForType_CR, 2), nansem(ROIBodyCutForType_CR, 2), ...
        'k', 1, figHs(iTrialType), gca);
    hold('off');
    
    xlim(xLims);
    ylim([-0.01, 0.21]);
    title(sprintf('Move probability N_{hit} = %02d, N_{CR} = %02d', ...
        size(ROIBodyCutForType_hit, 2), size(ROIBodyCutForType_CR, 2)));
    xlabel('Time [s]');
    ylabel('Frame-to-frame correlation \pm SEM');
    legend([hHit.mainLine, hCR.mainLine], { 'hit', 'CR' }, 'Location', 'NorthWest');
    
    if doSavePlots;
        export_fig(sprintf('%s/overview_moveVectorCut_shadedErrorBars_%s.png', plotPath, trialType), '-r200', figHs(iTrialType));
    end;

end;

tilefigs(figHs);
%}

%% plot the ratios of trial types for hit and CR
nCleanTrials_CR = nTrials_CR - size(tr_CR_noisy, 2);
nCleanTrials_hit = nTrials_hit - size(tr_hit_noisy, 2);

ratios_CR = 100 * [
    (nCleanTrials_CR - size(tr_CR_no_prior_move,2) - size(tr_CR_prior_move,2)) / nCleanTrials_CR, ...
    size(tr_CR_prior_move, 2) / nCleanTrials_CR, ...
    size(tr_CR_no_prior_move, 2) / nCleanTrials_CR
    ]; 
ratios_hit = 100 * [
    (nCleanTrials_hit - size(tr_hit_no_prior_move,2) - size(tr_hit_prior_move, 2)) / nCleanTrials_hit, ...
    size(tr_hit_prior_move, 2)/ nCleanTrials_hit, ...
    size(tr_hit_no_prior_move, 2)/nCleanTrials_hit
    ]; 

%{
close all;

figHs = zeros(2, 1);
figHs(1) = figure('Name', 'Ratios of trial types', figProps{:});
bar([ratios_hit; ratios_CR], 'stacked');
set(gca, 'XTickLabel', { 'hit', 'CR' });
xlabel('Condition'); ylabel('Trial fraction [%]');
legend('moving in delay', 'prior move', 'no prior move');

if doSavePlots;
%     export_fig(sprintf('%s/trialFractions.png', plotPath), '-r200', figHs(1));
end;

figHs(2) = figure('Name', 'Ratios of trial types', figProps{:});
bar([
    (ratios_hit(3) - ratios_hit(2)) / (ratios_hit(2) + ratios_hit(3)), ...
    (ratios_CR(3) - ratios_CR(2)) / (ratios_CR(2) + ratios_CR(3))
    ]);
set(gca, 'XTickLabel', { 'hit', 'CR' });
xlabel('Condition'); ylabel('(no\_prior\_move / prior\_move) fraction [%]');

tilefigs(figHs);
%}







