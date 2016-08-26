function BEValveControl(this, ~, ~)
% BEValveControl - [no description]
%
%       BEValveControl(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if this.be.hw.connected && isfield(this.be.hw, 'valve');
    if ~this.be.debugMode;
        valveState = get(this.GUI.handles.be.valveCtrl, 'Value');
        this.be.hw.valve.outputSingleScan(valveState);
        if valveState;
            showMessage(this, 'Valve open.');
            set(this.GUI.handles.be.valveCtrl, 'BackgroundColor', 'green', 'Value', 1);
        else
            showMessage(this, 'Valve closed.');
            set(this.GUI.handles.be.valveCtrl, 'BackgroundColor', 'red', 'Value', 0);
        end;
    end;
else
    showWarning(this, 'OCIA:Behavior:ValveControlHardwareDisconnected', 'Hardware is disconnected.');
    set(this.GUI.handles.be.valveCtrl, 'BackgroundColor', 'red', 'Value', 0);
end;

end
