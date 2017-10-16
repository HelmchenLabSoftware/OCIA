cd D:\intrinsic\20150521\b\Matt_files

load('cond_100_ave_clean.mat')
load('cond_1200_ave_clean.mat')
cond_100_ave=reshape(cond_100_ave,205,205,size(cond_100_ave,2));
cond_1200_ave=reshape(cond_1200_ave,205,205,size(cond_1200_ave,2));
load rois_initial_205x205
h=zeros(205*205,1);
h(roi_s1)=1;
h(roi_s2)=1;
h(roi_m1)=1;
h(roi_m2)=1;
h(roi_a1)=1;
h(roi_alm)=1;
%h(roi_ppc)=1;

x=(1:size(cond_100_ave,3))*0.05-2.5;
d=reshape(cond_100_ave,205*205,size(cond_100_ave,3));
figure;plot(x,smooth(squeeze(nanmean(d(roi_s1,:),1))-1,1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d(roi_s2,:),1))-1,1,'Gauss'),'c')
plot(x,smooth(squeeze(nanmean(d(roi_m1,:),1))-1,1,'Gauss'),'r')
plot(x,smooth(squeeze(nanmean(d(roi_a1,:),1))-1,1,'Gauss'),'g')
plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,1,'Gauss'),'k')
%plot(x,smooth(squeeze(nanmean(d(roi_alm,:),1))-1,1,'Gauss'),'m')
%plot(x,smooth(squeeze(nanmean(d(roi_ppc,:),1))-1,1,'Gauss'),'y')
plot(x,zeros(1,size(cond_100_ave,3)),'k')
legend('s1','s2','m1','a1','m2')
xlim([-2.5 6])
ylim([-0.04 0.1])

d2=reshape(cond_1200_ave,205*205,size(cond_1200_ave,3));
figure;plot(x,smooth(squeeze(nanmean(d2(roi_s1,:),1))-1,1,'Gauss'),'--b')
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_s2,:),1))-1,1,'Gauss'),'--c')
plot(x,smooth(squeeze(nanmean(d2(roi_m1,:),1))-1,1,'Gauss'),'--r')
plot(x,smooth(squeeze(nanmean(d2(roi_a1,:),1))-1,1,'Gauss'),'--g')
plot(x,smooth(squeeze(nanmean(d2(roi_m2,:),1))-1,1,'Gauss'),'--k')
%plot(x,smooth(squeeze(nanmean(d2(roi_alm,:),1))-1,1,'Gauss'),'--m')
plot(x,zeros(1,size(cond_100_ave,3)),'k')
legend('s1','s2','m1','a1','m2')
xlim([-2.5 6])
ylim([-0.04 0.1])

% figure;plot(x,smooth(squeeze(nanmean(d(roi_s1,:),1))-squeeze(nanmean(d2(roi_s1,:),1)),1,'Gauss'))
% hold on
% plot(x,smooth(squeeze(nanmean(d(roi_s2,:),1))-squeeze(nanmean(d2(roi_s2,:),1)),1,'Gauss'),'c')
% plot(x,smooth(squeeze(nanmean(d(roi_m1,:),1))-squeeze(nanmean(d2(roi_m1,:),1)),1,'Gauss'),'r')
% plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-squeeze(nanmean(d2(roi_m2,:),1)),1,'Gauss'),'k')
% plot(x,smooth(squeeze(nanmean(d(roi_alm,:),1))-squeeze(nanmean(d2(roi_alm,:),1)),1,'Gauss'),'m')
% plot(x,smooth(squeeze(nanmean(d(roi_a1,:),1))-squeeze(nanmean(d2(roi_a1,:),1)),1,'Gauss'),'g')
% %plot(x,smooth(squeeze(nanmean(d(roi_ppc,:),1))-squeeze(nanmean(d2(roi_ppc,:),1)),1,'Gauss'),'y')
% plot(x,zeros(1,size(cond_100_ave,3)),'k')
% legend('s1','s2','m1','m2','alm','a1')
% xlim([-2.5 6])
% ylim([-0.04 0.1])
% 


y=fliplr(smoothn(nanmean(cond_100_ave(:,:,92:140),3)-1,[5 5],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[-2.5e-2 2.5e-2]);colormap(mapgeog)
hold on
%h=zeros(205*205,1);
%h(roi_s1)=1;
%contour(fliplr(reshape(h,205,205)'),'k')
line([134 154],[8 165],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
axis square
axis off

y=fliplr(smoothn(nanmean(cond_100_ave(:,:,92:140),3)-1,[5 5],'Gauss')');
[slice, slice1D_s1, imgTransformedRotated, imgTransformed] = rotateAndSlice_guy(y', 100, 32, 0, 15);
xs1=((1:205)-140)*0.05;
figure;plot(xs1,slice1D_s1)
xlim([-3 0.5])

y=fliplr(smoothn(nanmean(cond_1200_ave(:,:,92:140),3)-1,[5 5],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[-2.5e-2 2.5e-2]);colormap(mapgeog)
hold on
%h=zeros(205*205,1);
%h(roi_s1)=1;
%contour(fliplr(reshape(h,205,205)'),'k')
line([134 154],[8 165],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
axis square
axis off

y=fliplr(smoothn(nanmean(cond_1200_ave(:,:,92:140),3)-1,[5 5],'Gauss')');
[slice, slice1D_s1, imgTransformedRotated, imgTransformed] = rotateAndSlice_guy(y', 100, 32, 0, 15);
xs1=((1:205)-140)*0.05;
figure;plot(xs1,slice1D_s1)
xlim([-3 0.5])


y=fliplr(smoothn(nanmean(cond_100_ave(:,:,47:50),3)-1,[5 5],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[-1e-2 2.5e-2]);colormap(mapgeog)
hold on
%h=zeros(205*205,1);
%h(roi_s1)=1;
%contour(fliplr(reshape(h,205,205)'),'k')
line([134 154],[8 165],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
axis square
axis off

y=fliplr(smoothn(nanmean(cond_100_ave(:,:,47:50),3)-1,[5 5],'Gauss')');
[slice, slice1D_s1, imgTransformedRotated, imgTransformed] = rotateAndSlice_guy(y', 100, 32, 0, 15);
xs1=((1:205)-140)*0.05;
figure;plot(xs1,slice1D_s1)
xlim([-3 0.5])

y=fliplr(smoothn(nanmean(cond_1200_ave(:,:,47:50),3)-1,[5 5],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[-1e-2 1.5e-2]);colormap(mapgeog)
hold on
%h=zeros(205*205,1);
%h(roi_s1)=1;
%contour(fliplr(reshape(h,205,205)'),'k')
line([134 154],[8 165],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
axis square
axis off

y=fliplr(smoothn(nanmean(cond_1200_ave(:,:,47:50),3)-1,[5 5],'Gauss')');
[slice, slice1D_s1, imgTransformedRotated, imgTransformed] = rotateAndSlice_guy(y', 100, 32, 0, 15);
xs1=((1:205)-140)*0.05;
figure;plot(xs1,slice1D_s1)
xlim([-3 0.5])
