function cellAsString = cell2str(c, varargin)
% cellAsString = cell2str(c) returns the cell-array as a "C1,C2,C3,..." string
% cellAsString = cell2str(c, sep) returns the cell-array as a "C1[sep]C2[sep]C3[sep]..." string
%
% Written on 2014-03-27 by B. Laurenczy (blaurenczy@gmail.com)

    if numel(varargin);
        sep = varargin{1};
    else
        sep = ',';
    end;
    
    cellAsString = regexprep(sprintf(sprintf('%%s%s', sep), c{:}), sprintf('%s$', sep), '');

end
