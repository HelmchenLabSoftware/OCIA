function BELight(this, h, ~)
% BELight - [no description]
%
%       BELight(this, h, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if this.be.hw.connected && isfield(this.be.hw, 'anOut');
    if this.GUI.handles.be.light ~= h; % if change was requested by a input value
        lightState = h;
        o('#%s(): h: %d, lightState: %d.', mfilename, h, lightState, 2, this.verb);
        
    else % if change was requested by the callback
        lightState = get(this.GUI.handles.be.light, 'Value');
        o('#%s(): h: %s, value: %d.', mfilename, get(h, 'Tag'), get(h, 'Value'), 2, this.verb);
        
    end;
    
%     spoutPosState = get(this.GUI.handles.be.spoutPos, 'Value');
%     ETLVolt = str2double(get(this.GUI.handles.be.ETLVoltSetter, 'String'));
    imagTTLState = get(this.GUI.handles.be.imagTTL, 'Value');
    
%     this.be.hw.anOut.outputSingleScan(lightState * this.be.params.maxLight);
    this.be.hw.anOut.outputSingleScan([imagTTLState * 5, lightState * this.be.params.maxLight]);
    
    if lightState;
        set(this.GUI.handles.be.light, 'BackgroundColor', 'green', 'Value', 1);
    else
        set(this.GUI.handles.be.light, 'BackgroundColor', 'red', 'Value', 0);
    end;
else
    showWarning(this, 'OCIA:Behavior:LightHardwareDisconnected', 'Hardware is disconnected.');
    set(this.GUI.handles.be.light, 'BackgroundColor', 'red', 'Value', 0);
end;

end
