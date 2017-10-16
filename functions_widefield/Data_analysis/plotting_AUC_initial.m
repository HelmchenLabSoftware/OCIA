load('AUC_map_time_clean.mat')

load rois_initial_205x205
h=zeros(205*205,1);
h(roi_s1)=1;
h(roi_s2)=1;
h(roi_m1)=1;
h(roi_m2)=1;
h(roi_a1)=1;
h(roi_alm)=1;

x=(1:180)*0.05-2.7;

% for i=180:-1:1
%     figure;imagesc(smoothn(AUC_map_time(:,:,i),[5 5],'Gauss'),[0.2 .95]);colormap(mapgeog)
%     %hold on
%     %contour(reshape(h,205,205),'r')
%     title([int2str(x(i)*1000)])
%     %title([int2str(i)])
% end



d=reshape(AUC_map_time,205*205,180);
figure;plot(x,smooth(squeeze(nanmean(d(roi_s1,:),1)),1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d(roi_s2,:),1)),1,'Gauss'),'c')
plot(x,smooth(squeeze(nanmean(d(roi_m1,:),1)),1,'Gauss'),'r')
plot(x,smooth(squeeze(nanmean(d(roi_a1,:),1)),1,'Gauss'),'g')
plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1)),1,'Gauss'),'k')
plot(x,smooth(squeeze(nanmean(d(roi_alm,:),1)),1,'Gauss'),'m')
plot(x,0.5*ones(1,180),'k')
legend('s1','s2','m1','a1','m2','alm')


%%

close all
for i=1:180
    disp(i)
    imagesc(fliplr(smoothn(AUC_map_time(:,:,i),[5 5],'Gauss')'),[0.5 0.7]);colormap(mapgeog)
    %get(h,'CDataMapping')
    %set(h,'CDataMapping','direct')
    axis off
    axis square
    title([int2str(x(i)*1000)])
    hold on
    contour(fliplr(reshape(h,205,205)'),'b')
    M(:,i)=getframe(gcf);
end;
movie2avi(M,'AUC_map','fps',20);    
  

%%
[r c]=find(d<0.4);%prctile(reshape(AUC_map_time,1,205*205*180),1)
[r2 c2]=find(d>0.60);%prctile(reshape(AUC_map_time,1,205*205*180),99)
g=ones(205*205,180);
for i=1:size(r,1)
    g(r(i),c(i))=d(r(i),c(i));
end
for i=1:size(r2,1)
    g(r2(i),c2(i))=d(r2(i),c2(i));
end
u=reshape(g,205,205,180);




for i=180:-4:1
    figure;imagesc(smoothn(u(:,:,i),[1 1],'Gauss'),[0 1]);colormap(mapgeog)
    %hold on
    %contour(reshape(h,205,205),'k')
    title([int2str(x(i)*1000)])
    %title([int2str(i)])
end
