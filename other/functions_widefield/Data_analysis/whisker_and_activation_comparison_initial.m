cd D:\intrinsic\20150512\mouse_tgg6fl23_4\a\Matt_files
load('whisker_envelope.mat')
load('rois_initial_205x205.mat')
load('trials_ind.mat')
x=(1:180)*0.05-2.7;
for i=1:size(tr_100,2)
    eval(['load cond_100_trial',int2str(i)])
    d=reshape(tr,205*205,180);
    figure;
    subplot(2,1,1)
    plot(x,smooth(squeeze(nanmean(d(roi_s1,:),1))-1,1,'Gauss'))
    hold on
    %plot(x,smooth(squeeze(nanmean(d(roi_s2,:),1))-1,1,'Gauss'),'c')
    %plot(x,smooth(squeeze(nanmean(d(roi_m1,:),1))-1,1,'Gauss'),'r')
    %plot(x,smooth(squeeze(nanmean(d(roi_a1,:),1))-1,1,'Gauss'),'g')
    plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,1,'Gauss'),'k')
    %plot(x,smooth(squeeze(nanmean(d(roi_alm,:),1))-1,1,'Gauss'),'m')
    plot(x,zeros(1,180),'k')
    %legend('s1','s2','m1','a1','m2','alm')
    xlim([-2.5 5.5])
    subplot(2,1,2)
    plot(x_env,whisk_env(:,tr_100(i)))
    xlim([-2.5 5.5])
    ylim([-5 15])
end


%%
load('cond_100_ave.mat')
d=reshape(cond_100_ave,205*205,180);
figure;
subplot(2,1,1)
plot(x,smooth(squeeze(nanmean(d(roi_s1,:),1))-1,1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d(roi_s2,:),1))-1,1,'Gauss'),'c')
plot(x,smooth(squeeze(nanmean(d(roi_m1,:),1))-1,1,'Gauss'),'r')
plot(x,smooth(squeeze(nanmean(d(roi_a1,:),1))-1,1,'Gauss'),'g')
plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,1,'Gauss'),'k')
plot(x,smooth(squeeze(nanmean(d(roi_alm,:),1))-1,1,'Gauss'),'m')
plot(x,zeros(1,180),'k')
legend('s1','s2','m1','a1','m2','alm')
xlim([-3 6])
subplot(2,1,2)
plot(x_env,nanmean(whisk_env,2))
xlim([-3 6])




