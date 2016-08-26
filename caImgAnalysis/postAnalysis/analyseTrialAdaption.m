function [figHands, trialAdaptionStats] = analyseTrialAdaption(PSROIStats, saveName, stimIDs, doPlot)
    % Based on experimental paradigm, analyze if in a "block" of 5
    % presented stimuli per image stack, we can see a trial adaption. For
    % now we have 20 trials per stimulus, 4 blocks à 5 stimulation points.
    % Depending on the analysis metrics we get 4 repetitions per stim
    % location.
    %
    % Usage: [figHands, meanTrialAdaptionStats] = analyseTrialAdaption(PSROIStats, saveName, doPlot)
    %
    % The variable trialAdaptionStats contains: 4x5 matrix containing all
    % trial stats per ROI, average adaptation stats, a polynomial fit
    % (linear regression of adaptation) + residuals. The used metrics are
    % the maximum peak per trial and the sum of all evoked frames, which
    % are saved separately
    %
    % Author: A. van der Bourg, 2014
    
    
    %% Init
    nROIs = size(PSROIStats, 1);
    nStims = size(PSROIStats, 2);
    % Adaption analysis parameters
    stimPerBlock = 5;
    nOfBlocks = 4;
    plotLimits = [0, 1800];
    doPeakPlot = 0;
    
    %Each entry constists of a matrix with mean and SEM of mean of sum
    trialAdaptionStats.meanTrialAdaptionStats = cell(nROIs,nStims);
    trialAdaptionStats.allTrialAdaptionStats = cell(nROIs, nStims);
    %Additional analysis of peak response for each trial (max)
    trialAdaptionStats.peakTrialAdaptionStats = cell(nROIs, nStims);
    trialAdaptionStats.allTrialPeakAdaptionStats = cell(nROIs, nStims);
    
    %% plot each group of ROIs in separate figures
    figHands = [];
    for iROI = 1 : nROIs;
        roiAdaptionStats = zeros(2,5);
        roiPeakAdaptionStats = zeros(2,5);
        
        %% Sort by stim onset and create matrices for them
        for iStim = 1 : nStims
            roiAdaptionSum = zeros(stimPerBlock, nOfBlocks);
            roiAdaptionPeak = zeros(stimPerBlock, nOfBlocks);
            %Obtain block traces (note that preStim is included!!
            roiTrialTraces = PSROIStats{iROI, iStim};
            %Calculate the mean of the sum of all evoked frames for the
            %specified stimulus
            roiEvokedTraces = roiTrialTraces(:,21:40);
            % Use matlab matrix indexes to specifiy position. Transform
            % later to obtain desired format
            for iTrial = 1:size(roiEvokedTraces,1)
                roiAdaptionSum(iTrial) = sum(roiEvokedTraces(iTrial,:));
                roiAdaptionPeak(iTrial) = max(roiEvokedTraces(iTrial,:));
            end;
            % Inverse matrix to get desired format: a*b matrix: a=blockIndex,
            % b=stim position index
            roiAdaptionSum = roiAdaptionSum';
            roiAdaptionPeak = roiAdaptionPeak';
            %roiAdaptionStats(1,:) = sum(roiAdaptionSum) / nOfBlocks;
            %%%TODO: Fix
            roiAdaptionStats(1,:) = mean(roiAdaptionSum);
            roiPeakAdaptionStats(1,:) = mean(roiAdaptionPeak);
            roiAdaptionStats(2,:) = sem(roiAdaptionSum);
            roiPeakAdaptionStats(2,:) = sem(roiAdaptionPeak);
            trialAdaptionStats.meanTrialAdaptionStats{iROI,iStim} = roiAdaptionStats;
            trialAdaptionStats.allTrialAdaptionStats{iROI,iStim} = roiAdaptionSum;
            trialAdaptionStats.peakTrialAdaptionStats{iROI, iStim} = roiPeakAdaptionStats;
            trialAdaptionStats.allTrialPeakAdaptionStats{iROI, iStim} = roiAdaptionPeak;
            
            
            % Perform a polyfit of mean of sum and peak stats (including
            % residual analysis) for each block          
            for iBlock = 1:nOfBlocks
                blockValues = roiAdaptionStats(iBlock,:);
                x = 1:stimPerBlock;
                %First order polyfit
                blockFit = polyfit(x, blockValues,1);
                %equals: yfit = blockFit(1)*x + blockFit(2);
                yfit = polyval(blockFit,x);
                %Calculate the residuals
                yresid = blockValues - yfit;
                SSresid = sum(yresid.^2);
                SStotal = (length(blockValues)-1)*var(blockValues);
                rsq = 1 - SSresid/SStotal;
                trialAdaptionStats.roiRegressionResiduals(iBlock,1) = rsq;
                trialAdaptionStats.roiLinRegression(iBlock,1) = blockFit(1);
                trialAdaptionStats.roiLinRegression(iBlock,2) = blockFit(2);
                %A value of 0.87 would mean that 87% of the variance in the
                %variable blockValues is predicted!
            end;
            
            
            %Visualize adaption stats on a per ROI basis
            if doPlot
                %Mean of sum response plot
                if iStim ==1
                    figHands(end+1) = figure('Name', sprintf('%s, Trial adaption for ROI: %s', saveName, num2str(iROI)), 'NumberTitle', 'off'); %#ok<AGROW>
                end;
                subplot(2, nStims/2,iStim);
                subStats = trialAdaptionStats.meanTrialAdaptionStats{iROI, iStim};
                barNumber = size(subStats,2);
                hold on;
                axeH = bar(1:barNumber, subStats(1,:), 0.8); %last param: bardist
                set(axeH,'FaceColor',[1,1,1]*0.5,'LineWidth',1);
                errH = errorbar(subStats(1,:), subStats(2,:), '+');
                set(errH,'LineStyle','none', 'color',[1,1,1]*0.5);
                %suptitle('Mean of Evoked Response Metric - Pooled Stimuli');
                title(sprintf('%s', stimIDs{iStim,1}));
                set(gca, 'XTick', 1:barNumber, 'XLim', [0, barNumber+1], 'YLim', plotLimits);
                % TODO: get overall max and set limits!
                hold off;
                
            end;
            
            if doPeakPlot
                %Peak amplitude plot
                if iStim ==1
                    figHands(end+1) = figure('Name', sprintf('%s, Trial adaption for ROI: %s', saveName, num2str(iROI)), 'NumberTitle', 'off'); %#ok<AGROW>
                end;
                subplot(2, nStims/2,iStim);
                subStats = trialAdaptionStats.peakTrialAdaptionStats{iROI, iStim};
                barNumber = size(subStats,2);
                hold on;
                axeH = bar(1:barNumber, subStats(1,:), 0.8); %last param: bardist
                set(axeH,'FaceColor',[1,1,1]*0.5,'LineWidth',1);
                errH = errorbar(subStats(1,:), subStats(2,:), '+');
                set(errH,'LineStyle','none', 'color',[1,1,1]*0.5);
                %suptitle('Mean of Evoked Response Metric - Pooled Stimuli');
                title(sprintf('%s', stimIDs{iStim,1}));
                set(gca, 'XTick', 1:barNumber, 'XLim', [0, barNumber+1], 'YLim', plotLimits);
                % TODO: get overall max and set limits!
                hold off;
            end;
        end;
    end;
end