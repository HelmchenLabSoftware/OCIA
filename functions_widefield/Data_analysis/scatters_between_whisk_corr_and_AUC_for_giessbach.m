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


cd D:\intrinsic\20150520\a\Matt_files
load('AUC_map_time_clean.mat')
load rois_for_giessbach

d=reshape(AUC_map_time,205*205,180);
figure;scatter(nanmean(d(roi_m2,98:134),2),nanmean(whisk_map_ave(roi_m2,[2 4 6 8]),2),'k')
hold on
axis square
scatter(nanmean(d(roi_s1,98:134),2),nanmean(whisk_map_ave(roi_s1,[2 4 6 8]),2),'b')
scatter(nanmean(d(roi_m1,98:134),2),nanmean(whisk_map_ave(roi_m1,[2 4 6 8]),2),'r')


% t=nanmean(d(roi_m2,98:134),2);
% tt=nanmean(whisk_map_ave(roi_m2,[2 4 6 8]),2);
% 
% m2_1=find(t>0.88&tt>0.19);
% m2_2=find(t<0.88&tt>0.19);
% m2_3=find(t<0.88&tt<0.19);
% 
% figure;scatter(nanmean(d(roi_m2,98:134),2),nanmean(whisk_map_ave(roi_m2,[2 4 6 8]),2),'k')
% hold on
% axis square
% scatter(nanmean(d(roi_m2(m2_1),98:134),2),nanmean(whisk_map_ave(roi_m2(m2_1),[2 4 6 8]),2),'r')
% scatter(nanmean(d(roi_m2(m2_2),98:134),2),nanmean(whisk_map_ave(roi_m2(m2_2),[2 4 6 8]),2),'y')
% scatter(nanmean(d(roi_m2(m2_3),98:134),2),nanmean(whisk_map_ave(roi_m2(m2_3),[2 4 6 8]),2),'b')
% 
% g=ones(205*205,1);
% g(roi_m2(m2_1))=0.8;
% g(roi_m2(m2_2))=0.5;
% g(roi_m2(m2_3))=0.2;
% figure;imagesc(fliplr(reshape(g,205,205)'),[0 1]);colormap(mapgeog)
% hold on
% line([139 151],[8 175],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
% axis square
% axis off
% 



