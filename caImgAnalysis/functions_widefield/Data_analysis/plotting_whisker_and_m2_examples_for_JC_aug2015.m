
cd D:\intrinsic\20150520\a\Matt_files
load('whisker_envelope.mat')
load('trials_ind.mat')

for i=[6]
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
    
    y=fliplr(smoothn(nanmean(tr(:,:,104:132),3)-1,[5 5],'Gauss')');
    y(isnan(y))=10000;
    figure;imagesc(y,[-1e-2 3e-2]);colormap(mapgeog)
    hold on
    %h=zeros(205*205,1);
    %h(roi_s1)=1;
    %contour(fliplr(reshape(h,205,205)'),'k')
    %line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
    axis square
    axis off
end

for i=[12]
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
    
    y=fliplr(smoothn(nanmean(tr(:,:,104:132),3)-1,[5 5],'Gauss')');
    y(isnan(y))=10000;
    figure;imagesc(y,[-1e-2 5e-2]);colormap(mapgeog)
    hold on
    %h=zeros(205*205,1);
    %h(roi_s1)=1;
    %contour(fliplr(reshape(h,205,205)'),'k')
    %line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
    axis square
    axis off
end

for i=[4]
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
    y=fliplr(smoothn(nanmean(tr(:,:,104:132),3)-1,[5 5],'Gauss')');
    y(isnan(y))=10000;
    figure;imagesc(y,[-1e-2 5e-2]);colormap(mapgeog)
    hold on
    %h=zeros(205*205,1);
    %h(roi_s1)=1;
    %contour(fliplr(reshape(h,205,205)'),'k')
    %line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
    axis square
    axis off
end





for i=[7]%[4 24]
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
    y=fliplr(smoothn(nanmean(tr(:,:,104:132),3)-1,[5 5],'Gauss')');
    y(isnan(y))=10000;
    figure;imagesc(y,[-1e-2 5e-2]);colormap(mapgeog)
    hold on
    %h=zeros(205*205,1);
    %h(roi_s1)=1;
    %contour(fliplr(reshape(h,205,205)'),'k')
    %line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
    axis square
    axis off
end


load('cond_100_ave_clean.mat')
load('cond_1200_ave_clean.mat')
cond_100_ave=reshape(cond_100_ave,205,205,size(cond_100_ave,2));
cond_1200_ave=reshape(cond_1200_ave,205,205,size(cond_1200_ave,2));

y=fliplr(smoothn(nanmean(cond_100_ave(:,:,104:132),3)-1,[5 5],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[-1e-2 4e-2]);colormap(mapgeog)
hold on
%h=zeros(205*205,1);
%h(roi_s1)=1;
%contour(fliplr(reshape(h,205,205)'),'k')
%line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
axis square
axis off


y=fliplr(smoothn(nanmean(cond_1200_ave(:,:,104:132),3)-1,[5 5],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[-1e-2 4e-2]);colormap(mapgeog)
hold on
%h=zeros(205*205,1);
%h(roi_s1)=1;
%contour(fliplr(reshape(h,205,205)'),'k')
%line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
axis square
axis off

load('rois_205x205_v2.mat')


