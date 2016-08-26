function JTPreProcessFrames(this, varargin)
% JTPreProcessFrames - [no description]
%
%       JTPreProcessFrames(this, varargin)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if this.GUI.jt.selectingROI;
    showMessage(this, 'Pre-processing the frames: already drawing something, aborting.', 'yellow');
    return;
end;

% get the pre-processing ROI handle
preProcROIHandle = this.GUI.jt.imPreProcROI;

% if previous handle exists, pre-process the movie
if ~isempty(preProcROIHandle) && isa(preProcROIHandle, 'imfreehand') && preProcROIHandle.isvalid();

    preProcTic = tic; % for performance timing purposes
    this.GUI.jt.selectingROI = false;
    showMessage(this, 'Pre-processing the frames ...', 'yellow');

    % store variables for par-for loop
    oriFrames = this.jt.oriFrames;
    frames = this.jt.frames;
    nFrames = this.jt.nFrames;

    %% create mask
    preProcMask = this.GUI.jt.imPreProcROI.createMask();
    this.GUI.jt.imPreProcROIMask = preProcMask;
    set(this.GUI.jt.imPreProcROI, 'Visible', 'off');

    %% static average
    % extract the average if required
    if isempty(this.jt.avgOriFrame);
        showMessage(this, ' - Pre-processing the frames: extracting average ...', 'yellow');
        avgOriFrame = linScale(nanmean(oriFrames, 3));
        showMessage(this, ' - Pre-processing the frames: average extracted ...', 'yellow');
    else
        avgOriFrame = this.jt.avgOriFrame;
    end;

    %% sliding average
    % extract the sliding average if required
    if isempty(this.jt.slidingAvgOriFrames);
        showMessage(this, ' - Pre-processing the frames: extracting sliding average ...', 'yellow');
        % extract a sliding average of window size "slidingAvgWindowPercentage" of the frames
        slidingAvgOriFrames = zeros(size(frames));
        halfWindowSize = round(this.jt.slidingAvgWindowPercentage * nFrames / 2);
        % process each frame
        parfor iFrame = 1 : nFrames;
            % create the range
            frameRange = iFrame - halfWindowSize : iFrame + halfWindowSize;
            frameRange(frameRange < 1 | frameRange > nFrames) = []; % exclude out-of-bound values
            slidingAvgOriFrames(:, :, iFrame) = linScale(nanmean(oriFrames(:, :, frameRange), 3)); %#ok<PFBNS>
        end;
        showMessage(this, ' - Pre-processing the movie: sliding average extracted ...', 'yellow');
    else
        slidingAvgOriFrames = this.jt.slidingAvgOriFrames;
    end;

    %% apply to frames
    % process each frame
    showMessage(this, ' - Pre-processing the frames: pre-processing frames ...', 'yellow');
    parfor iFrame = 1 : nFrames;
        oriFrame = oriFrames(:, :, iFrame); % get the frame
        frame = oriFrame;

        % get the frames with NaNs in and out of the mask respectively
        frameInMask = frame; frameOutMask = frame;
        frameInMask(~preProcMask) = NaN;
        frameOutMask(preProcMask) = NaN;

        % pseudo flat-field correction
        frameInMask = PseudoFlatfieldCorrect(frameInMask, round(size(frameInMask))); % flat-field correct
        frameOutMask = PseudoFlatfieldCorrect(frameOutMask, round(size(frameOutMask))); % flat-field correct

        % subtract the average from the part in the mask
    %     frameInMask = frameInMask - avgOriFrame; % subtract the average
        frame = oriFrame - slidingAvgOriFrames(:, :, iFrame); % subtract the sliding average
        frameInMask(~preProcMask) = NaN;

        % scale the frames and store them
        frame(preProcMask) = linScale(frameInMask(preProcMask));
        frame(~preProcMask) = linScale(frameOutMask(~preProcMask));
        frames(:, :, iFrame) = frame;
    end;
    showMessage(this, ' - Pre-processing the frames: frames pre-processed ...', 'yellow');

    % store the pre-processed frames
    this.jt.avgOriFrame = avgOriFrame;
    this.jt.slidingAvgOriFrames = slidingAvgOriFrames;
    this.jt.frames = frames;

    showMessage(this, sprintf('Pre-processing frames done (%3.1f sec).', toc(preProcTic)));

    % update GUI and get back the focus to frame setter
    set(this.GUI.handles.jt.viewOpts.preProc, 'Value', 1);
    JTUpdateGUI(this, this.GUI.handles.jt.viewOpts.preProc);
    
% if previous handle does not exists, define a ROI for pre-processing the movie
else
    
    showMessage(this, ['Pre-processing the frames: select a region to pre-process and press on the pre-process ' ...
        'button again ...'], 'yellow');
    % make a new selection
    this.GUI.jt.selectingROI = true;
    preProcROIHandle = imrect(this.GUI.handles.jt.axe);
    if isempty(preProcROIHandle);
        this.GUI.jt.selectingROI = false;
        preProcROIHandle = [];
        showMessage(this, 'Drawing pre-process region aborted.', 'yellow');
    end;
    
    this.GUI.jt.imPreProcROI = preProcROIHandle;
    
end;


end
