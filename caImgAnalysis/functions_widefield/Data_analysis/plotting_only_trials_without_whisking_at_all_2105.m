cd D:\intrinsic\20150521\a\Matt_files
k=0;
k=k+1;
load cond_100_trial1
cond_100_ave=tr;

cd D:\intrinsic\20150521\b\Matt_files
k=k+1;
load cond_100_trial35
cond_100_ave=cond_100_ave+tr;


cd D:\intrinsic\20150521\c\Matt_files
k=k+1;
load cond_100_trial13
cond_100_ave=cond_100_ave+tr(:,:,1:180);
k=k+1;
load cond_100_trial26
cond_100_ave=cond_100_ave+tr(:,:,1:180);
k=k+1;
load cond_100_trial29
cond_100_ave=cond_100_ave+tr(:,:,1:180);
k=k+1;
load cond_100_trial31
cond_100_ave=cond_100_ave+tr(:,:,1:180);
k=k+1;
load cond_100_trial47
cond_100_ave=cond_100_ave+tr(:,:,1:180);
k=k+1;
load cond_100_trial44
cond_100_ave=cond_100_ave+tr(:,:,1:180);


cd D:\intrinsic\20150521\d\Matt_files
k=k+1;
load cond_100_trial12
cond_100_ave=cond_100_ave+tr;

cond_100_ave=cond_100_ave/k;



%%

cd D:\intrinsic\20150521\a\Matt_files
k=0;
k=k+1;
load cond_1200_trial19
cond_1200_ave=tr;

cd D:\intrinsic\20150521\b\Matt_files
k=k+1;
load cond_1200_trial12
cond_1200_ave=cond_1200_ave+tr;
k=k+1;
load cond_1200_trial10
cond_1200_ave=cond_1200_ave+tr;
k=k+1;
load cond_1200_trial21
cond_1200_ave=cond_1200_ave+tr;
k=k+1;
load cond_1200_trial29
cond_1200_ave=cond_1200_ave+tr;


cd D:\intrinsic\20150521\c\Matt_files
k=k+1;
load cond_1200_trial23
cond_1200_ave=cond_1200_ave+tr(:,:,1:180);
k=k+1;
load cond_1200_trial33
cond_1200_ave=cond_1200_ave+tr(:,:,1:180);


cd D:\intrinsic\20150521\d\Matt_files
k=k+1;
load cond_1200_trial16
cond_1200_ave=cond_1200_ave+tr;
k=k+1;
load cond_1200_trial22
cond_1200_ave=cond_1200_ave+tr;
k=k+1;
load cond_1200_trial25
cond_1200_ave=cond_1200_ave+tr;
k=k+1;
load cond_1200_trial34
cond_1200_ave=cond_1200_ave+tr;

cond_1200_ave=cond_1200_ave/k;



%%



load rois_initial_205x205
h=zeros(205*205,1);
h(roi_s1)=1;
h(roi_s2)=1;
h(roi_m1)=1;
h(roi_m2)=1;
h(roi_a1)=1;
h(roi_alm)=1;

x=(1:size(cond_100_ave,3))*0.05-2.7;
d=reshape(cond_100_ave,205*205,size(cond_100_ave,3));
figure;plot(x,smooth(squeeze(nanmean(d(roi_s1,:),1))-1,1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d(roi_s2,:),1))-1,1,'Gauss'),'c')
plot(x,smooth(squeeze(nanmean(d(roi_m1,:),1))-1,1,'Gauss'),'r')
plot(x,smooth(squeeze(nanmean(d(roi_a1,:),1))-1,1,'Gauss'),'g')
plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,1,'Gauss'),'k')
plot(x,smooth(squeeze(nanmean(d(roi_alm,:),1))-1,1,'Gauss'),'m')
plot(x,zeros(1,size(cond_100_ave,3)),'k')
legend('s1','s2','m1','a1','m2','alm')



d2=reshape(cond_1200_ave,205*205,size(cond_1200_ave,3));
figure;plot(x,smooth(squeeze(nanmean(d2(roi_s1,:),1))-1,1,'Gauss'),'--b')
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_s2,:),1))-1,1,'Gauss'),'--c')
plot(x,smooth(squeeze(nanmean(d2(roi_m1,:),1))-1,1,'Gauss'),'--r')
plot(x,smooth(squeeze(nanmean(d2(roi_a1,:),1))-1,1,'Gauss'),'--g')
plot(x,smooth(squeeze(nanmean(d2(roi_m2,:),1))-1,1,'Gauss'),'--k')
plot(x,smooth(squeeze(nanmean(d2(roi_alm,:),1))-1,1,'Gauss'),'--m')
plot(x,zeros(1,size(cond_100_ave,3)),'k')
legend('s1','s2','m1','a1','m2','alm')

figure;plot(x,smooth(squeeze(nanmean(d(roi_s1,:),1))-squeeze(nanmean(d2(roi_s1,:),1)),1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d(roi_s2,:),1))-squeeze(nanmean(d2(roi_s2,:),1)),1,'Gauss'),'c')
plot(x,smooth(squeeze(nanmean(d(roi_m1,:),1))-squeeze(nanmean(d2(roi_m1,:),1)),1,'Gauss'),'r')
plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-squeeze(nanmean(d2(roi_m2,:),1)),1,'Gauss'),'k')
plot(x,smooth(squeeze(nanmean(d(roi_alm,:),1))-squeeze(nanmean(d2(roi_alm,:),1)),1,'Gauss'),'m')
plot(x,smooth(squeeze(nanmean(d(roi_a1,:),1))-squeeze(nanmean(d2(roi_a1,:),1)),1,'Gauss'),'g')
plot(x,smooth(squeeze(nanmean(d(roi_ppc,:),1))-squeeze(nanmean(d2(roi_ppc,:),1)),1,'Gauss'),'y')
plot(x,zeros(1,size(cond_100_ave,3)),'k')
legend('s1','s2','m1','m2','alm','a1')



for i=180:-4:1
    figure;imagesc(smoothn(cond_100_ave(:,:,i)-1,[5 5],'Gauss'),[-2e-2 2e-2]);colormap(mapgeog)
    %hold on
    %contour(reshape(h,205,205),'k')
    title([int2str(x(i)*1000)])
    %title([int2str(i)])
end


for i=180:-4:1
    figure;imagesc(smoothn(cond_100_ave(:,:,i)-cond_1200_ave(:,:,i),[5 5],'Gauss'),[-.6e-2 1e-2]);colormap(mapgeog)
    %hold on
    %contour(reshape(h,205,205),'k')
    title([int2str(x(i)*1000)])
    %title([int2str(i)])
end











