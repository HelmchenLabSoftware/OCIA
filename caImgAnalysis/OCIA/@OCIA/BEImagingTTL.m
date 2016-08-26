function BEImagingTTL(this, h, ~)
% BEImagingTTL - [no description]
%
%       BEImagingTTL(this, h, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if get(this.GUI.handles.be.imageEnableOff, 'Value');
    set(this.GUI.handles.be.imagTTL, 'Value', 0);
    if nargin > 2;
        showWarning(this, 'OCIA:Behavior:ImagingDisabled', 'Imaging is disabled.');
    end;
    return;
end;

if this.be.hw.connected && isfield(this.be.hw, 'anOut');
    if this.GUI.handles.be.imagTTL ~= h; % if change was requested by a input value
        imagTTLState = h;
        o('#BEImagingTTL(): h: %d, imagTTLState: %d.', h, imagTTLState, 3, this.verb);
    else % if change was requested by the callback
        imagTTLState = get(this.GUI.handles.be.imagTTL, 'Value');
        o('#BEImagingTTL(): h: %d, value: %d.', h, get(h, 'Value'), 3, this.verb);
    end;
    
%     spoutPosState = get(this.GUI.handles.be.spoutPos, 'Value');
%     ETLVolt = str2double(get(this.GUI.handles.be.ETLVoltSetter, 'String'));
    lightState = get(this.GUI.handles.be.light, 'Value');
    
%     this.be.hw.anOut.outputSingleScan([imagTTLState * 5, ETLVolt, lightState * this.be.params.maxLight]);
    this.be.hw.anOut.outputSingleScan([imagTTLState * 5, lightState * this.be.params.maxLight]);
    
    if imagTTLState;
        set(this.GUI.handles.be.imagTTL, 'BackgroundColor', 'green', 'Value', 1);
    else
        set(this.GUI.handles.be.imagTTL, 'BackgroundColor', 'red', 'Value', 0);
    end;
else
    showWarning(this, 'OCIA:Behavior:ImagingTTLHardwareDisconnected', 'Hardware is disconnected.');
    set(this.GUI.handles.be.imagTTL, 'BackgroundColor', 'red', 'Value', 0);
end;

end
