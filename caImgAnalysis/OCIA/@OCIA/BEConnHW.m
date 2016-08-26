function BEConnHW(this, ~, ~)
% BEConnHW - [no description]
%
%       BEConnHW(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if ~this.be.hw.connected;
    showMessage(this, 'Connecting hardware ...', 'yellow');
    set(this.GUI.handles.be.connHW, 'BackgroundColor', 'yellow', 'Value', 1);
    pause(0.01);

    % hide spout warnings
    warning('off', 'OCIA:Behavior:SpoutNotEnabled');
    
    %% analog inputs
    nAnIn = numel(this.be.hw.analogIns);
    if nAnIn;
        this.be.anInData = struct();
        this.be.hw.anIn = daq.createSession(this.be.hw.conf.adaptorID);
    end;

    for iAnIn = 1 : nAnIn;
        anInName = this.be.hw.analogIns{iAnIn};
        if ~this.be.debugMode;
            this.be.hw.anIn.addAnalogInputChannel(this.be.hw.conf.analogIn.(anInName).deviceName, ...
                this.be.hw.conf.analogIn.(anInName).channel, 'Voltage');
            this.be.hw.anIn.Channels(iAnIn).Name = anInName;
            this.be.hw.anIn.Channels(iAnIn).InputType = this.be.hw.conf.analogIn.(anInName).inputType;
            this.be.hw.anIn.Channels(iAnIn).Range = this.be.hw.conf.analogIn.(anInName).range;
            this.be.anInData.(anInName) = [];
        else
            o('  #BEConnHW: "Connecting" fake analog input %d/%d (%s).', iAnIn, nAnIn, anInName, 1, this.verb);
            this.be.hw.(anInName) = struct();
            this.be.hw.(anInName).stop = 1;
            this.be.hw.(anInName).startBackground = 1;
            this.be.hw.(anInName).IsRunning = 1;
            pause(1);
        end;
        o('  #BEConnHW: Analog input %d/%d (%s): OK.', iAnIn, nAnIn, anInName, 1, this.verb);
    end;

    if nAnIn;
        this.be.hw.anInListener = this.be.hw.anIn.addlistener('DataAvailable', @(h, e)BEStoreData(this, h, e));
        this.be.hw.anIn.IsNotifyWhenDataAvailableExceedsAuto = true;
        this.be.hw.anIn.IsContinuous = true;
        this.be.hw.anIn.Rate = this.be.hw.anInSampRate;
        this.be.hw.anIn.NotifyWhenDataAvailableExceeds = this.be.hw.sampToRec;
        this.be.hw.anIn.prepare();
    end;

    %% analog outputs
    nAnOut = numel(this.be.hw.analogOuts);
    if nAnOut;
        this.be.hw.anOut = daq.createSession(this.be.hw.conf.adaptorID);
    end;
    for iAnOut = 1 : nAnOut;
        anOutName = this.be.hw.analogOuts{iAnOut};
        if ~this.be.debugMode;
            warning('off', 'daq:Session:onDemandOnlyChannelsAdded');
            this.be.hw.anOut.addAnalogOutputChannel(this.be.hw.conf.analogOut.(anOutName).deviceName, ...
                this.be.hw.conf.analogOut.(anOutName).channel, 'Voltage');
            warning('on', 'daq:Session:onDemandOnlyChannelsAdded');
            this.be.hw.anOut.Channels(iAnOut).Name = anOutName;
            this.be.hw.anOut.Channels(iAnOut).Range = this.be.hw.conf.analogOut.(anOutName).range;
        end;
        o('  #BEConnHW: Analog output %d/%d (%s): OK.', iAnOut, nAnOut, anOutName, 1, this.verb);
    end;

%     if nAnOut;
%         this.be.hw.anOut.Rate = this.be.hw.anOutSampRate;
%         this.be.hw.anOut.IsContinuous = true;
%     end;

    %% digital outputs
    for iDigOut = 1 : numel(this.be.hw.digitalOuts);
        digOutName = this.be.hw.digitalOuts{iDigOut};
        if ~this.be.debugMode;
            this.be.hw.(digOutName) = daq.createSession(this.be.hw.conf.adaptorID);
            warning('off', 'daq:Session:onDemandOnlyChannelsAdded');
            this.be.hw.(digOutName).addDigitalChannel(this.be.hw.conf.digitalOut.(digOutName).deviceName, ...
                this.be.hw.conf.digitalOut.(digOutName).portLine, 'OutputOnly');
            warning('on', 'daq:Session:onDemandOnlyChannelsAdded');
            this.be.hw.(digOutName).outputSingleScan(0); % make sure valve is closed
        else
            o('  #BEConnHW: "Connecting" fake digital output %d (%s).', iDigOut, digOutName, 1, this.verb);
            this.be.hw.valve = struct();
            pause(1);
        end;
        o('  #BEConnHW: Digital output %d (%s): OK.', iDigOut, digOutName, 1, this.verb);
    end;

    %% all connects, start timer
    this.be.hw.connected = true;
    set(this.GUI.handles.be.connHW, 'BackgroundColor', 'green', 'Value', 0);
    showMessage(this, 'Hardware connected.');

    if ~strcmp(this.GUI.be.updateTimer.Running, 'on');
        start(this.GUI.be.updateTimer);
    end;

    this.be.hw.anIn.startBackground();
    
%     %% ETL-adjust
%     % set ETL to minimum Z focus
%     BEETL(this, this.be.params.minETLV, 'volt');
    
%     %% COM port
%     serialPortHandle = serial('COM8', 'BaudRate', 115000, 'DataBits', 8, 'StopBits', 1);
%     fopen(serialPortHandle);
%     fprintf(serialPortHandle, 'C0o');
%     fclose(serialPortHandle);
%     delete(serialPortHandle);

else

    showMessage(this, 'Disconnecting hardware ...', 'yellow');

    set(this.GUI.handles.be.connHW, 'BackgroundColor', 'yellow', 'Value', 1);
    if ~this.be.debugMode;
        this.be.hw.anIn.stop();
    end;
    this.be.hw.connected = false;
    daqreset();
    set(this.GUI.handles.be.connHW, 'BackgroundColor', 'red', 'Value', 0);
    showMessage(this, 'Hardware disconnected.');

end;

end
