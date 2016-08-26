x=(1:size(cond_100_ave_no_whisk,3))*0.05-3;
d=reshape(cond_100_ave_no_whisk,256*256,size(cond_100_ave_no_whisk,3));
figure;plot(x,smooth(squeeze(nanmean(d(roi_s1,:),1)),1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d(roi_s2,:),1)),1,'Gauss'),'c')
plot(x,smooth(squeeze(nanmean(d(roi_m1,:),1)),1,'Gauss'),'r')
plot(x,smooth(squeeze(nanmean(d(roi_a1,:),1)),1,'Gauss'),'g')
plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1)),1,'Gauss'),'k')
plot(x,smooth(squeeze(nanmean(d(roi_alm,:),1)),1,'Gauss'),'m')
%plot(x,smooth(squeeze(nanmean(d(roi_ppc,:),1))-1,1,'Gauss'),'y')
plot(x,zeros(1,size(cond_100_ave,3)),'k')
legend('s1','s2','m1','a1','m2','alm','ppc')

d2=reshape(cond_1200_ave_no_whisk,256*256,size(cond_1200_ave_no_whisk,3));
figure;plot(x,smooth(squeeze(nanmean(d2(roi_s1,:),1)),1,'Gauss'),'--b')
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_s2,:),1)),1,'Gauss'),'--c')
plot(x,smooth(squeeze(nanmean(d2(roi_m1,:),1)),1,'Gauss'),'--r')
plot(x,smooth(squeeze(nanmean(d2(roi_a1,:),1)),1,'Gauss'),'--g')
plot(x,smooth(squeeze(nanmean(d2(roi_m2,:),1)),1,'Gauss'),'--k')
plot(x,smooth(squeeze(nanmean(d2(roi_alm,:),1)),1,'Gauss'),'--m')
plot(x,zeros(1,size(cond_100_ave,3)),'k')
legend('s1','s2','m1','a1','m2','alm')

figure;plot(x,smooth(squeeze(nanmean(d2(roi_s1,:),1))-squeeze(nanmean(d(roi_s1,:),1)),1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_s2,:),1))-squeeze(nanmean(d(roi_s2,:),1)),1,'Gauss'),'c')
plot(x,smooth(squeeze(nanmean(d2(roi_m1,:),1))-squeeze(nanmean(d(roi_m1,:),1)),1,'Gauss'),'r')
plot(x,smooth(squeeze(nanmean(d2(roi_m2,:),1))-squeeze(nanmean(d(roi_m2,:),1)),1,'Gauss'),'k')
plot(x,smooth(squeeze(nanmean(d2(roi_alm,:),1))-squeeze(nanmean(d(roi_alm,:),1)),1,'Gauss'),'m')
plot(x,smooth(squeeze(nanmean(d2(roi_a1,:),1))-squeeze(nanmean(d(roi_a1,:),1)),1,'Gauss'),'g')
plot(x,smooth(squeeze(nanmean(d2(roi_ppc,:),1))-squeeze(nanmean(d(roi_ppc,:),1)),1,'Gauss'),'y')
plot(x,zeros(1,size(cond_100_ave,3)),'k')
legend('s1','s2','m1','m2','alm','a1')

