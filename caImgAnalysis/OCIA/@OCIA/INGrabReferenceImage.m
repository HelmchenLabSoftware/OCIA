function INGrabReferenceImage(this, ~, ~)
% INGrabReferenceImage - [no description]
%
%       INGrabReferenceImage(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% check for hardware connection state
if ~this.in.connected;
    showWarning(this, 'OCIA:INGrabReferenceImage:HardwareNotConnected', 'Intrinsic: hardware is not connected');
    set(this.GUI.handles.in.refBut, 'Value', 0);
    return;
end;

% if preview is running, stop it
isPreview = this.in.previewRunning;
if isPreview;
    INPreview(this);
end;

% show message
showMessage(this, 'Intrinsic: grabbing reference image ...', 'yellow');
txt = get(this.GUI.handles.in.refBut, 'String');
fontSize = get(this.GUI.handles.in.refBut, 'FontSize');
set(this.GUI.handles.in.refBut, 'String', 'Grabbing ...', 'FontSize', fontSize * 0.8, 'Value', 1, 'Enable', 'off');
pause(0.05);

% reset camera
stop(this.in.camH);
flushdata(this.in.camH);

% change camera settings
triggerconfig(this.in.camH, 'immediate');
set(this.in.camH, 'FramesPerTrigger', this.GUI.in.nFramesRef);

% aquire frames
start(this.in.camH);
wait(this.in.camH);

% extract frames
frames = getdata(this.in.camH);

% create conversion function to right data type
dataClass = class(frames);
convertFunc = str2func(dataClass);

% average frames
frames = nanmean(frames, 4);
avgImgRGB = nanmean(frames, 3);

% convert back to right data type
avgImgRGB = convertFunc(avgImgRGB);

% spatial down-sampling (binning)
avgImgRGB = INSpatialDownSample(this, avgImgRGB);

% adjust image intensity
avgImgRGB = INAdjustIntensity(this, avgImgRGB);

% store frames
this.in.data.refImg = avgImgRGB;

% display img
set(this.GUI.handles.in.refImg, 'CData', avgImgRGB);

% show message
set(this.GUI.handles.in.refBut, 'String', txt, 'FontSize', fontSize, 'Value', 0, 'Enable', 'on');
showMessage(this, 'Intrinsic: reference image acquired.');

% if preview was running, res-start it
if isPreview;
    INPreview(this);
end;

end
