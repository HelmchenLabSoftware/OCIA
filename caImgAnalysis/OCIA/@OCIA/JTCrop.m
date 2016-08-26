function JTCrop(this, varargin)
% JTCrop - [no description]
%
%       JTCrop(this, varargin)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if this.GUI.jt.selectingROI;
    showMessage(this, 'Croping movie: already drawing something, aborting.', 'yellow');
    return;
end;

% get the crop ROI handle
cropROIHandle = this.GUI.jt.cropROIHandle;

% if previous handle exists, crop the movie
if ~isempty(cropROIHandle) && isa(cropROIHandle, 'imrect') && cropROIHandle.isvalid();
    
    cropTic = tic; % for performance timing purposes
    % get crop dimensions and delete crop ROI handle
    this.GUI.jt.selectingROI = false;
    cropDimensions = round(cropROIHandle.getPosition());
    delete(cropROIHandle);
    
    showMessage(this, sprintf('Croping movie: from [%d x %d] to [%d x %d] ...', size(this.jt.oriFrames, 2), ...
        size(this.jt.oriFrames, 1), cropDimensions(3), cropDimensions(4)), 'yellow');
    
    oriFrames = this.jt.oriFrames;
    newFrames = zeros([cropDimensions(4) + 1, cropDimensions(3) + 1, this.jt.nFrames]);
    parfor iFrame = 1 : this.jt.nFrames;
        newFrames(:, :, iFrame) = imcrop(oriFrames(:, :, iFrame), cropDimensions);
    end;
    
    % reset other variables
    this.jt.oriFrames = newFrames;
    this.jt.frames = newFrames;
    this.jt.avgOriFrame = [];
    this.jt.slidingAvgOriFrames = [];
    
    % reset the GUI and set the focus to the frame setter
    JTUpdateGUI(this, 'all');
    if numel(varargin); uicontrol(this.GUI.handles.jt.frameSetter); end;
    
    showMessage(this, sprintf('Croping movie: from [%d x %d] to [%d x %d] done (%.1f sec).', ...
        size(this.jt.oriFrames, 2), size(this.jt.oriFrames, 1), cropDimensions(3), cropDimensions(4), toc(cropTic)));
    
% if previous handle does not exists, define a ROI for croping the movie
else
    
    showMessage(this, 'Croping movie: select a region to crop and press on the crop movie button again ...', 'yellow');
    % make a new selection
    this.GUI.jt.selectingROI = true;
    cropROIHandle = imrect(this.GUI.handles.jt.axe);
    if isempty(cropROIHandle);
        this.GUI.jt.selectingROI = false;
        cropROIHandle = [];
        showMessage(this, 'Drawing crop region aborted.', 'yellow');
    end;
    
    this.GUI.jt.cropROIHandle = cropROIHandle;
    
end;

end
