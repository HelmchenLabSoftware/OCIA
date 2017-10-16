
load('cond_100_ave_clean.mat')
load('cond_1200_ave_clean.mat')
cond_100_ave=reshape(cond_100_ave,205,205,size(cond_100_ave,2));
cond_1200_ave=reshape(cond_1200_ave,205,205,size(cond_1200_ave,2));
load rois_initial_205x205
h=zeros(205*205,1);
h(roi_s1)=1;
h(roi_s2)=1;
h(roi_m1)=1;
h(roi_m2)=1;
h(roi_a1)=1;
%h(roi_alm)=1;
h(roi_ppc)=1;
%%
p=205;
x=(1:size(cond_100_ave,3))*0.05-2.7;
d=reshape(cond_100_ave,p*p,size(cond_100_ave,3));
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

d2=reshape(cond_1200_ave,p*p,size(cond_1200_ave,3));
figure;plot(x,smooth(squeeze(nanmean(d2(roi_s1,:),1))-1,1,'Gauss'),'--b')
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_s2,:),1))-1,1,'Gauss'),'--c')
plot(x,smooth(squeeze(nanmean(d2(roi_m1,:),1))-1,1,'Gauss'),'--r')
plot(x,smooth(squeeze(nanmean(d2(roi_a1,:),1))-1,1,'Gauss'),'--g')
plot(x,smooth(squeeze(nanmean(d2(roi_m2,:),1))-1,1,'Gauss'),'--k')
%plot(x,smooth(squeeze(nanmean(d2(roi_alm,:),1))-1,1,'Gauss'),'--m')
plot(x,zeros(1,size(cond_100_ave,3)),'k')
legend('s1','s2','m1','a1','m2','alm')

figure;plot(x,smooth(squeeze(nanmean(d(roi_s1,:),1))-squeeze(nanmean(d2(roi_s1,:),1)),1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d(roi_s2,:),1))-squeeze(nanmean(d2(roi_s2,:),1)),1,'Gauss'),'c')
plot(x,smooth(squeeze(nanmean(d(roi_m1,:),1))-squeeze(nanmean(d2(roi_m1,:),1)),1,'Gauss'),'r')
plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-squeeze(nanmean(d2(roi_m2,:),1)),1,'Gauss'),'k')
plot(x,smooth(squeeze(nanmean(d(roi_alm,:),1))-squeeze(nanmean(d2(roi_alm,:),1)),1,'Gauss'),'m')
plot(x,smooth(squeeze(nanmean(d(roi_a1,:),1))-squeeze(nanmean(d2(roi_a1,:),1)),1,'Gauss'),'g')
%plot(x,smooth(squeeze(nanmean(d(roi_ppc,:),1))-squeeze(nanmean(d2(roi_ppc,:),1)),1,'Gauss'),'y')
plot(x,zeros(1,size(cond_100_ave,3)),'k')
legend('s1','s2','m1','m2','alm','a1')

%%


for i=180:-4:1
    figure;imagesc(smoothn(cond_100_ave(:,:,i)-1,[5 5],'Gauss'),[-.5e-2 2e-2]);colormap(mapgeog)
    %hold on
    %contour(reshape(h,205,205),'k')
    %title([int2str(x(i)*1000)])
    title([int2str(i)])
end




for i=180:-1:1
    figure;imagesc(smoothn(cond_1200_ave(:,:,i)-1,[5 5],'Gauss'),[-1e-2 1e-2]);colormap(mapgeog)
    %hold on
    %contour(reshape(h,205,205),'k')
    title([int2str(x(i)*1000)])
    %title([int2str(i)])
end


for i=180:-4:1
    figure;imagesc(smoothn(cond_100_ave(:,:,i)-cond_1200_ave(:,:,i),[5 5],'Gauss'),[-1.5e-2 1.5e-2]);colormap(mapgeog)
    %hold on
    %contour(reshape(h,205,205),'k')
    %title([int2str(x(i)*1000)])
    title([int2str(i)])
end



figure(100);imagesc(smoothn(nanmean(tr(:,:,63:67),3),[5 5],'Gauss')-1,[-1e-2 2.5e-2]);colormap(mapgeog)
roi_s1 = choose_polygon_imagesc(256);
roi_s2 = choose_polygon_imagesc(256);
roi_m1 = choose_polygon_imagesc(256);
roi_m2 = choose_polygon_imagesc(256);
roi_ppc = choose_polygon_imagesc(256);
figure(100);imagesc(smoothn(nanmean(cond_100_ave(:,:,110:120),3),[5 5],'Gauss')-1,[-1.5e-2 1e-2]);colormap(mapgeog)
roi_alm = choose_polygon_imagesc(256);
figure(100);imagesc(smoothn(nanmean(cond_100_ave(:,:,22:25,:),3),[5 5],'Gauss')-1,[-.5e-2 .65e-2]);colormap(mapgeog)
roi_a1 = choose_polygon_imagesc(256);

%%
figure;plot(x,smooth(squeeze(nanmean(d(roi_s1,:),1))-1,1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_s1,:),1))-1,1,'Gauss'),'--b')
plot(x,zeros(1,180),'k')
title('s1')

figure;plot(x,smooth(squeeze(nanmean(d(roi_s2,:),1))-1,1,'Gauss'),'c')
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_s2,:),1))-1,1,'Gauss'),'--c')
plot(x,zeros(1,180),'k')
title('s2')

figure;plot(x,smooth(squeeze(nanmean(d(roi_m1,:),1))-1,1,'Gauss'),'r')
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_m1,:),1))-1,1,'Gauss'),'--r')
plot(x,zeros(1,180),'k')
title('m1')

figure;plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,1,'Gauss'),'k')
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_m2,:),1))-1,1,'Gauss'),'--k')
plot(x,zeros(1,180),'k')
title('m2')


figure;plot(x,smooth(squeeze(nanmean(d(roi_alm,:),1))-1,1,'Gauss'),'m')
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_alm,:),1))-1,1,'Gauss'),'--m')
plot(x,zeros(1,180),'k')
title('alm')

figure;plot(x,smooth(squeeze(nanmean(d(roi_a1,:),1))-1,1,'Gauss'),'g')
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_a1,:),1))-1,1,'Gauss'),'--g')
plot(x,zeros(1,180),'k')
title('a1')




%%

figure;plot(x,smooth(squeeze(nanmean(d(roi_rs,:),1))-1,1,'Gauss'),'k')
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_rs,:),1))-1,1,'Gauss'),'--k')
plot(x,zeros(1,180),'k')

figure;plot(x,smooth(squeeze(nanmean(d(roi_ppc,:),1))-1,1,'Gauss'),'k')
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_ppc,:),1))-1,1,'Gauss'),'--k')
plot(x,zeros(1,180),'k')




figure;imagesc(smoothn(nanmean(cond_100_ave(:,:,110:140)-cond_1200_ave(:,:,110:140),3),[5 5],'Gauss'),[-2e-2 2e-2]);colormap(mapgeog)

figure;imagesc(smoothn(nanmean(cond_1200_ave(:,:,104:140),3)-1,[5 5],'Gauss'),[-0e-2 3e-3]);colormap(mapgeog)
   
figure;imagesc(smoothn(nanmean(cond_100_ave(:,:,104:140),3)-1,[5 5],'Gauss'),[-0e-2 3e-3]);colormap(mapgeog)
 