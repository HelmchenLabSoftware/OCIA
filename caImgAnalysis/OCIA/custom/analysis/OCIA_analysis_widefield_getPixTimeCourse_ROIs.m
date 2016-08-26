function [pixelTimeCourse, t, hashStruct] = OCIA_analysis_widefield_getPixTimeCourse_ROIs(this, iFile)
% OCIA_analysis_widefield_getPixTimeCourse_ROIs - [no description]
%
%       [pixelTimeCourse, t, hashStruct] = OCIA_analysis_widefield_getPixTimeCourse_ROIs(this, iFile)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% default output
[pixelTimeCourse, t, hashStruct] = deal([]);

% abort if no ROIs
ROIMasks = this.an.wf.ROIMasks;
if isempty(ROIMasks); return; end;
nROIs = size(ROIMasks, 3);

%% get the data
% get information from selected file
[filePath, ~, framesDatasetPath, ~, framesDim, frameRate] = OCIA_analysis_widefield_getFileInfo(this, iFile, true);
% baseline correction method
BLCorrMethod = this.an.wf.BLCorrMethod;
BLCorrParam = this.an.wf.BLCorrParam;
% window size for trace corrections with high-pass filter
windowSize = iff(strcmp(BLCorrMethod, 'slidingAvg'), round(frameRate ./ BLCorrParam), 0);

% limit frame range
frameRange = this.an.wf.frameRange;
if frameRange(2) == -1; frameRange(2) = Inf; end;
frameRange = [max(1, frameRange(1)), min(framesDim(3), frameRange(end))];
framesDim(3) = diff(frameRange) + 1;

% use cropped dimensions if any
H = framesDim(1); W = framesDim(2); nFrames = framesDim(3);
X = iff(isempty(this.an.wf.cropRect), 1, this.an.wf.cropRect, [], 1);
Y = iff(isempty(this.an.wf.cropRect), 1, this.an.wf.cropRect, [], 2);
W = iff(isempty(this.an.wf.cropRect), W, this.an.wf.cropRect, [], 3);
H = iff(isempty(this.an.wf.cropRect), H, this.an.wf.cropRect, [], 4);

% create time vector
t = (1 : nFrames) / frameRate;

% get the data in memory
hashStruct = OCIA_analysis_widefield_getHashStruct(this, iFile, 'WFPixelTimeCourseROIs', ...
    'stim|((base|evoked)Frames)|phase|power', struct('ROIMasks', ROIMasks));
cachedData = ANGetCachedData(this, 'wf', hashStruct);

% if the data is not in cache yet, generate it
if isempty(cachedData);
    
    % extract the pixel time course for each bin
    pixelTimeCourse = nan(nROIs, nFrames);
    
    ANShowHideMessage(this, 1, sprintf('Loading frames... (nFrames = %d)', nFrames));
    
    % get all frames
    allFrames = h5read(filePath, framesDatasetPath, [Y, X, frameRange(1)], [H, W, nFrames]);
    
    % actually loop over the relevant bins
    for iROI = 1 : nROIs;

        ANShowHideMessage(this, 1, sprintf('Extracting time course for ROI %02d / %02d ...', iROI, nROIs));
    
        % get average of selected pixels
        ROIMask = round(imresize(ROIMasks(:, :, iROI), [W, H]));
        trace = nanmean(GetRoiTimeseries(allFrames, ROIMask));

        switch BLCorrMethod;
            case 'mean';
                % correct the trace
                trace = trace - nanmean(trace);
%                     trace = (trace - nanmean(trace)) / nanmean(trace);

            case 'slidingAvg';

                % high-pass filter with a moving average filter
                slidingAvg = zeros(size(trace));
                for iFrame = 1 : nFrames;
                    frameStart = max(round(iFrame - 0.5 * windowSize), 1);
                    frameEnd = min(round(iFrame + 0.5 * windowSize), nFrames);
                    slidingAvg(iFrame) = nanmean(trace(frameStart : frameEnd));
                end;
                % correct the trace
                trace = trace - slidingAvg;

            case 'polynomial';
                % fit a degree "BLCorrParam" polynomial
                p = polyfit(1 : numel(trace), trace, BLCorrParam);
                polyCorr = polyval(p, 1 : numel(trace));
                % correct the trace
                trace = trace - polyCorr;

            case 'bpfilter';
                trace = mpi_BandPassFilterTimeSeries(trace, 1 / frameRate, BLCorrParam(1), BLCorrParam(2));

            otherwise;
                % do nothing
        end;

        % store
        pixelTimeCourse(iROI, :) = trace;

    end; % bin loop end
        
    % store the variables in the cached structure
    cachedData = struct('pixelTimeCourse', pixelTimeCourse, 'dataType', 'WFPixelTimeCourseROIs', ...
        'params', hashStruct);
    % store the data in memory
    ANStoreCachedData(this, 'wf', hashStruct, cachedData);
    
% if data was directly in memory, fetch it
else
    
    % fetch the data
    ANShowHideMessage(this, 1, 'Loading data from cache ...');
    pixelTimeCourse = cachedData.pixelTimeCourse;
    

end;

end
