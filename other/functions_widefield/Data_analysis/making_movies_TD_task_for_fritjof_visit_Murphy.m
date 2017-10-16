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
    imagesc(y,[-.5e-2 3.5e-2]);colormap(gray)
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
movie2avi(M,'cond_100_grayscale','fps',20);    
  

close all
x=(1:180)*0.05-2.7;
for i=1:154
    disp(i)
    y=fliplr(smoothn(cond_1200_ave(:,:,i)-1,[5 5],'Gauss')');
    y(isnan(y))=10000;
    imagesc(y,[-.5e-2 3.5e-2]);colormap(gray)
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
movie2avi(M,'cond_1200_grayscale','fps',20);    
  
      

close all
x=(1:180)*0.05-2.7;
for i=1:154
    disp(i)
    y=fliplr(smoothn(cond_100_ave(:,:,i)-cond_1200_ave(:,:,i),[5 5],'Gauss')');
    y(isnan(y))=10000;
    imagesc(y,[-1.5e-2 3e-2]);colormap(gray)
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
movie2avi(M,'diff_movie_grayscale','fps',20); 
       

%%
cd D:\intrinsic\20150127\d\Matt_files

list100 = dir('cond_100_trial*');
for i=1:size(list100,1)
    disp(i)
    eval(['load cond_100_trial',int2str(i)])
    if i==1
        cond_100=tr;
    else
        cond_100=cat(4,cond_100,tr);
    end
end
cond_100=reshape(cond_100,205*205,180,size(cond_100,4));
list1200 = dir('cond_1200_trial*');
for i=1:size(list1200,1)
    disp(i)
    eval(['load cond_1200_trial',int2str(i)])
    if i==1
        cond_1200=tr;
    else
        cond_1200=cat(4,cond_1200,tr);
    end
end
cond_1200=reshape(cond_1200,205*205,180,size(cond_1200,4));

load('norm_frame_100')
fr_dev=reshape(fr_dev,205*205,1,size(cond_100,3));
cond_100=cond_100.*repmat(fr_dev,[1 180 1]);

load('norm_frame_1200')
fr_dev=reshape(fr_dev,205*205,1,size(cond_1200,3));
cond_1200=cond_1200.*repmat(fr_dev,[1 180 1]);

cond_100_ave=reshape(nanmean(cond_100,3),205,205,180);
cond_1200_ave=reshape(nanmean(cond_1200,3),205,205,180);


load rois_205x205_v2
h=zeros(205*205,1);
h(roi_s1)=1;
h(roi_s2)=1;
h(roi_m1)=1;
h(roi_m2)=1;
h(roi_a1)=1;
h(roi_alm)=1;

close all
x=(1:180)*0.05-2.7;
for i=1:154
    disp(i)
    y=fliplr(smoothn(cond_100_ave(:,:,i),[5 5],'Gauss')');
    y(isnan(y))=10000;
    imagesc(y,[0 0.03]);colormap(gray)
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
movie2avi(M,'cond_100_not_normalized','fps',20);    
  

close all
x=(1:180)*0.05-2.7;
for i=1:154
    disp(i)
    y=fliplr(smoothn(cond_1200_ave(:,:,i)-1,[5 5],'Gauss')');
    y(isnan(y))=10000;
    imagesc(y,[0 0.03]);colormap(gray)
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
movie2avi(M,'cond_1200_not_normalized','fps',20);    
  
      

close all
x=(1:180)*0.05-2.7;
for i=1:154
    disp(i)
    y=fliplr(smoothn(cond_100_ave(:,:,i)-cond_1200_ave(:,:,i),[5 5],'Gauss')');
    y(isnan(y))=10000;
    imagesc(y,[-3e-4 5e-4]);colormap(gray)
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
movie2avi(M,'diff_movie_not_normalized','fps',20); 
     