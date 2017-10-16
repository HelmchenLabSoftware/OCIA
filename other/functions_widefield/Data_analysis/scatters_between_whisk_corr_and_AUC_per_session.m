cd D:\intrinsic\20150521\b\Matt_files
load('whisk_map_1200_clean.mat')
load('AUC_map_time_clean.mat')
load('rois_initial_205x205.mat')

d=reshape(AUC_map_time,205*205,180);
figure;scatter(nanmean(d(roi_m2,98:134),2),nanmean(whisk_map_1200_clean(roi_m2,:),2),'k')
hold on
axis square
scatter(nanmean(d(roi_s1,98:134),2),nanmean(whisk_map_1200_clean(roi_s1,:),2),'b')
scatter(nanmean(d(roi_m1,98:134),2),nanmean(whisk_map_1200_clean(roi_m1,:),2),'r')
%scatter(nanmean(d(roi_s2,98:134),2),nanmean(whisk_map_1200_clean(roi_s2,:),2),'c')



