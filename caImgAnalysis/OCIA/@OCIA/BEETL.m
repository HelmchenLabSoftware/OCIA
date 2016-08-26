function BEETL(this, handleOrValue, varargin)
% BEETL - [no description]
%
%       BEETL(this, handleOrValue, varargin)
%
% [No description]
%
% 2013-2016 - Copyleft and programmed by Balazs Laurenczy (blaurenczy_at_gmail.com)

if this.be.hw.connected && isfield(this.be.hw, 'anOut');
    
    localVerb = 3;
    
    ETLVolt = [];
    ETLState = [];
    ETLDepth = [];
    
    % if change was requested by a input value
    if isnumeric(handleOrValue) && ~isnan(handleOrValue) && ...
            ~any(handleOrValue == [this.GUI.handles.be.ETL, this.GUI.handles.be.ETLVoltSetter, ...
                this.GUI.handles.be.ETLDepthSetter]);
        
        if isempty(varargin) || ~ischar(varargin{1});
            varargin{1} = 'depth';
        end;
        switch varargin{1}
            case { 'ETLState', 'State', 'state' };
                ETLState = handleOrValue;
                ETLState = max(min(ETLState, 1), 0);
                o('#%s(): value: %d, ETLState: %.2f.', mfilename(), handleOrValue, ETLState, localVerb, this.verb);
                
            case { 'ETLVolt', 'Volt', 'volt' };
                ETLVolt = handleOrValue;
                ETLVolt = min(max(ETLVolt, this.be.params.maxETLV), this.be.params.minETLV);
                o('#%s(): value: %d, ETLVolt: %.2f.', mfilename(), handleOrValue, ETLVolt, localVerb, this.verb);
                
            case { 'ETLDepth', 'Depth', 'depth' };
                ETLDepth = handleOrValue;
                ETLDepth = max(min(ETLDepth, this.be.params.maxETLDepth), this.be.params.minETLDepth);
                o('#%s(): value: %d, ETLDepth: %03d.', mfilename(), handleOrValue, ETLVolt, localVerb, this.verb);
                
            otherwise
                ETLDepth = handleOrValue;
                ETLDepth = max(min(ETLDepth, this.be.params.maxETLDepth), this.be.params.minETLDepth);
                o('#%s(): value: %d, ETLDepth: %03d.', mfilename(), handleOrValue, ETLVolt, localVerb, this.verb);
            
        end;
        
    % if change was requested by the callback
    elseif isnumeric(handleOrValue) && this.GUI.handles.be.ETL == handleOrValue;
        ETLState = get(this.GUI.handles.be.ETL, 'Value');
        ETLState = max(min(ETLState, 1), 0);
        o('#%s(): handle: ETL slider, ETLState: %.2f.', mfilename(), ETLState, localVerb, this.verb);
        
    % if change was requested by a callback
    elseif isnumeric(handleOrValue) && this.GUI.handles.be.ETLVoltSetter == handleOrValue;
        ETLVolt = str2double(get(this.GUI.handles.be.ETLVoltSetter, 'String'));
        ETLVolt = min(max(ETLVolt, this.be.params.maxETLV), this.be.params.minETLV);
        o('#%s(): handle: ETL volt setter, ETLVolt: %.2f.', mfilename(), ETLVolt, localVerb, this.verb);
        
    % if change was requested by a callback
    elseif isnumeric(handleOrValue) && this.GUI.handles.be.ETLDepthSetter == handleOrValue;
        ETLDepth = round(str2double(get(this.GUI.handles.be.ETLDepthSetter, 'String')));
        if isnan(ETLDepth);
            ETLState = get(this.GUI.handles.be.ETL, 'Value');
            ETLState = max(min(ETLState, 1), 0);
            ETLDepth = ETLState * (this.be.params.maxETLDepth - this.be.params.minETLDepth) + this.be.params.minETLDepth;
        end;
        ETLDepth = max(min(ETLDepth, this.be.params.maxETLDepth), this.be.params.minETLDepth);
        o('#%s(): handle: ETL depth setter, ETLDepth: %03d.', mfilename(), ETLDepth, localVerb, this.verb);
        
    else
        o('#%s(): unknown input, aborting.', mfilename(), 0, this.verb);
        return;
        
    end;
    
    if ~isempty(ETLState);
        ETLVolt = ETLState * (this.be.params.maxETLV - this.be.params.minETLV) + this.be.params.minETLV;
        ETLDepth = round(ETLState * (this.be.params.maxETLDepth - this.be.params.minETLDepth) + this.be.params.minETLDepth);
        
    elseif ~isempty(ETLVolt);
        ETLState = (ETLVolt - this.be.params.minETLV) / (this.be.params.maxETLV - this.be.params.minETLV);
        ETLDepth = round(ETLState * (this.be.params.maxETLDepth - this.be.params.minETLDepth) + this.be.params.minETLDepth);
        
    elseif ~isempty(ETLDepth);
        ETLState = (ETLDepth - this.be.params.minETLDepth) / (this.be.params.maxETLDepth - this.be.params.minETLDepth);
        ETLVolt = ETLState * (this.be.params.maxETLV - this.be.params.minETLV) + this.be.params.minETLV;
        
    else
        o('#%s(): unknown input (2), aborting.', mfilename(), 0, this.verb);
        return;
    end;
    
    imagTTLState = get(this.GUI.handles.be.imagTTL, 'Value');
    lightState = get(this.GUI.handles.be.light, 'Value');
    this.be.hw.anOut.outputSingleScan([imagTTLState * 5, ETLVolt, lightState * this.be.params.maxLight]);
        
    set(this.GUI.handles.be.ETL, 'Value', ETLState);
    set(this.GUI.handles.be.ETLVoltSetter, 'String', sprintf('%.2f', ETLVolt));
    set(this.GUI.handles.be.ETLDepthSetter, 'String', sprintf('%03d', ETLDepth));

% hardware is not connected    
else
    
    showWarning(this, 'OCIA:Behavior:BEETLHardwareDisconnected', 'Hardware is disconnected.');
    set(this.GUI.handles.be.ETL, 'Value', 0);
    set(this.GUI.handles.be.ETLVoltSetter, 'String', '0.00');
    set(this.GUI.handles.be.ETLDepthSetter, 'String', '0.00');
    
end;

end
