cd D:\intrinsic\20150127\d\Matt_files
load('cond_100_ave.mat')
load rois_initial_205x205
h=zeros(205*205,1);
h(roi_s1)=1;
h(roi_s2)=1;
h(roi_m1)=1;
h(roi_m2)=1;
h(roi_a1)=1;
h(roi_alm)=1;

x=(1:180)*0.05-2.7;
for i=1:180
    disp(i)
    imagesc(fliplr(smoothn(cond_100_ave(:,:,i)-1,[5 5],'Gauss')'),[-.5e-2 3.5e-2]);colormap(mapgeog)
    %get(h,'CDataMapping')
    %set(h,'CDataMapping','direct')
    axis off
    axis square
    title([int2str(x(i)*1000)])
    hold on
    contour(fliplr(reshape(h,205,205)'),'b')
    M(:,i)=getframe(gcf);
end;
movie2avi(M,'cond_100','fps',40);    
  
load('cond_1200_ave.mat')
close all
for i=1:180
    disp(i)
    imagesc(fliplr(smoothn(cond_1200_ave(:,:,i)-1,[5 5],'Gauss')'),[-.5e-2 3.5e-2]);colormap(mapgeog)
    %get(h,'CDataMapping')
    %set(h,'CDataMapping','direct')
    axis off
    axis square
    title([int2str(x(i)*1000)])
    hold on
    contour(fliplr(reshape(h,205,205)'),'b')
    M(:,i)=getframe(gcf);
end;
movie2avi(M,'cond_1200','fps',40);    
       

close all
for i=1:180
    disp(i)
    imagesc(fliplr(smoothn(cond_100_ave(:,:,i)-cond_1200_ave(:,:,i),[5 5],'Gauss')'),[-1.5e-2 3e-2]);colormap(mapgeog)
    %get(h,'CDataMapping')
    %set(h,'CDataMapping','direct')
    axis off
    axis square
    title([int2str(x(i)*1000)])
    hold on
    contour(fliplr(reshape(h,205,205)'),'b')
    M(:,i)=getframe(gcf);
end;
movie2avi(M,'diff_movie','fps',40);    
       


