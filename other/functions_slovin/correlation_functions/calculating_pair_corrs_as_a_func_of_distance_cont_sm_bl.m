%% 1711b
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\b
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\b\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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


%% 1711c
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\c
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\c\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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




%% 1711g
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\g
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\g\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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







%% 2411b
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\b
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\b\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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



%% 2411d
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\d
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\d\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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



%% 2411f
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\f
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\f\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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



%% 1412b
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\b
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\b\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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


%% 1412c
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\c
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\c\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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



%% 1412d
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\d
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\d\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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


%% 1412e
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\e
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\e\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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


%% 2212b
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\b
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\b\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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

%% 2212c
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\c
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\c\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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

%% 2212d
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\d
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\d\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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


%% 2912b
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\b
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\b\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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


%% 2912d
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\d
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\d\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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

%% 0501e

clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\e
load('myrois.mat', 'roi_bg_in')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\e\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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

%% 2912c
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\c
load('myrois.mat', 'roi_bg_out')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\c\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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

%% 2912e
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\e
load('myrois.mat', 'roi_bg_out')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\e\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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


%% 2912k
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\k
load('myrois.mat', 'roi_bg_out')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\k\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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



%% 0501b
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\b
load('myrois.mat', 'roi_bg_out')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\b\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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


%% 0501c
clear all
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\c
load('myrois.mat', 'roi_bg_out')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\c\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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



%% 0501d
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\d
load('myrois.mat', 'roi_bg_out')
load('myrois.mat', 'roi_circle')
cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\d\pixelwise
load corr_circ_circ_bl
load corr_bg_circ_bl
load corr_bg_bg_bl

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














