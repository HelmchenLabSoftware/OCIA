



cd D:\intrinsic\20150511
load rois

cd D:\intrinsic\20150511\c\Matt_files
list1 = dir('stim_trial*');

seed_map_s1=nan*ones(205*205,size(list1,1));
for j=1:size(list1,1)
    disp(j)
    load(['stim_trial',int2str(j)])
    load('pixels_to_remove.mat')
    d=reshape(tr,205*205,size(tr,3));
    seed=nanmean(d(roi_s1,:),1);
    for i=1:size(d,1)
        %disp(i)
        t=corrcoef(seed,d(i,:));
        seed_map_s1(i,j)=t(1,2);
    end    
end
seed_map_s1=reshape(seed_map_s1,[205,205,size(list1,1)]);

y=fliplr(smoothn(nanmean(seed_map_s1,3),[1 1],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[.5 1]);colormap(mapgeog)
hold on
h=zeros(205*205,1);
h(roi_s1)=1;
contour(fliplr(reshape(h,205,205)'),'k')
line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
axis square
axis off




cd D:\intrinsic\20150511\b\Matt_files
list1 = dir('stim_trial*');

seed_map_v1=nan*ones(205*205,size(list1,1));
for j=1:size(list1,1)
    disp(j)
    load(['stim_trial',int2str(j)])
    load('pixels_to_remove.mat')
    d=reshape(tr,205*205,size(tr,3));
    seed=nanmean(d(roi_v1,:),1);
    for i=1:size(d,1)
        %disp(i)
        t=corrcoef(seed,d(i,:));
        seed_map_v1(i,j)=t(1,2);
    end    
end
seed_map_v1=reshape(seed_map_v1,[205,205,size(list1,1)]);

y=fliplr(smoothn(nanmean(seed_map_v1,3),[1 1],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[.5 1]);colormap(mapgeog)
hold on
h=zeros(205*205,1);
h(roi_s1)=1;
contour(fliplr(reshape(h,205,205)'),'k')
line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
axis square
axis off




cd D:\intrinsic\20150511\d\Matt_files
list1 = dir('stim_trial*');

seed_map_a1=nan*ones(205*205,size(list1,1));
for j=1:size(list1,1)
    disp(j)
    load(['stim_trial',int2str(j)])
    load('pixels_to_remove.mat')
    d=reshape(tr,205*205,size(tr,3));
    seed=nanmean(d(roi_a1,:),1);
    for i=1:size(d,1)
        %disp(i)
        t=corrcoef(seed,d(i,:));
        seed_map_a1(i,j)=t(1,2);
    end    
end
seed_map_a1=reshape(seed_map_a1,[205,205,size(list1,1)]);

y=fliplr(smoothn(nanmean(seed_map_a1,3),[1 1],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[.5 1]);colormap(mapgeog)
hold on
h=zeros(205*205,1);
h(roi_s1)=1;
contour(fliplr(reshape(h,205,205)'),'k')
line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
axis square
axis off




