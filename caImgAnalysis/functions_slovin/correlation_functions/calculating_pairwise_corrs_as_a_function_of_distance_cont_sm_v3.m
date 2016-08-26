%% 1711b
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\b\pixelwise
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
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])

save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec


%%
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\b\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])


save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%% 1711c
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\c\pixelwise
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
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])


save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%%
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\c\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])


save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec






%% 1711g
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\g\pixelwise
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
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])

save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%%
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\17Nov2010\g\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])


save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec






%% 2411b
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\b\pixelwise
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
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])


save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%%
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\b\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])


save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec





%% 2411d
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\d\pixelwise
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
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])


save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%%
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\d\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])


save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec





%% 2411f
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\f\pixelwise
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
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])


save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%%
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\24Nov2010\f\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])


save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec




%% 1412b
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\b\pixelwise
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
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])


save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%%
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\b\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])


save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec




%% 1412c
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\c\pixelwise
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
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])


save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%%
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\c\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])

save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec


%% 1412d
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\d\pixelwise
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
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])


save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%%
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\d\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])


save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%% 1412e
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\e\pixelwise
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
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])


save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%%
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\14Dec2010\e\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])

save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%% 2212b
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\b\pixelwise
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
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])

save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%%
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\b\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])


save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%% 2212c
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\c\pixelwise
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
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])


save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%%
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\c\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])


save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec

%% 2212d
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\d\pixelwise
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
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])


save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%%
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\22Dec2010\d\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])

save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%% 2912b
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\b\pixelwise
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
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])


save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%%
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\b\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])


save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%% 2912d
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\d\pixelwise
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
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])


save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%%
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\d\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])


save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec


%% 0501e
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\e\pixelwise
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
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])


save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%%
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\e\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])


save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec


%% 2912c
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\c\pixelwise
load corr_bg_bg

h=zeros(10000,1);
h(roi_bg_out)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_out,1)
    for j=1:size(roi_bg_out,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_bg_bg-non_bg_bg;
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])


save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%%
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\c\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])


save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%% 2912e
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\e\pixelwise
load corr_bg_bg

h=zeros(10000,1);
h(roi_bg_out)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_out,1)
    for j=1:size(roi_bg_out,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_bg_bg-non_bg_bg;
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])

save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%%
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\e\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])


save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%% 2912k
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\k\pixelwise
load corr_bg_bg

h=zeros(10000,1);
h(roi_bg_out)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_out,1)
    for j=1:size(roi_bg_out,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_bg_bg-non_bg_bg;
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])

save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%%
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\29Dec2010\k\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])


save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%% 0501b
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\b\pixelwise
load corr_bg_bg

h=zeros(10000,1);
h(roi_bg_out)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_out,1)
    for j=1:size(roi_bg_out,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_bg_bg-non_bg_bg;
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])


save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%%
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\b\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])


save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec




%% 0501c
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\c\pixelwise
load corr_bg_bg

h=zeros(10000,1);
h(roi_bg_out)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_out,1)
    for j=1:size(roi_bg_out,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_bg_bg-non_bg_bg;
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])

save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%%
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\c\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])

save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec




%% 0501d
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\d\pixelwise
load corr_bg_bg

h=zeros(10000,1);
h(roi_bg_out)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_bg_out,1)
    for j=1:size(roi_bg_out,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_bg_bg-non_bg_bg;
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_bg_bg(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_bg_bg(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])


save corr_bg_bg_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec



%%
clear all
cd F:\Data\VSDI\Contour_integration\Smeagol\05Jan2011\d\pixelwise
load corr_circ_circ

h=zeros(10000,1);
h(roi_circle)=1;
m=reshape(h,100,100);
[r c]=find(m);
for i=1:size(roi_circle,1)
    for j=1:size(roi_circle,1)
       dist_mat(i,j)=sqrt((r(i)-r(j))^2+(c(i)-c(j))^2);
    end
end
diff=cont_circ_circ-non_circ_circ;
[d_sort,dist_ind]=sort(reshape(dist_mat,1,size(dist_mat,1)*size(dist_mat,1)));

u=unique(d_sort);
for i=1:size(u,2)
    for j=1:size(diff,2)
        ddd(i,j)=mean(diff(d_sort==u(i),j),1);
    end
end

for i=1:size(u,2)
    for j=1:size(diff,2)
        dddc(i,j)=mean(cont_circ_circ(d_sort==u(i),j),1);
        dddn(i,j)=mean(non_circ_circ(d_sort==u(i),j),1);
    end
end

dist_vec=0:0.5/0.17:floor(max(u));
kkk=0;
for i=2:size(dist_vec,2)
    kkk=kkk+1;
    for j=1:size(diff,2)
        ttt=find((dist_vec(i-1)<u)&(u<=dist_vec(i)));
        dist_cont(kkk,j)=mean(dddc(ttt,j),1);
        dist_non(kkk,j)=mean(dddn(ttt,j),1);
        dist_diff(kkk,j)=mean(ddd(ttt,j),1);
    end
end
figure;plot(dist_vec(2:end)*0.17,mean(dist_cont,2));
hold on
plot(dist_vec(2:end)*0.17,mean(dist_non,2),'r');
xlim([0 8])
figure;plot(dist_vec(2:end)*0.17,mean(dist_diff,2));
xlim([0 8])


save corr_circ_circ_as_a_function_of_distance dist_diff dist_cont dist_non dist_vec
















