cd D:\intrinsic\20150511
load rois


cd D:\intrinsic\20150504\mouse_tgg6fl23_4\c\Matt_files
load('stim_ave.mat')
load('pixels_to_remove.mat')
d=reshape(tr_ave,205*205,size(tr_ave,3));

seed=nanmean(d(roi_s1,:),1);
for i=1:size(d,1)
    %disp(i)
    t=corrcoef(seed,d(i,:));
    seed_map_s1(i)=t(1,2);
end
seed_map_s1=reshape(seed_map_s1,205,205);
            
y=fliplr(smoothn(seed_map_s1,[1 1],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[.8 1]);colormap(mapgeog)
hold on
h=zeros(205*205,1);
h(roi_s1)=1;
contour(fliplr(reshape(h,205,205)'),'k')
line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
axis square
axis off




cd D:\intrinsic\20150504\mouse_tgg6fl23_4\b\Matt_files
load('stim_ave.mat')
load('pixels_to_remove.mat')
d=reshape(tr_ave,205*205,size(tr_ave,3));

seed=nanmean(d(roi_v1,:),1);
for i=1:size(d,1)
    %disp(i)
    t=corrcoef(seed,d(i,:));
    seed_map_v1(i)=t(1,2);
end
seed_map_v1=reshape(seed_map_v1,205,205);
            
y=fliplr(smoothn(seed_map_v1,[1 1],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[.8 1]);colormap(mapgeog)
hold on
h=zeros(205*205,1);
h(roi_s1)=1;
contour(fliplr(reshape(h,205,205)'),'k')
line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
axis square
axis off



cd D:\intrinsic\20150504\mouse_tgg6fl23_4\d\Matt_files
load('stim_ave.mat')
load('pixels_to_remove.mat')
d=reshape(tr_ave,205*205,size(tr_ave,3));

seed=nanmean(d(roi_a1,:),1);
for i=1:size(d,1)
    %disp(i)
    t=corrcoef(seed,d(i,:));
    seed_map_a1(i)=t(1,2);
end
seed_map_a1=reshape(seed_map_a1,205,205);
            
y=fliplr(smoothn(seed_map_a1,[1 1],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[.8 1]);colormap(mapgeog)
hold on
h=zeros(205*205,1);
h(roi_s1)=1;
contour(fliplr(reshape(h,205,205)'),'k')
line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
axis square
axis off



