function k = sparseness(varargin)
% calculate sparseness measure k for response vector r (in1) with method
% (in2)
% methods:
% {'kurtosis'}
% 'treves_rolls'
% 'willmore_tolhurst'

% this file written by Henry Luetcke (hluetck@gmail.com)
if nargin == 1
    r = varargin{1};
    method = 'kurtosis';
elseif nargin == 2
    r = varargin{1};
    method = varargin{2};
else
    error('Incorrect number of input arguments.');
end

switch lower(method)
    case 'kurtosis'
        k = doKurtosis(r);
    case 'treves_rolls'
        k = doTrevesRolls(r);
    case 'willmore_tolhurst'
        k = doWillmoreTolhurst(r);
end

function k = doKurtosis(r)
mean_r = mean(r);
sd_r = std(r);
k = zeros(size(r));
for n = 1:length(r)
    k(n) = ((r(n)-mean_r)/sd_r)^4;
end
k = sum(k)/length(r);
k = k - 3;

function k = doTrevesRolls(r)
k1 = sum(r/length(r)); k1 = k1^2;
k2 = sum((r.^2)/length(r));
k = k1 / k2;


function k = doWillmoreTolhurst(r)
k1 = sum(abs(r)/length(r)); k1 = k1^2;
k2 = sum((r.^2)/length(r));
k = 1 - (k1 / k2);



