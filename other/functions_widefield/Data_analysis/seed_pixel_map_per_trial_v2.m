



cd D:\intrinsic\20150520\b\Matt_files
list1 = dir('cond_100_trial*');
%load('rois_s1_m2.mat')
time=105:132;
seed_map_m2_cond100=nan*ones(205*205,size(list1,1));
for j=1:size(list1,1)
    disp(j)
    load(['cond_100_trial',int2str(j)])
    load('pixels_to_remove.mat')
    d=reshape(tr,205*205,size(tr,3));
    seed=nanmean(d(roi_m2,:),1);
    for i=1:size(d,1)
        %disp(i)
        t=corrcoef(seed(time),d(i,time));
        seed_map_m2_cond100(i,j)=t(1,2);
    end    
end
seed_map_m2_cond100=reshape(seed_map_m2_cond100,[205,205,size(list1,1)]);

y=fliplr(smoothn(nanmean(seed_map_m2_cond100,3),[1 1],'Gauss')');
y(isnan(y))=10000;
figure;imagesc(y,[0.3 1]);colormap(mapgeog)
hold on
h=zeros(205*205,1);
h(roi_m2)=1;
contour(fliplr(reshape(h,205,205)'),'k')
axis square
axis off






