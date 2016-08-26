function [meanNoisesAllRangesROI, overallThresh] = analyseNoiseLevel(ROIStats, ROISet, ...
    noiseThreshFactor, saveName, doSavePlot, showLegendAndTitles, doTruncation)
    
    nROIs = size(ROIStats, 1);
    nRuns = size(ROIStats, 2);
    nFrames = size(ROIStats{1, 1}, 2);
    
    frameRanges = {};
    frameRangeColors = {};
    frameRangeNames = {};
    
    nFramesBeg = 10;
    frameRanges = [frameRanges, 1 : nFramesBeg];
    frameRangeColors = [frameRangeColors, 'green'];
    frameRangeNames = [frameRangeNames, 'Noise@Beg'];
    
    nFramesEnd = 40;
    frameRanges = [frameRanges, nFrames - nFramesEnd + 1 : nFrames];
    frameRangeColors = [frameRangeColors, 'blue'];
    frameRangeNames = [frameRangeNames, 'Noise@End'];
    
    frameRanges = [frameRanges, 1 : nFrames];
    frameRangeColors = [frameRangeColors, 'red'];
    frameRangeNames = [frameRangeNames, 'NoiseOverall'];
    
    nStims = 30; dutyCycle = 15; baseFrames = 5; % in frames
    stimFrames = (1 : nStims) * dutyCycle - baseFrames;
    interStimFrames = [];
    for iStim = 1 : numel(stimFrames);
        interStimFrames = [interStimFrames (stimFrames(iStim) - baseFrames : stimFrames(iStim) - 1)]; %#ok<AGROW>
    end;
    
    frameRanges = [frameRanges, interStimFrames];
    frameRangeColors = [frameRangeColors, 'yellow'];
    frameRangeNames = [frameRangeNames, 'NoiseInterStim'];

    nFrameRanges = numel(frameRanges);
    
    % preallocate the noise holding variable
    noises = cell(nFrameRanges, 1);
    for iRange = 1 : nFrameRanges; noises{iRange} = zeros(nROIs, nRuns); end;
    stdDevFactor = 2; % traces contains ~95% of the value
        
    for iROI = 1 : nROIs;

        % extract ROIStats data to a nFrames x nRuns matrix
        ROIStatsForROI = reshape(cell2mat(ROIStats(iROI, :)), nFrames, nRuns);

        if doTruncation > 1;
            N = ceil(sqrt(nRuns));
            M = N;
            if (M - 1) * N >= nRuns; M = M - 1; end;
            figHands = cell(nFrameRanges, 1);
            for iRange = 1 : nFrameRanges;
                figHands{iRange} = figure('Name', sprintf('%s_TruncPlotROI%d_Range%d', saveName, iROI, iRange), ...
                    'NumberTitle', 'off');
            end;
        end;

        for iRun = 1 : nRuns;

            trace = ROIStatsForROI(:, iRun);
            noise = nanstd(trace);
            peakRemoveThreshold = nanmean(trace) + noise;
            truncTrace = trace;
            truncTrace(truncTrace > peakRemoveThreshold) = peakRemoveThreshold;
            truncNoise = stdDevFactor * nanstd(truncTrace);

            ROIStatsForROI(:, iRun) = truncTrace;

            if doTruncation > 0;
                for iRange = 1 : nFrameRanges;
                    c = frameRangeColors{iRange};
                    gCol = repmat(0.7, 1, 3);
                    figure(figHands{iRange});
                    subplot(M, N, iRun);
                    plot(frameRanges{iRange}, trace(frameRanges{iRange}), 'Color', gCol);
                    xLims = [min(frameRanges{iRange}) max(frameRanges{iRange})];
                    line(xLims, mean(trace) + repmat(noise, 1, 2), 'LineStyle', '--', 'Color', gCol);
                    line(xLims, mean(trace) - repmat(noise, 1, 2), 'LineStyle', '--', 'Color', gCol);
                    hold on;
                    plot(frameRanges{iRange}, truncTrace(frameRanges{iRange}), 'Color', c);
                    line(xLims, mean(truncTrace) + repmat(truncNoise, 1, 2), 'LineStyle', '--', 'Color', c);
                    line(xLims, mean(truncTrace) - repmat(truncNoise, 1, 2), 'LineStyle', '--', 'Color', c);
                    title({sprintf('Run%d', iRun), ...
                        sprintf('\\fontsize{8}noise: %3.1f, truncNoise: %3.1f', noise, truncNoise)});
                end;
            end;

        end;
        
        % get the noise level as the standard deviation for each run
        for iRange = 1 : nFrameRanges;
            noises{iRange}(iROI, :) = nanstd(ROIStatsForROI(frameRanges{iRange}, :));
        end;
        
    end;
    
    % get the mean and the standard deviation of the noise for each ROI and use to compute a threshold
    meanNoiseForROI = cell(nFrameRanges, 1);
    stdNoiseForROI = cell(nFrameRanges, 1);
    noiseThresh = cell(nFrameRanges, 1);
    for iRange = 1 : nFrameRanges;
        meanNoiseForROI{iRange} = nanmean(noises{iRange}, 2); % mean of the noises for each ROI
        stdNoiseForROI{iRange} = nanstd(noises{iRange}, 0, 2); % standard deviation of the noises
        
        % overal noise thresh for each range, using the mean noise levels and their standard deviation
        noiseThresh{iRange} = nanmean(meanNoiseForROI{iRange}) ...
            + noiseThreshFactor * nanstd(meanNoiseForROI{iRange});
    end;
    
    ROIStdDevThreshFactor = 1.5;
    noisyRuns = cell(nFrameRanges, 1);
    for iRange = 1 : nFrameRanges;
        noisyRuns{iRange} = false(nROIs, nRuns);
        for iROI = 1 : nROIs;
            noisyRuns{iRange}(iROI, :) = noises{iRange}(iROI, :) ...
                > meanNoiseForROI{iRange}(iROI) + ROIStdDevThreshFactor * stdNoiseForROI{iRange}(iROI);
        end;
    end;
    
%     [i, j] = ind2sub([nROIs, nRuns], find(noisyRuns{iRange}));
%     for n = 1 : numel(i);
%         fprintf('Noisy runs: ROI %d, run %d\n', i(n), j(n));
%     end;
    
    meanNoisesAllRangesROI = nanmean(cell2mat(meanNoiseForROI'), 2);
    nPilNoise = meanNoisesAllRangesROI(end);
    overallMeanNoise = nanmean(meanNoisesAllRangesROI(:));
    overallThresh = nanmean(cell2mat(noiseThresh));
    
    toExcludeROIs = find(meanNoisesAllRangesROI > overallThresh);
    
    %% do the plot
    if doSavePlot;
        figH = figure('Name', saveName, 'NumberTitle', 'off');
        
%         grayVal = 0.9;
%         for iRange = 1 : nFrameRanges;
%             plotHandles = plot(noises{iRange});
%             hold on;
%             
%             for iRun = 1 : nRuns;
%                 set(plotHandles(iRun), 'Color', repmat(grayVal, 1, 3));
%             end;
%             
%             for iROI = 1 : nROIs;
%                 for iRun = 1 : nRuns;
%                     if noisyRuns{iRange}(iROI, iRun);
%                         scatter(iROI, noises{iRange}(iROI, iRun), 'x', 'red');
%                     end;
%                 end;
%             end;
%         end;
        
        hold on;
        toLegendHandles = zeros(nFrameRanges * 3 + 1, 1);
        for iRange = 1 : nFrameRanges;
            commons = {'Color', frameRangeColors{iRange}};
            toLegendHandles((iRange - 1) * 3 + 1)  = errorbar((1 : nROIs) + 0.1 * iRange, meanNoiseForROI{iRange}, ...
                stdNoiseForROI{iRange}, commons{:});
            toLegendHandles((iRange - 1) * 3 + 2) = line(1 : nROIs, ...
                repmat(nanmean(meanNoiseForROI{iRange}), 1, nROIs), commons{:});
            toLegendHandles((iRange - 1) * 3 + 3) = line(1 : nROIs, ...
                repmat(noiseThresh{iRange}, 1, nROIs), 'LineStyle', ':', commons{:});
        end;

        hold off;
        
        toLegendHandles(end) = line(1 : nROIs, repmat(overallMeanNoise, 1, nROIs), 'Color', 'black');

        xlabel('ROIs');
        ylabel('Noise level [% dFF/dRR]');
        xlim([0.5, nROIs + 0.5]);
        set(gca, 'XTick', 1 : nROIs, 'XTickLabel', ROISet(:, 1));

        if showLegendAndTitles;

            legendEntries = cell(nFrameRanges * 3 + 1, 1);
            for iRange = 1 : nFrameRanges;
                legendEntries{(iRange - 1) * 3 + 1} = sprintf('%s \\pm SD (N=%d)', ...
                    frameRangeNames{iRange}, numel(frameRanges{iRange}));
                legendEntries{(iRange - 1) * 3 + 2} = [frameRangeNames{iRange} ' Mean'];
                legendEntries{(iRange - 1) * 3 + 3} = [frameRangeNames{iRange} ' Thresh'];
            end;
            legendEntries{end} = 'Mean Noise Level';

            hLeg = legend(toLegendHandles, legendEntries, 'Location', 'EastOutside');
%             hLeg = legend(toLegendHandles, legendEntries, 'Location', 'BestOutside');

            toExcludeROIsAsString = sprintf(repmat('%s ', 1, numel(toExcludeROIs)), ROISet{toExcludeROIs, 1});
            if isempty(toExcludeROIsAsString); toExcludeROIsAsString = '-'; end;
            title(sprintf('%s - mean noise: %3.1f%%, NPil noise: %3.1f%%\nExcluded ROIs: %s', saveName, ...
                overallMeanNoise, nPilNoise, toExcludeROIsAsString), ...
                'Interpreter', 'none');
        end;
    
        makePrettyFigure(figH);
        set(toLegendHandles(end), 'LineWidth', 3);
        set(hLeg, 'FontSize', 8);
        
        saveFigToDir(figH, saveName, 'NoiseLevel', doSavePlot, 1, 1);
            
        
    end;
   
end
