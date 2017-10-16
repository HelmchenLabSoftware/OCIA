



load('cond1n_dt_bl_no_eyemove.mat')
load('cond2n_dt_bl_no_eyemove.mat')
load('cond4n_dt_bl_no_eyemove.mat')
load('cond5n_dt_bl_no_eyemove.mat')
load('myrois3.mat')
time=50:63;
n1=(nanmean(nanmean(cond1n_dt_bl(roi_top_clean,time,:),1),2)+nanmean(nanmean(cond1n_dt_bl(roi_bottom_clean,time,:),1),2)+nanmean(nanmean(cond1n_dt_bl(roi_bg_clean,time,:),1),2))/3-1;
n2=(nanmean(nanmean(cond2n_dt_bl(roi_top_clean,time,:),1),2)+nanmean(nanmean(cond2n_dt_bl(roi_bottom_clean,time,:),1),2)+nanmean(nanmean(cond2n_dt_bl(roi_bg_clean,time,:),1),2))/3-1;
n4=(nanmean(nanmean(cond4n_dt_bl(roi_top_clean,time,:),1),2)+nanmean(nanmean(cond4n_dt_bl(roi_bottom_clean,time,:),1),2)+nanmean(nanmean(cond4n_dt_bl(roi_bg_clean,time,:),1),2))/3-1;
n5=(nanmean(nanmean(cond5n_dt_bl(roi_top_clean,time,:),1),2)+nanmean(nanmean(cond5n_dt_bl(roi_bottom_clean,time,:),1),2)+nanmean(nanmean(cond5n_dt_bl(roi_bg_clean,time,:),1),2))/3-1;

cond1n_dt_bl=(cond1n_dt_bl-1)./repmat(n1,[10000 256 1]) + 1;
cond2n_dt_bl=(cond2n_dt_bl-1)./repmat(n2,[10000 256 1]) + 1;
cond4n_dt_bl=(cond4n_dt_bl-1)./repmat(n4,[10000 256 1]) + 1;
cond5n_dt_bl=(cond5n_dt_bl-1)./repmat(n5,[10000 256 1]) + 1;

save cond1n_dt_bl_no_eyemove_norm cond1n_dt_bl
save cond2n_dt_bl_no_eyemove_norm cond2n_dt_bl
save cond4n_dt_bl_no_eyemove_norm cond4n_dt_bl
save cond5n_dt_bl_no_eyemove_norm cond5n_dt_bl







