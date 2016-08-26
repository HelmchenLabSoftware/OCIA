cd D:\intrinsic\20150123\a\Matt_files
load('AUC_map_time_clean.mat')
load('rois_initial_205x205.mat')
d=reshape(AUC_map_time,205*205,180);

GA_AUC_s1=nanmean(d(roi_s1,:),1)';
GA_AUC_s2=nanmean(d(roi_s2,:),1)';
GA_AUC_m1=nanmean(d(roi_m1,:),1)';
GA_AUC_a1=nanmean(d(roi_a1,:),1)';
GA_AUC_alm=nanmean(d(roi_alm,:),1)';
GA_AUC_m2=nanmean(d(roi_m2,:),1)';


cd D:\intrinsic\20150127\b\Matt_files
load('AUC_map_time_clean.mat')
load('rois_initial_205x205.mat')
d=reshape(AUC_map_time,205*205,180);

GA_AUC_s1=cat(2,GA_AUC_s1,nanmean(d(roi_s1,:),1)');
GA_AUC_s2=cat(2,GA_AUC_s2,nanmean(d(roi_s2,:),1)');
GA_AUC_m1=cat(2,GA_AUC_m1,nanmean(d(roi_m1,:),1)');
GA_AUC_a1=cat(2,GA_AUC_a1,nanmean(d(roi_a1,:),1)');
GA_AUC_alm=cat(2,GA_AUC_alm,nanmean(d(roi_alm,:),1)');
GA_AUC_m2=cat(2,GA_AUC_m2,nanmean(d(roi_m2,:),1)');


cd D:\intrinsic\20150127\d\Matt_files
load('AUC_map_time_clean.mat')
load('rois_initial_205x205.mat')
d=reshape(AUC_map_time,205*205,180);

GA_AUC_s1=cat(2,GA_AUC_s1,nanmean(d(roi_s1,:),1)');
GA_AUC_s2=cat(2,GA_AUC_s2,nanmean(d(roi_s2,:),1)');
GA_AUC_m1=cat(2,GA_AUC_m1,nanmean(d(roi_m1,:),1)');
GA_AUC_a1=cat(2,GA_AUC_a1,nanmean(d(roi_a1,:),1)');
GA_AUC_alm=cat(2,GA_AUC_alm,nanmean(d(roi_alm,:),1)');
GA_AUC_m2=cat(2,GA_AUC_m2,nanmean(d(roi_m2,:),1)');


cd D:\intrinsic\20150128\a\Matt_files
load('AUC_map_time_clean.mat')
load('rois_initial_205x205.mat')
d=reshape(AUC_map_time,205*205,180);

GA_AUC_s1=cat(2,GA_AUC_s1,nanmean(d(roi_s1,:),1)');
GA_AUC_s2=cat(2,GA_AUC_s2,nanmean(d(roi_s2,:),1)');
GA_AUC_m1=cat(2,GA_AUC_m1,nanmean(d(roi_m1,:),1)');
GA_AUC_a1=cat(2,GA_AUC_a1,nanmean(d(roi_a1,:),1)');
GA_AUC_alm=cat(2,GA_AUC_alm,nanmean(d(roi_alm,:),1)');
GA_AUC_m2=cat(2,GA_AUC_m2,nanmean(d(roi_m2,:),1)');


cd D:\intrinsic\20150128\e\Matt_files
load('AUC_map_time_clean.mat')
load('rois_initial_205x205.mat')
d=reshape(AUC_map_time,205*205,180);

GA_AUC_s1=cat(2,GA_AUC_s1,nanmean(d(roi_s1,:),1)');
GA_AUC_s2=cat(2,GA_AUC_s2,nanmean(d(roi_s2,:),1)');
GA_AUC_m1=cat(2,GA_AUC_m1,nanmean(d(roi_m1,:),1)');
GA_AUC_a1=cat(2,GA_AUC_a1,nanmean(d(roi_a1,:),1)');
GA_AUC_alm=cat(2,GA_AUC_alm,nanmean(d(roi_alm,:),1)');
GA_AUC_m2=cat(2,GA_AUC_m2,nanmean(d(roi_m2,:),1)');

cd D:\intrinsic\20150129\a\Matt_files
load('AUC_map_time_clean.mat')
load('rois_initial_205x205.mat')
d=reshape(AUC_map_time,205*205,180);

GA_AUC_s1=cat(2,GA_AUC_s1,nanmean(d(roi_s1,:),1)');
GA_AUC_s2=cat(2,GA_AUC_s2,nanmean(d(roi_s2,:),1)');
GA_AUC_m1=cat(2,GA_AUC_m1,nanmean(d(roi_m1,:),1)');
GA_AUC_a1=cat(2,GA_AUC_a1,nanmean(d(roi_a1,:),1)');
GA_AUC_alm=cat(2,GA_AUC_alm,nanmean(d(roi_alm,:),1)');
GA_AUC_m2=cat(2,GA_AUC_m2,nanmean(d(roi_m2,:),1)');

cd D:\intrinsic\20150129\b\Matt_files
load('AUC_map_time_clean.mat')
load('rois_initial_205x205.mat')
d=reshape(AUC_map_time,205*205,180);

GA_AUC_s1=cat(2,GA_AUC_s1,nanmean(d(roi_s1,:),1)');
GA_AUC_s2=cat(2,GA_AUC_s2,nanmean(d(roi_s2,:),1)');
GA_AUC_m1=cat(2,GA_AUC_m1,nanmean(d(roi_m1,:),1)');
GA_AUC_a1=cat(2,GA_AUC_a1,nanmean(d(roi_a1,:),1)');
GA_AUC_alm=cat(2,GA_AUC_alm,nanmean(d(roi_alm,:),1)');
GA_AUC_m2=cat(2,GA_AUC_m2,nanmean(d(roi_m2,:),1)');

% cd D:\intrinsic\20150129\e\Matt_files
% load('AUC_map_time_clean.mat')
% load('rois_initial_205x205.mat')
% d=reshape(AUC_map_time,205*205,180);
% 
% GA_AUC_s1=cat(2,GA_AUC_s1,nanmean(d(roi_s1,:),1)');
% GA_AUC_s2=cat(2,GA_AUC_s2,nanmean(d(roi_s2,:),1)');
% GA_AUC_m1=cat(2,GA_AUC_m1,nanmean(d(roi_m1,:),1)');
% GA_AUC_a1=cat(2,GA_AUC_a1,nanmean(d(roi_a1,:),1)');
% GA_AUC_alm=cat(2,GA_AUC_alm,nanmean(d(roi_alm,:),1)');
% GA_AUC_m2=cat(2,GA_AUC_m2,nanmean(d(roi_m2,:),1)');
% 
% cd D:\intrinsic\20150129\f\Matt_files
% load('AUC_map_time_clean.mat')
% load('rois_initial_205x205.mat')
% d=reshape(AUC_map_time,205*205,180);
% 
% GA_AUC_s1=cat(2,GA_AUC_s1,nanmean(d(roi_s1,:),1)');
% GA_AUC_s2=cat(2,GA_AUC_s2,nanmean(d(roi_s2,:),1)');
% GA_AUC_m1=cat(2,GA_AUC_m1,nanmean(d(roi_m1,:),1)');
% GA_AUC_a1=cat(2,GA_AUC_a1,nanmean(d(roi_a1,:),1)');
% GA_AUC_alm=cat(2,GA_AUC_alm,nanmean(d(roi_alm,:),1)');
% GA_AUC_m2=cat(2,GA_AUC_m2,nanmean(d(roi_m2,:),1)');

cd D:\intrinsic\20150129\g\Matt_files
load('AUC_map_time_clean.mat')
load('rois_initial_205x205.mat')
d=reshape(AUC_map_time,205*205,180);

GA_AUC_s1=cat(2,GA_AUC_s1,nanmean(d(roi_s1,:),1)');
GA_AUC_s2=cat(2,GA_AUC_s2,nanmean(d(roi_s2,:),1)');
GA_AUC_m1=cat(2,GA_AUC_m1,nanmean(d(roi_m1,:),1)');
GA_AUC_a1=cat(2,GA_AUC_a1,nanmean(d(roi_a1,:),1)');
GA_AUC_alm=cat(2,GA_AUC_alm,nanmean(d(roi_alm,:),1)');
GA_AUC_m2=cat(2,GA_AUC_m2,nanmean(d(roi_m2,:),1)');

cd D:\intrinsic\20150130\a\Matt_files
load('AUC_map_time_clean.mat')
load('rois_initial_205x205.mat')
d=reshape(AUC_map_time,205*205,180);

GA_AUC_s1=cat(2,GA_AUC_s1,nanmean(d(roi_s1,:),1)');
GA_AUC_s2=cat(2,GA_AUC_s2,nanmean(d(roi_s2,:),1)');
GA_AUC_m1=cat(2,GA_AUC_m1,nanmean(d(roi_m1,:),1)');
GA_AUC_a1=cat(2,GA_AUC_a1,nanmean(d(roi_a1,:),1)');
GA_AUC_alm=cat(2,GA_AUC_alm,nanmean(d(roi_alm,:),1)');
GA_AUC_m2=cat(2,GA_AUC_m2,nanmean(d(roi_m2,:),1)');


x=(1:180)*0.05-2.7;
figure;errorbar(x,nanmean(GA_AUC_s1,2),nanstd(GA_AUC_s1,0,2)/sqrt(size(GA_AUC_s1,2)),'b')
hold on
errorbar(x,nanmean(GA_AUC_s2,2),nanstd(GA_AUC_s2,0,2)/sqrt(size(GA_AUC_s2,2)),'c')
errorbar(x,nanmean(GA_AUC_m1,2),nanstd(GA_AUC_m1,0,2)/sqrt(size(GA_AUC_m1,2)),'r')
errorbar(x,nanmean(GA_AUC_m2,2),nanstd(GA_AUC_m2,0,2)/sqrt(size(GA_AUC_m2,2)),'k')
errorbar(x,nanmean(GA_AUC_a1,2),nanstd(GA_AUC_a1,0,2)/sqrt(size(GA_AUC_a1,2)),'g')
errorbar(x,nanmean(GA_AUC_alm,2),nanstd(GA_AUC_alm,0,2)/sqrt(size(GA_AUC_alm,2)),'m')
xlim([-2.6 5.5])
plot(x,0.5*ones(1,180),'--k')
