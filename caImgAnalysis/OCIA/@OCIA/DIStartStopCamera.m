%% #DIStartStopCamera
function DIStartStopCamera(this, commandString)

o('#%s() ...', mfilename, 3, this.verb);

try % capture display errors

if strcmp(commandString, 'toggle') && strcmp(get(this.GUI.di.camHandle, 'Running'), 'on');
    commandString = 'stop';
elseif strcmp(commandString, 'toggle') && strcmp(get(this.GUI.di.camHandle, 'Running'), 'off');
    commandString = 'start';    
end;

if strcmp(commandString, 'start');
    
    % make sure camera is stopped
    stop(this.GUI.di.camHandle);
    
    % add disk and memory logging options
    set(this.GUI.di.camHandle, 'LoggingMode', 'disk&memory');
    if exist(this.path.discrDataSave, 'dir') ~= 7; mkdir(this.path.discrDataSave); end;
    videoWriterHandle = VideoWriter(sprintf('%s%s.mp4', this.path.discrDataSave, datestr(now, 'yyyymmdd_HHMMSS')), 'MPEG-4');
    this.GUI.di.camHandle.DiskLogger = videoWriterHandle;

    % start the recording
    start(this.GUI.di.camHandle);
    
elseif strcmp(commandString, 'stop');
    
    stop(this.GUI.di.camHandle);
    
end;

catch err;
    errStack = getStackText(err);
    showWarning(this, 'OCIA:DIStartStopCamera', sprintf('Problem in the Discriminator camera start/stop function: "%s".', err.message));
    o(errStack, 0, 0);
end
