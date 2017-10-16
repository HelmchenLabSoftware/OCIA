cd D:\intrinsic\20150123\a\Matt_files
load('cond_100_ave_clean_norm_response.mat')
load('cond_1200_ave_clean_norm_response.mat')
load('rois_initial_205x205.mat')
d=reshape(cond_100_ave,205*205,180);
d2=reshape(cond_1200_ave,205*205,180);

GA_100_del1100_s1=nanmean(d(roi_s1,:),1)';
GA_100_del1100_s2=nanmean(d(roi_s2,:),1)';
GA_100_del1100_m1=nanmean(d(roi_m1,:),1)';
GA_100_del1100_a1=nanmean(d(roi_a1,:),1)';
GA_100_del1100_alm=nanmean(d(roi_alm,:),1)';
GA_100_del1100_m2=nanmean(d(roi_m2,:),1)';

GA_1200_del1100_s1=nanmean(d2(roi_s1,:),1)';
GA_1200_del1100_s2=nanmean(d2(roi_s2,:),1)';
GA_1200_del1100_m1=nanmean(d2(roi_m1,:),1)';
GA_1200_del1100_a1=nanmean(d2(roi_a1,:),1)';
GA_1200_del1100_alm=nanmean(d2(roi_alm,:),1)';
GA_1200_del1100_m2=nanmean(d2(roi_m2,:),1)';


cd D:\intrinsic\20150127\b\Matt_files
load('cond_100_ave_clean_norm_response.mat')
load('cond_1200_ave_clean_norm_response.mat')
load('rois_initial_205x205.mat')
d=reshape(cond_100_ave,205*205,180);
d2=reshape(cond_1200_ave,205*205,180);

GA_100_del1100_s1=cat(2,GA_100_del1100_s1,nanmean(d(roi_s1,:),1)');
GA_100_del1100_s2=cat(2,GA_100_del1100_s2,nanmean(d(roi_s2,:),1)');
GA_100_del1100_m1=cat(2,GA_100_del1100_m1,nanmean(d(roi_m1,:),1)');
GA_100_del1100_a1=cat(2,GA_100_del1100_a1,nanmean(d(roi_a1,:),1)');
GA_100_del1100_alm=cat(2,GA_100_del1100_alm,nanmean(d(roi_alm,:),1)');
GA_100_del1100_m2=cat(2,GA_100_del1100_m2,nanmean(d(roi_m2,:),1)');

GA_1200_del1100_s1=cat(2,GA_1200_del1100_s1,nanmean(d2(roi_s1,:),1)');
GA_1200_del1100_s2=cat(2,GA_1200_del1100_s2,nanmean(d2(roi_s2,:),1)');
GA_1200_del1100_m1=cat(2,GA_1200_del1100_m1,nanmean(d2(roi_m1,:),1)');
GA_1200_del1100_a1=cat(2,GA_1200_del1100_a1,nanmean(d2(roi_a1,:),1)');
GA_1200_del1100_alm=cat(2,GA_1200_del1100_alm,nanmean(d2(roi_alm,:),1)');
GA_1200_del1100_m2=cat(2,GA_1200_del1100_m2,nanmean(d2(roi_m2,:),1)');

cd D:\intrinsic\20150127\d\Matt_files
load('cond_100_ave_clean_norm_response.mat')
load('cond_1200_ave_clean_norm_response.mat')
load('rois_initial_205x205.mat')
d=reshape(cond_100_ave,205*205,180);
d2=reshape(cond_1200_ave,205*205,180);

GA_100_del1100_s1=cat(2,GA_100_del1100_s1,nanmean(d(roi_s1,:),1)');
GA_100_del1100_s2=cat(2,GA_100_del1100_s2,nanmean(d(roi_s2,:),1)');
GA_100_del1100_m1=cat(2,GA_100_del1100_m1,nanmean(d(roi_m1,:),1)');
GA_100_del1100_a1=cat(2,GA_100_del1100_a1,nanmean(d(roi_a1,:),1)');
GA_100_del1100_alm=cat(2,GA_100_del1100_alm,nanmean(d(roi_alm,:),1)');
GA_100_del1100_m2=cat(2,GA_100_del1100_m2,nanmean(d(roi_m2,:),1)');

GA_1200_del1100_s1=cat(2,GA_1200_del1100_s1,nanmean(d2(roi_s1,:),1)');
GA_1200_del1100_s2=cat(2,GA_1200_del1100_s2,nanmean(d2(roi_s2,:),1)');
GA_1200_del1100_m1=cat(2,GA_1200_del1100_m1,nanmean(d2(roi_m1,:),1)');
GA_1200_del1100_a1=cat(2,GA_1200_del1100_a1,nanmean(d2(roi_a1,:),1)');
GA_1200_del1100_alm=cat(2,GA_1200_del1100_alm,nanmean(d2(roi_alm,:),1)');
GA_1200_del1100_m2=cat(2,GA_1200_del1100_m2,nanmean(d2(roi_m2,:),1)');


cd D:\intrinsic\20150128\a\Matt_files
load('cond_100_ave_clean_norm_response.mat')
load('cond_1200_ave_clean_norm_response.mat')
load('rois_initial_205x205.mat')
d=reshape(cond_100_ave,205*205,180);
d2=reshape(cond_1200_ave,205*205,180);

GA_100_del1100_s1=cat(2,GA_100_del1100_s1,nanmean(d(roi_s1,:),1)');
GA_100_del1100_s2=cat(2,GA_100_del1100_s2,nanmean(d(roi_s2,:),1)');
GA_100_del1100_m1=cat(2,GA_100_del1100_m1,nanmean(d(roi_m1,:),1)');
GA_100_del1100_a1=cat(2,GA_100_del1100_a1,nanmean(d(roi_a1,:),1)');
GA_100_del1100_alm=cat(2,GA_100_del1100_alm,nanmean(d(roi_alm,:),1)');
GA_100_del1100_m2=cat(2,GA_100_del1100_m2,nanmean(d(roi_m2,:),1)');

GA_1200_del1100_s1=cat(2,GA_1200_del1100_s1,nanmean(d2(roi_s1,:),1)');
GA_1200_del1100_s2=cat(2,GA_1200_del1100_s2,nanmean(d2(roi_s2,:),1)');
GA_1200_del1100_m1=cat(2,GA_1200_del1100_m1,nanmean(d2(roi_m1,:),1)');
GA_1200_del1100_a1=cat(2,GA_1200_del1100_a1,nanmean(d2(roi_a1,:),1)');
GA_1200_del1100_alm=cat(2,GA_1200_del1100_alm,nanmean(d2(roi_alm,:),1)');
GA_1200_del1100_m2=cat(2,GA_1200_del1100_m2,nanmean(d2(roi_m2,:),1)');


cd D:\intrinsic\20150128\e\Matt_files
load('cond_100_ave_clean_norm_response.mat')
load('cond_1200_ave_clean_norm_response.mat')
load('rois_initial_205x205.mat')
d=reshape(cond_100_ave,205*205,180);
d2=reshape(cond_1200_ave,205*205,180);

GA_100_del1100_s1=cat(2,GA_100_del1100_s1,nanmean(d(roi_s1,:),1)');
GA_100_del1100_s2=cat(2,GA_100_del1100_s2,nanmean(d(roi_s2,:),1)');
GA_100_del1100_m1=cat(2,GA_100_del1100_m1,nanmean(d(roi_m1,:),1)');
GA_100_del1100_a1=cat(2,GA_100_del1100_a1,nanmean(d(roi_a1,:),1)');
GA_100_del1100_alm=cat(2,GA_100_del1100_alm,nanmean(d(roi_alm,:),1)');
GA_100_del1100_m2=cat(2,GA_100_del1100_m2,nanmean(d(roi_m2,:),1)');

GA_1200_del1100_s1=cat(2,GA_1200_del1100_s1,nanmean(d2(roi_s1,:),1)');
GA_1200_del1100_s2=cat(2,GA_1200_del1100_s2,nanmean(d2(roi_s2,:),1)');
GA_1200_del1100_m1=cat(2,GA_1200_del1100_m1,nanmean(d2(roi_m1,:),1)');
GA_1200_del1100_a1=cat(2,GA_1200_del1100_a1,nanmean(d2(roi_a1,:),1)');
GA_1200_del1100_alm=cat(2,GA_1200_del1100_alm,nanmean(d2(roi_alm,:),1)');
GA_1200_del1100_m2=cat(2,GA_1200_del1100_m2,nanmean(d2(roi_m2,:),1)');

cd D:\intrinsic\20150129\a\Matt_files
load('cond_100_ave_clean_norm_response.mat')
load('cond_1200_ave_clean_norm_response.mat')
load('rois_initial_205x205.mat')
d=reshape(cond_100_ave,205*205,180);
d2=reshape(cond_1200_ave,205*205,180);

GA_100_del1100_s1=cat(2,GA_100_del1100_s1,nanmean(d(roi_s1,:),1)');
GA_100_del1100_s2=cat(2,GA_100_del1100_s2,nanmean(d(roi_s2,:),1)');
GA_100_del1100_m1=cat(2,GA_100_del1100_m1,nanmean(d(roi_m1,:),1)');
GA_100_del1100_a1=cat(2,GA_100_del1100_a1,nanmean(d(roi_a1,:),1)');
GA_100_del1100_alm=cat(2,GA_100_del1100_alm,nanmean(d(roi_alm,:),1)');
GA_100_del1100_m2=cat(2,GA_100_del1100_m2,nanmean(d(roi_m2,:),1)');

GA_1200_del1100_s1=cat(2,GA_1200_del1100_s1,nanmean(d2(roi_s1,:),1)');
GA_1200_del1100_s2=cat(2,GA_1200_del1100_s2,nanmean(d2(roi_s2,:),1)');
GA_1200_del1100_m1=cat(2,GA_1200_del1100_m1,nanmean(d2(roi_m1,:),1)');
GA_1200_del1100_a1=cat(2,GA_1200_del1100_a1,nanmean(d2(roi_a1,:),1)');
GA_1200_del1100_alm=cat(2,GA_1200_del1100_alm,nanmean(d2(roi_alm,:),1)');
GA_1200_del1100_m2=cat(2,GA_1200_del1100_m2,nanmean(d2(roi_m2,:),1)');

cd D:\intrinsic\20150129\b\Matt_files
load('cond_100_ave_clean_norm_response.mat')
load('cond_1200_ave_clean_norm_response.mat')
load('rois_initial_205x205.mat')
d=reshape(cond_100_ave,205*205,180);
d2=reshape(cond_1200_ave,205*205,180);

GA_100_del1100_s1=cat(2,GA_100_del1100_s1,nanmean(d(roi_s1,:),1)');
GA_100_del1100_s2=cat(2,GA_100_del1100_s2,nanmean(d(roi_s2,:),1)');
GA_100_del1100_m1=cat(2,GA_100_del1100_m1,nanmean(d(roi_m1,:),1)');
GA_100_del1100_a1=cat(2,GA_100_del1100_a1,nanmean(d(roi_a1,:),1)');
GA_100_del1100_alm=cat(2,GA_100_del1100_alm,nanmean(d(roi_alm,:),1)');
GA_100_del1100_m2=cat(2,GA_100_del1100_m2,nanmean(d(roi_m2,:),1)');

GA_1200_del1100_s1=cat(2,GA_1200_del1100_s1,nanmean(d2(roi_s1,:),1)');
GA_1200_del1100_s2=cat(2,GA_1200_del1100_s2,nanmean(d2(roi_s2,:),1)');
GA_1200_del1100_m1=cat(2,GA_1200_del1100_m1,nanmean(d2(roi_m1,:),1)');
GA_1200_del1100_a1=cat(2,GA_1200_del1100_a1,nanmean(d2(roi_a1,:),1)');
GA_1200_del1100_alm=cat(2,GA_1200_del1100_alm,nanmean(d2(roi_alm,:),1)');
GA_1200_del1100_m2=cat(2,GA_1200_del1100_m2,nanmean(d2(roi_m2,:),1)');

% cd D:\intrinsic\20150129\e\Matt_files
% load('cond_100_ave_clean_norm_response.mat')
% load('cond_1200_ave_clean_norm_response.mat')
% load('rois_initial_205x205.mat')
% d=reshape(cond_100_ave,205*205,180);
% d2=reshape(cond_1200_ave,205*205,180);
% 
% GA_100_del1100_s1=cat(2,GA_100_del1100_s1,nanmean(d(roi_s1,:),1)');
% GA_100_del1100_s2=cat(2,GA_100_del1100_s2,nanmean(d(roi_s2,:),1)');
% GA_100_del1100_m1=cat(2,GA_100_del1100_m1,nanmean(d(roi_m1,:),1)');
% GA_100_del1100_a1=cat(2,GA_100_del1100_a1,nanmean(d(roi_a1,:),1)');
% GA_100_del1100_alm=cat(2,GA_100_del1100_alm,nanmean(d(roi_alm,:),1)');
% GA_100_del1100_m2=cat(2,GA_100_del1100_m2,nanmean(d(roi_m2,:),1)');
% 
% GA_1200_del1100_s1=cat(2,GA_1200_del1100_s1,nanmean(d2(roi_s1,:),1)');
% GA_1200_del1100_s2=cat(2,GA_1200_del1100_s2,nanmean(d2(roi_s2,:),1)');
% GA_1200_del1100_m1=cat(2,GA_1200_del1100_m1,nanmean(d2(roi_m1,:),1)');
% GA_1200_del1100_a1=cat(2,GA_1200_del1100_a1,nanmean(d2(roi_a1,:),1)');
% GA_1200_del1100_alm=cat(2,GA_1200_del1100_alm,nanmean(d2(roi_alm,:),1)');
% GA_1200_del1100_m2=cat(2,GA_1200_del1100_m2,nanmean(d2(roi_m2,:),1)');
% 
% cd D:\intrinsic\20150129\f\Matt_files
% load('cond_100_ave_clean_norm_response.mat')
% load('cond_1200_ave_clean_norm_response.mat')
% load('rois_initial_205x205.mat')
% d=reshape(cond_100_ave,205*205,180);
% d2=reshape(cond_1200_ave,205*205,180);
% 
% GA_100_del1100_s1=cat(2,GA_100_del1100_s1,nanmean(d(roi_s1,:),1)');
% GA_100_del1100_s2=cat(2,GA_100_del1100_s2,nanmean(d(roi_s2,:),1)');
% GA_100_del1100_m1=cat(2,GA_100_del1100_m1,nanmean(d(roi_m1,:),1)');
% GA_100_del1100_a1=cat(2,GA_100_del1100_a1,nanmean(d(roi_a1,:),1)');
% GA_100_del1100_alm=cat(2,GA_100_del1100_alm,nanmean(d(roi_alm,:),1)');
% GA_100_del1100_m2=cat(2,GA_100_del1100_m2,nanmean(d(roi_m2,:),1)');
% 
% GA_1200_del1100_s1=cat(2,GA_1200_del1100_s1,nanmean(d2(roi_s1,:),1)');
% GA_1200_del1100_s2=cat(2,GA_1200_del1100_s2,nanmean(d2(roi_s2,:),1)');
% GA_1200_del1100_m1=cat(2,GA_1200_del1100_m1,nanmean(d2(roi_m1,:),1)');
% GA_1200_del1100_a1=cat(2,GA_1200_del1100_a1,nanmean(d2(roi_a1,:),1)');
% GA_1200_del1100_alm=cat(2,GA_1200_del1100_alm,nanmean(d2(roi_alm,:),1)');
% GA_1200_del1100_m2=cat(2,GA_1200_del1100_m2,nanmean(d2(roi_m2,:),1)');

cd D:\intrinsic\20150129\g\Matt_files
load('cond_100_ave_clean_norm_response.mat')
load('cond_1200_ave_clean_norm_response.mat')
load('rois_initial_205x205.mat')
d=reshape(cond_100_ave,205*205,180);
d2=reshape(cond_1200_ave,205*205,180);

GA_100_del1100_s1=cat(2,GA_100_del1100_s1,nanmean(d(roi_s1,:),1)');
GA_100_del1100_s2=cat(2,GA_100_del1100_s2,nanmean(d(roi_s2,:),1)');
GA_100_del1100_m1=cat(2,GA_100_del1100_m1,nanmean(d(roi_m1,:),1)');
GA_100_del1100_a1=cat(2,GA_100_del1100_a1,nanmean(d(roi_a1,:),1)');
GA_100_del1100_alm=cat(2,GA_100_del1100_alm,nanmean(d(roi_alm,:),1)');
GA_100_del1100_m2=cat(2,GA_100_del1100_m2,nanmean(d(roi_m2,:),1)');

GA_1200_del1100_s1=cat(2,GA_1200_del1100_s1,nanmean(d2(roi_s1,:),1)');
GA_1200_del1100_s2=cat(2,GA_1200_del1100_s2,nanmean(d2(roi_s2,:),1)');
GA_1200_del1100_m1=cat(2,GA_1200_del1100_m1,nanmean(d2(roi_m1,:),1)');
GA_1200_del1100_a1=cat(2,GA_1200_del1100_a1,nanmean(d2(roi_a1,:),1)');
GA_1200_del1100_alm=cat(2,GA_1200_del1100_alm,nanmean(d2(roi_alm,:),1)');
GA_1200_del1100_m2=cat(2,GA_1200_del1100_m2,nanmean(d2(roi_m2,:),1)');

cd D:\intrinsic\20150130\a\Matt_files
load('cond_100_ave_clean_norm_response.mat')
load('cond_1200_ave_clean_norm_response.mat')
load('rois_initial_205x205.mat')
d=reshape(cond_100_ave,205*205,180);
d2=reshape(cond_1200_ave,205*205,180);

GA_100_del1100_s1=cat(2,GA_100_del1100_s1,nanmean(d(roi_s1,:),1)');
GA_100_del1100_s2=cat(2,GA_100_del1100_s2,nanmean(d(roi_s2,:),1)');
GA_100_del1100_m1=cat(2,GA_100_del1100_m1,nanmean(d(roi_m1,:),1)');
GA_100_del1100_a1=cat(2,GA_100_del1100_a1,nanmean(d(roi_a1,:),1)');
GA_100_del1100_alm=cat(2,GA_100_del1100_alm,nanmean(d(roi_alm,:),1)');
GA_100_del1100_m2=cat(2,GA_100_del1100_m2,nanmean(d(roi_m2,:),1)');

GA_1200_del1100_s1=cat(2,GA_1200_del1100_s1,nanmean(d2(roi_s1,:),1)');
GA_1200_del1100_s2=cat(2,GA_1200_del1100_s2,nanmean(d2(roi_s2,:),1)');
GA_1200_del1100_m1=cat(2,GA_1200_del1100_m1,nanmean(d2(roi_m1,:),1)');
GA_1200_del1100_a1=cat(2,GA_1200_del1100_a1,nanmean(d2(roi_a1,:),1)');
GA_1200_del1100_alm=cat(2,GA_1200_del1100_alm,nanmean(d2(roi_alm,:),1)');
GA_1200_del1100_m2=cat(2,GA_1200_del1100_m2,nanmean(d2(roi_m2,:),1)');



x=(1:180)*0.05-2.6;

time=113:148;
diff_s1=GA_100_del1100_s1-GA_1200_del1100_s1;
diff_s2=GA_100_del1100_s2-GA_1200_del1100_s2;
diff_m1=GA_100_del1100_m1-GA_1200_del1100_m1;
diff_m2=GA_100_del1100_m2-GA_1200_del1100_m2;
diff_a1=GA_100_del1100_a1-GA_1200_del1100_a1;
diff_alm=GA_100_del1100_alm-GA_1200_del1100_alm;
figure;errorbar(x(time),nanmean(diff_m2(time,:),2),nanstd(diff_m2(time,:),0,2)/sqrt(size(diff_m2,2)),'k')
hold on
errorbar(x(time),nanmean(diff_alm(time,:),2),nanstd(diff_alm(time,:),0,2)/sqrt(size(diff_alm,2)),'m')
errorbar(x(time),nanmean(diff_a1(time,:),2),nanstd(diff_a1(time,:),0,2)/sqrt(size(diff_a1,2)),'g')
legend('m2','alm','a1')
plot(x(time),zeros(1,size(time,2)),'k')


figure;errorbar(x(time),nanmean(GA_100_del1100_a1(time,:),2)-1,nanstd(GA_100_del1100_a1(time,:),0,2)/sqrt(size(GA_100_del1100_a1,2)),'g')
hold on
errorbar(x(time),nanmean(GA_1200_del1100_a1(time,:),2)-1,nanstd(GA_1200_del1100_a1(time,:),0,2)/sqrt(size(GA_1200_del1100_a1,2)),'--k')
plot(x(time),zeros(1,size(time,2)),'k')

figure;errorbar(x(time),nanmean(GA_100_del1100_m2(time,:),2)-1,nanstd(GA_100_del1100_m2(time,:),0,2)/sqrt(size(GA_100_del1100_m2,2)),'k')
hold on
errorbar(x(time),nanmean(GA_1200_del1100_m2(time,:),2)-1,nanstd(GA_1200_del1100_m2(time,:),0,2)/sqrt(size(GA_1200_del1100_m2,2)),'--k')
plot(x(time),zeros(1,size(time,2)),'k')

figure;errorbar(x(time),nanmean(GA_100_del1100_alm(time,:),2)-1,nanstd(GA_100_del1100_alm(time,:),0,2)/sqrt(size(GA_100_del1100_alm,2)),'m')
hold on
errorbar(x(time),nanmean(GA_1200_del1100_alm(time,:),2)-1,nanstd(GA_1200_del1100_alm(time,:),0,2)/sqrt(size(GA_1200_del1100_alm,2)),'--k')
plot(x(time),zeros(1,size(time,2)),'k')



time=128:143;
figure;bar([nanmean(nanmean(diff_a1(time,:),1)) nanmean(nanmean(diff_m2(time,:),1)) nanmean(nanmean(diff_alm(time,:),1))])
hold on
errorbar([nanmean(nanmean(diff_a1(time,:),1)) nanmean(nanmean(diff_m2(time,:),1)) nanmean(nanmean(diff_alm(time,:),1))],[nanstd(nanmean(diff_a1(time,:),1)) nanstd(nanmean(diff_m2(time,:),1)) nanstd(nanmean(diff_alm(time,:),1))]/sqrt(size(diff_s1,2)))
signrank(nanmean(diff_a1(time,:),1))
signrank(nanmean(diff_m2(time,:),1))
signrank(nanmean(diff_alm(time,:),1))

