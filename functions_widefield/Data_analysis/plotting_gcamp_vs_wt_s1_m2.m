cd D:\intrinsic\20151208\a\Matt_files
load('cond_100_ave.mat')
load('cond_1200_ave.mat')
load('rois_s1_m2.mat')

x=(1:size(cond_100_ave,3))*0.05-3.05;
d_wt1=reshape(cond_100_ave,256*256,size(cond_100_ave,3));
figure;plot(x,smooth(squeeze(nanmean(d_wt1(roi_s1,:),1))-1,1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d_wt1(roi_m2,:),1))-1,1,'Gauss'),'k')
%plot(x,smooth(squeeze(nanmean(d(roi_ppc,:),1))-1,1,'Gauss'),'y')
plot(x,zeros(1,size(cond_100_ave,3)),'k')
wt1_s1=squeeze(nanmean(d_wt1(roi_s1,:),1))-1;
wt1_m2=squeeze(nanmean(d_wt1(roi_m2,:),1))-1;

cd D:\intrinsic\20151216\b\Matt_files
load('cond_100_ave.mat')
load('cond_1200_ave.mat')
load('rois_s1_m2.mat')

x=(1:size(cond_100_ave,3))*0.05-3.05;
d_wt2=reshape(cond_100_ave,256*256,size(cond_100_ave,3));
figure;plot(x,smooth(squeeze(nanmean(d_wt2(roi_s1,:),1))-1,1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d_wt2(roi_m2,:),1))-1,1,'Gauss'),'k')
%plot(x,smooth(squeeze(nanmean(d(roi_ppc,:),1))-1,1,'Gauss'),'y')
plot(x,zeros(1,size(cond_100_ave,3)),'k')
wt2_s1=squeeze(nanmean(d_wt2(roi_s1,:),1))-1;
wt2_m2=squeeze(nanmean(d_wt2(roi_m2,:),1))-1;


cd D:\intrinsic\20150520\a\Matt_files
load('cond_100_ave.mat')
load('cond_1200_ave.mat')
load('rois_s1_m2.mat')

x=(1:size(cond_100_ave,3))*0.05-2.7;
d=reshape(cond_100_ave,205*205,size(cond_100_ave,3));
figure;plot(x,smooth(squeeze(nanmean(d(roi_s1,:),1))-1,1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,1,'Gauss'),'k')
plot(x,zeros(1,size(cond_100_ave,3)),'k')
gc1_s1=squeeze(nanmean(d(roi_s1,:),1))-1;
gc1_m2=squeeze(nanmean(d(roi_m2,:),1))-1;


cd D:\intrinsic\20151021\a\Matt_files
load('cond_100_ave.mat')
load('cond_1200_ave.mat')
load('rois_s1_m2.mat')

x=(1:180)*0.05-3.05;
d2=reshape(cond_1200_ave(:,:,1:180),256*256,180);
figure;plot(x,smooth(squeeze(nanmean(d2(roi_s1,:),1))-1,1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_m2,:),1))-1,1,'Gauss'),'k')
plot(x,zeros(1,180),'k')
gc2_s1=squeeze(nanmean(d2(roi_s1,:),1))-1;
gc2_m2=squeeze(nanmean(d2(roi_m2,:),1))-1;



cd F:\wide_field_data\20150128\b\Matt_files
load('cond_100_ave.mat')
load('cond_1200_ave.mat')
load('rois_s1_m2.mat')

x=(1:size(cond_1200_ave,3))*0.05-2.7;
d3=reshape(cond_100_ave,205*205,size(cond_100_ave,3));
figure;plot(x,smooth(squeeze(nanmean(d3(roi_s1,:),1))-1,1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d3(roi_m2,:),1))-1,1,'Gauss'),'k')
plot(x,zeros(1,size(cond_100_ave,3)),'k')
gc3_s1=squeeze(nanmean(d3(roi_s1,:),1))-1;
gc3_m2=squeeze(nanmean(d3(roi_m2,:),1))-1;

cd F:\wide_field_data\20150128\e\Matt_files
load('cond_100_ave.mat')
d4=reshape(cond_100_ave,205*205,size(cond_100_ave,3));
gc3_m2=squeeze(nanmean(d4(roi_m2,:),1))-1;




x1=(1:size(cond_1200_ave,3))*0.05-2.7;
x2=(1:size(cond_1200_ave,3))*0.05-3.05;
figure;plot(x1,gc1_s1,'b')
hold on
plot(x2,gc2_s1,'b')
plot(x1,gc3_s1,'b')
plot(x2,wt1_s1,'--b')
plot(x2,wt2_s1,'--b')
plot(x,zeros(1,size(cond_100_ave,3)),'k')
xlim([-2.5 6])

figure;plot(x1,gc1_m2,'k')
hold on
plot(x2,gc2_m2,'k')
plot(x1,gc3_m2,'k')
plot(x2,wt1_m2,'--k')
plot(x2,wt2_m2,'--k')
plot(x,zeros(1,size(cond_100_ave,3)),'k')
xlim([-2.5 6])







