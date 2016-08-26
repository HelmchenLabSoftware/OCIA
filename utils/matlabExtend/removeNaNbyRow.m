function A = removeNaNbyRow(A)
% Any row containing at least one NaN entry is removed 

rowIx = any(isnan(A'));
A(rowIx',:) = [];

end

