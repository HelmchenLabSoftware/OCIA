function c = str2cell(str, varargin)
% c = str2cell(str) returns a cell-array {C1, C2, C3, ...} from a "C1,C2,C3,..." string
% c = str2cell(str, sep) returns the cell-array as a "C1[sep]C2[sep]C3[sep]..." string
%
% Written on 2014-03-27 by B. Laurenczy (blaurenczy@gmail.com)

    if numel(varargin);
        sep = varargin{1};
    else
        sep = ',';
    end;
    
    c = regexp(str, sep, 'split');

end
