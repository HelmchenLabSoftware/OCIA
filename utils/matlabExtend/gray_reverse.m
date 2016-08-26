function g = gray_reverse(m)
%GRAYREVERSE   Linear white to black color map
%   GRAY_REVERSE(M) returns an M-by-3 matrix containing a gray-scale colormap.
%   GRAY_REVERSE, by itself, is the same length as the current figure's
%   colormap. If no figure exists, MATLAB creates one.
%
%   For example, to reset the colormap of the current figure:
%
%             colormap(gray_reverse)
%
%   See also HSV, HOT, COOL, BONE, COPPER, PINK, FLAG, 
%   COLORMAP, RGBPLOT.

if nargin < 1, m = size(get(gcf,'colormap'),1); end
g = 1 - ((0 : m - 1)' / max(m - 1, 1));
g = [g g g];
