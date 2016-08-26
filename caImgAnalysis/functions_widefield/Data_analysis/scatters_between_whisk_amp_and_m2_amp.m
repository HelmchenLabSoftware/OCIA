cd E:\data_for_israel_july_2015\20150521\c\Matt_files
load trials_ind
load whisker_envelope_100
load whisker_envelope_1200
x=(1:180)*0.05-2.7;
load('whisker_envelope.mat', 'x_env')
load rois_initial_205x205
load trials_ind_clean_205x205

for i=1:size(tr_100,2)
    eval(['load cond_100_trial',int2str(i)])    
    d=reshape(tr(:,:,1:180),205*205,180);
    resp_m2(i)=nanmean(nanmean(d(roi_m2,2:38)))-1;    
end
tr100=1:size(tr_100,2);
tr100(tr_bad_100)=[];
figure;scatter(resp_m2(tr100),nanmean(whisk_env_100(9:45,tr100),1))
[r p]=corrcoef(resp_m2(tr100),nanmean(whisk_env_100(9:45,tr100),1))


for i=1:size(tr_1200,2)
    eval(['load cond_1200_trial',int2str(i)])    
    d=reshape(tr(:,:,1:180),205*205,180);
    resp_m2_1200(i)=nanmean(nanmean(d(roi_m2,2:38)))-1;    
end
tr1200=1:size(tr_1200,2);
tr1200(tr_bad_1200)=[];
figure;scatter(resp_m2_1200(tr1200),nanmean(whisk_env_1200(9:45,tr1200),1),'r')
[r p]=corrcoef(resp_m2_1200(tr1200),nanmean(whisk_env_1200(9:45,tr1200),1))



