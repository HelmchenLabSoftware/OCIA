function [refImg, powerMaps, phaseMaps, meanDelay, stdDelay, pitchLims, recordDur, DCShifts, attribs, hashStruct] = OCIA_analysis_widefield_getCorrectedMaps(this, iFile1, iFile2)
% OCIA_analysis_widefield_getCorrectedMaps - [no description]
%
%       [refImg, powerMaps, phaseMaps, meanDelay, stdDelay, pitchLims, recordDur, DCShifts, attribs, hashStruct] = OCIA_analysis_widefield_getCorrectedMaps(this, iFile1, iFile2)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

%% get the data
% get information from selected file
[~, ~, ~, ~, ~, ~, ~, pitchLims, recordDur, attribs] = OCIA_analysis_widefield_getFileInfo(this, iFile1, true);
% cropping rectangle
cropRect = this.an.wf.cropRect;
% filters, shifts and thresholds
powFiltSet = this.an.wf.powerMapFilt;
phaFiltSet = this.an.wf.phaseMapFilt;

% get the data in memory
hashStruct = OCIA_analysis_widefield_getHashStruct(this, [iFile1, iFile2], 'WFCorrPowerAndPhaseMaps', '(base|evoked)Frames');
cachedData = ANGetCachedData(this, 'wf', hashStruct);

% if the data is not in cache yet, generate it
if isempty(cachedData);

    %% get the data
    % get data for up and down sweep
    powerMap = cell(2, 1); phaseMap = cell(2, 1); complexMap = cell(2, 1);
    [powerMap{1}, phaseMap{1}, pitchLims, recordDur, complexMap{1}] = OCIA_analysis_widefield_getPowerAndPhaseMap(this, iFile1);
    [powerMap{2}, phaseMap{2}, pitchLims2, ~, complexMap{2}] = OCIA_analysis_widefield_getPowerAndPhaseMap(this, iFile2);
    % invert cell-array order if sweeps are not in right order (if up is not the first element)
    if pitchLims(end) < pitchLims2(end);
        powerMap = flipud(powerMap);
        phaseMap = flipud(phaseMap);
        complexMap = flipud(complexMap);
        pitchLims = fliplr(pitchLims);
    end;
    
    powerMapComb = (powerMap{1} + powerMap{2}) ./ 2;

    % get information about selected file
    [~, ~, ~, refImg] = OCIA_analysis_widefield_getFileInfo(this, iFile1);
    % crop image if needed
    if ~isempty(refImg) && ~isempty(this.an.wf.cropRect);
        refImg = refImg(cropRect(2) + (0 : cropRect(4) - 1), cropRect(1) + (0 : cropRect(3) - 1));
    end;
    
%     %% DC Shift
%     DCShifts = zeros(3, 1);
%     for iDir = 1 : 2;
%         % get threshold of power map
%         powerMapMask = powerMap{iDir} < thresh(iff(numel(thresh) >= iDir, iDir, 1));
%         % calculate DC shift of unresponsive areas and correct for it
%         DCShifts(iDir) = nanmean(phaseMap{iDir}(powerMapMask));
%         phaseMap{iDir} = phaseMap{iDir} - iff(isnan(DCShifts(iDir)), 0, DCShifts(iDir));
%     end;
    
    %% filter maps
    gaussFiltPow = fspecial('gaussian', powFiltSet(1 : 2), powFiltSet(3));
    gaussFiltPha = fspecial('gaussian', powFiltSet(1 : 2), powFiltSet(3));
    for iDir = 1 : 2;
        if all(powFiltSet(1 : 3)) > 0; powerMap{iDir} = imfilter(powerMap{iDir}, gaussFiltPow); end;
        if all(powFiltSet(4 : 5)) > 0; powerMap{iDir} = medfilt2(powerMap{iDir}, powFiltSet(4 : 5)); end;
        if all(phaFiltSet(1 : 3)) > 0; phaseMap{iDir} = imfilter(phaseMap{iDir}, gaussFiltPha); end;
        if all(phaFiltSet(4 : 5)) > 0; phaseMap{iDir} = medfilt2(phaseMap{iDir}, phaFiltSet(4 : 5)); end;    
    end;
    
    %% get delay-corrected maps
    % delay-corrected map
    corrMap = complexMap{2} ./ complexMap{1};
    parfor iBin = 1 : numel(corrMap);
        corrMap(iBin) = angle(corrMap(iBin));
    end;
    corrMap = (corrMap + pi) / 2;
    
    %% DC Shift
    DCShifts = zeros(3, 1);
%     % get threshold of power map
%     powerMapMask = powerMap{1} >= this.an.wf.powerMapThresh(1) & powerMap{2} >= this.an.wf.powerMapThresh(1);
%     % calculate DC shift of unresponsive areas and correct for it
%     DCShifts(3) = nanmean(corrMap(~powerMapMask));
%     corrMap = corrMap - iff(isnan(DCShifts(3)), 0, DCShifts(3));
    
    % delay map
    delayMap = complexMap{1} .* complexMap{2};
    parfor iBin = 1 : numel(delayMap);
        delayMap(iBin) = angle(delayMap(iBin));
    end;
    
    % set things to 0
%     DCShifts = zeros(3, 1);
    [meanDelay, stdDelay] = deal(0);
    
    %{
    %% compute real maps from complex map
    nBins = this.an.wf.nBins;
    cMap = 'hsv';
    
    figure('Name', 'From complex maps', 'NumberTitle', 'off', 'Position', [1940, 245, 1230, 500]);
    a = complexMap{1};
    a = reshape(arrayfun(@(i)angle(a(i)), 1 : numel(a)), nBins(1), nBins(2));
    subplot(3, 5, 1); imagesc(a); colormap(cMap); colorbar(); title('1');  
    a = complexMap{2};
    a = reshape(arrayfun(@(i)angle(a(i)), 1 : numel(a)), nBins(1), nBins(2));  
    subplot(3, 5, 6); imagesc(-a); colormap(cMap); colorbar(); title('2');
    
    a = complexMap{1} ./ complexMap{2};
    a = reshape(arrayfun(@(i)angle(a(i)), 1 : numel(a)), nBins(1), nBins(2));
    subplot(3, 5, 2); imagesc(a); colormap(cMap); colorbar(); title('c1 / c2');    
    subplot(3, 5, 7); imagesc(-a); colormap(cMap); colorbar(); title('-(c1 / c2)');
    a = (complexMap{1} ./ complexMap{2});
    a = reshape(arrayfun(@(i)(angle(a(i)) + pi) / 2, 1 : numel(a)), nBins(1), nBins(2));
    subplot(3, 5, 12); imagesc(a); colormap(cMap); colorbar(); title('((c1 / c2) + pi) / 2');
    a = complexMap{2} ./ complexMap{1};
    a = reshape(arrayfun(@(i)angle(a(i)), 1 : numel(a)), nBins(1), nBins(2));
    subplot(3, 5, 3); imagesc(a); colormap(cMap); colorbar(); title('c2 / c1');
    subplot(3, 5, 8); imagesc(-a); colormap(cMap); colorbar(); title('-(c2 / c1)');
    a = (complexMap{2} ./ complexMap{1});
    a = reshape(arrayfun(@(i)(angle(a(i)) + pi) / 2, 1 : numel(a)), nBins(1), nBins(2));
    subplot(3, 5, 13); imagesc(a); colormap(cMap); colorbar(); title('(c2 / c1) / 2');
    
    a = complexMap{1} .* complexMap{2};
    a = reshape(arrayfun(@(i)angle(a(i)), 1 : numel(a)), nBins(1), nBins(2));
    subplot(3, 5, 4); imagesc(a); colormap(cMap); colorbar(); title('c1 * c2');
    subplot(3, 5, 9); imagesc(-a); colormap(cMap); colorbar(); title('-(c1 * c2)');    
    a = complexMap{2} .* complexMap{1};
    a = reshape(arrayfun(@(i)angle(a(i)), 1 : numel(a)), nBins(1), nBins(2));
    subplot(3, 5, 5); imagesc(a); colormap(cMap); colorbar(); title('c2 * c1');
    subplot(3, 5, 10); imagesc(-a); colormap(cMap); colorbar(); title('-(c2 * c1)');
    
%     %{
    
    figure('Name', 'From phase maps', 'NumberTitle', 'off', 'Position', [25, 200, 1860, 315]);
    subplot(3, 5, 1); imagesc(phaseMap{1}); colormap(cMap); colorbar(); title('1');    
    subplot(3, 5, 6); imagesc(phaseMap{2}); colormap(cMap); colorbar(); title('2'); 
    a = phaseMap{1} - phaseMap{2};
    subplot(3, 5, 2); imagesc(a); colormap(cMap); colorbar(); title('p1 - p2');    
    subplot(3, 5, 7); imagesc(-a); colormap(cMap); colorbar(); title('-(p1 - p2)');    
    a = phaseMap{2} - phaseMap{1};
    subplot(3, 5, 3); imagesc(a); colormap(cMap); colorbar(); title('p2 - p1');
    subplot(3, 5, 8); imagesc(-a); colormap(cMap); colorbar(); title('-(p2 - p1)');
    a = phaseMap{1} + phaseMap{2};
    subplot(3, 5, 4); imagesc(a); colormap(cMap); colorbar(); title('p1 + p2');    
    subplot(3, 5, 9); imagesc(-a); colormap(cMap); colorbar(); title('-(p1 + p2)');    
    a = phaseMap{2} + phaseMap{1};
    subplot(3, 5, 5); imagesc(a); colormap(cMap); colorbar(); title('p2 + p1');
    subplot(3, 5, 10); imagesc(-a); colormap(cMap); colorbar(); title('-(p2 + p1)');
    
    %}
    
    
%     %% compute real maps from phase maps
%     % delay-corrected map
%     diffPhaseMapUpMinDown = (phaseMap{1} - phaseMap{2}) / 2;
%     diffPhaseMapUpMinDown = diffPhaseMapUpMinDown + phaseShift(iff(numel(phaseShift) >= 2, 2, 1));
%     diffPhaseMapUpMinDown(diffPhaseMapUpMinDown < -pi) = diffPhaseMapUpMinDown(diffPhaseMapUpMinDown < -pi) + 2 * pi;
%     diffPhaseMapUpMinDown(diffPhaseMapUpMinDown > pi) = diffPhaseMapUpMinDown(diffPhaseMapUpMinDown > pi) - 2 * pi;
%     
%     % delay map
%     sweepDur = 1 / stimFreq;
%     diffPhaseMapUpPlusDown = ((((phaseMap{1} + phaseMap{2} - 2 * phaseShift(1)) / 2) + pi) / (2 * pi)) * sweepDur;
%     diffPhaseMapUpPlusDown = diffPhaseMapUpPlusDown + phaseShift(iff(numel(phaseShift) >= 3, 3, 1));
%     while any(diffPhaseMapUpPlusDown > sweepDur);
%         diffPhaseMapUpPlusDown(diffPhaseMapUpPlusDown > sweepDur) = diffPhaseMapUpPlusDown(diffPhaseMapUpPlusDown > sweepDur) - sweepDur;
%     end;
%     
%     %% DC Shift
%     % get lower threshold of both power map
%     powerMapMask = powerMap{1} < thresh(1) | powerMap{2} < thresh(iff(numel(thresh) >= 2, 2, 1));
%     % calculate DC shift of unresponsive areas and correct for it
%     DCShifts(3) = nanmean(corrMap(powerMapMask));
%     corrMap = corrMap - iff(isnan(DCShifts(3)), 0, DCShifts(3));
%     corrMap(powerMapMask) = NaN;
%     delayMap(powerMapMask) = NaN;
%     
%     %% calculate delay variables
%     meanDelay = nanmean(delayMap(:));
%     stdDelay = nanstd(delayMap(:));

%     %% threshold maps
%     for iDir = 1 : 2;
%         % get threshold of power map
%         powerMapMask = powerMap{iDir} < thresh(iff(numel(thresh) >= iDir, iDir, 1));
%         % mask values of phase map that do not have enough power with NaN
%         phaseMap{iDir}(powerMapMask) = NaN;
%     end;
    
    %% store
    powerMaps = [powerMap; {powerMapComb}];
    phaseMaps = [phaseMap; corrMap; delayMap];    
    
    % store the variables in the cached structure
    cachedData = struct('refImg', refImg, 'powerMaps', { powerMaps }, 'phaseMaps', { phaseMaps }, 'DCShifts', DCShifts, ...
        'meanDelay', meanDelay, 'stdDelay', stdDelay, 'dataType', 'WFCorrPowerAndPhaseMaps', 'params', hashStruct);
    % store the data in memory
    ANStoreCachedData(this, 'wf', hashStruct, cachedData);
    
% if data was directly in memory, fetch it
else
    
    % fetch the data
    ANShowHideMessage(this, 1, 'Loading data from cache ...');
    refImg = cachedData.refImg;
    powerMaps = cachedData.powerMaps;
    phaseMaps = cachedData.phaseMaps;
    meanDelay = cachedData.meanDelay;
    stdDelay = cachedData.stdDelay;
    DCShifts = cachedData.DCShifts;

end;

end
