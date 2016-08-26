

%% 1111

%c
c1_1111c_bgn_bgn=squeeze(mean(a(roi_maskin_narrow,:,:),1));
c2_1111c_bgn_bgn=squeeze(mean(b(roi_maskin_narrow,:,:),1));
c4_1111c_bgn_bgn=squeeze(mean(c(roi_maskin_narrow,:,:),1));
c5_1111c_bgn_bgn=squeeze(mean(d(roi_maskin_narrow,:,:),1));

%d 
c1_1111d_bgn_bgn=squeeze(mean(a(roi_maskin_narrow,:,:),1));
c2_1111d_bgn_bgn=squeeze(mean(b(roi_maskin_narrow,:,:),1));
c4_1111d_bgn_bgn=squeeze(mean(c(roi_maskin_narrow,:,:),1));
c5_1111d_bgn_bgn=squeeze(mean(d(roi_maskin_narrow,:,:),1));

%h 
c1_1111h_bgn_bgn=squeeze(mean(a(roi_maskin,:,:),1));
c2_1111h_bgn_bgn=squeeze(mean(b(roi_maskin,:,:),1));
c4_1111h_bgn_bgn=squeeze(mean(c(roi_maskin,:,:),1));
c5_1111h_bgn_bgn=squeeze(mean(d(roi_maskin,:,:),1));

%% 2511

%d
c1_2511d_bgn_bgn=squeeze(mean(a(roi_bg_in_narrow,:,:),1));
c5_2511d_bgn_bgn=squeeze(mean(b(roi_bg_in_narrow,:,:),1));

%e
c1_2511e_bgn_bgn=squeeze(mean(a(roi_bg_in_narrow,:,:),1));
c5_2511e_bgn_bgn=squeeze(mean(b(roi_bg_in_narrow,:,:),1));

%f
c1_2511f_bgn_bgn=squeeze(mean(a(roi_bg_in_narrow,:,:),1));
c5_2511f_bgn_bgn=squeeze(mean(b(roi_bg_in_narrow,:,:),1));


%% 1811

%c
c1_1811c_bgn_bgn=squeeze(mean(a(roi_bg_in_narrow,:,:),1));
c5_1811c_bgn_bgn=squeeze(mean(b(roi_bg_in_narrow,:,:),1));

%d
c1_1811d_bgn_bgn=squeeze(mean(a(roi_bg_in_narrow,:,:),1));
c5_1811d_bgn_bgn=squeeze(mean(b(roi_bg_in_narrow,:,:),1));

%e
c1_1811e_bgn_bgn=squeeze(mean(a(roi_bg_in_narrow,:,:),1));
c5_1811e_bgn_bgn=squeeze(mean(b(roi_bg_in_narrow,:,:),1));


%% 1203

%d
c1_1203d_bgn_bgn=squeeze(mean(a(roi_bg_in_narrow,:,:),1));
c5_1203d_bgn_bgn=squeeze(mean(b(roi_bg_in_narrow,:,:),1));

%e
c1_1203e_bgn_bgn=squeeze(mean(a(roi_bg_in_narrow,:,:),1));
c5_1203e_bgn_bgn=squeeze(mean(b(roi_bg_in_narrow,:,:),1));

%f
c1_1203f_bgn_bgn=squeeze(mean(a(roi_bg_in_narrow,:,:),1));
c5_1203f_bgn_bgn=squeeze(mean(b(roi_bg_in_narrow,:,:),1));



%% 0610

%e
c1_0610e_bgn_bgn=squeeze(mean(a(roi_bg_in_narrow,:,:),1));
c2_0610e_bgn_bgn=squeeze(mean(b(roi_bg_in_narrow,:,:),1));
c4_0610e_bgn_bgn=squeeze(mean(c(roi_bg_in_narrow,:,:),1));
c5_0610e_bgn_bgn=squeeze(mean(d(roi_bg_in_narrow,:,:),1));

%f
c1_0610f_bgn_bgn=squeeze(mean(a(roi_bg_in_narrow,:,:),1));
c2_0610f_bgn_bgn=squeeze(mean(b(roi_bg_in_narrow,:,:),1));
c4_0610f_bgn_bgn=squeeze(mean(c(roi_bg_in_narrow,:,:),1));
c5_0610f_bgn_bgn=squeeze(mean(d(roi_bg_in_narrow,:,:),1));


%% 2210

%d
c1_2210d_bgn_bgn=squeeze(mean(a(roi_bg_in_narrow,:,:),1));
c2_2210d_bgn_bgn=squeeze(mean(b(roi_bg_in_narrow,:,:),1));
c4_2210d_bgn_bgn=squeeze(mean(c(roi_bg_in_narrow,:,:),1));
c5_2210d_bgn_bgn=squeeze(mean(d(roi_bg_in_narrow,:,:),1));

%e
c1_2210e_bgn_bgn=squeeze(mean(a(roi_bg_in_narrow,:,:),1));
c2_2210e_bgn_bgn=squeeze(mean(b(roi_bg_in_narrow,:,:),1));
c4_2210e_bgn_bgn=squeeze(mean(c(roi_bg_in_narrow,:,:),1));
c5_2210e_bgn_bgn=squeeze(mean(d(roi_bg_in_narrow,:,:),1));


%%

cont_bgn_bgn(:,1)=mean(c1_1111c_bgn_bgn,2);
cont_bgn_bgn(:,2)=mean(c2_1111c_bgn_bgn,2);
cont_bgn_bgn(:,3)=mean(c1_1111d_bgn_bgn,2);
cont_bgn_bgn(:,4)=mean(c2_1111d_bgn_bgn,2);
cont_bgn_bgn(:,5)=mean(c1_1811c_bgn_bgn,2);
cont_bgn_bgn(:,6)=mean(c1_1811d_bgn_bgn,2);
cont_bgn_bgn(:,7)=mean(c1_1811e_bgn_bgn,2);
cont_bgn_bgn(:,8)=mean(c1_2511d_bgn_bgn,2);
cont_bgn_bgn(:,9)=mean(c1_2511e_bgn_bgn,2);
cont_bgn_bgn(:,10)=mean(c1_2511f_bgn_bgn,2);
cont_bgn_bgn(:,11)=mean(c1_1203d_bgn_bgn,2);
cont_bgn_bgn(:,12)=mean(c1_1203e_bgn_bgn,2);
cont_bgn_bgn(:,13)=mean(c1_1203f_bgn_bgn,2);
cont_bgn_bgn(:,14)=mean(c1_1111h_bgn_bgn,2);
cont_bgn_bgn(:,15)=mean(c2_1111h_bgn_bgn,2);
cont_bgn_bgn(:,16)=mean(c1_0610e_bgn_bgn,2);
cont_bgn_bgn(:,17)=mean(c2_0610e_bgn_bgn,2);
cont_bgn_bgn(:,18)=mean(c1_0610f_bgn_bgn,2);
cont_bgn_bgn(:,19)=mean(c2_0610f_bgn_bgn,2);
cont_bgn_bgn(:,20)=mean(c1_2210d_bgn_bgn,2);
cont_bgn_bgn(:,21)=mean(c2_2210d_bgn_bgn,2);
cont_bgn_bgn(:,22)=mean(c1_2210e_bgn_bgn,2);
cont_bgn_bgn(:,23)=mean(c2_2210e_bgn_bgn,2);

non_bgn_bgn(:,1)=mean(c4_1111c_bgn_bgn,2);
non_bgn_bgn(:,2)=mean(c5_1111c_bgn_bgn,2);
non_bgn_bgn(:,3)=mean(c4_1111d_bgn_bgn,2);
non_bgn_bgn(:,4)=mean(c5_1111d_bgn_bgn,2);
non_bgn_bgn(:,5)=mean(c5_1811c_bgn_bgn,2);
non_bgn_bgn(:,6)=mean(c5_1811d_bgn_bgn,2);
non_bgn_bgn(:,7)=mean(c5_1811e_bgn_bgn,2);
non_bgn_bgn(:,8)=mean(c5_2511d_bgn_bgn,2);
non_bgn_bgn(:,9)=mean(c5_2511e_bgn_bgn,2);
non_bgn_bgn(:,10)=mean(c5_2511f_bgn_bgn,2);
non_bgn_bgn(:,11)=mean(c5_1203d_bgn_bgn,2);
non_bgn_bgn(:,12)=mean(c5_1203e_bgn_bgn,2);
non_bgn_bgn(:,13)=mean(c5_1203f_bgn_bgn,2);
non_bgn_bgn(:,14)=mean(c4_1111h_bgn_bgn,2);
non_bgn_bgn(:,15)=mean(c5_1111h_bgn_bgn,2);
non_bgn_bgn(:,16)=mean(c4_0610e_bgn_bgn,2);
non_bgn_bgn(:,17)=mean(c5_0610e_bgn_bgn,2);
non_bgn_bgn(:,18)=mean(c4_0610f_bgn_bgn,2);
non_bgn_bgn(:,19)=mean(c5_0610f_bgn_bgn,2);
non_bgn_bgn(:,20)=mean(c4_2210d_bgn_bgn,2);
non_bgn_bgn(:,21)=mean(c5_2210d_bgn_bgn,2);
non_bgn_bgn(:,22)=mean(c4_2210e_bgn_bgn,2);
non_bgn_bgn(:,23)=mean(c5_2210e_bgn_bgn,2);

