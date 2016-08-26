clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008
load corr_circ_circ_1111cd

h=zeros(10000,1);
h(roi_contour2)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_contour2,1)
    for j=1:size(roi_contour2,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(distances==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(distances==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(diff,2)
    k=-st;
    for j=1:floor((size(ddd,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_diff(j,jj)=mean(ddd(j+k:j+k+st,jj),1);
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,2))
ylim([-0.03 0.07])
xlim([0 12])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 12])
ylim([0 0.5])

save corr_circ_circ_as_a_function_of_distance_1111cd dist_diff dist_cont dist_non dist_vec


%%
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008
load corr_bg_bg_1111cd

h=zeros(10000,1);
h(roi_maskin)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_maskin,1)
    for j=1:size(roi_maskin,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_bg_bg-non_bg_bg;
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(distances==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(distances==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(diff,2)
    k=-st;
    for j=1:floor((size(ddd,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_diff(j,jj)=mean(ddd(j+k:j+k+st,jj),1);
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,2))
ylim([-0.03 0.07])
xlim([0 12])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 12])
ylim([0 0.5])

save corr_bg_bg_as_a_function_of_distance_1111cd dist_diff dist_cont dist_non dist_vec

%%
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\h\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_contour)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_contour,1)
    for j=1:size(roi_contour,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(distances==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(distances==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(diff,2)
    k=-st;
    for j=1:floor((size(ddd,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_diff(j,jj)=mean(ddd(j+k:j+k+st,jj),1);
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,2))
ylim([-0.03 0.07])
xlim([0 12])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 12])
ylim([0 0.5])

save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec


%%
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\h\pixelwise
load corr_bg_bg

h=zeros(10000,1);
h(roi_maskin)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_maskin,1)
    for j=1:size(roi_maskin,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_bg_bg-non_bg_bg;
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(distances==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(distances==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(diff,2)
    k=-st;
    for j=1:floor((size(ddd,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_diff(j,jj)=mean(ddd(j+k:j+k+st,jj),1);
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,2))
ylim([-0.03 0.07])
xlim([0 12])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 12])
ylim([0 0.5])

save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec


%% 2511d
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\d\correct_and_incorrect_together\pixelwise
load corr_bg_bg

h=zeros(10000,1);
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_bg_in,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_bg_bg-non_bg_bg;
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(distances==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(distances==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(diff,2)
    k=-st;
    for j=1:floor((size(ddd,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_diff(j,jj)=mean(ddd(j+k:j+k+st,jj),1);
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,2))
ylim([-0.07 0.04])
xlim([0 9])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%%
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\d\correct_and_incorrect_together\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle_diff)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle_diff,1)
    for j=1:size(roi_circle_diff,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(distances==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(distances==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(diff,2)
    k=-st;
    for j=1:floor((size(ddd,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_diff(j,jj)=mean(ddd(j+k:j+k+st,jj),1);
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,2))
ylim([-0.04 0.07])
xlim([0 13])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 13])
ylim([0 0.2])

save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec




%% 2511e
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\e\correct_and_incorrect_together\pixelwise
load corr_bg_bg

h=zeros(10000,1);
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_bg_in,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_bg_bg-non_bg_bg;
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(distances==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(distances==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(diff,2)
    k=-st;
    for j=1:floor((size(ddd,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_diff(j,jj)=mean(ddd(j+k:j+k+st,jj),1);
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,2))
ylim([-0.07 0.04])
xlim([0 9])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%%
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\e\correct_and_incorrect_together\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle_diff)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle_diff,1)
    for j=1:size(roi_circle_diff,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(distances==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(distances==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(diff,2)
    k=-st;
    for j=1:floor((size(ddd,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_diff(j,jj)=mean(ddd(j+k:j+k+st,jj),1);
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,2))
ylim([-0.04 0.07])
xlim([0 13])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 13])
ylim([0 0.2])

save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec




%% 2511f
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\f\correct_and_incorrect_together\pixelwise
load corr_bg_bg

h=zeros(10000,1);
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_bg_in,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_bg_bg-non_bg_bg;
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(distances==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(distances==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(diff,2)
    k=-st;
    for j=1:floor((size(ddd,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_diff(j,jj)=mean(ddd(j+k:j+k+st,jj),1);
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,2))
ylim([-0.07 0.04])
xlim([0 9])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%%
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\f\correct_and_incorrect_together\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle_diff)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle_diff,1)
    for j=1:size(roi_circle_diff,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(distances==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(distances==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(diff,2)
    k=-st;
    for j=1:floor((size(ddd,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_diff(j,jj)=mean(ddd(j+k:j+k+st,jj),1);
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,2))
ylim([-0.04 0.07])
xlim([0 13])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 13])
ylim([0 0.2])

save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec




%% 1811c
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\c\correct_and_incorrect_together\pixelwise
load corr_bg_bg

h=zeros(10000,1);
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_bg_in,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_bg_bg-non_bg_bg;
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(distances==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(distances==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(diff,2)
    k=-st;
    for j=1:floor((size(ddd,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_diff(j,jj)=mean(ddd(j+k:j+k+st,jj),1);
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,2))
ylim([-0.07 0.04])
xlim([0 9])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%%
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\c\correct_and_incorrect_together\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle_diff)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle_diff,1)
    for j=1:size(roi_circle_diff,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(distances==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(distances==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(diff,2)
    k=-st;
    for j=1:floor((size(ddd,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_diff(j,jj)=mean(ddd(j+k:j+k+st,jj),1);
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,2))
ylim([-0.04 0.07])
xlim([0 13])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 13])
ylim([0 0.2])

save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%% 1811d
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\d\correct_and_incorrect_together\pixelwise
load corr_bg_bg

h=zeros(10000,1);
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_bg_in,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_bg_bg-non_bg_bg;
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(distances==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(distances==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(diff,2)
    k=-st;
    for j=1:floor((size(ddd,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_diff(j,jj)=mean(ddd(j+k:j+k+st,jj),1);
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,2))
ylim([-0.07 0.04])
xlim([0 9])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%%
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\d\correct_and_incorrect_together\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle_diff)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle_diff,1)
    for j=1:size(roi_circle_diff,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(distances==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(distances==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(diff,2)
    k=-st;
    for j=1:floor((size(ddd,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_diff(j,jj)=mean(ddd(j+k:j+k+st,jj),1);
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,2))
ylim([-0.04 0.07])
xlim([0 13])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 13])
ylim([0 0.2])

save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec


%% 1811e
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\e\correct_and_incorrect_together\pixelwise
load corr_bg_bg

h=zeros(10000,1);
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_bg_in,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_bg_bg-non_bg_bg;
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(distances==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(distances==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(diff,2)
    k=-st;
    for j=1:floor((size(ddd,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_diff(j,jj)=mean(ddd(j+k:j+k+st,jj),1);
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,2))
ylim([-0.07 0.04])
xlim([0 9])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%%
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\e\correct_and_incorrect_together\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle_diff)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle_diff,1)
    for j=1:size(roi_circle_diff,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(distances==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(distances==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(diff,2)
    k=-st;
    for j=1:floor((size(ddd,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_diff(j,jj)=mean(ddd(j+k:j+k+st,jj),1);
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,2))
ylim([-0.04 0.07])
xlim([0 13])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 13])
ylim([0 0.2])

save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%% 1203d
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\d\correct_and_incorrect_together\pixelwise
load corr_bg_bg

h=zeros(10000,1);
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_bg_in,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_bg_bg-non_bg_bg;
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(distances==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(distances==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(diff,2)
    k=-st;
    for j=1:floor((size(ddd,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_diff(j,jj)=mean(ddd(j+k:j+k+st,jj),1);
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,2))
ylim([-0.07 0.04])
xlim([0 9])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%%
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\d\correct_and_incorrect_together\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle_diff)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle_diff,1)
    for j=1:size(roi_circle_diff,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(distances==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(distances==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(diff,2)
    k=-st;
    for j=1:floor((size(ddd,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_diff(j,jj)=mean(ddd(j+k:j+k+st,jj),1);
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,2))
ylim([-0.04 0.07])
xlim([0 13])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 13])
ylim([0 0.2])

save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%% 1203e
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\e\correct_and_incorrect_together\pixelwise
load corr_bg_bg

h=zeros(10000,1);
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_bg_in,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_bg_bg-non_bg_bg;
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(distances==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(distances==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(diff,2)
    k=-st;
    for j=1:floor((size(ddd,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_diff(j,jj)=mean(ddd(j+k:j+k+st,jj),1);
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,2))
ylim([-0.07 0.04])
xlim([0 9])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%%
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\e\correct_and_incorrect_together\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle_diff)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle_diff,1)
    for j=1:size(roi_circle_diff,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(distances==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(distances==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(diff,2)
    k=-st;
    for j=1:floor((size(ddd,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_diff(j,jj)=mean(ddd(j+k:j+k+st,jj),1);
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,2))
ylim([-0.04 0.07])
xlim([0 13])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 13])
ylim([0 0.2])

save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%% 1203f
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\f\correct_and_incorrect_together\pixelwise
load corr_bg_bg

h=zeros(10000,1);
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_bg_in,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_bg_bg-non_bg_bg;
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(distances==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(distances==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(diff,2)
    k=-st;
    for j=1:floor((size(ddd,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_diff(j,jj)=mean(ddd(j+k:j+k+st,jj),1);
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,2))
ylim([-0.07 0.04])
xlim([0 9])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%%
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\f\correct_and_incorrect_together\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle_diff)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle_diff,1)
    for j=1:size(roi_circle_diff,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(distances==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(distances==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(diff,2)
    k=-st;
    for j=1:floor((size(ddd,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_diff(j,jj)=mean(ddd(j+k:j+k+st,jj),1);
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,2))
ylim([-0.04 0.07])
xlim([0 13])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 13])
ylim([0 0.2])

save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%% 0610e
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\e\pixelwise
load corr_bg_bg

h=zeros(10000,1);
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_bg_in,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_bg_bg-non_bg_bg;
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(distances==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(distances==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(diff,2)
    k=-st;
    for j=1:floor((size(ddd,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_diff(j,jj)=mean(ddd(j+k:j+k+st,jj),1);
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,2))
ylim([-0.07 0.04])
xlim([0 9])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%%
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\e\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle_diff)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle_diff,1)
    for j=1:size(roi_circle_diff,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(distances==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(distances==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(diff,2)
    k=-st;
    for j=1:floor((size(ddd,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_diff(j,jj)=mean(ddd(j+k:j+k+st,jj),1);
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,2))
ylim([-0.04 0.07])
xlim([0 13])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 13])
ylim([0 0.2])

save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%% 0610f
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\f\pixelwise
load corr_bg_bg

h=zeros(10000,1);
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_bg_in,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_bg_bg-non_bg_bg;
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(distances==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(distances==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(diff,2)
    k=-st;
    for j=1:floor((size(ddd,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_diff(j,jj)=mean(ddd(j+k:j+k+st,jj),1);
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,2))
ylim([-0.07 0.04])
xlim([0 9])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%%
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\f\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle_diff)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle_diff,1)
    for j=1:size(roi_circle_diff,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(distances==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(distances==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(diff,2)
    k=-st;
    for j=1:floor((size(ddd,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_diff(j,jj)=mean(ddd(j+k:j+k+st,jj),1);
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,2))
ylim([-0.04 0.07])
xlim([0 13])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 13])
ylim([0 0.2])

save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%% 2210d
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\d\pixelwise
load corr_bg_bg

h=zeros(10000,1);
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_bg_in,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_bg_bg-non_bg_bg;
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(distances==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(distances==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(diff,2)
    k=-st;
    for j=1:floor((size(ddd,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_diff(j,jj)=mean(ddd(j+k:j+k+st,jj),1);
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,2))
ylim([-0.07 0.04])
xlim([0 9])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%%
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\d\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle_diff)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle_diff,1)
    for j=1:size(roi_circle_diff,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(distances==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(distances==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(diff,2)
    k=-st;
    for j=1:floor((size(ddd,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_diff(j,jj)=mean(ddd(j+k:j+k+st,jj),1);
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,2))
ylim([-0.04 0.07])
xlim([0 13])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 13])
ylim([0 0.2])

save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec


%% 2210e
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\e\pixelwise
load corr_bg_bg

h=zeros(10000,1);
h(roi_bg_in)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_in,1)
    for j=1:size(roi_bg_in,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_bg_bg-non_bg_bg;
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(distances==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(distances==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(diff,2)
    k=-st;
    for j=1:floor((size(ddd,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_diff(j,jj)=mean(ddd(j+k:j+k+st,jj),1);
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,2))
ylim([-0.07 0.04])
xlim([0 9])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 9])
ylim([0 0.35])

save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%%
clear all
cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\e\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle_diff)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle_diff,1)
    for j=1:size(roi_circle_diff,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
distances=reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1));
[d_sort,dist_ind]=sort(distances);

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(distances==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(distances==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(distances==u(i),j),1);
    end
end

st=50;
for jj=1:size(diff,2)
    k=-st;
    for j=1:floor((size(ddd,1)-st)/st)
        k=k+st;
        us(j)=mean(u(j+k:j+k+st));
        dist_diff(j,jj)=mean(ddd(j+k:j+k+st,jj),1);
        dist_cont(j,jj)=mean(dddc(j+k:j+k+st,jj),1);
        dist_non(j,jj)=mean(dddn(j+k:j+k+st,jj),1);
    end
end
dist_vec=us*0.17;
figure;plot(dist_vec,mean(dist_diff,2))
ylim([-0.04 0.07])
xlim([0 13])
hold on
plot(dist_vec,zeros(1,size(us,2)),'k')
figure;plot(us*0.17,mean(dist_cont,2))
hold on
plot(dist_vec,mean(dist_non,2),'r')
xlim([0 13])
ylim([0 0.2])

save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec

