


circ_cont=zeros(13,1);
circ_non=zeros(13,1);
bgin_cont=zeros(13,1);
bgin_non=zeros(13,1);
bgout_cont=zeros(13,1);
bgout_non=zeros(13,1);
V2_cont=zeros(13,1);
V2_non=zeros(13,1);

circ_cont(13)=mean(mean(mean(cond1n_dt_bl(roi_contour,38:58,:),3),2),1)-1;
bgin_cont(13)=mean(mean(mean(cond1n_dt_bl(roi_bg_in,38:58,:),3),2),1)-1;
bgout_cont(13)=mean(mean(mean(cond1n_dt_bl(roi_bg_out,38:58,:),3),2),1)-1;
V2_cont(13)=mean(mean(mean(cond1n_dt_bl(roi_V2,38:58,:),3),2),1)-1;

circ_non(13)=mean(mean(mean(cond5n_dt_bl(roi_contour,38:58,:),3),2),1)-1;
bgin_non(13)=mean(mean(mean(cond5n_dt_bl(roi_bg_in,38:58,:),3),2),1)-1;
bgout_non(13)=mean(mean(mean(cond5n_dt_bl(roi_bg_out,38:58,:),3),2),1)-1;
V2_non(13)=mean(mean(mean(cond5n_dt_bl(roi_V2,38:58,:),3),2),1)-1;

fr=[circ_cont circ_non bgin_cont bgin_non bgout_cont bgout_non V2_cont V2_non];


mcirc_cont=zeros(13,1);
mcirc_non=zeros(13,1);
mbgin_cont=zeros(13,1);
mbgin_non=zeros(13,1);
mbgout_cont=zeros(13,1);
mbgout_non=zeros(13,1);
mV2_cont=zeros(13,1);
mV2_non=zeros(13,1);

mcirc_cont(1)=mean(mean(minpeak(roi_contour2,:),2),1)-1;
mbgin_cont(1)=mean(mean(minpeak(roi_maskin,:),2),1)-1;
mbgout_cont(1)=mean(mean(minpeak(roi_maskout,:),2),1)-1;
mV2_cont(1)=mean(mean(minpeak(roi_V2,:),2),1)-1;

mcirc_non(1)=mean(mean(minpeak(roi_contour2,:),2),1)-1;
mbgin_non(1)=mean(mean(minpeak(roi_maskin,:),2),1)-1;
mbgout_non(1)=mean(mean(minpeak(roi_maskout,:),2),1)-1;
mV2_non(1)=mean(mean(minpeak(roi_V2,:),2),1)-1;

mfr=[circ_cont circ_non bgin_cont bgin_non bgout_cont bgout_non V2_cont V2_non];


%% normalize grand average

nfr=fr./repmat(fr(:,1),1,8);







