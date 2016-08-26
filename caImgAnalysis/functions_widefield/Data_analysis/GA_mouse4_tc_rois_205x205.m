cd C:\20150501\mouse_tgg6fl23_4\c\Matt_files
load('cond_100_ave_clean.mat')
load('cond_1200_ave_clean.mat')
load('rois_initial_205x205.mat')
d=reshape(cond_100_ave,205*205,180);
d2=reshape(cond_1200_ave,205*205,180);

GA_100_del2100_s1=nanmean(d(roi_s1,:),1)';
GA_100_del2100_s2=nanmean(d(roi_s2,:),1)';
GA_100_del2100_m1=nanmean(d(roi_m1,:),1)';
GA_100_del2100_a1=nanmean(d(roi_a1,:),1)';
GA_100_del2100_alm=nanmean(d(roi_alm,:),1)';
GA_100_del2100_m2=nanmean(d(roi_m2,:),1)';
GA_100_del2100_ppc=nanmean(d(roi_ppc,:),1)';

GA_1200_del2100_s1=nanmean(d2(roi_s1,:),1)';
GA_1200_del2100_s2=nanmean(d2(roi_s2,:),1)';
GA_1200_del2100_m1=nanmean(d2(roi_m1,:),1)';
GA_1200_del2100_a1=nanmean(d2(roi_a1,:),1)';
GA_1200_del2100_alm=nanmean(d2(roi_alm,:),1)';
GA_1200_del2100_m2=nanmean(d2(roi_m2,:),1)';
GA_1200_del2100_ppc=nanmean(d2(roi_ppc,:),1)';


cd D:\intrinsic\20150520\mouse_tgg6fl23_4\d\Matt_files
load('cond_100_ave.mat')
load('cond_1200_ave.mat')
load('rois_initial_205x205.mat')
d=reshape(cond_100_ave,205*205,180);
d2=reshape(cond_1200_ave,205*205,180);

GA_100_del2100_s1=cat(2,GA_100_del2100_s1,nanmean(d(roi_s1,:),1)');
GA_100_del2100_s2=cat(2,GA_100_del2100_s2,nanmean(d(roi_s2,:),1)');
GA_100_del2100_m1=cat(2,GA_100_del2100_m1,nanmean(d(roi_m1,:),1)');
GA_100_del2100_a1=cat(2,GA_100_del2100_a1,nanmean(d(roi_a1,:),1)');
GA_100_del2100_alm=cat(2,GA_100_del2100_alm,nanmean(d(roi_alm,:),1)');
GA_100_del2100_m2=cat(2,GA_100_del2100_m2,nanmean(d(roi_m2,:),1)');
GA_100_del2100_ppc=cat(2,GA_100_del2100_ppc,nanmean(d(roi_ppc,:),1)');

GA_1200_del2100_s1=cat(2,GA_1200_del2100_s1,nanmean(d2(roi_s1,:),1)');
GA_1200_del2100_s2=cat(2,GA_1200_del2100_s2,nanmean(d2(roi_s2,:),1)');
GA_1200_del2100_m1=cat(2,GA_1200_del2100_m1,nanmean(d2(roi_m1,:),1)');
GA_1200_del2100_a1=cat(2,GA_1200_del2100_a1,nanmean(d2(roi_a1,:),1)');
GA_1200_del2100_alm=cat(2,GA_1200_del2100_alm,nanmean(d2(roi_alm,:),1)');
GA_1200_del2100_m2=cat(2,GA_1200_del2100_m2,nanmean(d2(roi_m2,:),1)');
GA_1200_del2100_ppc=cat(2,GA_1200_del2100_ppc,nanmean(d2(roi_ppc,:),1)');




% cd D:\intrinsic\20150522\b\Matt_files
% load('cond_100_ave_clean.mat')
% load('cond_1200_ave_clean.mat')
% load('rois_initial_205x205.mat')
% d=reshape(cond_100_ave,205*205,180);
% d2=reshape(cond_1200_ave,205*205,180);
% 
% GA_100_del2100_s1=cat(2,GA_100_del2100_s1,nanmean(d(roi_s1,:),1)');
% GA_100_del2100_s2=cat(2,GA_100_del2100_s2,nanmean(d(roi_s2,:),1)');
% GA_100_del2100_m1=cat(2,GA_100_del2100_m1,nanmean(d(roi_m1,:),1)');
% GA_100_del2100_a1=cat(2,GA_100_del2100_a1,nanmean(d(roi_a1,:),1)');
% GA_100_del2100_alm=cat(2,GA_100_del2100_alm,nanmean(d(roi_alm,:),1)');
% GA_100_del2100_m2=cat(2,GA_100_del2100_m2,nanmean(d(roi_m2,:),1)');
% GA_100_del2100_ppc=cat(2,GA_100_del2100_ppc,nanmean(d(roi_ppc,:),1)');
% 
% GA_1200_del2100_s1=cat(2,GA_1200_del2100_s1,nanmean(d2(roi_s1,:),1)');
% GA_1200_del2100_s2=cat(2,GA_1200_del2100_s2,nanmean(d2(roi_s2,:),1)');
% GA_1200_del2100_m1=cat(2,GA_1200_del2100_m1,nanmean(d2(roi_m1,:),1)');
% GA_1200_del2100_a1=cat(2,GA_1200_del2100_a1,nanmean(d2(roi_a1,:),1)');
% GA_1200_del2100_alm=cat(2,GA_1200_del2100_alm,nanmean(d2(roi_alm,:),1)');
% GA_1200_del2100_m2=cat(2,GA_1200_del2100_m2,nanmean(d2(roi_m2,:),1)');
% GA_1200_del2100_ppc=cat(2,GA_1200_del2100_ppc,nanmean(d2(roi_ppc,:),1)');



cd D:\intrinsic\20150605\mouse_tgg6fl23_4\c\Matt_files
load('cond_100_ave_clean.mat')
load('cond_1200_ave_clean.mat')
load('rois_initial_205x205.mat')
d=reshape(cond_100_ave,205*205,180);
d2=reshape(cond_1200_ave,205*205,180);

GA_100_del2100_s1=cat(2,GA_100_del2100_s1,nanmean(d(roi_s1,:),1)');
GA_100_del2100_s2=cat(2,GA_100_del2100_s2,nanmean(d(roi_s2,:),1)');
GA_100_del2100_m1=cat(2,GA_100_del2100_m1,nanmean(d(roi_m1,:),1)');
GA_100_del2100_a1=cat(2,GA_100_del2100_a1,nanmean(d(roi_a1,:),1)');
GA_100_del2100_alm=cat(2,GA_100_del2100_alm,nanmean(d(roi_alm,:),1)');
GA_100_del2100_m2=cat(2,GA_100_del2100_m2,nanmean(d(roi_m2,:),1)');
GA_100_del2100_ppc=cat(2,GA_100_del2100_ppc,nanmean(d(roi_ppc,:),1)');

GA_1200_del2100_s1=cat(2,GA_1200_del2100_s1,nanmean(d2(roi_s1,:),1)');
GA_1200_del2100_s2=cat(2,GA_1200_del2100_s2,nanmean(d2(roi_s2,:),1)');
GA_1200_del2100_m1=cat(2,GA_1200_del2100_m1,nanmean(d2(roi_m1,:),1)');
GA_1200_del2100_a1=cat(2,GA_1200_del2100_a1,nanmean(d2(roi_a1,:),1)');
GA_1200_del2100_alm=cat(2,GA_1200_del2100_alm,nanmean(d2(roi_alm,:),1)');
GA_1200_del2100_m2=cat(2,GA_1200_del2100_m2,nanmean(d2(roi_m2,:),1)');
GA_1200_del2100_ppc=cat(2,GA_1200_del2100_ppc,nanmean(d2(roi_ppc,:),1)');




cd D:\intrinsic\20150610\mouse_tgg6fl23_4\c\Matt_files
load('cond_100_ave_clean.mat')
load('cond_1200_ave_clean.mat')
load('rois_initial_205x205.mat')
d=reshape(cond_100_ave,205*205,180);
d2=reshape(cond_1200_ave,205*205,180);

GA_100_del2100_s1=cat(2,GA_100_del2100_s1,nanmean(d(roi_s1,:),1)');
GA_100_del2100_s2=cat(2,GA_100_del2100_s2,nanmean(d(roi_s2,:),1)');
GA_100_del2100_m1=cat(2,GA_100_del2100_m1,nanmean(d(roi_m1,:),1)');
GA_100_del2100_a1=cat(2,GA_100_del2100_a1,nanmean(d(roi_a1,:),1)');
GA_100_del2100_alm=cat(2,GA_100_del2100_alm,nanmean(d(roi_alm,:),1)');
GA_100_del2100_m2=cat(2,GA_100_del2100_m2,nanmean(d(roi_m2,:),1)');
GA_100_del2100_ppc=cat(2,GA_100_del2100_ppc,nanmean(d(roi_ppc,:),1)');

GA_1200_del2100_s1=cat(2,GA_1200_del2100_s1,nanmean(d2(roi_s1,:),1)');
GA_1200_del2100_s2=cat(2,GA_1200_del2100_s2,nanmean(d2(roi_s2,:),1)');
GA_1200_del2100_m1=cat(2,GA_1200_del2100_m1,nanmean(d2(roi_m1,:),1)');
GA_1200_del2100_a1=cat(2,GA_1200_del2100_a1,nanmean(d2(roi_a1,:),1)');
GA_1200_del2100_alm=cat(2,GA_1200_del2100_alm,nanmean(d2(roi_alm,:),1)');
GA_1200_del2100_m2=cat(2,GA_1200_del2100_m2,nanmean(d2(roi_m2,:),1)');
GA_1200_del2100_ppc=cat(2,GA_1200_del2100_ppc,nanmean(d2(roi_ppc,:),1)');






x=(1:180)*0.05-2.7;

figure;errorbar(x,nanmean(GA_100_del2100_s1,2),nanstd(GA_100_del2100_s1,0,2)/sqrt(size(GA_100_del2100_s1,2)),'b')
hold on
errorbar(x,nanmean(GA_100_del2100_s2,2),nanstd(GA_100_del2100_s2,0,2)/sqrt(size(GA_100_del2100_s2,2)),'c')
errorbar(x,nanmean(GA_100_del2100_m1,2),nanstd(GA_100_del2100_m1,0,2)/sqrt(size(GA_100_del2100_m1,2)),'r')
errorbar(x,nanmean(GA_100_del2100_m2,2),nanstd(GA_100_del2100_m2,0,2)/sqrt(size(GA_100_del2100_m2,2)),'k')
errorbar(x,nanmean(GA_100_del2100_a1,2),nanstd(GA_100_del2100_a1,0,2)/sqrt(size(GA_100_del2100_a1,2)),'g')
errorbar(x,nanmean(GA_100_del2100_alm,2),nanstd(GA_100_del2100_alm,0,2)/sqrt(size(GA_100_del2100_alm,2)),'m')
errorbar(x,nanmean(GA_100_del2100_ppc,2),nanstd(GA_100_del2100_ppc,0,2)/sqrt(size(GA_100_del2100_ppc,2)),'y')


diff_s1=GA_100_del2100_s1-GA_1200_del2100_s1;
diff_s2=GA_100_del2100_s2-GA_1200_del2100_s2;
diff_m1=GA_100_del2100_m1-GA_1200_del2100_m1;
diff_m2=GA_100_del2100_m2-GA_1200_del2100_m2;
diff_a1=GA_100_del2100_a1-GA_1200_del2100_a1;
diff_alm=GA_100_del2100_alm-GA_1200_del2100_alm;
diff_ppc=GA_100_del2100_ppc-GA_1200_del2100_ppc;

figure;errorbar(x,nanmean(diff_s1,2),nanstd(diff_s1,0,2)/sqrt(size(diff_s1,2)),'b')
hold on
errorbar(x,nanmean(diff_s2,2),nanstd(diff_s2,0,2)/sqrt(size(diff_s2,2)),'c')
errorbar(x,nanmean(diff_m1,2),nanstd(diff_m1,0,2)/sqrt(size(diff_m1,2)),'r')
errorbar(x,nanmean(diff_m2,2),nanstd(diff_m2,0,2)/sqrt(size(diff_m2,2)),'k')
errorbar(x,nanmean(diff_alm,2),nanstd(diff_alm,0,2)/sqrt(size(diff_alm,2)),'m')
errorbar(x,nanmean(diff_a1,2),nanstd(diff_a1,0,2)/sqrt(size(diff_a1,2)),'g')
errorbar(x,nanmean(diff_ppc,2),nanstd(diff_ppc,0,2)/sqrt(size(diff_ppc,2)),'y')
legend('s1','s2','m1','m2','alm','a1')
plot(x,zeros(1,180),'k')



