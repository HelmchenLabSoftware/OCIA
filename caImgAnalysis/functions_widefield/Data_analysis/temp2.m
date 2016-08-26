time=100:140;
figure;imagesc(smoothn(nanmean(cond_1200_ave_no_whisk(:,:,time),3),[5 5],'Gauss'),[-1.7e-2 .7e-2]);colormap(mapgeog)
figure;imagesc(smoothn(nanmean(cond_100_ave_no_whisk(:,:,time),3),[5 5],'Gauss'),[-1.7e-2 .7e-2]);colormap(mapgeog)

figure;imagesc(smoothn(nanmean(cond_1200_ave_no_whisk(:,:,time)-cond_100_ave_no_whisk(:,:,time),3),[5 5],'Gauss'),[-1e-2 1e-2]);colormap(mapgeog)


pix=size(cond_1200_ave_no_whisk,1);
x=(1:size(cond_100_ave_no_whisk,3))*0.05-3.05;
d=reshape(cond_100_ave_no_whisk,pix*pix,size(cond_100_ave_no_whisk,3));
d2=reshape(cond_1200_ave_no_whisk,pix*pix,size(cond_1200_ave_no_whisk,3));

figure;plot(x,smooth(squeeze(nanmean(d(roi_s1,:),1)),1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_s1,:),1)),1,'Gauss'),'--b')
plot(x,zeros(1,size(cond_100_ave_no_whisk,3)),'k')

figure;plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1)),1,'Gauss'),'k')
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_m2,:),1)),1,'Gauss'),'--k')
plot(x,zeros(1,size(cond_100_ave_no_whisk,3)),'k')




figure;plot(x,smooth(squeeze(nanmean(d2(roi_s1,:)-d(roi_s1,:),1)),1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_m2,:)-d(roi_m2,:),1)),1,'Gauss'),'k')
plot(x,zeros(1,size(cond_100_ave_no_whisk,3)),'k')
plot(x,smooth(squeeze(nanmean(d2(roi_a1,:)-d(roi_a1,:),1)),1,'Gauss'),'g')
plot(x,smooth(squeeze(nanmean(d2(roi_s2,:)-d(roi_s2,:),1)),1,'Gauss'),'c')



load('trials_ind.mat')
load('whisker_envelope.mat')
figure;errorbar(x_env,nanmean(whisk_env(:,tr_100),2),nanstd(whisk_env(:,tr_100),0,2)/sqrt(size(tr_100,2)))
hold on
errorbar(x_env,nanmean(whisk_env(:,tr_1200),2),nanstd(whisk_env(:,tr_1200),0,2)/sqrt(size(tr_1200,2)))
xlim([-3 8])
ylim([-1 5])




