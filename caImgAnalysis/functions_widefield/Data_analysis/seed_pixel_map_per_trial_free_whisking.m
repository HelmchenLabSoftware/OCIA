



cd D:\intrinsic\20150617\a\Matt_files
load('rois_205x205_v2.mat')
list1 = dir('stim_trial*');

seed_map_m2=nan*ones(205*205,size(list1,1));
for j=1:size(list1,1)
    disp(j)
    load(['stim_trial',int2str(j)])
    load('pixels_to_remove.mat')
    d=reshape(tr,205*205,size(tr,3));
    seed=nanmean(d(roi_m2,:),1);
    te=find(isnan(seed));
    if isempty(te)
        te=size(d,2)+1;
    end
    for i=1:size(d,1)
        %disp(i)
        t=corrcoef(seed(1:(te(1)-1)),d(i,1:(te(1)-1)));
        seed_map_m2(i,j)=t(1,2);
    end    
end
seed_map_m2=reshape(seed_map_m2,[205,205,size(list1,1)]);

y=fliplr(smoothn(nanmean(seed_map_m2,3),[1 1],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[.5 1]);colormap(mapgeog)
hold on
h=zeros(205*205,1);
h(roi_m2)=1;
contour(fliplr(reshape(h,205,205)'),'k')
line([139 151],[12 161],'Marker','.','LineStyle','-','LineWidth',3,'Color','w')
axis square
axis off



