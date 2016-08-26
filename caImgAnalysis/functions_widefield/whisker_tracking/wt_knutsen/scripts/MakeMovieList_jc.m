clear all

ca = dir;
ca = struct2cell(ca);
ca = ca(1,:);
ca = reshape(ca, [], 1);
a = size(ca);
a = a(1);
n=1;

for i = 1:a
    if findstr('avi', ca{i}) 
        list{n} = ca{i};
        n = n + 1;
    end
end


savefile=['movie1list.mat']
save (savefile,'list')