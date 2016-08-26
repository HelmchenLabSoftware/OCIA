% plot Wide-Field maps

load('session01_122800\Matt_files\ROIs_registered.mat');

sessDirs = dir();
sessDirs(arrayfun(@(i) isempty(regexp(sessDirs(i).name, '^session\d\d_\d+$', 'once')), 1 : numel(sessDirs))) = [];

% sessInds = 1:7;
% sessInds = [2, 4];
% sessInds = [1, 4, 5, 7]; % delay
% sessInds = [1, 2, 3, 4, 5, 6, 7];
sessInds = [1, 3, 4, 5, 6, 7];
% sessInds = [1, 2, 4, 5, 7]; % sound
% sessInds = [1, 2, 4];
% sessDirs = sessDirs(sessInds);

if ~exist('saveStruct', 'var');
    if exist('analysis/saveStruct.mat', 'file');
        saveStructMat = load('analysis/saveStruct.mat');
        saveStruct = saveStructMat.saveStruct;
    else
        saveStruct = struct();
        saveStruct(numel(sessDirs)) = struct();
    end;
end;

nFrames = 200; frameRate = 20; baseLineTime = 0;
t = ((1 : nFrames) / frameRate ) - baseLineTime;

% framesToAvgCell = { 10 : 20, 15 : 20, 14 : 18 };
% timePeriodCell = { 'x0p00To0p50Sec', 'x0p25To0p50Sec', 'x0p20To0p40Sec' };

% conditions = { 'move_hit_average_aligned', 'strict_quiet_hit_average_aligned', 'delay_quiet_hit_average_aligned', ...
%     'move_CR_average_aligned', 'strict_quiet_CR_average_aligned', 'delay_quiet_CR_average_aligned' };

% conditions = { 'hit_average_aligned', 'CR_average_aligned', 'move_average_aligned', 'strict_quiet_average_aligned' };
% conditions = { 'hit_average_aligned__MINUS__CR_average_aligned', 'move_average_aligned__MINUS__strict_quiet_average_aligned' };
% conditions = { 'move_hit_average_aligned__MINUS__move_CR_average_aligned', ...
%     'strict_quiet_hit_average_aligned__MINUS__strict_quiet_CR_average_aligned' };

% conditions = { 'move_hit_average__MINUS__move_CR_average', ...
%     'strict_quiet_hit_average__MINUS__strict_quiet_CR_average', ...
%     'move_hit_average__MINUS__strict_quiet_hit_average', ...
%     'move_CR_average__MINUS__strict_quiet_CR_average' };

% conditions = { 'move_hit_average_aligned__MINUS__move_CR_average_aligned', ...
%     'strict_quiet_hit_average_aligned__MINUS__strict_quiet_CR_average_aligned', ...
%     'move_hit_average_aligned__MINUS__strict_quiet_hit_average_aligned', ...
%     'move_CR_average_aligned__MINUS__strict_quiet_CR_average_aligned' };

% conditions = { 'move_average_aligned__MINUS__strict_quiet_average_aligned', ...
%     'hit_average_aligned__MINUS__CR_average_aligned' };
conditions = { 'move_average__MINUS__strict_quiet_average', ...
    'hit_average__MINUS__CR_average' };

% conditions = { 'move_hit_average', 'strict_quiet_hit_average', 'delay_quiet_hit_average', ...
%     'move_CR_average', 'strict_quiet_CR_average', 'delay_quiet_CR_average' };
% conditions = { 'move_hit_average', 'strict_quiet_hit_average', ...
%     'move_CR_average', 'strict_quiet_CR_average' };

% framesToAvgCell = { 20 : 40, 62 : 69, 107 : 117 };
% timePeriodCell = { 'lightCue', 'sound', 'delay' };
% timePeriodCellClean = { 'visual', 'sound', 'delay' };

% framesToAvgCell = { 62 : 69, 107 : 117 };
% timePeriodCell = { 'sound', 'delay' };
% timePeriodCellClean = { 'sound', 'delay' };

% framesToAvgCell = { 60 : 62, 104 : 120 };
% timePeriodCell = { 'sound', 'delay' };
% timePeriodCellClean = { 'sound', 'delay' };

% framesToAvgCell = { 62 : 69 };
% timePeriodCell = { 'sound' };
% timePeriodCellClean = { 'sound' };

framesToAvgCell = { 25 : 40 };
timePeriodCell = { 'visual' };
timePeriodCellClean = { 'visual' };

% framesToAvgCell = { 107 : 117 };
% timePeriodCell = { 'delay' };
% timePeriodCellClean = { 'delay' };

% cLimsCellTimePeriod = { [5, 0.02], [5, 0.02], [5, 0.02] };
% cLimsCellTimePeriod = { [-0.6, 0.6], [-0.2, 0.5] };
cLimsCellTimePeriod = [];
% cLimsCellSession = { [-0.2, 1.2], [-0.2, 1.4], [-0.2, 0.6], [-0.2, 0.5], [-0.2, 0.7], [-0.2, 2.4] };
cLimsCellSession = [];

ROIsShift = ROIs;
translationShifts = [10; -15];
srcPoints = [0 1 ; 1 0; 1 1]; targPoints = repmat(translationShifts', 3, 1) + srcPoints;
% get the transformation matrix
tForm = cp2tform(squeeze(srcPoints), squeeze(targPoints), 'affine'); %#ok<DCPTF>
for iROI = 1 : size(ROIs, 1);
    % adjust mask
    ROIsShift{iROI, 3} = imtransform(ROIs{iROI, 3}, tForm, 'XData', [1, 256], 'YData', [1, 256], 'FillValues', NaN) == 1; %#ok<DIMTRNS>
    % adjust coordinates
    ROIsShift{iROI, 2} = round(ROIsShift{iROI, 2} + repmat(translationShifts', size(ROIsShift{iROI, 2}, 1), 1));
end;

% cLim = [-3, 3];

% posCell = { [30, 130, 820, 870], [1000, 130, 820, 870] };
% posCell = { [30, 130, 820, 870], [500, 130, 820, 870], [1000, 130, 820, 870] };
% posCell = { [30, 80, 1850, 910], [30, 80, 1850, 910], [30, 80, 1850, 910] };
% posCell = { [30, 80, 1250, 910], [230, 80, 1250, 910], [430, 80, 1250, 910] };
% posCell = { [30, 80, 900, 445], [230, 80, 900, 445], [430, 80, 900, 445] };
posCell = { [30, 80, 900, 670], [230, 80, 900, 670], [430, 80, 900, 670] };

% save parameters
saveStruct(1).params.sessDirs = sessDirs;
saveStruct(1).params.t = t;
saveStruct(1).params.framesToAvgCell = framesToAvgCell;
saveStruct(1).params.timePeriodCell = timePeriodCell;
saveStruct(1).params.cLimsCellTimePeriod = cLimsCellTimePeriod;
saveStruct(1).params.cLimsCellSession = cLimsCellSession;
saveStruct(1).params.posCell = posCell;


%% plot
close all;
% cLim = [-0.9, 1.2];
cLim = [-0.8, 0.8];
% cLim = [-0.3, 0.7];
% cLim = [-0.5, 0.5];

% showAllSess = true;
showAllSess = false;

doSave = true;
% doSave = false;

% showCBar = true;
showCBar = false;

% addROIs = true;
addROIs = false;

figHs = [];

    
% go through each period/condition in a new figure
for iPer = 1 : numel(timePeriodCell);
    
    for iCond = 1 : numel(conditions);
        cond = conditions{iCond};
        varCond = matlab.lang.makeValidName(DataHash(cond));
        condClean = regexprep(cond, '_', ' ');

        % get the parameters for the current period
        timePeriod = timePeriodCell{iPer};
        framesToAvg = framesToAvgCell{iPer};
        if isempty(cLimsCellSession) && ~isempty(cLimsCellTimePeriod);
            cLim = cLimsCellTimePeriod{iPer};
        end;

        pos = posCell{min(iPer, numel(posCell))};

        % create figure
        figHs(end + 1) = figure('NumberTitle', 'off', 'Name', sprintf('%s - %s', timePeriod, condClean), ...
            'Position', pos, 'Color', 'white'); %#ok<SAGROW>

        avgForAllSession = [];

        % go through each session
        nRealSess = 0;
        for iSess = 1 : numel(sessDirs);
            
            if ~ismember(iSess, sessInds); continue; end;
            
            if ~isempty(regexp(cond, '__MINUS__', 'once'));
                condParts = regexp(cond, '__MINUS__', 'split');
                varCondParts{1} = matlab.lang.makeValidName(DataHash(condParts{1}));
                varCondParts{2} = matlab.lang.makeValidName(DataHash(condParts{2}));
                for iCondPart = 1 : 2;
                    localCond = condParts{iCondPart};
                    localVarCond = matlab.lang.makeValidName(DataHash(localCond));
                    % load the average for each session
                    if ~isfield(saveStruct(iSess), localVarCond) || isempty(saveStruct(iSess).(localVarCond));
                        avgMat = load(sprintf('%s/Matt_files/cond_%s.mat', sessDirs(iSess).name, localCond));
                        saveStruct(iSess).(localVarCond) = avgMat;

                        fprintf('Loading [disk] condition "%29s" (%d/%d), period "%5s" (%d/%d), session "%s" (%d/%d): %d trial(s) ...\n', ...
                           localCond, iCond, numel(conditions), timePeriod, iPer, numel(timePeriodCell), ...
                           sessDirs(iSess).name, iSess, numel(sessDirs), saveStruct(iSess).(localVarCond).N);

                    else
                        fprintf('Loading [cache] condition "%29s" (%d/%d), period "%5s" (%d/%d), session "%s" (%d/%d): %d trial(s) ...\n', ...
                           localCond, iCond, numel(conditions), timePeriod, iPer, numel(timePeriodCell), ...
                           sessDirs(iSess).name, iSess, numel(sessDirs), saveStruct(iSess).(localVarCond).N);

                    end;
                end;
                
                saveStruct(iSess).(varCond).N = 0;
                saveStruct(iSess).(varCond).tr_ave = saveStruct(iSess).(varCondParts{1}).tr_ave - saveStruct(iSess).(varCondParts{2}).tr_ave + 1;
                
            end;

            % load the average for each session
            if ~isfield(saveStruct(iSess), varCond) || isempty(saveStruct(iSess).(varCond));
                avgMat = load(sprintf('%s/Matt_files/cond_%s.mat', sessDirs(iSess).name, cond));
                saveStruct(iSess).(varCond) = avgMat;
            
                fprintf('Loading [disk] condition "%29s" (%d/%d), period "%5s" (%d/%d), session "%s" (%d/%d): %d trial(s) ...\n', ...
                   cond, iCond, numel(conditions), timePeriod, iPer, numel(timePeriodCell), ...
                   sessDirs(iSess).name, iSess, numel(sessDirs), saveStruct(iSess).(varCond).N);
               
            else
                fprintf('Loading [cache] condition "%29s" (%d/%d), period "%5s" (%d/%d), session "%s" (%d/%d): %d trial(s) ...\n', ...
                   cond, iCond, numel(conditions), timePeriod, iPer, numel(timePeriodCell), ...
                   sessDirs(iSess).name, iSess, numel(sessDirs), saveStruct(iSess).(varCond).N);
               
            end;

            dataForSess = saveStruct(iSess).(varCond).tr_ave - 1;
            if isempty(avgForAllSession);
                avgForAllSession = dataForSess;
                
            else
                avgForAllSession = avgForAllSession + dataForSess;
                
            end;
            nRealSess = nRealSess + 1;

            if ~isempty(cLimsCellSession) && isempty(cLimsCellTimePeriod);
                cLim = cLimsCellSession{iSess};
            end;
            
            
            % plot
            if showAllSess;
                subplot(2, 4, nRealSess);
                imagesc(1 : 256, 1 : 256, 100 * (smoothn(nanmean(dataForSess(:, :, framesToAvg), 3), [7 7], 'Gauss')));
                set(gca, 'CLim', cLim, 'XLim', [1 256], 'YLim', [1 256], 'XTick', [], 'YTick', []);
                axis('square');
                title(sprintf('%s - sess%02d', timePeriodCellClean{iPer}, iSess), 'Interpreter', 'none', 'FontSize', 15);
%                 cBar = colorbar('FontSize', 15);
%                 set(get(cBar, 'Label'), 'String', '\DeltaF/F %');
                colormap(gca, 'mapgeog');
            end;

        end;

        avgForAllSession = avgForAllSession ./ nRealSess;

        % plot
        if showAllSess;
            subplot(2, 4, numel(sessDirs) + 1);
        end;
        %%
        avgForAllSession = tr - 1;
%         framesToAvg = 25 : 40;
%         framesToAvg = 62 : 67;
        framesToAvg = 107 : 117;
        cLim = [-2, 2];
        imagesc(1 : 256, 1 : 256, 100 * (smoothn(nanmean(avgForAllSession(:, :, framesToAvg), 3), [7 7], 'Gauss')));
        set(gca, 'CLim', cLim, 'XLim', [1 256], 'YLim', [1 256], 'XTick', [], 'YTick', []);
        axis('square');
        colormap(gca, 'mapgeog');
        %%
        if showAllSess;
            title(sprintf('%s - average', timePeriodCellClean{iPer}), 'Interpreter', 'none', 'FontSize', 15);
        else
            if showCBar;
                title(sprintf('%s', timePeriodCellClean{iPer}), 'Interpreter', 'none', 'FontSize', 45);
                cBar = colorbar('FontSize', 45);
                set(get(cBar, 'Label'), 'String', '\DeltaF/F %');
            end;
        end;
        
        if addROIs;
            hold('on');
            ROIColors = [0 1 1; 1 0 1; 0 1 0; 1 1 0; 1 0 0; 0 0 1];
            for iROI = 1 : size(ROIsShift, 1);
                contour(ROIsShift{iROI, 3}, 'Color', ROIColors(iROI, :), 'LineStyle', '-');
            end;
            legend(ROIsShift(:, 1));
            hold('off');
        end;
        
        if doSave;
            export_fig(sprintf('analysis/%s_%s%s%s.png', timePeriod, cond, iff(showAllSess, '', '_avgOnly'), ...
                iff(~showCBar, '', '_CBar')), '-r300', gcf);
            export_fig(sprintf('analysis/%s_%s%s%s.fig', timePeriod, cond, iff(showAllSess, '', '_avgOnly'), ...
                iff(~showCBar, '', '_CBar')), gcf);
        else
            if regexp(cond, 'hit');
                text(2, 10, 'HIT', 'Color', 'green', 'FontSize', 30);
            elseif regexp(cond, 'CR');
                text(2, 10, 'CR', 'Color', 'red', 'FontSize', 30);
            end;
            if regexp(cond, 'strict');
                text(204, 10, 'quiet', 'Color', 'white', 'FontSize', 30);
            elseif regexp(cond, 'delay');
                text(204, 10, 'delay', 'Color', 'white', 'FontSize', 30);
            elseif regexp(cond, 'move');
                text(204, 10, 'move', 'Color', 'white', 'FontSize', 30);
            end;
        end;
        if showCBar;
            return;
        end;
    end;
end;

for iFig = 1 : numel(figHs); tightfig(figHs(iFig)); end;
tilefigs(figHs, false);
% tilefigs(figHs, true);

% save('analysis/saveStruct.mat', 'saveStruct');

%% draw an ROI