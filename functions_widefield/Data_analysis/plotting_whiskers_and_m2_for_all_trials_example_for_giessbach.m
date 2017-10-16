for i=1:31
    eval(['load cond_100_trial',int2str(i)])
    d=reshape(tr,205*205,180);
    figure;
    subplot(2,1,1)
    hold on
    plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,1,'Gauss'),'b')
    plot(x,zeros(1,180),'k')
    xlim([2 4])
    ylim([-.01 0.15])
    subplot(2,1,2)
    plot(x_env,whisk_env(:,tr_100(i)),'b')
    xlim([2 4])
    ylim([-5 15])
    figure(144);subplot(2,1,1)
    plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,1,'Gauss'),'b')
    hold on
    xlim([2 4])
    figure(144);subplot(2,1,2)
    plot(x_env,whisk_env(:,tr_100(i)),'b')
    xlim([2 4])
    ylim([-5 15])
    hold on
    
end

for i=1:36
    eval(['load cond_1200_trial',int2str(i)])
    d=reshape(tr,205*205,180);
    figure;
    subplot(2,1,1)
    hold on
    plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,1,'Gauss'),'r')
    plot(x,zeros(1,180),'k')
    xlim([2 4])
    ylim([-.01 0.15])
    subplot(2,1,2)
    plot(x_env,whisk_env(:,tr_1200(i)),'r')
    xlim([2 4])
    ylim([-5 15])
    figure(144);subplot(2,1,1)
    plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,1,'Gauss'),'r')
    hold on
    xlim([2 4])
    figure(144);subplot(2,1,2)
    plot(x_env,whisk_env(:,tr_1200(i)),'r')
    xlim([2 4])
    ylim([-5 15])
    hold on    
end

