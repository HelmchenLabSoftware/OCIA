function BEPiezoBL(this, handleOrValue, varargin)
% BEPiezoBL - [no description]
%
%       BEPiezoBL(this, handleOrValue, varargin)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if this.be.hw.connected && isfield(this.be.hw, 'anOut');
    
    localVerb = 3;
    
    if isnumeric(handleOrValue) && ishandle(handleOrValue) && handleOrValue == this.GUI.handles.be.piezoBLSetter;
        piezoBL = str2double(get(handleOrValue, 'String'));
        if isnan(piezoBL); piezoBL = this.be.params.piezoBL; end;
        this.be.params.piezoBL = piezoBL;
        set(this.GUI.handles.be.piezoBL, 'Value', piezoBL);
        
    elseif isnumeric(handleOrValue) && ishandle(handleOrValue) && handleOrValue == this.GUI.handles.be.piezoBL;
        piezoBL = get(handleOrValue, 'Value');
        if isnan(piezoBL); piezoBL = this.be.params.piezoBL; end;
        this.be.params.piezoBL = piezoBL;
        set(this.GUI.handles.be.piezoBLSetter, 'String', piezoBL);
        
    end;
   

% hardware is not connected    
else
    
    showWarning(this, 'OCIA:Behavior:BEETLHardwareDisconnected', 'Hardware is disconnected.');
    set(this.GUI.handles.be.piezoBL, 'Value', 0);
    
end;

end
