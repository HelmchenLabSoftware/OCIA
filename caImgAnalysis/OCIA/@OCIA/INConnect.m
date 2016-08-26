function INConnect(this, ~, ~)
% INConnect - [no description]
%
%       INConnect(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% check the connection state
if ~this.in.connected;
    
    %% connect camera
    % show message
    showMessage(this, 'Intrinsic: connecting camera ...', 'yellow');
    set(this.GUI.handles.in.connect, 'BackgroundColor', 'yellow', 'Value', 1);
    pause(0.01);

    % connect camera in a try-catch to avoid errors in case things go wrong
    try    
        % reset the imaq toolbox
        imaqreset();
        
        % build the input arguments depending on wheter we have a camera format specified or not
        inputArgs = { this.in.adaptorName, this.in.deviceID };
        if ~isempty(this.in.common.camFormat);
            inputArgs{end + 1} = this.in.common.camFormat;
        end;
        
        % create the video input
        this.in.camH = videoinput(inputArgs{:});
        set(this.in.camH, 'ROIPosition', this.in.common.ROIPosition);
        set(get(this.in.camH, 'Source'), 'ExposureTime', 1 / this.in.common.frameRate);
        
        % get some information about the camera
        oldDim = this.GUI.in.imDim;
        this.GUI.in.imDim = this.in.common.ROIPosition(3 : 4) / this.in.common.spatialDSFactor;
        
        % adjust the images if needed 
        if ~all(oldDim == this.GUI.in.imDim);
            W = this.GUI.in.imDim(1);
            H = this.GUI.in.imDim(2);
            img = 0.5 * ones(H, W, 3);
            axNames = { 'prevImg', 'expLeftImg', 'expRightImg', 'refImg' };
            for iName = 1 : numel(axNames);
                set(this.GUI.handles.in.(axNames{iName}), 'CData', img);
                set(get(this.GUI.handles.in.(axNames{iName}), 'Parent'), 'XLim', [0 W], 'YLim', [0 H]);
            end;
        end;
        
    % abort on error
    catch err;        
        showWarning(this, 'OCIA:INConnect:CameraConnectionFailed', ...
            sprintf('Problem while connecting the camera (%s): %s.', err.identifier, err.message));
        set(this.GUI.handles.in.connect, 'BackgroundColor', 'red', 'Value', 0);
        return;
        
    end;
    
    % proper connection: show message
    showMessage(this, 'Intrinsic: camera connected.');
    
    % if everything succeeded, change connection status
    set(this.GUI.handles.in.connect, 'BackgroundColor', 'green', 'Value', 0);
    this.in.connected = true;

% if we are already connected
else

    showMessage(this, 'Intrinsic: disconnecting camera ...', 'yellow');
    set(this.GUI.handles.in.connect, 'BackgroundColor', 'yellow', 'Value', 1);
    pause(0.01);
    
    % kill everything
    delete(this.in.camH);
    this.in.camH = [];
    imaqreset();
    
    delete(this.in.RP);
    this.in.RP = [];
    
    % show message and change connection status    
    this.in.connected = false;
    set(this.GUI.handles.in.connect, 'BackgroundColor', 'red', 'Value', 0);
    showMessage(this, 'Intrinsic: camera disconnected.');

end;

end
