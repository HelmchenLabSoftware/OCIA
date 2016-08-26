


load cond3n_dt_bl
load 1409

sd=mean(std(cond3n_dt_bl(:,40:80,:),0,3),2);

[l i]=sort(sd(roi_V2tar));
roi_V2tar_std=roi_V2tar(i(1:20));


h=zeros(10000,1);
h(roi_V2tar_std)=5;
j=zeros(10000,1);
j(roi_V2_c1)=1;
k=zeros(10000,1);
k(roi_V2_c2)=1;
l=zeros(10000,1);
l(roi_V2_c4)=1;
m=zeros(10000,1);
m(roi_V2_c5)=1;

v=zeros(10000,1);
v=h+j+k+l+m;
figure
mimg(v,100,100,0,9);colormap(mapgeog)

roi_V2comb2=find(v==9);
c=zeros(10000,1);
c(roi_V2comb2)=1;
figure
mimg(c,100,100,0,1);

