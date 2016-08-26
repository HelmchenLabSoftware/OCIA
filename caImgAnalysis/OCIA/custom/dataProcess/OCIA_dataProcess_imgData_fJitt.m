%% #OCIA:OCIA_dataProcess_imgData_fJitt
function [isValid, unvalidReason] = OCIA_dataProcess_imgData_fJitt(this, iDWRow, varargin)

% by default, row is valid
isValid = true;
unvalidReason = '';

% get the selected processing steps and this row's processing state
selProcOpts = this.an.procOptions.id(get(this.GUI.handles.dw.procOptsList, 'Value'));
rowProcState = getData(this, iDWRow, 'procImg', 'procState');
% if this processing is not required or if data is not imaging data or if data was already processed, abort
if ~any(strcmp(selProcOpts, 'fJitt')) || ~strcmp(get(this, iDWRow, 'rowType'), 'Imaging data') ...
        || any(strcmp(rowProcState, 'fJitt'));
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
rowIDTitle = sprintf('Frame jitter correction for %s (%d)', rowID, iDWRow);
figCommons = { 'NumberTitle', 'off', 'WindowStyle', 'docked' }; % figure options
        
% get the ROISet for this row
ROISet = ANGetROISetForRow(this, iDWRow);
nROIs = size(ROISet, 1);

% if no ROISet found, create fake ROISet
if ~nROIs;
    o('%s: no ROISet found, using fake ROIs ...', mfilename(), 2, this.verb);
    % make sure data is fully loaded
    DWLoadRow(this, iDWRow, 'full');
    % check if the processing should be aborted
    [doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;
    % get the imaging data
    imgData = get(this, iDWRow, 'data');
    imgData = imgData.procImg.data;
    imgDim = size(imgData{this.an.img.preProcChan});
    % create the fake ROISet
    [ROISet, nROIs] = createFakeROISet(imgDim(1:2), imgDim(1) * 0.05, 10, 10);
end;

percBoundBox = 0.04; % percent of image around the ROI's bounding box
% range of pixel shift to test
shifts = -3 : 3;
% use only the 10% brightest ROIs, but at least 5 ROIs but not more than "nROIs" ROIs
nBrightROIs = min(max(round(nROIs * 0.1), 5), nROIs);

% make sure data is fully loaded
DWLoadRow(this, iDWRow, 'full');
        
% check if the processing should be aborted
[doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;

% get the imaging data
imgData = get(this, iDWRow, 'data');
imgData = imgData.procImg.data;
imgDim = size(imgData{this.an.img.preProcChan});

% number of frames in a "chunck" of data to analyse, about the tenth of the frames but at least one second of data
nFrameAvg = round(max(ceil(imgDim(3) / 10), this.an.img.defaultFrameRate));

%% - #OCIA:AN:ANFrameJitterCorrection: loop on chuncks of data
nChuncks = ceil(imgDim(3) / nFrameAvg); % calculate the number of chuncks 
for iChunck = 1 : nChuncks;
    
    % get the frame range for this chunck, removing frames exceeding limits
    frameRange = ((iChunck - 1) * nFrameAvg + 1) : min(iChunck * nFrameAvg, imgDim(3));
    
    % get the average of all frames of the pre-processing channel
    avgImg = nanmean(imgData{this.an.img.preProcChan}(:, :, frameRange), 3);
    
    %% -- #OCIA:AN:ANFrameJitterCorrection: ROI brightness
    % get the brightness of the ROIs to calculate correlation only on the "nBrightROIs" brightest ROIs
    ROIBrightness = zeros(1, nROIs);
    parfor iROI = 1 : nROIs;
        if strcmpi(ROISet{iROI, 1}, 'npil'); continue; end; % exclude neuropil
        % get the ROI's mask
        ROIMask = ROISet{iROI, 2};
        % get the x and y positions of this ROI's pixels
        ROIBrightness(iROI) = sum(avgImg(ROIMask > 0));
    end;
    % sort the brightness
    [~, ROIBrightnessIndex] = sort(-ROIBrightness);
    brighROISet = ROISet(ROIBrightnessIndex(1 : nBrightROIs), :);
        
    % check if the processing should be aborted
    [doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;

    %% -- #OCIA:AN:ANFrameJitterCorrection: loop on shifts: fix the jitter by applying a shift to lines
    nShifts = numel(shifts);
    shiftImprovs = zeros(nBrightROIs, nShifts);
    parfor iShift = 1 : nShifts;

        shift = shifts(iShift); % get the current shift to apply
        avgImgShift = shiftImage(avgImg, imgDim, shift); % shift the image

        %% --- #OCIA:AN:ANFrameJitterCorrection: loop on ROIs
        for iROI = 1 : nBrightROIs;

            %% ---- #OCIA:AN:ANFrameJitterCorrection: process ROI
            % get the ROI's mask
            ROIMask = brighROISet{iROI, 2};
            % get the x and y positions of this ROI's pixels
            ROIPixels = unique(find(ROIMask > 0));
            [yVals, xVals] = ind2sub(imgDim([1, 2]), ROIPixels);
            
            % get the bounding box of this ROI
            ROIXRange = [round(min(xVals) * (1 - percBoundBox)), round(max(xVals) * (1 + percBoundBox))];
            ROIYRange = [round(min(yVals) * (1 - percBoundBox)), round(max(yVals) * (1 + percBoundBox))];
            % skip if the ROI with bounding box is not completely in the image 
            if ROIXRange(1) < 1 || ROIXRange(end) > imgDim(2) || ROIYRange(1) < 1 || ROIYRange(end) > imgDim(1);
                continue;
            end;
            % image of the ROI's bounding box
            ROIAvgImg = avgImg(ROIYRange(1) : ROIYRange(end), ROIXRange(1) : ROIXRange(end));

            % do a line-wise correlation
            yCorrsROI = zeros(1, ROIYRange(end) - ROIYRange(1));
            for y = 1 : (ROIYRange(end) - ROIYRange(1));
                yCorrsROI(y) = corr(ROIAvgImg(y, :)', ROIAvgImg(y + 1, :)', 'rows', 'pairwise'); %#ok<*PFBNS>
            end;
            
            % corrected image of the ROI's bounding box
            ROIAvgImgShift = avgImgShift(ROIYRange(1) : ROIYRange(end), ROIXRange(1) : ROIXRange(end));

            % do a line-wise correlation
            yCorrsROICorrected = zeros(1, ROIYRange(end) - ROIYRange(1));
            for y = 1 : (ROIYRange(end) - ROIYRange(1));
                yCorrsROICorrected(y) = corr(ROIAvgImgShift(y, :)', ROIAvgImgShift(y + 1, :)', 'rows', 'pairwise');
            end;

            shiftImprovs(iROI, iShift) = (nanmean(yCorrsROICorrected) / nanmean(yCorrsROI)) * 100 - 100;

            %% ---- #OCIA:AN:FrameJitterCorrection: ROI plotting
            if doPlots > 2; % if requested, plot a figure illustrating the shift correction procedure and result
                
                figure('Name', sprintf('%s: frames %03d-%03d (%d), ROI%d, shift %+d', ...
                    rowIDTitle, frameRange([1, end]), iChunck, iROI, shift), figCommons{:});
                subplot(1, 2, 1); imshow(linScale(ROIAvgImg));
                subplot(1, 2, 2); imshow(linScale(ROIAvgImgShift));
                % add titles
                subplot(1, 2, 1); title('Original');
                subplot(1, 2, 2); title('Corrected');

                figure('Name', sprintf('%s: frames %03d-%03d (%d), shift %+d, corr.: %.3f->%.3f (%+02.1f%%)', ...
                    rowIDTitle, frameRange([1, end]), iChunck, shift, nanmean(yCorrsROI), ...
                    nanmean(yCorrsROICorrected), shiftImprovs(iROI, iShift)), figCommons{:});
                plot(1 : size(yCorrsROI, 2), yCorrsROI);
                hold on;
                plot((1 : size(yCorrsROI, 2)) + 0.5, yCorrsROICorrected, 'r');
                ylim([0.2 1]);
                legend('Original', 'Corrected');

            end; % end of plotting if case

        end; % end of ROI for loop
        
        %% --- #OCIA:AN:FrameJitterCorrection: general plotting
        if doPlots > 1; % if requested, plot a figure illustrating the shift correction procedure and result

            % original image
            figure('Name', sprintf('%s: frames %03d-%03d (%d), shift %+d', ...
                    rowIDTitle, frameRange([1, end]), iChunck, shift), figCommons{:});
            subplot(1, 2, 1); imshow(linScale(avgImg));
            subplot(1, 2, 2); imshow(linScale(avgImgShift));
            % add titles
            subplot(1, 2, 1); title('Original');
            subplot(1, 2, 2); title('Corrected');
            
        end; % end of plotting if case
        
    end; % end of shifts for loop
        
    % check if the processing should be aborted
    [doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;
        
    % extract the best shift
    [~, bestShift] = sort(-nanmean(shiftImprovs, 1));
    bestShift = shifts(bestShift(1));
    
    % if some shifting was found, apply it on the frame and calculate correlations
    if bestShift;
        avgImgCorr = shiftImage(avgImg, imgDim, bestShift); % shift the image

        % do a line-wise correlation
        yCorrs = zeros(1, imgDim(1) - 1);
        yCorrsCorrected = zeros(1, imgDim(1) - 1);
        parfor y = 1 : (imgDim(1) - 1);
            yCorrs(y) = corr(avgImg(y, :)', avgImg(y + 1, :)', 'rows', 'pairwise');
            yCorrsCorrected(y) = corr(avgImgCorr(y, :)', avgImgCorr(y + 1, :)', 'rows', 'pairwise');
        end;

        bestShiftImprov = (nanmean(yCorrsCorrected) / nanmean(yCorrs)) * 100 - 100;
        
        % if improvement is not big enough, do not apply it
        if bestShiftImprov < 1; % less than 1% improvement
            bestShift = 0;
        else
            o('%s: frames %03d-%03d (%d), best shift %+d, corr.: %.3f->%.3f (%+02.1f%%).', ...
                rowIDTitle, frameRange([1, end]), iChunck, bestShift, nanmean(yCorrs), nanmean(yCorrsCorrected), ...
                bestShiftImprov, 2, this.verb);
        end;
    end;
    
    if ~bestShift; % if no correction, keep original image
        avgImgCorr = avgImg;
        bestShiftImprov = 0;
        % do a line-wise correlation
        yCorrs = zeros(1, imgDim(1) - 1);
        parfor y = 1 : (imgDim(1) - 1);
            yCorrs(y) = corr(avgImg(y, :)', avgImg(y + 1, :)', 'rows', 'pairwise');
        end;
        yCorrsCorrected = yCorrs;
    end;
        
    % check if the processing should be aborted
    [doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;
    
    %% --- #OCIA:AN:FrameJitterCorrection: general plotting
    if doPlots > 0; % if requested, plot a figure illustrating the shift correction procedure and result

        % original image
        figure('Name', sprintf('%s: frames %03d-%03d (%d), best shift %+d', ...
                rowIDTitle, frameRange([1, end]), iChunck, bestShift), figCommons{:});
        subplot(1, 2, 1); imshow(linScale(avgImg));
        subplot(1, 2, 2); imshow(linScale(avgImgCorr));
%         subplot(1, 2, 1); imagesc(avgImg);
%         subplot(1, 2, 2); imagesc(avgImgCorrected);
        subplot(1, 2, 1); title('Original');
        subplot(1, 2, 2); title('Corrected');

        figure('Name', sprintf('%s: frames %03d-%03d (%d), best shift: %+d, corr.: %.3f->%.3f (%+02.1f%%)', ...
            rowIDTitle, frameRange([1, end]), iChunck, bestShift, nanmean(yCorrs), nanmean(yCorrsCorrected), ...
            bestShiftImprov), figCommons{:});
        plot(1 : size(yCorrs, 2), yCorrs);
        hold on;
        plot((1 : size(yCorrsCorrected, 2)) + 0.5, yCorrsCorrected, 'r');
        ylim([0.2 1]);
        legend('Original', 'Corrected');

    end; % end of plotting if case
        
    % check if the processing should be aborted
    [doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;
    
    % if some shifting was applied, shift all frames in the original data
    if bestShift;
        
        % create a corrected data set
        imgDataCorrected = imgData;
        % go through each channel
        for iChan = 1 : this.an.img.nChans;
            % skip empty channels
            if isempty(imgDataCorrected{iChan}); continue; end;
            % get the current data chunck (images) of the current channel
            imgDataChanAllFrames = imgDataCorrected{iChan};
            imgDataChan = imgDataChanAllFrames(:, :, frameRange);
            % go through each frame and correct it
            parfor iFrame = 1 : size(imgDataChan, 3);
                imgDataChan(:, :, iFrame) = shiftImage(imgDataChan(:, :, iFrame), imgDim, bestShift); % shift the image
            end;
            imgDataChanAllFrames(:, :, frameRange) = imgDataChan; % copy back the corrected data
            imgDataCorrected{iChan} = imgDataChanAllFrames; % copy back the corrected data
        end;
        
        % check if the processing should be aborted
        [doAbort, isValid, unvalidReason] = DWCheckProcessAbort(this, isValid, unvalidReason); if doAbort; return; end;
        
        % store the corrected data
        this.dw.table{iDWRow, strcmp(this.dw.tableIDs, 'data')}.procImg.data = imgDataCorrected;
        
    end;
    

end; % end of chuncks for loop

% mark row as processed for frame jitter correction
setData(this, iDWRow, 'procImg', 'procState', [rowProcState { 'fJitt' }]);

end

%% - #OCIA:AN:ANFrameJitterCorrection:shiftImage
function shiftedImage = shiftImage(avgImg, imgDim, shift)

shiftedImage = avgImg; % start with the original image

for y = 1 : imgDim(1);
    if mod(y, 2);
        xIndexes = (1 : imgDim(2)) + shift;
        xIndexes(xIndexes < 1 | xIndexes > imgDim(2)) = [];
        if shift > 0;
            lineValues = [avgImg(y, xIndexes), nan(1, abs(shift))];
        elseif shift < 0;
            lineValues = [nan(1, abs(shift)), avgImg(y, xIndexes)];
        else
            lineValues = avgImg(y, xIndexes);
        end;
        shiftedImage(y, :) = lineValues;
    end;
end;
        
end
