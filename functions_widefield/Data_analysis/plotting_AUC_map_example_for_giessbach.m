cd D:\intrinsic\20150520\a\Matt_files
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
xlim([-2.7 5.5])

y=fliplr(smoothn(nanmean(AUC_map_time(:,:,98:134),3),[5 5],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[0 1]);colormap(mapgeog)
% hold on
% contour(fliplr(reshape(h,205,205)'),'k')
line([139 151],[8 175],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
axis square
axis off

% y=fliplr(smoothn(nanmean(AUC_map_time(:,:,98:134),3),[5 5],'Gauss')');
% [r c]=find(y<0.29);%prctile(reshape(AUC_map_time,1,205*205*180),1)
% [r2 c2]=find(y>0.85);%prctile(reshape(AUC_map_time,1,205*205*180),99)
% g=ones(205,205);
% g(isnan(y))=0;
% for i=1:size(r,1)
%     g(r(i),c(i))=y(r(i),c(i));
% end
% for i=1:size(r2,1)
%     g(r2(i),c2(i))=y(r2(i),c2(i));
% end
% figure;imagesc(smoothn(g,[1 1],'Gauss'),[0 1]);colormap(mapgeog)
% line([139 151],[8 175],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
% axis square
% axis off
% 


%%

cd D:\intrinsic\20150520\a\Matt_files
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
xlim([-2.7 5.5])

y=fliplr(smoothn(nanmean(AUC_map_time(:,:,98:134),3),[5 5],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[0 1]);colormap(mapgeog)
% hold on
% contour(fliplr(reshape(h,205,205)'),'k')
line([141 146],[27 88],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
line([146 145],[88 165],'Marker','.','LineStyle','-','LineWidth',3,'Color','k') 
axis square
axis off


