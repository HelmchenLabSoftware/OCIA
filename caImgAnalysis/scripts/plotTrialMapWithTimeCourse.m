% trialTypes = { 'noisy', 'prior_move', 'no_prior_move', 'quiet_sens', 'delay_move' };
trialTypes = { 'no_prior_move' };
figPos = { [17 -115 935 1055] };
conds = { 'hit', 'CR' };
timeFrames = {
%     'base',     15 :  25;
%     'light',    25 :  35;
%     'sound',    65 :  75;
    'delay',   105 : 120;
};

ROIsToPlot = { 'M2', 'S1BC', 'S1FL', 'lateral', 'A1', 'V1', 'PPC' };
% ROIsToPlot = ROIs.ROINames;
caROIs = find(strcmp(ROIs.axeH, 'wf') & ismember(ROIs.ROINames, ROIsToPlot));
ROINames = ROIs.ROINames(caROIs);
nROIs = numel(ROINames);
% ROIColors = zeros(nROIs, 3);
% ROIColors = lines(nROIs);
ROIMasks = ROIs.ROIMasks(caROIs);

% lineTypes = { '-', ':', '--' };
lineTypes = { '-', '-', '-' };
% lineColors = [0 1 0; 1 0 0; 0 0 1];
% lineColors = hsv(nROIs);
lineColors = lines(nROIs);

nTypes = numel(trialTypes);
nConds = numel(conds);
nTimes = size(timeFrames, 1);

nFrames = 200; frameRate = 20; timeOffset = 3;
t = (1 : nFrames) ./ frameRate - timeOffset;

nFramesBehav = size(moveVect_CR, 1); frameRateBehav = 30; timeOffsetBehav = 3;
tBehav = (1 : nFramesBehav) ./ frameRateBehav - timeOffsetBehav;

cLim = [-2 2];
xLims = [-3 4];
yLims = [-5.2 6.8];

% showROIs = false;
showROIs = true;
doSave = true;
% doSave = false;

close all;

baseSavePath = 'singleTrialTimeCourseMapPlots';
if ~exist(baseSavePath, 'dir'); mkdir(baseSavePath); end;

for iTrialType = 1 : nTypes;
    trialType = trialTypes{iTrialType};
    
    for iTime = 1 : nTimes;
        tFrameName = timeFrames{iTime, 1};
        tFrame = timeFrames{iTime, 2};
        
        for iCond = 1 : nConds;
            cond = conds{iCond};
            fieldName = sprintf('%s_%s', cond, trialType);
                
            % get the variables with the condition name in them
            eval(sprintf('trialIndices = tr_%s;', fieldName));
            eval(sprintf('moveVectsForCond = moveVect_%s;', cond));
            
            % get data and count number of trials
            data = nan(256, 256, 200, 4); % blank display by default
            if isfield(dataStruct, fieldName);
                data = dataStruct.(fieldName);
            end;
            nTrials = size(data, 4);
            
            savePath = sprintf('%s/%s_%s_', baseSavePath, fieldName, tFrameName);
            nTrialsPerPlot = 4;
            iPlot = 1;
            firstTrial = 1;

            botPad = 0.08; leftPad = 0.05; topPad = 0.01; rightPad = 0.005;
            xPad = 0.01; yPad = 0.02;
            W = (1 - leftPad - rightPad - (4 - 1) * xPad) / 4;
            H = (1 - botPad - topPad - (nTrialsPerPlot - 1) * yPad) / nTrialsPerPlot;
            
            for iTrial = 1 : nTrials;
            
                if mod(iTrial, nTrialsPerPlot) == 1;
                    if doSave && iTrial > 1;
                        lastTrial = iTrial - 1;
                        savePathWithEnd = sprintf('%s_trials%02dTo%02d.png', savePath, firstTrial, lastTrial);
                        export_fig(savePathWithEnd, '-r300', gcf);
                        close(gcf);
                    end;
                    
                    firstTrial = iTrial;
                    
                    xPos = leftPad; yPos = 1 - H - topPad;
                    figure('Name', sprintf('Plot for %s-%s trials %02d to %02d', fieldName, tFrameName, ...
                        firstTrial, min(firstTrial + nTrialsPerPlot, nTrials)), figProps{:});
                    iPlot = 1;
                    
                end;
                
                subplot('position', [xPos, yPos, W * 3 + 2 * xPad, H]);
                hold('on');
                plotHandles = [];
                
                moveVect = linScale(moveVectsForCond(:, trialIndices(iTrial)), yLims);
                if any(moveVect);
                    moveVect(isnan(moveVect)) = yLims(1);
                    moveVect(1) = yLims(1);
                    moveVect(end) = yLims(1);
                end;
                
                moveVectHandle = patch(tBehav, double(moveVect), [0.9 0.9 0.9], 'EdgeColor', 'none');
                
                tfrX = tFrame(1) / frameRate - timeOffset; tfrY = yLims(1);
                tfrX2 = tFrame(end) / frameRate - timeOffset; tfrY2 = yLims(end);
                timeFrameRectHandle = plot([tfrX tfrX tfrX2 tfrX2], [tfrY tfrY2 tfrY2 tfrY], 'Color', 'red');
                
                dataForTrial = squeeze(data(:, :, :, iTrial));
                
                for iROI = 1 : nROIs;
                    ROIMask = ROIMasks{iROI};
                    ROIPixels = find(ROIMask);

                    dataLin = reshape(dataForTrial, size(dataForTrial, 1) * size(dataForTrial, 2), size(dataForTrial, 3));
                    dataTrace = smooth(nanmean(dataLin(ROIPixels, :), 1), 1, 'Gauss');

                    dataLin = reshape(dataForTrial, size(dataForTrial, 1) * size(dataForTrial, 2), size(dataForTrial, 3));
                    dataTraceSem = smooth(nanmean(dataLin(ROIPixels, :), 1), 1, 'Gauss');

                    plotHandles(iROI) = plot(t, dataTrace, 'Color', lineColors(iROI, :), 'LineWidth', 2); %#ok<SAGROW>
                end;
                
                hold('off');

                xlim(xLims); ylim(yLims);
                set(gca, 'XGrid', 'on', 'YGrid', 'on', 'FontSize', 15);

                if yPos - botPad > eps && iTrial ~= nTrials;
                    set(gca, 'XTickLabel', []);
                else
                    xlabel('Time [s]', 'FontSize', 18);
                end;
                ylabel('\DeltaF/F [%]', 'FontSize', 18);
                
                xPos = xPos + 3 * W + 3 * xPad;
                
                subplot('position', [xPos, yPos, W, H]);
                imagesc(smoothn(nanmean(data(:, :, tFrame, iTrial), 3), [5 5], 'Gauss'), cLim);
                set(gca, 'XTick', [], 'YTick', []);
                colormap('mapgeog');
%                 hCBar = colorbar(gca, 'FontSize', 14);
%                 set(get(hCBar, 'Label'), 'String', '\DeltaF/F [%]');
                
                if yPos - botPad < eps && xPos - leftPad < eps;
                    ylabel(tFrameName, 'FontSize', 20); 
                    condName = sprintf('%s_{%s}', regexprep(cond, '__MINUS__', ' - '), ...
                        regexprep(trialType, '_', ' '));
                    if isfield(nStruct, fieldName);
                        condName = sprintf('%s \\fontsize{10}N=%02d trial%s', condName, nTrials, iff(nTrials > 1, 's', ''));
                    end;
                    condName = regexprep(condName, '([^_]+ - [^_]+)', '($1)');
                    xlabel(condName, 'FontSize', 20);
                end;

                text(2, 2, sprintf('%s %02d', cond, trialIndices(iTrial)), 'Color', iff(strcmp(cond, 'CR'), 'red', 'green'), 'HorizontalAlignment', 'left', ...
                    'VerticalAlignment', 'top', 'FontSize', 15);
            
                if (iTrial == nTrials || mod(iTrial + 1, nTrialsPerPlot) == 1) && showROIs;
                    legend([plotHandles, moveVectHandle, timeFrameRectHandle], [regexprep(ROINames, '_', ' '), 'Move periods', 'Averaged time frame'], ...
                        'Location', 'SouthWest', 'FontSize', 7, 'Orientation', 'Horizontal');
                
                    hold('on');
                    for iROI = 1 : nROIs;
                        contour(ROIMasks{iROI}, ':', 'Color', lineColors(iROI, :));
                    end;
                    hold('off');
                    text(2, size(data, 2), sprintf('%s - %s', regexprep(trialType, '_', ' '), tFrameName), ...
                        'Color', 'white', 'HorizontalAlignment', 'left', ...
                        'VerticalAlignment', 'bottom', 'FontSize', 12);
                end;
                     
                % reset position to next line
                yPos = yPos - H - yPad;
                xPos = leftPad;
                                
            end; % end of trials
            
            if doSave;
                lastTrial = iTrial;
                savePathWithEnd = sprintf('%s_trials%02dTo%02d.png', savePath, firstTrial, lastTrial);
                export_fig(savePathWithEnd, '-r300', gcf);
                close(gcf);
            end;
        end;
    end;
end;