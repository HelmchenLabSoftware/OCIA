
x=(1:180)*0.05-2.7;
x=x(1:3:180);

load rois_initial
h=zeros(2048*2048,1);
h(roi_s1)=1;
h(roi_s2)=1;
h(roi_m1)=1;
h(roi_m2)=1;
h(roi_a1)=1;
h(roi_alm)=1;

for i=60:-1:1
    figure;imagesc(smoothn(nanmean(ave_100(:,:,i),3)-1,[41 41],'Gauss'),[-0.9e-2 3e-2]);colormap(mapgeog)
    %hold on
    %contour(reshape(h,2048,2048),'k')
    %title([int2str(x(i)*1000)])
    title([int2str(i)])
end

for i=60:-1:1
    figure;imagesc(smoothn(nanmean(ave_1200(:,:,i),3)-1,[41 41],'Gauss'),[-0.9e-2 3e-2]);colormap(mapgeog)
    %hold on
    %contour(reshape(h,2048,2048),'k')
    %title([int2str(x(i)*1000)])
    title([int2str(i)])
end

figure(100);imagesc(smoothn(nanmean(ave_100(:,:,17),3),[53 53],'Gauss')-1,[-.5e-2 3e-2]);colormap(mapgeog)
roi_s1 = choose_polygon_imagesc(2048);
roi_s2 = choose_polygon_imagesc(2048);
roi_m1 = choose_polygon_imagesc(2048);
roi_m2 = choose_polygon_imagesc(2048);
figure(100);imagesc(smoothn(nanmean(ave_100(:,:,7:9),3),[53 53],'Gauss')-1,[-.5e-2 .5e-2]);colormap(mapgeog)
roi_a1 = choose_polygon_imagesc(2048);
figure(100);imagesc(smoothn(nanmean(ave_100(:,:,41),3),[53 53],'Gauss')-1,[-1e-2 2e-2]);colormap(mapgeog)
roi_alm = choose_polygon_imagesc(2048);


d=reshape(ave_100,2048*2048,60);
figure;plot(x,smooth(squeeze(nanmean(d(roi_s1,:),1))-1,1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d(roi_s2,:),1))-1,1,'Gauss'),'r')
plot(x,smooth(squeeze(nanmean(d(roi_m1,:),1))-1,1,'Gauss'),'g')
plot(x,smooth(squeeze(nanmean(d(roi_a1,:),1))-1,1,'Gauss'),'c')

d2=reshape(ave_1200,2048*2048,60);
figure;plot(x,smooth(squeeze(nanmean(d2(roi_s1,:),1))-1,1,'Gauss'),'--b')
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_s2,:),1))-1,1,'Gauss'),'--r')
plot(x,smooth(squeeze(nanmean(d2(roi_m1,:),1))-1,1,'Gauss'),'--g')
plot(x,smooth(squeeze(nanmean(d2(roi_a1,:),1))-1,1,'Gauss'),'--c')


figure;plot(x,smooth(squeeze(nanmean(d(roi_alm,:),1))-1,1,'Gauss'),'k')
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_alm,:),1))-1,1,'Gauss'),'--k')





figure;plot(x,smooth(squeeze(nanmean(d(roi_s1,:),1))-squeeze(nanmean(d2(roi_s1,:),1)),1,'Gauss'),'b')
hold on
plot(x,smooth(squeeze(nanmean(d(roi_s2,:),1))-squeeze(nanmean(d2(roi_s2,:),1)),1,'Gauss'),'r')
plot(x,smooth(squeeze(nanmean(d(roi_m1,:),1))-squeeze(nanmean(d2(roi_m1,:),1)),1,'Gauss'),'g')
plot(x,smooth(squeeze(nanmean(d(roi_a1,:),1))-squeeze(nanmean(d2(roi_a1,:),1)),1,'Gauss'),'c')
plot(x,smooth(squeeze(nanmean(d(roi_alm,:),1))-squeeze(nanmean(d2(roi_alm,:),1)),1,'Gauss'),'k')

for i=60:-1:1
    figure;imagesc(smoothn(nanmean(ave_100(:,:,i),3)-nanmean(ave_1200(:,:,i),3),[41 41],'Gauss'),[-0e-2 3.5e-2]);colormap(mapgeog)
    hold on
    %contour(reshape(h,2048,2048),'k')
    %title([int2str(x(i)*1000)])
    title([int2str(i)])
end



figure;plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-1,1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_m2,:),1))-1,1,'Gauss'),'c')

figure;plot(x,smooth(squeeze(nanmean(d(roi_rs,:),1))-1,1,'Gauss'),'r')
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_rs,:),1))-1,1,'Gauss'),'m')

figure;plot(x,smooth(squeeze(nanmean(d(roi_s1,:),1))-1,1,'Gauss'),'b')
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_s1,:),1))-1,1,'Gauss'),'c')

figure;plot(x,smooth(squeeze(nanmean(d(roi_s2,:),1))-1,1,'Gauss'),'r')
hold on
plot(x,smooth(squeeze(nanmean(d2(roi_s2,:),1))-1,1,'Gauss'),'m')

figure;plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1))-squeeze(nanmean(d2(roi_m2,:),1)),1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d(roi_alm,:),1))-squeeze(nanmean(d2(roi_alm,:),1)),1,'Gauss'),'g')
plot(x,smooth(squeeze(nanmean(d(roi_m1,:),1))-squeeze(nanmean(d2(roi_m1,:),1)),1,'Gauss'),'m')
%plot(x,smooth(squeeze(nanmean(d(roi_ppc,:),1))-squeeze(nanmean(d2(roi_ppc,:),1)),1,'Gauss'),'y')
plot(x,zeros(1,60),'k')




