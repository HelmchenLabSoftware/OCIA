


x=(1:size(cond_100_ave,3))*0.05-2.7;
for i=1:41
    load(['cond_100_trial',int2str(i)])
    d=reshape(tr,205*205,size(cond_100_ave,3));
    figure;plot(x(1:60),smooth(squeeze(nanmean(d(roi_a1,1:60),1))-1,1,'Gauss'),'b')
    hold on
    plot(x(1:60),zeros(1,60),'k')
end





for i=60:-1:1
    figure;imagesc(smoothn(tr(:,:,i)-1,[5 5],'Gauss'),[-1.5e-2 1.5e-2]);colormap(mapgeog)
    %hold on
    %contour(reshape(h,205,205),'k')
    title([int2str(x(i)*1000)])
    %title([int2str(i)])
end




