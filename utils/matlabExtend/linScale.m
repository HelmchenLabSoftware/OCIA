function scaledData = linScale(data, varargin)
% scaledData = linScale(data, varargin):
% Linearly scales the input "data" between two values (argument 2 and 3).
% If argument 2 and 3 are not provided, data is scaled between 0 and 1.

% written by Henry Luetcke (hluetck_at_gmail.com)
% modified by Balazs Laurenczy (blaurenczy_at_gmail.com)

if nargin == 1;
    yMin = 0;
    yMax = 1;
elseif nargin == 2 && numel(varargin{1}) == 2;
    yMin = varargin{1}(1);
    yMax = varargin{1}(2);
elseif nargin == 3;
    yMin = varargin{1};
    yMax = varargin{2};
else
    error('linScale:BadArgumentNumber', 'Number of arguments should be 1 or 3.');
end;

% if yMin >= yMax; error('Input 2 must be smaller than input 3!'); end

% get x boundaries
xMin = min(data(:));
xMax = max(data(:));
% get the slope
slope = (yMax - yMin) / (xMax - xMin);
% get the intercept
intercept = yMin - (slope * xMin);
% abort if infinite or NaN is encountered
if isempty(slope) || isnan(slope) || isinf(slope) || isnan(intercept) || isinf(intercept);
    scaledData = data;
    return;
end;
% scale the data
scaledData = slope .* data + intercept;
% make sure data does not go beyond boundaries
scaledData(scaledData < min(yMin, yMax)) = min(yMin, yMax);
scaledData(scaledData > max(yMin, yMax)) = max(yMin, yMax);

