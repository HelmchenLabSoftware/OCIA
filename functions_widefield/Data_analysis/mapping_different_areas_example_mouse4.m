


for i=200:-5:50
    figure;imagesc(smoothn(nanmean(tr_ave(:,:,i),3)-1,[3 3],'Gauss'),[-.5e-2 1.5e-2]);colormap(mapgeog)
    %hold on
    %contour(reshape(h,2048,2048),'k')
    %title([int2str(x(i)*1000)])
    title([int2str(i)])
end

% 
% 
figure(100);imagesc(smoothn(nanmean(tr_ave(:,:,110:130),3)-1,[3 3],'Gauss'),[-.25e-2 1.5e-2]);colormap(mapgeog)
roi_s1 = choose_polygon_imagesc(256);
roi_fl = choose_polygon_imagesc(256);
roi_a1 = choose_polygon_imagesc(256);
roi_s2 = choose_polygon_imagesc(256);
roi_v1 = choose_polygon_imagesc(256);
roi_hl = choose_polygon_imagesc(256);


d=reshape(tr_ave,256*256,500);
figure;plot(smooth(squeeze(nanmean(d(roi_v1,:),1))-1,1,'Gauss'))
hold on
plot(smooth(squeeze(nanmean(d(roi_s1,:),1))-1,1,'Gauss'),'c')
plot(smooth(squeeze(nanmean(d(roi_s2,:),1))-1,1,'Gauss'),'r')
plot(smooth(squeeze(nanmean(d(roi_a1,:),1))-1,1,'Gauss'),'g')



cd D:\intrinsic\20150511
load rois

cd D:\intrinsic\20150518\a\Matt_files
load('stim_ave.mat')
y=fliplr(smoothn(nanmean(tr_ave(:,:,65:70),3)-1,[3 3],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[-.25e-2 2e-2]);colormap(mapgeog)
% hold on
% h=zeros(205*205,1);
% h(roi_a1)=1;
% contour(fliplr(reshape(h,205,205)'),'k')
% line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
% axis square
% axis off


cd D:\intrinsic\20150518\b\Matt_files
load('stim_ave.mat')
y=fliplr(smoothn(nanmean(tr_ave(:,:,85:90),3)-1,[3 3],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[-.25e-2 2e-2]);colormap(mapgeog)
% hold on
% h=zeros(205*205,1);
% h(roi_a1)=1;
% contour(fliplr(reshape(h,205,205)'),'k')
% line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
% axis square
% axis off

cd D:\intrinsic\20150518\f\Matt_files
load('stim_ave.mat')
y=fliplr(smoothn(nanmean(tr_ave(:,:,100:150),3)-1,[3 3],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[-.25e-2 2e-2]);colormap(mapgeog)
% hold on
% h=zeros(205*205,1);
% h(roi_a1)=1;
% contour(fliplr(reshape(h,205,205)'),'k')
% line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
% axis square
% axis off





