cd D:\intrinsic\20150521\a\Matt_files
load('whisker_envelope.mat')
load('rois_initial_205x205.mat')
load('trials_ind.mat')
load('whisker_envelope.mat')
x=(1:180)*0.05-2.7;


th=0.5;
map_no_whisk_100=nan*ones(205*205,180,size(tr_100,2));
map_whisk_100=nan*ones(205*205,180,size(tr_100,2));
for i=1:size(tr_100,2)
    disp(i)
    t=smooth(whisk_env(:,tr_100(i)),3,'Gauss');
    wh_ind=t(8:167)>th;
    eval(['load cond_100_trial',int2str(i)])
    d=reshape(tr,205*205,180);
    map_no_whisk_100(:,~wh_ind,i)=d(:,~wh_ind)-1;
    map_whisk_100(:,wh_ind,i)=d(:,wh_ind)-1;
end
cond_100_ave_whisk=reshape(nanmean(map_whisk_100,3),[205,205,180]);
cond_100_ave_no_whisk=reshape(nanmean(map_no_whisk_100,3),[205,205,180]);


map_no_whisk_1200=nan*ones(205*205,180,size(tr_1200,2));
map_whisk_1200=nan*ones(205*205,180,size(tr_1200,2));
for i=1:size(tr_1200,2)
    disp(i)
    t=smooth(whisk_env(:,tr_1200(i)),3,'Gauss');
    wh_ind=t(8:167)>th;
    eval(['load cond_1200_trial',int2str(i)])
    d=reshape(tr,205*205,180);
    map_no_whisk_1200(:,~wh_ind,i)=d(:,~wh_ind)-1;
    map_whisk_1200(:,wh_ind,i)=d(:,wh_ind)-1;
end
cond_1200_ave_whisk=reshape(nanmean(map_whisk_1200,3),[205,205,180]);
cond_1200_ave_no_whisk=reshape(nanmean(map_no_whisk_1200,3),[205,205,180]);

%%

for i=180:-1:1
    figure;imagesc(smoothn(cond_100_ave_no_whisk(:,:,i),[5 5],'Gauss'),[-1e-2 1.5e-2]);colormap(mapgeog)
    %hold on
    %contour(reshape(h,205,205),'k')
    %title([int2str(x(i)*1000)])
    title([int2str(i)])
end

for i=180:-1:1
    figure;imagesc(smoothn(cond_1200_ave_whisk(:,:,i),[5 5],'Gauss'),[-1e-2 1.5e-2]);colormap(mapgeog)
    %hold on
    %contour(reshape(h,205,205),'k')
    title([int2str(x(i)*1000)])
    %title([int2str(i)])
end


for i=180:-1:1
    figure;imagesc(smoothn(cond_100_ave_no_whisk(:,:,i)-cond_1200_ave_no_whisk(:,:,i),[5 5],'Gauss'),[-1e-2 1e-2]);colormap(mapgeog)
    %hold on
    %contour(reshape(h,205,205),'k')
    title([int2str(x(i)*1000)])
    %title([int2str(i)])
end





