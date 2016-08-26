
figPos = [17 55 935 1055];

% conds = { 'hit', 'CR' };
conds = { 'hit', 'CR', 'hit__MINUS__CR' };

timeFrames = {
    'light',    25 :  35;
    'sound',    62 :  72;
    'delay',   105 : 120;
};
%     'light',    20 :  30; %  25 :  35
%     'sound',    65 :  95; %  65 :  75
%     'delay',   105 : 120; % 105 : 120

% lineTypes = { '-', ':', '--' };
lineTypes = { '-', '-.' };
% lineColors = [0 1 0; 1 0 0; 0 0 1];
% lineColors = hsv(nROIs);
lineColors = lines(nROIs);

axisFontSize = 25;
xLabFontSize = 40;
yLabFontSize = 40;
legendFontSize = 15;
condNameFontSize = 18;
nTrialsFontSize = 18;


nTypes = numel(trialTypes);
nConds = numel(conds);
nTimes = size(timeFrames, 1);

nFrames = 200; frameRate = 20; timeOffset = 3;
t = (1 : nFrames) ./ frameRate - timeOffset;

xLims = [-3.1 4.1];
if ~exist('yLimsTimeCourseAvg', 'var');
    yLimsTimeCourseAvg = { [-4.8 3.6], [-4.8 2.1], [-4.8 3.6] };
end;

% showROIs = false;
showROIs = true;

if ~exist('doSave', 'var');
    doSave = false;
    % doSave = true;
end;

if ~exist('cLimsTimeCourseAvgMap', 'var');
    cLimsTimeCourseAvgMap = { [-1.4 1.4], [-0.9 0.9], [-1.4 1.4] };
end;

close all;

baseSavePath = 'averageTimeCourseMapPlots';
if ~exist(baseSavePath, 'dir'); mkdir(baseSavePath); end;

for iTrialType = 1 : nTypes;
    trialType = trialTypes{iTrialType};
    
    for iTime = 1 : nTimes;
        tFrameName = timeFrames{iTime, 1};
        tFrame = timeFrames{iTime, 2};
    
        figure('Name', sprintf('Plot for "%s %s" averages - %s', regexprep(trialType, '_', ' '), tFrameName, sessID), figProps{:}, ...
            'Position', figPos);
        savePath = sprintf('%s/%s_%s_%s_', baseSavePath, sessID, trialType, tFrameName);

        botPad = 0.13; leftPad = 0.13; topPad = 0.01; rightPad = 0.005;
        xPad = 0.01; yPad = 0.02;
        W = (1 - leftPad - rightPad - (5 - 1) * xPad) / 5;
        H = (1 - botPad - topPad - (nROIs - 1) * yPad) / nROIs;

        xPos = leftPad; yPos = 1 - H - topPad;
        
        for iROI = 1 : nROIs;

            subplot('position', [xPos, yPos, W * 3 + 2 * xPad, H]);
            hold('on');
            plotHandles = nan(1, nConds);
            
            tfrX = tFrame(1) / frameRate - timeOffset; tfrY = yLimsTimeCourseAvg{iTrialType}(1);
            tfrX2 = tFrame(end) / frameRate - timeOffset; tfrY2 = yLimsTimeCourseAvg{iTrialType}(end);
            timeFrameRectHandle = plot([tfrX tfrX tfrX2 tfrX2], [tfrY tfrY2 tfrY2 tfrY], 'Color', 'red');
        
            for iCond = 1 : nConds;
                cond = conds{iCond};
                fieldName = sprintf('%s_%s', cond, trialType);
                ROIMask = ROIMasks{iROI};
                ROIMask = ROIMask((cropDims(2) + 1) : (cropDims(2) + cropDims(4)), ...
                    (cropDims(1) + 1) : (cropDims(1) + cropDims(3)));
                ROIPixels = find(ROIMask);
            
                % get data and count number of trials
                data = nan(256, 256, 200); % blank display by defaultif ~isempty(regexp(cond, '__MINUS__', 'once'));
                
                if isfield(meanStruct, fieldName);
                    data = meanStruct.(fieldName);
                    
                else
                    continue;
                    
                end;

                dataLin = reshape(data, size(data, 1) * size(data, 2), size(data, 3));
                dataTrace = smooth(nanmean(dataLin(ROIPixels, :), 1), 1, 'Gauss');

                dataLin = reshape(data, size(data, 1) * size(data, 2), size(data, 3));
                dataTraceSem = smooth(nanmean(dataLin(ROIPixels, :), 1), 1, 'Gauss');

                plotHandles(iCond) = plot(t, dataTrace, 'Color', lineColors(iROI, :), 'LineWidth', 2, ...
                    'LineStyle', lineTypes{iCond});

                xlim(xLims); ylim(yLimsTimeCourseAvg{iTrialType});
                set(gca, 'XGrid', 'on', 'YGrid', 'on', 'FontSize', axisFontSize);
                
                if iROI ~= nROIs;
                    set(gca, 'XTickLabel', []);
                else
                    xlabel('Time [s]', 'FontSize', xLabFontSize);
                end;
                if iROI == round(nROIs * 0.5);
                    ylabel('\DeltaF/F [%]', 'FontSize', yLabFontSize);
                end;
                
            end;
                
            ROINameWithConds = regexp(sprintf(sprintf('%s %%s,', ROINames{iROI}), conds{~isnan(plotHandles)}), ',', 'split');
            ROINameWithConds(end) = [];
%             legend([plotHandles(~isnan(plotHandles)), timeFrameRectHandle], [ROINameWithConds, 'Averaged time frame'], ...
%                 'Location', 'SouthWest', 'FontSize', legendFontSize, 'Orientation', 'Horizontal');
            legend(plotHandles(~isnan(plotHandles)), ROINameWithConds, ...
                'Location', 'SouthEast', 'FontSize', legendFontSize, 'Orientation', 'Horizontal');
            
            hold('off');
            % reset position to next line
            yPos = yPos - H - yPad;
            xPos = leftPad;
        end;

        xPos = leftPad + 3 * W + 3 * xPad;
        yPos = 1 - topPad - 2 * H - yPad;

        for iCond = 1 : nConds;
            cond = conds{iCond};
            fieldName = sprintf('%s_%s', cond, trialType);

            data = nan(256, 256, 200); % blank display by default
            if ~isempty(regexp(cond, '__MINUS__', 'once'));
                multiConds = regexp(cond, '__MINUS__', 'split');
                if isfield(meanStruct, sprintf('%s_%s', multiConds{1}, trialType)) ...
                    && isfield(meanStruct, sprintf('%s_%s', multiConds{2}, trialType));

                    data1 = meanStruct.(sprintf('%s_%s', multiConds{1}, trialType));
                    data2 = meanStruct.(sprintf('%s_%s', multiConds{2}, trialType));
                    data = data1 - data2;

                end;

            elseif isfield(meanStruct, fieldName);
                data = meanStruct.(fieldName);
                
            end;

            subplot('position', [xPos, yPos, W * 2, 2 * H + yPad]);
            imagesc(smoothn(nanmean(data(:, :, tFrame), 3), [5 5], 'Gauss'), cLimsTimeCourseAvgMap{iTrialType});
            set(gca, 'XTick', [], 'YTick', []);
            colormap('mapgeog');
            
            condName = regexprep(cond, '__MINUS__', ' - ');
            condName = regexprep(condName, 'hit', '\\color{green}hit\\color{white}');
            condName = regexprep(condName, 'CR', '\\color{red}CR\\color{white}');
            text(2, 2, sprintf('%s', condName), 'HorizontalAlignment', 'left', ...
                'VerticalAlignment', 'top', 'FontSize', condNameFontSize);
            text(size(data, 1) - 2, 2, tFrameName, 'Color', 'white', 'HorizontalAlignment', 'right', ...
                'VerticalAlignment', 'top', 'FontSize', condNameFontSize);
            if isfield(nStruct, fieldName);
                text(2, size(data, 2), sprintf('N = %03d trial%s', nStruct.(fieldName), ...
                    iff(nStruct.(fieldName) > 1, 's', '')), 'Color', 'white', 'HorizontalAlignment', 'left', ...
                    'VerticalAlignment', 'bottom', 'FontSize', nTrialsFontSize);
            end;

            if showROIs;
                hold('on');
                for iROI = 1 : nROIs;
                    ROIMask = ROIMasks{iROI}((cropDims(2) + 1) : (cropDims(2) + cropDims(4)), ...
                        (cropDims(1) + 1) : (cropDims(1) + cropDims(3)));
                    contour(ROIMask, ':', 'Color', lineColors(iROI, :));
                end;
                hold('off');
            end;

            yPos = yPos - 2 * H - 2 * yPad;

        end;
            
        if doSave;
            savePathWithEnd = sprintf('%s_averageTimeCourseAndMap.png', savePath);
            export_fig(savePathWithEnd, '-r300', gcf);
            close(gcf);
        end;
    end;
end;