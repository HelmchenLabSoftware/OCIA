function dim = str2dim(str, varargin)
% dim = str2dim(str) returns the dimension of a "MxNxOx..." string
% dim = str2dim(str, sep) returns the dimension of a "M[sep]N[sep]O[sep]..." string
%
% Written on 2014-03-27 by B. Laurenczy (blaurenczy@gmail.com)

    if numel(varargin);
        sep = varargin{1};
    else
        sep = 'x';
    end;
    
    dim = cellfun(@str2double, regexp(str, sep, 'split'));

end
