% trialTypes = { 'noisy', 'prior_move', 'no_prior_move', 'quiet_sens', 'delay_move' };
trialTypes = { 'prior_move', 'no_prior_move', 'delay_move' };
figPos = { [17 -115 935 1055], [979 -115 935 1055], [500 -115 935 1055] };
conds = { 'hit', 'CR' };
% conds = { 'hit', 'CR', 'hit__MINUS__CR' };

nTypes = numel(trialTypes);
nConds = numel(conds);

ROIsToPlot = { 'M2', 'A1', 'V1', 'PPC' };
caROIs = find(strcmp(ROIs.axeH, 'wf') & ismember(ROIs.ROINames, ROIsToPlot));
ROINames = ROIs.ROINames(caROIs);
nROIs = numel(ROINames);
% ROIColors = zeros(nROIs, 3);
% ROIColors = lines(nROIs);
ROIMasks = ROIs.ROIMasks(caROIs);

% lineTypes = { '-', ':', '--' };
lineTypes = { '-', '-', '-' };
lineColors = [0 1 0; 1 0 0; 0 0 1];

botPad = 0.09; leftPad = 0.06; topPad = 0.01; rightPad = 0.01;
xPad = 0.02; yPad = 0.02;
% W = (1 - leftPad - rightPad - 2 * xPad) / 3;
% H = (1 - botPad - topPad - (nROIs) * yPad) / nROIs;
W = (1 - leftPad - rightPad - (nROIs) * xPad) / nROIs;
H = (1 - botPad - topPad - 2 * yPad) / 3;

xLims = [-3.05 4.05];
yLims = [-0.024 0.034];

nFrames = 200; frameRate = 20; timeOffset = 3;
t = (1 : nFrames) ./ frameRate - timeOffset;

% close all;

figure('Name', 'Time courses', figProps{:});
xPos = leftPad; yPos = 1 - H - topPad;
    
for iTrialType = 1 : nTypes;
    trialType = trialTypes{iTrialType};

    for iROI = 1 : nROIs;
        ROIMask = ROIMasks{iROI};
        ROIPixels = find(ROIMask);
        
        subplot('position', [xPos, yPos, W, H]);
        hold('on');

        plotHandles = zeros(nConds, 1);
        for iCond = 1 : nConds;
            cond = conds{iCond};
            fieldName = sprintf('%s_%s', cond, trialType);

            dataTrace = nan(1, nFrames); % blank display by default
            dataTraceSem = nan(1, nFrames); % blank display by default

            % multiple conditions required
            if ~isempty(regexp(cond, '__MINUS__', 'once'));
                multiConds = regexp(cond, '__MINUS__', 'split');
                if isfield(meanStruct, sprintf('%s_%s', multiConds{1}, trialType)) ...
                    && isfield(meanStruct, sprintf('%s_%s', multiConds{2}, trialType));
                
                    data1 = meanStruct.(sprintf('%s_%s', multiConds{1}, trialType));
                    dataLin1 = reshape(data1, size(data1, 1) * size(data1, 2), size(data1, 3));
                    dataTrace1 = smooth(nanmean(dataLin1(ROIPixels, :), 1), 1, 'Gauss');
                    
                    data2 = meanStruct.(sprintf('%s_%s', multiConds{2}, trialType));
                    dataLin2 = reshape(data2, size(data2, 1) * size(data2, 2), size(data2, 3));
                    dataTrace2 = smooth(nanmean(dataLin2(ROIPixels, :), 1), 1, 'Gauss');
                    
                    dataTrace = dataTrace1 - dataTrace2;
                
                    data1 = semStruct.(sprintf('%s_%s', multiConds{1}, trialType));
                    dataLin1 = reshape(data1, size(data1, 1) * size(data1, 2), size(data1, 3));
                    dataTrace1 = smooth(nanmean(dataLin1(ROIPixels, :), 1), 1, 'Gauss');
                    
                    data2 = semStruct.(sprintf('%s_%s', multiConds{2}, trialType));
                    dataLin2 = reshape(data2, size(data2, 1) * size(data2, 2), size(data2, 3));
                    dataTrace2 = smooth(nanmean(dataLin2(ROIPixels, :), 1), 1, 'Gauss');
                    
                    dataTraceSem = dataTrace1 + dataTrace2;
                end;

            elseif isfield(meanStruct, fieldName);
                
                data = meanStruct.(fieldName);
                dataLin = reshape(data, size(data, 1) * size(data, 2), size(data, 3));
                dataTrace = smooth(nanmean(dataLin(ROIPixels, :), 1), 1, 'Gauss');
                
                data = semStruct.(fieldName);
                dataLin = reshape(data, size(data, 1) * size(data, 2), size(data, 3));
                dataTraceSem = smooth(nanmean(dataLin(ROIPixels, :), 1), 1, 'Gauss');

            end;

%             trialTypeHandles(iTrialType) = plot(t, dataTrace, 'Color', ROIColors(iROI, :), ...
%                 'LineStyle', lineTypes{iTrialType}, 'LineWidth', 1);
            plotHandles(iCond) = plot(t, dataTrace, 'Color', lineColors(iCond, :), ...
                'LineStyle', lineTypes{iCond}, 'LineWidth', 1);
%             h = shadedErrorBar(t, dataTrace, dataTraceSem, { 'Color', lineColors(iCond, :), ...
%                 'LineStyle', lineTypes{iCond}, 'LineWidth', 1 }, 1, gcf, gca);
%             plotHandles(iCond) = h.mainLine;
            
            xlim(xLims); ylim(yLims);
            set(gca, 'XGrid', 'on', 'YGrid', 'on');
            
            if xPos - leftPad < eps;
                ylabel(regexprep(trialType, '_', ' '), 'FontSize', 20);
            else
                set(gca, 'YTickLabel', []);
            end;
            if yPos - botPad < eps;
                xlabel(ROINames{iROI}, 'FontSize', 20);
            else
                set(gca, 'XTickLabel', []);
            end;
        end;
        hold('off');
        
        if iCond == nConds && iROI == nROIs;
            legend(plotHandles, regexprep(regexprep(conds, '__MINUS__', ' - '), '_', ' '), 'Location', 'NorthEast');
        end;
        
        xPos = xPos + W + xPad;
    end;

    % reset position to next line
    yPos = yPos - H - yPad;
    xPos = leftPad;
end;