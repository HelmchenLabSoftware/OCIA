x=(1:size(cond_1200_ave,3))*0.05-3.05;
for i=1:40
    eval(['load cond_1200_trial',int2str(i)])
    d=reshape(tr,256*256,200);
    figure;
    subplot(2,1,1)
    hold on
    plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,1,'Gauss'),'k')
    plot(x,smooth(squeeze(nanmean(d(roi_s1,:),1))-1,1,'Gauss'),'b')
    plot(x,zeros(1,200),'k')
    xlim([-2.5 7])
    %ylim([-.01 0.15])
    subplot(2,1,2)
    plot(x_env,whisk_env(:,tr_1200(i)))
    xlim([-2.5 7])
    %ylim([-1 2])
end

