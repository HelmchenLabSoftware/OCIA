function dRR = quickAndDirtyDRR(traceYFP, traceCFP, ROIName, iR0Method, frameRate, downSampleFactor, ...
    sgolayFiltFrameSize, doPlot)
    
% set(0, 'DefaultFigureWindowStyle', 'docked', 'DefaultFigureNumberTitle', 'off');
set(0, 'DefaultFigureWindowStyle', 'docked');
isCFP = ~isempty(traceCFP);

nFrames = size(traceYFP, 1);
t = (1 : nFrames) / frameRate;

%% plot
if doPlot;
    figure('Name', 'RawTraces');
    plot(t, traceYFP, 'g');
    xlabel('Time [s]');
    ylabel('Raw trace');
    title(sprintf('Raw traces, %d frames, frameRate: %4.2f', nFrames, frameRate));
    if isCFP;
        hold on;
        plot(t, traceCFP, 'b');
        legend('YFP', 'CFP');
    else
        legend('YFP');
    end;
end;

%% dFF /dRR
if isCFP;

    R = traceYFP ./ traceCFP;
    
    methods = {'mean', 'median', 'prctile', 'polyfit', 'polyfitMean'};
    method = methods{iR0Method};
    switch method;
        case 'mean';
            R0 = nanmean(R);
        case 'median';
            R0 = nanmedian(R);
        case 'prctile';
            R0 = prctile(R, 30);
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
        
    %% downsample dRR
%     frameRateDS = frameRate / downSampleFactor;
%     dRRDS = decimate(dRR, downSampleFactor);
    if downSampleFactor;
        frameRateDS = frameRate / downSampleFactor; % the target frame rate
        tDS = t(1) : 1 / frameRateDS : t(end);
        dRRDS = interp1(t, dRR, tDS, 'linear')'; % could also try 'cubic' --> see help for interp1

        nDSFrames = size(dRRDS, 1);
    %     tDS = (1 : nDSFrames) / frameRateDS;
        if doPlot;
            figure('Name', 'DownSampledDRR');
            plot(tDS, dRRDS, 'k');
            xlabel('Time [s]');
            ylabel('Down sampled dRR');
            title(sprintf('Down-sampled dRR, %d frames, frameRate: %4.2f', nDSFrames, frameRateDS));
            legend('dRR');
        end;
        
    else
        tDS = t;
        dRRDS = dRR;
    end;

    %% filter dRR
    if sgolayFiltFrameSize > 1; dRRDSFilt = sgolayfilt(dRRDS, 1, sgolayFiltFrameSize);
    else dRRDSFilt = dRRDS;
    end;
    if doPlot && sgolayFiltFrameSize > 1;
        figure('Name', 'FilteredDRR');
        plot(tDS, dRRDSFilt, 'k');
        xlabel('Time [s]');
        ylabel('Filtered dRR');
        title('Filtered down-sampled dRR (Savitzky-Golay filter)');
        legend('dRR');
    end;
    
else

    F = traceYFP;
%     pF = polyfit(t', F, 2);
%     F0 = (pF(1) .* t .^ 2 + pF(2) .* t + pF(3))';
    F0 = prctile(F, 10);
    dFF = ((F - F0) ./ F0) * 100;
    if doPlot;
        figure('Name', 'F&F0');
        plot(t, F0, 'k');
        hold on;
        plot(t, F, 'r');
        xlabel('Time [s]');
        ylabel('F');
        title('F and F0 using YFP');
        legend('F0', 'F');
    end;
    
    figure('Name', sprintf('dFF for %s', ROIName));
    plot(t, dFF, 'k');
    xlabel('Time [s]');
    ylabel('dFF [%]');
    title(sprintf('dFF for %s', ROIName));
    legend('dFF');
    
end;

% %% only dRR / dFF
% if isCFP;
%     figure('Name', 'dRR');
%     plot(tDS, dRR, 'r');
% else
%     figure('Name', 'dFF');
%     plot(tDS, dFF, 'r');
% end;

set(0, 'DefaultFigureWindowStyle', 'normal');

end