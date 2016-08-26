cd D:\intrinsic\20150520\a\Matt_files
load('cond_100_ave.mat')
load('cond_1200_ave.mat')
load('rois_s1_m2.mat')

x=(1:size(cond_100_ave,3))*0.05-2.7;
d=reshape(cond_100_ave,205*205,size(cond_100_ave,3));
d2=reshape(cond_1200_ave,205*205,size(cond_100_ave,3));
figure;plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,3,'Gauss'),'k')
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_m2,:),1))-1,3,'Gauss'),'--k')
plot(x,zeros(1,180),'k')
xlim([-2.5 6.25])



cd D:\intrinsic\20151021\a\Matt_files
load('cond_100_ave.mat')
load('cond_1200_ave.mat')
load('rois_s1_m2.mat')

x=(1:size(cond_100_ave,3))*0.05-2.7;
d=reshape(cond_100_ave,256*256,size(cond_100_ave,3));
d2=reshape(cond_1200_ave,256*256,size(cond_100_ave,3));
figure;plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,3,'Gauss'),'k')
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_m2,:),1))-1,3,'Gauss'),'--k')
plot(x,zeros(1,200),'k')
xlim([-2.5 6.25])

