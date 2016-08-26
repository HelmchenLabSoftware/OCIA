function INPreview(this, ~, ~)
% INPreview - [no description]
%
%       INPreview(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% check for hardware connection state
if ~this.in.connected;
    showWarning(this, 'OCIA:INPreview:HardwareNotConnected', 'Intrinsic: hardware is not connected');
    set(this.GUI.handles.in.prevBut, 'BackgroundColor', 'red', 'Value', 0);
    return;
end;

% already in preview mode => stop it
if this.in.previewRunning;

    this.in.previewRunning = false;
    stoppreview(this.in.camH);
    
    showMessage(this, 'Intrinsic: preview stopped.');
    set(this.GUI.handles.in.prevBut, 'BackgroundColor', 'red', 'Value', 0);

% not in preview mode yet => start it
else
    
    showMessage(this, 'Intrinsic: starting preview ...', 'yellow');
    set(this.GUI.handles.in.prevBut, 'BackgroundColor', 'yellow', 'Value', 1);
    pause(0.01);
    % reset the counter for the update of preview image
    this.GUI.in.iPrevImg = 1;

    hPrev = preview(this.in.camH, this.GUI.handles.in.prevImg);
    % set the frames acquired function
    setappdata(hPrev, 'UpdatePreviewWindowFcn', @(camH, eventData, hImg) INPrevImgProcess(this, camH, eventData, hImg));
    this.in.previewRunning = true;
    
    set(this.GUI.handles.in.prevBut, 'BackgroundColor', 'green', 'Value', 0);
    showMessage(this, 'Intrinsic: preview started.');
    
    % performance-related updates
    pause(0.01);
    set(this.GUI.handles.in.prevAxe, 'Units', 'pixels');
%     pos = get(this.GUI.handles.in.prevAxe, 'Position');
%     prevImg = get(this.GUI.handles.in.prevImg, 'CData');
%     set(this.GUI.handles.in.prevAxe, 'Position', [pos(1), pos(2), size(prevImg, 2), size(prevImg, 1)]);
    set(this.GUI.handles.in.prevAxe, 'xlimmode', 'manual', 'ylimmode', 'manual', 'zlimmode', 'manual',...
        'climmode', 'manual', 'alimmode', 'manual');
    set(this.GUI.figH, 'doublebuffer', 'off');

end;

end
