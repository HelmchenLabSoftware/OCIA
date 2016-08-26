function nByn1 = perfNbyN1(perfBySession,roiID)

roiSet = []; perfByRoiSet = [];
for n = 1:numel(roiID)
   roiSet = [roiSet; roiID{n}];
   perfByRoiSet = [perfByRoiSet; perfBySession{n}(1:end-1)']; % last entry is population score
end
roiSetUnique = unique(roiSet);

nByn1 = zeros(1,2); pos = 1;
for n = 1:numel(roiSetUnique)
    ix = find(strcmp(roiSet,roiSetUnique{n}));
    if numel(ix) > 1
        for m1 = 1:numel(ix)
            for m2 = 1:numel(ix)
               if m2>m1
                   nByn1(pos,1:2) = [perfByRoiSet(ix(m1)), perfByRoiSet(ix(m2))];
                   pos = pos + 1;
               end
            end
        end
    end
end

end
