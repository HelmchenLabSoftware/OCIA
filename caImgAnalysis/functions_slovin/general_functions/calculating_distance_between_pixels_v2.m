h=ones(10000,1);
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(h,1)
    for j=1:size(h,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));


[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
        nu(i)=sum(distances==u(i));
end

st=50;
k=-st;
for j=1:floor((size(u,2)-st)/st)-1
    k=k+st;
    nn(j)=mean(nu(j+k:j+k+st));
end



%%
h=ones(25,1);
m=reshape(h,5,5);
[r c]=find(m);
for i=1:size(h,1)
    for j=1:size(h,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));


[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
        nu(i)=sum(distances==u(i));
end












