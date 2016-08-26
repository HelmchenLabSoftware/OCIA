cd D:\intrinsic\20150127\d\Matt_files
load('cond_100_ave_clean.mat')
load('cond_1200_ave_clean.mat')
cond_100_ave=reshape(cond_100_ave,205,205,180);
cond_1200_ave=reshape(cond_1200_ave,205,205,180);
load rois_initial_205x205

x=(1:180)*0.05-2.7;
d=reshape(cond_100_ave,205*205,180);
figure;plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,1,'Gauss'),'k')
hold on
plot(x,smooth(squeeze(nanmean(d(roi_alm,:),1))-1,1,'Gauss'),'m')
plot(x,zeros(1,180),'k')
xlim([-2.6 6])
ylim([-0.01 0.06])

cd D:\intrinsic\20150128\c\Matt_files
load('cond_100_ave_clean.mat')
load('cond_1200_ave_clean.mat')
cond_100_ave=reshape(cond_100_ave,205,205,180);
cond_1200_ave=reshape(cond_1200_ave,205,205,180);
load rois_initial_205x205

x=(1:180)*0.05-2.7;
d=reshape(cond_100_ave,205*205,180);
figure;plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,1,'Gauss'),'k')
hold on
plot(x,smooth(squeeze(nanmean(d(roi_alm,:),1))-1,1,'Gauss'),'m')
plot(x,zeros(1,180),'k')
xlim([-2.6 6])
ylim([-0.01 0.06])

