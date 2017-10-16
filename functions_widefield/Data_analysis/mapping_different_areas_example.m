


% for i=250:-1:50
%     figure;imagesc(smoothn(nanmean(tr_ave(:,:,i),3)-1,[3 3],'Gauss'),[-.5e-2 3e-2]);colormap(mapgeog)
%     %hold on
%     %contour(reshape(h,2048,2048),'k')
%     %title([int2str(x(i)*1000)])
%     title([int2str(i)])
% end

% 
% 
% figure(100);imagesc(smoothn(nanmean(tr_ave(:,:,13),3)-1,[3 3],'Gauss'),[-.25e-2 .9e-2]);colormap(mapgeog)
% roi_s1 = choose_polygon_imagesc(205);
% roi_fl = choose_polygon_imagesc(205);
% roi_a1 = choose_polygon_imagesc(205);
% roi_s2 = choose_polygon_imagesc(205);
% roi_v1 = choose_polygon_imagesc(205);
% roi_hl = choose_polygon_imagesc(205);


% d=reshape(tr_ave,205*205,80);
% figure;plot(smooth(squeeze(nanmean(d(roi_v1,:),1))-1,1,'Gauss'))
% hold on
% plot(smooth(squeeze(nanmean(d(roi_fl,:),1))-1,1,'Gauss'),'c')
% plot(smooth(squeeze(nanmean(d(roi_m1,:),1))-1,1,'Gauss'),'r')
% plot(smooth(squeeze(nanmean(d(roi_a1,:),1))-1,1,'Gauss'),'g')
% 


cd D:\intrinsic\20150511
load rois

cd D:\intrinsic\20150511\d\Matt_files
load('stim_ave.mat')
y=fliplr(smoothn(nanmean(tr_ave(:,:,15),3)-1,[3 3],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[-.25e-2 1.25e-2]);colormap(mapgeog)
hold on
h=zeros(205*205,1);
h(roi_a1)=1;
contour(fliplr(reshape(h,205,205)'),'k')
line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
axis square
axis off

cd D:\intrinsic\20150511\c\Matt_files
load('stim_ave.mat')
y=fliplr(smoothn(nanmean(tr_ave(:,:,28),3)-1,[3 3],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[-.25e-2 2.25e-2]);colormap(mapgeog)
hold on
h=zeros(205*205,1);
h(roi_s1)=1;
contour(fliplr(reshape(h,205,205)'),'k')
h(roi_s2)=1;
contour(fliplr(reshape(h,205,205)'),'k')
line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
axis square
axis off

cd D:\intrinsic\20150511\b\Matt_files
load('stim_ave_trials_3_8_9.mat')
y=fliplr(smoothn(nanmean(tr_ave(:,:,148:158),3)-1,[3 3],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[-.25e-2 3e-2]);colormap(mapgeog)
hold on
h=zeros(205*205,1);
h(roi_v1)=1;
contour(fliplr(reshape(h,205,205)'),'k')
line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
axis square
axis off

cd D:\intrinsic\20150511\g\Matt_files
load('stim_ave.mat')
y=fliplr(smoothn(nanmean(tr_ave(:,:,14:15),3)-1,[3 3],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[-.25e-2 .9e-2]);colormap(mapgeog)
hold on
h=zeros(205*205,1);
h(roi_fl)=1;
contour(fliplr(reshape(h,205,205)'),'k')
line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
axis square
axis off

cd D:\intrinsic\20150511\h\Matt_files
load('stim_ave.mat')
y=fliplr(smoothn(nanmean(tr_ave(:,:,13),3)-1,[3 3],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[-.25e-2 .9e-2]);colormap(mapgeog)
hold on
h=zeros(205*205,1);
h(roi_hl)=1;
contour(fliplr(reshape(h,205,205)'),'k')
line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
axis square
axis off

cd D:\intrinsic\20150511
load green_ds
y=fliplr(smoothn(nanmean(tr_ave(:,:,15),3)-1,[3 3],'Gauss')');
y2=fliplr(green_ds');
y2(isnan(y))=10000;
figure;imagesc(y2,[0 0.9]);colormap(gray)
hold on
line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
axis square
axis off
h=zeros(205*205,1);
h(roi_s1)=1;
contour(fliplr(reshape(h,205,205)'),'b')
h=zeros(205*205,1);
h(roi_s2)=1;
contour(fliplr(reshape(h,205,205)'),'c')
h=zeros(205*205,1);
h(roi_a1)=1;
contour(fliplr(reshape(h,205,205)'),'g')
h=zeros(205*205,1);
h(roi_v1)=1;
contour(fliplr(reshape(h,205,205)'),'y')
h=zeros(205*205,1);
h(roi_fl)=1;
contour(fliplr(reshape(h,205,205)'),'r')
h=zeros(205*205,1);
h(roi_hl)=1;
contour(fliplr(reshape(h,205,205)'),'m')







