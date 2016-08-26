%% 1711b
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\b\no_stim
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\b\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle)=1;
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_circle,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat2(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_bg_in,1)
       dist_mat3(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end

cont=cat(1,cont_circ_circ,cont_bg_bg,cont_bg_circ);
non=cat(1,non_circ_circ,non_bg_bg,non_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);


u=unique(d_sort);


for i=1:size(u,2)
    for j=1:size(cont,2)
        dddc(i,j)=mean(cont(distances==u(i),j),1);
        dddn(i,j)=mean(non(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(cont,2)
    k=-st;
    for j=1:floor((size(dddc,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_all_as_a_function_of_distance dist_cont dist_non dist_vec




%% 1711c
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\c\no_stim
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\c\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle)=1;
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_circle,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat2(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_bg_in,1)
       dist_mat3(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end

cont=cat(1,cont_circ_circ,cont_bg_bg,cont_bg_circ);
non=cat(1,non_circ_circ,non_bg_bg,non_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);


u=unique(d_sort);


for i=1:size(u,2)
    for j=1:size(cont,2)
        dddc(i,j)=mean(cont(distances==u(i),j),1);
        dddn(i,j)=mean(non(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(cont,2)
    k=-st;
    for j=1:floor((size(dddc,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_all_as_a_function_of_distance dist_cont dist_non dist_vec


%% 1711g
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\g\no_stim
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\g\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle)=1;
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_circle,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat2(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_bg_in,1)
       dist_mat3(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end

cont=cat(1,cont_circ_circ,cont_bg_bg,cont_bg_circ);
non=cat(1,non_circ_circ,non_bg_bg,non_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);


u=unique(d_sort);


for i=1:size(u,2)
    for j=1:size(cont,2)
        dddc(i,j)=mean(cont(distances==u(i),j),1);
        dddn(i,j)=mean(non(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(cont,2)
    k=-st;
    for j=1:floor((size(dddc,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_all_as_a_function_of_distance dist_cont dist_non dist_vec


%% 2411b
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\b\no_stim
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\b\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle)=1;
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_circle,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat2(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_bg_in,1)
       dist_mat3(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end

cont=cat(1,cont_circ_circ,cont_bg_bg,cont_bg_circ);
non=cat(1,non_circ_circ,non_bg_bg,non_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);


u=unique(d_sort);


for i=1:size(u,2)
    for j=1:size(cont,2)
        dddc(i,j)=mean(cont(distances==u(i),j),1);
        dddn(i,j)=mean(non(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(cont,2)
    k=-st;
    for j=1:floor((size(dddc,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_all_as_a_function_of_distance dist_cont dist_non dist_vec



%% 2411d
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\d\no_stim
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\d\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle)=1;
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_circle,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat2(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_bg_in,1)
       dist_mat3(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end

cont=cat(1,cont_circ_circ,cont_bg_bg,cont_bg_circ);
non=cat(1,non_circ_circ,non_bg_bg,non_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);


u=unique(d_sort);


for i=1:size(u,2)
    for j=1:size(cont,2)
        dddc(i,j)=mean(cont(distances==u(i),j),1);
        dddn(i,j)=mean(non(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(cont,2)
    k=-st;
    for j=1:floor((size(dddc,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_all_as_a_function_of_distance dist_cont dist_non dist_vec



%% 2411f
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\f\no_stim
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\f\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle)=1;
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_circle,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat2(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_bg_in,1)
       dist_mat3(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end

cont=cat(1,cont_circ_circ,cont_bg_bg,cont_bg_circ);
non=cat(1,non_circ_circ,non_bg_bg,non_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);


u=unique(d_sort);


for i=1:size(u,2)
    for j=1:size(cont,2)
        dddc(i,j)=mean(cont(distances==u(i),j),1);
        dddn(i,j)=mean(non(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(cont,2)
    k=-st;
    for j=1:floor((size(dddc,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_all_as_a_function_of_distance dist_cont dist_non dist_vec



%% 1412b
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\b\no_stim
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\b\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle)=1;
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_circle,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat2(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_bg_in,1)
       dist_mat3(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end

cont=cat(1,cont_circ_circ,cont_bg_bg,cont_bg_circ);
non=cat(1,non_circ_circ,non_bg_bg,non_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);


u=unique(d_sort);


for i=1:size(u,2)
    for j=1:size(cont,2)
        dddc(i,j)=mean(cont(distances==u(i),j),1);
        dddn(i,j)=mean(non(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(cont,2)
    k=-st;
    for j=1:floor((size(dddc,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_all_as_a_function_of_distance dist_cont dist_non dist_vec




%% 1412c
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\c\no_stim
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\c\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle)=1;
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_circle,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat2(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_bg_in,1)
       dist_mat3(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end

cont=cat(1,cont_circ_circ,cont_bg_bg,cont_bg_circ);
non=cat(1,non_circ_circ,non_bg_bg,non_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);


u=unique(d_sort);


for i=1:size(u,2)
    for j=1:size(cont,2)
        dddc(i,j)=mean(cont(distances==u(i),j),1);
        dddn(i,j)=mean(non(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(cont,2)
    k=-st;
    for j=1:floor((size(dddc,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_all_as_a_function_of_distance dist_cont dist_non dist_vec



%% 1412d
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\d\no_stim
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\d\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle)=1;
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_circle,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat2(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_bg_in,1)
       dist_mat3(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end

cont=cat(1,cont_circ_circ,cont_bg_bg,cont_bg_circ);
non=cat(1,non_circ_circ,non_bg_bg,non_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);


u=unique(d_sort);


for i=1:size(u,2)
    for j=1:size(cont,2)
        dddc(i,j)=mean(cont(distances==u(i),j),1);
        dddn(i,j)=mean(non(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(cont,2)
    k=-st;
    for j=1:floor((size(dddc,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_all_as_a_function_of_distance dist_cont dist_non dist_vec



%% 1412e
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\e\no_stim
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\e\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle)=1;
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_circle,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat2(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_bg_in,1)
       dist_mat3(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end

cont=cat(1,cont_circ_circ,cont_bg_bg,cont_bg_circ);
non=cat(1,non_circ_circ,non_bg_bg,non_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);


u=unique(d_sort);


for i=1:size(u,2)
    for j=1:size(cont,2)
        dddc(i,j)=mean(cont(distances==u(i),j),1);
        dddn(i,j)=mean(non(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(cont,2)
    k=-st;
    for j=1:floor((size(dddc,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_all_as_a_function_of_distance dist_cont dist_non dist_vec



%% 2212b
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\b\no_stim
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\b\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle)=1;
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_circle,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat2(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_bg_in,1)
       dist_mat3(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end

cont=cat(1,cont_circ_circ,cont_bg_bg,cont_bg_circ);
non=cat(1,non_circ_circ,non_bg_bg,non_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);


u=unique(d_sort);


for i=1:size(u,2)
    for j=1:size(cont,2)
        dddc(i,j)=mean(cont(distances==u(i),j),1);
        dddn(i,j)=mean(non(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(cont,2)
    k=-st;
    for j=1:floor((size(dddc,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_all_as_a_function_of_distance dist_cont dist_non dist_vec



%% 2212c
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\c\no_stim
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\c\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle)=1;
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_circle,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat2(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_bg_in,1)
       dist_mat3(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end

cont=cat(1,cont_circ_circ,cont_bg_bg,cont_bg_circ);
non=cat(1,non_circ_circ,non_bg_bg,non_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);


u=unique(d_sort);


for i=1:size(u,2)
    for j=1:size(cont,2)
        dddc(i,j)=mean(cont(distances==u(i),j),1);
        dddn(i,j)=mean(non(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(cont,2)
    k=-st;
    for j=1:floor((size(dddc,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_all_as_a_function_of_distance dist_cont dist_non dist_vec



%% 2212d
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\d\no_stim
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\d\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle)=1;
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_circle,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat2(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_bg_in,1)
       dist_mat3(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end

cont=cat(1,cont_circ_circ,cont_bg_bg,cont_bg_circ);
non=cat(1,non_circ_circ,non_bg_bg,non_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);


u=unique(d_sort);


for i=1:size(u,2)
    for j=1:size(cont,2)
        dddc(i,j)=mean(cont(distances==u(i),j),1);
        dddn(i,j)=mean(non(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(cont,2)
    k=-st;
    for j=1:floor((size(dddc,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_all_as_a_function_of_distance dist_cont dist_non dist_vec



%% 2912b
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\b\no_stim
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\b\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle)=1;
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_circle,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat2(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_bg_in,1)
       dist_mat3(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end

cont=cat(1,cont_circ_circ,cont_bg_bg,cont_bg_circ);
non=cat(1,non_circ_circ,non_bg_bg,non_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);


u=unique(d_sort);


for i=1:size(u,2)
    for j=1:size(cont,2)
        dddc(i,j)=mean(cont(distances==u(i),j),1);
        dddn(i,j)=mean(non(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(cont,2)
    k=-st;
    for j=1:floor((size(dddc,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_all_as_a_function_of_distance dist_cont dist_non dist_vec


%% 2912d
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\d\no_stim
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\d\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle)=1;
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_circle,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat2(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_bg_in,1)
       dist_mat3(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end

cont=cat(1,cont_circ_circ,cont_bg_bg,cont_bg_circ);
non=cat(1,non_circ_circ,non_bg_bg,non_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);


u=unique(d_sort);


for i=1:size(u,2)
    for j=1:size(cont,2)
        dddc(i,j)=mean(cont(distances==u(i),j),1);
        dddn(i,j)=mean(non(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(cont,2)
    k=-st;
    for j=1:floor((size(dddc,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_all_as_a_function_of_distance dist_cont dist_non dist_vec


%% 0501e
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\e\no_stim
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\e\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle)=1;
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_circle,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat2(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_bg_in,1)
       dist_mat3(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end

cont=cat(1,cont_circ_circ,cont_bg_bg,cont_bg_circ);
non=cat(1,non_circ_circ,non_bg_bg,non_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);


u=unique(d_sort);


for i=1:size(u,2)
    for j=1:size(cont,2)
        dddc(i,j)=mean(cont(distances==u(i),j),1);
        dddn(i,j)=mean(non(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(cont,2)
    k=-st;
    for j=1:floor((size(dddc,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_all_as_a_function_of_distance dist_cont dist_non dist_vec


%% 2912c
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\c\no_stim
load('myrois.mat', 'roi_bg_out')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\c\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle)=1;
h(roi_bg_out)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_out,1)
    for j=1:size(roi_circle,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat2(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_bg_out)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_out,1)
    for j=1:size(roi_bg_out,1)
       dist_mat3(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end

cont=cat(1,cont_circ_circ,cont_bg_bg,cont_bg_circ);
non=cat(1,non_circ_circ,non_bg_bg,non_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);


u=unique(d_sort);


for i=1:size(u,2)
    for j=1:size(cont,2)
        dddc(i,j)=mean(cont(distances==u(i),j),1);
        dddn(i,j)=mean(non(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(cont,2)
    k=-st;
    for j=1:floor((size(dddc,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_all_as_a_function_of_distance dist_cont dist_non dist_vec

%% 2912e
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\e\no_stim
load('myrois.mat', 'roi_bg_out')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\e\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle)=1;
h(roi_bg_out)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_out,1)
    for j=1:size(roi_circle,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat2(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_bg_out)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_out,1)
    for j=1:size(roi_bg_out,1)
       dist_mat3(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end

cont=cat(1,cont_circ_circ,cont_bg_bg,cont_bg_circ);
non=cat(1,non_circ_circ,non_bg_bg,non_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);


u=unique(d_sort);


for i=1:size(u,2)
    for j=1:size(cont,2)
        dddc(i,j)=mean(cont(distances==u(i),j),1);
        dddn(i,j)=mean(non(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(cont,2)
    k=-st;
    for j=1:floor((size(dddc,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_all_as_a_function_of_distance dist_cont dist_non dist_vec

%% 2912k
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\k\no_stim
load('myrois.mat', 'roi_bg_out')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\k\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle)=1;
h(roi_bg_out)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_out,1)
    for j=1:size(roi_circle,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat2(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_bg_out)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_out,1)
    for j=1:size(roi_bg_out,1)
       dist_mat3(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end

cont=cat(1,cont_circ_circ,cont_bg_bg,cont_bg_circ);
non=cat(1,non_circ_circ,non_bg_bg,non_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);


u=unique(d_sort);


for i=1:size(u,2)
    for j=1:size(cont,2)
        dddc(i,j)=mean(cont(distances==u(i),j),1);
        dddn(i,j)=mean(non(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(cont,2)
    k=-st;
    for j=1:floor((size(dddc,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_all_as_a_function_of_distance dist_cont dist_non dist_vec

%% 0501b
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\b\no_stim
load('myrois.mat', 'roi_bg_out')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\b\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle)=1;
h(roi_bg_out)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_out,1)
    for j=1:size(roi_circle,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat2(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_bg_out)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_out,1)
    for j=1:size(roi_bg_out,1)
       dist_mat3(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end

cont=cat(1,cont_circ_circ,cont_bg_bg,cont_bg_circ);
non=cat(1,non_circ_circ,non_bg_bg,non_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);


u=unique(d_sort);


for i=1:size(u,2)
    for j=1:size(cont,2)
        dddc(i,j)=mean(cont(distances==u(i),j),1);
        dddn(i,j)=mean(non(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(cont,2)
    k=-st;
    for j=1:floor((size(dddc,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_all_as_a_function_of_distance dist_cont dist_non dist_vec



%% 0501c
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\c\no_stim
load('myrois.mat', 'roi_bg_out')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\c\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle)=1;
h(roi_bg_out)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_out,1)
    for j=1:size(roi_circle,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat2(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_bg_out)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_out,1)
    for j=1:size(roi_bg_out,1)
       dist_mat3(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end

cont=cat(1,cont_circ_circ,cont_bg_bg,cont_bg_circ);
non=cat(1,non_circ_circ,non_bg_bg,non_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);


u=unique(d_sort);


for i=1:size(u,2)
    for j=1:size(cont,2)
        dddc(i,j)=mean(cont(distances==u(i),j),1);
        dddn(i,j)=mean(non(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(cont,2)
    k=-st;
    for j=1:floor((size(dddc,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_all_as_a_function_of_distance dist_cont dist_non dist_vec



%% 0501d
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\d\no_stim
load('myrois.mat', 'roi_bg_out')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\d\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle)=1;
h(roi_bg_out)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_out,1)
    for j=1:size(roi_circle,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat2(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_bg_out)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_out,1)
    for j=1:size(roi_bg_out,1)
       dist_mat3(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end

cont=cat(1,cont_circ_circ,cont_bg_bg,cont_bg_circ);
non=cat(1,non_circ_circ,non_bg_bg,non_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);


u=unique(d_sort);


for i=1:size(u,2)
    for j=1:size(cont,2)
        dddc(i,j)=mean(cont(distances==u(i),j),1);
        dddn(i,j)=mean(non(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(cont,2)
    k=-st;
    for j=1:floor((size(dddc,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_all_as_a_function_of_distance dist_cont dist_non dist_vec

