%% #OCIA:OCIA_dataProcess_imgData_fShift
function [isValid, unvalidReason] = OCIA_dataProcess_imgData_fShift(this, iDWRow, varargin)

% by default, row is valid
isValid = true;
unvalidReason = '';

% get the selected processing steps and this row's processing state
selProcOpts = this.an.procOptions.id(get(this.GUI.handles.dw.procOptsList, 'Value'));
rowProcState = getData(this, iDWRow, 'procImg', 'procState');
% if this processing is not required or if data is not imaging data or if data was already processed, abort
if ~any(strcmp(selProcOpts, 'fShift')) || ~strcmp(get(this, iDWRow, 'rowType'), 'Imaging data') ...
        || any(strcmp(rowProcState, 'fShift'));
    return;
end;

% get whether to do plots or not
if nargin > 2;  doPlots = varargin{1};
else            doPlots = 0;
end;
        
% check if the processing should be aborted
[doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;

%% init
rowID = DWGetRowID(this, iDWRow);
rowIDTitle = sprintf('Frame shift correction for %s (%d)', rowID, iDWRow);
figCommons = { 'NumberTitle', 'off', 'WindowStyle', 'docked' }; % figure options
    
% make sure data is fully loaded
DWLoadRow(this, iDWRow, 'full');

% get the imaging data
imgData = get(this, iDWRow, 'data');
imgData = imgData.procImg.data;
imgDim = size(imgData{this.an.img.preProcChan});
% correct for frame shifting artifact by analysing the correlations in the average image of the selected channel
avgImg = nanmean(imgData{this.an.img.preProcChan}, 3);

% range on which the average image should be analysed (exclude side artifacts)
percExcl = 0.2;
xRange = round([imgDim(1) * percExcl, imgDim(1) * (1 - percExcl)]);
yRange = round([imgDim(2) * percExcl, imgDim(2) * (1 - percExcl)]);
        
% check if the processing should be aborted
[doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;

% do a line-wise correlation
xCorrs = zeros(1, xRange(end) - xRange(1) + 1);
xIndOffset = xRange(1) - 1; % offset for indexing
parfor x = xRange(1) : xRange(end);
    xCorrs(x - xIndOffset) = corr(avgImg(:, x), avgImg(:, x - 1), 'rows', 'pairwise'); %#ok<*PFBNS>
end;
yCorrs = zeros(1, yRange(end) - yRange(1) + 1);
yIndOffset = yRange(1) - 1; % offset for indexing
parfor y = yRange(1) : yRange(end);
    yCorrs(y - yIndOffset) = corr(avgImg(y, :)', avgImg(y - 1, :)', 'rows', 'pairwise');
end;
        
% check if the processing should be aborted
[doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;

% get the correlation thresholds using a certain number of times the standard deviation
corrTheshFactor = this.an.fShift.corrThreshFactor;
% calculate correlations for X and Y differently
corrThreshX = nanmean(xCorrs) - corrTheshFactor * (max(xCorrs) - min(xCorrs));
corrThreshY = nanmean(yCorrs) - corrTheshFactor * (max(yCorrs) - min(yCorrs));
% make boundaries for correlations
corrThreshX = max(min(corrThreshX, this.an.fShift.maxCorrThresh), this.an.fShift.minCorrThresh);
corrThreshY = max(min(corrThreshY, this.an.fShift.maxCorrThresh), this.an.fShift.minCorrThresh);
% set a minimum of correlation difference in order to investigate the frame shift
corrDiffThresh = 0.1;

% correct on the X-axis
if any(xCorrs < corrThreshX);
    
    % get the "derivative" of the correlation
    diffXCorrs = abs(diff(xCorrs));
    
    if any(diffXCorrs > corrDiffThresh);
        
        % get a fresh copy of the data to change
        imgDataToCorrect = this.dw.table{iDWRow, strcmp(this.dw.tableIDs, 'data')}.procImg.data;
        % get the line where the shift occured
        [maxXCorrDiff, maxXCorrDiffInd] = max(diffXCorrs);
        xLineInd = maxXCorrDiffInd + xRange(1) - 1;
        % reshape the images accordingly
        imgDataCorr = cellfun(@(imgs) horzcat(imgs(:, xLineInd : end, :), imgs(:, 1 : xLineInd - 1, :)), ...
            imgDataToCorrect, 'UniformOutput', false);
        
        % average image of the selected channel of the corrected data
        avgImgCorr = nanmean(imgDataCorr{this.an.img.preProcChan}, 3);
        
        % see if it actually made it better: re-do a line-wise correlation
        xCorrs2 = zeros(1, xRange(end) - xRange(1) + 1);
        parfor x = xRange(1) : xRange(end);
            xCorrs2(x - xIndOffset) = corr(avgImgCorr(:, x), avgImgCorr(:, x - 1), 'rows', 'pairwise'); %#ok<*PFBNS>
        end;
        % get the "derivative" of the correlation
        diffXCorrs2 = abs(diff(xCorrs2));
        % get the max correlation drop
        maxXCorrDiff2 = max(diffXCorrs2);
        % update the thresholds
        corrThreshX2 = median(xCorrs) - corrTheshFactor * std(xCorrs);
        
        % check if the processing should be aborted
        [doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;

        % only apply the change if the "corrected" image is actually better than the original
        if ~any(xCorrs2 < corrThreshX2) || ~any(diffXCorrs2 > corrDiffThresh) || maxXCorrDiff2 < maxXCorrDiff;
            % store the change
            this.dw.table{iDWRow, strcmp(this.dw.tableIDs, 'data')}.procImg.data = imgDataCorr;
            % display message
            showMessage(this, sprintf(' - %s: shift correction done on X.', rowIDTitle));
        else
            % keep the original image as "corrected"
            avgImgCorr = avgImg;
        end;
    end;
    
end;

% correct on the Y-axis
if any(yCorrs < corrThreshY);
    
    % get the "derivative" of the correlation
    diffYCorrs = abs(diff(yCorrs));
    
    if any(diffYCorrs > corrDiffThresh);
        % get a fresh copy of the data to change
        imgDataToCorrect = this.dw.table{iDWRow, strcmp(this.dw.tableIDs, 'data')}.procImg.data;
        % get the line where the shift occured
        [maxYCorrDiff, maxYCorrDiffInd] = max(diffYCorrs);
        yLineInd = maxYCorrDiffInd + yRange(1) - 1;
        % reshape the images accordingly
        imgDataCorr = cellfun(@(imgs) vertcat(imgs(yLineInd : end, :, :), imgs(1 : yLineInd - 1, :, :)), ...
            imgDataToCorrect, 'UniformOutput', false);
        
        % average image of the selected channel of the corrected data
        avgImgCorr = nanmean(imgDataCorr{this.an.img.preProcChan}, 3);
        
        % see if it actually made it better: re-do a line-wise correlation
        yCorrs2 = zeros(1, yRange(end) - yRange(1) + 1);
        parfor y = yRange(1) : yRange(end);
            yCorrs2(y - yIndOffset) = corr(avgImgCorr(y, :)', avgImgCorr(y - 1, :)', 'rows', 'pairwise');
        end;
        % get the "derivative" of the correlation
        diffYCorrs2 = abs(diff(yCorrs2));
        % get the max correlation drop
        maxYCorrDiff2 = max(diffYCorrs2);
        % update the thresholds
        corrThreshY2 = median(yCorrs) - corrTheshFactor * std(xCorrs);
        
        % check if the processing should be aborted
        [doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;

        % only apply the change if the "corrected" image is actually better than the original
        if ~any(yCorrs2 < corrThreshY2) || ~any(diffYCorrs2 > corrDiffThresh) || maxYCorrDiff2 < maxYCorrDiff;
            % store the change
            this.dw.table{iDWRow, strcmp(this.dw.tableIDs, 'data')}.procImg.data = imgDataCorr;
            % display message
            showMessage(this, sprintf(' - %s: shift correction done on Y.', rowIDTitle));
        else
            % keep the original image as "corrected"
            avgImgCorr = avgImg;
        end;
    end;
    
end;
        
% check if the processing should be aborted
[doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;

% mark row as processed for frame shift correction
setData(this, iDWRow, 'procImg', 'procState', [rowProcState { 'fShift' }]);

%%  plotting
% if requested, plot a figure illustrating what has been done
if doPlots > 0;
    
    % correlation values
    figure('Name', sprintf('%s: line-wise correlations', rowIDTitle), figCommons{:});
    legendTexts = {'Corr. on X', 'Corr. on Y', 'Corr. thresh. X', 'Corr. thresh. Y'};
    hold(gca, 'on');
    plot(xRange(1) : xRange(end), xCorrs, 'r');
    plot(yRange(1) : yRange(end), yCorrs, 'b');
    xLims = get(gca, 'XLim');
    plot(xLims(1) : xLims(end), repmat(corrThreshX, 1, xLims(end) - xLims(1) + 1), 'r:');
    plot(xLims(1) : xLims(end), repmat(corrThreshY, 1, xLims(end) - xLims(1) + 1), 'b:');
    if exist('diffXCorrs', 'var') || exist('diffYCorrs', 'var');
        plot(xLims(1) : xLims(end), repmat(corrDiffThresh + 0.2, 1, xLims(end) - xLims(1) + 1), 'g--');
        legendTexts{end + 1} = 'Corr. thresh. Diff.';
    end;
    if exist('diffXCorrs', 'var');
        plot(0.5 + (xRange(1) : xRange(end) - 1), diffXCorrs + 0.2, 'r.-');
        legendTexts{end + 1} = 'Diff. X corr.';
    end;
    if exist('diffYCorrs', 'var');
        plot(0.5 + (xRange(1) : xRange(end) - 1), diffYCorrs + 0.2, 'g.-');
        legendTexts{end + 1} = 'Diff. Y corr.';
    end;
    ylim([0 1]);
    legend(legendTexts);
    
    % if there was a correction done
    if exist('avgImgCorr', 'var');
        figure('Name', sprintf('%s: average images', rowIDTitle), figCommons{:});
        subplot(1, 2, 1); imshow(linScale(avgImg));
        subplot(1, 2, 2); imshow(linScale(avgImgCorr));
        subplot(1, 2, 1); title('Original');
        subplot(1, 2, 2); title('Corrected');
        
    else
        % original image
        figure('Name', sprintf('%s: original average image (no correction done)', rowIDTitle), figCommons{:});
        imshow(linScale(avgImg));
    end;
    
end;

end
