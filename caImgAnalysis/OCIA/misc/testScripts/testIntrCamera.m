%% config
stop(this.in.camH);
flushdata(this.in.camH);

this.in.camH

set(this.in.camH, 'LoggingMode', 'memory');
this.in.camH.DiskLogger = [];
triggerconfig(this.in.camH, 'hardware', 'RisingEdge', 'EdgeTrigger');
set(this.in.camH, 'FramesPerTrigger', 125, 'TriggerRepeat', 0);

%% start
start(this.in.camH);

%% send trigger
outputSingleScan(this.in.daq.sessHandle, 0); % TTL high
outputSingleScan(this.in.daq.sessHandle, 1); % TTL high
outputSingleScan(this.in.daq.sessHandle, 0); % TTL high

pause(0.01);

outputSingleScan(this.in.daq.sessHandle, 0); % TTL high
outputSingleScan(this.in.daq.sessHandle, 1); % TTL high
outputSingleScan(this.in.daq.sessHandle, 0); % TTL high

this.in.camH

pause(0.1);

this.in.camH