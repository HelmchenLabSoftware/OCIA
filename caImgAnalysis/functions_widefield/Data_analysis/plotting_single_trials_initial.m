
for i=1:25
    disp(i)
    eval(['load trial_stim_',int2str(i)])
    figure;imagesc(smoothn(nanmean(tr(:,:,10:20),3)-1,[21 21],'Gauss'),[-.25e-2 1.5e-2]);colormap(gray)
    shg
end
x=(1:50)*100-500;
for i=1:25
    disp(i)
    eval(['load trial_stim_',int2str(i)])
    d=reshape(tr,2048*2048,50);
    figure;plot(x,smooth(squeeze(nanmean(d(roi_s1,:),1))-1,1,'Gauss'))
    hold on
    plot(x,smooth(squeeze(nanmean(d(roi_s2,:),1))-1,1,'Gauss'),'r')
    plot(x,smooth(squeeze(nanmean(d(roi_s3,:),1))-1,1,'Gauss'),'g')
    shg
end

