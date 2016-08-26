function OCIA_analysis_setIfExists(this, fieldName, stringOrValue, GUIVal, varargin)
    anh = this.GUI.handles.an;
    % decide whether to use anh.paramPanElems.img or other custom
    if ~isempty(varargin) && numel(varargin) > 1 && ~isempty(varargin{2}) ...
            && ischar(varargin{2}) && isfield(this.an, varargin{2});
        subField = varargin{2};
    else
        subField = 'img';
    end;
    if isfield(anh.paramPanElems, fieldName) ...
            && strcmp(get(anh.paramPanElems.(fieldName), 'Style'), 'popupmenu');
        set(anh.paramPanElems.(fieldName), 'Value', ...
            find(strcmp(GUIVal, get(anh.paramPanElems.(fieldName), 'String'))));
        
    elseif isfield(anh.paramPanElems, fieldName);
        set(anh.paramPanElems.(fieldName), stringOrValue, GUIVal);
        
    elseif ~isempty(varargin) && ~isempty(varargin{1});
        this.an.(subField).(fieldName) = varargin{1};
        
    elseif isempty(varargin) || ~isempty(varargin) && numel(varargin) > 1 && isempty(varargin{1});
        this.an.(subField).(fieldName) = GUIVal;
    end;
end