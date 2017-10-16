clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\c\elhanan_new
load('myrois.mat', 'roi_maskin')
load('myrois.mat', 'roi_contour2')
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\c\elhanan_new\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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

diff=cat(1,bl_circ_circ,bl_bg_bg,bl_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)   
    ddd(i)=mean(diff(distances==u(i)),1);
end


st=50;
k=-st;
for j=1:floor((size(ddd,2)-st)/st)
    k=k+st;
    us(j)=mean(u(j+k:j+k+st));
    dist_diff(j)=mean(ddd(j+k:j+k+st),2);
end

dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,1))
%ylim([-0.03 0.07])
%xlim([0 12])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')

save corr_between_rois_bl dist_diff dist_vec

%% 1111d
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\d\elhanan_new
load('myrois.mat', 'roi_maskin')
load('myrois.mat', 'roi_contour2')
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\d\elhanan_new\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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

diff=cat(1,bl_circ_circ,bl_bg_bg,bl_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)   
    ddd(i)=mean(diff(distances==u(i)),1);
end


st=50;
k=-st;
for j=1:floor((size(ddd,2)-st)/st)
    k=k+st;
    us(j)=mean(u(j+k:j+k+st));
    dist_diff(j)=mean(ddd(j+k:j+k+st),2);
end

dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,1))
%ylim([-0.03 0.07])
%xlim([0 12])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')

save corr_between_rois_bl dist_diff dist_vec


%% 1111h
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\h
load('myrois.mat', 'roi_maskin')
load('myrois.mat', 'roi_contour')
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\h\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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

diff=cat(1,bl_circ_circ,bl_bg_bg,bl_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)   
    ddd(i)=mean(diff(distances==u(i)),1);
end


st=50;
k=-st;
for j=1:floor((size(ddd,2)-st)/st)
    k=k+st;
    us(j)=mean(u(j+k:j+k+st));
    dist_diff(j)=mean(ddd(j+k:j+k+st),2);
end

dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,1))
%ylim([-0.03 0.07])
%xlim([0 12])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')

save corr_between_rois_bl dist_diff dist_vec



%% 2511d
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\d\correct_and_incorrect_together
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_contour')
load('myrois.mat', 'roi_circle_diff')
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\d\correct_and_incorrect_together\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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
h(roi_contour)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_contour,1)
    for j=1:size(roi_contour,1)
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

diff=cat(1,bl_circ_circ,bl_bg_bg,bl_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)   
    ddd(i)=mean(diff(distances==u(i)),1);
end


st=50;
k=-st;
for j=1:floor((size(ddd,2)-st)/st)
    k=k+st;
    us(j)=mean(u(j+k:j+k+st));
    dist_diff(j)=mean(ddd(j+k:j+k+st),2);
end

dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,1))
%ylim([-0.03 0.07])
%xlim([0 12])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')

save corr_between_rois_bl dist_diff dist_vec


%% 2511e
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\e\correct_and_incorrect_together
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_contour')
load('myrois.mat', 'roi_circle_diff')
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\e\correct_and_incorrect_together\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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
h(roi_contour)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_contour,1)
    for j=1:size(roi_contour,1)
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

diff=cat(1,bl_circ_circ,bl_bg_bg,bl_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)   
    ddd(i)=mean(diff(distances==u(i)),1);
end


st=50;
k=-st;
for j=1:floor((size(ddd,2)-st)/st)
    k=k+st;
    us(j)=mean(u(j+k:j+k+st));
    dist_diff(j)=mean(ddd(j+k:j+k+st),2);
end

dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,1))
%ylim([-0.03 0.07])
%xlim([0 12])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')

save corr_between_rois_bl dist_diff dist_vec

%% 2511f
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\f\correct_and_incorrect_together
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_contour')
load('myrois.mat', 'roi_circle_diff')
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\f\correct_and_incorrect_together\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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
h(roi_contour)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_contour,1)
    for j=1:size(roi_contour,1)
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

diff=cat(1,bl_circ_circ,bl_bg_bg,bl_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)   
    ddd(i)=mean(diff(distances==u(i)),1);
end


st=50;
k=-st;
for j=1:floor((size(ddd,2)-st)/st)
    k=k+st;
    us(j)=mean(u(j+k:j+k+st));
    dist_diff(j)=mean(ddd(j+k:j+k+st),2);
end

dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,1))
%ylim([-0.03 0.07])
%xlim([0 12])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')

save corr_between_rois_bl dist_diff dist_vec

%% 1811c
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\c\correct_and_incorrect_together
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_contour')
load('myrois.mat', 'roi_circle_diff')
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\c\correct_and_incorrect_together\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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
h(roi_contour)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_contour,1)
    for j=1:size(roi_contour,1)
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

diff=cat(1,bl_circ_circ,bl_bg_bg,bl_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)   
    ddd(i)=mean(diff(distances==u(i)),1);
end


st=50;
k=-st;
for j=1:floor((size(ddd,2)-st)/st)
    k=k+st;
    us(j)=mean(u(j+k:j+k+st));
    dist_diff(j)=mean(ddd(j+k:j+k+st),2);
end

dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,1))
%ylim([-0.03 0.07])
%xlim([0 12])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')

save corr_between_rois_bl dist_diff dist_vec



%% 1811d
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\d\correct_and_incorrect_together
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_contour')
load('myrois.mat', 'roi_circle_diff')
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\d\correct_and_incorrect_together\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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
h(roi_contour)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_contour,1)
    for j=1:size(roi_contour,1)
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

diff=cat(1,bl_circ_circ,bl_bg_bg,bl_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)   
    ddd(i)=mean(diff(distances==u(i)),1);
end


st=50;
k=-st;
for j=1:floor((size(ddd,2)-st)/st)
    k=k+st;
    us(j)=mean(u(j+k:j+k+st));
    dist_diff(j)=mean(ddd(j+k:j+k+st),2);
end

dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,1))
%ylim([-0.03 0.07])
%xlim([0 12])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')

save corr_between_rois_bl dist_diff dist_vec

%% 1811e
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\e\correct_and_incorrect_together
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_contour')
load('myrois.mat', 'roi_circle_diff')
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\e\correct_and_incorrect_together\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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
h(roi_contour)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_contour,1)
    for j=1:size(roi_contour,1)
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

diff=cat(1,bl_circ_circ,bl_bg_bg,bl_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)   
    ddd(i)=mean(diff(distances==u(i)),1);
end


st=50;
k=-st;
for j=1:floor((size(ddd,2)-st)/st)
    k=k+st;
    us(j)=mean(u(j+k:j+k+st));
    dist_diff(j)=mean(ddd(j+k:j+k+st),2);
end

dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,1))
%ylim([-0.03 0.07])
%xlim([0 12])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')

save corr_between_rois_bl dist_diff dist_vec

%% 1203d
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\d\correct_and_incorrect_together
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_contour')
load('myrois.mat', 'roi_circle_diff')
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\d\correct_and_incorrect_together\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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
h(roi_contour)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_contour,1)
    for j=1:size(roi_contour,1)
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

diff=cat(1,bl_circ_circ,bl_bg_bg,bl_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)   
    ddd(i)=mean(diff(distances==u(i)),1);
end


st=50;
k=-st;
for j=1:floor((size(ddd,2)-st)/st)
    k=k+st;
    us(j)=mean(u(j+k:j+k+st));
    dist_diff(j)=mean(ddd(j+k:j+k+st),2);
end

dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,1))
%ylim([-0.03 0.07])
%xlim([0 12])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')

save corr_between_rois_bl dist_diff dist_vec



%% 1203e
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\e\correct_and_incorrect_together
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_contour')
load('myrois.mat', 'roi_circle_diff')
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\e\correct_and_incorrect_together\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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
h(roi_contour)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_contour,1)
    for j=1:size(roi_contour,1)
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

diff=cat(1,bl_circ_circ,bl_bg_bg,bl_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)   
    ddd(i)=mean(diff(distances==u(i)),1);
end


st=50;
k=-st;
for j=1:floor((size(ddd,2)-st)/st)
    k=k+st;
    us(j)=mean(u(j+k:j+k+st));
    dist_diff(j)=mean(ddd(j+k:j+k+st),2);
end

dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,1))
%ylim([-0.03 0.07])
%xlim([0 12])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')

save corr_between_rois_bl dist_diff dist_vec

%% 1203f
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\f\correct_and_incorrect_together
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_contour')
load('myrois.mat', 'roi_circle_diff')
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\f\correct_and_incorrect_together\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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
h(roi_contour)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_contour,1)
    for j=1:size(roi_contour,1)
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

diff=cat(1,bl_circ_circ,bl_bg_bg,bl_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)   
    ddd(i)=mean(diff(distances==u(i)),1);
end


st=50;
k=-st;
for j=1:floor((size(ddd,2)-st)/st)
    k=k+st;
    us(j)=mean(u(j+k:j+k+st));
    dist_diff(j)=mean(ddd(j+k:j+k+st),2);
end

dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,1))
%ylim([-0.03 0.07])
%xlim([0 12])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')

save corr_between_rois_bl dist_diff dist_vec

%% 0610e
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\e
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_contour')
load('myrois.mat', 'roi_circle_diff')
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\e\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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
h(roi_contour)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_contour,1)
    for j=1:size(roi_contour,1)
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

diff=cat(1,bl_circ_circ,bl_bg_bg,bl_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)   
    ddd(i)=mean(diff(distances==u(i)),1);
end


st=50;
k=-st;
for j=1:floor((size(ddd,2)-st)/st)
    k=k+st;
    us(j)=mean(u(j+k:j+k+st));
    dist_diff(j)=mean(ddd(j+k:j+k+st),2);
end

dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,1))
%ylim([-0.03 0.07])
%xlim([0 12])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')

save corr_between_rois_bl dist_diff dist_vec


%% 0610f
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\f
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_contour')
load('myrois.mat', 'roi_circle_diff')
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\f\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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
h(roi_contour)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_contour,1)
    for j=1:size(roi_contour,1)
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

diff=cat(1,bl_circ_circ,bl_bg_bg,bl_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)   
    ddd(i)=mean(diff(distances==u(i)),1);
end


st=50;
k=-st;
for j=1:floor((size(ddd,2)-st)/st)
    k=k+st;
    us(j)=mean(u(j+k:j+k+st));
    dist_diff(j)=mean(ddd(j+k:j+k+st),2);
end

dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,1))
%ylim([-0.03 0.07])
%xlim([0 12])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')

save corr_between_rois_bl dist_diff dist_vec

%% 2210d
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\d
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_contour')
load('myrois.mat', 'roi_circle_diff')
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\d\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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
h(roi_contour)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_contour,1)
    for j=1:size(roi_contour,1)
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

diff=cat(1,bl_circ_circ,bl_bg_bg,bl_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)   
    ddd(i)=mean(diff(distances==u(i)),1);
end


st=50;
k=-st;
for j=1:floor((size(ddd,2)-st)/st)
    k=k+st;
    us(j)=mean(u(j+k:j+k+st));
    dist_diff(j)=mean(ddd(j+k:j+k+st),2);
end

dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,1))
%ylim([-0.03 0.07])
%xlim([0 12])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')

save corr_between_rois_bl dist_diff dist_vec

%% 2210e
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\e
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_contour')
load('myrois.mat', 'roi_circle_diff')
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\e\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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
h(roi_contour)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_contour,1)
    for j=1:size(roi_contour,1)
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

diff=cat(1,bl_circ_circ,bl_bg_bg,bl_bg_circ);
distances=cat(2,reshape(dist_mat2,1,size(dist_mat2,1)*size(dist_mat2,2)),reshape(dist_mat3,1,size(dist_mat3,1)*size(dist_mat3,2)),reshape(dist_mat1,1,size(dist_mat1,1)*size(dist_mat1,2)));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)   
    ddd(i)=mean(diff(distances==u(i)),1);
end


st=50;
k=-st;
for j=1:floor((size(ddd,2)-st)/st)
    k=k+st;
    us(j)=mean(u(j+k:j+k+st));
    dist_diff(j)=mean(ddd(j+k:j+k+st),2);
end

dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,1))
%ylim([-0.03 0.07])
%xlim([0 12])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')

save corr_between_rois_bl dist_diff dist_vec

