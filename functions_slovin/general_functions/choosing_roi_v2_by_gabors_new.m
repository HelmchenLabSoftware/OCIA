

load visual_areas

con=5;
t=mean(condz(:,34,con)./condz(:,34,6),2);

figure(100);
mimg(mfilt2(t-1,100,100,1,'lm'),100,100,-.1e-3,1.2e-3);colormap(mapgeog)
roi = choose_polygon(100);

h1=zeros(10000,1);
h2=zeros(10000,1);
%h1(v2)=1;
h2(roi)=1;
h=h1+h2;
figure;mimg(h,100,100,0,3);colormap(mapgeog)

roi=find(h==1);



n=(std(condz(:,2:28,con)./condz(:,2:28,6),0,2)).^2;
SNR_V2=(t-mean(condz(:,10:25,con)./condz(:,10:25,6),2)).^2./n;
SNR_V2(isnan(SNR_V2))=0;
thresh=35; %in std

roi_V2=roi(find(SNR_V2(roi)>=thresh));   %define new ROI for V2



figure;
c=zeros(10000,1);
%c(roi_V2_circ_middle)=10;
%c(roi_V2_circ_right)=20;
%c(roi_V2_bg_right)=20;
%c(roi_V2_bg_middle)=20;
%c(roi_V2_bg_left)=20;
%c(roi_V2_circ_left)=20;
c(roi_V2)=20;
mimg(c,100,100,0,20);colormap(mapgeog);



%%

h1=zeros(10000,1);
h2=zeros(10000,1);
h3=zeros(10000,1);
h4=zeros(10000,1);
h5=zeros(10000,1);
h6=zeros(10000,1);

h1(roi_V2_circ_left)=1;
h2(roi_V2_circ_middle)=2;
h3(roi_V2_circ_right)=3;
h=h1+h2+h3;
roi_t=find(h);
figure;mimg(h,100,100,0,3);colormap(mapgeog)

h4(roi_V2_bg_left)=1;
h5(roi_V2_bg_middle)=2;
h6(roi_V2_bg_right)=3;
g=h4+h5+h6;
roi_s=find(g);
figure;mimg(g,100,100,0,3);colormap(mapgeog)


h7=zeros(10000,1);
h8=zeros(10000,1);
h7(roi_t)=1;
h8(roi_s)=2;
v=h7+h8;
roi_V2_circle=find(v==1);
roi_V2_bg=find(v==2);
figure;mimg(v,100,100,0,3);colormap(mapgeog)


h=zeros(10000,1);
h(roi_V2_bg)=1;
h(roi_V2_circle)=2;
figure;mimg(h,100,100,0,2);colormap(mapgeog)














