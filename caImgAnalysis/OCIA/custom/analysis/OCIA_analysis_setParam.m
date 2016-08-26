function OCIA_analysis_setParam(this, isParamPan, name, stringOrValue, GUIValue, value)

if isParamPan;    
    if isfield(this.GUI.handles.an, 'paramPanElems') && isfield(this.GUI.handles.an.paramPanElems, name);
        set(this.GUI.handles.an.paramPanElems.(name), stringOrValue, GUIValue);
    else
        this.an.img.(name) = value;
    end;
else
    set(this.GUI.handles.an.(name), stringOrValue, GUIValue);
end;

end