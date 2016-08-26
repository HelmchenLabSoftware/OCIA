function BESpoutPos(this, h, ~)
% BESpoutPos - [no description]
%
%       BESpoutPos(this, h, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

% check if hardware is connected
if ~this.be.hw.connected || ~isfield(this.be.hw, 'anOut');
    showWarning(this, 'OCIA:Behavior:SpoutPosHardwareDisconnected', 'Hardware is disconnected.');
    set(this.GUI.handles.be.spoutPos, 'BackgroundColor', 'red', 'Value', 0);
    return;
end;

% get the names of the analog out channels
channelNames = arrayfun(@(i)get(this.be.hw.anOut.Channels(i), 'Name'), 1 : numel(this.be.hw.anOut.Channels), ...
    'UniformOutput', false);

% check if spout is in the analog outputs
if ~ismember('spout', channelNames);
    showWarning(this, 'OCIA:Behavior:SpoutNotEnabled', 'Behavior: Spout is not enabled.');
    set(this.GUI.handles.be.spoutPos, 'BackgroundColor', 'red', 'Value', 0);
    return;
end;

% if change was requested by a input value
if (islogical(h) || isnumeric(h)) && this.GUI.handles.be.spoutPos ~= h;
    spoutPosState = get(this.GUI.handles.be.spoutPos, 'Value');
    if spoutPosState == h;
        o('#BESpoutPos(): h: %d, spoutPosState: %d => nothing to do.', h, spoutPosState, 3, this.verb);
        return;
    end;
    spoutPosState = h;
    o('#BESpoutPos(): h: %d, spoutPosState: %d.', h, spoutPosState, 3, this.verb);
    
else % if change was requested by the callback
    spoutPosState = get(this.GUI.handles.be.spoutPos, 'Value');
    o('#BESpoutPos(): h: %d, value: %d.', h, get(h, 'Value'), 3, this.verb);
    
end;

imagTTLState = get(this.GUI.handles.be.imagTTL, 'Value');
lightState = get(this.GUI.handles.be.imagTTL, 'Value');

spoutUpTime = 0.01; % seconds
nSteps = 1;
maxV = 4.6;
spoutPosSteps = 0 : 1 / nSteps : 1;
spoutPosSteps = spoutPosSteps * maxV;
if ~spoutPosState; spoutPosSteps = fliplr(spoutPosSteps); end;
for iStep = 1 : nSteps;
    stepStart = tic;
    this.be.hw.anOut.outputSingleScan([imagTTLState * 5, spoutPosSteps(iStep), lightState * 5]);
    pause((spoutUpTime / nSteps) - toc(stepStart));
end;
this.be.hw.anOut.outputSingleScan([imagTTLState * 5, spoutPosSteps(end), lightState * 5]);

if spoutPosState;        
    set(this.GUI.handles.be.spoutPos, 'BackgroundColor', 'green', 'Value', 1);
else    
    set(this.GUI.handles.be.spoutPos, 'BackgroundColor', 'red', 'Value', 0);
end;

end
