function out1 = nansem(varargin)
% Function to calculate standard error of the mean of an input matrix
% sem = std(in1)/sqrt(size(in1(:,n),1))
% in1 can be a vector or 2-D matrix
% for 2-D matrix, sem is calculated columnwise
% NaNs are treated as missing values (not included in calculation of either
% std nor sqrt(N)
% in2 ... dimension (for vector inputs)

out1 = sem(varargin{:});