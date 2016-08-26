cd D:\intrinsic\20150520\a\Matt_files
load('whisk_map_100_clean.mat')
load('whisk_map_1200_clean.mat')
whisk_map_ave=cat(2,nanmean(whisk_map_100_clean,2),nanmean(whisk_map_1200_clean,2));

cd D:\intrinsic\20150520\b\Matt_files
load('whisk_map_100_clean.mat')
load('whisk_map_1200_clean.mat')
whisk_map_ave=cat(2,whisk_map_ave,nanmean(whisk_map_100_clean,2),nanmean(whisk_map_1200_clean,2));

cd D:\intrinsic\20150520\c\Matt_files
load('whisk_map_100_clean.mat')
load('whisk_map_1200_clean.mat')
whisk_map_ave=cat(2,whisk_map_ave,nanmean(whisk_map_100_clean,2),nanmean(whisk_map_1200_clean,2));

cd D:\intrinsic\20150520\d\Matt_files
load('whisk_map_100_clean.mat')
load('whisk_map_1200_clean.mat')
whisk_map_ave=cat(2,whisk_map_ave,nanmean(whisk_map_100_clean,2),nanmean(whisk_map_1200_clean,2));

load rois_initial_205x205
h=zeros(205*205,1);
h(roi_s1)=1;
h(roi_s2)=1;
h(roi_m1)=1;
h(roi_m2)=1;
h(roi_a1)=1;
h(roi_alm)=1;
figure;imagesc(smoothn(reshape(nanmean(whisk_map_ave(:,[2 4 6 8]),2),[205,205]),[5 5],'Gauss'),[.1 .3]);colormap(mapgeog)
hold on
contour(reshape(h,205,205),'k')




