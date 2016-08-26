
%% 2912



%c
c1_2912c_bgn_bgn=squeeze(mean(a(roi_bg_out_narrow,:,:),1));
c2_2912c_bgn_bgn=squeeze(mean(b(roi_bg_out_narrow,:,:),1));
c4_2912c_bgn_bgn=squeeze(mean(c(roi_bg_out_narrow,:,:),1));
c5_2912c_bgn_bgn=squeeze(mean(d(roi_bg_out_narrow,:,:),1));



%e
c1_2912e_bgn_bgn=squeeze(mean(a(roi_bg_out_narrow,:,:),1));
c2_2912e_bgn_bgn=squeeze(mean(b(roi_bg_out_narrow,:,:),1));
c4_2912e_bgn_bgn=squeeze(mean(c(roi_bg_out_narrow,:,:),1));
c5_2912e_bgn_bgn=squeeze(mean(d(roi_bg_out_narrow,:,:),1));


%k
c1_2912k_bgn_bgn=squeeze(mean(a(roi_bg_out_narrow,:,:),1));
c2_2912k_bgn_bgn=squeeze(mean(b(roi_bg_out_narrow,:,:),1));
c4_2912k_bgn_bgn=squeeze(mean(c(roi_bg_out_narrow,:,:),1));
c5_2912k_bgn_bgn=squeeze(mean(d(roi_bg_out_narrow,:,:),1));


%% 0501

%b
c1_0501b_bgn_bgn=squeeze(mean(a(roi_bg_out_narrow,:,:),1));
c2_0501b_bgn_bgn=squeeze(mean(b(roi_bg_out_narrow,:,:),1));
c4_0501b_bgn_bgn=squeeze(mean(c(roi_bg_out_narrow,:,:),1));
c5_0501b_bgn_bgn=squeeze(mean(d(roi_bg_out_narrow,:,:),1));

%c
c1_0501c_bgn_bgn=squeeze(mean(a(roi_bg_out_narrow,:,:),1));
c5_0501c_bgn_bgn=squeeze(mean(b(roi_bg_out_narrow,:,:),1));

%d
c1_0501d_bgn_bgn=squeeze(mean(a(roi_bg_out_narrow,:,:),1));
c5_0501d_bgn_bgn=squeeze(mean(b(roi_bg_out_narrow,:,:),1));



%%

cont_bgn_bgn(:,1)=mean(c1_1711b_ccbg_bg,2);
cont_bgn_bgn(:,2)=mean(c2_1711b_ccbg_bg,2);
cont_bgn_bgn(:,3)=mean(c1_1711c_ccbg_bg,2);
cont_bgn_bgn(:,4)=mean(c2_1711c_ccbg_bg,2);
cont_bgn_bgn(:,5)=mean(c1_1711g_ccbg_bg,2);
cont_bgn_bgn(:,6)=mean(c2_1711g_ccbg_bg,2);
cont_bgn_bgn(:,7)=mean(c1_2411b_ccbg_bg,2);
cont_bgn_bgn(:,8)=mean(c2_2411b_ccbg_bg,2);
cont_bgn_bgn(:,9)=mean(c1_2411d_ccbg_bg,2);
cont_bgn_bgn(:,10)=mean(c2_2411d_ccbg_bg,2);
cont_bgn_bgn(:,11)=mean(c1_2411f_ccbg_bg,2);
cont_bgn_bgn(:,12)=mean(c2_2411f_ccbg_bg,2);
cont_bgn_bgn(:,13)=mean(c1_1412b_ccbg_bg,2);
cont_bgn_bgn(:,14)=mean(c2_1412b_ccbg_bg,2);
cont_bgn_bgn(:,15)=mean(c1_1412c_ccbg_bg,2);
cont_bgn_bgn(:,16)=mean(c1_1412d_ccbg_bg,2);
cont_bgn_bgn(:,17)=mean(c1_1412e_ccbg_bg,2);
cont_bgn_bgn(:,18)=mean(c1_2212b_ccbg_bg,2);
cont_bgn_bgn(:,19)=mean(c2_2212b_ccbg_bg,2);
cont_bgn_bgn(:,20)=mean(c1_2212c_ccbg_bg,2);
cont_bgn_bgn(:,21)=mean(c1_2212d_ccbg_bg,2);
cont_bgn_bgn(:,22)=mean(c1_2912b_ccbg_bg,2);
cont_bgn_bgn(:,23)=mean(c2_2912b_ccbg_bg,2);
cont_bgn_bgn(:,24)=mean(c1_2912c_bgn_bgn,2);
cont_bgn_bgn(:,25)=mean(c2_2912c_bgn_bgn,2);
cont_bgn_bgn(:,26)=mean(c1_2912d_ccbg_bg,2);
cont_bgn_bgn(:,27)=mean(c2_2912d_ccbg_bg,2);
cont_bgn_bgn(:,28)=mean(c1_2912e_bgn_bgn,2);
cont_bgn_bgn(:,29)=mean(c2_2912e_bgn_bgn,2);
cont_bgn_bgn(:,30)=mean(c1_2912k_bgn_bgn,2);
cont_bgn_bgn(:,31)=mean(c2_2912k_bgn_bgn,2);
cont_bgn_bgn(:,32)=mean(c1_0501b_bgn_bgn,2);
cont_bgn_bgn(:,33)=mean(c2_0501b_bgn_bgn,2);
cont_bgn_bgn(:,34)=mean(c1_0501c_bgn_bgn,2);
cont_bgn_bgn(:,35)=mean(c1_0501d_bgn_bgn,2);
cont_bgn_bgn(:,36)=mean(c1_0501e_ccbg_bg,2);
cont_bgn_bgn(:,37)=mean(c2_0501e_ccbg_bg,2);


non_bgn_bgn(:,1)=mean(c4_1711b_ccbg_bg,2);
non_bgn_bgn(:,2)=mean(c5_1711b_ccbg_bg,2);
non_bgn_bgn(:,3)=mean(c4_1711c_ccbg_bg,2);
non_bgn_bgn(:,4)=mean(c5_1711c_ccbg_bg,2);
non_bgn_bgn(:,5)=mean(c4_1711g_ccbg_bg,2);
non_bgn_bgn(:,6)=mean(c5_1711g_ccbg_bg,2);
non_bgn_bgn(:,7)=mean(c4_2411b_ccbg_bg,2);
non_bgn_bgn(:,8)=mean(c5_2411b_ccbg_bg,2);
non_bgn_bgn(:,9)=mean(c4_2411d_ccbg_bg,2);
non_bgn_bgn(:,10)=mean(c5_2411d_ccbg_bg,2);
non_bgn_bgn(:,11)=mean(c4_2411f_ccbg_bg,2);
non_bgn_bgn(:,12)=mean(c5_2411f_ccbg_bg,2);
non_bgn_bgn(:,13)=mean(c4_1412b_ccbg_bg,2);
non_bgn_bgn(:,14)=mean(c5_1412b_ccbg_bg,2);
non_bgn_bgn(:,15)=mean(c5_1412c_ccbg_bg,2);
non_bgn_bgn(:,16)=mean(c5_1412d_ccbg_bg,2);
non_bgn_bgn(:,17)=mean(c5_1412e_ccbg_bg,2);
non_bgn_bgn(:,18)=mean(c4_2212b_ccbg_bg,2);
non_bgn_bgn(:,19)=mean(c5_2212b_ccbg_bg,2);
non_bgn_bgn(:,20)=mean(c5_2212c_ccbg_bg,2);
non_bgn_bgn(:,21)=mean(c5_2212d_ccbg_bg,2);
non_bgn_bgn(:,22)=mean(c4_2912b_ccbg_bg,2);
non_bgn_bgn(:,23)=mean(c5_2912b_ccbg_bg,2);
non_bgn_bgn(:,24)=mean(c4_2912c_bgn_bgn,2);
non_bgn_bgn(:,25)=mean(c5_2912c_bgn_bgn,2);
non_bgn_bgn(:,26)=mean(c4_2912d_ccbg_bg,2);
non_bgn_bgn(:,27)=mean(c5_2912d_ccbg_bg,2);
non_bgn_bgn(:,28)=mean(c4_2912e_bgn_bgn,2);
non_bgn_bgn(:,29)=mean(c5_2912e_bgn_bgn,2);
non_bgn_bgn(:,30)=mean(c4_2912k_bgn_bgn,2);
non_bgn_bgn(:,31)=mean(c5_2912k_bgn_bgn,2);
non_bgn_bgn(:,32)=mean(c4_0501b_bgn_bgn,2);
non_bgn_bgn(:,33)=mean(c5_0501b_bgn_bgn,2);
non_bgn_bgn(:,34)=mean(c5_0501c_bgn_bgn,2);
non_bgn_bgn(:,35)=mean(c5_0501d_bgn_bgn,2);
non_bgn_bgn(:,36)=mean(c4_0501e_ccbg_bg,2);
non_bgn_bgn(:,37)=mean(c5_0501e_ccbg_bg,2);


