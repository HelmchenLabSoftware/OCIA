function RGBImage = cell2RGB(cellImg, colorVector, varargin)
% RGBImage = cell2RGB(cellImg, colorVector)
% converts a cell array of grayscale frame(s) into an RGB frame as single RGB frames
%
% RGBImage = cell2RGB(cellImg, colorVector, doAverage)
% converts a cell array of grayscale frame(s) into an RGB frame, with optional averaging of frames

if nargin > 2;  doAverage = varargin{1};
else            doAverage = false;
end;

dimReducFcnName = '';
if nargin > 3;
    dimReducFcnName = varargin{2};
end;
if isempty(dimReducFcnName) || ~ischar(dimReducFcnName);
    dimReducFcnName = 'nanmean';
end;

% if the image has several frames, average them
if doAverage && size(cellImg{1}, 3) > 1;
    switch dimReducFcnName;
        case { '', 'mean', 'nanmean', 'median', 'nanmedian', 'sem', 'nansem' };
            if ~strcmp(dimReducFcnName(1:3), 'nan');
                dimReducFcnName = ['nan', dimReducFcnName];
            end;
            dimReducFcn = str2func(dimReducFcnName);
            cellImg = cellfun(@(x) dimReducFcn(x, 3), cellImg, 'UniformOutput', false);
            
        case { 'min', 'nanmin', 'max', 'nanmax', 'std', 'nanstd' };
            if ~strcmp(dimReducFcnName(1:3), 'nan');
                dimReducFcnName = ['nan', dimReducFcnName];
            end;
            dimReducFcn = str2func(dimReducFcnName);
            cellImg = cellfun(@(x) dimReducFcn(x, [], 3), cellImg, 'UniformOutput', false);
            
        otherwise
            error('cell2RGB:UnknownDimReducFunctionName', ...
                'Cannot handle function "%s" as dimension reduction function.', dimReducFcnName);
    end;
end;

% init the channels
red = zeros(size(cellImg{1}));
green = zeros(size(cellImg{1}));
blue = zeros(size(cellImg{1}));

% skip channels where no data was fed in
colorVector(colorVector >= size(cellImg, 1) + 1) = 0;

% extract the channels if required and scale them between 0 and 1
if colorVector(1) && ~isempty(cellImg{colorVector(1)}); red     = linScale(cellImg{colorVector(1)}); end;
if colorVector(2) && ~isempty(cellImg{colorVector(2)}); green   = linScale(cellImg{colorVector(2)}); end;
if colorVector(3) && ~isempty(cellImg{colorVector(3)}); blue    = linScale(cellImg{colorVector(3)}); end

% keep nans in all channels
if ~isempty(red); red(isnan(green) | isnan(blue)) = NaN; end;
if ~isempty(green); green(isnan(red) | isnan(blue)) = NaN; end;
if ~isempty(blue); blue(isnan(red) | isnan(green)) = NaN; end;

% merge the channels
RGBImage = cat(ndims(red) + 1, red, green, blue);

end
