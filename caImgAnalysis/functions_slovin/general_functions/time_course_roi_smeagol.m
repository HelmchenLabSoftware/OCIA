

load myrois

load cond1n_dt_bl

cond1_2411f_bg_in=mean(mean(cond1n_dt_bl(roi_bg_in,:,:),1),3);
%cond1_2411f_bg_right=mean(mean(cond1n_dt_bl(roi_bg_right,:,:),1),3);
cond1_2411f_bg_left=mean(mean(cond1n_dt_bl(roi_bg_left,:,:),1),3);
cond1_2411f_bg_middle=mean(mean(cond1n_dt_bl(roi_bg_middle,:,:),1),3);

cond1_2411f_circle=mean(mean(cond1n_dt_bl(roi_circle,:,:),1),3);
cond1_2411f_circ_right=mean(mean(cond1n_dt_bl(roi_circ_right,:,:),1),3);
cond1_2411f_circ_left=mean(mean(cond1n_dt_bl(roi_circ_left,:,:),1),3);
cond1_2411f_circ_middle=mean(mean(cond1n_dt_bl(roi_circ_middle,:,:),1),3);

clear cond1n_dt_bl


load cond2n_dt_bl

cond2_2411f_bg_in=mean(mean(cond2n_dt_bl(roi_bg_in,:,:),1),3);
%cond2_2411f_bg_right=mean(mean(cond2n_dt_bl(roi_bg_right,:,:),1),3);
cond2_2411f_bg_left=mean(mean(cond2n_dt_bl(roi_bg_left,:,:),1),3);
cond2_2411f_bg_middle=mean(mean(cond2n_dt_bl(roi_bg_middle,:,:),1),3);

cond2_2411f_circle=mean(mean(cond2n_dt_bl(roi_circle,:,:),1),3);
cond2_2411f_circ_right=mean(mean(cond2n_dt_bl(roi_circ_right,:,:),1),3);
cond2_2411f_circ_left=mean(mean(cond2n_dt_bl(roi_circ_left,:,:),1),3);
cond2_2411f_circ_middle=mean(mean(cond2n_dt_bl(roi_circ_middle,:,:),1),3);

clear cond2n_dt_bl


load cond4n_dt_bl

cond4_2411f_bg_in=mean(mean(cond4n_dt_bl(roi_bg_in,:,:),1),3);
%cond4_2411f_bg_right=mean(mean(cond4n_dt_bl(roi_bg_right,:,:),1),3);
cond4_2411f_bg_left=mean(mean(cond4n_dt_bl(roi_bg_left,:,:),1),3);
cond4_2411f_bg_middle=mean(mean(cond4n_dt_bl(roi_bg_middle,:,:),1),3);

cond4_2411f_circle=mean(mean(cond4n_dt_bl(roi_circle,:,:),1),3);
cond4_2411f_circ_right=mean(mean(cond4n_dt_bl(roi_circ_right,:,:),1),3);
cond4_2411f_circ_left=mean(mean(cond4n_dt_bl(roi_circ_left,:,:),1),3);
cond4_2411f_circ_middle=mean(mean(cond4n_dt_bl(roi_circ_middle,:,:),1),3);

clear cond4n_dt_bl



load cond5n_dt_bl

cond5_2411f_bg_in=mean(mean(cond5n_dt_bl(roi_bg_in,:,:),1),3);
%cond5_2411f_bg_right=mean(mean(cond5n_dt_bl(roi_bg_right,:,:),1),3);
cond5_2411f_bg_left=mean(mean(cond5n_dt_bl(roi_bg_left,:,:),1),3);
cond5_2411f_bg_middle=mean(mean(cond5n_dt_bl(roi_bg_middle,:,:),1),3);

cond5_2411f_circle=mean(mean(cond5n_dt_bl(roi_circle,:,:),1),3);
cond5_2411f_circ_right=mean(mean(cond5n_dt_bl(roi_circ_right,:,:),1),3);
cond5_2411f_circ_left=mean(mean(cond5n_dt_bl(roi_circ_left,:,:),1),3);
cond5_2411f_circ_middle=mean(mean(cond5n_dt_bl(roi_circ_middle,:,:),1),3);

clear cond5n_dt_bl


















