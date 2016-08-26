function Vshuff = shuffleArray(V,varargin)
% randomly shuffle elements in V
% for 2D-arrays, shuffle column-wise (new permutation for each column)
% optional:
% vector with IDs for each row --> shuffle so that order of rowIDs is destroyed

% this file written by Henry Luetcke(hluetck@gmail.com)

if nargin > 1
   rowIDs = varargin{1};
else
    rowIDs = 1:size(V,1);
end

if size(V,1) == 1
    V = reshape(V,numel(V),1);
end

if nargin > 1
   rowIDs = varargin{1};
else
    rowIDs = 1:size(V,1);
end
rowIDs = reshape(rowIDs,numel(rowIDs),1);

Vshuff = zeros(size(V));
permMemory = zeros(size(V,1),size(V,2));
for col = 1:size(V,2)
    while true
        a = randperm(size(V,1));
        doBreak = 1;
        for n = 1:length(a)
            if rowIDs(n) == rowIDs(a(n))
               doBreak = 0;
               break
            end
        end
        if ~doBreak
           continue 
        end
        if ~isequal(a,[1:size(V,1)])
            doBreak = 1;
            for col2 = 1:col-1
                if isequal(a',permMemory(:,col2))
                   doBreak = 0;
                end
            end
            if doBreak
                permMemory(:,col) = a;
                break
            end
        end
    end
    for n = 1:size(V,1)
        Vshuff(n,col) = V(a(n),col);
    end
end
