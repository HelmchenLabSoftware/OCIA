

for i=[1:26 28:50]
    load (['stim_trial',int2str(i)])
    d=reshape(tr,256*256,80);
    z(:,i)=smooth(squeeze(nanmean(d(roi_s1,:),1))-1,3,'Gauss');
    %figure;plot(smooth(squeeze(nanmean(d(roi_s1,:),1))-1,1,'Gauss'))
end
figure;plot(nanmean(z,2))

for i=50
    load (['stim_trial',int2str(i)])
    figure;imagesc(smoothn(nanmean(tr(:,:,60:78),3)-1,[9 9],'Gauss'),[-.25e-3 4e-3]);colormap(mapgeog)
end





