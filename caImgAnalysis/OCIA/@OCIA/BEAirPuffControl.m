function BEAirPuffControl(this, ~, ~)
% BEAirPuffControl - [no description]
%
%       BEAirPuffControl(this, ~, ~)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if this.be.hw.connected && isfield(this.be.hw, 'airPuff');
    if ~this.be.debugMode;
        airPuffState = get(this.GUI.handles.be.airPuffCtrl, 'Value');
        this.be.hw.airPuff.outputSingleScan(airPuffState);
        if airPuffState;
            showMessage(this, 'Air puff open.');
            set(this.GUI.handles.be.airPuffCtrl, 'BackgroundColor', 'green', 'Value', 1);
        else
            showMessage(this, 'Air puff closed.');
            set(this.GUI.handles.be.airPuffCtrl, 'BackgroundColor', 'red', 'Value', 0);
        end;
    end;
else
    showWarning(this, 'OCIA:Behavior:BEAirPuffControlHardwareDisconnected', 'Hardware is disconnected.');
    set(this.GUI.handles.be.airPuffCtrl, 'BackgroundColor', 'red', 'Value', 0);
end;

end
