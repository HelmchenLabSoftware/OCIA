
cd D:\intrinsic\20150520\a\Matt_files
load('whisker_envelope.mat')
load('trials_ind.mat')
figure;errorbar(x_env,nanmean(whisk_env(:,tr_100),2),nanstd(whisk_env(:,tr_100),0,2)/sqrt(size(tr_100,2)))
hold on
errorbar(x_env,nanmean(whisk_env(:,tr_1200),2),nanstd(whisk_env(:,tr_1200),0,2)/sqrt(size(tr_1200,2)))
xlim([-3 6])
ylim([-1 4])


%%

cd D:\intrinsic\20150520\a\Matt_files
load('whisker_envelope.mat')
load('rois_initial_205x205.mat')
load('trials_ind.mat')

x=(1:180)*0.05-2.7;
time_whisk=9:171; % 105:149;  %9:42
time_wf=2:164; %98:142; %2:35 

for i=1:size(tr_100,2)
    disp(i)
    eval(['load cond_100_trial',int2str(i)])
    d=reshape(tr,205*205,180);
    tt=corrcoef(squeeze(nanmean(d(roi_m2,time_wf),1))-1,whisk_env(time_whisk,tr_100(i)));
    whisk_corr_m2_100(i)=tt(1,2);
end
figure;plot(whisk_corr_m2_100)


for i=1:size(tr_1200,2)
    disp(i)
    eval(['load cond_1200_trial',int2str(i)])
    d=reshape(tr,205*205,180);
    tt=corrcoef(squeeze(nanmean(d(roi_m2,time_wf),1))-1,whisk_env(time_whisk,tr_1200(i)));
    whisk_corr_m2_1200(i)=tt(1,2);
end
figure;plot(whisk_corr_m2_1200)

%%
for i=[6 12]
    eval(['load cond_100_trial',int2str(i)])
    d=reshape(tr,205*205,180);
    figure;
    subplot(2,1,1)
    hold on
    plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,1,'Gauss'),'k')
    plot(x,zeros(1,180),'k')
    xlim([-2.5 5.5])
    ylim([-.01 0.15])
    subplot(2,1,2)
    plot(x_env,whisk_env(:,tr_100(i)))
    xlim([-2.5 5.5])
    ylim([-5 15])
    figure(14);subplot(2,1,1)
    plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,1,'Gauss'),'k')
    hold on
    figure(14);subplot(2,1,2)
    plot(x_env,whisk_env(:,tr_100(i)),'b')
    xlim([-2.5 5.5])
    ylim([-5 15])
    hold on
    
end

for i=[4 24]
    eval(['load cond_1200_trial',int2str(i)])
    d=reshape(tr,205*205,180);
    figure;
    subplot(2,1,1)
    hold on
    plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,1,'Gauss'),'k')
    plot(x,zeros(1,180),'k')
    xlim([-2.5 5.5])
    ylim([-.01 0.15])
    subplot(2,1,2)
    plot(x_env,whisk_env(:,tr_1200(i)))
    xlim([-2.5 5.5])
    ylim([-5 15])
    figure(14);subplot(2,1,1)
    plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,1,'Gauss'),'--k')
    hold on
    xlim([-2.5 5.5])
    ylim([-.01 0.15])
    figure(14);subplot(2,1,2)
    plot(x_env,whisk_env(:,tr_100(i)),'--b')
    xlim([-2.5 5.5])
    ylim([-5 15])
end










