

load('rois_initial_205x205.mat')
x=(1:180)*0.05-2.7;
d=reshape(tr,205*205,180);
figure;plot(x,smooth(squeeze(nanmean(d(roi_s1,:),1))-1,1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d(roi_s2,:),1))-1,1,'Gauss'),'c')
plot(x,smooth(squeeze(nanmean(d(roi_m1,:),1))-1,1,'Gauss'),'r')
plot(x,smooth(squeeze(nanmean(d(roi_a1,:),1))-1,1,'Gauss'),'g')
plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,1,'Gauss'),'k')
plot(x,smooth(squeeze(nanmean(d(roi_alm,:),1))-1,1,'Gauss'),'m')
plot(x,smooth(squeeze(nanmean(d(roi_ppc,:),1))-1,1,'Gauss'),'y')
plot(x,zeros(1,180),'k')
legend('s1','s2','m1','a1','m2','alm')

d2=reshape(cond_1200_ave,205*205,180);
figure;plot(x,smooth(squeeze(nanmean(d(roi_s1,:),1))-squeeze(nanmean(d2(roi_s1,:),1)),1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d(roi_s2,:),1))-squeeze(nanmean(d2(roi_s2,:),1)),1,'Gauss'),'c')
plot(x,smooth(squeeze(nanmean(d(roi_m1,:),1))-squeeze(nanmean(d2(roi_m1,:),1)),1,'Gauss'),'r')
plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-squeeze(nanmean(d2(roi_m2,:),1)),1,'Gauss'),'k')
plot(x,smooth(squeeze(nanmean(d(roi_alm,:),1))-squeeze(nanmean(d2(roi_alm,:),1)),1,'Gauss'),'m')
plot(x,smooth(squeeze(nanmean(d(roi_a1,:),1))-squeeze(nanmean(d2(roi_a1,:),1)),1,'Gauss'),'g')
plot(x,smooth(squeeze(nanmean(d(roi_ppc,:),1))-squeeze(nanmean(d2(roi_ppc,:),1)),1,'Gauss'),'y')
plot(x,zeros(1,180),'k')
legend('s1','s2','m1','m2','alm','a1')


%%

for i=180:-4:1
    figure;imagesc(smoothn(nanmean(tr(:,:,i),3)-1,[7 7],'Gauss'),[-1e-2 2e-2]);colormap(mapgeog)
    %hold on
    %contour(reshape(h,2048,2048),'k')
    title([int2str(x(i)*1000)])
    %title([int2str(i)])
end
