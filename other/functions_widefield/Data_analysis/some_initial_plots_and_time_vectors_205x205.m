


for i=180:-5:1
    figure;imagesc(smoothn(nanmean(cond_CR_ave(:,:,i),3)-1,[5 5],'Gauss'),[-3e-2 1e-2]);colormap(mapgeog)
    %hold on
    %contour(reshape(h,2048,2048),'k')
    %title([int2str(x(i)*1000)])
    title([int2str(i)])
end



figure(100);imagesc(smoothn(nanmean(t(:,:,100:120),3)-1,[5 5],'Gauss'),[-.5e-2 1.5e-2]);colormap(mapgeog)
roi_s1 = choose_polygon_imagesc(256);
roi_m2 = choose_polygon_imagesc(205);
roi_a1 = choose_polygon_imagesc(256);
roi_s2 = choose_polygon_imagesc(205);


d=reshape(tr,256*256,220);
figure;plot(smooth(squeeze(nanmean(d(roi_s1,:),1))-1,1,'Gauss'))
hold on
plot(smooth(squeeze(nanmean(d(roi_s2,:),1))-1,1,'Gauss'),'c')
plot(smooth(squeeze(nanmean(d(roi_m2,:),1))-1,1,'Gauss'),'k')
plot(smooth(squeeze(nanmean(d(roi_a1,:),1))-1,1,'Gauss'),'g')

figure;imagesc(smoothn(nanmean(tr(:,:,100:140)-1,3),[5 5],'Gauss'),[-1e-2 1e-2]);colormap(mapgeog)

figure;imagesc(smoothn(nanmean(tr(:,:,104:150)-cond_1200_ave(:,:,104:150),3),[5 5],'Gauss'),[-1e-2 1e-2]);colormap(mapgeog)


d2=reshape(cond_100_ave,256*256,220);
figure;plot(smooth(squeeze(nanmean(d(roi_s1,:),1))-squeeze(nanmean(d2(roi_s1,:),1)),1,'Gauss'))
hold on
plot(smooth(squeeze(nanmean(d(roi_s2,:),1))-squeeze(nanmean(d2(roi_s1,:),1)),1,'Gauss'),'c')
plot(smooth(squeeze(nanmean(d(roi_m2,:),1))-squeeze(nanmean(d2(roi_s1,:),1)),1,'Gauss'),'k')
plot(smooth(squeeze(nanmean(d(roi_a1,:),1))-squeeze(nanmean(d2(roi_s1,:),1)),1,'Gauss'),'g')
plot(smooth(squeeze(nanmean(d(roi_alm,:),1))-squeeze(nanmean(d2(roi_alm,:),1)),1,'Gauss'),'m')

for i=180:-4:1
    figure;imagesc(smoothn(nanmean(tr(:,:,i),3)-nanmean(cond_1200_ave(:,:,i),3),[5 5],'Gauss'),[-1e-2 1.5e-2]);colormap(mapgeog)
    %hold on
    %contour(reshape(h,2048,2048),'k')
    %title([int2str(x(i)*1000)])
    title([int2str(i)])
end



for i=1:20
    load(['stim_trial',int2str(i),'.mat'])
    d=reshape(tr,256*256,180);
    figure;plot(smooth(squeeze(nanmean(d(roi_s1,:),1))-1,5,'Gauss'))
    title(int2str(i))
end


for i=1:50
    load(['stim_trial',int2str(i),'.mat'])
    figure;imagesc(smoothn(nanmean(tr(:,:,15:30),3)-1,[11 11],'Gauss'),[-.5e-3 1.5e-3]);colormap(mapgeog)
    title(int2str(i))
end



figure;imagesc(smoothn(nanmean(tr(:,:,120:160),3)-1,[5 5],'Gauss')...
    ,[-20e-4 2e-2]);colormap(mapgeog)

k=0;
for i=[7 8 9 12 15 16 17 21 23 29 31 34 38 43 44 46 48]
    k=k+1;
    load(['stim_trial',int2str(i),'.mat'])
    t(:,:,k)=smoothn(nanmean(tr(:,:,15:30),3)-1,[11 11],'Gauss');
    d=reshape(tr,256*256,80);
    tt(:,k)=smooth(squeeze(nanmean(d(roi_s1,:),1))-1,5,'Gauss');
    ttt(:,:,:,k)=tr;
end
figure;plot(x,nanmean(tt,2))
figure;imagesc(nanmean(t(:,:,:),3),[-.5e-3 1.5e-3]);colormap(mapgeog)

figure;imagesc(smoothn(nanmean(nanmean(ttt(:,:,15:30,:),3),4)-1,[11 11],'Gauss'),[-.5e-3 1.5e-3]);colormap(mapgeog)


for i=50:-1:1
    figure;imagesc(smoothn(nanmean(ttt(:,:,i,:),4)-1,[11 11],'Gauss'),[-1e-3 1.5e-3]);colormap(mapgeog)
    %hold on
    %contour(reshape(h,2048,2048),'k')
    %title([int2str(x(i)*1000)])
    title([int2str(i)])
end


figure;imagesc(smoothn(nanmean(tr(:,:,100:130)-1,3),[5 5],'Gauss'),[-5e-2 1e-2]);colormap(mapgeog)

figure;imagesc(smoothn(nanmean(tr(:,:,100:140)-cond_100_ave(:,:,100:140),3),[5 5],'Gauss'),[-1e-2 3e-2]);colormap(mapgeog)






for i=180:-4:1
    figure;imagesc(smoothn(nanmean(tr(:,:,i)-1,3),[5 5],'Gauss'),[-.5e-2 1.5e-2]);colormap(mapgeog)
    %hold on
    %contour(reshape(h,2048,2048),'k')
    %title([int2str(x(i)*1000)])
    title([int2str(i)])
end


for i=1:20
    load (['cond_1200_trial',int2str(i)])
    d=reshape(tr,256*256,200);
    figure;plot(smooth(squeeze(nanmean(d(roi_m2,:),1))-1,1,'Gauss'),'k')
end


%%
for i=[8, 10, 19, 20, 31, 39, 41 ];
    load(['stim_trial',int2str(i), '.mat'])
%     load (['cond_100_trial',int2str(i)])
%     %%
    d=reshape(tr,256*256,200);
    figure('Position', [405   596   969   420]);
    
    subplot(1,2,1);plot(smooth(squeeze(nanmean(d(roi_m2,:),1))-1,1,'Gauss'),'k')
    hold on
    plot(smooth(squeeze(nanmean(d(roi_alm,:),1))-1,1,'Gauss'),'m')
    plot(smooth(squeeze(nanmean(d(roi_s1,:),1))-1,1,'Gauss'),'b')
    plot(smooth(squeeze(nanmean(d(roi_a1,:),1))-1,1,'Gauss'),'g')
    subplot(1,2,2);imagesc(smoothn(nanmean(tr(:,:,104:130)-1,3),[5 5],'Gauss'),[-1e-2 1e-2]);colormap(mapgeog)
end

%%
%2710a
[1 3 5 9 11 12 14 17 18 20 21 23 25 26 27 29 30 32 33 37 38 43 48 53 54 56]

k=0;
for i=[2 8 19 24 30 31 33 40 41 55 56]
    k=k+1;
    disp(k)
    load (['cond_1200_trial',int2str(i)])
    if k==1
        t=tr;
    else
        t=t+tr;
    end
end
t=t/k;


d=reshape(t,256*256,200);
d=reshape(tt,256*256,200);


figure;plot(smooth(squeeze(nanmean(d(roi_s1,:),1))-1,1,'Gauss'))
hold on
plot(smooth(squeeze(nanmean(d(roi_s2,:),1))-1,1,'Gauss'),'c')
plot(smooth(squeeze(nanmean(d(roi_m2,:),1))-1,1,'Gauss'),'k')
plot(smooth(squeeze(nanmean(d(roi_a1,:),1))-1,1,'Gauss'),'g')

figure;imagesc(smoothn(nanmean(t(:,:,100:140)-1,3),[5 5],'Gauss'),[-1e-2 1e-2]);colormap(mapgeog)

figure;imagesc(smoothn(nanmean(t(:,:,104:140)-cond_100_ave(:,:,104:140),3),[5 5],'Gauss'),[-1e-2 1e-2]);colormap(mapgeog)


d2=reshape(cond_100_ave,256*256,180);
figure;plot(smooth(squeeze(nanmean(d(roi_s1,:),1))-squeeze(nanmean(d2(roi_s1,:),1)),1,'Gauss'))
hold on
plot(smooth(squeeze(nanmean(d(roi_s2,:),1))-squeeze(nanmean(d2(roi_s1,:),1)),1,'Gauss'),'c')
plot(smooth(squeeze(nanmean(d(roi_m2,:),1))-squeeze(nanmean(d2(roi_s1,:),1)),1,'Gauss'),'k')
plot(smooth(squeeze(nanmean(d(roi_a1,:),1))-squeeze(nanmean(d2(roi_s1,:),1)),1,'Gauss'),'g')
plot(smooth(squeeze(nanmean(d(roi_alm,:),1))-squeeze(nanmean(d2(roi_alm,:),1)),1,'Gauss'),'m')


for i=180:-4:1
    figure;imagesc(smoothn(nanmean(t(:,:,i),3)-nanmean(cond_100_ave(:,:,i),3),[5 5],'Gauss'),[-1e-2 1e-2]);colormap(mapgeog)
    %hold on
    %contour(reshape(h,2048,2048),'k')
    %title([int2str(x(i)*1000)])
    title([int2str(i)])
end


