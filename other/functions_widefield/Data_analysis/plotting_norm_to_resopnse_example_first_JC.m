cd D:\intrinsic\20150128\e\Matt_files
load rois_initial_205x205
x=(1:180)*0.05-2.6;

load cond_100_ave_clean
load cond_1200_ave_clean
figure;plot(x,smooth(squeeze(nanmean(cond_100_ave(roi_a1,:,:),1))-1,1,'Gauss'),'g')
hold on
plot(x,smooth(squeeze(nanmean(cond_1200_ave(roi_a1,:,:),1))-1,1,'Gauss'),'--g')
plot(x,zeros(1,180),'k')
xlim([-2.6 5.5])
figure;plot(x,smooth(squeeze(nanmean(cond_100_ave(roi_m2,:,:),1))-1,1,'Gauss'),'k')
hold on
plot(x,smooth(squeeze(nanmean(cond_1200_ave(roi_m2,:,:),1))-1,1,'Gauss'),'--k')
plot(x,zeros(1,180),'k')
xlim([-2.6 5.5])


load cond_100_ave_clean_norm_response
load cond_1200_ave_clean_norm_response
figure;plot(x,smooth(squeeze(nanmean(cond_100_ave(roi_a1,:,:),1))-1,1,'Gauss'),'g')
hold on
plot(x,smooth(squeeze(nanmean(cond_1200_ave(roi_a1,:,:),1))-1,1,'Gauss'),'--g')
plot(x,zeros(1,180),'k')
xlim([-2.6 5.5])
figure;plot(x,smooth(squeeze(nanmean(cond_100_ave(roi_m2,:,:),1))-1,1,'Gauss'),'k')
hold on
plot(x,smooth(squeeze(nanmean(cond_1200_ave(roi_m2,:,:),1))-1,1,'Gauss'),'--k')
plot(x,zeros(1,180),'k')
xlim([-2.6 5.5])