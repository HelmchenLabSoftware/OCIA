function varargout = maxnpp(data, nPoints, varargin)
    if numel(varargin);
        direction = varargin{1};
    else
        direction = 'descend';
    end;
    % remove nans
    data(isnan(data)) = [];
    if ~isempty(data);
        [sortedData, sortedDataInd] = sort(data, direction);
        m = sortedData(1 : min(numel(sortedData), nPoints));
        i = sortedDataInd(1 : min(numel(sortedData), nPoints));
    else
        m = [];
        i = [];
    end;
    varargout = {m};
    if nargout == 2;
        varargout{2} = i;
    end;
end