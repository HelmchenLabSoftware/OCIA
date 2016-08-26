function BELightPulse(this, pulseDur, IPI, nPulses)
% BELightPulse - [no description]
%
%       BELightPulse(this, pulseDur, IPI, nPulses)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

imagTTLState = get(this.GUI.handles.be.imagTTL, 'Value');
o('#%s(): pulseDur %.3f, IPI %.3f, nPulses %d.', mfilename, pulseDur, IPI, nPulses, 2, this.verb);

if this.be.hw.connected && isfield(this.be.hw, 'anOut');
    start(timer('Name', 'PulseTimer', 'TimerFcn', { @doPulse, this.be, pulseDur, imagTTLState }, ...
        'Period', pulseDur + IPI, 'TasksToExecute', nPulses, 'ExecutionMode', 'fixedRate'));
else
    showWarning(this, 'OCIA:Behavior:LightHardwareDisconnected', 'Hardware is disconnected.');
    set(this.GUI.handles.be.light, 'BackgroundColor', 'red', 'Value', 0);
end;


end

function doPulse(~, ~, be, pulseDur, imagTTLState)

be.hw.anOut.outputSingleScan([imagTTLState * 5, 1 * be.params.maxLight]);
pauseTicToc(pulseDur);
be.hw.anOut.outputSingleScan([imagTTLState * 5, 0 * be.params.maxLight]);
    
end