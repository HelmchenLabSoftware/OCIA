p=205;
x=(1:size(cond_100_ave,3))*0.05-2.7;
d=reshape(cond_100_ave,p*p,size(cond_100_ave,3));
figure;plot(x,smooth(squeeze(nanmean(d(roi_s1,:),1))-1,1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d(roi_s2,:),1))-1,1,'Gauss'),'--b')
plot(x,smooth(squeeze(nanmean(d(roi_ppc,:),1))-1,1,'Gauss'),'c')
plot(x,smooth(squeeze(nanmean(d(roi_m1,:),1))-1,1,'Gauss'),'r')
plot(x,smooth(squeeze(nanmean(d(roi_m2_med,:),1))-1,1,'Gauss'),'--r')
plot(x,smooth(squeeze(nanmean(d(roi_a1,:),1))-1,1,'Gauss'),'g')
plot(x,smooth(squeeze(nanmean(d(roi_sc,:),1))-1,1,'Gauss'),'m')
plot(x,smooth(squeeze(nanmean(d(roi_ic,:),1))-1,1,'Gauss'),'--m')
plot(x,zeros(1,size(cond_100_ave,3)),'k')

d2=reshape(cond_1200_ave,p*p,size(cond_1200_ave,3));
figure;plot(x,smooth(squeeze(nanmean(d2(roi_s1,:),1))-1,1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_s2,:),1))-1,1,'Gauss'),'--b')
plot(x,smooth(squeeze(nanmean(d2(roi_ppc,:),1))-1,1,'Gauss'),'c')
plot(x,smooth(squeeze(nanmean(d2(roi_m1,:),1))-1,1,'Gauss'),'r')
plot(x,smooth(squeeze(nanmean(d2(roi_m2_med,:),1))-1,1,'Gauss'),'--r')
plot(x,smooth(squeeze(nanmean(d2(roi_a1,:),1))-1,1,'Gauss'),'g')
plot(x,smooth(squeeze(nanmean(d2(roi_sc,:),1))-1,1,'Gauss'),'m')
plot(x,smooth(squeeze(nanmean(d2(roi_ic,:),1))-1,1,'Gauss'),'--m')
plot(x,zeros(1,size(cond_100_ave,3)),'k')

figure;plot(x,smooth(squeeze(nanmean(d(roi_s1,:),1))-squeeze(nanmean(d2(roi_s1,:),1)),1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d(roi_s2,:),1))-squeeze(nanmean(d2(roi_s2,:),1)),1,'Gauss'),'--b')
plot(x,smooth(squeeze(nanmean(d(roi_ppc,:),1))-squeeze(nanmean(d2(roi_ppc,:),1)),1,'Gauss'),'c')
plot(x,smooth(squeeze(nanmean(d(roi_m1,:),1))-squeeze(nanmean(d2(roi_m1,:),1)),1,'Gauss'),'r')
plot(x,smooth(squeeze(nanmean(d(roi_m2_med,:),1))-squeeze(nanmean(d2(roi_m2_med,:),1)),1,'Gauss'),'--r')
plot(x,smooth(squeeze(nanmean(d(roi_a1,:),1))-squeeze(nanmean(d2(roi_a1,:),1)),1,'Gauss'),'g')
plot(x,smooth(squeeze(nanmean(d(roi_sc,:),1))-squeeze(nanmean(d2(roi_sc,:),1)),1,'Gauss'),'m')
plot(x,smooth(squeeze(nanmean(d(roi_ic,:),1))-squeeze(nanmean(d2(roi_ic,:),1)),1,'Gauss'),'--m')
plot(x,zeros(1,size(cond_100_ave,3)),'k')


%%

d3=reshape(AUC_map_time,p*p,size(cond_1200_ave,3));
figure;plot(x,smooth(squeeze(nanmean(d3(roi_s1,:),1)),1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d3(roi_s2,:),1)),1,'Gauss'),'--b')
plot(x,smooth(squeeze(nanmean(d3(roi_ppc,:),1)),1,'Gauss'),'c')
plot(x,smooth(squeeze(nanmean(d3(roi_m1,:),1)),1,'Gauss'),'r')
plot(x,smooth(squeeze(nanmean(d3(roi_m2_med,:),1)),1,'Gauss'),'--r')
plot(x,smooth(squeeze(nanmean(d3(roi_a1,:),1)),1,'Gauss'),'g')
plot(x,smooth(squeeze(nanmean(d3(roi_sc,:),1)),1,'Gauss'),'m')
plot(x,smooth(squeeze(nanmean(d3(roi_ic,:),1)),1,'Gauss'),'--m')
plot(x,0.5+zeros(1,size(cond_100_ave,3)),'k')




%%

p=205;
d=reshape(amp_trig_ave,p*p,size(amp_trig_ave,3));
figure;plot(smooth(squeeze(nanmean(d(roi_s1,:),1))-1,1,'Gauss'))
hold on
plot(smooth(squeeze(nanmean(d(roi_s2,:),1))-1,1,'Gauss'),'--b')
plot(smooth(squeeze(nanmean(d(roi_ppc,:),1))-1,1,'Gauss'),'c')
plot(smooth(squeeze(nanmean(d(roi_m1,:),1))-1,1,'Gauss'),'r')
plot(smooth(squeeze(nanmean(d(roi_m2_med,:),1))-1,1,'Gauss'),'--r')
plot(smooth(squeeze(nanmean(d(roi_a1,:),1))-1,1,'Gauss'),'g')
plot(smooth(squeeze(nanmean(d(roi_sc,:),1))-1,1,'Gauss'),'m')
plot(smooth(squeeze(nanmean(d(roi_ic,:),1))-1,1,'Gauss'),'--m')
plot(zeros(1,size(d,2)),'k')





