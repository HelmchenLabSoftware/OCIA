function [figHands, eventDetectInterROICorr, roiDistance] = eventDetectionCorrelationAnalysis(ROISet, dimX, dimY, pixelCalibration, models, eventMat, stim)
    % Analyse the relationship between instantaneous firing rate or spike
    % train for each ROI with each other ROI. In addition evaluate the
    % correlation in relationship to the distance of each ROI combination
    % (the center of mass of each ROI is taken and the pixel-calibrated
    % distance used as a "measure of distance" between ROIs)
    % based on Golshani et al., 2009, Fig 2 for example data
    %
    % Usage: [figHands, eventDetectInterROICorr, roiDistance] = eventDetectionCorrelationAnalysis(ROISet, dimX, dimY, pixelCalibration, models, eventMat, stim)
    %
    % Author: A. van der Bourg, 2014
    
    %% Init varibles
    nROIs = size(ROISet, 1);
    ROIPos = ROISet(1 : (nROIs - 1), 2);
    %plotLimits = [plotLimits(1)+10, plotLimits(2)];
    % extract the stimuli times
    stimFrames = find(stim>0);
    % extract the stimulus 'IDs' by converting the stim index into a string (the index of the stimuli)
    stimIDIndexes = stim(stim > 0);
    stimIDs = cell(1, numel(stimIDIndexes));
    for n = 1 : numel(stimIDIndexes);
        stimIDs{n} = num2str(stimIDIndexes(n));
    end;
    nStims =numel(unique(stimIDs));
    %Number of stim-presentations per condition
    stimPres = length(stimFrames) ./ length(nStims);

    %TODO: remove hard-coded variables!!
    blockSize = 579;
    preStimFrames = 80;
    
    % H37L specific pixel distance calibration
    xCalibration = 100 / 160;
    yCalibration = 100 / 133;
    
      
    %% Find ROI locations
    ROICenter = zeros(numel(ROIPos), 2);
    for iROI = 1 : numel(ROIPos);
        
        [x, y] = find(ROIPos{iROI});
        ROICenter(iROI, 1) = mean(y);
        ROICenter(iROI, 2) = mean(x);
    end;
    
    %% Perform Inter ROI corr analysis on deconvolved calcium trace
    crossCorrMat = zeros(nROIs-1, nROIs-1);
    distMat = zeros(nROIs-1, nROIs-1);
    pValCorrMat = zeros(nROIs-1, nROIs-1);
    % obtain spontaneous set
    [~, spontIndx] = find(stimIDIndexes==7);
    if spontIndx(1) == 1
        spontBlockIndx = 1;
    else
        spontBlockIndx= stimFrames(spontIndx(1))-preStimFrames;
    end;
    
    %Calculate pairwise correlation coefficient on all pairs of deconvolved
    %trace
    modelMat = cell2mat(models);
    for iROI = 1:nROIs-1
        for jROI = 1:nROIs-1
            %Calculate cross-correlation
            [r,p] = corrcoef(modelMat(iROI, spontBlockIndx:(spontBlockIndx+blockSize-1)), modelMat(jROI, spontBlockIndx:(spontBlockIndx+blockSize-1)), 'rows', 'pairwise');
            crossCorrMat(iROI, jROI) = r(1,2);
            pValCorrMat(iROI, jROI) = p(1,2);
            %Obtain pixel locations
            iROILoc = [ROICenter(iROI, 1), ROICenter(iROI,2)];
            jROILoc = [ROICenter(jROI, 1), ROICenter(jROI,2)];
            %Calculate absolute x and y distances (calibrated)
            absXDist = abs(iROILoc(1)-jROILoc(1)) * xCalibration;
            absYDist = abs(iROILoc(2)-jROILoc(2)) * yCalibration;
            %Calculate distance (c=sqrt(x^2-y^2))
            distMat(iROI, jROI) = sqrt(absXDist^2 + absYDist^2);
        end;
    end;
    %% Plot correlation data
    figHands = [];
    figHands(end+1) = figure;
    imagesc(crossCorrMat);
    colorbar('CLim', [0,1]);
    
    %% Plot distance correlation relationship for specified region
    %{
    % Distance binning deltaDist = 5 microns

    %}
    % 1. Iterate through binning distance and find indices
    % 2. retrieve all values
    % 3. take mean +- sem
    % 4. plot distribution
    corrMeans = [];
    corrSTDs = [];
    distVect = 5:5:100;
    %Only take upper triangle elements
    diagCrossCorrMat = triu(crossCorrMat);
    diagCrossCorrMat(logical(eye(size(diagCrossCorrMat)))) = 0;
    distMat = triu(distMat);
    diagDistMat(logical(eye(size(distMat)))) =0;
    for iDist = 10:5:100
        hits = find(distMat<iDist & distMat>(iDist-5));
        corrVals = diagCrossCorrMat(hits);
        corrMeans(end+1) = mean (corrVals);
        corrSTDs(end+1) = std(corrVals);
    end
    figHands(end+1) = figure;
    errorbar(corrMeans, corrSTDs);
    set(gca, 'XTick', 1:25, 'XTickLabel', 5:5:100);
    
    %% Plot fraction active
    binaryEvents = full(spones(eventMat));
    events = sum(binaryEvents);
    normEvents = 100/size(binaryEvents,1)*events;
    % Smooth normEvents
    normSGEvents = sgolayfilt(normEvents, 1, 5);
    figHands(end+1) = figure;
    plot(normSGEvents(spontBlockIndx:(spontBlockIndx+blockSize-1)), 'Color', 'black');
    set(gca, 'XLim', [spontBlockIndx,(spontBlockIndx+blockSize-1)], 'XTickLabel', []);
    
    eventDetectInterROICorr = crossCorrMat;
    roiDistance = distMat;
end