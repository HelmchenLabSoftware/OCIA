cd D:\intrinsic\20150123\green\Tiff_files
a=imread('Trial1frame2');
green=im2double(a);
figure;imagesc(green,[-.2 0.9]);colormap(gray)



cd D:\intrinsic\20141125\b\Matt_files
load('intial_rois.mat')
load('blank_ave.mat')
load('stim_ave.mat')
x=(1:50)*100-500;
d=reshape(tr_ave./tr_ave_bl,2048*2048,50);
figure;plot(x,smooth(squeeze(nanmean(d(roi_s1,:),1))-1,1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d(roi_s2,:),1))-1,1,'Gauss'),'r')
plot(x,smooth(squeeze(nanmean(d(roi_s3,:),1))-1,1,'Gauss'),'g')
plot(x,smooth(squeeze(nanmean(d(roi_s4,:),1))-1,1,'Gauss'),'c')

figure;imagesc(smoothn(nanmean(tr_ave(:,:,10:15),3)./nanmean(tr_ave_bl(:,:,10:15),3)-1,[13 13],'Gauss'),[-.5e-2 2.5e-2]);colormap(gray)
hold on
h=zeros(2048*2048,1);
h(roi_s1)=1;
contour(reshape(h,2048,2048),'b')
h=zeros(2048*2048,1);
h(roi_s2)=1;
contour(reshape(h,2048,2048),'r')
h=zeros(2048*2048,1);
h(roi_s3)=1;
contour(reshape(h,2048,2048),'g')
h=zeros(2048*2048,1);
h(roi_s4)=1;
contour(reshape(h,2048,2048),'c')


cd D:\intrinsic\20141125\a\Matt_files
load('blank_ave.mat')
load('stim_ave.mat')
load('intial_rois.mat')
d=reshape(tr_ave./tr_ave_bl,2048*2048,50);
figure;plot(x,smooth(squeeze(nanmean(d(roi_s1,:),1))-1,1,'Gauss'))
hold on
plot(x,smooth(squeeze(nanmean(d(roi_s2,:),1))-1,1,'Gauss'),'r')

figure(100);imagesc(smoothn(nanmean(tr_ave(:,:,7:35),3)./nanmean(tr_ave_bl(:,:,7:35),3)-1,[13 13],'Gauss'),[-.5e-3 1e-3]);colormap(gray)
hold on
h=zeros(2048*2048,1);
h(roi_s1)=1;
contour(reshape(h,2048,2048),'b')
h=zeros(2048*2048,1);
h(roi_s2)=1;
contour(reshape(h,2048,2048),'r')




