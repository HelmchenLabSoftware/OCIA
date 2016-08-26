
figPos = [20 45 1145 950];

conds = { 'hit', 'CR' };
timeFrames = {
    'light',    25 :  35;
    'sound',    62 :  72;
    'delay',   105 : 120;
};
%     'light',    25 :  35;
%     'sound',    65 :  75;
%     'delay',   105 : 120;

nTypes = numel(trialTypes);
nConds = numel(conds);
nTimes = size(timeFrames, 1);

trialNumFontSize = 18;
axisBotFontSize = 60;
axisLeftFontSize = 70;
cBarFontSize = 35;

cBarXOffset = 0.01;
cBarYOffset = 0.06;
cBarWOffset = -0.15;
cBarHOffset = -0.02;
cBarLabelXOffset = -0.15;
cBarLabelYOffset = iff(abs(cLimTrial(1)) == abs(cLimTrial(2)), -0.5, iff(abs(cLimTrial(1)) > abs(cLimTrial(2)), -0.5, 0.5));
            
botPad = 0.11; leftPad = 0.09; topPad = 0.05; rightPad = 0.2;
xPad = 0.001; yPad = 0.020;

if ~exist('cLimTrial', 'var');
    cLimTrial = [-3 3];
end;

% doCBar = false;
doCBar = true;

% showROIs = false;
showROIs = true;

if ~exist('doSave', 'var');
    doSave = false;
    % doSave = true;
end;

close all;

if exist('averageAndTrialMaps', 'dir') ~= 7; mkdir('averageAndTrialMaps'); end;

for iTrialType = 1 : nTypes;
    trialType = trialTypes{iTrialType};
    
    for iTime = 1 : nTimes;
        tFrameName = timeFrames{iTime, 1};
        tFrame = timeFrames{iTime, 2};
        
        for iCond = 1 : nConds;
            cond = conds{iCond};
            fieldName = sprintf('%s_%s', cond, trialType);
            
%             if iCond > 1 || iTime > 1; return; end; % for debug only
                
            eval(sprintf('trialIndices = tr_%s;', fieldName));
            if doExclTrials;
                eval(sprintf('exclTrials = exclTrials_%s;', cond)); %#ok<*UNRCH>
            else
                exclTrials = [];
            end;
        
            trialIndices(ismember(trialIndices, exclTrials)) = []; %#ok<SAGROW>
            
            figure('Name', sprintf('Single trial maps for %s %s - %s', fieldName, tFrameName, sessID), figProps{:}, ...
                'Position', figPos);
            
            data = nan(imgDimX, imgDimY, nFrames, 4); % blank display by default
            
            if isfield(dataStruct, fieldName);
                data = dataStruct.(fieldName);
                
            end;

            nTrials = size(data, 4);
%             M = ceil(sqrt(nTrials)); N = iff((M * (M - 1)) >= nTrials, M - 1, M);
            M = ceil(sqrt(nTrials)); N = M; NOffset = iff((M * (M - 1)) >= nTrials, 1, 0);
            
            W = (1 - leftPad - rightPad - (M - 1) * xPad) / M;
            H = (1 - botPad - topPad - (N - 1) * yPad) / N;
            
            xPos = leftPad; yPos = 1 - H - topPad;
            
            for iTrial = 1 : nTrials;
                subplot('position', [xPos, yPos, W, H]);
                imagesc(smoothn(nanmean(data(:, :, tFrame, iTrial), 3), [5 5], 'Gauss'), cLimTrial);
                set(gca, 'XTick', [], 'YTick', []);
                axis('square');
                colormap('mapgeog');
                if yPos - NOffset * (H + yPad) - botPad < eps && xPos - leftPad < eps;
%                     ylabel([tFrameName ' period'], 'FontSize', axisLeftFontSize);
                    text(-10, size(data, 2), [tFrameName ' period'], 'Color', 'black', 'HorizontalAlignment', 'left', ...
                        'VerticalAlignment', 'bottom', 'FontSize', axisLeftFontSize, 'Rotation', 90); 
                    condName = sprintf('%s trials - %s', regexprep(cond, '__MINUS__', ' - '), ...
                        regexprep(trialType, '_', ' '));
                    condName = regexprep(condName, 'hit', '\\color{green}hit\\color{black}');
                    condName = regexprep(condName, 'CR', '\\color{red}CR\\color{black}');
                    text(0, size(data, 2), condName, 'Color', 'black', 'HorizontalAlignment', 'left', ...
                        'VerticalAlignment', 'top', 'FontSize', axisBotFontSize);
                end;
                xPos = xPos + W + xPad;
            
                if iTrial == nTrials && showROIs;
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
                text(2, -2, sprintf('%02d', trialIndices(iTrial)), 'Color', iff(strcmp(cond, 'hit'), 'green', 'red'), ...
                    'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', 'FontSize', trialNumFontSize);
                
                if mod(iTrial, M) == 0;        
                    % reset position to next line
                    yPos = yPos - H - yPad;
                    xPos = leftPad;
                end;
                
            end; % end of trials

            if doCBar;
                cBarAxe = axes('Position', [0 0 1 1], 'Visible', 'on', 'Color', 'none', 'XColor', 'white', 'YColor', 'white', 'CLim', [-3 3]);
                colormap(mapgeog(3000));
                hCBar = colorbar('FontSize', cBarFontSize);
                set(hCBar, 'Position', [1 - rightPad + cBarXOffset, topPad + cBarYOffset + NOffset * 0.215, ...
                    rightPad + cBarWOffset, 1 - topPad - leftPad + cBarHOffset - NOffset * 0.215]);
                YTicks = get(hCBar, 'YTick');
                YTicks(YTicks ~= round(YTicks)) = [];
                set(hCBar, 'YTick', YTicks);
                set(get(hCBar, 'Label'), 'String', '\DeltaF/F [%]');
                set(get(hCBar, 'Label'), 'Position', get(get(hCBar, 'Label'), 'Position') + [cBarLabelXOffset, cBarLabelYOffset, 0]);
                set(cBarAxe, 'CLim', cLimTrial);

            end;
            
            if doSave;
                saveName = sprintf('averageAndTrialMaps/%s_trialMaps_%s_%s%s', sessID, tFrameName, fieldName, ...
                    iff(doExclTrials, '_exclTrials', '')); %#ok<*UNRCH>
                export_fig(sprintf('%s.png', saveName), exportArgsPNG{:}, gcf);
                export_fig(sprintf('%s.fig', saveName), gcf);
            end;
        end;
    end;
end;