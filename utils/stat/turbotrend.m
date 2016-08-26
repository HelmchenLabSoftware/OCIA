function [xs, z, yfit] = turbotrend(x, y, lambda, n)
% based on http://stat.ethz.ch/events/archive/Ascona_04/Slides/eilers.pdf
% lambda determines smoothness (larger = smoother; best around 0.5 - 5)
% n should be close to or equal numel(x)

% Discretize x & compute bin midpoints
xmin = min(x);
xmax = max(x);
dx = 1.0001 * (xmax - xmin) / n;
xb = floor(1 + (x - xmin) / dx);
xs = xmin + ((1:n) - 0.5)' * dx;
% Construct equations & solve
s = sparse(xb, 1, y); % Right-hand side
t = sparse(xb, 1, 1); % Diagonal W = B'B
D = diff(eye(n), 2);
W = spdiags(t, 0, n, n);
C = chol(W + lambda * D' * D);
z = C \ (C' \ s); % Solve with Cholesky
yfit = z(xb);

end
