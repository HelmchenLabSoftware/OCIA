
cd D:\intrinsic\20150520\a\Matt_files
load('whisk_map_100.mat')
load('whisk_map_1200.mat')
load rois_initial_205x205
h=zeros(205*205,1);
h(roi_s1)=1;
h(roi_s2)=1;
h(roi_m1)=1;
h(roi_m2)=1;
h(roi_a1)=1;
h(roi_alm)=1;

for i=[6 12]
    figure;imagesc(smoothn(nanmean(reshape(whisk_map_100(:,i),[205,205]),3),[5 5],'Gauss'),[-.5 .8]);colormap(mapgeog)
    hold on
    contour(reshape(h,205,205),'k')
end


for i=[4 24]
    figure;imagesc(smoothn(nanmean(reshape(whisk_map_1200(:,i),[205,205]),3),[5 5],'Gauss'),[-.5 .8]);colormap(mapgeog)
    hold on
    contour(reshape(h,205,205),'k')
end


