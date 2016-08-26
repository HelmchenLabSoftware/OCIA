cd D:\intrinsic\20151027\a\Matt_files
load('trials_ind.mat')
load('first_touch.mat')
load('rois_initial_205x205.mat')
x=(1:180)*0.05-3.05;
pix=256;
fr=200;

for i=1:size(tr_100,2)
    disp(i)
    tr_new=nan*ones(pix,pix,fr);
    load(['cond_100_trial',int2str(i)])
    x_wf(i)=find(abs(x-time_ft(tr_100(i)))==min(abs(x-time_ft(tr_100(i)))));
    if x_wf(i)<=46
        tr_new(:,:,1+(46-x_wf(i)):end)=tr(:,:,1:end-(46-x_wf(i)));
    else
        tr_new(:,:,1:end-(x_wf(i)-46))=tr(:,:,1+(x_wf(i)-46):end);
    end
    tr=tr_new;
    load('norm_frame_100')
    tr=tr.*repmat(fr_dev(:,:,:,i),[1 1 fr]);
    fr_dev2=nanmean(tr(:,:,43:45),3);
    tr=tr./repmat(fr_dev2,[1 1 fr]);
    d=reshape(tr,pix*pix,fr);
    cond_100_s1(:,i)=nanmean(d(roi_s1,:),1);
    cond_100_s2(:,i)=nanmean(d(roi_s2,:),1);
    cond_100_m1(:,i)=nanmean(d(roi_m1,:),1);
    cond_100_m2(:,i)=nanmean(d(roi_m2,:),1);
    cond_100_a1(:,i)=nanmean(d(roi_a1,:),1);
    cond_100_ppc(:,i)=nanmean(d(roi_ppc,:),1);
    eval(['save cond_100_trial',int2str(i),'_ft_norm tr'])
    if i==1
        cond_100_ave=tr;
    else
        cond_100_ave=cond_100_ave+tr;
    end
end
cond_100_ave=cond_100_ave/i;
save cond_100_ave_first_touch_norm cond_100_*


for i=1:size(tr_1200,2)
    disp(i)
    tr_new=nan*ones(pix,pix,fr);
    load(['cond_1200_trial',int2str(i)])
    x_wf(i)=find(abs(x-time_ft(tr_1200(i)))==min(abs(x-time_ft(tr_1200(i)))));
    if x_wf(i)<=46
        tr_new(:,:,1+(46-x_wf(i)):end)=tr(:,:,1:end-(46-x_wf(i)));
    else
        tr_new(:,:,1:end-(x_wf(i)-46))=tr(:,:,1+(x_wf(i)-46):end);
    end
    tr=tr_new;
    load('norm_frame_1200')
    tr=tr.*repmat(fr_dev(:,:,:,i),[1 1 fr]);
    fr_dev2=nanmean(tr(:,:,43:45),3);
    tr=tr./repmat(fr_dev2,[1 1 fr]);
    d=reshape(tr,pix*pix,fr);
    cond_1200_s1(:,i)=nanmean(d(roi_s1,:),1);
    cond_1200_s2(:,i)=nanmean(d(roi_s2,:),1);
    cond_1200_m1(:,i)=nanmean(d(roi_m1,:),1);
    cond_1200_m2(:,i)=nanmean(d(roi_m2,:),1);
    cond_1200_a1(:,i)=nanmean(d(roi_a1,:),1);
    cond_1200_ppc(:,i)=nanmean(d(roi_ppc,:),1);
    eval(['save cond_1200_trial',int2str(i),'_ft_norm tr'])
    if i==1
        cond_1200_ave=tr;
    else
        cond_1200_ave=cond_1200_ave+tr;
    end
end
cond_1200_ave=cond_1200_ave/i;
save cond_1200_ave_first_touch_norm cond_1200_*






    