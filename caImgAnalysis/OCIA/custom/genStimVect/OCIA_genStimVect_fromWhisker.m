%% #OCIA:AN:OCIA_genStimVect_fromWhisker
function [isValid, unvalidReason] = OCIA_genStimVect_fromWhisker(this, iDWRow, varargin)

% get whether to do plots or not
if nargin > 2;      doDebugPlots = varargin{1}; 
else                doDebugPlots = 0;
end;

rowID = DWGetRowID(this, iDWRow); % get the row ID 
isValid = true; % by default, the row is valid
unvalidReason = ''; % by default no reason

o('#%s(): row num: %d ...', mfilename, iDWRow, 3, this.verb);

%% init the stim vector
% get the number of skipped frames
nSkippedFrames = this.an.skipFrame.nFramesBegin + this.an.skipFrame.nFramesEnd;
imgDim = str2dim(get(this, iDWRow, 'dim'));
% compensate for the skipped frames
if numel(imgDim) < 3;   nFramesImg = 0;
else                    nFramesImg = imgDim(3) - nSkippedFrames;
end;
% stimulus vector is all zeros except where there are stimulus starts (sound, lick, spout, etc.)
stimVect = zeros(1, nFramesImg);
% string storing the stimulus types for this row
stimTypes = '';
% start bit encoding with bit 1
iBit = 1;

% store temporarly this empty stimulus vector (in case things get stuck later on)
setData(this, iDWRow, 'stim', 'data', stimVect);
setData(this, iDWRow, 'stim', 'loadStatus', 'partial');
setData(this, iDWRow, 'stim', 'stimTypes', regexprep(stimTypes, '^,', ''));

% if no imaging frames, abort
if ~nFramesImg;
    isValid = false; % set the validity flag to false
    % store the reason why this row was not valid
    unvalidReason = sprintf('no imaging data for row %s %03d (frame number = 0)', rowID, iDWRow);
    return; % abort processing of this row
end;

% get the (eventually down-sampled) whisker traces matrix for the requested rows
whiskTraces = OCIA_analysis_getRawWhiskTracesMatrix(this, iDWRow, true);

% if no whisker data is found, abort
if isempty(whiskTraces);
    isValid = false; % set the validity flag to false
    % store the reason why this row was not valid
    unvalidReason = sprintf('cannot find whisker data for row %s %03d', rowID, iDWRow);
    return; % abort processing of this row
end;

% normalize the traces by their mean
whiskTraces = whiskTraces - nanmean(whiskTraces);


%% Whisker peak
minPeakThresh = 10;
minPeakDist = 5;
[peakValues, stimPeakFrames] = findpeaks(whiskTraces, 'MinPeakHeight', minPeakThresh, 'MinPeakDistance', 15);

% if there are some stimulus, fill the simulus vector
if ~isempty(stimPeakFrames);
    
    % annotate the whisking peak with 1 on the current bit to mark it as stimulus frame
    stimVect(stimPeakFrames) = bitset(stimVect(stimPeakFrames), iBit, 1);
    stimTypes = sprintf('%s,%s', stimTypes, 'whiskPeak');
    iBit = iBit + 1;
    
    % if requested, plot a figure illustrating the extraction procedure
    if doDebugPlots > 0;
        figure('Name', sprintf('%s_whiskPeak', rowID), 'WindowStyle', 'docked', 'NumberTitle', 'off');
        whiskHandle = plot(whiskTraces, 'k');
        hold('on');
        hScatt = scatter(stimPeakFrames, peakValues, 100, 'rs', 'fill');
        yLims = get(gca, 'YLim'); xLims = get(gca, 'XLim');
        minPeakHeightHandle = plot(xLims, repmat(minPeakThresh, 2, 1), 'g:');
        minPeakDistHandle = plot([stimPeakFrames; stimPeakFrames], repmat(yLims', 1, numel(stimPeakFrames)), 'b:');
        plot([stimPeakFrames + minPeakDist; stimPeakFrames + minPeakDist], repmat(yLims', 1, numel(stimPeakFrames)), 'b:');
        title(sprintf('minPeakThresh: %.1f, minPeakDist: %.1f', minPeakThresh, minPeakDist));
        legend([whiskHandle, hScatt(1), minPeakHeightHandle(1), minPeakDistHandle(1)], ...
            'whisker angle', 'peaks', 'minimum peak height threshold', 'minimum inter-peak distance threshold');
    end;
    
end;

%% Other methods ...



%% saving the stimulus vector
% clean up the stimTypes string
stimTypes = regexprep(regexprep(stimTypes, '^,', ''), ',$', '');
    
% store the created stimulus vector and the different stimulus types encoding
setData(this, iDWRow, 'stim', 'data', stimVect);
setData(this, iDWRow, 'stim', 'loadStatus', 'full');
setData(this, iDWRow, 'stim', 'stimTypes', regexprep(stimTypes, '^,', ''));

end
