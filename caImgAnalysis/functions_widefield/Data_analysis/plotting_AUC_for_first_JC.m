cd D:\intrinsic\20150127\d\Matt_files
load('AUC_map_time_clean.mat')

load rois_205x205_v2
h=zeros(205*205,1);
h(roi_s1)=1;
h(roi_s2)=1;
h(roi_m1)=1;
h(roi_m2)=1;
h(roi_a1)=1;
h(roi_alm)=1;

x=(1:180)*0.05-2.7;

% for i=180:-1:1
%     figure;imagesc(smoothn(AUC_map_time(:,:,i),[5 5],'Gauss'),[0.2 1]);colormap(mapgeog)
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
for i=1:154
    disp(i)
    y=fliplr(smoothn(AUC_map_time(:,:,i),[5 5],'Gauss')');
    y(isnan(y))=10000;
    imagesc(y,[0.2 1]);colormap(mapgeog)
    %get(h,'CDataMapping')
    %set(h,'CDataMapping','direct')
    axis off
    axis square
    title([int2str(x(i)*1000)])
    hold on
    line([141 146],[27 88],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
    line([146 145],[88 165],'Marker','.','LineStyle','-','LineWidth',3,'Color','k') 
    contour(fliplr(reshape(h,205,205)'),'b')
    M(:,i)=getframe(gcf);
end;
movie2avi(M,'AUC_map','fps',20);    
  

%%

[r c]=find(d<0.35);%prctile(reshape(AUC_map_time,1,205*205*180),1)
[r2 c2]=find(d>0.9);%prctile(reshape(AUC_map_time,1,205*205*180),99)
g=ones(205*205,180);
for i=1:size(r,1)
    g(r(i),c(i))=d(r(i),c(i));
end
for i=1:size(r2,1)
    g(r2(i),c2(i))=d(r2(i),c2(i));
end
u=reshape(g,205,205,180);


load pixels_to_remove
g=zeros(205*205,1);
g(isnan(AUC_map_time(:,:,1)))=1;
%%
close all
for i=1:174
    disp(i)
    imagesc(fliplr(smoothn(u(:,:,i),[1 1],'Gauss')'),[0 1]);colormap(mapgeog)
    %get(h,'CDataMapping')
    %set(h,'CDataMapping','direct')
    axis off
    axis square
    title([int2str(x(i)*1000)])
    hold on
    line([141 146],[27 88],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
    line([146 145],[88 165],'Marker','.','LineStyle','-','LineWidth',3,'Color','k') 
    contour(fliplr(reshape(h,205,205)'),'b')
    contour(fliplr(reshape(g,205,205)'),'k')
    M(:,i)=getframe(gcf);
end;
movie2avi(M,'AUC_map_thresh','fps',10);    
  

%%
f=zeros(205*205,1);
f(roi_rs)=1;
t=61;
figure;imagesc(fliplr(smoothn(u(:,:,t),[1 1],'Gauss')'),[0 1]);colormap(mapgeog)
axis off
axis square
title([int2str(x(t)*1000)])
hold on
line([141 146],[27 88],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
line([146 145],[88 165],'Marker','.','LineStyle','-','LineWidth',3,'Color','k') 
contour(fliplr(reshape(h,205,205)'),'b')
contour(fliplr(reshape(f,205,205)'),'r')
contour(fliplr(reshape(g,205,205)'),'k')


f=zeros(205*205,1);
f(roi_rh)=1;
f(roi_ppc)=1;
t=87;
figure;imagesc(fliplr(smoothn(u(:,:,t),[1 1],'Gauss')'),[0 1]);colormap(mapgeog)
axis off
axis square
title([int2str(x(t)*1000)])
hold on
line([141 146],[27 88],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
line([146 145],[88 165],'Marker','.','LineStyle','-','LineWidth',3,'Color','k') 
contour(fliplr(reshape(h,205,205)'),'b')
contour(fliplr(reshape(f,205,205)'),'r')
contour(fliplr(reshape(g,205,205)'),'k')


t=110;
figure;imagesc(fliplr(smoothn(u(:,:,t),[1 1],'Gauss')'),[0 1]);colormap(mapgeog)
axis off
axis square
title([int2str(x(t)*1000)])
hold on
line([141 146],[27 88],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
line([146 145],[88 165],'Marker','.','LineStyle','-','LineWidth',3,'Color','k') 
contour(fliplr(reshape(h,205,205)'),'b')
contour(fliplr(reshape(g,205,205)'),'k')



f=zeros(205*205,1);
f(roi_rs)=1;
t=135;
figure;imagesc(fliplr(smoothn(u(:,:,t),[1 1],'Gauss')'),[0 1]);colormap(mapgeog)
axis off
axis square
title([int2str(x(t)*1000)])
hold on
line([141 146],[27 88],'Marker','.','LineStyle','-','LineWidth',3,'Color','k')
line([146 145],[88 165],'Marker','.','LineStyle','-','LineWidth',3,'Color','k') 
contour(fliplr(reshape(h,205,205)'),'b')
contour(fliplr(reshape(f,205,205)'),'r')
contour(fliplr(reshape(g,205,205)'),'k')




figure;plot(x,smooth(squeeze(nanmean(d(roi_rh,:),1)),1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d(roi_ppc,:),1)),1,'Gauss'),'c')
plot(x,smooth(squeeze(nanmean(d(roi_a1,:),1)),1,'Gauss'),'g')
plot(x,0.5*ones(1,180),'k')
legend('right hemisphere','ppc','a1')


figure;plot(x,smooth(squeeze(nanmean(d(roi_m1,:),1)),1,'Gauss'),'r')
hold on
plot(x,smooth(squeeze(nanmean(d(roi_m2,:),1)),1,'Gauss'),'k')
plot(x,smooth(squeeze(nanmean(d(roi_rs,:),1)),1,'Gauss'),'y')
plot(x,smooth(squeeze(nanmean(d(roi_alm,:),1)),1,'Gauss'),'m')
plot(x,0.5*ones(1,180),'k')
legend('m1','m2','rs','alm')


