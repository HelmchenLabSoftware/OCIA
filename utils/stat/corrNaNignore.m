function cc = corrNaNignore(a,b)
% correlates the equal sized arrays a and b, but ignores all points where
% either a or b are NaN

% written by Henry Luetcke (hluetck@gmail.com)

a = double(reshape(a,numel(a),1));
b = double(reshape(b,numel(b),1));

nan_idx = find(isnan(a));
nan_idx = unique([nan_idx find(isnan(b))]);

a(nan_idx) = []; b(nan_idx) = [];

cc = corr(a,b);