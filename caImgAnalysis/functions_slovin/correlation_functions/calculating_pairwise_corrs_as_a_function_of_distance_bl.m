%% 1111c3
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\c\elhanan_new\pixelwise
t=8;
load coeff_maskin_contour2_cond3
coeff_bg_circ_cond3=mean(coeff_maskin_contour2_cond3(:,:,t),3);
clear coeff_maskin_contour2_cond3
bl_bg_circ=coeff_bg_circ_cond3;
bl_bg_circ=reshape(bl_bg_circ,[size(bl_bg_circ,1)*size(bl_bg_circ,2) size(bl_bg_circ,3)]);


load coeff_contour2_cond3
coeff_circ_cond3=mean(coeff_contour2_cond3(:,:,t),3);
clear coeff_contour2_cond3
bl_circ_circ=coeff_circ_cond3;
bl_circ_circ=reshape(bl_circ_circ,[size(bl_circ_circ,1)*size(bl_circ_circ,2) size(bl_circ_circ,3)]);


load coeff_maskin_cond3
coeff_bg_cond3=mean(coeff_maskin_cond3(:,:,t),3);
clear coeff_maskin_cond3
bl_bg_bg=coeff_bg_cond3;
bl_bg_bg=reshape(bl_bg_bg,[size(bl_bg_bg,1)*size(bl_bg_bg,2) size(bl_bg_bg,3)]);


corr_v1=cat(1,bl_circ_circ,bl_bg_bg,bl_bg_circ);
save corr_v1 corr_v1


%% all pixels in v1
t=8;
load coeff_v1_cond3
bl_v1=mean(coeff_v1_cond3(:,:,t),3);
clear coeff_v1_cond3
bl_v1=reshape(bl_v1,[size(bl_v1,1)*size(bl_v1,2) size(bl_v1,3)]);
save corr_v1_all bl_v1


% cond1
t=8;
load coeff_v1_cond1
c1_v1=mean(coeff_v1_cond1(:,:,t),3);
clear coeff_v1_cond3
c1_v1=reshape(c1_v1,[size(c1_v1,1)*size(c1_v1,2) size(c1_v1,3)]);
save corr_v1_all_c1 c1_v1



%%
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\c\elhanan_new
load v1
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\c\elhanan_new\pixelwise
load corr_v1_all

h=zeros(10000,1);
h(roi_v1)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_v1,1)
    for j=1:size(roi_v1,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=bl_v1;
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(distances==u(i),j),1);
        nu(i)=sum(distances==u(i));
    end
end


st=50;
for jj=1:size(diff,2)
    k=-st;
    for j=1:floor((size(ddd,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        nn(j)=mean(nu(j+k:j+k+st));
        dist_diff(j,jj)=mean(ddd(j+k:j+k+st,jj),1);
    end
end

dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,2))
%ylim([-0.03 0.07])
%xlim([0 12])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')


save corr_bl_v1_as_a_function_of_distance dist_diff dist_vec


clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\c\elhanan_new
load v1
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\c\elhanan_new\pixelwise
load corr_v1_all_c1

h=zeros(10000,1);
h(roi_v1)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_v1,1)
    for j=1:size(roi_v1,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=c1_v1;
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(distances==u(i),j),1);
    end
end


st=50;
for jj=1:size(diff,2)
    k=-st;
    for j=1:floor((size(ddd,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_diff(j,jj)=mean(ddd(j+k:j+k+st,jj),1);
    end
end

dist_vec=us*0.17;
figure;plot(dist_vec,nanmean(dist_diff,2))
%ylim([-0.03 0.07])
%xlim([0 12])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')


save corr_c1_v1_as_a_function_of_distance dist_diff dist_vec


%%
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\d\elhanan_new
load v1
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\d\elhanan_new\pixelwise
load corr_v1_all

h=zeros(10000,1);
h(roi_v1)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_v1,1)
    for j=1:size(roi_v1,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=bl_v1;
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(distances==u(i),j),1);
        nu(i)=sum(distances==u(i));
    end
end


st=50;
for jj=1:size(diff,2)
    k=-st;
    for j=1:floor((size(ddd,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        nn(j)=mean(nu(j+k:j+k+st));
        dist_diff(j,jj)=mean(ddd(j+k:j+k+st,jj),1);
    end
end

dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,2))
%ylim([-0.03 0.07])
%xlim([0 12])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')


save corr_bl_v1_as_a_function_of_distance dist_diff dist_vec

