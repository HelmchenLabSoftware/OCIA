cd D:\intrinsic\20150507\a\Matt_files
load('cond_100_ave_clean.mat')
load('cond_1200_ave_clean.mat')
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


cd D:\intrinsic\20150507\b\Matt_files
load('cond_100_ave_clean.mat')
load('cond_1200_ave_clean.mat')
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

cd D:\intrinsic\20150507\c\Matt_files
load('cond_100_ave_clean.mat')
load('cond_1200_ave_clean.mat')
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


cd D:\intrinsic\20150508\a\Matt_files
load('cond_100_ave_clean.mat')
load('cond_1200_ave_clean.mat')
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



cd D:\intrinsic\20150508\b\Matt_files
load('cond_100_ave_clean.mat')
load('cond_1200_ave_clean.mat')
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

cd D:\intrinsic\20150508\c\Matt_files
load('cond_100_ave_clean.mat')
load('cond_1200_ave_clean.mat')
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

cd D:\intrinsic\20150508\d\Matt_files
load('cond_100_ave_clean.mat')
load('cond_1200_ave_clean.mat')
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

cd D:\intrinsic\20150508\e\Matt_files
load('cond_100_ave_clean.mat')
load('cond_1200_ave_clean.mat')
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

cd D:\intrinsic\20150513\c\Matt_files
load('cond_100_ave_clean.mat')
load('cond_1200_ave_clean.mat')
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


cd D:\intrinsic\20150513\d\Matt_files
load('cond_100_ave.mat')
load('cond_1200_ave.mat')
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



cd D:\intrinsic\20150513\e\Matt_files
load('cond_100_ave_clean.mat')
load('cond_1200_ave_clean.mat')
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


cd D:\intrinsic\20150513\f\Matt_files
load('cond_100_ave_clean.mat')
load('cond_1200_ave_clean.mat')
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



cd D:\intrinsic\20150514\a\Matt_files
load('cond_100_ave.mat')
load('cond_1200_ave.mat')
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


cd D:\intrinsic\20150514\b\Matt_files
load('cond_100_ave.mat')
load('cond_1200_ave.mat')
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


cd D:\intrinsic\20150514\c\Matt_files
load('cond_100_ave.mat')
load('cond_1200_ave.mat')
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



cd D:\intrinsic\20150519\a\Matt_files
load('cond_100_ave.mat')
load('cond_1200_ave.mat')
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


cd D:\intrinsic\20150519\b\Matt_files
load('cond_100_ave.mat')
load('cond_1200_ave.mat')
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


cd D:\intrinsic\20150519\c\Matt_files
load('cond_100_ave.mat')
load('cond_1200_ave.mat')
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

cd D:\intrinsic\20150519\d\Matt_files
load('cond_100_ave.mat')
load('cond_1200_ave.mat')
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


cd D:\intrinsic\20150520\a\Matt_files
load('cond_100_ave_clean.mat')
load('cond_1200_ave_clean.mat')
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



cd D:\intrinsic\20150520\b\Matt_files
load('cond_100_ave_clean.mat')
load('cond_1200_ave_clean.mat')
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

cd D:\intrinsic\20150520\c\Matt_files
load('cond_100_ave_clean.mat')
load('cond_1200_ave_clean.mat')
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

cd D:\intrinsic\20150520\d\Matt_files
load('cond_100_ave_clean.mat')
load('cond_1200_ave_clean.mat')
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


cd D:\intrinsic\20150521\a\Matt_files
load('cond_100_ave_clean.mat')
load('cond_1200_ave_clean.mat')
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


cd D:\intrinsic\20150521\b\Matt_files
load('cond_100_ave_clean.mat')
load('cond_1200_ave_clean.mat')
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

cd D:\intrinsic\20150521\c\Matt_files
load('cond_100_ave_clean.mat')
load('cond_1200_ave_clean.mat')
load('rois_initial_205x205.mat')
d=reshape(cond_100_ave(:,1:180),205*205,180);
d2=reshape(cond_1200_ave(:,1:180),205*205,180);

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

cd D:\intrinsic\20150521\d\Matt_files
load('cond_100_ave_clean.mat')
load('cond_1200_ave_clean.mat')
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

cd D:\intrinsic\20150522\mouse_tggf6l23_3\a\Matt_files
load('cond_100_ave.mat')
load('cond_1200_ave.mat')
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

cd D:\intrinsic\20150522\mouse_tggf6l23_3\b\Matt_files
load('cond_100_ave.mat')
load('cond_1200_ave.mat')
load('rois_initial_205x205.mat')
d=reshape(cond_100_ave(:,:,1:180),205*205,180);
d2=reshape(cond_1200_ave(:,:,1:180),205*205,180);

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


cd D:\intrinsic\20150610\b\Matt_files
load('cond_100_ave.mat')
load('cond_1200_ave.mat')
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


cd D:\intrinsic\20150610\c\Matt_files
load('cond_100_ave.mat')
load('cond_1200_ave.mat')
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



x=(1:180)*0.05-2.7;

diff_s1=GA_100_del1100_s1-GA_1200_del1100_s1;
diff_s2=GA_100_del1100_s2-GA_1200_del1100_s2;
diff_m1=GA_100_del1100_m1-GA_1200_del1100_m1;
diff_m2=GA_100_del1100_m2-GA_1200_del1100_m2;
diff_a1=GA_100_del1100_a1-GA_1200_del1100_a1;
diff_alm=GA_100_del1100_alm-GA_1200_del1100_alm;
% figure;errorbar(x,nanmean(diff_s1,2),nanstd(diff_s1,0,2)/sqrt(size(diff_s1,2)),'b')
% hold on
% errorbar(x,nanmean(diff_s2,2),nanstd(diff_s2,0,2)/sqrt(size(diff_s2,2)),'c')
% errorbar(x,nanmean(diff_m1,2),nanstd(diff_m1,0,2)/sqrt(size(diff_m1,2)),'r')
% errorbar(x,nanmean(diff_m2,2),nanstd(diff_m2,0,2)/sqrt(size(diff_m2,2)),'k')
% errorbar(x,nanmean(diff_alm,2),nanstd(diff_alm,0,2)/sqrt(size(diff_alm,2)),'m')
% errorbar(x,nanmean(diff_a1,2),nanstd(diff_a1,0,2)/sqrt(size(diff_a1,2)),'g')
% legend('s1','s2','m1','m2','alm','a1')
% plot(x,zeros(1,180),'k')

time=44:60;
figure;bar([nanmean(nanmean(diff_s1(time,:),1)) nanmean(nanmean(diff_s2(time,:),1)) nanmean(nanmean(diff_a1(time,:),1)) nanmean(nanmean(diff_m1(time,:),1)) nanmean(nanmean(diff_m2(time,:),1))])
hold on
errorbar([nanmean(nanmean(diff_s1(time,:),1)) nanmean(nanmean(diff_s2(time,:),1)) nanmean(nanmean(diff_a1(time,:),1)) nanmean(nanmean(diff_m1(time,:),1)) nanmean(nanmean(diff_m2(time,:),1))],[nanstd(nanmean(diff_s1(time,:),1)) nanstd(nanmean(diff_s2(time,:),1)) nanstd(nanmean(diff_a1(time,:),1)) nanstd(nanmean(diff_m1(time,:),1)) nanstd(nanmean(diff_m2(time,:),1))]/sqrt(size(diff_s1,2)))
title('Resopnse to texture')
ylim([-0.01 0.05])

signrank(nanmean(diff_s1(time,:),1))
signrank(nanmean(diff_s2(time,:),1))
signrank(nanmean(diff_a1(time,:),1))
signrank(nanmean(diff_m1(time,:),1))
signrank(nanmean(diff_m2(time,:),1))
signrank(nanmean(diff_alm(time,:),1))

signrank(nanmean(diff_s1(time,:),1),nanmean(diff_m2(time,:),1))*5
signrank(nanmean(diff_s2(time,:),1),nanmean(diff_m2(time,:),1))*5
signrank(nanmean(diff_m1(time,:),1),nanmean(diff_m2(time,:),1))*5
signrank(nanmean(diff_a1(time,:),1),nanmean(diff_m2(time,:),1))*5
signrank(nanmean(diff_alm(time,:),1),nanmean(diff_m2(time,:),1))*5

% figure;bar([nanmean(nanmean(GA_100_del1100_s1(time,:),1))-1 nanmean(nanmean(GA_100_del1100_s2(time,:),1))-1 nanmean(nanmean(GA_100_del1100_a1(time,:),1))-1 nanmean(nanmean(GA_100_del1100_m1(time,:),1))-1 nanmean(nanmean(GA_100_del1100_m2(time,:),1))-1 nanmean(nanmean(GA_100_del1100_alm(time,:),1))-1])
% hold on
% errorbar([nanmean(nanmean(GA_100_del1100_s1(time,:),1))-1 nanmean(nanmean(GA_100_del1100_s2(time,:),1))-1 nanmean(nanmean(GA_100_del1100_a1(time,:),1))-1 nanmean(nanmean(GA_100_del1100_m1(time,:),1))-1 nanmean(nanmean(GA_100_del1100_m2(time,:),1))-1 nanmean(nanmean(GA_100_del1100_alm(time,:),1))-1],[nanstd(nanmean(GA_100_del1100_s1(time,:),1)) nanstd(nanmean(GA_100_del1100_s2(time,:),1)) nanstd(nanmean(GA_100_del1100_a1(time,:),1)) nanstd(nanmean(GA_100_del1100_m1(time,:),1)) nanstd(nanmean(GA_100_del1100_m2(time,:),1)) nanstd(nanmean(GA_100_del1100_alm(time,:),1))]/sqrt(size(GA_100_del1100_s1,2)))
% ylim([-0.005 0.03])
% figure;bar([nanmean(nanmean(GA_1200_del1100_s1(time,:),1))-1 nanmean(nanmean(GA_1200_del1100_s2(time,:),1))-1 nanmean(nanmean(GA_1200_del1100_a1(time,:),1))-1 nanmean(nanmean(GA_1200_del1100_m1(time,:),1))-1 nanmean(nanmean(GA_1200_del1100_m2(time,:),1))-1 nanmean(nanmean(GA_1200_del1100_alm(time,:),1))-1])
% hold on
% errorbar([nanmean(nanmean(GA_1200_del1100_s1(time,:),1))-1 nanmean(nanmean(GA_1200_del1100_s2(time,:),1))-1 nanmean(nanmean(GA_1200_del1100_a1(time,:),1))-1 nanmean(nanmean(GA_1200_del1100_m1(time,:),1))-1 nanmean(nanmean(GA_1200_del1100_m2(time,:),1))-1 nanmean(nanmean(GA_1200_del1100_alm(time,:),1))-1],[nanstd(nanmean(GA_1200_del1100_s1(time,:),1)) nanstd(nanmean(GA_1200_del1100_s2(time,:),1)) nanstd(nanmean(GA_1200_del1100_a1(time,:),1)) nanstd(nanmean(GA_1200_del1100_m1(time,:),1)) nanstd(nanmean(GA_1200_del1100_m2(time,:),1)) nanstd(nanmean(GA_1200_del1100_alm(time,:),1))]/sqrt(size(GA_1200_del1100_s1,2)))
% ylim([-0.005 0.03])

time=96:122;
figure;bar([nanmean(nanmean(diff_s1(time,:),1)) nanmean(nanmean(diff_s2(time,:),1)) nanmean(nanmean(diff_a1(time,:),1)) nanmean(nanmean(diff_m1(time,:),1)) nanmean(nanmean(diff_m2(time,:),1))])
hold on
errorbar([nanmean(nanmean(diff_s1(time,:),1)) nanmean(nanmean(diff_s2(time,:),1)) nanmean(nanmean(diff_a1(time,:),1)) nanmean(nanmean(diff_m1(time,:),1)) nanmean(nanmean(diff_m2(time,:),1))],[nanstd(nanmean(diff_s1(time,:),1)) nanstd(nanmean(diff_s2(time,:),1)) nanstd(nanmean(diff_a1(time,:),1)) nanstd(nanmean(diff_m1(time,:),1)) nanstd(nanmean(diff_m2(time,:),1))]/sqrt(size(diff_s1,2)))
ylim([-0.01 0.05])
title('Delay period')
signrank(nanmean(diff_s1(time,:),1))
signrank(nanmean(diff_s2(time,:),1))
signrank(nanmean(diff_a1(time,:),1))
signrank(nanmean(diff_m1(time,:),1))
signrank(nanmean(diff_m2(time,:),1))
signrank(nanmean(diff_alm(time,:),1))

signrank(nanmean(diff_s1(time,:),1),nanmean(diff_m2(time,:),1))*5
signrank(nanmean(diff_s2(time,:),1),nanmean(diff_m2(time,:),1))*5
signrank(nanmean(diff_m1(time,:),1),nanmean(diff_m2(time,:),1))*5
signrank(nanmean(diff_a1(time,:),1),nanmean(diff_m2(time,:),1))*5
signrank(nanmean(diff_alm(time,:),1),nanmean(diff_m2(time,:),1))*5

% figure;bar([nanmean(nanmean(GA_100_del1100_s1(time,:),1))-1 nanmean(nanmean(GA_100_del1100_s2(time,:),1))-1 nanmean(nanmean(GA_100_del1100_a1(time,:),1))-1 nanmean(nanmean(GA_100_del1100_m1(time,:),1))-1 nanmean(nanmean(GA_100_del1100_m2(time,:),1))-1 nanmean(nanmean(GA_100_del1100_alm(time,:),1))-1])
% hold on
% errorbar([nanmean(nanmean(GA_100_del1100_s1(time,:),1))-1 nanmean(nanmean(GA_100_del1100_s2(time,:),1))-1 nanmean(nanmean(GA_100_del1100_a1(time,:),1))-1 nanmean(nanmean(GA_100_del1100_m1(time,:),1))-1 nanmean(nanmean(GA_100_del1100_m2(time,:),1))-1 nanmean(nanmean(GA_100_del1100_alm(time,:),1))-1],[nanstd(nanmean(GA_100_del1100_s1(time,:),1)) nanstd(nanmean(GA_100_del1100_s2(time,:),1)) nanstd(nanmean(GA_100_del1100_a1(time,:),1)) nanstd(nanmean(GA_100_del1100_m1(time,:),1)) nanstd(nanmean(GA_100_del1100_m2(time,:),1)) nanstd(nanmean(GA_100_del1100_alm(time,:),1))]/sqrt(size(GA_100_del1100_s1,2)))
% ylim([-0.02 0.05])
% figure;bar([nanmean(nanmean(GA_1200_del1100_s1(time,:),1))-1 nanmean(nanmean(GA_1200_del1100_s2(time,:),1))-1 nanmean(nanmean(GA_1200_del1100_a1(time,:),1))-1 nanmean(nanmean(GA_1200_del1100_m1(time,:),1))-1 nanmean(nanmean(GA_1200_del1100_m2(time,:),1))-1 nanmean(nanmean(GA_1200_del1100_alm(time,:),1))-1])
% hold on
% errorbar([nanmean(nanmean(GA_1200_del1100_s1(time,:),1))-1 nanmean(nanmean(GA_1200_del1100_s2(time,:),1))-1 nanmean(nanmean(GA_1200_del1100_a1(time,:),1))-1 nanmean(nanmean(GA_1200_del1100_m1(time,:),1))-1 nanmean(nanmean(GA_1200_del1100_m2(time,:),1))-1 nanmean(nanmean(GA_1200_del1100_alm(time,:),1))-1],[nanstd(nanmean(GA_1200_del1100_s1(time,:),1)) nanstd(nanmean(GA_1200_del1100_s2(time,:),1)) nanstd(nanmean(GA_1200_del1100_a1(time,:),1)) nanstd(nanmean(GA_1200_del1100_m1(time,:),1)) nanstd(nanmean(GA_1200_del1100_m2(time,:),1)) nanstd(nanmean(GA_1200_del1100_alm(time,:),1))]/sqrt(size(GA_1200_del1100_s1,2)))
% ylim([-0.02 0.05])









