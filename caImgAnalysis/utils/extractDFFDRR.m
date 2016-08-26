function [DFF, traceYFP, traceCFP, axeHandles] = extractDFFDRR(traceYFP, traceCFP, iR0Method, R0Params, polyfitCorrect, ...
    polyfitFraction, expfitCorrect, expfitWindow, frameRate, saveName, axeH, doPlot)
    
% set(0, 'DefaultFigureWindowStyle', 'docked', 'DefaultFigureNumberTitle', 'off');
set(0, 'DefaultFigureWindowStyle', 'docked');
nFrames = size(traceYFP, 1);
t = (1 : nFrames) / frameRate;

%% polyfit correct (bleaching or other slow artifacts
if polyfitCorrect > 0;
    r = round(1 : (nFrames * polyfitFraction));
    traceYFPNoNans = inpaint_nans(traceYFP, 1);
    YFPPolyfitModel = polyfit(t(r)', traceYFPNoNans(r), polyfitCorrect);
    YFPAvg = nanmean(traceYFP(r));
    YFPPolyfit = polyval(YFPPolyfitModel, t(r));
    YFPPolyfit(r(end) : nFrames) = repmat(YFPPolyfit(end), 1, nFrames - r(end) + 1);
    traceYFPOri = traceYFP;
    traceYFP = traceYFP - YFPPolyfit' + YFPAvg;
end;
if polyfitCorrect > 0 && ~isempty(traceCFP);
    r = round(1 : (nFrames * polyfitFraction));
    traceCFPNoNans = inpaint_nans(traceCFP, 1);
    CFPPolyfitModel = polyfit(t(r)', traceCFPNoNans(r), polyfitCorrect);
    CFPAvg = nanmean(traceCFP(r));
    CFPPolyfit = polyval(CFPPolyfitModel, t(r));
    CFPPolyfit(r(end) : nFrames) = repmat(CFPPolyfit(end), 1, nFrames - r(end) + 1);
    traceCFPOri = traceCFP;
    traceCFP = traceCFP - CFPPolyfit' + CFPAvg;
end;

if expfitCorrect > 0;
    traceYFPNoNans = inpaint_nans(traceYFP, 1);
    traceYFP = FitExpBaselineWithSlidingMean(traceYFPNoNans, frameRate, expfitWindow);
end;
if expfitCorrect > 0 && ~isempty(traceCFP);
    traceCFPNoNans = inpaint_nans(traceCFP, 1);
    traceCFP = FitExpBaselineWithSlidingMean(traceCFPNoNans, frameRate, expfitWindow);
end;

%% do plot
if doPlot && polyfitCorrect > 0;
%     if isempty(axeH);
        figure('Name', sprintf('%s_RawTracesPolyFitCorrect', saveName));
%         axeH = gca;
        axeHPoly = gca;
%         removeAxes = true;
%     else
%         removeAxes = false;
%     end;
    plot(axeHPoly, t, traceYFPOri, 'g--');
    hold(axeHPoly, 'on');
    plot(axeHPoly, t, YFPPolyfit, 'g:');
    plot(axeHPoly, t, traceYFP, 'g');
    xlabel(axeHPoly, 'Time [s]');
    ylabel(axeHPoly, 'Raw trace');

    if ~isempty(traceCFP);
        plot(axeHPoly, t, traceCFPOri, 'b--');
        plot(axeHPoly, t, CFPPolyfit, 'b:');
        plot(axeHPoly, t, traceCFP, 'b');
        legend(axeHPoly, {'YFPori', 'YFPpoly', 'YFPcorr', 'CFPori', 'CFPpoly', 'CFPcorr'});
    else
        legend(axeHPoly, {'YFPori', 'YFPpoly', 'YFPcorr'});
    end;
%     if removeAxes; axeH = []; end;
end;

%% DFF/DRR
if ~isempty(traceCFP);
    F = traceYFP ./ traceCFP;
else
    F = traceYFP;
end;

methods = {'mean', 'median', 'prctile', 'polyfit', 'polyfitMean', 'slidingMean'};
method = methods{iR0Method};
switch method;
    case 'mean';
        F0 = nanmean(F);
    case 'median';
        F0 = nanmedian(F);
    case 'prctile';
        F0 = prctile(F, R0Params);
    case 'polyfit';
        pR = polyfit(t', F, R0Params);
        F0 = (pR(1) .* t .^ 2 + pR(2) .* t + pR(3))';
    case 'polyfitMean';
        pR = polyfit(t', F, R0Params);
        F0 = mean(pR(1) .* t .^ 2 + pR(2) .* t + pR(3));
    case 'slidingMean';
        F0 = FindBaselineWithSlidingMean(F, frameRate, R0Params);
end

DFF = ((F - F0) ./ F0) * 100;
DFF(isinf(DFF)) = NaN;

%% do plot
if doPlot;
    
    C = 'R';
    if isempty(traceCFP); C = 'F'; end;
    
    if isempty(axeH);
        figure('Name', sprintf('%s_RawTracesPolyFitCorrect', saveName));
        axeH = gca;
    end;
    
    %%
    
    % generate config for plotting
    toPlots = { ...
        traceCFP, 'CFP', [0 0 1], '-', 1, 'Raw trace CFP';
        traceYFP, 'YFP', [0 1 0], '-', 1, 'Raw trace YFP';
        F, C, [.8 .8 .8], '-', 1, C;
        repmat(F0, numel(t), 1), sprintf('%s0', C), [.8 .8 .8], '--', 0, '';
        DFF, sprintf('D%s%s', C, C), [0 0 0], '-', 1, sprintf('D%s%s', C, C);
    };
    % remove empty cells
    toPlots(cellfun(@isempty, toPlots(:, 1)), :) = [];
    
    % get the number of plots and axes
    nPlots = size(toPlots, 1);
    nAxes = sum(cell2mat(toPlots(:, 5)));
    % get the basic position and axe handle
    basePos = get(axeH, 'Position'); baseAxeH = axeH;
    % get height of the axes
    pad = basePos(4) * 0.03; baseHeight = ((basePos(4) - pad) / nAxes) - pad;
    currPos = basePos; currPos(4) = baseHeight; currPos(2) = currPos(2) - baseHeight;
    currAxe = [];
    
    % set the axes and do the plots
    axeHandles = [];
    for iPlot = 1 : nPlots;
        
        if toPlots{iPlot, 5} || isempty(currAxe);
            currPos(2) = currPos(2) + baseHeight + pad;
            currAxe = copyobj(baseAxeH, get(baseAxeH, 'Parent'));
            set(currAxe, 'Position', currPos, 'Tag', sprintf('TemporaryAxe%02d_analyser', iPlot));
            hold(currAxe, 'on');
            axeHandles(end + 1) = currAxe; %#ok<AGROW>
            
            if iPlot == 1;
                xlabel(currAxe, 'Time [s]');
            end;
            ylabel(currAxe, toPlots{iPlot, 6});
            
            if iPlot == nPlots;
                title(currAxe, sprintf('%s, raw traces (scaled), %d frames, frameRate: %4.2f', ...
                    saveName, nFrames, frameRate), 'Interpreter', 'none');
            end;
        else
            hold(currAxe, 'on');
        end;
        plot(currAxe, t, toPlots{iPlot, 1}, 'Color', toPlots{iPlot, 3}, 'LineStyle', toPlots{iPlot, 4});
        hold(currAxe, 'off');
        xlim(currAxe, [t(1) t(end)]);
        
    end;
    linkaxes(axeHandles, 'x');
    delete(axeH);
    
end;

set(0, 'DefaultFigureWindowStyle', 'normal');

end
