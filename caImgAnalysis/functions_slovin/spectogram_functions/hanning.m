function w = hanning(n)
if ~rem(n,2)
   w = .5*(1 - cos(2*pi*(1:n/2)'/(n+1)));
   w = [w; w(end:-1:1)];
else
   w = .5*(1 - cos(2*pi*(1:(n+1)/2)'/(n+1)));
   w = [w; w(end-1:-1:1)];
end

function myprintf(verbose, varargin)
    if strcmpi(verbose, 'on')
        fprintf(varargin{:});
    end;