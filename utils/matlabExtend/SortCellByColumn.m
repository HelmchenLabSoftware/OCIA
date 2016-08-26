function out = SortCellByColumn(in,col)
% sort a cell array according to entries in column col

% this file written by Henry Luetcke (hluetck@gmail.com)

[sorted_col,index] = sort(in(:,col));
out = cell(size(in));
for n = 1:size(out,1)
   out(n,:) = in(index(n),:);
end