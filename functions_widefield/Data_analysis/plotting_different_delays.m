cd D:\intrinsic\20151023\a\Matt_files
load('cond_1200_ave.mat')
load('roi_m2.mat')
s=3;
x=(1:size(cond_1200_ave,3))*0.05-3.05;
d=reshape(cond_1200_ave,256*256,size(cond_1200_ave,3));
figure;plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,s,'Gauss'),'b')
hold on
plot(x,zeros(1,size(cond_1200_ave,3)),'k')

cd D:\intrinsic\20151023\b\Matt_files
load('cond_1200_ave.mat')
x=(1:size(cond_1200_ave,3))*0.05-3.05;
d=reshape(cond_1200_ave,256*256,size(cond_1200_ave,3));
plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,s,'Gauss'),'r')

cd D:\intrinsic\20151023\c\Matt_files
load('cond_1200_ave.mat')
x=(1:size(cond_1200_ave,3))*0.05-3.05;
d=reshape(cond_1200_ave,256*256,size(cond_1200_ave,3));
plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,s,'Gauss'),'g')
xlim([-2.5 6.25])


%
cd D:\intrinsic\20150519\b\Matt_files
load('cond_100_ave.mat')
load('rois_initial_205x205.mat')
x=(1:size(cond_100_ave,3))*0.05-2.7;
d=reshape(cond_100_ave,205*205,size(cond_100_ave,3));
figure;plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,s,'Gauss'),'b')
hold on
plot(x,zeros(1,size(cond_100_ave,3)),'k')
xlim([-2.5 6.25])

cd D:\intrinsic\20150519\c\Matt_files
load('cond_100_ave.mat')
d=reshape(cond_100_ave,205*205,size(cond_100_ave,3));
plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,s,'Gauss'),'r')


cd D:\intrinsic\20150519\d\Matt_files
load('cond_100_ave.mat')
d=reshape(cond_100_ave,205*205,size(cond_100_ave,3));
plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,s,'Gauss'),'g')

cd D:\intrinsic\20150520\c\Matt_files
load('cond_100_ave.mat')
load('rois_initial_205x205.mat')
d=reshape(cond_100_ave,205*205,size(cond_100_ave,3));
plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,s,'Gauss'),'c')




%
cd F:\wide_field_data\20150128\e\Matt_files
load('cond_100_ave.mat')
load('rois_initial_205x205.mat')
x=(1:size(cond_100_ave,3))*0.05-2.7;
d=reshape(cond_100_ave,205*205,size(cond_100_ave,3));
figure;plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,s,'Gauss'),'b')
hold on
plot(x,zeros(1,size(cond_100_ave,3)),'k')
xlim([-2.5 6.25])

cd F:\wide_field_data\20150128\c\Matt_files
load('cond_100_ave.mat')
d=reshape(cond_100_ave,205*205,size(cond_100_ave,3));
plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,s,'Gauss'),'r')


