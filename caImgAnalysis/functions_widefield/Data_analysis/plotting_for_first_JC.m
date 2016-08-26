cd D:\intrinsic\20150127\d\Matt_files
load('cond_100_ave_clean.mat')
load('cond_1200_ave_clean.mat')
cond_100_ave=reshape(cond_100_ave,205,205,180);
cond_1200_ave=reshape(cond_1200_ave,205,205,180);

load rois_205x205_v2
h=zeros(205*205,1);
h(roi_s1)=1;
h(roi_s2)=1;
h(roi_m1)=1;
h(roi_m2)=1;
%h(roi_a1)=1;
%h(roi_alm)=1;
y=fliplr(smoothn(nanmean(cond_100_ave(:,:,50),3),[5 5],'Gauss')')-1;
y(isnan(y))=10000;
figure;imagesc(y,[-.5e-2 3.5e-2]);colormap(mapgeog)
hold on
axis square
axis off
line([141 146],[27 88],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([146 145],[88 165],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
contour(fliplr(reshape(h,205,205)'),'k')

y=fliplr(smoothn(nanmean(cond_100_ave(:,:,140:160),3),[5 5],'Gauss')')-1;
y(isnan(y))=10000;
figure;imagesc(y,[-.5e-2 2e-2]);colormap(mapgeog)
h=zeros(205*205,1);
h(roi_alm)=1;
hold on
axis square
axis off
line([141 146],[27 88],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([146 145],[88 165],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
contour(fliplr(reshape(h,205,205)'),'k')

load green_205x205
h=zeros(205*205,1);
h(roi_s1)=1;
h(roi_s2)=1;
h(roi_m1)=1;
h(roi_m2)=1;
h(roi_a1)=1;
h(roi_alm)=1;

y=fliplr(smoothn(nanmean(cond_100_ave(:,:,140:160),3),[5 5],'Gauss')')-1;
y2=fliplr(green_ds');
y2(isnan(y))=10000;
figure;imagesc(y2,[-0.025 0.1]);colormap(gray)
hold on
axis square
axis off
line([141 146],[27 88],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
line([146 145],[88 165],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
contour(fliplr(reshape(h,205,205)'),'k')



x=(1:180)*0.05-2.7;
d=reshape(cond_100_ave,205*205,180);
d2=reshape(cond_1200_ave,205*205,180);
figure;plot(x,smooth(squeeze(nanmean(d(roi_s1,:),1))-1,1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d(roi_s2,:),1))-1,1,'Gauss'),'c')
plot(x,smooth(squeeze(nanmean(d(roi_m1,:),1))-1,1,'Gauss'),'r')
plot(x,smooth(squeeze(nanmean(d(roi_a1,:),1))-1,1,'Gauss'),'g')
plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,1,'Gauss'),'k')
plot(x,smooth(squeeze(nanmean(d(roi_alm,:),1))-1,1,'Gauss'),'m')
plot(x,zeros(1,180),'k')
legend('s1','s2','m1','a1','m2','alm')
xlim([-2.7 6])
ylim([-3e-2 6e-2])


figure;plot(x,smooth(squeeze(nanmean(d2(roi_s1,:),1))-1,1,'Gauss'),'--b')
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_s2,:),1))-1,1,'Gauss'),'--c')
plot(x,smooth(squeeze(nanmean(d2(roi_m1,:),1))-1,1,'Gauss'),'--r')
plot(x,smooth(squeeze(nanmean(d2(roi_a1,:),1))-1,1,'Gauss'),'--g')
plot(x,smooth(squeeze(nanmean(d2(roi_m2,:),1))-1,1,'Gauss'),'--k')
plot(x,smooth(squeeze(nanmean(d2(roi_alm,:),1))-1,1,'Gauss'),'--m')
plot(x,zeros(1,180),'k')
legend('s1','s2','m1','a1','m2','alm')
xlim([-2.7 6])
ylim([-3e-2 6e-2])

figure;plot(x,smooth(squeeze(nanmean(d(roi_s1,:),1))-squeeze(nanmean(d2(roi_s1,:),1)),1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d(roi_s2,:),1))-squeeze(nanmean(d2(roi_s2,:),1)),1,'Gauss'),'c')
plot(x,smooth(squeeze(nanmean(d(roi_m1,:),1))-squeeze(nanmean(d2(roi_m1,:),1)),1,'Gauss'),'r')
plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-squeeze(nanmean(d2(roi_m2,:),1)),1,'Gauss'),'k')
plot(x,smooth(squeeze(nanmean(d(roi_alm,:),1))-squeeze(nanmean(d2(roi_alm,:),1)),1,'Gauss'),'m')
plot(x,smooth(squeeze(nanmean(d(roi_a1,:),1))-squeeze(nanmean(d2(roi_a1,:),1)),1,'Gauss'),'g')
plot(x,zeros(1,180),'k')
legend('s1','s2','m1','m2','alm','a1')
xlim([-2.7 6])




figure;plot(x,smooth(squeeze(nanmean(d(roi_s1,:),1))-1,1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_s1,:),1))-1,1,'Gauss'),'--b')
plot(x,zeros(1,180),'k')
title('s1')
xlim([-2.7 6])

figure;plot(x,smooth(squeeze(nanmean(d(roi_s2,:),1))-1,1,'Gauss'),'c')
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_s2,:),1))-1,1,'Gauss'),'--c')
plot(x,zeros(1,180),'k')
title('s2')
xlim([-2.7 6])

figure;plot(x,smooth(squeeze(nanmean(d(roi_m1,:),1))-1,1,'Gauss'),'r')
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_m1,:),1))-1,1,'Gauss'),'--r')
plot(x,zeros(1,180),'k')
title('m1')
xlim([-2.7 6])

figure;plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,1,'Gauss'),'k')
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_m2,:),1))-1,1,'Gauss'),'--k')
plot(x,zeros(1,180),'k')
title('m2')
xlim([-2.7 6])


figure;plot(x,smooth(squeeze(nanmean(d(roi_alm,:),1))-1,1,'Gauss'),'m')
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_alm,:),1))-1,1,'Gauss'),'--m')
plot(x,zeros(1,180),'k')
title('alm')
xlim([-2.7 6])

figure;plot(x,smooth(squeeze(nanmean(d(roi_a1,:),1))-1,1,'Gauss'),'g')
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_a1,:),1))-1,1,'Gauss'),'--g')
plot(x,zeros(1,180),'k')
title('a1')
xlim([-2.7 6])







