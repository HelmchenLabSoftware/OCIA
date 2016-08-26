
% figPos = [305 45 1125 985];
figPos = [305 45 1085 985];
conds = { 'hit', 'CR', 'hit__MINUS__CR' };

timeFrames = {
    'light',    25 :  35;
    'sound',    62 :  72;
    'delay',   105 : 120;
};

nTypes = numel(trialTypes);
nConds = numel(conds);
nTimes = size(timeFrames, 1);

botPad = 0.09; leftPad = 0.07; topPad = 0.06; rightPad = 0.15;
xPad = 0.005; yPad = 0.005;
W = (1 - leftPad - rightPad - 2 * xPad) / 3;
H = (1 - botPad - topPad - (nTimes - 1) * yPad) / nTimes;

axisTopFontSize = 35;
axisBotFontSize = 50;
axisLeftFontSize = 40;
axisNTrialsFontSize = 30;
cBarFontSize = 35;

cBarXOffset = 0.01;
cBarYOffset = 0.03;
cBarWOffset = -0.10;
cBarHOffset = -0.02;
cBarLabelXOffset = -0.5;
cBarLabelYOffset = iff(abs(cLimAvg(1)) == abs(cLimAvg(2)), -0.5, iff(abs(cLimAvg(1)) > abs(cLimAvg(2)), -0.5, 0.5));

% showROIs = false;
showROIs = true;

% doCBar = false;
doCBar = true;

if ~exist('doSave', 'var');
    doSave = false;
    % doSave = true;
end;

if ~exist('cLimAvg', 'var');
    cLimAvg = [-1 1];
end;

if doSave && exist('averageAndTrialMaps', 'dir') ~= 7;
    mkdir('averageAndTrialMaps');
end;

close all;

for iTrialType = 1 : nTypes;
    trialType = trialTypes{iTrialType};
    figure('Name', sprintf('Average maps for %s - %s', trialType, sessID), figProps{:}, 'Position', figPos);
    xPos = leftPad; yPos = 1 - H - topPad;
    
    for iTime = 1 : nTimes;
        tFrameName = timeFrames{iTime, 1};
        tFrame = timeFrames{iTime, 2};
        
        for iCond = 1 : nConds;
            cond = conds{iCond};
            fieldName = sprintf('%s_%s', cond, trialType);
            
            data = nan(imgDimX, imgDimY, nFrames, 1); % blank display by default
            
            % multiple conditions required
            if ~isempty(regexp(cond, '__MINUS__', 'once'));
                multiConds = regexp(cond, '__MINUS__', 'split');
                if isfield(meanStruct, sprintf('%s_%s', multiConds{1}, trialType)) ...
                    && isfield(meanStruct, sprintf('%s_%s', multiConds{2}, trialType));
                
                    data1 = meanStruct.(sprintf('%s_%s', multiConds{1}, trialType))(:, :, tFrame);
                    data2 = meanStruct.(sprintf('%s_%s', multiConds{2}, trialType))(:, :, tFrame);
                    
                    data = data1 - data2;
                end;
                
            elseif isfield(meanStruct, fieldName);
                data = meanStruct.(fieldName)(:, :, tFrame);
                
            end;
            
            subplot('position', [xPos, yPos, W, H]);
            imagesc(1 : imgDimX, 1 : imgDimY, smoothn(nanmean(data, 3), [5 5], 'Gauss'), cLimAvg);
            set(gca, 'XTick', [], 'YTick', []);
            axis(gca, 'square');
            colormap('mapgeog');
            if xPos - leftPad < eps; ylabel(tFrameName, 'FontSize', axisLeftFontSize); end;
            if iCond < 3 && iTime == 3 && isfield(nStruct, fieldName);
                condNameAndCount = sprintf('\\color{%s}N=%02d', iff(strcmp(cond, 'hit'), 'green', 'red'), nStruct.(fieldName));
                text(2, size(data, 2), condNameAndCount, 'HorizontalAlignment', 'left', ...
                    'VerticalAlignment', 'bottom', 'FontSize', axisNTrialsFontSize);
            end;
            
            if iCond == 2 && iTime == 3;
                trialTypeClean = sprintf('%s', regexprep(trialType, '_', ' '));
                text(size(data, 1) * 0.5, size(data, 2) + 2, trialTypeClean, 'HorizontalAlignment', 'center', ...
                    'VerticalAlignment', 'top', 'FontSize', axisTopFontSize);
            end;
            
            condName = sprintf('%s', regexprep(cond, '__MINUS__', ' - '));
            condName = regexprep(condName, '([^_]+ - [^_]+)', '$1');
            condName = regexprep(condName, 'hit', '\\color{green}hit\\color{black}');
            condName = regexprep(condName, 'CR', '\\color{red}CR\\color{black}');
            
            if iTime == 1;
                text(size(data, 1) * 0.5, 0, condName, 'HorizontalAlignment', 'center', ...
                    'VerticalAlignment', 'bottom', 'FontSize', axisTopFontSize);
            end;
            
            xPos = xPos + W + xPad;
            
            if iCond == nConds && showROIs;
                ROIColors = lines(nROIs);
                hold('on');
                for iROI = 1 : nROIs;
                    ROIMask = ROIMasks{iROI};
                    ROIMask = ROIMask((cropDims(2) + 1) : (cropDims(2) + cropDims(4)), ...
                        (cropDims(1) + 1) : (cropDims(1) + cropDims(3)));
                    contour(ROIMask, ':', 'Color', 'black', 'LineWidth', 0.25);
                end;
                hold('off');
            end;
        end;
        
        % reset position to next line
        yPos = yPos - H - yPad;
        xPos = leftPad;
    end;

    if doCBar;
        cBarAxe = axes('Position', [0 0 1 1], 'Visible', 'on', 'Color', 'none', 'XColor', 'white', 'YColor', 'white', 'CLim', [-3 3]);
        colormap(mapgeog(3000));
        hCBar = colorbar('FontSize', cBarFontSize);
        set(hCBar, 'Position', [1 - rightPad + cBarXOffset, topPad + cBarYOffset, rightPad + cBarWOffset, 1 - topPad - leftPad + cBarHOffset]);
        YTicks = get(hCBar, 'YTick');
        YTicks(YTicks ~= round(YTicks)) = [];
        set(hCBar, 'YTick', YTicks);
        set(get(hCBar, 'Label'), 'String', '\DeltaF/F [%]');
        set(get(hCBar, 'Label'), 'Position', get(get(hCBar, 'Label'), 'Position') + [cBarLabelXOffset, cBarLabelYOffset, 0]);
        set(cBarAxe, 'CLim', cLimAvg);

    end;
    
    if doSave;
        saveName = sprintf('averageAndTrialMaps/%s_averageMaps_%s%s', sessID, trialType, ...
            iff(doExclTrials, '_exclTrials', '')); %#ok<*UNRCH>
        export_fig(sprintf('%s.png', saveName), exportArgsPNG{:}, gcf);
        export_fig(sprintf('%s.fig', saveName), gcf);
    end;
    
end;
