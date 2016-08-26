function INPrevImgProcess(this, ~, eventData, ~)
% INPrevImgProcess - [no description]
%
%       INPrevImgProcess(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% processTic = tic;

% abort if preview is not running anymore
if ~this.in.previewRunning; return; end;

% if current image should not be display
if this.GUI.in.iPrevImg < 1;
    % update counter
    this.GUI.in.iPrevImg = this.GUI.in.iPrevImg + this.GUI.in.prevImgFrac;
%     o('#%s: skipped preview image (iPrevImg: %.2f)', mfilename, this.GUI.in.iPrevImg, 4, this.verb);
    return;
end;

% current image should be displayed: reset counter
this.GUI.in.iPrevImg = 0 + this.GUI.in.prevImgFrac;
% o('#%s: displaying preview image (iPrevImg: %.2f)', mfilename, this.GUI.in.iPrevImg, 4, this.verb);
    

% defines the frequency of update of the preview image
this.GUI.in.prevImgFreq = 0.1;
% counter for the update of preview image
this.GUI.in.curPrevImg = 1;

%% init
% get image
% getImTic = tic;
img = eventData.Data;

% create conversion function to right data type
dataClass = class(img);
convertFunc = str2func(dataClass);

% remove RGB dimension (convert to grayscale)
avgImg = nanmean(img, 3);
% o('#%s: getting image done: %.3f sec', mfilename, toc(getImTic), 3, this.verb);
% abort if preview is not running anymore
if ~this.in.previewRunning; return; end;

%% spatial down-sampling (binning)
avgImg = INSpatialDownSample(this, avgImg);

%% process saturation
% mark saturated pixels
if get(this.GUI.handles.in.prevShowSaturation, 'Value');
    
    % convert back to right data type
    avgImgRGB = convertFunc(avgImg);

%     satDisplayTic = tic;    
%     o('#%s: maxValue: %.1f, minValue: %.1f, saturation bounds: %d, %d', mfilename, ...
%         max(avgImgRGB(:)), min(avgImgRGB(:)), this.GUI.in.prevSaturationBounds, 4, this.verb);
    avgImgRGB = markImageWithSaturation(avgImgRGB, this.GUI.in.prevSaturationBounds);
%     o('#%s: saturation display done: %.3f sec', mfilename, toc(satDisplayTic), 3, this.verb);
    % abort if preview is not running anymore
    if ~this.in.previewRunning; return; end;
    
% no saturation display
else
    
    avgImgRGB = avgImg;
    
end;

% convert back to right data type
avgImgRGB = convertFunc(avgImgRGB);
% abort if preview is not running anymore
if ~this.in.previewRunning; return; end;

%% adjust image intensity
avgImgRGB = INAdjustIntensity(this, avgImgRGB);
% abort if preview is not running anymore
if ~this.in.previewRunning; return; end;

%% display data
set(this.GUI.handles.in.prevImg, 'CData', avgImgRGB);

% o('#%s done: %.3f sec', mfilename, toc(processTic), 3, this.verb);

end
