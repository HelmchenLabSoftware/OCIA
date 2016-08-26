function dimAsString = dim2str(dim, varargin)
% dimAsString = dim2str(dim) returns the dimension as a "MxNxOx..." string
% dimAsString = dim2str(dim, sep) returns the dimension as a "M[sep]N[sep]O[sep]..." string
%
% Written on 2014-03-27 by B. Laurenczy (blaurenczy@gmail.com)

    if numel(varargin);
        sep = varargin{1};
    else
        sep = 'x';
    end;
    
    dimAsString = regexprep(sprintf(sprintf('%%d%s', sep), dim), sprintf('%s$', sep), '');

end
