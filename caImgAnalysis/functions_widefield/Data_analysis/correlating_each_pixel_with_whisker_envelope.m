cd D:\intrinsic\20150521\c\Matt_files
load('whisker_envelope.mat')
load('rois_initial_205x205.mat')
load('trials_ind.mat')
load('pixels_to_remove.mat')
x=(1:180)*0.05-2.7;
time_whisk=9:167; % 105:149;  %9:42
time_wf=2:160; %98:142; %2:35 


whisk_map_100=nan*ones(205*205,size(tr_100,2));
for i=1:size(tr_100,2)
    disp(i)
    eval(['load cond_100_trial',int2str(i)])
    d=reshape(tr,205*205,size(tr,3));
    for j=1:size(d,1)
        tt=corrcoef(d(j,time_wf),whisk_env(time_whisk,tr_100(i)));
        whisk_map_100(j,i)=tt(1,2);
    end   
end
save whisk_map_100 whisk_map_100 time_whisk time_wf



% for i=1:size(tr_100,2)
%     figure;imagesc(smoothn(nanmean(reshape(whisk_map(:,i),[205,205]),3),[5 5],'Gauss'),[-.5 .5]);colormap(mapgeog)
% end


load('trials_ind_clean_205x205.mat')
load rois_initial_205x205
h=zeros(205*205,1);
h(roi_s1)=1;
h(roi_s2)=1;
h(roi_m1)=1;
h(roi_m2)=1;
h(roi_a1)=1;
h(roi_alm)=1;

tr_100_c=ones(1,size(whisk_map_100,2));
tr_100_c(tr_bad_100)=0;
whisk_map_100_clean=whisk_map_100(:,find(tr_100_c));
save whisk_map_100_clean whisk_map_100_clean time_whisk time_wf


figure;imagesc(smoothn(nanmean(reshape(whisk_map_100_clean,[205,205,size(whisk_map_100_clean,2)]),3),[5 5],'Gauss'),[.1 .5]);colormap(mapgeog)
hold on
contour(reshape(h,205,205),'k')




whisk_map_1200=nan*ones(205*205,size(tr_1200,2));
for i=1:size(tr_1200,2)
    disp(i)
    eval(['load cond_1200_trial',int2str(i)])
    d=reshape(tr,205*205,size(tr,3));
    for j=1:size(d,1)
        tt=corrcoef(d(j,time_wf),whisk_env(time_whisk,tr_1200(i)));
        whisk_map_1200(j,i)=tt(1,2);
    end   
end
save whisk_map_1200 whisk_map_1200 time_whisk time_wf



% for i=1:size(tr_1200,2)
%     figure;imagesc(smoothn(nanmean(reshape(whisk_map(:,i),[205,205]),3),[5 5],'Gauss'),[-.5 .5]);colormap(mapgeog)
% end

tr_1200_c=ones(1,size(whisk_map_1200,2));
tr_1200_c(tr_bad_1200)=0;
whisk_map_1200_clean=whisk_map_1200(:,find(tr_1200_c));
save whisk_map_1200_clean whisk_map_1200_clean time_whisk time_wf

figure;imagesc(smoothn(nanmean(reshape(whisk_map_1200_clean,[205,205,size(whisk_map_1200_clean,2)]),3),[5 5],'Gauss'),[.1 .5]);colormap(mapgeog)
hold on
contour(reshape(h,205,205),'k')


