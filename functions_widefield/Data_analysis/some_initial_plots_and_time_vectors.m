
x=(1:180)*0.05-2.7;
x=x(1:3:180);

load rois
h=zeros(2048*2048,1);
h(roi_s1)=1;
h(roi_s2)=1;
h(roi_m1)=1;
h(roi_a1)=1;

for i=100:-1:1
    figure;imagesc(smoothn(nanmean(tr_ave(:,:,i),3)-1,[53 53],'Gauss'),[-1e-3 0.4e-2]);colormap(mapgeog)
    %hold on
    %contour(reshape(h,2048,2048),'k')
    %title([int2str(x(i)*1000)])
    title([int2str(i)])
end

figure(100);imagesc(smoothn(nanmean(tr_ave(:,:,25:30),3)-1,[53 53],'Gauss'),[-.2e-3 .25e-2]);colormap(mapgeog)
roi_s1 = choose_polygon_imagesc(2048);
roi_m1 = choose_polygon_imagesc(2048);
roi_a1 = choose_polygon_imagesc(2048);
roi_s2 = choose_polygon_imagesc(2048);


d=reshape(tr_ave,2048*2048,100);
figure;plot(smooth(squeeze(nanmean(d(roi_s1,:),1))-1,1,'Gauss'))
hold on
plot(smooth(squeeze(nanmean(d(roi_s2,:),1))-1,1,'Gauss'),'r')
plot(smooth(squeeze(nanmean(d(roi_m1,:),1))-1,1,'Gauss'),'g')
plot(smooth(squeeze(nanmean(d(roi_a1,:),1))-1,1,'Gauss'),'c')




