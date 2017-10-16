
figure;imagesc(smoothn(nanmean(tr_ave(:,:,7:50)./tr_ave_bl(:,:,7:50),3)-1,[7 7],'gaussian'),[-1e-3 2e-3]);colormap(gray)
figure;imagesc(smoothn(nanmean(tr_ave(:,:,7:50),3)-1,[7 7],'gaussian'),[-1e-3 2e-3]);colormap(gray)

for i=1:50
    %figure(10);imagesc(smoothn(nanmean(tr_ave(:,:,i)./tr_ave_bl(:,:,i),3)-1,[7 7],'gaussian'),[-1e-3 2e-3]);colormap(gray)
    figure(10);imagesc(smoothn(nanmean(tr_ave(:,:,i),3)-1,[7 7],'gaussian'),[-3e-3 2e-3]);colormap(gray)
    title(['time ',int2str(i*100),' ms'])
    shg
    pause(0.35)
end


diff=tr_ave;
d=reshape(diff,2048*2048,50);
figure;plot(smooth(squeeze(nanmean(d(roi_s1,:),1))-1,6,'Gauss'))
hold on
%plot(smooth(squeeze(nanmean(d(roi2,:),1))-1,6,'Gauss'),'r')

