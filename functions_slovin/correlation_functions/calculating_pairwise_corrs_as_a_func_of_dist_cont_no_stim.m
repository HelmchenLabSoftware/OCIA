clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008
load corr_circ_circ_1111cd_no_stim
load corr_bg_circ_1111cd_no_stim
load corr_bg_bg_1111cd_no_stim
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\c\elhanan_new
load('myrois.mat', 'roi_maskin')
load('myrois.mat', 'roi_contour2')

h=zeros(10000,1);
h(roi_contour2)=1;
h(roi_maskin)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_maskin,1)
    for j=1:size(roi_contour2,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_contour2)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_contour2,1)
    for j=1:size(roi_contour2,1)
       dist_mat2(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_maskin)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_maskin,1)
    for j=1:size(roi_maskin,1)
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


save corr_circ_circ_as_a_function_of_distance_1111cd_no_stim dist_cont dist_non dist_vec

%% 1111h
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\h
load('myrois.mat', 'roi_maskin')
load('myrois.mat', 'roi_contour')
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\h\no_stim\pixelwise\
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_contour)=1;
h(roi_maskin)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_maskin,1)
    for j=1:size(roi_contour,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_contour)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_contour,1)
    for j=1:size(roi_contour,1)
       dist_mat2(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_maskin)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_maskin,1)
    for j=1:size(roi_maskin,1)
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


save corr_circ_circ_as_a_function_of_distance dist_cont dist_non dist_vec




%% 2511d
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\d\correct_and_incorrect_together\no_stim
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle_diff')
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\d\correct_and_incorrect_together\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle_diff)=1;
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_circle_diff,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle_diff)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle_diff,1)
    for j=1:size(roi_circle_diff,1)
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


save corr_circ_circ_as_a_function_of_distance dist_cont dist_non dist_vec



%% 2511e
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\e\correct_and_incorrect_together\no_stim
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle_diff')
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\e\correct_and_incorrect_together\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle_diff)=1;
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_circle_diff,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle_diff)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle_diff,1)
    for j=1:size(roi_circle_diff,1)
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


save corr_circ_circ_as_a_function_of_distance dist_cont dist_non dist_vec


%% 2511f
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\f\correct_and_incorrect_together\no_stim
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle_diff')
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\f\correct_and_incorrect_together\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle_diff)=1;
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_circle_diff,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle_diff)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle_diff,1)
    for j=1:size(roi_circle_diff,1)
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


save corr_circ_circ_as_a_function_of_distance dist_cont dist_non dist_vec


%% 1811c
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\c\correct_and_incorrect_together\no_stim
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle_diff')
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\c\correct_and_incorrect_together\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle_diff)=1;
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_circle_diff,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle_diff)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle_diff,1)
    for j=1:size(roi_circle_diff,1)
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


save corr_circ_circ_as_a_function_of_distance dist_cont dist_non dist_vec



%% 1811d
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\d\correct_and_incorrect_together\no_stim
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle_diff')
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\d\correct_and_incorrect_together\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle_diff)=1;
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_circle_diff,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle_diff)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle_diff,1)
    for j=1:size(roi_circle_diff,1)
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


save corr_circ_circ_as_a_function_of_distance dist_cont dist_non dist_vec


%% 1811e
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\e\correct_and_incorrect_together\no_stim
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle_diff')
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\e\correct_and_incorrect_together\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle_diff)=1;
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_circle_diff,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle_diff)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle_diff,1)
    for j=1:size(roi_circle_diff,1)
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


save corr_circ_circ_as_a_function_of_distance dist_cont dist_non dist_vec



%% 1203d
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\d\correct_and_incorrect_together\no_stim
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle_diff')
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\d\correct_and_incorrect_together\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle_diff)=1;
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_circle_diff,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle_diff)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle_diff,1)
    for j=1:size(roi_circle_diff,1)
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


save corr_circ_circ_as_a_function_of_distance dist_cont dist_non dist_vec



%% 1203e
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\e\correct_and_incorrect_together\no_stim
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle_diff')
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\e\correct_and_incorrect_together\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle_diff)=1;
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_circle_diff,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle_diff)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle_diff,1)
    for j=1:size(roi_circle_diff,1)
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


save corr_circ_circ_as_a_function_of_distance dist_cont dist_non dist_vec



%% 1203f
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\f\correct_and_incorrect_together\no_stim
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle_diff')
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\f\correct_and_incorrect_together\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle_diff)=1;
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_circle_diff,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle_diff)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle_diff,1)
    for j=1:size(roi_circle_diff,1)
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


save corr_circ_circ_as_a_function_of_distance dist_cont dist_non dist_vec


%% 0610e
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\e\no_stim
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle_diff')
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\e\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle_diff)=1;
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_circle_diff,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle_diff)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle_diff,1)
    for j=1:size(roi_circle_diff,1)
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


save corr_circ_circ_as_a_function_of_distance dist_cont dist_non dist_vec


%% 0610f
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\f\no_stim
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle_diff')
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\f\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle_diff)=1;
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_circle_diff,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle_diff)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle_diff,1)
    for j=1:size(roi_circle_diff,1)
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


save corr_circ_circ_as_a_function_of_distance dist_cont dist_non dist_vec


%% 2210d
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\d\no_stim
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle_diff')
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\d\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle_diff)=1;
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_circle_diff,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle_diff)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle_diff,1)
    for j=1:size(roi_circle_diff,1)
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


save corr_circ_circ_as_a_function_of_distance dist_cont dist_non dist_vec


%% 2210e
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\e\no_stim
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle_diff')
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\e\no_stim\pixelwise
load corr_circ_circ
load corr_bg_circ
load corr_bg_bg

h=zeros(10000,1);
h(roi_circle_diff)=1;
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_circle_diff,1)
       dist_mat1(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
h=zeros(10000,1);
h(roi_circle_diff)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle_diff,1)
    for j=1:size(roi_circle_diff,1)
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


save corr_circ_circ_as_a_function_of_distance dist_cont dist_non dist_vec


