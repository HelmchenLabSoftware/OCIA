function [out,r] = correlatedVariables(samples,targetCC)
% generate correlated random variables
% the generared variables will be correlated, on average, with the
% correlation coefficient targetCC
% specify a vector to generate a correlated vector

% this file written by Henry Luetcke (hluetck@gmail.com)

if numel(samples) == 1
    x = rand(samples,1);
    y = rand(samples,1);
elseif isvector(samples)
    y = rand(numel(samples),1);
    x = reshape(samples,numel(samples),1);
else
    % assume x and y data in columns
    x = samples(:,1);
    y = samples(:,2);
end

% multiplication with upper triangular Cholesky decomposition of
% correlation matrix
y = x*targetCC+y*sqrt(1-targetCC^2);

r = corrcoef(x,y);
r = r(1,2);

out = [x,y];