function dRR = extractDRR(traceYFP, traceCFP, iR0Method, frameRate, doPlot)
    
% set(0, 'DefaultFigureWindowStyle', 'docked', 'DefaultFigureNumberTitle', 'off');
set(0, 'DefaultFigureWindowStyle', 'docked');
nFrames = size(traceYFP, 1);
t = (1 : nFrames) / frameRate;

%% plot
if doPlot;
    figure('Name', 'RawTraces');
    plot(t, traceYFP, 'g');
    xlabel('Time [s]');
    ylabel('Raw trace');
    title(sprintf('Raw traces, %d frames, frameRate: %4.2f', nFrames, frameRate));
    
    hold on;
    plot(t, traceCFP, 'b');
    legend('YFP', 'CFP');
end;

%% dFF /dRR
R = traceYFP ./ traceCFP;

methods = {'mean', 'median', 'prctile', 'polyfit', 'polyfitMean'};
method = methods{iR0Method};
switch method;
    case 'mean';
        R0 = nanmean(R);
    case 'median';
        R0 = nanmedian(R);
    case 'prctile';
        R0 = prctile(R, 25);
    case 'polyfit';
        pR = polyfit(t', R, 2);
        R0 = (pR(1) .* t .^ 2 + pR(2) .* t + pR(3))';
    case 'polyfitMean';
        pR = polyfit(t', R, 2);
        R0 = mean(pR(1) .* t .^ 2 + pR(2) .* t + pR(3));
end

dRR = ((R - R0) ./ R0) * 100;
dRR(isinf(dRR)) = 0;
dRR(isnan(dRR)) = 0;

if doPlot;
    
    figure('Name', 'R&R0');
    plot(t, R0, 'k');
    hold on;
    plot(t, R, 'r');
    xlabel('Time [s]');
    ylabel('Ratio');
    title('R and R0 as YFP/CFP');
    legend('R0', 'R');

    figure('Name', 'dRR');
    plot(t, dRR, 'k');
    xlabel('Time [s]');
    ylabel('dRR');
    title(sprintf('dRR, %d frames, frameRate: %4.2f', nFrames, frameRate));
    legend('dRR');
    
end;

set(0, 'DefaultFigureWindowStyle', 'normal');

end
