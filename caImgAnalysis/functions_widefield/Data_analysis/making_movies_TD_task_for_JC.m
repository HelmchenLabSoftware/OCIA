cd D:\intrinsic\20150127\d\Matt_files
load('cond_100_ave_clean.mat')
load('cond_1200_ave_clean.mat')
cond_100_ave=reshape(cond_100_ave,205,205,180);
cond_1200_ave=reshape(cond_1200_ave,205,205,180);

load rois_205x205_v2
h=zeros(205*205,1);
h(roi_s1)=1;
h(roi_s2)=1;
h(roi_m1)=1;
h(roi_m2)=1;
h(roi_a1)=1;
h(roi_alm)=1;


x=(1:180)*0.05-2.7;
for i=1:154
    disp(i)
    y=fliplr(smoothn(cond_100_ave(:,:,i)-1,[5 5],'Gauss')');
    y(isnan(y))=10000;
    imagesc(y,[-.5e-2 3.5e-2]);colormap(mapgeog)
    %get(h,'CDataMapping')
    %set(h,'CDataMapping','direct')
    axis off
    axis square
    title([int2str(x(i)*1000)])
    line([141 146],[27 88],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
    line([146 145],[88 165],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
    hold on
    %contour(fliplr(reshape(h,205,205)'),'w')
    M(:,i)=getframe(gcf);
end;
movie2avi(M,'cond_100','fps',20);    
  

close all
x=(1:180)*0.05-2.7;
for i=1:154
    disp(i)
    y=fliplr(smoothn(cond_1200_ave(:,:,i)-1,[5 5],'Gauss')');
    y(isnan(y))=10000;
    imagesc(y,[-.5e-2 3.5e-2]);colormap(mapgeog)
    %get(h,'CDataMapping')
    %set(h,'CDataMapping','direct')
    axis off
    axis square
    title([int2str(x(i)*1000)])
    line([141 146],[27 88],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
    line([146 145],[88 165],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
    hold on
    %contour(fliplr(reshape(h,205,205)'),'w')
    M(:,i)=getframe(gcf);
end;
movie2avi(M,'cond_1200','fps',20);    
  
      

close all
x=(1:180)*0.05-2.7;
for i=1:154
    disp(i)
    y=fliplr(smoothn(cond_100_ave(:,:,i)-cond_1200_ave(:,:,i),[5 5],'Gauss')');
    y(isnan(y))=10000;
    imagesc(y,[-1.5e-2 3e-2]);colormap(mapgeog)
    %get(h,'CDataMapping')
    %set(h,'CDataMapping','direct')
    axis off
    axis square
    title([int2str(x(i)*1000)])
    line([141 146],[27 88],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
    line([146 145],[88 165],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
    hold on
    contour(fliplr(reshape(h,205,205)'),'w')
    M(:,i)=getframe(gcf);
end;
movie2avi(M,'diff_map','fps',20); 
       


