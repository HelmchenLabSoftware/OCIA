cd D:\intrinsic\20141125\b\Matt_files
load('stim_ave.mat')

y=fliplr(smoothn(nanmean(tr_ave(:,:,8:25),3)',[53 53],'Gauss')')-1;
y(isnan(y))=10000;
figure;imagesc(y,[-.5e-2 1.8e-2]);colormap(gray)
hold on
axis square
axis off
line([1335 1353],[377 1559],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')

cd D:\intrinsic\20141125\green\Tiff_files
a=imread('Trial1frame2');
green=im2double(a);
figure;imagesc(fliplr(green'),[0.1 0.9]);colormap(gray)
hold on
axis square
axis off
line([1335 1353],[377 1559],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')



