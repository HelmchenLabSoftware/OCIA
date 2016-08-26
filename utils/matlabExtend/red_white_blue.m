function r = red_white_blue(m)
%RED_WHITE_BLUE   Linear white to black color map
%   RED_WHITE_BLUE(M) returns an M-by-3 matrix containing a red to blue colormap.
%   RED_WHITE_BLUE, by itself, is the same length as the current figure's
%   colormap. If no figure exists, MATLAB creates one.
%
%   For example, to reset the colormap of the current figure:
%
%             colormap(red_white_blue)
%
%   See also HSV, HOT, COOL, BONE, COPPER, PINK, FLAG, 
%   COLORMAP, RGBPLOT.

if nargin < 1, m = size(get(gcf,'colormap'),1); end
m = round(0.5 * m);
r = [ones(m, 1); 1 - ((0 : m - 1)' / max(m - 1, 1))];
rmid = [((0 : m - 1)' / max(m - 1, 1)); 1 - ((0 : m - 1)' / max(m - 1, 1))];
rback = [((0 : m - 1)' / max(m - 1, 1)); ones(m, 1)];
r = [r rmid rback];
