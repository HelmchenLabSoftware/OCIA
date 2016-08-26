
load('cond_100_ave_clean.mat')
load('cond_1200_ave_clean.mat')
cond_100_ave=reshape(cond_100_ave,256,256,size(cond_100_ave,2));
cond_1200_ave=reshape(cond_1200_ave,256,256,size(cond_1200_ave,2));
load rois_initial_205x205
h=zeros(256*256,1);
h(roi_s1)=1;
h(roi_s2)=1;
h(roi_m1)=1;
h(roi_m2)=1;
h(roi_a1)=1;
h(roi_alm)=1;
h(roi_ppc)=1;
%%
x=(1:size(cond_100_ave,3))*0.05-3.05;
d=reshape(cond_100_ave,256*256,size(cond_100_ave,3));
figure;plot(x,smooth(squeeze(nanmean(d(roi_s1,:),1))-1,1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d(roi_s2,:),1))-1,1,'Gauss'),'c')
plot(x,smooth(squeeze(nanmean(d(roi_m1,:),1))-1,1,'Gauss'),'r')
plot(x,smooth(squeeze(nanmean(d(roi_a1,:),1))-1,1,'Gauss'),'g')
plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,1,'Gauss'),'k')
plot(x,smooth(squeeze(nanmean(d(roi_alm,:),1))-1,1,'Gauss'),'m')
plot(x,smooth(squeeze(nanmean(d(roi_ppc,:),1))-1,1,'Gauss'),'y')
plot(x,zeros(1,size(cond_100_ave,3)),'k')
legend('s1','s2','m1','a1','m2','alm','ppc')

d2=reshape(cond_1200_ave,256*256,size(cond_1200_ave,3));
figure;plot(x,smooth(squeeze(nanmean(d2(roi_s1,:),1))-1,1,'Gauss'),'--b')
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_s2,:),1))-1,1,'Gauss'),'--c')
plot(x,smooth(squeeze(nanmean(d2(roi_m1,:),1))-1,1,'Gauss'),'--r')
plot(x,smooth(squeeze(nanmean(d2(roi_a1,:),1))-1,1,'Gauss'),'--g')
plot(x,smooth(squeeze(nanmean(d2(roi_m2,:),1))-1,1,'Gauss'),'--k')
plot(x,smooth(squeeze(nanmean(d2(roi_alm,:),1))-1,1,'Gauss'),'--m')
plot(x,smooth(squeeze(nanmean(d2(roi_ppc,:),1))-1,1,'Gauss'),'--y')
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






%%

for i=70:-5:1
    figure;imagesc(smoothn(cond_100_ave(:,:,i)-1,[5 5],'Gauss'),[-1e-2 2e-2]);colormap(mapgeog)
    %hold on
    %contour(reshape(h,256,256),'k')
    %title([int2str(x(i)*1000)])
    title([int2str(i)])
end




for i=70:-1:40
    figure;imagesc(smoothn(cond_1200_ave(:,:,i)-1,[5 5],'Gauss'),[-1e-2 1e-2]);colormap(mapgeog)
    %hold on
    %contour(reshape(h,205,205),'k')
    %title([int2str(x(i)*1000)])
    title([int2str(i)])
end


for i=180:-5:1
    figure;imagesc(smoothn(cond_1200_ave(:,:,i)-cond_100_ave(:,:,i),[5 5],'Gauss'),[-1e-2 5e-2]);colormap(mapgeog)
    %hold on
    %contour(reshape(h,205,205),'k')
    title([int2str(x(i)*1000)])
    %title([int2str(i)])
end



figure(100);imagesc(smoothn(nanmean(cond_1200_ave(:,:,55:65),3),[5 5],'Gauss')-1,[-1e-2 .7e-2]);colormap(mapgeog)
roi_s1 = choose_polygon_imagesc(256);
roi_s2 = choose_polygon_imagesc(256);
roi_m1 = choose_polygon_imagesc(256);
roi_m2 = choose_polygon_imagesc(256);
roi_ppc = choose_polygon_imagesc(256);
figure(100);imagesc(smoothn(nanmean(cond_1200_ave(:,:,140:160),3),[5 5],'Gauss')-1,[-1.5e-2 1.5e-2]);colormap(mapgeog)
roi_alm = choose_polygon_imagesc(256);
figure(100);imagesc(smoothn(nanmean(cond_1200_ave(:,:,22:25,:),3),[5 5],'Gauss')-1,[-.5e-2 .5e-2]);colormap(mapgeog)
roi_a1 = choose_polygon_imagesc(256);






figure(100);imagesc(smoothn(nanmean(cond_1200_ave(:,:,104:160)-cond_100_ave(:,:,104:160),3),[5 5],'Gauss'),[-1e-2 1e-2]);colormap(mapgeog)


figure;imagesc(smoothn(nanmean(cond_1200_ave(:,:,149),3)-1,[5 5],'Gauss'),[-2e-3 2e-3]);colormap(mapgeog)
figure;imagesc(smoothn(nanmean(cond_100_ave(:,:,149),3)-1,[5 5],'Gauss'),[-2e-3 2e-3]);colormap(mapgeog)










