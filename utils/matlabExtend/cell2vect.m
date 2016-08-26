function vect = cell2vect(A)
% collect all elements in cell array A into a vector

% this file written by Henry Luetcke (hluetck@gmail.com)

vect = [];
A = reshape(A,1,numel(A));
for cells = 1:length(A)
   current_mat = A{cells};
   vect = [vect reshape(current_mat,1,numel(current_mat))];
end