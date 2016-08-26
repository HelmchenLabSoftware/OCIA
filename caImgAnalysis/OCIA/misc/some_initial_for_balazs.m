%%
for i=1:29;
    load (['cond_hit_trial',int2str(i)])
    d=reshape(tr,size(tr,2)*size(tr,2),size(tr,3));
    figure('Position',[100 50 1100 400]);
    title([int2str(i)])
    subplot(1,2,1);plot(smooth(squeeze(nanmean(d(roi_M2,:),1))-1,1,'Gauss'),'k')
    hold on
    plot(smooth(squeeze(nanmean(d(roi_A1,:),1))-1,1,'Gauss'),'g')
    plot(smooth(squeeze(nanmean(d(roi_V1,:),1))-1,1,'Gauss'),'b')
    plot(smooth(squeeze(nanmean(d(roi_S1FL,:),1))-1,1,'Gauss'),'r')
    plot(zeros(1,size(tr,3)),'k')
    ylim([-0.03 0.15])
    title([int2str(i)])
    
    subplot(1,2,2);
    subplot('Position',[0.5 0.1 .5 1]) 
    imagesc(smoothn(nanmean(tr(:,:,104:124)-1,3),[5 5],'Gauss'),[-1e-2 1e-2]);colormap(mapgeog)
    hold on;
    h=zeros(256*256,1);
    h(roi_A1)=1;
    contour(reshape(h,256,256),'g');
    
    h=zeros(256*256,1);
    h(roi_V1)=1;
    contour(reshape(h,256,256),'b');
    
    h=zeros(256*256,1);
    h(roi_S1FL)=1;
    contour(reshape(h,256,256),'r');
    
    h=zeros(256*256,1);
    h(roi_M2)=1;
    contour(reshape(h,256,256),'k');
end

%%
for i=1:39
    load (['cond_CR_trial',int2str(i)])
    d=reshape(tr,size(tr,2)*size(tr,2),size(tr,3));
    figure('Position',[100 50 1100 400]);
    title([int2str(i)])
    subplot(1,2,1);plot(smooth(squeeze(nanmean(d(roi_M2,:),1))-1,1,'Gauss'),'k')
    hold on
    plot(smooth(squeeze(nanmean(d(roi_A1,:),1))-1,1,'Gauss'),'g')
    plot(smooth(squeeze(nanmean(d(roi_V1,:),1))-1,1,'Gauss'),'b')
    plot(smooth(squeeze(nanmean(d(roi_S1FL,:),1))-1,1,'Gauss'),'r')
    plot(zeros(1,size(tr,3)),'k')
    ylim([-0.03 0.15])
    title([int2str(i)])
    subplot(1,2,2);
    subplot('Position',[0.5 0.1 .5 1]) 
    imagesc(smoothn(nanmean(tr(:,:,104:124)-1,3),[5 5],'Gauss'),[-1e-2 1e-2]);colormap(mapgeog)
    
end



%%
fixedStartFrame = max(stimStartFrame);
k=0;
% for i=[3 10 17 18 27]
for i=1:29;
    k=k+1;
    disp(k)
    stimStartFrameTrial = stimStartFrame(tr_hit(i));
    nFramesDiff = fixedStartFrame - stimStartFrameTrial;
    
    load(['cond_hit_trial',int2str(i)])
    nFrames = size(tr, 3);
    if nFramesDiff > 0;
        tr = cat(3, nan(size(tr, 1), size(tr, 2), nFramesDiff), tr(:, :, 1 : (end - nFramesDiff)));
    elseif nFramesDiff < 0;
        tr = cat(3, tr(:, :, (nFramesDiff + 1) : end), nan(size(tr, 1), size(tr, 2), nFramesDiff));
    end;
    if k==1
        tt=tr;
    else
        tt=tt+tr;
    end
end
tt=tt/k;
cond_hit_avg = tt;

%%
d3 = reshape(cond_hit_avg, size(cond_hit_avg,2) * size(cond_hit_avg, 2), size(cond_hit_avg, 3));
figure;plot(smooth(squeeze(nanmean(d3(roi_V1,:),1))-1,1,'Gauss'),'--b')
hold on
%plot(smooth(squeeze(nanmean(d3(roi_s2,:),1))-1,1,'Gauss'),'--c')
plot(smooth(squeeze(nanmean(d3(roi_M2,:),1))-1,1,'Gauss'),'--k')
plot(smooth(squeeze(nanmean(d3(roi_A1,:),1))-1,1,'Gauss'),'--g')
plot(smooth(squeeze(nanmean(d3(roi_S1FL,:),1))-1,1,'Gauss'),'--r')
%%
figure;imagesc(smoothn(nanmean(tt_corr(:,:,60:65)-1,3),[5 5],'Gauss'),[-7e-3 -3e-3]);colormap(mapgeog)
figure;imagesc(smoothn(nanmean(tt_uncorr(:,:,60:65)-1,3),[5 5],'Gauss'),[-7e-3 -3e-3]);colormap(mapgeog)

%%
k=0;
for i=[2 5 6 7 8 12 14 20 25 26]
    k=k+1;
    disp(k)
    load(['cond_CR_trial',int2str(i)])
    if k==1
        t=tr;
    else
        t=t+tr;
    end
end
t=t/k;

%%
d3=reshape(t,size(t,2)*size(t,2),size(t,3));
figure;plot(smooth(squeeze(nanmean(d3(roi_V1,:),1))-1,1,'Gauss'),'b')
hold on
%plot(smooth(squeeze(nanmean(d3(roi_s2,:),1))-1,1,'Gauss'),'--c')
plot(smooth(squeeze(nanmean(d3(roi_M2,:),1))-1,1,'Gauss'),'k')
plot(smooth(squeeze(nanmean(d3(roi_A1,:),1))-1,1,'Gauss'),'g')
plot(smooth(squeeze(nanmean(d3(roi_S1FL,:),1))-1,1,'Gauss'),'r')

%%
figure;imagesc(smoothn(nanmean(tt(:,:,60:65)-1,3),[5 5],'Gauss'),[-3e-3 -5e-3]);colormap(mapgeog)
figure;imagesc(smoothn(nanmean(t(:,:,104:120)-1,3),[5 5],'Gauss'),[-1e-2 1e-2]);colormap(mapgeog)

figure(100);imagesc(smoothn(nanmean(tt(:,:,104:120)-t(:,:,104:120),3),[5 5],'Gauss'),[-1e-2 1e-2]);colormap(mapgeog)




