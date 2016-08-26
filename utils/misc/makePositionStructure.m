function pos = makePositionStructure(varargin)

% units
SpInput = find(strcmpi(varargin, 'units'));
if numel(SpInput)
    pos.units = varargin{SpInput+1};
else
    pos.units = '';
end

% spot coordinates
SpInput = find(strcmpi(varargin, 'spotCoordinates'));
if numel(SpInput)
    pos.spotCoordinates = varargin{SpInput+1};
else
    pos.spotCoordinates = nan(1,3);
end

% reference coordinates
SpInput = find(strcmpi(varargin, 'refCoordinates'));
if numel(SpInput)
    pos.refCoordinates = varargin{SpInput+1};
else
    pos.refCoordinates = nan(1,3);
end

% reference ID
SpInput = find(strcmpi(varargin, 'refID'));
if numel(SpInput)
    pos.refID = varargin{SpInput+1};
else
    pos.refID = cell(1,size(pos.refCoordinates,1));
end

pos = orderfields(pos);