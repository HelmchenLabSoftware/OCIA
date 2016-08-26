function out1 = sem(varargin)
% Function to calculate standard error of the mean of an input matrix
% sem = std(in1)/sqrt(size(in1(:,n),1))
% in1 can be a vector or 2-D matrix
% for 2-D matrix, sem is calculated columnwise
% NaNs are treated as missing values (not included in calculation of either
% std nor sqrt(N)
% in2 ... dimension (for vector inputs)

in1 = varargin{1};
if nargin == 2;
    dim = varargin{2};
else
    dim = [];
end;
if length(size(in1)) > 2;
    disp('Dimension of input matrix not allowed');
    help sem
    out1 = [];
    return;
end;
% special case of vector input
% if vectors is along dim, take sem, otherwise sem = 0
if isvector(in1)
    [~, idx] = max(size(in1));
    if ~isempty(dim)
        if idx == dim
            in1 = reshape(in1,numel(in1),1);
        else
            out1 = zeros(size(in1));
            return
        end
    else
        in1 = reshape(in1,numel(in1),1);
    end
end

% special case of matrix input
if ismatrix(in1) && ndims(in1) == 2 && ~isempty(dim) && dim == 2; %#ok<ISMAT>
    in1 = in1';
end

if length(size(in1)) == 1
    % remove NaNs from in1
    non_nans = length(in1(~isnan(in1)));
    out1 = nanstd(in1)/sqrt(non_nans);
elseif length(size(in1)) == 2
    out1 = zeros(1,size(in1,2));
    for n = 1:size(in1,2)
        vect = in1(:,n);
        non_nans = length(vect(~isnan(vect)));
        if non_nans > 0
            out1(n) = nanstd(vect)/sqrt(non_nans);
        else
            out1(n) = NaN;
        end
    end
end