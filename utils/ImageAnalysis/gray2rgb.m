function rgb = gray2rgb(varargin)
% convenience function to convert a grayscale image to RGB using gray2ind
% and ind2rgb (colormap: jet)
% n is the size of the colormap

% this file written by Henry Luetcke (hluetck@gmail.com)

if nargin > 3
   doScale = varargin{4};
else
    doScale = 1;
end

if doScale
    X = linScale(varargin{1});
else
    X = varargin{1};
end

n = varargin{2};
if nargin > 2
   cmap = varargin{3};
else
    cmap = 'jet';
end

if ~nansum(X(:))
    rgb = repmat(X,[1 1 3]);
else
    cmap_string = sprintf('%s(%s)',cmap,int2str(n));
    [X,map] = gray2ind(X,n);
    rgb = eval(['ind2rgb(X,' cmap_string ')']);
    % rgb = ind2rgb(X,jet(n));
end
