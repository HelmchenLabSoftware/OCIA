cd D:\intrinsic\20150521\a\Matt_files
load('whisker_envelope.mat')
load('rois_initial_205x205.mat')
load('trials_ind.mat')
load('pixels_to_remove.mat')

time_whisk=9:167; % 105:149;  %9:42
time_wf=2:160; %98:142; %2:35 
x=-7900:50:7900;

cov_whisk_100=nan*ones(size(x,2),size(tr_100,2));
for i=1:size(tr_100,2)
    disp(i)
    eval(['load cond_100_trial',int2str(i)])
    d=reshape(tr,205*205,size(tr,3));
    t=xcov(nanmean(d(roi_s1,time_wf),1)-1,whisk_env(time_whisk,tr_100(i)),'coeff');
    cov_whisk_100(:,i)=t;
end

cov_whisk_1200=nan*ones(size(x,2),size(tr_1200,2));
for i=1:size(tr_1200,2)
    disp(i)
    eval(['load cond_1200_trial',int2str(i)])
    d=reshape(tr,205*205,size(tr,3));
    t=xcov(nanmean(d(roi_s1,time_wf),1)-1,whisk_env(time_whisk,tr_1200(i)),'coeff');
    cov_whisk_1200(:,i)=t;
end



figure;errorbar(x,nanmean(cov_whisk_100,2),nanstd(cov_whisk_100,0,2)/sqrt(size(cov_whisk_100,2)),'b')
hold on
errorbar(x,nanmean(cov_whisk_1200,2),nanstd(cov_whisk_1200,0,2)/sqrt(size(cov_whisk_1200,2)),'r')
xlim([-1000 1000])


